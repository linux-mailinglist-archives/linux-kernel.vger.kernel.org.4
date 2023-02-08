Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39A468F9A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjBHVSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHVSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:18:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CF9126C5;
        Wed,  8 Feb 2023 13:18:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92036B81F03;
        Wed,  8 Feb 2023 21:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863A3C433D2;
        Wed,  8 Feb 2023 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675891083;
        bh=E9pZ20y6nxjUAdEDmzrCEjQTqE2cOMP7oInfuah3gNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CE8aDZQbQF3wnwpTEwtbXQ/oUXxPw1ZTgo3uZ/TctFhDPZ7cUwgu5C7gd80XyDlHr
         DeWJ5uo2MXo2k8B7AUVq5jPjg7xfJH+o3LBxYqWXQfp7zflEP2na5oW18W2tkPWq7f
         4KFZkIU+gXjQArrZNkMxUwXyJaDQCgc/hsr3q/Bi7lMdhfzYB3g1jgjQidsl3YyuNL
         2hapsERx768w5Z06wxjktdG7AIPkugTW1tcP2pJ3JkMCSMbWev1PpI2XeVygZiR+OK
         U+YrxxSz+xTlU7e7enh015nIDzh/QNjXiHDoHDA4itqOlrxtAxF4A87/R7iDApYVRt
         roEeytSIzrNCA==
Date:   Wed, 8 Feb 2023 13:20:14 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_hbandi@quicinc.com, quic_hemantg@quicinc.com, mka@chromium.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <20230208212014.gz3zxhysas23mxwg@ripper>
References: <20230208094038.13670-1-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208094038.13670-1-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:40:38PM +0800, Tim Jiang wrote:
> This patch adds support for QCA2066, including the devicetree

What do you mean with "devicetree downloading"?

> and patch/nvm downloading.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c   | 85 +++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btqca.h   |  2 +
>  drivers/bluetooth/hci_qca.c |  6 +++
>  3 files changed, 93 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index c9064d34d830..7d00df3a1d61 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -205,6 +205,55 @@ static int qca_send_reset(struct hci_dev *hdev)
>  	return 0;
>  }
>  
> +static int qca_read_fw_board_id(struct hci_dev *hdev, u8 *bid)
> +{
> +	u8 cmd;
> +	struct sk_buff *skb;
> +	struct edl_event_hdr *edl;
> +	int err;
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
> +		return err;
> +	}
> +
> +	edl = (struct edl_event_hdr *)(skb->data);
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA read board ID with no header");
> +		err = -EILSEQ;
> +		goto out;
> +	}
> +
> +	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
> +	    edl->rtype != EDL_GET_BID_REQ_CMD) {
> +		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
> +			   edl->rtype);
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +	bid_len = edl->data[0];
> +	bid[0] = edl->data[1];
> +	bid[1] = edl->data[2];
> +	bt_dev_info(hdev, "QCA board ID len %d,id = %x %x", bid_len, bid[0], bid[1]);
> +
> +

Please clean up the double empty lines..

> +	err = 0;

Why not zero-initialize err from the start?

> +
> +out:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
> +
>  int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>  {
>  	struct sk_buff *skb;
> @@ -574,6 +623,32 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  }
>  EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>  
> +static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
> +		   size_t max_size, struct qca_btsoc_version ver, u8 *bid)
> +{
> +	u8 rom_ver = 0;
> +	u32 soc_ver;
> +	const char *variant;
> +
> +	soc_ver = get_soc_ver(ver.soc_id, ver.rom_ver);
> +	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> +	bt_dev_info(hdev, "bid == 0x%02x 0x%02x", bid[0], bid[1]);

Is this really useful information to put in the log every time the
device comes up?

> +
> +	if ((ver.soc_id & 0x0000ff00) == 0x1200) /*hsp gf chip*/
> +		variant = "g";
> +	else
> +		variant = "";
> +
> +	if (bid[0] == 0 && bid[1] == 0) {
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
> +	} else {
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x%02x",
> +			rom_ver, variant, bid[0], bid[1]);
> +	}
> +	bt_dev_info(hdev, "%s:  %s", __func__, fwname);

Please write proper and useful informational prints in the log.

> +
> +}
> +
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>  		   const char *firmware_name)
> @@ -582,6 +657,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	int err;
>  	u8 rom_ver = 0;
>  	u32 soc_ver;
> +	u8 bid[2] = {0};

Seems that storing this as a u16 would make the patch cleaner.

>  
>  	bt_dev_dbg(hdev, "QCA setup on UART");
>  
> @@ -607,6 +683,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	} else if (soc_type == QCA_QCA6390) {
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/htbtfw%02x.tlv", rom_ver);
> +	} else if (soc_type == QCA_QCA2066) {
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/hpbtfw%02x.tlv", rom_ver);
>  	} else if (soc_type == QCA_WCN6750) {
>  		/* Choose mbn file by default.If mbn file is not found
>  		 * then choose tlv file
> @@ -628,6 +707,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	/* Give the controller some time to get ready to receive the NVM */
>  	msleep(10);
>  
> +	if (soc_type == QCA_QCA2066)
> +		qca_read_fw_board_id(hdev, bid);
> +
> +

Double empty lines...

>  	/* Download NVM configuration */
>  	config.type = TLV_TYPE_NVM;
>  	if (firmware_name)
> @@ -645,6 +728,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	else if (soc_type == QCA_QCA6390)
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/htnv%02x.bin", rom_ver);
> +	else if (soc_type == QCA_QCA2066)
> +		qca_generate_nvm_name(hdev, config.fwname, sizeof(config.fwname), ver, bid);
>  	else if (soc_type == QCA_WCN6750)
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/msnv%02x.bin", rom_ver);
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 61e9a50e66ae..e762c403284a 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -13,6 +13,7 @@
>  #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
>  #define EDL_GET_BUILD_INFO_CMD		(0x20)
>  #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
> +#define EDL_GET_BID_REQ_CMD		(0x23)
>  #define EDL_PATCH_CONFIG_CMD		(0x28)
>  #define MAX_SIZE_PER_TLV_SEGMENT	(243)
>  #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
> @@ -147,6 +148,7 @@ enum qca_btsoc_type {
>  	QCA_WCN3991,
>  	QCA_QCA6390,
>  	QCA_WCN6750,
> +	QCA_QCA2066,
>  };
>  
>  #if IS_ENABLED(CONFIG_BT_QCA)
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 3df9e692756a..596f730ff375 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1859,6 +1859,11 @@ static const struct qca_device_data qca_soc_data_qca6390 = {
>  	.num_vregs = 0,
>  };
>  
> +static const struct qca_device_data qca_soc_data_qca2066 = {
> +	.soc_type = QCA_QCA2066,
> +	.num_vregs = 0,
> +};
> +
>  static const struct qca_device_data qca_soc_data_wcn6750 = {
>  	.soc_type = QCA_WCN6750,
>  	.vregs = (struct qca_vreg []) {
> @@ -2316,6 +2321,7 @@ static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
>  static const struct of_device_id qca_bluetooth_of_match[] = {
>  	{ .compatible = "qcom,qca6174-bt" },
>  	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
> +	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

These entries seems alphabetically sorted, please maintain that.

Regards,
Bjorn

>  	{ .compatible = "qcom,qca9377-bt" },
>  	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
>  	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
> 
