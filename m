Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786A26E2B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDNU6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNU6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:58:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2742B4692;
        Fri, 14 Apr 2023 13:58:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec8143400aso53979e87.0;
        Fri, 14 Apr 2023 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681505883; x=1684097883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjSdTi6A4OFAAi/vDcIHMF+dEX4VsEtl0S5XW4neYsg=;
        b=jyyFfnoTF5PIE3hP7JLKC1WWjFeTe66Wt2Z5464ssl1Q+xERqv9iVTrFflYKRHwzNV
         33qNSB8QF0QDeURbZTmN9NWNpaDCeLXmrorrTrYjzuuBzbJjkwLZFP6gk4Xsts8NMLAz
         4j19v43A9lCsgvG67WoHbW4ARbgw/hDdufdDPjUGg6i7Roe7DuMIbCPEvlbEPdJYjqgD
         1ANFbmz92KoV9mgnSIIZIWQKgCwZa5yHbNpiOjlB4opxOJyrgloatTgT5Qsp9HaRdNrN
         mKhqvv6wKlMHwWDW3k8KRnY9Yu+/irVGVdRIpuaJxafBvunHjpqlr0FR3Mxet52eEyeX
         uUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681505883; x=1684097883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjSdTi6A4OFAAi/vDcIHMF+dEX4VsEtl0S5XW4neYsg=;
        b=OBcPDZQPm22auXLmkO2lrmk/eKUSxcIjYnNIPq8rLLLFR+vncT9rIt0Ga5KiqALUMr
         EW80uBoSMs+CIsswwnnGPTcM1+QyPnoAAW3fIw0YABNkk9uCp3/GNUJY0CJ8IwMXKb0D
         LRxLrsJJjH5p0uUWg6B0G1HsiirFxkH0zRyuNyYBxU5l38l2pKOdGJpLPSsmQh1D2wDV
         te2iBZAj2tr4XbQ2t+NbWThr9BfyT1ohY2hpIB+CM8temES6NjidAq/oAi+dguevp3B9
         fsaMX4HWsljFtihqKLkPxQNziyQdbVCpT79cteXzUwR8Wnumq86JLTIUr+cPbnRB6sWD
         Itqw==
X-Gm-Message-State: AAQBX9clTjYdhPT4uHMbjvgcA+9E3RYHl5dihoc9gqHj80t+7emf8Uw/
        /tnedWek2quRySaHmuQVLFKUvudI2/5WjVsr7gCoUyVM
X-Google-Smtp-Source: AKy350aesRf01RAhxs0H5n7pD6zzBoG6FpEgPTscMmdgC7GIIZycEmZ32M5l6vNUB3k/IYoZZ3j1tOR5tQycurvsoiE=
X-Received: by 2002:a19:c50f:0:b0:4ec:8e50:5032 with SMTP id
 w15-20020a19c50f000000b004ec8e505032mr59955lfe.13.1681505883187; Fri, 14 Apr
 2023 13:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064344.18714-1-quic_tjiang@quicinc.com>
In-Reply-To: <20230413064344.18714-1-quic_tjiang@quicinc.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Apr 2023 13:57:51 -0700
Message-ID: <CABBYNZJdWCCs+Z-Mvj47jrPHBaj-L7j2D6bJ+fShzPstMxkU3g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add WCN6855 devcoredump support
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com,
        mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Wed, Apr 12, 2023 at 11:46=E2=80=AFPM Tim Jiang <quic_tjiang@quicinc.com=
