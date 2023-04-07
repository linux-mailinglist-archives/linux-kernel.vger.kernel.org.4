Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289866DB040
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjDGQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjDGQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F3D10C1;
        Fri,  7 Apr 2023 09:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AF2A64F13;
        Fri,  7 Apr 2023 16:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3C5C433D2;
        Fri,  7 Apr 2023 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680883792;
        bh=HmNQ9RlHMgSZYT5CKlY9VdPfprafu+PBbMSI+csJyZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ify7NMubEUiq7okkL+7pscbemiPLigKHytqN2bcQVAUHMVhSyOjIpkeA7RqEaeUsr
         k+eqwKqGJWiLDqfw17F9ekmOwzaQvCsBN8x/rKuMLHlzyYxFsxRWlpcNI94fAbWb37
         gCKtKEWvQDKcdRjPJ3kU4KXWxwSqOn/vmMwkCp34cK3ZOJD5xBbK46lhKdsXSYBCFq
         8OhqvEJSjiX7aEbqIQ/9rcJ7st426X9gilbiSUEbTETX9179BcZJSnV9INEXYgOlCN
         vlLgttU9WESV6NKWljwa3yNpVYJpPWkuQPRMHUY/1bcJQZioelhUBxBI76GnhwrEi0
         BBn1gEn1V3M2g==
Date:   Fri, 7 Apr 2023 09:12:42 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hbandi@quicinc.com,
        quic_hemantg@quicinc.com, mka@chromium.org
Subject: Re: [PATCH v1] Bluetooth: btusb: Add WCN6855 devcoredump support
Message-ID: <20230407161242.hydjluny5y6bttmh@ripper>
References: <20230407032936.14799-1-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407032936.14799-1-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 11:29:36AM +0800, Tim Jiang wrote:
> WCN6855 will report memdump via ACL data or HCI event when
> it get crashed, so we collect memdump to debug firmware.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/btusb.c | 221 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 221 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2303b0a66323..ecc346d8b2ea 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -752,6 +752,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
>  #define BTUSB_WAKEUP_AUTOSUSPEND	14
>  #define BTUSB_USE_ALT3_FOR_WBS	15
>  #define BTUSB_ALT6_CONTINUOUS_TX	16
> +#define BTUSB_HW_SSR_ACTIVE	17
>  
>  struct btusb_data {
>  	struct hci_dev       *hdev;
> @@ -904,6 +905,11 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
>  	struct btusb_data *data = hci_get_drvdata(hdev);
>  	struct gpio_desc *reset_gpio = data->reset_gpio;
>  
> +	if (test_bit(BTUSB_HW_SSR_ACTIVE, &data->flags)) {
> +		bt_dev_info(hdev, "Defer cmd_timeout due to dump active");

"Ramdump in progress, defer cmd_timeout"

> +		return;
> +	}
> +
>  	if (++data->cmd_timeout_cnt < 5)
>  		return;
>  
> @@ -3294,6 +3300,213 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
>  	return 0;
>  }
>  
> +#define QCA_MEMDUMP_ACL_HANDLE 0x2EDD
> +#define QCA_MEMDUMP_SIZE_MAX  0x100000
> +#define QCA_MEMDUMP_VSE_CLASS 0x01
> +#define QCA_MEMDUMP_MSG_TYPE 0x08
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
> +struct qca_dump_info {
> +	/* fields for dump collection */
> +	u16 id_vendor;
> +	u16 id_product;
> +	u32 fw_version;
> +	u32 controller_id;
> +	u32 ram_dump_size;
> +	u32 ram_dump_offs;
> +	u16 ram_dump_seqno;
> +};
> +
> +static struct qca_dump_info qca_dump = {0};

Do you really need to keep track of this across the individual packets?

What if I connect two btqca devices to my machine?

