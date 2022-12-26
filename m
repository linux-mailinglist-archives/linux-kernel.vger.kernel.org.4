Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1792C656544
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiLZWI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLZWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:08:56 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63101096
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:08:51 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1447c7aa004so13727012fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSRAcp/+vJ+stR2//JCMbf9aGRi8bTCB9Xeja1CXz40=;
        b=CwkDcBDKw9mYk5UemioFkEisPiN5sfISrOXhkMTjvyDcXrTAiDjS44CSG/KbW/TBbx
         Yxny4jSEZXoweaIOw4BRuJbggPf17unALEH/bQf2eadh95PjNOfo8ySrns0AEJVIgkbz
         JXte9gldub1QzNPMmsK8ABjZoJJv6mUkLDzCrrxaVSf7eFhNE4tIvsEO0eoXdWmDgcD1
         A6WfRf0w9sySp+nS/3Z9bNZswR89OwdhrMhh7GqruuFvq8knv/gd2XPi5muJCiDdk47O
         VgulPgXKuYYhPfh1dgb9z69sFD0vYmOEh1WhPttoFg77kzxxc2Jb3luODGpenbmagHzQ
         pzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSRAcp/+vJ+stR2//JCMbf9aGRi8bTCB9Xeja1CXz40=;
        b=PMUS7BeEq0BSE7TgAxAEF/nqET0Jc8+hWVEEFT7+7AQKm95SQ1rPHKYgNL6uYsHpEx
         6AP0RZdNZzwFKrAi8fJPskupa8Tw1OZbj1QfIrSHUaWoY4VifKxG0j3ziTzZTImNG7n6
         OeKGUvO2YaF1rtW/a1Y6AqQPpjhrYvXSo92oZfPtZ1QAqdTYJw+iCjYLBaIbAhqnLSeW
         zkM88+1qDLoZkseUJoIgy0Qx9FY+ZyKPP9U3LgKxucyypyb1ki33r9BkQArPZe2V3TKG
         cwjcbZBddtnEDECwn9sEdtkWinAQLbh/rUgfLxndWi6jVNW6nty1muV+C0KY83Af/pXN
         dTSw==
X-Gm-Message-State: AFqh2kr1XKyZQZxXDqhkhuQNPKL8uqpPygCkgKz7Ap69XlhnUuuYdn4F
        i77UlX1vo8ewyDsNx7dWHjs=
X-Google-Smtp-Source: AMrXdXt4c+BNyxQJMd+9D1AZTWrwDMbwBxP+gPzCSZkko7+CyMY7jyi3jYyLsEUdAVlDaayJxU9H7w==
X-Received: by 2002:a05:6871:4405:b0:144:7a86:ae39 with SMTP id nd5-20020a056871440500b001447a86ae39mr9057620oab.7.1672092531122;
        Mon, 26 Dec 2022 14:08:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o12-20020a4ad48c000000b004d54ff4de54sm1380554oos.2.2022.12.26.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:08:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Dec 2022 14:08:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20221226220848.GA2629353@roeck-us.net>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221226195206.GA2626419@roeck-us.net>
 <CAMo8BfKR2quFYBKmVdgmFfhP0y2jCTwKB7Det9o0a6PYuJkP3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfKR2quFYBKmVdgmFfhP0y2jCTwKB7Det9o0a6PYuJkP3A@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 01:10:40PM -0800, Max Filippov wrote:
> On Mon, Dec 26, 2022 at 12:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > xtensa:allmodconfig
> >
> > Building xtensa:allmodconfig ... failed
> > --------------
> > Error log:
> > kernel/kcsan/kcsan_test.c: In function '__report_matches':
> > kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes
> >
> > Bisect for both points to commit e240e53ae0abb08 ("mm, slub: add
> > CONFIG_SLUB_TINY").  Reverting it on its own is not possible, but
> > reverting the following two patches fixes the problem.
> >
> > 149b6fa228ed mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED
> > e240e53ae0ab mm, slub: add CONFIG_SLUB_TINY
> >
> > Context: CONFIG_SLUB_TINY is enabled with allmodconfig builds.
> > This enables some previously disabled configurations and disables
> > some previously enabled configurations. Not sure if that is a good
> > thing or a bad thing, but it does result in the above errors.
> 
> For xtensa I've posted the following fix:
> https://lore.kernel.org/lkml/20221223074238.4092772-1-jcmvbkbc@gmail.com/
> I suspect that previously KCSAN was disabled in allmodconfig builds for xtensa.
> 

Correect.

Thanks,
Guenter
