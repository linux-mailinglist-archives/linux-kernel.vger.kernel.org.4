Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0062163E9F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiLAGlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiLAGli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:41:38 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AC877405
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:41:37 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id n191so402951vkf.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ORRus/ro4FIyVLQAs/Zz1Z+37Vnb3kGYqJp0YKLyVc8=;
        b=ozPGcKusnW7rTsIrfvE7H+v7AiVI8+/BAg9bAQlefF2PRdN6TwUnAfGP3f6VPYOdmu
         IDowWN8o9eJXDTZPZ213/YN1F3FOI+KdMyHNZ0qDvsS6JUkGzbpNtjcFbPonQv2K/beJ
         veAp975HT2AEFLlc3uILNBOo+SNEI6AS9nihq/V66zU/9k4vEKftRhjy1q65zgy59aBD
         r5tUxgQXndF/QEu5SLwQV8EL3AK4HmrfgV/LrwYSIhN6H/WPIhsH6SzuMOxfeU72dk4W
         /NOTIYPZbcE1iCaV6std23k8HXs3Z83iajNPIiZP8sTvni152nEITBCohO4zrRnXR/i+
         yW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORRus/ro4FIyVLQAs/Zz1Z+37Vnb3kGYqJp0YKLyVc8=;
        b=baCY5U5U0gsYxtQ49pHFtpPkc3x74gq0X+9BEb0XEhMeWyZfXNOC+cUC05dHX0akeE
         gV/YKjp8FC8Ppxr68Kl51W4ShtrYwVJhGs4OoP/g/4MjybUCGd+/lU/4hrHIlJUEzbVh
         rjisDoL+IFTrTm7KVVS6GjJaVi55OWBsD06rPvD/tivVocPM2wY6/58xXcKDt7QpK4pL
         pC0KN24ZKuXFzfMAmVv29+S5vT9eL0Bsh6VhcQZ13ng2XagdWDUnQErehO5O2uUccMdZ
         cxVLnfV6Mcwu5rYPra8tvr0VijKK5h/D5RS1Q4J5KYz63ZFRMr5m6EYUaoajRO9qHHC8
         e5NA==
X-Gm-Message-State: ANoB5pnBBbYyF0IomImcG75EV8w3TcI5uvNmOruTFFicQfd66cjz7XQW
        /SyZJHUhnNCuXuEQ5FzXIi2TqHJXg8g8xefVoZwXFQ==
X-Google-Smtp-Source: AA0mqf541NigviDqLoiF6INf2Z2gKtvGceTfjMGBF93ndRKDKSIn1QkCrX/zRVaeFBUJC6Mos7A6sUzD/94b8KaOEBg=
X-Received: by 2002:a1f:62c1:0:b0:3bd:32cc:975 with SMTP id
 w184-20020a1f62c1000000b003bd32cc0975mr2808876vkb.36.1669876896228; Wed, 30
 Nov 2022 22:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20220704014046.34596-1-haibo.li@mediatek.com> <Ysx39t+I56lDGe4i@google.com>
In-Reply-To: <Ysx39t+I56lDGe4i@google.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Thu, 1 Dec 2022 14:41:25 +0800
Message-ID: <CAMSo37WGWLuP64LGOth4s+hXuN_1mEBwEGz+i6L7HxryF56eZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cfi: free old cfi shadow asynchronously
To:     Sami Tolvanen <samitolvanen@google.com>,
        Haibo Li <haibo.li@mediatek.com>
Cc:     xiaoming.yu@mediatek.com, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Aaron Tomlin <atomlin@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Haibo, Sami

Thanks for the changes here!

With the Linaro LKFT project[1], we noticed there is about 5 seconds
boottime improvement for the 5.15 kernel Android builds.
And after some investigation, we found it's these changes
made the improvement.
And I'd like to share one of the test results here for your information:

====>>> data started here
 Linux 5.15: 5.15-gki-android13-aosp-master-rb5-boottime
    boottime:
    Index Build Number boottime-fresh-install#KERNEL_BOOT_TIME_avg
boottime-fresh-install#ANDROID_BOOT_TIME_avg
boottime-fresh-install#TOTAL_BOOT_TIME_avg
boottime-reboot#KERNEL_BOOT_TIME_avg
boottime-reboot#ANDROID_BOOT_TIME_avg
boottime-reboot#TOTAL_BOOT_TIME_avg
    1 5.15.41-aec224bb9ebc 1.6 37.19 38.79 1.61 30.14 31.75
    2 5.15.41-c2162eca3f66 1.62 36.92 38.53 1.62 30.04 31.66
    3 5.15.41-e796ee569574 1.62 37.27 38.89 1.62 30.01 31.62
    4 5.15.41-432cf292eb20 1.62 41.64 43.26 1.61 35.16 36.76
    5 5.15.41-a3829998513a 1.62 42.2 43.82 1.61 35.4 37.01
<<<==== data ended here

# the improvements started from build#5.15.41-e796ee569574 since these
changes were submitted to the ACK[3]
# the unit of the data is seconds
# boottime-fresh items are data for the first time boot after deployment
# boottime-reboot items are the average data for the 2nd ~ 7th data
with the minimum and maximum excluded.
# for the meaning of
KERNEL_BOOT_TIME/ANDROID_BOOT_TIME/TOTAL_BOOT_TIME please see the
description here[2]

[1]: https://source.android.com/docs/core/architecture/kernel/android-common?hl=en#linaro-kernel-functional-testing
[2]: https://github.com/Linaro/test-definitions/blob/master/automated/android/boottime/device-script.sh
[3]: https://android-review.googlesource.com/q/I08dcb29ef97453b836efd0d64286196600be8cce

Thanks,
Yongqin Liu

On Tue, 12 Jul 2022 at 03:20, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Mon, Jul 04, 2022 at 09:40:44AM +0800, Haibo Li wrote:
> > This patchset changes synchronize_rcu to call_rcu in update_shadow.
> >
> > Patch 1 enables the CFI sanitization for cfi.c and
> > bypass __cfi_slowpath_diag.
> > It is the prerequisite for using call_rcu in cfi.c.
> >
> > Patch 2 changes synchronize_rcu to call_rcu and
> > free old cfi shadow in rcu cb
> >
> > Changes in v2:
> >  - Remove _run_cfi_check,add __nocfi to __cfi_slowpath_diag directly
> >  - Rename _cfi_shadow_free_rcu to free_shadow
> >
> > Haibo Li (2):
> >   cfi: enable sanitize for cfi.c
> >   cfi: free old cfi shadow asynchronously
> >
> >  kernel/Makefile |  3 ---
> >  kernel/cfi.c    | 14 +++++++++++---
> >  2 files changed, 11 insertions(+), 6 deletions(-)
>
> Thanks for sending v2! For the series:
>
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
>
> Sami



-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
