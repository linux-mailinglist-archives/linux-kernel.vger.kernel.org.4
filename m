Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFBE6A8E44
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCCArk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCArh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:47:37 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49D2580E7;
        Thu,  2 Mar 2023 16:47:26 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x6so813266ljq.1;
        Thu, 02 Mar 2023 16:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8IBvSk03mdwBhrMfLX8E9pU4bCyC5xIIUspkH2OZOc=;
        b=IN6G8qLmxz6uEL938nCO/c1atOAerinb74wI/sfcCtgPSLuGbKYcE+gRGr5PE+5EOl
         hJw0ugCBQ2wjAVa/pRdPLVm3RaKkt2E3dlIs9AtLYOH+03K+GvgxlFovuXqACaFaTorl
         xq2XfsfNqz7ggyPzvjY9RkOF61h9GJV+aVZjxZ5nq4+AP2fcgYmfJuW3HwXJvNl8GSE5
         Nc/Zn8hvGdptQA1XM+EBxEJx7v/tmqzORbk9vec0btIIBpUbbsskfa7CQn9BpVqer8xt
         pmPmbu5UkR2+K7HcGRRwzolJVyvPnb2q8fI1I/TtPZFAAeo3njUV1diM8AMLV5yiR2nn
         lR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8IBvSk03mdwBhrMfLX8E9pU4bCyC5xIIUspkH2OZOc=;
        b=PsZoW7JHVuOIYdyUNiTLAWf/9KcNwy2LAj7a+YmYvNIjwM9qzEQ1v+tuCea5uGwtBF
         DVNCrVGyILeZW+qZGaxKQJjyw5joV0UuWcuhiPWqGBqXLs9DRk0q380+gHM5ca+xzKeU
         FtQZuUzIODNCjZnQw4HdcspKCg5t2gBgQjpPquIM+pAOI7D0Nj7OcbBsngypvdvasSbL
         6gljSE0o3KswpSz2eisvxcHLGBVxGpZSDRirejGqi9/EMPcHboaLd3Vdvdtvga3q6+gw
         Zp6BSOpcRWeJHdySexAHUebQZ/MxbeA40myToh0I20FUGgVkMsoD02IXphyBMV/0TNWl
         2rnw==
X-Gm-Message-State: AO0yUKULJ4iMUbPr8AGTr0P6aOqs5v1+2zhzyuPBsnWmYY39w/Q+YD/p
        FOSiPD1oO5gCK/ydmClxNKgUZxNAF5ImzCfJe5Q=
X-Google-Smtp-Source: AK7set95rq6DpYqveNHINHVYwVO7z5Dz3fyp+0LREvLZ6KUt9mhldQs4UhoF7MWUUxI+onGGe6fAXz5SBo7A0Scj5gs=
X-Received: by 2002:a05:651c:2dc:b0:295:b96e:caa6 with SMTP id
 f28-20020a05651c02dc00b00295b96ecaa6mr3839629ljo.9.1677804444871; Thu, 02 Mar
 2023 16:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20230302151413.v7.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
 <20230302151413.v7.4.I8ac78c64382c66cdb49076a2053ef9c44ebf1ea3@changeid>
In-Reply-To: <20230302151413.v7.4.I8ac78c64382c66cdb49076a2053ef9c44ebf1ea3@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Mar 2023 16:47:13 -0800
Message-ID: <CABBYNZ+TaEeiULXWGEoyPzVYgY1=paofDnc7iXZbd=JrASFGfg@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] Bluetooth: btintel: Add Intel devcoredump support
To:     Manish Mandlik <mmandlik@google.com>
Cc:     marcel@holtmann.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

On Thu, Mar 2, 2023 at 3:15=E2=80=AFPM Manish Mandlik <mmandlik@google.com>=
 wrote:
