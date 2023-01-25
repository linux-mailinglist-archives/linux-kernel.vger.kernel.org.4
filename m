Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C120767B5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbjAYP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjAYP1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:27:11 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ACA367CF;
        Wed, 25 Jan 2023 07:27:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j17so14065208wms.0;
        Wed, 25 Jan 2023 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKNvukrUZVkfJrcLs35cGJYgMdjcalP+BqI+yH4alAs=;
        b=PTCB9nDDuMHNEDQSJWfrYIQAO0gqzMZqtftPkaxooVDP22osj39QfBR1m5uQH5XpGP
         0Zwj9clLcSJWUrbt4X1Uqb8KNGkMDuB9a/c5ck/0hQ4owznKASqVH60nkmkzeP/N+r3Q
         ftIGL/PWngiSHBVbO05D47KHoZz2mCamhvp+K3SvRPitlNaY0ixRY6njdKVRwZ4fw4wq
         Rwilhm1LgkNwLjYfVjJrHbwft7veb50uf9TfNgB/zH19WrqIwnxR/rxlaCZUAmSLdavV
         41lH6nUKLpKpzDQZxjAuhy05e2K9kUyC63qeiMV8azz0Yw4aHdml4n3pEgJnYcMJkbry
         MYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKNvukrUZVkfJrcLs35cGJYgMdjcalP+BqI+yH4alAs=;
        b=I9MWgBf97WncaM6WfnWAYhr4NqnxkLrzrzipvSDw6zsPCc0hKsJr8aZCLbcj/R19Mq
         JfbwkFrgKwnjwH0jAM5mqBrSgLP2YuWkPDhOa0oZljNoRCA/Eep2M0WSBGffRVcYSPrl
         hxRr7YsAQ950sOEj/rum8yQUV1N08cMJl10dQ3kR+2ZdWsd6S4N83zpzBRkQCLDuRSvc
         VJhfIkEluiLjjmgvnm/Yv0bWoU28LaNfeZhfHi+n+r/6Tz+C5EGVgrRjp44d2nA+vUSZ
         CG63r90aG3csaCRwlJYVc+ip35nosAgVPJZrfhqfwjf7oEkdVgOMANN4NrwrLHMDJgLr
         jHuw==
X-Gm-Message-State: AFqh2kqADK3AjaTwSqhKwO5d6lJwDIiU8QQLq1gSMbaS+ad5Rx1iR94q
        W5OuModxFlbqjEHm+akw5nM=
X-Google-Smtp-Source: AMrXdXt2M+tmqAUcwmI3R665W1S2ANiQS1SHnpB2bomoeMAf3o65vWXBYeRr1w24dRhukh7CO+u6ZA==
X-Received: by 2002:a05:600c:4687:b0:3db:2e06:4091 with SMTP id p7-20020a05600c468700b003db2e064091mr22180602wmo.37.1674660428737;
        Wed, 25 Jan 2023 07:27:08 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm2456161wmq.33.2023.01.25.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 07:27:08 -0800 (PST)
Date:   Wed, 25 Jan 2023 18:27:01 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdeia: ipu3: ipu33-mmu: Replace macro IPU3_ADDR2PTE()
 with a function
Message-ID: <Y9FKRQiiUxCsidhe@kadam>
References: <20230124135554.13787-1-bpappas@pappasbrent.com>
 <Y8/uTYK7qmYD5MSA@kadam>
 <Y9E+dGgQXFUQnIb8@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9E+dGgQXFUQnIb8@pappasbrent.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry, but I don't think this is a worthwhile approach.

If you created a tool to automatically re-write macros as functions,
that's super impressive.  But the choice between using a macro and a
function is just a style debate.  The note in Coding Style is more
talking about complicated macros instead of these simple ones.  And
anyway, when it comes to gray areas in the style guidelines, we
generally defer to the original author because that's who is doing all
the work.

There are some sorts of bugs associated with using macros like Macro
Expansion Precedence Bugs where there isn't parentheses around a macro,
or Double Evaluation Bugs where a parameter is evaluated twice.  But
these sorts of bugs are very rare in the Linux kernel.  Generally kernel
programmers have always been good about this sort of stuff.  Also
checkpatch insists on parentheses.  And it's not like error paths where
the bugs are difficult to find in testing.  Probably we get a macro
bug every three years (compared to uninitialized variable bugs where we
get several per week).  I have a Smatch check for both of these kinds of
macro bugs.

Another kind of bug would be type related bugs, because macros don't
have type checking.  But I think those are caught in testing so they're
extremely rare.  I don't think I have seen a real life example of one of
those.

regards,
dan carpenter

