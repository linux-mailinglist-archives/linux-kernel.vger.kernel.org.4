Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37C6E4EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjDQRN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDQRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:13:57 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274ADF2;
        Mon, 17 Apr 2023 10:13:56 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7606df2b5e3so73247639f.3;
        Mon, 17 Apr 2023 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681751635; x=1684343635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrftNEs2qOSwWl03Nchn5scIv7SNUtGLtjGhEsWIfMQ=;
        b=qtIQZkmtv2I5Fl9ovw3w81fAHC9Tp9f8hcIBskUhz4aPj9VVWHOzzGs7Npi7F2LpL0
         badLBN5o3fBh4PcNaW56+ghzNXq40fvukcHMMu1AT6ZQMvQW/WZrGNqJl8NncBg37H8D
         LdLtSGW97jOefI4Zk4wJN0N0xlHeItmerK3zrqmHT4ZJfnx7e1CaSZR0yUl9YyJWJ656
         j+uytAPX+8cBNS3PMN/kO0eap/6rM2/lYCE6cxmKMpAYZ8ghLoh/gvqwaxSq9VXgiZkY
         DXWoTtp+jOp321J8v9QoHWSyFzy31BR6Fs+mQJXOWBKOgUQH42RAfKxPFLaqF07/FPln
         +ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681751635; x=1684343635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrftNEs2qOSwWl03Nchn5scIv7SNUtGLtjGhEsWIfMQ=;
        b=eGcTKfAWHBFBtwkcyPFtZ6ghvMJ/M6TnGjFSbVY388iwWby0gVK78Y5EgRMezG9+jM
         Tr6RngdeomlAsx6wsRzaG3MYR3bkU3uQHCvBoQz9iYSBSam4ODMA11Al0Gi377ggPA68
         hcHATkn2VttFeAl7XPiANN/0lLvL0JC+OhEKsjXtCsxp9o9abvrtIu5vGCXARFpdPnTM
         E91oAG48CRIUQHMcql9vcSvmikeHhsZt4MIUZBbqB4b1qV5WE5kNgl0v1vAUOhaLfoGM
         t4gx2ysUHJmcg0Y+CbXsLLwBqjq/QISS5hiewqu0Lrfcr8fm2/iVCxEYLR711+C2JliO
         r5qg==
X-Gm-Message-State: AAQBX9fqZ3LR0OfL2BRpYXV1iewE/tmYSwvvLwmDkVZMSMKcVxFHJWSF
        B4hsfek1JRqWD6Y905nZlP+Xwye+ajkQQqgVj3RCbsTTKVE=
X-Google-Smtp-Source: AKy350b8EuFkknWtPCx3RXxKeq2wJ/oKOALz7EFbhNKaaES23ijMCaFMMchAzssbqWnWvYhxbRc2iMxMI0ESgEDiD4g=
X-Received: by 2002:a92:2906:0:b0:329:5faf:cbc0 with SMTP id
 l6-20020a922906000000b003295fafcbc0mr6372058ilg.2.1681751635408; Mon, 17 Apr
 2023 10:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230417160148.60011-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20230417160148.60011-1-n.zhandarovich@fintech.ru>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Mon, 17 Apr 2023 10:13:43 -0700
Message-ID: <CAF8JNh+Ba1SNT5JFy3EGAAtcfZdRYcQ_M4LtQoV0H0dViFyGcw@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: avoid integer overflow in wacom_intuos_inout()
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
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

On Mon, Apr 17, 2023 at 9:03=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> If high bit is set to 1 in ((data[3] & 0x0f << 28), after all arithmetic
> operations and integer promotions are done, high bits in
> wacom->serial[idx] will be filled with 1s as well.
> Avoid this, albeit unlikely, issue by specifying left operand's __u64
> type for the right operand.

Thank you Nikita for the fix! It's good to avoid potential issues.

> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: 3bea733ab212 ("USB: wacom tablet driver reorganization")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Cc: stable@vger.kernel.org

Cheers,
Ping
> ---
>  drivers/hid/wacom_wac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 9312d611db8e..0e4404f3801e 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -826,7 +826,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom=
)
>         /* Enter report */
>         if ((data[1] & 0xfc) =3D=3D 0xc0) {
>                 /* serial number of the tool */
> -               wacom->serial[idx] =3D ((data[3] & 0x0f) << 28) +
> +               wacom->serial[idx] =3D ((__u64)(data[3] & 0x0f) << 28) +
>                         (data[4] << 20) + (data[5] << 12) +
>                         (data[6] << 4) + (data[7] >> 4);
>
> --
> 2.25.1
>
