Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6D6E73E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjDSHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjDSHWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:22:41 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58740F0;
        Wed, 19 Apr 2023 00:22:38 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae81a.dynamic.kabel-deutschland.de [95.90.232.26])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1A23461E4052B;
        Wed, 19 Apr 2023 09:22:37 +0200 (CEST)
Message-ID: <a26a1b41-dd6b-4b01-696e-79e195787958@molgen.mpg.de>
Date:   Wed, 19 Apr 2023 09:22:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3] Bluetooth: btusb: Add WCN6855 devcoredump support
Content-Language: en-US
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com,
        mka@chromium.org
References: <20230419033805.27356-1-quic_tjiang@quicinc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230419033805.27356-1-quic_tjiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Tim,


Than you for the patch.

Am 19.04.23 um 05:38 schrieb Tim Jiang:
> WCN6855 will report memdump via ACL data or HCI event when
> it get crashed, so we collect memdump to debug firmware.

s/when it get crashed/when it crashes/

Please give an example, how to collect the memdump, and maybe even how 
to force a crash.

Please amend the commit message to document the specification/datasheet 
name and revision.

Is WCN6855 the only device supporting this, or could other devices be 
easily added?

> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>   drivers/bluetooth/btusb.c | 222 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 222 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2303b0a66323..f045bbb0ee09 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -733,6 +733,16 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
>   	{}
>   };
>   
> +struct qca_dump_info {
> +	/* fields for dump collection */
> +	u16 id_vendor;
> +	u16 id_product;
> +	u32 fw_version;
> +	u32 controller_id;
> +	u32 ram_dump_size;

I’d add the unit to the variable name.

> +	u16 ram_dump_seqno;
> +};
> +
>   #define BTUSB_MAX_ISOC_FRAMES	10
>   
>   #define BTUSB_INTR_RUNNING	0
> @@ -752,6 +762,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
>   #define BTUSB_WAKEUP_AUTOSUSPEND	14
>   #define BTUSB_USE_ALT3_FOR_WBS	15
>   #define BTUSB_ALT6_CONTINUOUS_TX	16
> +#define BTUSB_HW_SSR_ACTIVE	17
>   
>   struct btusb_data {
>   	struct hci_dev       *hdev;
> @@ -814,6 +825,8 @@ struct btusb_data {
>   
>   	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>   	unsigned cmd_timeout_cnt;
> +
> +	struct qca_dump_info qca_dump;
>   };
>   
>   static void btusb_reset(struct hci_dev *hdev)
> @@ -904,6 +917,11 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
>   	struct btusb_data *data = hci_get_drvdata(hdev);
>   	struct gpio_desc *reset_gpio = data->reset_gpio;
>   
> +	if (test_bit(BTUSB_HW_SSR_ACTIVE, &data->flags)) {
> +		bt_dev_info(hdev, "Ramdump in progress, defer cmd_timeout");
> +		return;
> +	}
> +
>   	if (++data->cmd_timeout_cnt < 5)
>   		return;
>   
> @@ -3294,6 +3312,202 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
>   	return 0;
>   }
>   
> +#define QCA_MEMDUMP_ACL_HANDLE 0x2EDD
> +#define QCA_MEMDUMP_SIZE_MAX  0x100000
> +#define QCA_MEMDUMP_VSE_CLASS 0x01
> +#define QCA_MEMDUMP_MSG_TYPE 0x08
> +#define QCA_MEMDUMP_PKT_SIZE 248
> +#define QCA_LAST_SEQUENCE_NUM 0xffff
> +
> +struct qca_dump_hdr {
> +	u8 vse_class;
> +	u8 msg_type;
> +	__le16 seqno;
> +	u8 reserved;
> +	union {
> +		u8 data[0];
> +		struct {
> +			__le32 ram_dump_size;
> +			u8 data0[0];
> +		} __packed;
> +	};
> +} __packed;
> +
> +
> +static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	char buf[128];
> +	struct btusb_data *btdata = hci_get_drvdata(hdev);
> +
> +	snprintf(buf, sizeof(buf), "Controller Name: 0x%x\n",
> +			btdata->qca_dump.controller_id);
> +	skb_put_data(skb, buf, strlen(buf));
> +
> +	snprintf(buf, sizeof(buf), "Firmware Version: 0x%x\n",
> +			btdata->qca_dump.fw_version);
> +	skb_put_data(skb, buf, strlen(buf));
> +
> +	snprintf(buf, sizeof(buf), "Driver: %s\nVendor: qca\n",
> +			btusb_driver.name);
> +	skb_put_data(skb, buf, strlen(buf));
> +
> +	snprintf(buf, sizeof(buf), "VID: 0x%x\nPID:0x%x\n",
> +			btdata->qca_dump.id_vendor, btdata->qca_dump.id_product);
> +	skb_put_data(skb, buf, strlen(buf));
> +
> +	snprintf(buf, sizeof(buf), "Lmp Subversion: 0x%x\n",
> +			hdev->lmp_subver);
> +	skb_put_data(skb, buf, strlen(buf));
> +}
> +
> +static void btusb_coredump_qca(struct hci_dev *hdev)
> +{
> +	static const u8 param[] = { 0x26 };
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb))
> +		bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func__, PTR_ERR(skb));

