Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E12B5BFE03
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIUMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIUMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F83E8B2E5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663763722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WBzCpJXjGzNS/0as+VEExYirQKKMOXTS/WQUrRMrrm4=;
        b=JsTNRcr3Idn2KcaqGm1bg0VLVBCgfVhLaTlxYfeISmoj8HcA1/pwXX5REKyQ39O7OqqM9V
        8il6NEkVve3tcR7Y660s/B/x5jxcuLrzA+w2sftLWHOeB8hbKi4NLZ9tSS3epIMlOBtN1b
        meW0euaPsYwHBaN3pYgvgqjfOm8mGDo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-Y98GJyaUM86B_5kah5X8qw-1; Wed, 21 Sep 2022 08:35:21 -0400
X-MC-Unique: Y98GJyaUM86B_5kah5X8qw-1
Received: by mail-io1-f72.google.com with SMTP id h205-20020a6bb7d6000000b006a1e6bef9c7so2954349iof.17
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WBzCpJXjGzNS/0as+VEExYirQKKMOXTS/WQUrRMrrm4=;
        b=w4jO4HkNCgc8vHWJzUHxPYA8bnb1kSUpC9NVHId3SBfP2wxolAxtwLN2Vixys0QsIE
         eUauvcThzWcc+DPq1VVXhN27zA8jmFOfSWq51pOilvH2jomPQJajcYsGYods7w2+v4lK
         TeesL9QPs0RBoyz7YLt6mMnWYNIm1AB1yiUJGANlZfyvxi5CQ7U/BW/vKRcDnB98RHpf
         Nj4XRE5R5BPwhrRny/pO3ZBZcHcc3j2vwApUoY37hAu9FByMkSvuQuvy59MbXlbVtpKP
         Q9T9LAyCRFrrxpxka857zMe+JBdwRWQRXVkmv5qR/m6Avz7ZAneSjeu07ys/1J39W2Iq
         znqA==
X-Gm-Message-State: ACrzQf2pX8FyHGa2ztDNWLgYS33kSY9H6Iqml8lkP3ABmMLFihgUeXwS
        PC3cEnZebg+kb++f2t8TXt/gxeBBnmZGAih9RFGZDvtFbKI2RVFB1LPIGS4dRnfzQemJJdxGU5j
        FwX02J3BL28Y/imm+BbviYxVa4Ptu4pZ90fF3G+Lh
X-Received: by 2002:a05:6e02:1a6b:b0:2f1:a7c9:ea2e with SMTP id w11-20020a056e021a6b00b002f1a7c9ea2emr11688873ilv.176.1663763720518;
        Wed, 21 Sep 2022 05:35:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54oIjz7+HgMHXoN4N41EJYhjR4/Sk/sh9XK47YEXjIXjjx/h67gZuKoeorhbnTQmCS1XbMst3E54swinbklAE=
X-Received: by 2002:a05:6e02:1a6b:b0:2f1:a7c9:ea2e with SMTP id
 w11-20020a056e021a6b00b002f1a7c9ea2emr11688862ilv.176.1663763720287; Wed, 21
 Sep 2022 05:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <gvpL2G6VwXGJPvxX5KRiu9pVjvTivgayug_jdKDY6zfuAaAqncP9BkKLosjwUXNlgVVTMfJSKfwPF1K79cKAkwGComyC21vCV3q9B3EXNkE=@protonmail.com>
In-Reply-To: <gvpL2G6VwXGJPvxX5KRiu9pVjvTivgayug_jdKDY6zfuAaAqncP9BkKLosjwUXNlgVVTMfJSKfwPF1K79cKAkwGComyC21vCV3q9B3EXNkE=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 21 Sep 2022 14:35:09 +0200
Message-ID: <CAO-hwJ+gCVPv2zoQtyA-535sGDyvqNQ8gfmpySQGJnmUhmFyQg@mail.gmail.com>
Subject: Re: [PATCH v4] HID: nintendo: check analog user calibration for plausibility
To:     Johnothan King <johnothanking@protonmail.com>
Cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 12:56 PM Johnothan King
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

Thanks for the quick v4.

Daniel, I applied it without your rev-by. I think we are close enough
to what you reviewed previously. The only thing though is that I just
realized I lost your rev-by from v2. If you really want it, I can
probably force push the patch.

Anyway, applied to for-6.1/nintendo in hid.git.

Cheers,
Benjamin

