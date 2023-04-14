Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85276E2B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDNVDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDNVDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:03:00 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0EF3A84
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:02:58 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fbee98814so118492877b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681506178; x=1684098178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WWEO8uqhNvO00r4ycJ3TpZPsfGpKR1mET0ZYbAOCDc0=;
        b=axfMp/VavoP1HBOdl4SIAT4vj/jc31aY11d6XkGlNTrOSKemwEGV9W+Y3sxjQ18KTN
         YtG8NDbjhQhOv6pFI6vGJ2jbjnoXkSOdiaNkeiDHrlnLBsler6ZdvO6pVxP1Zf+W7Z0o
         E/bv3XSHiDiZW7DZE4PP1j6+cWXcur7Fw22DuiI1T044MVfC80xVe5twThOvJeqg06t1
         94eaFQb0viAwj7kHk5uIKQpSVoxQfKh/m4uNtGayEmR8WXu0CPq4ErKVWoqkMuKzIE8H
         PlYm8RArQkp3WCeT3KAIyQBIpEt8CqNURQ+j/AGxrGGajuuxXIQnC4lie93wvLFCmaId
         AEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681506178; x=1684098178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWEO8uqhNvO00r4ycJ3TpZPsfGpKR1mET0ZYbAOCDc0=;
        b=XyS3oULbNIfVA0vtx24i22jwIOZFlnz09De7tPMNCvAlRxVbq+OYzcdbWgyF8dS6NH
         CmwbUVASkBvMd6PrHxvEnhuStfArga9gMe0RvbJjum51M3ScJuQm+FXjKWNtQIcF+NEZ
         LYcSIBlSdYuosbKbLEKq4vBaq1g8oFKuuYO9gmCjJcRZW2D4G1WXFA8qIoc5aj183ndY
         nP9ahlW4nV+rbXaWp3wRUhhWJGxH1YeJDG4t5gKOpvLV+KLTwPhmHtZwoVigO/QCNiNg
         hgPUUnh9Xcp6vJ0RV4KHiJH7gpicRiMQuY2nT5AepDGNye7hV4jNf+WgveU9RnUEVxA2
         iosw==
X-Gm-Message-State: AAQBX9fH8o1WJAvcM7y7sotKu7uxnO3zTA+r9jiTCUJMMiVKKZCRNLh0
        p0FemSf/Y41YQOdUalZMXSrYVDu+o61wMPBbK54MIg==
X-Google-Smtp-Source: AKy350ZMHVdAq1JrqOVbNRS6R1nIlr3NIBqj7WilDNVMgI5SvlscEJw2cU2UMV3ypG3/gqKBRe+Mzr+tj13TE0jJVOE=
X-Received: by 2002:a81:af62:0:b0:54c:bdc:ef18 with SMTP id
 x34-20020a81af62000000b0054c0bdcef18mr4604162ywj.5.1681506178013; Fri, 14 Apr
 2023 14:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064344.18714-1-quic_tjiang@quicinc.com>
In-Reply-To: <20230413064344.18714-1-quic_tjiang@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 15 Apr 2023 00:02:47 +0300
Message-ID: <CAA8EJpoc4nn+Wr131-o=YQoDeL0t7aj9hC=8NNnJa3SeHwgJ-w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com,
        mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 at 09:44, Tim Jiang <quic_tjiang@quicinc.com> wrote:
>
> WCN6855 will report memdump via ACL data or HCI event when
> it get crashed, so we collect memdump to debug firmware.

Is it applicable only to wcn6855 or to some of earlier chips too?

