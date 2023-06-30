Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDE74441F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 23:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjF3VzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 17:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3VzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:55:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7D3C0E;
        Fri, 30 Jun 2023 14:55:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so3961857e87.0;
        Fri, 30 Jun 2023 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688162099; x=1690754099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5DxyFcmJIMNE7LBSdw0rkcJEAqf+huqKEIAkUvUHJ8=;
        b=DEjH22qpNxM0IfWh3zAQj9c3eY2FA7gby1mw71AlZQju+wLUl1+O1vR7eZsUTyMUyy
         hTInCk2Xj+vGFtD4MNTSLL6qTMnXAxKOa3NHBzidb7YOhDLD78Iw+hxwxAhB98pNMF3w
         TH2rHkUgsgMVaH4fOy18IlN1e5NmHKDCKFjqBTc4cRAQmhAo0WholJq5AFGMrh12vYqr
         6DTFdH/uE2GmUB4Si06AYeHxdVKlzyijf/ym7ipCO/V/2YHg48hfyiP50RQtwyFzCJpt
         zpNVZwZxI0KlvXgxMjVIaDhSjARW7m1luURILYA3HUAD2XlXbBZN0mXzBihWL952jh+h
         JfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688162099; x=1690754099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5DxyFcmJIMNE7LBSdw0rkcJEAqf+huqKEIAkUvUHJ8=;
        b=USfa4OzF5ButRF/g0QXEP05n5kqAhmLIsayFIP9ux/Ebx7pApHGChMVzrlTUFjG4Sf
         cxEc3IClBZ1sCKRqQkrsftFkg6BnWt6+oTMlVUrlwzhFBokxTBVmmZdjoJEFuvXlA7VS
         dJ3qIXdtFtTAvTXtdn9MbvYvjEnnMLyH2r0Cm08jWJD+Gzyi+Jv4l1t5OMgxIz1eepsN
         bwp0Kzt0pezfO1ixpTlKXsjDcDh/AUenwVDHlcna0f+fxep4PGjVDT5ghITZ4/BVldBc
         rDicf4mN0NcqFwVvJBPFAMiYgDOe3Nd1BZBv5RI3fUIqoex2wx3B7eQ1qAQUn4QwH8E/
         WkzQ==
X-Gm-Message-State: ABy/qLZ9ZPig0edNr31J3Ei5CfN5ybDHH+ufU2sgGqZLPXDGgxzzxKKE
        wtZWVIOCR/qpGJop4/wzepXxWDVBcZFL62AwNnU=
X-Google-Smtp-Source: APBJJlGVVUvNEejt3V3N0bDzAsUdHFiy15zqpeG8FuTp7do4GlMHTp4/Qc9n0y74QlXt5qx09DpFp9QkooDzt16MDEw=
X-Received: by 2002:a05:6512:472:b0:4f9:5a87:1028 with SMTP id
 x18-20020a056512047200b004f95a871028mr2714789lfd.30.1688162099088; Fri, 30
 Jun 2023 14:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
In-Reply-To: <20230630143125.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 30 Jun 2023 14:54:46 -0700
Message-ID: <CABBYNZLtxMGQLFwZTztPo2epV2E9Z4uthFMeozxABW2KXQR1nQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Douglas,

On Fri, Jun 30, 2023 at 2:40=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> KASAN reports that there's a use-after-free in
> hci_remove_adv_monitor(). Trawling through the disassembly, you can
> see that the complaint is from the access in bt_dev_dbg() under the
> HCI_ADV_MONITOR_EXT_MSFT case. The problem case happens because
> msft_remove_monitor() can end up freeing the monitor
> structure. Specifically:
>   hci_remove_adv_monitor() ->
>   msft_remove_monitor() ->
>   msft_remove_monitor_sync() ->
>   msft_le_cancel_monitor_advertisement_cb() ->
>   hci_free_adv_monitor()
>
> Let's fix the problem by just stashing the relevant data when it's
> still valid.
>
> Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  net/bluetooth/hci_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 48917c68358d..dbb2043a9112 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1972,6 +1972,7 @@ static int hci_remove_adv_monitor(struct hci_dev *h=
dev,
>                                   struct adv_monitor *monitor)
>  {
>         int status =3D 0;
> +       int handle;
>
>         switch (hci_get_adv_monitor_offload_ext(hdev)) {
>         case HCI_ADV_MONITOR_EXT_NONE: /* also goes here when powered off=
 */
> @@ -1980,9 +1981,10 @@ static int hci_remove_adv_monitor(struct hci_dev *=
hdev,
>                 goto free_monitor;
>
>         case HCI_ADV_MONITOR_EXT_MSFT:
> +               handle =3D monitor->handle;
>                 status =3D msft_remove_monitor(hdev, monitor);
>                 bt_dev_dbg(hdev, "%s remove monitor %d msft status %d",
> -                          hdev->name, monitor->handle, status);
> +                          hdev->name, handle, status);

Just move the call to bt_dev_dbg under msft_remove_monitor, also there
is no reason to print hdev->name since bt_dev_dbg already does that so
while at it we can probably fix this as well.

>                 break;
>         }
>
> --
> 2.41.0.255.g8b1d071c50-goog
>


--=20
Luiz Augusto von Dentz