>
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Intercept debug exception events from the controller and put them into
> a devcoredump using hci devcoredump APIs. The debug exception contains
> data in a TLV format and it will be parsed in userspace.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Manish Mandlik <mmandlik@google.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Reviewed-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
> ---
>
> Changes in v7:
> - Update btintel_coredump() and btusb_intel_diagnostics()
>
> Changes in v6:
> - Implement btintel_coredump()
>
> Changes in v4:
> - Add btintel_coredump() placeholder
>
> Changes in v2:
> - Create a local struct to store coredump_info in btintel.c
> - Call btintel_register_devcoredump_support() from btintel.c
> - Fix strncpy() destination bound warning
>
>  drivers/bluetooth/btintel.c | 81 ++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btintel.h | 12 +++++-
>  drivers/bluetooth/btusb.c   | 54 +++++++++++++++++++++----
>  3 files changed, 137 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index bede8b005594..3f0bc3ea4af7 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -36,6 +36,13 @@ struct cmd_write_boot_params {
>         u8  fw_build_yy;
>  } __packed;
>
> +#define DRIVER_NAME_LEN                16
> +static struct {
> +       char driver_name[DRIVER_NAME_LEN];

Can't we access the driver name directly from another structure? Don't
really like the idea of having to truncate the name if the driver name
is bigger than expected, besides the size itself seems to be arbitrary
selected here.

> +       u8   hw_variant;
> +       u32  fw_build_num;
> +} coredump_info;
> +
>  int btintel_check_bdaddr(struct hci_dev *hdev)
>  {
>         struct hci_rp_read_bd_addr *bda;
> @@ -308,6 +315,9 @@ int btintel_version_info(struct hci_dev *hdev, struct=
 intel_version *ver)
>                 return -EINVAL;
>         }
>
> +       coredump_info.hw_variant =3D ver->hw_variant;
> +       coredump_info.fw_build_num =3D ver->fw_build_num;
> +
>         bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
>                     variant, ver->fw_revision >> 4, ver->fw_revision & 0x=
0f,
>                     ver->fw_build_num, ver->fw_build_ww,
> @@ -502,6 +512,9 @@ static int btintel_version_info_tlv(struct hci_dev *h=
dev,
>                 return -EINVAL;
>         }
>
> +       coredump_info.hw_variant =3D INTEL_HW_VARIANT(version->cnvi_bt);
> +       coredump_info.fw_build_num =3D version->build_num;
> +
>         bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", var=
iant,
>                     2000 + (version->timestamp >> 8), version->timestamp =
& 0xff,
>                     version->build_type, version->build_num);
> @@ -1453,6 +1466,67 @@ int btintel_set_quality_report(struct hci_dev *hde=
v, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(btintel_set_quality_report);
>
> +static void btintel_coredump(struct hci_dev *hdev)
> +{
> +       struct sk_buff *skb;
> +
> +       skb =3D __hci_cmd_sync(hdev, 0xfc4e, 0, NULL, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Coredump failed (%ld)", PTR_ERR(skb));
> +               return;
> +       }
> +
> +       kfree_skb(skb);
> +}
> +
> +static int btintel_dmp_hdr(struct hci_dev *hdev, char *buf, size_t size)
> +{
> +       char *ptr =3D buf;
> +       size_t rem =3D size;
> +       size_t read =3D 0;
> +
> +       read =3D snprintf(ptr, rem, "Controller Name: 0x%X\n",
> +                       coredump_info.hw_variant);
> +       rem -=3D read;
> +       ptr +=3D read;

Same thing here, I'd recommend using an skb and then use the likes of
skb_push, etc, to append into the buffer.

> +       read =3D snprintf(ptr, rem, "Firmware Version: 0x%X\n",
> +                       coredump_info.fw_build_num);
> +       rem -=3D read;
> +       ptr +=3D read;
> +
> +       read =3D snprintf(ptr, rem, "Driver: %s\n", coredump_info.driver_=
name);
> +       rem -=3D read;
> +       ptr +=3D read;
> +
> +       read =3D snprintf(ptr, rem, "Vendor: Intel\n");
> +       rem -=3D read;
> +       ptr +=3D read;
> +
> +       return size - rem;
> +}
> +
> +static int btintel_register_devcoredump_support(struct hci_dev *hdev)
> +{
> +       struct intel_debug_features features;
> +       int err;
> +
> +       err =3D btintel_read_debug_features(hdev, &features);
> +       if (err) {
> +               bt_dev_info(hdev, "Error reading debug features");
> +               return err;
> +       }
> +
> +       if (!(features.page1[0] & 0x3f)) {
> +               bt_dev_info(hdev, "Telemetry exception format not support=
ed");

Does this really need to be an info, I'd leave it as bt_dev_debug.

> +               return -EOPNOTSUPP;
> +       }
> +
> +       hci_devcoredump_register(hdev, btintel_coredump, btintel_dmp_hdr,=
 NULL);
> +
> +       return err;
> +}
> +
>  static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *=
hdev,
>                                                struct intel_version *ver)
>  {
> @@ -2582,6 +2656,7 @@ static int btintel_setup_combined(struct hci_dev *h=
dev)
>                         btintel_set_msft_opcode(hdev, ver.hw_variant);
>
>                         err =3D btintel_bootloader_setup(hdev, &ver);
> +                       btintel_register_devcoredump_support(hdev);
>                         break;
>                 default:
>                         bt_dev_err(hdev, "Unsupported Intel hw variant (%=
u)",
> @@ -2655,6 +2730,7 @@ static int btintel_setup_combined(struct hci_dev *h=
dev)
>                 btintel_set_msft_opcode(hdev, ver.hw_variant);
>
>                 err =3D btintel_bootloader_setup(hdev, &ver);
> +               btintel_register_devcoredump_support(hdev);
>                 break;
>         case 0x17:
>         case 0x18:
> @@ -2678,6 +2754,7 @@ static int btintel_setup_combined(struct hci_dev *h=
dev)
>                                         INTEL_HW_VARIANT(ver_tlv.cnvi_bt)=
);
>
>                 err =3D btintel_bootloader_setup_tlv(hdev, &ver_tlv);
> +               btintel_register_devcoredump_support(hdev);
>                 break;
>         default:
>                 bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
> @@ -2727,7 +2804,7 @@ static int btintel_shutdown_combined(struct hci_dev=
 *hdev)
>         return 0;
>  }
>
> -int btintel_configure_setup(struct hci_dev *hdev)
> +int btintel_configure_setup(struct hci_dev *hdev, const char *driver_nam=
e)
>  {
>         hdev->manufacturer =3D 2;
>         hdev->setup =3D btintel_setup_combined;
> @@ -2736,6 +2813,8 @@ int btintel_configure_setup(struct hci_dev *hdev)
>         hdev->set_diag =3D btintel_set_diag_combined;
>         hdev->set_bdaddr =3D btintel_set_bdaddr;
>
> +       strncpy(coredump_info.driver_name, driver_name, DRIVER_NAME_LEN -=
 1);

Like I said I don't really like the idea of truncating the driver
name, can't we just refer to the pointer directly? In fact can't we
just resolve the driver name at runtime with use of hci_dev?

>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(btintel_configure_setup);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 8e7da877efae..c34553fef3b0 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -150,6 +150,13 @@ struct btintel_loc_aware_reg {
>         __le32 delta;
>  } __packed;
>
> +#define INTEL_TLV_TYPE_ID              0x01
> +
> +#define INTEL_TLV_SYSTEM_EXCEPTION     0x00
> +#define INTEL_TLV_FATAL_EXCEPTION      0x01
> +#define INTEL_TLV_DEBUG_EXCEPTION      0x02
> +#define INTEL_TLV_TEST_EXCEPTION       0xDE
> +
>  #define INTEL_HW_PLATFORM(cnvx_bt)     ((u8)(((cnvx_bt) & 0x0000ff00) >>=
 8))