What does “triggle” mean?

> +	kfree_skb(skb);
> +}
> +
> +/*
> + * ==0: not a dump pkt.
> + * < 0: fails to handle a dump pkt
> + * > 0: otherwise.
> + */
> +static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	int ret = 1;
> +	u8 pkt_type;
> +	u8 *sk_ptr;
> +	unsigned int sk_len;
> +	u16 seqno;
> +	u32 dump_size;
> +
> +	struct hci_event_hdr *event_hdr;
> +	struct hci_acl_hdr *acl_hdr;
> +	struct qca_dump_hdr *dump_hdr;
> +	struct btusb_data *btdata = hci_get_drvdata(hdev);
> +	struct usb_device *udev = btdata->udev;
> +
> +	pkt_type = hci_skb_pkt_type(skb);
> +	sk_ptr = skb->data;
> +	sk_len = skb->len;
> +
> +	if (pkt_type == HCI_ACLDATA_PKT) {
> +		acl_hdr = hci_acl_hdr(skb);
> +		if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
> +			return 0;
> +		sk_ptr += HCI_ACL_HDR_SIZE;
> +		sk_len -= HCI_ACL_HDR_SIZE;
> +		event_hdr = (struct hci_event_hdr *)sk_ptr;
> +	} else {
> +		event_hdr = hci_event_hdr(skb);
> +	}
> +
> +	if ((event_hdr->evt != HCI_VENDOR_PKT)
> +		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> +		return 0;

Indentation/alignment of the second and third line (it’s the same) looks 
confusing, as it’s not clear, what is the body.

> +
> +	sk_ptr += HCI_EVENT_HDR_SIZE;
> +	sk_len -= HCI_EVENT_HDR_SIZE;
> +
> +	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> +	if ((sk_len < offsetof(struct qca_dump_hdr, data))
> +		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
> +	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))

The coding style is off.

> +		return 0;
> +
> +	/*it is dump pkt now*/

Please add spaces, and elaborate. I do not understant the comment.

