Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570D0668473
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbjALUxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A679DEB1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:26:12 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c9so14652214pfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I1a5Jj4LhArw7C+veD1AJXimxs0gBRN9QYGmaPZZepQ=;
        b=LcnxElzta+l75Ylsdgk5tzeX0fCoTfPkGseZ5j2bomhev4jeAdUsp6vHBChkB8yoly
         Bf6lkv4WYdJ/5DC1BctbcuHJDw2GAANme9nc1SVk3IavR3GOJIdjf34BMl0Vlg/9S0Yq
         rkDBtZnGuHshIQm9AXgy7ckOqphAzjf1Z+63xGS9Osh3IYHAQT6qORpwS4srH3mADQ2u
         DIukaRwB1cIiYyGscj+Z2bLeA29CKYSEtiIWnTTtHoZdXEKPj59GyGWv2mZZ1uviEp45
         aZjic2wb7Xke4T4BrWd2NQcwcv9XLRSpA0ipWAgzlrZ0HZ39vMU5G/osPKCs7M8JpIKe
         TuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1a5Jj4LhArw7C+veD1AJXimxs0gBRN9QYGmaPZZepQ=;
        b=UKgiKJh5/S2Y3bWI4e/INF7gCreoALz9CwLvkn2tVZZbIhha3NU8XKTqLMJOmj8OLM
         ZIJSoRQAaPRgfr97v9NKqHoPuqpTgVC0IBNw1JNzBhd2F0ReHvF69KZWVo2sOnMxFzv1
         XRftZv3Xmyornm/B/TpbOw8aWiOxtSLe9A43md/ETPvZAJFRrgvhkchmeZPW//KV5NoZ
         Fbb9DVBkEcPX/KP8idKNswl7yAfPvSKe6cJ1CU5a6Bm8kJh1PrnfNbXPDX8oNajGKfzK
         Q6u7FFTEOP5EIJaItrhLoRxxw7rACM49tv7T5GsDt71zTLFsK7JXSQ48+FSQ9ugASPaQ
         UARA==
X-Gm-Message-State: AFqh2kqRHci8j6dL5x58jCIBw2phTTZ1vOEeuHHdE1wGE+GTCnSymRtI
        0/8ui0vsGQo+mapE5RSeuyFLSREYS/c9P4qa67GNUEq/sNvwJoA=
X-Google-Smtp-Source: AMrXdXtLHfrPEbNBMn076Vm8h0lZ3DMfIQaIwVz1OKoIMpwXxm+yfgf+J4Mwtwe+0AIs9jvRvcUv83kG4AJ/KIY4qsk=
X-Received: by 2002:a62:158f:0:b0:588:e66e:4f05 with SMTP id
 137-20020a62158f000000b00588e66e4f05mr1348955pfv.23.1673555171377; Thu, 12
 Jan 2023 12:26:11 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-3-casey@schaufler-ca.com> <CAHC9VhTaySsuvkj0U9Jbp405+WoRfhtq+ib5ynO-a9BeM+a5Ew@mail.gmail.com>
 <c1acc2ed-d188-6560-4554-e6e37d47d06d@schaufler-ca.com>
In-Reply-To: <c1acc2ed-d188-6560-4554-e6e37d47d06d@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Jan 2023 15:26:00 -0500
Message-ID: <CAHC9VhSZ50nbrFJsxKYstVJMekDK6D4tS=Ddz29EUQe55ZQvKQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] LSM: Maintain a table of LSM attribute data
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 7:36 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/11/2023 1:01 PM, Paul Moore wrote:
> > On Mon, Jan 9, 2023 at 1:07 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> As LSMs are registered add their lsm_id pointers to a table.
> >> This will be used later for attribute reporting.
> >>
> >> Determine the number of possible security modules based on
> >> their respective CONFIG options. This allows the number to be
> >> known at build time. This allows data structures and tables
> >> to use the constant.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/security.h |  2 ++
> >>  security/security.c      | 44 +++++++++++++++++++++++++++++++++-------
> >>  2 files changed, 39 insertions(+), 7 deletions(-)

...

> >> diff --git a/security/security.c b/security/security.c
> >> index 07a8fe7f92bf..a590fa98ddd6 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -388,7 +408,7 @@ static void __init ordered_lsm_init(void)
> >>         for (lsm = ordered_lsms; *lsm; lsm++)
> >>                 initialize_lsm(*lsm);
> >>
> >> -       kfree(ordered_lsms);
> >> +       init_debug("lsm count            = %d\n", lsm_active_cnt);
> >>  }
> > Given 86ef3c735ec8 ("LSM: Better reporting of actual LSMs at boot"),
> > is this needed?
>
> None of what comes out from lsm.debug is strictly necessary, and
> human or script can parse "initializing lsm=", but sometimes the
> number of LSMs is interesting.

I guess what I was questioning is if printing the @lsm_active_cnt
variable provides any better information that what is already provided
by commit 86ef3c735ec8?  We currently print the enabled/active LSMs
with lsm.debug, printing a count seems a bit redundant to me.

-- 
paul-moore.com