> Changes in v2:
>  - Move the plausibility check to joycon_read_stick_calibration() and
>    have that function return -EINVAL if the check fails.
>  - In the plausibility check, change >= to ==. hid_field_extract() never
>    returns a negative value, so a scenario involving min > center or
>    center > max is impossible.
>  - To reduce code duplication, move the code for setting default
>    calibration values into a single function called
>    joycon_use_default_calibration().
>
> Changes in v3:
>  - Unbreak warning string to conform to coding style.
>  - Change joycon_use_default_calibration() to accept a struct hid_device
>    pointer instead of a struct joycon_ctlr pointer.
>
> Changes in v4:
>  - Reformat joycon_use_default_calibration() another time to move stick
>    and ret onto the same line.
>  - Revert == to >= change to account for rollover.
>  - Additional minor change to comment for value check.
>
>  drivers/hid/hid-nintendo.c | 55 +++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 5cb5a1d53b71..71e2a9a0882a 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -760,12 +760,31 @@ static int joycon_read_stick_calibration(struct joycon_ctlr *ctlr, u16 cal_addr,
>         cal_y->max = cal_y->center + y_max_above;
>         cal_y->min = cal_y->center - y_min_below;
>
> -       return 0;
> +       /* check if calibration values are plausible */
> +       if (cal_x->min >= cal_x->center || cal_x->center >= cal_x->max ||
> +           cal_y->min >= cal_y->center || cal_y->center >= cal_y->max)
> +               ret = -EINVAL;
> +
> +       return ret;
>  }
>
>  static const u16 DFLT_STICK_CAL_CEN = 2000;
>  static const u16 DFLT_STICK_CAL_MAX = 3500;
>  static const u16 DFLT_STICK_CAL_MIN = 500;
> +static void joycon_use_default_calibration(struct hid_device *hdev,
> +                                          struct joycon_stick_cal *cal_x,
> +                                          struct joycon_stick_cal *cal_y,
> +                                          const char *stick, int ret)
> +{
> +       hid_warn(hdev,
> +                "Failed to read %s stick cal, using defaults; e=%d\n",
> +                stick, ret);
> +
> +       cal_x->center = cal_y->center = DFLT_STICK_CAL_CEN;
> +       cal_x->max = cal_y->max = DFLT_STICK_CAL_MAX;
> +       cal_x->min = cal_y->min = DFLT_STICK_CAL_MIN;
> +}
> +
>  static int joycon_request_calibration(struct joycon_ctlr *ctlr)
>  {
>         u16 left_stick_addr = JC_CAL_FCT_DATA_LEFT_ADDR;
> @@ -793,38 +812,24 @@ static int joycon_request_calibration(struct joycon_ctlr *ctlr)
>                                             &ctlr->left_stick_cal_x,
>                                             &ctlr->left_stick_cal_y,
>                                             true);
> -       if (ret) {
> -               hid_warn(ctlr->hdev,
> -                        "Failed to read left stick cal, using dflts; e=%d\n",
> -                        ret);
> -
> -               ctlr->left_stick_cal_x.center = DFLT_STICK_CAL_CEN;
> -               ctlr->left_stick_cal_x.max = DFLT_STICK_CAL_MAX;
> -               ctlr->left_stick_cal_x.min = DFLT_STICK_CAL_MIN;
>
> -               ctlr->left_stick_cal_y.center = DFLT_STICK_CAL_CEN;
> -               ctlr->left_stick_cal_y.max = DFLT_STICK_CAL_MAX;
> -               ctlr->left_stick_cal_y.min = DFLT_STICK_CAL_MIN;
> -       }
> +       if (ret)
> +               joycon_use_default_calibration(ctlr->hdev,
> +                                              &ctlr->left_stick_cal_x,
> +                                              &ctlr->left_stick_cal_y,
> +                                              "left", ret);
>
>         /* read the right stick calibration data */
>         ret = joycon_read_stick_calibration(ctlr, right_stick_addr,
>                                             &ctlr->right_stick_cal_x,
>                                             &ctlr->right_stick_cal_y,
>                                             false);
> -       if (ret) {
> -               hid_warn(ctlr->hdev,
> -                        "Failed to read right stick cal, using dflts; e=%d\n",
> -                        ret);
> -
> -               ctlr->right_stick_cal_x.center = DFLT_STICK_CAL_CEN;
> -               ctlr->right_stick_cal_x.max = DFLT_STICK_CAL_MAX;
> -               ctlr->right_stick_cal_x.min = DFLT_STICK_CAL_MIN;
>
> -               ctlr->right_stick_cal_y.center = DFLT_STICK_CAL_CEN;
> -               ctlr->right_stick_cal_y.max = DFLT_STICK_CAL_MAX;
> -               ctlr->right_stick_cal_y.min = DFLT_STICK_CAL_MIN;
> -       }
> +       if (ret)
> +               joycon_use_default_calibration(ctlr->hdev,
> +                                              &ctlr->right_stick_cal_x,
> +                                              &ctlr->right_stick_cal_y,
> +                                              "right", ret);
>
>         hid_dbg(ctlr->hdev, "calibration:\n"
>                             "l_x_c=%d l_x_max=%d l_x_min=%d\n"
> --
> 2.37.3
>
>

