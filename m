Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE596A02F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjBWGto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjBWGtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:49:43 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E608D1EFF5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:49:41 -0800 (PST)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 41D203F192
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677134979;
        bh=QpPuGHqBkC6q1Q3QpZCOPa/joEa4UuaREJkyAc1I2i4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FpUecrdT/g/HR8qxZUOslh+oR3oR+d0V2x+ZFGe80pyUYT5NWxcmEqVk/m6wVCJKN
         aBX/d197Hp0cqJU9IAQrazcLio/XUQjuNp7RWipxJ3oGSopdHQejfqylmTFKDgpLGF
         a41FTcnIjBOqqng7rJyEa5YQoOMdBIEwqpX7GeSyRv6wgnw1G7dRUvnYj37U+I4tBM
         YpZGeJlcdyHmAY7529JLvNOdJ5hDV7dfX92V6ltpLPv3CMuuVWb35EzwA0JSi4entz
         dlFihBzWZUZ49hvaGqTJcfAwVyuYIUkyp2MBaIDQQY1DbUGdGVZmSa5U5WlIaUNlpv
         IVRP/fs80QyFQ==
Received: by mail-oi1-f199.google.com with SMTP id p6-20020acad806000000b0037890be175fso3951417oig.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpPuGHqBkC6q1Q3QpZCOPa/joEa4UuaREJkyAc1I2i4=;
        b=4PiOpGR/IcxfeUCVbeSKJ6Yi3ujmhVz4Mwyl6Drfj4r0iPFE2b0khQM6NRkj5FUTA5
         evyiG4qDQYCWjsd4dfFm/08nChaFFqKrpCAVlzcnFuSuuyOtSkhk6yb5ES4WuixXAcjx
         aqgLapK9fW1PtpWYXhDv/d0VkhWOBYVBovLcbxxaz6KKWVG2wt0oEkH6dLqimLTfY1GT
         c+Acql8Obv3G1T5QRn1DnEnAWiZLEAe/wKap3KeqA4SMkL1Sl3H/MnLlJPPmjy/vUc7n
         raIU6VnOs1ie5iqHzMt7c13mppwozeNINEvFWKzgEohzrH1uFw4ZgN65mQ46ebLDitRq
         p6sw==
X-Gm-Message-State: AO0yUKVeZXeYnPEs+ezMgOpV0JbHwD+Ds4YeDBVd2zq12Xz1+jS2zj2v
        0vEoZll4pCTncW9HrDI3SP03HD2BDcurBJQ0DL5cNkAxHOCfCsJhp9u1WSgJtjkYVnh+xNEVnSE
        HaAx73WOTsCAolWrdlknJiRKGX4pVeGJ9K9XQMZLCirp3aRN3Hxt2vvMQAA==
X-Received: by 2002:a05:6808:f8f:b0:37d:78ff:da48 with SMTP id o15-20020a0568080f8f00b0037d78ffda48mr1242380oiw.30.1677134978105;
        Wed, 22 Feb 2023 22:49:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+/9hGeDOpTfSiGHp3vcU1n7L2sX9So/79lz+m3NIfCvtGIw9AO5wb7KNH9GoNRY0DgZXJ/pr85kX3vUwZzk1o=
X-Received: by 2002:a05:6808:f8f:b0:37d:78ff:da48 with SMTP id
 o15-20020a0568080f8f00b0037d78ffda48mr1242370oiw.30.1677134977857; Wed, 22
 Feb 2023 22:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20230223013032.2011601-1-kai.heng.feng@canonical.com> <07827f74-0c63-259c-37ff-86905c496b71@amd.com>
In-Reply-To: <07827f74-0c63-259c-37ff-86905c496b71@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 23 Feb 2023 14:49:26 +0800
Message-ID: <CAAd53p52AkTLcuytA=hPCeQze_NRU0amLjc7eZq3+-0YahwGJw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: Let user know amd-pstate is disabled
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     ray.huang@amd.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 1:02 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 2/22/23 19:30, Kai-Heng Feng wrote:
> > Commit 202e683df37c ("cpufreq: amd-pstate: add amd-pstate driver
>
> s/Commit/commit/

I think the first character of the sentence still needs to be capitalized?

>
> > parameter for mode selection") changed the driver to be disabled by
> > default, and this can suprise users.
>
> s/suprise/surprise/

Will change.

>
> >
> > Let users know what happened so they can decide what to do next.
> >
> > BugLink: https://bugs.launchpad.net/bugs/2006942
>
> s/BugLink/Link/
>
> BugLink isn't an official tag, you should use "Link".

Will change.

>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/cpufreq/amd-pstate.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 45c88894fd8e..305f73f657ed 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1263,7 +1263,7 @@ static int __init amd_pstate_init(void)
> >        * with amd_pstate=passive or other modes in kernel command line
> >        */
> >       if (cppc_state == AMD_PSTATE_DISABLE) {
> > -             pr_debug("driver load is disabled, boot with specific mode to enable this\n");
> > +             pr_info("amd_pstate is disabled, boot with specific mode to enable this\n");
>
> The file uses `pr_fmt` so this will show up as `amd_pstate: amd_state is
> disabled`.  That's a bit redundant no?

Will change.

Kai-Heng

>
> >               return -ENODEV;
> >       }
> >
>