> +
> +static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	char buf[128];
> +
> +	snprintf(buf, sizeof(buf), "Controller Name: 0x%x\n",
> +			qca_dump.controller_id);
> +	skb_put_data(skb, buf, strlen(buf));
> +
> +	snprintf(buf, sizeof(buf), "Firmware Version: 0x%x\n",
> +			qca_dump.fw_version);
> +	skb_put_data(skb, buf, strlen(buf));
> +
> +	snprintf(buf, sizeof(buf), "Driver: %s\nVendor: qca\n",
> +			btusb_driver.name);
> +	skb_put_data(skb, buf, strlen(buf));
> +
> +	snprintf(buf, sizeof(buf), "VID: 0x%x\nPID:0x%x\n",
> +			qca_dump.id_vendor, qca_dump.id_product);
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
> +	int ret = 0;
> +	u8 pkt_type;
> +	u8 *sk_ptr;
> +	unsigned int sk_len;
> +	u16 seqno;
> +	u32 ram_dump_size;
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
> +	if (event_hdr->evt != HCI_VENDOR_PKT)
> +		return 0;
> +	if (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE))
> +		return 0;
> +	sk_ptr += HCI_EVENT_HDR_SIZE;
> +	sk_len -= HCI_EVENT_HDR_SIZE;
> +
> +	if (sk_len < offsetof(struct qca_dump_hdr, data))
> +		return 0;
> +	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> +	if ((dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
> +	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> +		return 0;
> +
> +	/*it is dump pkt now*/
> +	ret = 1;

Perhaps you can redesign this so that you don't need to set ret = 1 in
multiple places?

> +	seqno = le16_to_cpu(dump_hdr->seqno);
> +	if (seqno == 0) {
> +		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> +		ram_dump_size = le32_to_cpu(dump_hdr->ram_dump_size);
> +		if (!ram_dump_size || (ram_dump_size > QCA_MEMDUMP_SIZE_MAX)) {
> +			ret = -EILSEQ;
> +			bt_dev_err(hdev, "Invalid memdump size(%u)",
> +				   ram_dump_size);
> +			goto out;
> +		}
> +
> +		ret = hci_devcd_init(hdev, ram_dump_size);
> +		if (ret < 0) {
> +			bt_dev_err(hdev, "memdump init error(%d)", ret);
> +			goto out;
> +		}
> +		ret = 1;
> +
> +		qca_dump.ram_dump_size = ram_dump_size;
> +		qca_dump.ram_dump_offs = 0;
> +		qca_dump.ram_dump_seqno = 0;
> +		sk_ptr += offsetof(struct qca_dump_hdr, data0);
> +		sk_len -= offsetof(struct qca_dump_hdr, data0);
> +
> +		usb_disable_autosuspend(udev);
> +		bt_dev_info(hdev, "%s memdump size(%u)\n",
> +			    (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
> +			    ram_dump_size);
> +	} else {
> +		sk_ptr += offsetof(struct qca_dump_hdr, data);
> +		sk_len -= offsetof(struct qca_dump_hdr, data);
> +	}
> +
> +	if (!qca_dump.ram_dump_size) {
> +		ret = -EINVAL;
> +		bt_dev_err(hdev, "memdump is not active");
> +		goto out;
> +	}
> +
> +	if ((seqno != qca_dump.ram_dump_seqno) && (seqno != 0xFFFF)) {
> +		ret = -EILSEQ;
> +		bt_dev_err(hdev,
> +			   "expected memdump seqno(%u) is not received(%u)\n",
> +			   qca_dump.ram_dump_seqno, seqno);
> +		hci_devcd_abort(hdev);
> +		goto out;
> +	}
> +
> +	skb_pull(skb, skb->len - sk_len);
> +	hci_devcd_append(hdev, skb);
> +	qca_dump.ram_dump_offs += sk_len;
> +	qca_dump.ram_dump_seqno++;
> +	if (seqno != 0xFFFF)
> +		return ret;

It wasn't immediately clear to me that this means "return OK, but we're
waiting for more data".

How about turning this the other way around?

if (all_data_received) {
	bt_dev_info("memdump done");
	hci_devcd_complete();
	...
}

...

> +	hci_devcd_complete(hdev);
> +
> +out:
> +	if (qca_dump.ram_dump_size) {

So if I get seqno == 0, followed by seqno == 2 we will print memdump
Done and return -EILSEQ?

Regards,
Bjorn

> +		usb_enable_autosuspend(udev);
> +		bt_dev_info(hdev,
> +				"memdump Done: pkts(%u), dumped(%u)/total(%u)\n",
> +				qca_dump.ram_dump_seqno, qca_dump.ram_dump_offs,
> +				qca_dump.ram_dump_size);
> +	}
> +	qca_dump.ram_dump_size = 0;
> +	qca_dump.ram_dump_offs = 0;
> +	qca_dump.ram_dump_seqno = 0;
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
>  #define QCA_DFU_PACKET_LEN	4096
>  
>  #define QCA_GET_TARGET_VERSION	0x09
> @@ -3628,6 +3841,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>  	if (err < 0)
>  		return err;
>  
> +	qca_dump.fw_version = le32_to_cpu(ver.patch_version);
> +	qca_dump.controller_id = le32_to_cpu(ver.rom_version);
> +
>  	if (!(status & QCA_SYSCFG_UPDATED)) {
>  		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
>  		if (err < 0)
> @@ -4117,6 +4333,11 @@ static int btusb_probe(struct usb_interface *intf,
>  	}
>  
>  	if (id->driver_info & BTUSB_QCA_WCN6855) {
> +		qca_dump.id_vendor = id->idVendor;
> +		qca_dump.id_product = id->idProduct;
> +		data->recv_event = btusb_recv_evt_qca;
> +		data->recv_acl = btusb_recv_acl_qca;
> +		hci_devcd_register(hdev, btusb_coredump_qca, btusb_dump_hdr_qca, NULL);
>  		data->setup_on_usb = btusb_setup_qca;
>  		hdev->shutdown = btusb_shutdown_qca;
>  		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
> -- 
> 2.17.1
> 
