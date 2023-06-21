Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621997388C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjFUPV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjFUPUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:20:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968B41BF5;
        Wed, 21 Jun 2023 08:18:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f8775126d3so3943182e87.1;
        Wed, 21 Jun 2023 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687360700; x=1689952700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSen+zBAIg18Rp9jlGNUtOajx7SmCBDVFIEONdBtLJ8=;
        b=kP95B7iNAo4PTHQy1CUM8QHZcb5D8EGkG9PB0zTlSOEX0ORI6UBQBCN2tvE2x84YSH
         fmfsxRvrICJYuTCMAvx0teUgOzuJCi9tsKZMK2jlh20YpHDvPL5o+IaUWyR0L1u2Pz4Y
         GaezGubGfrVa1jZK796btfZhmAcTG6Ji66xVwlALZrulos6hmPdIjCAbVMTbGUG+ft3E
         nT/e3GiYoUSOzWspLI1kqD6em5PKJ12f6ulcmmJ0gKvX1J9RG0mvHosYfFwhKDsic0bA
         wsWZct13WdkMxxnoIKs/IEVsg2iIB4AIDZjbizzXroK9PiXuQIdhQSzpEdbnq+DumpDx
         w9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687360700; x=1689952700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSen+zBAIg18Rp9jlGNUtOajx7SmCBDVFIEONdBtLJ8=;
        b=OlbM7CbNVQboZVVooLLJK0Olk0yfyVTusmLYay57sYwfuUxmpxjQgupMRPWSlEZ4Ym
         dZbQnwsTVlfl/6lPnZMJmhh4q7EqGK0l7Vsbj7CNHkA6Em1r5Y0DJ7m00r7OAa9xnvdz
         llaGyYJlhBgvGCuJCNxa2YIt/VxGcLueiXF0dAGXnATMRk5YugQIYxuHKjWCGGbI4LVv
         cNl3dCqnJLB28IgrwuiU1h6q83WLKDXmXXBoGSSg8aqdDssK1mr7IA1nlRnYTtb3S4YG
         ppU7TMgcdepWm156F1oGCAT+NWgnPOLENmJIeJWA/LyJoULMZgEiPC8RcYGk8Q9iHt+s
         bGxA==
X-Gm-Message-State: AC+VfDzPYKGYhVVjL6jfuJkYrD8y65t6KWPgToVZcSJIgaaISneBTKcg
        u0SONJbFJYZB8SAR9+HNvaTHTCHeXY74be4Wz6SvhTCe
X-Google-Smtp-Source: ACHHUZ5Q+boYEtKLhRKO9zR4Wwu+QRmt9F4DaCw3EB8iFelWGcVJFWtqt0ElqfrniHY8S/jp4EAZaKh5G+4tDsCppag=
X-Received: by 2002:a19:f203:0:b0:4f5:f736:cb9f with SMTP id
 q3-20020a19f203000000b004f5f736cb9fmr9842715lfh.67.1687360700051; Wed, 21 Jun
 2023 08:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230607214102.2113-1-jason.gerecke@wacom.com> <20230608213828.2108-1-jason.gerecke@wacom.com>
In-Reply-To: <20230608213828.2108-1-jason.gerecke@wacom.com>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Wed, 21 Jun 2023 08:18:08 -0700
Message-ID: <CANRwn3R-XbfB+mP9AQ-J7R_19jLi4eS3MhswaWjL+LCEih-7pg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: wacom: Use ktime_t rather than int when dealing
 with timestamps
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Joshua Dickens <Joshua@joshua-dickens.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up since no action seems to have been taken on this patch yet.

On Thu, Jun 8, 2023 at 2:38=E2=80=AFPM Jason Gerecke <killertofu@gmail.com>=
 wrote:
>
> Code which interacts with timestamps needs to use the ktime_t type
> returned by functions like ktime_get. The int type does not offer
> enough space to store these values, and attempting to use it is a
> recipe for problems. In this particular case, overflows would occur
> when calculating/storing timestamps leading to incorrect values being
> reported to userspace. In some cases these bad timestamps cause input
> handling in userspace to appear hung.
>
> Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/901
> Fixes: 17d793f3ed53 ("HID: wacom: insert timestamp to packed Bluetooth (B=
T) events")
> CC: stable@vger.kernel.org
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
> v2: Use div_u64 to perform division to deal with ARC and ARM architecture=
s
>     (as found by the kernel test robot)
>
>  drivers/hid/wacom_wac.c | 6 +++---
>  drivers/hid/wacom_wac.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 2ccf838371343..174bf03908d7c 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1314,7 +1314,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_w=
ac *wacom)
>         struct input_dev *pen_input =3D wacom->pen_input;
>         unsigned char *data =3D wacom->data;
>         int number_of_valid_frames =3D 0;
> -       int time_interval =3D 15000000;
> +       ktime_t time_interval =3D 15000000;
>         ktime_t time_packet_received =3D ktime_get();
>         int i;
>
> @@ -1348,7 +1348,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_w=
ac *wacom)
>         if (number_of_valid_frames) {
>                 if (wacom->hid_data.time_delayed)
>                         time_interval =3D ktime_get() - wacom->hid_data.t=
ime_delayed;
> -               time_interval /=3D number_of_valid_frames;
> +               time_interval =3D div_u64(time_interval, number_of_valid_=
frames);
>                 wacom->hid_data.time_delayed =3D time_packet_received;
>         }
>
> @@ -1359,7 +1359,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_w=
ac *wacom)
>                 bool range =3D frame[0] & 0x20;
>                 bool invert =3D frame[0] & 0x10;
>                 int frames_number_reversed =3D number_of_valid_frames - i=
 - 1;
> -               int event_timestamp =3D time_packet_received - frames_num=
ber_reversed * time_interval;
> +               ktime_t event_timestamp =3D time_packet_received - frames=
_number_reversed * time_interval;
>
>                 if (!valid)
>                         continue;
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 1a40bb8c5810c..ee21bb260f22f 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -324,7 +324,7 @@ struct hid_data {
>         int ps_connected;
>         bool pad_input_event_flag;
>         unsigned short sequence_number;
> -       int time_delayed;
> +       ktime_t time_delayed;
>  };
>
>  struct wacom_remote_data {
> --
> 2.41.0
>
