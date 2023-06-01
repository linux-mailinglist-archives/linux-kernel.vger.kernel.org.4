Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC971981E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjFAKCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjFAKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:01:12 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D90E54;
        Thu,  1 Jun 2023 03:00:43 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AE3FA61E4052B;
        Thu,  1 Jun 2023 12:00:35 +0200 (CEST)
Message-ID: <f76f9920-7234-ef72-9e88-87713e3b0f8e@molgen.mpg.de>
Date:   Thu, 1 Jun 2023 12:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 SoC QCA2066
Content-Language: en-US
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com
References: <20230601091355.18097-1-quic_tjiang@quicinc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230601091355.18097-1-quic_tjiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Tim,


Thank you for the interation.

Am 01.06.23 um 11:13 schrieb Tim Jiang:
> This patch adds support for QCA2066 firmware patch and nvm downloading.
> as the RF performance of qca2066 soc chip from different foundries will
> be difference, so we use different nvm to configure them by according

s/difference/different/

> to board id.

chat.lmsys.org with the model vicuna-13b suggested the text below:

> Please correct the spelling/grammar of […]:
> Sure, here's the corrected version of the sentence:
> This patch adds support for QCA2066 firmware patch and NVM
> downloading, as the RF performance of QCA2066 SOC chips from
> different foundries may vary. Therefore, we use different NVM to
> configure them based on board ID.
> I hope that helps!

;-)

> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---

In the future, it’d be great if you added a change-log between the patch 
iterations so reviewers know what to look at.

>   drivers/bluetooth/btqca.c   | 76 ++++++++++++++++++++++++++++++++++++-
>   drivers/bluetooth/btqca.h   |  4 ++
>   drivers/bluetooth/hci_qca.c | 40 +++++++++++++++++--
>   3 files changed, 114 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index e7e58a956d15..1f1b141b80f9 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -205,6 +205,46 @@ static int qca_send_reset(struct hci_dev *hdev)
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

As the length cannot be negative, why not use `unsigned int`? But also 
see below.

> +
> +	cmd = EDL_GET_BID_REQ_CMD;
> +	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
> +				&cmd, 0, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Reading QCA board ID failed (%d)", err);
> +		return err;
> +	}
> +
> +	edl = skb_pull_data(skb, sizeof(*edl));
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA read board ID with no header");
> +		err = -EILSEQ;
> +		goto out;
> +	}
> +
> +	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
> +	    edl->rtype != EDL_GET_BID_REQ_CMD) {
> +		bt_dev_err(hdev, "QCA Wrong packet: %d %d", edl->cresp, edl->rtype);
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +	bid_len = edl->data[0];
> +	*bid = (edl->data[1] << 8) + edl->data[2];
> +	bt_dev_dbg(hdev, "%s: bid len = %x, bid = %x", __func__, bid_len, *bid);

Currently, you use `bid_len` only to log it, and not for anything else. 
Should some sanity checks be added? Otherwise, I think, the variable can 
be removed?

> +
> +out:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
>   int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>   {
>   	struct sk_buff *skb;
> @@ -574,6 +614,29 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>   }
>   EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>   
> +static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
> +		   size_t max_size, struct qca_btsoc_version ver, u16 bid)
> +{
> +	u8 rom_ver;
> +	u32 soc_ver;
> +	const char *variant;
> +
> +	soc_ver = get_soc_ver(ver.soc_id, ver.rom_ver);
> +	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> +
> +	if ((le32_to_cpu(ver.soc_id) & 0x0000ff00) == QCA_HSP_GF_SOC_ID)  /* hsp gf chip */
> +		variant = "g";
> +	else
> +		variant = "";
> +
> +	if (bid == 0x0)
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
> +	else
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
> +
> +	bt_dev_dbg(hdev, "%s: nvm name is %s", __func__, fwname);
> +}
> +
>   int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>   		   const char *firmware_name)
> @@ -582,6 +645,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	int err;
>   	u8 rom_ver = 0;
>   	u32 soc_ver;
> +	u16 boardid = 0;

Sorry, I didn’t get to reply to your v3 answer:

> Why can’t you simply use `unsigned int` [1]?
> [Tim] you can refer to function qca_uart_setup , which also use u32

I meant `boardid`, which is newly introduced.


Kind regards,

Paul


