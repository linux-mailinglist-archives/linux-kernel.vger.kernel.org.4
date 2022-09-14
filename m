Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B715B9024
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiINVhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiINVhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:37:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E437557E0E;
        Wed, 14 Sep 2022 14:37:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k10so27240838lfm.4;
        Wed, 14 Sep 2022 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=chB+Lu6UnHCHH080s7HW8NVlIEEyU+gPJTweSWX9ogs=;
        b=DQJ4rFtaPOZtzkgXxaNeKhheSHyPdrX3QivtYFhtE0SG1c9EuFaew8+AeNrLGvVAKY
         SPOLd+MKlbV5O0NBkmsopNkp22E8NArHlCmijGu8SlHnt4ul5/5E9ZhfpHHbkKsabOA+
         1OsFlGct2Au8/7PEEV0lcfAq/weCFOY6CP9istc/i5/zwTCyVC3Ivyw7ntB+jgsbBAA8
         V2jxgGdMYQlZod1pbm575N+526WaIn+CIgga/LKwJxvwBXmdfnBQ/5Umc0wg+t3Jc2CB
         uAPFCGCy+rIpUO25ZMgMP//89QcUNXHt+lL0MlnOmxeNQ4T1LGpmgDf+h0tppVsFT/u6
         o7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=chB+Lu6UnHCHH080s7HW8NVlIEEyU+gPJTweSWX9ogs=;
        b=21PCi9rhSIB6KwfgAcNjvA/eoPIZp5yuhB4WAScR4vUTRzoOPLc212uPUTbNvSMihP
         6PsmsAR1YIeVVgPTKFN9T6EhDLbpEY1lqMxI7DqBUVa4/RXdgmJhgPg6+5zhfI8sSc6j
         1uoWW8MSgGs/X4sciwKmnXUfUca0g7e0vEwW41PkrAsqDjO3FYtbk11uy9cRb8BsZDv3
         48OHkon2i5OxGcsk2JQ4OGdR4DJZEjqAfQpNJo3E9gQnt8KDuVjsB9l7CF4dLkfJ5vYh
         QEOCPCiQzbOyd/xEq1rY1xwRde3JlNJx4DL7Gdmyx1c5fAdGjRNnmYvDrQW2YJJba5jx
         ++bg==
X-Gm-Message-State: ACgBeo0t1oHDDjO+g1wzBQY6lzjUH2GImywhkm+8wQ5VhzBmn+J1suEU
        XNQiODdM2wAceC58izAb+ipQ/0omXU97mbhktOU=
X-Google-Smtp-Source: AA6agR5eHNF9+/sozTIKo93t+FLVStOkqBL3q/bankcDHJXL21KqhuKdWDn52VHK91fa5zMqeDQ6M5EwXgBdziUjLcc=
X-Received: by 2002:a05:6512:b81:b0:494:78cc:ca9c with SMTP id
 b1-20020a0565120b8100b0049478ccca9cmr12073587lfv.564.1663191452188; Wed, 14
 Sep 2022 14:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220913100244.23660-1-hildawu@realtek.com> <20220913100244.23660-3-hildawu@realtek.com>
In-Reply-To: <20220913100244.23660-3-hildawu@realtek.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Sep 2022 14:37:20 -0700
Message-ID: <CABBYNZKCEs_2Jb1tPncekgxGtjkNkgew4hzdKktoQhvPkuR1Lw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Bluetooth: btusb: Workaround for spotty SCO quality
To:     hildawu@realtek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        apusaka@chromium.org, yinghsu@chromium.org, max.chou@realtek.com,
        alex_lu@realsil.com.cn, kidman@realtek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hilda,

On Tue, Sep 13, 2022 at 3:02 AM <hildawu@realtek.com> wrote:
>
> From: Hilda Wu <hildawu@realtek.com>
>
> When streaming HFP, once a few minutes a brief pause in audio can be
> heard on some platform with Realtek Bluetooth. When the issue occurs,
> the system will see the SCO packet for unknown connection handle messages.
>
> Note: This issue affects (e)SCO only, does not affect ACLs.
> Because the duplicate packet causing the problem only occurs in Realtek BT.
> This is to filter out duplicate packet for avoiding influence.
>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> Changes in v2:
>  - Seperate commits for functions
> ---
> ---
>  drivers/bluetooth/btrtl.c | 28 ++++++++++++++++++++++++++++
>  drivers/bluetooth/btrtl.h |  8 ++++++++
>  drivers/bluetooth/btusb.c | 14 ++++++++++++++
>  3 files changed, 50 insertions(+)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index fb52313a1d45..15223b3ed94d 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -781,6 +781,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
>         case CHIP_ID_8852C:
>                 set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
>                 set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
> +               btrealtek_set_flag(hdev, REALTEK_WBS_FILTER);
>                 hci_set_aosp_capable(hdev);
>                 break;
>         default:
> @@ -937,6 +938,33 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>  }
>  EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
>
> +int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *p, int len,
> +                       u16 wMaxPacketSize)
> +{
> +       u8 *prev;
> +
> +       if (pos >= HCI_SCO_HDR_SIZE && pos >= wMaxPacketSize &&
> +           len == wMaxPacketSize && !(pos % wMaxPacketSize) &&
> +           wMaxPacketSize >= 10 && p[0] == data[0] && p[1] == data[1]) {
> +               prev = data + (pos - wMaxPacketSize);

Is this attempting to access before the skb-->data in case
wMaxPacketSize is bigger than pos? Anyway I'm not really following the
reasoning you are comparing the data like that, depending on the codec
there could be frames that match exactly but doesn't necessarily means
they are duplicated.

> +
> +               /* Detect the sco data of usb isoc pkt duplication. */
> +               if (!memcmp(p + 2, prev + 2, 8))
> +                       return -EILSEQ;
> +
> +               if (wMaxPacketSize >= 12 &&
> +                   p[2] == prev[6] && p[3] == prev[7] &&
> +                   p[4] == prev[4] && p[5] == prev[5] &&
> +                   p[6] == prev[10] && p[7] == prev[11] &&
> +                   p[8] == prev[8] && p[9] == prev[9]) {
> +                       return -EILSEQ;
> +               }
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(btrtl_usb_recv_isoc);
> +
>  MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
>  MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
>  MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index e2c99684799a..79e93a8b229f 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -84,6 +84,8 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
>                             struct btrtl_device_info *btrtl_dev,
>                             unsigned int *controller_baudrate,
>                             u32 *device_baudrate, bool *flow_control);
> +int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
> +                               u16 wMaxPacketSize);
>
>  #else
>
> @@ -127,4 +129,10 @@ static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
>         return -ENOENT;
>  }
>
> +static inline int btrtl_usb_recv_isoc(u16 pos, u8 *data, u8 *buffer, int len,
> +                                 u16 wMaxPacketSize)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4c3aed89ff05..8e595e03655a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -961,6 +961,7 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
>         struct sk_buff *skb;
>         unsigned long flags;
>         int err = 0;
> +       u16 wMaxPacketSize = le16_to_cpu(data->isoc_rx_ep->wMaxPacketSize);
>
>         spin_lock_irqsave(&data->rxlock, flags);
>         skb = data->sco_skb;
> @@ -980,6 +981,19 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
>                 }
>
>                 len = min_t(uint, hci_skb_expect(skb), count);
> +
> +               /* Gaps in audio could be heard while streaming WBS using USB
> +                * alt settings 3 on some platforms, since this is only used
> +                * with RTK chips so let vendor function detect it.
> +                */
> +               if (test_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags) &&
> +                       btrealtek_test_flag(data->hdev, REALTEK_WBS_FILTER)) {
> +                       err = btrtl_usb_recv_isoc(skb->len, skb->data, buffer,
> +                                                       len, wMaxPacketSize);
> +                       if (err)
> +                               break;
> +               }

If we really need to do this then we need a way for vendors to replace
btus_recv_isoc with the vendor function.

>                 skb_put_data(skb, buffer, len);
>
>                 count -= len;
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