>  #define INTEL_HW_VARIANT(cnvx_bt)      ((u8)(((cnvx_bt) & 0x003f0000) >>=
 16))
>  #define INTEL_CNVX_TOP_TYPE(cnvx_top)  ((cnvx_top) & 0x00000fff)
> @@ -219,7 +226,7 @@ int btintel_read_boot_params(struct hci_dev *hdev,
>                              struct intel_boot_params *params);
>  int btintel_download_firmware(struct hci_dev *dev, struct intel_version =
*ver,
>                               const struct firmware *fw, u32 *boot_param)=
;
> -int btintel_configure_setup(struct hci_dev *hdev);
> +int btintel_configure_setup(struct hci_dev *hdev, const char *driver_nam=
e);
>  void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int =
len);
>  void btintel_secure_send_result(struct hci_dev *hdev,
>                                 const void *ptr, unsigned int len);
> @@ -300,7 +307,8 @@ static inline int btintel_download_firmware(struct hc=
i_dev *dev,
>         return -EOPNOTSUPP;
>  }
>
> -static inline int btintel_configure_setup(struct hci_dev *hdev)
> +static inline int btintel_configure_setup(struct hci_dev *hdev,
> +                                         const char *driver_name)
>  {
>         return -ENODEV;
>  }
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 9c9f7bf1375a..4f7aa32696f4 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2376,16 +2376,47 @@ static int btusb_recv_bulk_intel(struct btusb_dat=
a *data, void *buffer,
>         return btusb_recv_bulk(data, buffer, count);
>  }
>
> +static int btusb_intel_diagnostics(struct hci_dev *hdev, struct sk_buff =
*skb)
> +{
> +       struct intel_tlv *tlv =3D (void *)&skb->data[5];
> +
> +       /* The first event is always an event type TLV */
> +       if (tlv->type !=3D INTEL_TLV_TYPE_ID)
> +               goto recv_frame;
> +
> +       switch (tlv->val[0]) {
> +       case INTEL_TLV_SYSTEM_EXCEPTION:
> +       case INTEL_TLV_FATAL_EXCEPTION:
> +       case INTEL_TLV_DEBUG_EXCEPTION:
> +       case INTEL_TLV_TEST_EXCEPTION:
> +               /* Generate devcoredump from exception */
> +               if (!hci_devcoredump_init(hdev, skb->len)) {
> +                       hci_devcoredump_append(hdev, skb);
> +                       hci_devcoredump_complete(hdev);
> +               } else {
> +                       bt_dev_err(hdev, "Failed to generate devcoredump"=
);
> +                       kfree_skb(skb);
> +               }
> +               return 0;
> +       default:
> +               bt_dev_err(hdev, "Invalid exception type %02X", tlv->val[=
0]);
> +       }
> +
> +recv_frame:
> +       return hci_recv_frame(hdev, skb);
> +}
> +
>  static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *=
skb)
>  {
> -       if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
> -               struct hci_event_hdr *hdr =3D (void *)skb->data;
> +       struct hci_event_hdr *hdr =3D (void *)skb->data;

Lets use skb_pull_data here, or if that is not possible since it
changes the packet then perhaps we need something that reset the skb
state, anway at the very least lets not access skb->data without first
checking the skb->len, I think in the long term what we really need is
a way for driver to register for its own event opcodes so we don't
have to intercept them like this.

> +       const char diagnostics_hdr[] =3D { 0x87, 0x80, 0x03 };
>
> -               if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt =3D=3D 0xff=
 &&
> -                   hdr->plen > 0) {
> -                       const void *ptr =3D skb->data + HCI_EVENT_HDR_SIZ=
E + 1;
> -                       unsigned int len =3D skb->len - HCI_EVENT_HDR_SIZ=
E - 1;
> +       if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt =3D=3D 0xff &&
> +           hdr->plen > 0) {
> +               const void *ptr =3D skb->data + HCI_EVENT_HDR_SIZE + 1;
> +               unsigned int len =3D skb->len - HCI_EVENT_HDR_SIZE - 1;
>
> +               if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
>                         switch (skb->data[2]) {
>                         case 0x02:
>                                 /* When switching to the operational firm=
ware
> @@ -2404,6 +2435,15 @@ static int btusb_recv_event_intel(struct hci_dev *=
hdev, struct sk_buff *skb)
>                                 break;
>                         }
>                 }
> +
> +               /* Handle all diagnostics events separately. May still ca=
ll
> +                * hci_recv_frame.
> +                */
> +               if (len >=3D sizeof(diagnostics_hdr) &&
> +                   memcmp(&skb->data[2], diagnostics_hdr,
> +                          sizeof(diagnostics_hdr)) =3D=3D 0) {
> +                       return btusb_intel_diagnostics(hdev, skb);
> +               }
>         }
>
>         return hci_recv_frame(hdev, skb);
> @@ -4008,7 +4048,7 @@ static int btusb_probe(struct usb_interface *intf,
>
>         /* Combined Intel Device setup to support multiple setup routine =
*/
>         if (id->driver_info & BTUSB_INTEL_COMBINED) {
> -               err =3D btintel_configure_setup(hdev);
> +               err =3D btintel_configure_setup(hdev, btusb_driver.name);
>                 if (err)
>                         goto out_free_dev;
>
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>


--=20
Luiz Augusto von Dentz
