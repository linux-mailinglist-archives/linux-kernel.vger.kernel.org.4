Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD76729C20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbjFIOBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbjFIOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:01:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B193580
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:01:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f7fc9014fdso13485585e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686319297; x=1688911297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dMKLfxyfO6GRRSI5mpAvE1qLvloyaEdkSgeCZ5iq4U=;
        b=efajulzotRym0OO0p2vBcircrcKWduJ7YSzbFR3qQjOSgZWpb0Qdz/SNKCWOh2A/r2
         yuqugaKknpK0cVzFHNnCL871IVsouSLd//AMkWGTmcWrMkFyPBln0uQNq48HOFFcohA0
         UvRgyNbS7//k8MKCtxeTBP/vglxeQcSK7PESRjA1rkuE/vi2QV+yequ/qNvIaOPcqyAZ
         Ahuo7FryBnT7Fnq1s3gz9cFcOeKXR3aN0mz62KAd5teBCBd7lOtzyJW20IyHFusi0HWu
         HF4RWMN0eG3bwzlUC5RjPBB/AlSFKLc5vO+6yWmszPtGQNuKYeGOSfwIGsW2E+4GBCJ0
         WpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319297; x=1688911297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dMKLfxyfO6GRRSI5mpAvE1qLvloyaEdkSgeCZ5iq4U=;
        b=YGl1n7K5KA/7dU7nEtRdPUeixtFEF+m08UdgdnWvtWhFZhpvuXYD+T9AzTk00DueFr
         7q4ff/PrK568cDRLHVNlS4tvdSCo7zt/pSSlruncvad57k9vNiZWsUrDsHWcvDBqJq2s
         3NcRmTHdxCA2q/rW5l+N0ZRSXDPGTRQf6n05jFTjOs3D52/Hf6KoyY3tnz3lfnX8VtFz
         xh8Ep8/04eYqGo8v4J5MU8kiEAh1SVwbjUaw5W++7a7Dx+1AxDZh140fxhHF/d+eqQsw
         DB1rTb+S9djeTX8ht4JTwQj73J5KbskfDr9xh/SEPX69nGAQesdInN5esWzRGkrOHDy8
         7N2A==
X-Gm-Message-State: AC+VfDykSTbNxEbhUGxl6qvwvDm4IBmYL+H+FiFyrhtHD9Y6HFEzz41k
        ukcubkXU/vK94R18EZrYcYz8Xw==
X-Google-Smtp-Source: ACHHUZ5IGHDLRT/F8ZiBNtbhtA6enQaJjbrsANjPa9s/JYdZAAOsgVsifgcve4BhUYpVZxJAkggcKQ==
X-Received: by 2002:a1c:7c0a:0:b0:3f4:2492:a91f with SMTP id x10-20020a1c7c0a000000b003f42492a91fmr1046811wmc.27.1686319297138;
        Fri, 09 Jun 2023 07:01:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f13-20020a056000036d00b0030aefa3a957sm4568403wrf.28.2023.06.09.07.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:01:35 -0700 (PDT)
Date:   Fri, 9 Jun 2023 17:01:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        keyrings@vger.kernel.org, dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
Message-ID: <c464c4ee-038c-47bf-857a-b11a89680e82@kadam.mountain>
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com>
 <ZH8mhIrjyBvTF4oZ@debian.me>
 <e39efb7f-5d8f-4433-83b3-8eea8a6c0486@kadam.mountain>
 <CT5NH4XXIYQF.5XXJE6JA5FZP@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CT5NH4XXIYQF.5XXJE6JA5FZP@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 05:51:09PM +0300, Jarkko Sakkinen wrote:
> It's not a "punishment". It's more like that I really have to take the
> time to read the prose...

The thing about imperative tense is that it was used as a punishment on
me once five years ago.  I wrote a quite bad commit message and a senior
maintainer told me to re-write it properly and I realized that it was
true.  My commit message was bad.  So I wrote a proper commit message.
And then he yelled at me, "Can't you follow simple directions and write
it in imperative tense like the documentation says?  Are you a
shithead?"

So then I swore I would never talk to him again or to anyone who
enforced the imperative tense rule.  That has only happened once in the
intervening years.  I told the maintainer, "Fine.  Re-write the commit
message however you like and give me Reported-by credit."  This was a
cheeky response and it made the maintainer enraged.  I guess he thought
that my boss would force me to fix the bug or something?  I felt bad for
the Intel developer who had to fix my bug instead because I knew that
the maintainer was going to be super angry if he gave me reported-by
credit so I had put him in a bind.  I almost re-wrote the commit message
so that he wouldn't have to deal with that.  Maybe this is how mothers
feel when they try to take abuse from an angry husband instead of
letting their kids suffer.  But I am a bad mother and I left.

My boss would never have forced me to deal with that.  When he left for
a different company he said, "Dan, I'm transitioning and XXX is taking
over me and I have told him all your weirdness so he is prepared."  And
it was a huge comfort to me because I know what my weakness are.

You people on this thread all seem super nice.  And you're right that we
should always try to be improve every aspect of our craft.

When Jarkko talked about people who write too long commit messages, I
thought about one developer in particular who writes too long commit
messages.  He writes in imperative tense.  He takes everything so
seriously and he's never seen a rule without following it.  His patches
are always right.  People have told him that his commit messages are bad
and too long and those people are right.  But they need to shut up.  The
good things that he does and the bad things that he does are all part of
the same package.  He can't change and I don't want him to feel anything
but welcome.

It's hard to be a good kernel developer without being at least slightly
obsessive.  Both developers and maintainers are that way.  And I deal
with a lot of people and accomodating maintainers you disagree with is
part of the job.

So long as everyone is kind to each other.  That's the main thing.

regards,
dan carpenter
