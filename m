Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB985699348
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjBPLiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBPLiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:38:06 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467A1A4B3;
        Thu, 16 Feb 2023 03:37:52 -0800 (PST)
Received: from [141.14.13.65] (g320.RadioFreeInternet.molgen.mpg.de [141.14.13.65])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B8E7060027FD7;
        Thu, 16 Feb 2023 12:37:43 +0100 (CET)
Message-ID: <44ac5699-c42f-bb22-b92d-c0d0a54cced4@molgen.mpg.de>
Date:   Thu, 16 Feb 2023 12:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 SoC QCA2066
Content-Language: en-US
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_hbandi@quicinc.com, quic_hemantg@quicinc.com, mka@chromium.org
References: <20230216092236.26720-1-quic_tjiang@quicinc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230216092236.26720-1-quic_tjiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Tim,


Thank you for the patch.

Am 16.02.23 um 10:22 schrieb Tim Jiang:
> This patch adds support for QCA2066 firmware patch and nvm downloading.

(Nit: Imperative mood with *Add support …* would make it shorter, and is 
recommended.)

Please elaborate a little. Please mention the datasheet name and 
revision, and how it was tested.

> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>   drivers/bluetooth/btqca.c   | 78 +++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btqca.h   |  2 +
>   drivers/bluetooth/hci_qca.c |  6 +++
>   3 files changed, 86 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c9064d34d830..e1127532c5a8 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -205,6 +205,50 @@ static int qca_send_reset(struct hci_dev *hdev)
>   	return 0;
>   }
>   
> +static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
> +{
> +	u8 cmd;
> +	struct sk_buff *skb;
> +	struct edl_event_hdr *edl;
> +	int err = 0;
> +	int bid_len;
> +
> +	bt_dev_dbg(hdev, "QCA read board ID");
> +
> +	cmd = EDL_GET_BID_REQ_CMD;
> +	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
> +				&cmd, 0, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Reading QCA board ID failed (%d)",
> +			   err);

Should fit in one line?

> +		return err;
> +	}
> +
> +	edl = skb_pull_data(skb, sizeof(*edl));
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA read board ID with no header");

Please phrase these errors more user understandable. Maybe even with a 
suggestion, how to fix it.

> +		err = -EILSEQ;
> +		goto out;
> +	}
> +
> +	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
> +	    edl->rtype != EDL_GET_BID_REQ_CMD) {
> +		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
> +			   edl->rtype);

Same.

> +		err = -EIO;
> +		goto out;
> +	}
> +
> +	bid_len = edl->data[0];
> +	*bid = (edl->data[1] << 8) + edl->data[2];
> +	bt_dev_info(hdev, "%s: bid len = %x, bid = %x", __func__, bid_len, *bid);
> +
> +out:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
>   int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>   {
>   	struct sk_buff *skb;
> @@ -574,6 +618,31 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>   }
>   EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>   
> +static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
> +		   size_t max_size, struct qca_btsoc_version ver, u16 bid)
> +{
> +	u8 rom_ver = 0;
> +	u32 soc_ver;
> +	const char *variant;
> +
> +	soc_ver = get_soc_ver(ver.soc_id, ver.rom_ver);
> +	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> +
> +	if ((ver.soc_id & 0x0000ff00) == 0x1200) /*hsp gf chip*/

Missing spaces in the comment. Can macros/enums be used?

> +		variant = "g";
> +	else
> +		variant = "";
> +
> +	if (bid == 0x0) {
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
> +	} else {
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x",
> +			rom_ver, variant, bid);
> +	}

The coding style requires no spaces for oneline bodies.

> +
> +	bt_dev_info(hdev, "%s: nvm name is %s", __func__, fwname);
> +}
> +
>   int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>   		   const char *firmware_name)
> @@ -582,6 +651,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	int err;
>   	u8 rom_ver = 0;
>   	u32 soc_ver;
> +	u16 bid = 0;

Use boardid as name?

>   
>   	bt_dev_dbg(hdev, "QCA setup on UART");
>   
> @@ -607,6 +677,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	} else if (soc_type == QCA_QCA6390) {
>   		snprintf(config.fwname, sizeof(config.fwname),
>   			 "qca/htbtfw%02x.tlv", rom_ver);
> +	} else if (soc_type == QCA_QCA2066) {
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/hpbtfw%02x.tlv", rom_ver);
>   	} else if (soc_type == QCA_WCN6750) {
>   		/* Choose mbn file by default.If mbn file is not found

Missing space after dot/period.

>   		 * then choose tlv file
> @@ -628,6 +701,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	/* Give the controller some time to get ready to receive the NVM */
>   	msleep(10);
>   
> +	if (soc_type == QCA_QCA2066)
> +		qca_read_fw_board_id(hdev, &bid);
> +
>   	/* Download NVM configuration */
>   	config.type = TLV_TYPE_NVM;
>   	if (firmware_name)
> @@ -645,6 +721,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	else if (soc_type == QCA_QCA6390)
>   		snprintf(config.fwname, sizeof(config.fwname),
>   			 "qca/htnv%02x.bin", rom_ver);
> +	else if (soc_type == QCA_QCA2066)
> +		qca_generate_nvm_name(hdev, config.fwname, sizeof(config.fwname), ver, bid);

Sort the branches lexicographically?

>   	else if (soc_type == QCA_WCN6750)
>   		snprintf(config.fwname, sizeof(config.fwname),
>   			 "qca/msnv%02x.bin", rom_ver);
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 61e9a50e66ae..e762c403284a 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -13,6 +13,7 @@
>   #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
>   #define EDL_GET_BUILD_INFO_CMD		(0x20)
>   #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
> +#define EDL_GET_BID_REQ_CMD		(0x23)
>   #define EDL_PATCH_CONFIG_CMD		(0x28)
>   #define MAX_SIZE_PER_TLV_SEGMENT	(243)
>   #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
> @@ -147,6 +148,7 @@ enum qca_btsoc_type {
>   	QCA_WCN3991,
>   	QCA_QCA6390,
>   	QCA_WCN6750,
> +	QCA_QCA2066,

Sort it?

>   };
>   
>   #if IS_ENABLED(CONFIG_BT_QCA)
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 3df8c3606e93..84769089ddff 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1866,6 +1866,11 @@ static const struct qca_device_data qca_soc_data_qca6390 = {
>   	.num_vregs = 0,
>   };
>   
> +static const struct qca_device_data qca_soc_data_qca2066 = {
> +	.soc_type = QCA_QCA2066,
> +	.num_vregs = 0,
> +};
> +
>   static const struct qca_device_data qca_soc_data_wcn6750 = {
>   	.soc_type = QCA_WCN6750,
>   	.vregs = (struct qca_vreg []) {
> @@ -2335,6 +2340,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>   	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
>   	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
>   	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
> +	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

Sort it?

>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);


Kind regards,

Paul