>   
>   	bt_dev_dbg(hdev, "QCA setup on UART");
>   
> @@ -604,6 +668,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	if (qca_is_wcn399x(soc_type)) {
>   		snprintf(config.fwname, sizeof(config.fwname),
>   			 "qca/crbtfw%02x.tlv", rom_ver);
> +	} else if (soc_type == QCA_QCA2066) {
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/hpbtfw%02x.tlv", rom_ver);
>   	} else if (soc_type == QCA_QCA6390) {
>   		snprintf(config.fwname, sizeof(config.fwname),
>   			 "qca/htbtfw%02x.tlv", rom_ver);
> @@ -631,6 +698,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	/* Give the controller some time to get ready to receive the NVM */
>   	msleep(10);
>   
> +	if (soc_type == QCA_QCA2066)
> +		qca_read_fw_board_id(hdev, &boardid);
> +
>   	/* Download NVM configuration */
>   	config.type = TLV_TYPE_NVM;
>   	if (firmware_name)
> @@ -644,8 +714,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   			snprintf(config.fwname, sizeof(config.fwname),
>   				 "qca/crnv%02x.bin", rom_ver);
>   		}
> -	}
> -	else if (soc_type == QCA_QCA6390)
> +	} else if (soc_type == QCA_QCA2066) {
> +		qca_generate_nvm_name(hdev, config.fwname, sizeof(config.fwname),
> +				ver, boardid);
> +	} else if (soc_type == QCA_QCA6390)
>   		snprintf(config.fwname, sizeof(config.fwname),
>   			 "qca/htnv%02x.bin", rom_ver);
>   	else if (soc_type == QCA_WCN6750)
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index b884095bcd9d..234a97a49bb9 100644
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
> @@ -48,6 +49,8 @@
>   
>   #define QCA_FW_BUILD_VER_LEN		255
>   
> +#define QCA_HSP_GF_SOC_ID		0x1200
> +
>   
>   enum qca_baudrate {
>   	QCA_BAUDRATE_115200 	= 0,
> @@ -148,6 +151,7 @@ enum qca_btsoc_type {
>   	QCA_QCA6390,
>   	QCA_WCN6750,
>   	QCA_WCN6855,
> +	QCA_QCA2066,
>   };
>   
>   #if IS_ENABLED(CONFIG_BT_QCA)
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 1b064504b388..3c65b6b80461 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1712,6 +1712,7 @@ static int qca_setup(struct hci_uart *hu)
>   	const char *firmware_name = qca_get_firmware_name(hu);
>   	int ret;
>   	struct qca_btsoc_version ver;
> +	const char *soc_name;
>   
>   	ret = qca_check_speeds(hu);
>   	if (ret)
> @@ -1726,10 +1727,35 @@ static int qca_setup(struct hci_uart *hu)
>   	 */
>   	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>   
> -	bt_dev_info(hdev, "setting up %s",
> -		qca_is_wcn399x(soc_type) ? "wcn399x" :
> -		(soc_type == QCA_WCN6750) ? "wcn6750" :
> -		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
> +	switch (soc_type) {
> +	case QCA_AR3002:
> +		soc_name = "ar300x";
> +		break;
> +	case QCA_ROME:
> +		soc_name = "ROME";
> +		break;
> +	case QCA_WCN3990:
> +	case QCA_WCN3991:
> +	case QCA_WCN3998:
> +		soc_name = "wcn399x";
> +		break;
> +	case QCA_QCA2066:
> +		soc_name = "QCA2066";
> +		break;
> +	case QCA_QCA6390:
> +		soc_name = "QCA6390";
> +		break;
> +	case QCA_WCN6750:
> +		soc_name = "wcn6750";
> +		break;
> +	case QCA_WCN6855:
> +		soc_name = "wcn6855";
> +		break;
> +	default:
> +		soc_name = "unknown soc";
> +		break;
> +	}
> +	bt_dev_info(hdev, "setting up %s", soc_name);
>   
>   	qca->memdump_state = QCA_MEMDUMP_IDLE;
>   
> @@ -1874,6 +1900,11 @@ static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
>   	.num_vregs = 0,
>   };
>   
> +static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
> +	.soc_type = QCA_QCA2066,
> +	.num_vregs = 0,
> +};
> +
>   static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
>   	.soc_type = QCA_WCN6750,
>   	.vregs = (struct qca_vreg []) {
> @@ -2371,6 +2402,7 @@ MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
>   
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
> +	{ "QCOM2066", (kernel_ulong_t)&qca_soc_data_qca2066 },
>   	{ "QCOM6390", (kernel_ulong_t)&qca_soc_data_qca6390 },
>   	{ "DLA16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
>   	{ "DLB16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
