Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E5069B7FE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 05:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBREPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 23:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBREPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 23:15:51 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A266076
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 20:15:47 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id r31so87941oiw.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 20:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNH8dxi7/o7bNwZMGaKuox7+HCrpkJuP+/JorjvFWLo=;
        b=IluZMMWZpDfI3KZNTq7NX6ENPsNYspqRJ+QMNfWJww7S62lDEHjwPsaYQ7edeaFfTL
         eKwaWecIckrz6VXr4GmXbg1bIwD8NytpXoLurAUlDF77axtKM9h/UdPtp6jjRnycMPD1
         BRme97DqV7pqyW4bsutfgi7Kl/Zg3jDC0ZpRDgbqtiMybXzVyL5GwVc27RVeZsIuxh+n
         +SvEmgswi5Lw2xEDHJA/IpEciWIR3Qw3rbRtRlWTBs+rl73nx5o1zBYndgFe/4SPP/JL
         sdSlxB3cjIarQiXiMaM/q0Fz4WOazyLEDukeopdHRllZPBDvaNsCP15c+eGewaJ7jy4A
         DhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNH8dxi7/o7bNwZMGaKuox7+HCrpkJuP+/JorjvFWLo=;
        b=nN4yRBkqCKqzuKQ6EA8z5pfsL0uzTEQzSW567XoGs/5KTTUZ0EyQvkB8R3mZzbN+25
         h8O6F9xzeHlBtMD2kL55ToYJtCCWb60uqqa+28ub3kdmNgRaYpG+CpEgSs3XmEsy48Qe
         5vhEDpb7KubIqk6KKB+eMVFu/EhGE4hohDmUlCBg8JW2YZ9qJBP+lPeNd29SWn5PTrVN
         Qm4/nps4oHdTOJ+leQCWEBRSg/S82KzEFu89qrqzdAyqId9Qae78I73Plg7W8tLrYCvi
         kio8kKeY40SK6C9/nwJSTFHAc1RDDIxgl5F4N6JJ6fR/2pDZLlg7IqvpPpaZZ15tq56S
         F8mQ==
X-Gm-Message-State: AO0yUKVIrmR5uDHEEgMqGlSTc/Geg6DugItmvS6wiGk5GRgfJju4b3ve
        VrJPSN3hrtEohrEXcONn1hlWXw==
X-Google-Smtp-Source: AK7set/9aOc8cI7Yxx3u2J6zHD5XMNW3wACdmDXWVNrDKuB1ZzIp3CLyyeJjPkfOxQsATpLHOkiWtg==
X-Received: by 2002:a05:6808:b3b:b0:35c:29b0:e6ea with SMTP id t27-20020a0568080b3b00b0035c29b0e6eamr1392506oij.30.1676693747092;
        Fri, 17 Feb 2023 20:15:47 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b0037d8148cf04sm2582522oib.46.2023.02.17.20.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 20:15:46 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     quic_tjiang@quicinc.com
Cc:     johan.hedberg@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, mka@chromium.org, quic_bgodavar@quicinc.com,
        quic_hbandi@quicinc.com, quic_hemantg@quicinc.com
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
Date:   Fri, 17 Feb 2023 22:15:45 -0600
Message-Id: <20230218041545.3801-1-steev@kali.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216092236.26720-1-quic_tjiang@quicinc.com>
References: <20230216092236.26720-1-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This patch adds support for QCA2066 firmware patch and nvm downloading.

>Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
>---
> drivers/bluetooth/btqca.c   | 78 +++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h   |  2 +
> drivers/bluetooth/hci_qca.c |  6 +++
> 3 files changed, 86 insertions(+)

>diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>index c9064d34d830..e1127532c5a8 100644
>--- a/drivers/bluetooth/btqca.c
>+++ b/drivers/bluetooth/btqca.c
>@@ -205,6 +205,50 @@ static int qca_send_reset(struct hci_dev *hdev)
> 	return 0;
> }
> 
>+static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
>+{
>+	u8 cmd;
>+	struct sk_buff *skb;
>+	struct edl_event_hdr *edl;
>+	int err = 0;
>+	int bid_len;
>+
>+	bt_dev_dbg(hdev, "QCA read board ID");
>+
>+	cmd = EDL_GET_BID_REQ_CMD;
>+	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
>+				&cmd, 0, HCI_INIT_TIMEOUT);
>+	if (IS_ERR(skb)) {
>+		err = PTR_ERR(skb);
>+		bt_dev_err(hdev, "Reading QCA board ID failed (%d)",
>+			   err);
>+		return err;
>+	}
>+
>+	edl = skb_pull_data(skb, sizeof(*edl));
>+	if (!edl) {
>+		bt_dev_err(hdev, "QCA read board ID with no header");
>+		err = -EILSEQ;
>+		goto out;
>+	}
>+
>+	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
>+	    edl->rtype != EDL_GET_BID_REQ_CMD) {
>+		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
>+			   edl->rtype);
>+		err = -EIO;
>+		goto out;
>+	}
>+
>+	bid_len = edl->data[0];
>+	*bid = (edl->data[1] << 8) + edl->data[2];

Is this actually correct?  I ask because here I have the WCN6855 in the Lenovo
Thinkpad X13s, and when attempting to use this driver, I end up with a 
board id of 08c, and according to the firmware, we should have a board id of
b8c.

>+	bt_dev_info(hdev, "%s: bid len = %x, bid = %x", __func__, bid_len, *bid);

Does this print serve any use for end users? Perhaps it could be combined with
the QCA Read Board ID above, so it is in line with the other prints from the
driver?

>+
>+out:
>+	kfree_skb(skb);
>+	return err;
>+}
>+
> int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
> {
> 	struct sk_buff *skb;
>@@ -574,6 +618,31 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> }
> EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
> 
>+static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
>+		   size_t max_size, struct qca_btsoc_version ver, u16 bid)
>+{
>+	u8 rom_ver = 0;
>+	u32 soc_ver;
>+	const char *variant;
>+
>+	soc_ver = get_soc_ver(ver.soc_id, ver.rom_ver);
>+	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
>+
>+	if ((ver.soc_id & 0x0000ff00) == 0x1200) /*hsp gf chip*/
>+		variant = "g";
>+	else
>+		variant = "";
>+
>+	if (bid == 0x0) {
>+		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
>+	} else {
>+		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x",
>+			rom_ver, variant, bid);
>+	}
>+
>+	bt_dev_info(hdev, "%s: nvm name is %s", __func__, fwname);

Does this print serve any purpose for end users?