> +	seqno = le16_to_cpu(dump_hdr->seqno);
> +	if (seqno == 0) {
> +		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> +		dump_size = le32_to_cpu(dump_hdr->ram_dump_size);
> +		if (!dump_size || (dump_size > QCA_MEMDUMP_SIZE_MAX)) {
> +			ret = -EILSEQ;
> +			bt_dev_err(hdev, "Invalid memdump size(%u)",
> +				   dump_size);
> +			goto out;
> +		}
> +
> +		ret = hci_devcd_init(hdev, dump_size);
> +		if (ret < 0) {
> +			bt_dev_err(hdev, "memdump init error(%d)", ret);

I’d add spaces before the (.

> +			goto out;
> +		}
> +
> +		btdata->qca_dump.ram_dump_size = dump_size;
> +		btdata->qca_dump.ram_dump_seqno = 0;
> +		sk_ptr += offsetof(struct qca_dump_hdr, data0);
> +		sk_len -= offsetof(struct qca_dump_hdr, data0);
> +
> +		usb_disable_autosuspend(udev);
> +		bt_dev_info(hdev, "%s memdump size(%u)\n",
> +			    (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
> +			    dump_size);
> +	} else {
> +		sk_ptr += offsetof(struct qca_dump_hdr, data);
> +		sk_len -= offsetof(struct qca_dump_hdr, data);
> +	}
> +
> +	if (!btdata->qca_dump.ram_dump_size) {
> +		ret = -EINVAL;
> +		bt_dev_err(hdev, "memdump is not active");

What is the heuristics behind that? Setting `ram_dump_size` to zero 
disables the feature? Where is this documented?

> +		goto out;
> +	}
> +
> +	if ((seqno > btdata->qca_dump.ram_dump_seqno + 1) && (seqno != QCA_LAST_SEQUENCE_NUM)) {
> +		dump_size = QCA_MEMDUMP_PKT_SIZE * (seqno - btdata->qca_dump.ram_dump_seqno - 1);
> +		hci_devcd_append_pattern(hdev, 0x0, dump_size);
> +		bt_dev_err(hdev,
> +			   "expected memdump seqno(%u) is not received(%u)\n",

I’d add spaces before the ( – also in other places.


Kind regards,

Paul


> +			   btdata->qca_dump.ram_dump_seqno, seqno);
> +		btdata->qca_dump.ram_dump_seqno = seqno;
> +		kfree_skb(skb);
> +		return ret;
> +	}
> +
> +	skb_pull(skb, skb->len - sk_len);
> +	hci_devcd_append(hdev, skb);
> +	btdata->qca_dump.ram_dump_seqno++;
> +	if (seqno == QCA_LAST_SEQUENCE_NUM) {
> +		bt_dev_info(hdev,
> +				"memdump done: pkts(%u), total(%u)\n",
> +				btdata->qca_dump.ram_dump_seqno, btdata->qca_dump.ram_dump_size);
> +
> +		hci_devcd_complete(hdev);
> +		goto out;
> +	}
> +	return ret;
> +
> +out:
> +	if (btdata->qca_dump.ram_dump_size)
> +		usb_enable_autosuspend(udev);
> +	btdata->qca_dump.ram_dump_size = 0;
> +	btdata->qca_dump.ram_dump_seqno = 0;
> +	clear_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> +
> +	if (ret < 0)
> +		kfree_skb(skb);
> +	return ret;
> +}
> +
> +static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	if (handle_dump_pkt_qca(hdev, skb))
> +		return 0;
> +	return hci_recv_frame(hdev, skb);
> +}
> +
> +static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	if (handle_dump_pkt_qca(hdev, skb))
> +		return 0;
> +	return hci_recv_frame(hdev, skb);
> +}
> +
> +
>   #define QCA_DFU_PACKET_LEN	4096
>   
>   #define QCA_GET_TARGET_VERSION	0x09
> @@ -3628,6 +3842,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>   	if (err < 0)
>   		return err;
>   
> +	btdata->qca_dump.fw_version = le32_to_cpu(ver.patch_version);
> +	btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
> +
>   	if (!(status & QCA_SYSCFG_UPDATED)) {
>   		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
>   		if (err < 0)
> @@ -4117,6 +4334,11 @@ static int btusb_probe(struct usb_interface *intf,
>   	}
>   
>   	if (id->driver_info & BTUSB_QCA_WCN6855) {
> +		data->qca_dump.id_vendor = id->idVendor;
> +		data->qca_dump.id_product = id->idProduct;
> +		data->recv_event = btusb_recv_evt_qca;
> +		data->recv_acl = btusb_recv_acl_qca;
> +		hci_devcd_register(hdev, btusb_coredump_qca, btusb_dump_hdr_qca, NULL);
>   		data->setup_on_usb = btusb_setup_qca;
>   		hdev->shutdown = btusb_shutdown_qca;
>   		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