> wrote:
>
> WCN6855 will report memdump via ACL data or HCI event when
> it get crashed, so we collect memdump to debug firmware.
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
> @@ -733,6 +733,16 @@ static const struct dmi_system_id btusb_needs_reset_=
resume_table[] =3D {
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
> @@ -752,6 +762,7 @@ static const struct dmi_system_id btusb_needs_reset_r=
esume_table[] =3D {
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
> @@ -904,6 +917,11 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hd=
ev)
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         struct gpio_desc *reset_gpio =3D data->reset_gpio;
>
> +       if (test_bit(BTUSB_HW_SSR_ACTIVE, &data->flags)) {
> +               bt_dev_info(hdev, "Ramdump in progress, defer cmd_timeout=
");
> +               return;
> +       }
> +
>         if (++data->cmd_timeout_cnt < 5)
>                 return;
>
> @@ -3294,6 +3312,202 @@ static int btusb_set_bdaddr_wcn6855(struct hci_de=
v *hdev,
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
> +static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb=
)
> +{
> +       char buf[128];
> +       struct btusb_data *btdata =3D hci_get_drvdata(hdev);
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
> +                       btdata->qca_dump.id_vendor, btdata->qca_dump.id_p=
roduct);
> +       skb_put_data(skb, buf, strlen(buf));
> +
> +       snprintf(buf, sizeof(buf), "Lmp Subversion: 0x%x\n",
> +                       hdev->lmp_subver);
> +       skb_put_data(skb, buf, strlen(buf));
> +}
> +
> +static void btusb_coredump_qca(struct hci_dev *hdev)
> +{
> +       static const u8 param[] =3D { 0x26 };
> +       struct sk_buff *skb;
> +
> +       skb =3D __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb))
> +               bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func=
__, PTR_ERR(skb));
> +       kfree_skb(skb);
> +}
> +
> +/*
> + * =3D=3D0: not a dump pkt.
> + * < 0: fails to handle a dump pkt
> + * > 0: otherwise.
> + */
> +static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb=
)
> +{
> +       int ret =3D 1;
> +       u8 pkt_type;
> +       u8 *sk_ptr;
> +       unsigned int sk_len;
> +       u16 seqno;
> +       u32 dump_size;
> +
> +       struct hci_event_hdr *event_hdr;
> +       struct hci_acl_hdr *acl_hdr;
> +       struct qca_dump_hdr *dump_hdr;
> +       struct btusb_data *btdata =3D hci_get_drvdata(hdev);
> +       struct usb_device *udev =3D btdata->udev;
> +
> +       pkt_type =3D hci_skb_pkt_type(skb);
> +       sk_ptr =3D skb->data;
> +       sk_len =3D skb->len;
> +
> +       if (pkt_type =3D=3D HCI_ACLDATA_PKT) {
> +               acl_hdr =3D hci_acl_hdr(skb);
> +               if (le16_to_cpu(acl_hdr->handle) !=3D QCA_MEMDUMP_ACL_HAN=
DLE)
> +                       return 0;
> +               sk_ptr +=3D HCI_ACL_HDR_SIZE;
> +               sk_len -=3D HCI_ACL_HDR_SIZE;
> +               event_hdr =3D (struct hci_event_hdr *)sk_ptr;
> +       } else {
> +               event_hdr =3D hci_event_hdr(skb);
> +       }
> +
> +       if ((event_hdr->evt !=3D HCI_VENDOR_PKT)
> +               || (event_hdr->plen !=3D (sk_len - HCI_EVENT_HDR_SIZE)))
> +               return 0;
> +
> +       sk_ptr +=3D HCI_EVENT_HDR_SIZE;
> +       sk_len -=3D HCI_EVENT_HDR_SIZE;
> +
> +       dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
> +       if ((sk_len < offsetof(struct qca_dump_hdr, data))
> +               || (dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS)
> +           || (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> +               return 0;
> +
> +       /*it is dump pkt now*/
> +       seqno =3D le16_to_cpu(dump_hdr->seqno);
> +       if (seqno =3D=3D 0) {
> +               set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> +               dump_size =3D le32_to_cpu(dump_hdr->ram_dump_size);
> +               if (!dump_size || (dump_size > QCA_MEMDUMP_SIZE_MAX)) {
> +                       ret =3D -EILSEQ;
> +                       bt_dev_err(hdev, "Invalid memdump size(%u)",
> +                                  dump_size);
> +                       goto out;
> +               }
> +
> +               ret =3D hci_devcd_init(hdev, dump_size);
> +               if (ret < 0) {
> +                       bt_dev_err(hdev, "memdump init error(%d)", ret);
> +                       goto out;
> +               }
> +
> +               btdata->qca_dump.ram_dump_size =3D dump_size;
> +               btdata->qca_dump.ram_dump_seqno =3D 0;
> +               sk_ptr +=3D offsetof(struct qca_dump_hdr, data0);
> +               sk_len -=3D offsetof(struct qca_dump_hdr, data0);
> +
> +               usb_disable_autosuspend(udev);
> +               bt_dev_info(hdev, "%s memdump size(%u)\n",
> +                           (pkt_type =3D=3D HCI_ACLDATA_PKT) ? "ACL" : "=
event",
> +                           dump_size);

Lets not use bt_dev_info for devcd code, since the system should log
these events via devcd interface, so please convert any instance of
bt_dev_info to bt_dev_dbg.

> +       } else {
> +               sk_ptr +=3D offsetof(struct qca_dump_hdr, data);
> +               sk_len -=3D offsetof(struct qca_dump_hdr, data);
> +       }
> +
> +       if (!btdata->qca_dump.ram_dump_size) {
> +               ret =3D -EINVAL;
> +               bt_dev_err(hdev, "memdump is not active");
> +               goto out;
> +       }
> +
> +       if ((seqno > btdata->qca_dump.ram_dump_seqno + 1) && (seqno !=3D =
QCA_LAST_SEQUENCE_NUM)) {
> +               dump_size =3D QCA_MEMDUMP_PKT_SIZE * (seqno - btdata->qca=
_dump.ram_dump_seqno - 1);
> +               hci_devcd_append_pattern(hdev, 0x0, dump_size);
> +               bt_dev_err(hdev,
> +                          "expected memdump seqno(%u) is not received(%u=
)\n",
> +                          btdata->qca_dump.ram_dump_seqno, seqno);
> +               btdata->qca_dump.ram_dump_seqno =3D seqno;
> +               kfree_skb(skb);
> +               return ret;
> +       }
> +
> +       skb_pull(skb, skb->len - sk_len);
> +       hci_devcd_append(hdev, skb);
> +       btdata->qca_dump.ram_dump_seqno++;
> +       if (seqno =3D=3D QCA_LAST_SEQUENCE_NUM) {
> +               bt_dev_info(hdev,
> +                               "memdump done: pkts(%u), total(%u)\n",
> +                               btdata->qca_dump.ram_dump_seqno, btdata->=
qca_dump.ram_dump_size);

Ditto.

> +               hci_devcd_complete(hdev);
> +               goto out;
> +       }
> +       return ret;
> +
> +out:
> +       if (btdata->qca_dump.ram_dump_size)
> +               usb_enable_autosuspend(udev);
> +       btdata->qca_dump.ram_dump_size =3D 0;
> +       btdata->qca_dump.ram_dump_seqno =3D 0;
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
> +       btdata->qca_dump.fw_version =3D le32_to_cpu(ver.patch_version);
> +       btdata->qca_dump.controller_id =3D le32_to_cpu(ver.rom_version);
> +
>         if (!(status & QCA_SYSCFG_UPDATED)) {
>                 err =3D btusb_setup_qca_load_nvm(hdev, &ver, info);
>                 if (err < 0)
> @@ -4117,6 +4334,11 @@ static int btusb_probe(struct usb_interface *intf,
>         }
>
>         if (id->driver_info & BTUSB_QCA_WCN6855) {
> +               data->qca_dump.id_vendor =3D id->idVendor;
> +               data->qca_dump.id_product =3D id->idProduct;
> +               data->recv_event =3D btusb_recv_evt_qca;
> +               data->recv_acl =3D btusb_recv_acl_qca;
> +               hci_devcd_register(hdev, btusb_coredump_qca, btusb_dump_h=
dr_qca, NULL);
>                 data->setup_on_usb =3D btusb_setup_qca;
>                 hdev->shutdown =3D btusb_shutdown_qca;
>                 hdev->set_bdaddr =3D btusb_set_bdaddr_wcn6855;
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz
