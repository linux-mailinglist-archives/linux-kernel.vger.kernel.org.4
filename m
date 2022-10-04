Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D1C5F4A81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJDUxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJDUxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:53:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7055FAF0;
        Tue,  4 Oct 2022 13:53:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j16so22859972lfg.1;
        Tue, 04 Oct 2022 13:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vK7ZiQtOKOorpOolbuiXfBptJvD5dUeokoyncEYbxT8=;
        b=UkXSMqev0fpGvsDmqFj5ZP2zx9U9Iq3HCZ2/+UQh0hdwxnrmDgb4CXTXcvGE5A5L5D
         QdPsEKkvIUI2Y6UtzuRLOUvhbcCP/+huS0qvJbXtCUZVHfOBrbQZ1P24YNPMJ5Owq5TH
         JC307Geg9TwegkgS12Udbvdf180uRBNPmY3vYgonFzM20tsTt6rCoUTW+uS8gMks5J0x
         756s8dkM4df9wUtPLYu9PRTdp5Ut6L/SWHf24DJRcTT+ZwFTvDNCL7/59FtdpYsyZHPt
         gG4Mn84ddUfcnwdmh1X72IIX6JCzwfIwWI6RnPpoRrd6sB/bldCQBUCVPmF8IHR2XW3I
         pYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vK7ZiQtOKOorpOolbuiXfBptJvD5dUeokoyncEYbxT8=;
        b=3Zm/14NJOpu8W2rzPi1vlHekCXHcVWgsbBop+hib5YQ1r9xNoajp0w2oaIGvozebCZ
         mQkY1pohFJl0Xzk1gotpYjrYTK2Ed6EKK3YQ55W9wqH0kpz8cb28o2wFFWO7T3b+WH77
         EP+vKOsMGvMtz+YgwGsW+BW/78WtLg9oMfCAk6JnLHq18i/PdYnlG13a2cySvhgyyMmR
         y/0itzIz4K85Y94/uWUxDuNgsyrSF/m/mVp7NGwKNqFWHOEpltlSmuZfwXl8AhJvRfMi
         fV8257oDDivbXh5AxA4wuLhn+9iGbx7bjp85M1J5CbtIWT5VUGDlW9PaQvToSOqUVbTW
         agCw==
X-Gm-Message-State: ACrzQf1s484VIEUu9oyVviRUqCVqa/pwdHsPnNMj16lbq1HkxSg0mshS
        D2ZNdFRXL/aVi4rAGwHjcizrW/aOg4eCsPwDrwU=
X-Google-Smtp-Source: AMsMyM45NUPRhDPYkze1OxQJG1io/+S5snLELYeemJjqgFVRMfH/OeUe/+fnXoChUS+sEVRn4xQMSm+xTx3iYTfhYo8=
X-Received: by 2002:ac2:4c8b:0:b0:4a2:2432:93ff with SMTP id
 d11-20020ac24c8b000000b004a2243293ffmr5499306lfl.26.1664916807436; Tue, 04
 Oct 2022 13:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221004163224.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
In-Reply-To: <20221004163224.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Oct 2022 13:53:15 -0700
Message-ID: <CABBYNZ+M5KqVvzOT4LjVR2ZzF1cxCxYtJnMLS89ke48FyErjzg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Introduce generic USB reset
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Archie,

On Tue, Oct 4, 2022 at 1:33 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> On cmd_timeout and there is no reset_gpio, reset the USB port as a
> last resort.
>
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> Reviewed-by: Ying Hsu <yinghsu@chromium.org>
>
> ---
>
>  drivers/bluetooth/btusb.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 271963805a38..11040124ef79 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -696,6 +696,19 @@ struct btusb_data {
>         unsigned cmd_timeout_cnt;
>  };
>
> +static void generic_usb_reset(struct hci_dev *hdev, struct btusb_data *data)
> +{
> +       int err;
> +
> +       bt_dev_err(hdev, "Resetting usb device.");
> +       /* This is not an unbalanced PM reference since the device will reset */
> +       err = usb_autopm_get_interface(data->intf);
> +       if (!err)
> +               usb_queue_reset_device(data->intf);
> +       else
> +               bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);

Lets just have one line printed if it fails:

err = usb_autopm_get_interface(data->intf);
if (err) {
        bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", err);
        return;
}

bt_dev_err(hdev, "Resetting usb device.");
usb_queue_reset_device(data->intf);

> +}
> +
>  static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
>  {
>         struct btusb_data *data = hci_get_drvdata(hdev);
> @@ -705,7 +718,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
>                 return;
>
>         if (!reset_gpio) {
> -               bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
> +               generic_usb_reset(hdev, data);

Lets call it btusb_reset since this is specific for the data->intf,
btw is this safe, or perhaps we want to refactor this to have it
callback based so each vendor can add it own specific hdev->reset
callback hardware reset with btusb_reset serving as default callback?
Also the logic of btusb_intel_cmd_timeout should probably be put
inside btintel.c and I don't think we need the gpio_desc reference to
be inside the btusb_data since we can call gpiod_get_optional during
the reset phase and immediately do gpiod_put after done using it.

>                 return;
>         }
>
> @@ -736,7 +749,7 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
>                 return;
>
>         if (!reset_gpio) {
> -               bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
> +               generic_usb_reset(hdev, data);
>                 return;
>         }
>
> @@ -761,7 +774,6 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
>  {
>         struct btusb_data *data = hci_get_drvdata(hdev);
>         struct gpio_desc *reset_gpio = data->reset_gpio;
> -       int err;
>
>         if (++data->cmd_timeout_cnt < 5)
>                 return;
> @@ -787,13 +799,7 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
>                 return;
>         }
>
> -       bt_dev_err(hdev, "Multiple cmd timeouts seen. Resetting usb device.");
> -       /* This is not an unbalanced PM reference since the device will reset */
> -       err = usb_autopm_get_interface(data->intf);
> -       if (!err)
> -               usb_queue_reset_device(data->intf);
> -       else
> -               bt_dev_err(hdev, "Failed usb_autopm_get_interface with %d", err);
> +       generic_usb_reset(hdev, data);
>  }
>
>  static inline void btusb_free_frags(struct btusb_data *data)
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>


-- 
Luiz Augusto von Dentz
