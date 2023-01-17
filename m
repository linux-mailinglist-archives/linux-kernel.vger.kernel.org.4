Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408EC66E7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjAQUsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjAQUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:37:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B79442C0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:22:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c6so34579567pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V0qcABF+rC2+wypY9Co8ogyd9bMie1DG0YXrqCGR92M=;
        b=jQ9R9GO6CcL14A488fdRl0hUZC+f54CPIRgkg9E2CCgREegJcouLOr1z7BUrh8BwMF
         WYSKkwE48/wbtZz/bimn1F6f+bRfr3uQZ5mKXzhWeKdYDwcTRGpvvL5D923glniNz32f
         MCR5oZaSIULnOnsKBCs/q6pHMheyvzt9FSTXyU4p2eBISjB68RQW3IBdkWsDM972bxLq
         DRIaYNQfteFoi6a9JND1UT5WzUggyBjjwqL9keEN1cIUcV5HbbqWafukgTWZZg0notCs
         dAohn7ZovOOl3arn/j/o9pwP6KpY4G6Et+mPf7AcWTlJDsONluMg+owroNlRQ2uUzQQn
         phSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0qcABF+rC2+wypY9Co8ogyd9bMie1DG0YXrqCGR92M=;
        b=eINupnGndrfvgsaCmW7i55AlZnYtI8dfSk8grJwIdFnQs/igI2LHzKzF+DSKqiYyaa
         R1CsXZNnywi0FFKCCC+6Euwygpbvi3/DCH3M1FPzFHZkoEIq0SIgrt5HFe+RefT5CgC2
         IFhB9uIFfpYnMHv442s1QtT7hq2xwNqZvROHMfJXMRNDu5grphl9L4w+9JGMwdAJ7Hvy
         N2wGugXspEP5RuQvmGacm0AbMCsHygIwBD+6M1nvTE32oy5Ndj0ihB0VvJ01nSHIXRdQ
         M9lOXPCRYFP+AQN3DTsfNTMVSEaDUodi6oMwTwqrXTqc6ZTo/yIcv79ZBYxVI4vnIBnQ
         NLFw==
X-Gm-Message-State: AFqh2kqSaH4ukuryGCSYpqedlPLmdbHSEbtDcXIPg71al+1R6LoVVx+q
        r7vcjw4fGi07V8VTzsnSmtpgFA2+DO3uHBma75KpxA==
X-Google-Smtp-Source: AMrXdXsATbyHIe7ZlH83NjP1r0fhxSqw0ijai8PbLlQzO/fEUf9l3lua68zv5B61GkcM9Xvp5pZkzS9SForTOUpSijM=
X-Received: by 2002:a17:90b:48d0:b0:226:b5f4:d420 with SMTP id
 li16-20020a17090b48d000b00226b5f4d420mr471440pjb.102.1673983327042; Tue, 17
 Jan 2023 11:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20230114170113.3985630-1-trix@redhat.com>
In-Reply-To: <20230114170113.3985630-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Jan 2023 11:21:55 -0800
Message-ID: <CAKwvOdk=3GrWN_h41nPi_TKgw1uwB2twaV38B+Fj_paVuZ2nxw@mail.gmail.com>
Subject: Re: [PATCH] paride/pcd: return earlier when an error happens in pcd_atapi()
To:     Tom Rix <trix@redhat.com>
Cc:     tim@cyberelk.net, axboe@kernel.dk, nathan@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 9:01 AM Tom Rix <trix@redhat.com> wrote:
>
> clang static analysis reports
> drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
>   is a garbage value [core.UndefinedBinaryOperatorResult]
>   tocentry->cdte_ctrl = buffer[5] & 0xf;
>                         ~~~~~~~~~ ^
>
> When the call to pcd_atapi() fails, buffer[] is in an unknown state,
> so return early.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/block/paride/pcd.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
> index a5ab40784119..4524d8880463 100644
> --- a/drivers/block/paride/pcd.c
> +++ b/drivers/block/paride/pcd.c
> @@ -827,12 +827,13 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
>                         char buffer[32];
>                         int r;

Hi Tom, Thanks for the patch!
It looks like `r` is now unused; mind removing that in v2?

Same below.

>
> -                       r = pcd_atapi(cd, cmd, 12, buffer, "read toc header");
> +                       if (pcd_atapi(cd, cmd, 12, buffer, "read toc header"))
> +                               return -EIO;
>
>                         tochdr->cdth_trk0 = buffer[2];
>                         tochdr->cdth_trk1 = buffer[3];
>
> -                       return r ? -EIO : 0;
> +                       return 0;
>                 }
>
>         case CDROMREADTOCENTRY:
> @@ -845,13 +846,13 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
>                         struct cdrom_tocentry *tocentry =
>                             (struct cdrom_tocentry *) arg;
>                         unsigned char buffer[32];
> -                       int r;

^

>
>                         cmd[1] =
>                             (tocentry->cdte_format == CDROM_MSF ? 0x02 : 0);
>                         cmd[6] = tocentry->cdte_track;
>
> -                       r = pcd_atapi(cd, cmd, 12, buffer, "read toc entry");
> +                       if (pcd_atapi(cd, cmd, 12, buffer, "read toc entry"))
> +                               return -EIO;
>
>                         tocentry->cdte_ctrl = buffer[5] & 0xf;
>                         tocentry->cdte_adr = buffer[5] >> 4;
> @@ -866,7 +867,7 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void
>                                     (((((buffer[8] << 8) + buffer[9]) << 8)
>                                       + buffer[10]) << 8) + buffer[11];
>
> -                       return r ? -EIO : 0;
> +                       return 0;
>                 }
>
>         default:
> --
> 2.27.0
>
>


-- 
Thanks,
~Nick Desaulniers