>+}
>+
> int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> 		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
> 		   const char *firmware_name)
>@@ -582,6 +651,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> 	int err;
> 	u8 rom_ver = 0;
> 	u32 soc_ver;
>+	u16 bid = 0;
> 
> 	bt_dev_dbg(hdev, "QCA setup on UART");
> 
>@@ -607,6 +677,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> 	} else if (soc_type == QCA_QCA6390) {
> 		snprintf(config.fwname, sizeof(config.fwname),
> 			 "qca/htbtfw%02x.tlv", rom_ver);
>+	} else if (soc_type == QCA_QCA2066) {
>+		snprintf(config.fwname, sizeof(config.fwname),
>+			 "qca/hpbtfw%02x.tlv", rom_ver);
> 	} else if (soc_type == QCA_WCN6750) {
> 		/* Choose mbn file by default.If mbn file is not found
> 		 * then choose tlv file
>@@ -628,6 +701,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> 	/* Give the controller some time to get ready to receive the NVM */
> 	msleep(10);
> 
>+	if (soc_type == QCA_QCA2066)
>+		qca_read_fw_board_id(hdev, &bid);
>+
> 	/* Download NVM configuration */
> 	config.type = TLV_TYPE_NVM;
> 	if (firmware_name)
>@@ -645,6 +721,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> 	else if (soc_type == QCA_QCA6390)
> 		snprintf(config.fwname, sizeof(config.fwname),
> 			 "qca/htnv%02x.bin", rom_ver);
>+	else if (soc_type == QCA_QCA2066)
>+		qca_generate_nvm_name(hdev, config.fwname, sizeof(config.fwname), ver, bid);
> 	else if (soc_type == QCA_WCN6750)
> 		snprintf(config.fwname, sizeof(config.fwname),
> 			 "qca/msnv%02x.bin", rom_ver);
>diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>index 61e9a50e66ae..e762c403284a 100644
>--- a/drivers/bluetooth/btqca.h
>+++ b/drivers/bluetooth/btqca.h
>@@ -13,6 +13,7 @@
> #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
> #define EDL_GET_BUILD_INFO_CMD		(0x20)
> #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
>+#define EDL_GET_BID_REQ_CMD		(0x23)
> #define EDL_PATCH_CONFIG_CMD		(0x28)
> #define MAX_SIZE_PER_TLV_SEGMENT	(243)
> #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
>@@ -147,6 +148,7 @@ enum qca_btsoc_type {
> 	QCA_WCN3991,
> 	QCA_QCA6390,
> 	QCA_WCN6750,
>+	QCA_QCA2066,
> };
> 
> #if IS_ENABLED(CONFIG_BT_QCA)
>diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>index 3df8c3606e93..84769089ddff 100644
>--- a/drivers/bluetooth/hci_qca.c
>+++ b/drivers/bluetooth/hci_qca.c
>@@ -1866,6 +1866,11 @@ static const struct qca_device_data qca_soc_data_qca6390 = {
> 	.num_vregs = 0,
> };
> 
>+static const struct qca_device_data qca_soc_data_qca2066 = {
>+	.soc_type = QCA_QCA2066,
>+	.num_vregs = 0,
>+};
>+
> static const struct qca_device_data qca_soc_data_wcn6750 = {
> 	.soc_type = QCA_WCN6750,
> 	.vregs = (struct qca_vreg []) {
>@@ -2335,6 +2340,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
> 	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
> 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
> 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
>+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},
> 	{ /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);

I'm not sure how to phrase this, and just thinking out loud - if the qca2066 is
the same as the wcn6855, just with an additional antenna, perhaps there should
be some way to indicate it?  In my patchset, I had a print of the name "Setting
up wcn6855" and locally, I combined your patch with mine, although dropping the
above qca2066 hunks in favor of my already written wcn6855 hunks, and then
combined the two in the print so it says "Setting up qca2066/wcn6855" - is there
any way to differentiate between what Qualcomm considers a qca2066 and what is
considered the wcn6855?

Below is dmesg output, and so if we go by the wifi device check, we end up
seeing that we get

chip_id 0x2
chip_family 0xb
board_id 0x8c
soc_id 0x400c0210

[    9.724834] ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board_id 0x8c soc_id 0x400c0210
[    9.724850] ath11k_pci 0006:01:00.0: fw_version 0x110b196e fw_build_timestamp 2022-12-22 12:54 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
[    9.742346] ath11k_pci 0006:01:00.0: failed to fetch board data for bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=140 from ath11k/WCN6855/hw2.1/board-2.bin
[    9.742358] ath11k_pci 0006:01:00.0: failed to fetch board.bin from WCN6855/hw2.1
[    9.742361] ath11k_pci 0006:01:00.0: qmi failed to fetch board file: -2
[    9.742363] ath11k_pci 0006:01:00.0: failed to load board data file: -2

But with your driver (mine too for that matter, but then it's just doing the
same bid bits)...

[    9.081003] Bluetooth: hci0: Frame reassembly failed (-84)
[    9.141992] Bluetooth: hci0: QCA Product ID   :0x00000013
[    9.141999] Bluetooth: hci0: QCA SOC Version  :0x400c0210
[    9.142003] Bluetooth: hci0: QCA ROM Version  :0x00000201
[    9.142007] Bluetooth: hci0: QCA Patch Version:0x000038e6
[    9.170612] Bluetooth: hci0: QCA controller version 0x02100201
[    9.170620] Bluetooth: hci0: QCA Downloading qca/hpbtfw21.tlv


[    9.760537] Bluetooth: hci0: QCA board ID len 2,id = 0 8c
[    9.760547] Bluetooth: hci0: QCA Downloading qca/hpnv21.08c
[    9.760638] bluetooth hci0: Direct firmware load for qca/hpnv21.08c failed with error -2
[    9.760640] Bluetooth: hci0: QCA Failed to request file: qca/hpnv21.08c (-2)
[    9.760643] Bluetooth: hci0: QCA Failed to download NVM (-2)

Is there another way to check the board id or board family?  Because it's not
coming up with the correct one here.

--steev
