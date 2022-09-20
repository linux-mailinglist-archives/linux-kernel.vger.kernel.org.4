Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7415BE2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiITKWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiITKWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425F6F545
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663669316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3i+0gqrQGBQWhldO2Pvgxs5eAAnagMoK2WnxgbEYA48=;
        b=PFwd1u3AbqQnnxqvNdcSvLnNwTKm3guoDAbRezZ2sYPD777uD/YvJtC7d3YJ9C+kKWCq8G
        RRbiQbpJiHzu+EyBjIykp2aCcbxG9hgFIx3MMzK9Y9pBIyYpRbgcDieMzvZ8yLHaDjhV0n
        TKuUzv7JFQrliSqW2jCTfixftcdexGw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92-XgiWYGs1Osesg923MLcHGQ-1; Tue, 20 Sep 2022 06:21:55 -0400
X-MC-Unique: XgiWYGs1Osesg923MLcHGQ-1
Received: by mail-pf1-f197.google.com with SMTP id 15-20020a62170f000000b0053e304ef6c0so1472810pfx.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3i+0gqrQGBQWhldO2Pvgxs5eAAnagMoK2WnxgbEYA48=;
        b=JkCixEzoCzyX7dDe0EEsceJPLvnrsZgVFZcnvyRdjLs3os7QkM9Nt160VqMwDKlwGJ
         buA+NrD90Murq7sk1a8bYk3Z4qzNoWB+Yk3AwzAsFBvFksv4VtgEl7NWygjNpAqZ0DSd
         I5dMoRndkEeHPzvKGKaDYDG8PQa21JjFvDhBH3fdm0UadLwXOtPcgdeoAhiHNDR8F9Y7
         0s9gCOEZO90hLDFuPasJZGC09H3NQlmGwat0HaGLk8RY1z+Kfc9XLq3IbVijMB36bVbr
         LOGwlFU54P15JdIeQE4VkOcZwxYVrBszqPm6q+1xINuvKnwdK/fTf4EktDf4+hlza5CP
         eHVA==
X-Gm-Message-State: ACrzQf0jiCpwYzsHtxUyUXUvP0nbbYVsErZFKeJit4PkfqOiYEGYYXrk
        1c7+IlWyEP61VCtRndNF8NkJv/gpSK56Lnm3W1Lfo8QT2+rVl8eJ0rVtumJP1w4meNHxWa9akIv
        gIP7jvGYmoIuUf9RBnYEv9lcHhU8HUbNL9YHcOD3I
X-Received: by 2002:a17:903:120c:b0:172:728a:3b24 with SMTP id l12-20020a170903120c00b00172728a3b24mr4083970plh.61.1663669314786;
        Tue, 20 Sep 2022 03:21:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7sDp1O8OmHEWmZvu4VZ45pvII+B4rRWc1fXEr8CLm1seb69bQyVC3yR+HtMDvXY75rWtRjh+R74unndl3Wxs0=
X-Received: by 2002:a17:903:120c:b0:172:728a:3b24 with SMTP id
 l12-20020a170903120c00b00172728a3b24mr4083945plh.61.1663669314401; Tue, 20
 Sep 2022 03:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <ByMO0BENaLBLEnGGrPwe37i3VDtN-VuRlSHqkdgk7Q1JHQ16bI_S1QuEtqtSdeV0XcwGMZwrAkFEGaEdXN_Z1qaN2r1cFeZnu5TyHMxszIU=@protonmail.com>
In-Reply-To: <ByMO0BENaLBLEnGGrPwe37i3VDtN-VuRlSHqkdgk7Q1JHQ16bI_S1QuEtqtSdeV0XcwGMZwrAkFEGaEdXN_Z1qaN2r1cFeZnu5TyHMxszIU=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 20 Sep 2022 12:21:43 +0200
Message-ID: <CAO-hwJLxTQ6Sq=yHksE1f9sDveAsX88ozhu5Pw4+N+kwHdi8hg@mail.gmail.com>
Subject: Re: [PATCH] HID: nintendo: check analog user calibration for plausibility
To:     Johnothan King <johnothanking@protonmail.com>
Cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 9:51 AM Johnothan King
<johnothanking@protonmail.com> wrote:
>
> Arne Wendt writes:
>   Cheap clone controllers may (falsely) report as having a user
>   calibration for the analog sticks in place, but return
>   wrong/impossible values for the actual calibration data.
>   In the present case at mine, the controller reports having a
>   user calibration in place and successfully executes the read
>   commands. The reported user calibration however is
>   min = center = max = 0.
>
>   This pull request addresses problems of this kind by checking the
>   provided user calibration-data for plausibility (min < center < max)
>   and falling back to the default values if implausible.
>
> I'll note that I was experiencing a crash because of this bug when using
> the GuliKit KingKong 2 controller. The crash manifests as a divide by
> zero error in the kernel logs:
> kernel: divide error: 0000 [#1] PREEMPT SMP NOPTI
>
> Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
> Link: https://github.com/DanielOgorchock/linux/issues/36
> Co-authored-by: Arne Wendt <arne.wendt@tuhh.de>
> Signed-off-by: Johnothan King <johnothanking@protonmail.com>
> ---
>  drivers/hid/hid-nintendo.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 6028af3c3aae..7f287f6a75f5 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -793,7 +793,17 @@ static int joycon_request_calibration(struct joycon_ctlr *ctlr)
>                                             &ctlr->left_stick_cal_x,
>                                             &ctlr->left_stick_cal_y,
>                                             true);
> -       if (ret) {
> +
> +       /*
> +        * Check whether read succeeded and perform plausibility check
> +        * for retrieved values.
> +        */
> +       if (ret ||
> +               ctlr->left_stick_cal_x.min >= ctlr->left_stick_cal_x.center ||
> +               ctlr->left_stick_cal_x.center >= ctlr->left_stick_cal_x.max ||
> +               ctlr->left_stick_cal_y.min >= ctlr->left_stick_cal_y.center ||
> +               ctlr->left_stick_cal_y.center >= ctlr->left_stick_cal_y.max
> +       ) {
>                 hid_warn(ctlr->hdev,
>                          "Failed to read left stick cal, using dflts; e=%d\n",
>                          ret);
> @@ -812,7 +822,17 @@ static int joycon_request_calibration(struct joycon_ctlr *ctlr)
>                                             &ctlr->right_stick_cal_x,
>                                             &ctlr->right_stick_cal_y,
>                                             false);
> -       if (ret) {
> +
> +       /*
> +        * Check whether read succeeded and perform plausibility check
> +        * for retrieved values.
> +        */
> +       if (ret ||
> +               ctlr->right_stick_cal_x.min >= ctlr->right_stick_cal_x.center ||
> +               ctlr->right_stick_cal_x.center >= ctlr->right_stick_cal_x.max ||
> +               ctlr->right_stick_cal_y.min >= ctlr->right_stick_cal_y.center ||
> +               ctlr->right_stick_cal_y.center >= ctlr->right_stick_cal_y.max

Wouldn't it make sense to have a function that takes a single struct
joycon_stick_cal pointer and does the check?
This would make things more readable IMO.

Cheers,
Benjamin

> +       ) {
>                 hid_warn(ctlr->hdev,
>                          "Failed to read right stick cal, using dflts; e=%d\n",
>                          ret);
> --
> 2.37.3
>
>