>
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/btusb.c | 222 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 222 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2303b0a66323..f045bbb0ee09 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -733,6 +733,16 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
>         {}
>  };
>
> +struct qca_dump_info {
> +       /* fields for dump collection */
> +       u16 id_vendor;
> +       u16 id_product;
> +       u32 fw_version;
> +       u32 controller_id;
> +       u32 ram_dump_size;
> +       u16 ram_dump_seqno;
> +};
> +
>  #define BTUSB_MAX_ISOC_FRAMES  10
>
>  #define BTUSB_INTR_RUNNING     0
> @@ -752,6 +762,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
>  #define BTUSB_WAKEUP_AUTOSUSPEND       14
>  #define BTUSB_USE_ALT3_FOR_WBS 15
>  #define BTUSB_ALT6_CONTINUOUS_TX       16
> +#define BTUSB_HW_SSR_ACTIVE    17
>
>  struct btusb_data {
>         struct hci_dev       *hdev;
> @@ -814,6 +825,8 @@ struct btusb_data {
>
>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>         unsigned cmd_timeout_cnt;
> +
> +       struct qca_dump_info qca_dump;
>  };
>
>  static void btusb_reset(struct hci_dev *hdev)
> @@ -904,6 +917,11 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
>         struct btusb_data *data = hci_get_drvdata(hdev);
>         struct gpio_desc *reset_gpio = data->reset_gpio;
>
> +       if (test_bit(BTUSB_HW_SSR_ACTIVE, &data->flags)) {
> +               bt_dev_info(hdev, "Ramdump in progress, defer cmd_timeout");
> +               return;
> +       }
> +
>         if (++data->cmd_timeout_cnt < 5)
>                 return;
>
> @@ -3294,6 +3312,202 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
>         return 0;
>  }
>
> +#define QCA_MEMDUMP_ACL_HANDLE 0x2EDD
> +#define QCA_MEMDUMP_SIZE_MAX  0x100000
> +#define QCA_MEMDUMP_VSE_CLASS 0x01
> +#define QCA_MEMDUMP_MSG_TYPE 0x08
> +#define QCA_MEMDUMP_PKT_SIZE 248
> +#define QCA_LAST_SEQUENCE_NUM 0xffff
> +
> +struct qca_dump_hdr {
> +       u8 vse_class;
> +       u8 msg_type;
> +       __le16 seqno;
> +       u8 reserved;
> +       union {
> +               u8 data[0];
> +               struct {
> +                       __le32 ram_dump_size;
> +                       u8 data0[0];
> +               } __packed;
> +       };
> +} __packed;
> +
> +
> +static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       char buf[128];
> +       struct btusb_data *btdata = hci_get_drvdata(hdev);
> +
> +       snprintf(buf, sizeof(buf), "Controller Name: 0x%x\n",
> +                       btdata->qca_dump.controller_id);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Firmware Version: 0x%x\n",
> +                       btdata->qca_dump.fw_version);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Driver: %s\nVendor: qca\n",
> +                       btusb_driver.name);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "VID: 0x%x\nPID:0x%x\n",
> +                       btdata->qca_dump.id_vendor, btdata->qca_dump.id_product);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Lmp Subversion: 0x%x\n",
> +                       hdev->lmp_subver);
> +       skb_put_data(skb, buf, strlen(buf));
> +}
> +
> +static void btusb_coredump_qca(struct hci_dev *hdev)
> +{
> +       static const u8 param[] = { 0x26 };
> +       struct sk_buff *skb;
> +
> +       skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb))
> +               bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func__, PTR_ERR(skb));
> +       kfree_skb(skb);
> +}
> +
> +/*
> + * ==0: not a dump pkt.
> + * < 0: fails to handle a dump pkt
> + * > 0: otherwise.
> + */
> +static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       int ret = 1;
> +       u8 pkt_type;
> +       u8 *sk_ptr;
> +       unsigned int sk_len;
> +       u16 seqno;
> +       u32 dump_size;
> +
> +       struct hci_event_hdr *event_hdr;
> +       struct hci_acl_hdr *acl_hdr;
> +       struct qca_dump_hdr *dump_hdr;
> +       struct btusb_data *btdata = hci_get_drvdata(hdev);
> +       struct usb_device *udev = btdata->udev;
> +
> +       pkt_type = hci_skb_pkt_type(skb);
> +       sk_ptr = skb->data;
> +       sk_len = skb->len;
> +
> +       if (pkt_type == HCI_ACLDATA_PKT) {
> +               acl_hdr = hci_acl_hdr(skb);
> +               if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
> +                       return 0;
> +               sk_ptr += HCI_ACL_HDR_SIZE;
> +               sk_len -= HCI_ACL_HDR_SIZE;
> +               event_hdr = (struct hci_event_hdr *)sk_ptr;
> +       } else {
> +               event_hdr = hci_event_hdr(skb);
> +       }
> +
> +       if ((event_hdr->evt != HCI_VENDOR_PKT)
> +               || (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
> +               return 0;
> +
> +       sk_ptr += HCI_EVENT_HDR_SIZE;
> +       sk_len -= HCI_EVENT_HDR_SIZE;
> +
> +       dump_hdr = (struct qca_dump_hdr *)sk_ptr;
> +       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> +               || (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
> +           || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
> +               return 0;
> +
> +       /*it is dump pkt now*/
> +       seqno = le16_to_cpu(dump_hdr->seqno);
> +       if (seqno == 0) {
> +               set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> +               dump_size = le32_to_cpu(dump_hdr->ram_dump_size);
> +               if (!dump_size || (dump_size > QCA_MEMDUMP_SIZE_MAX)) {
> +                       ret = -EILSEQ;
> +                       bt_dev_err(hdev, "Invalid memdump size(%u)",
> +                                  dump_size);
> +                       goto out;
> +               }
> +
> +               ret = hci_devcd_init(hdev, dump_size);
> +               if (ret < 0) {
> +                       bt_dev_err(hdev, "memdump init error(%d)", ret);
> +                       goto out;
> +               }
> +
> +               btdata->qca_dump.ram_dump_size = dump_size;
> +               btdata->qca_dump.ram_dump_seqno = 0;
> +               sk_ptr += offsetof(struct qca_dump_hdr, data0);
> +               sk_len -= offsetof(struct qca_dump_hdr, data0);
> +
> +               usb_disable_autosuspend(udev);
> +               bt_dev_info(hdev, "%s memdump size(%u)\n",
> +                           (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
> +                           dump_size);
> +       } else {
> +               sk_ptr += offsetof(struct qca_dump_hdr, data);
> +               sk_len -= offsetof(struct qca_dump_hdr, data);
> +       }
> +
> +       if (!btdata->qca_dump.ram_dump_size) {
> +               ret = -EINVAL;
> +               bt_dev_err(hdev, "memdump is not active");
> +               goto out;
> +       }
> +
> +       if ((seqno > btdata->qca_dump.ram_dump_seqno + 1) && (seqno != QCA_LAST_SEQUENCE_NUM)) {
> +               dump_size = QCA_MEMDUMP_PKT_SIZE * (seqno - btdata->qca_dump.ram_dump_seqno - 1);
> +               hci_devcd_append_pattern(hdev, 0x0, dump_size);
> +               bt_dev_err(hdev,
> +                          "expected memdump seqno(%u) is not received(%u)\n",
> +                          btdata->qca_dump.ram_dump_seqno, seqno);
> +               btdata->qca_dump.ram_dump_seqno = seqno;
> +               kfree_skb(skb);
> +               return ret;
> +       }
> +
> +       skb_pull(skb, skb->len - sk_len);
> +       hci_devcd_append(hdev, skb);
> +       btdata->qca_dump.ram_dump_seqno++;
> +       if (seqno == QCA_LAST_SEQUENCE_NUM) {
> +               bt_dev_info(hdev,
> +                               "memdump done: pkts(%u), total(%u)\n",
> +                               btdata->qca_dump.ram_dump_seqno, btdata->qca_dump.ram_dump_size);
> +
> +               hci_devcd_complete(hdev);
> +               goto out;
> +       }
> +       return ret;
> +
> +out:
> +       if (btdata->qca_dump.ram_dump_size)
> +               usb_enable_autosuspend(udev);
> +       btdata->qca_dump.ram_dump_size = 0;
> +       btdata->qca_dump.ram_dump_seqno = 0;
> +       clear_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> +
> +       if (ret < 0)
> +               kfree_skb(skb);
> +       return ret;
> +}
> +
> +static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       if (handle_dump_pkt_qca(hdev, skb))
> +               return 0;
> +       return hci_recv_frame(hdev, skb);
> +}
> +
> +static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       if (handle_dump_pkt_qca(hdev, skb))
> +               return 0;
> +       return hci_recv_frame(hdev, skb);
> +}
> +
> +
>  #define QCA_DFU_PACKET_LEN     4096
>
>  #define QCA_GET_TARGET_VERSION 0x09
> @@ -3628,6 +3842,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>         if (err < 0)
>                 return err;
>
> +       btdata->qca_dump.fw_version = le32_to_cpu(ver.patch_version);
> +       btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
> +
>         if (!(status & QCA_SYSCFG_UPDATED)) {
>                 err = btusb_setup_qca_load_nvm(hdev, &ver, info);
>                 if (err < 0)
> @@ -4117,6 +4334,11 @@ static int btusb_probe(struct usb_interface *intf,
>         }
>
>         if (id->driver_info & BTUSB_QCA_WCN6855) {
> +               data->qca_dump.id_vendor = id->idVendor;
> +               data->qca_dump.id_product = id->idProduct;
> +               data->recv_event = btusb_recv_evt_qca;
> +               data->recv_acl = btusb_recv_acl_qca;
> +               hci_devcd_register(hdev, btusb_coredump_qca, btusb_dump_hdr_qca, NULL);
>                 data->setup_on_usb = btusb_setup_qca;
>                 hdev->shutdown = btusb_shutdown_qca;
>                 hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
