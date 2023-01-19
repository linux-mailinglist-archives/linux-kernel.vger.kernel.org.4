Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB31672E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjASBtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjASBps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:48 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103CD5528C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:41:58 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so367116pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zADmnpsuNtIYVpwfxpwV4/VpUfEveCJ2KWctJtlT7fU=;
        b=LNTqwVnpccT/EMOVWj9IzyZDxA243X49Lg53XS5JGSwSOVlY1TF6Ueh1mG55Zkz6HX
         zN84OJXLd79el+ZxutRyA1u5W4r9t8AHUdVbUNDiZ7aukBwVxKdkD8UWLlDsf8V0ghgT
         MVkK+a9wTqXvSYCuH8pVRXpckyOdKKUihZdHl2qnBdyQOnux9Ng0zF3mEqweDoNPU3z4
         d+zEUdTMLGBNrTZ0Wu+qiVDIwrUoxBpLH5PS0Z63wdEUtBPK6qOF/u+JX7oStXcJr004
         etlr7ksTagfF9SG64GMnKx0Zv5Vs9IJANlpokxWE+ju5PdCOU4W69KeOVWt2oI3dW1Aw
         jsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zADmnpsuNtIYVpwfxpwV4/VpUfEveCJ2KWctJtlT7fU=;
        b=Fd8SXKSgUaF7x/uCVdu5b7xIeRWzcARFcRzXumIDeljnghI39XEmEZDuNyaKRBeDG1
         qjSqrd/YnyCGoY6W/BOlxS/BQC2C0ZxxpJwCPzEBAJKQ97gLFoDpRyAudVO8lWUPkuQj
         BZhyei6TyGM74GPrsohA7c5hsKg1n3ssIB/yjiqD137SAkMBoMcLZuBDn+/PJySsF+T2
         JdeREQknJrPfNoPY6nQH964EeKWNO2+Uyg+Q5ClR4On/GM/bLCh81UKb4WHI6bB2emNT
         gBNigqCqNY6BIidvKHAZiObxZNfyARfzORkd6c+OOJNqAAMwgb0pqzj9o/4/KyIjyyTz
         1mXw==
X-Gm-Message-State: AFqh2kquRw6pSHUE882ACEkduvpNShf5OPMZFIKeMB9e5TWPIIalIN3T
        vjx1jWsheHU69beCIymCGQI=
X-Google-Smtp-Source: AMrXdXvd30Li23W1X4ve12v8MsWM7nbmYggz0o7t+4I7HvcbapsEpk1veNozzWIWgcJQBVw4Pv5lhQ==
X-Received: by 2002:a05:6a00:10:b0:576:a74a:13c3 with SMTP id h16-20020a056a00001000b00576a74a13c3mr11296420pfk.1.1674092517155;
        Wed, 18 Jan 2023 17:41:57 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79594000000b0058de2c315e6sm2348593pfj.158.2023.01.18.17.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 17:41:56 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 Jan 2023 15:41:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Richard Clark <richard.xnu.clark@gmail.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org," <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] workqueue: fix enum type for gcc-13
Message-ID: <Y8if47fU4C+06JNz@slm.duckdns.org>
References: <20230117164041.1207412-1-arnd@kernel.org>
 <99ea6e86d2594b40a6de96cc821c447b@AcuMS.aculab.com>
 <Y8ggiF+7k0rViXcY@slm.duckdns.org>
 <a1d48420-862e-47e6-9435-462e23bb6be3@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1d48420-862e-47e6-9435-462e23bb6be3@app.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:32:45PM +0100, Arnd Bergmann wrote:
> the enum type has to be compatible with 'long long' because
> anything shorter would not fit both -1 and -1u (UINT_MAX).
> A and B were both signed types to match the signedness of the
> enum type, but A was actually a 32-bit integer since that is
> sufficient, while B was also a 64-bit type since it exceeds
> INT_MAX. Now they are both the same type.

Yeah, the new behavior makes total sense.

> I don't think there is a chance they will revert to the old behavior,
> though we could try asking for an command line flag to warn about
> cases where this changes code generation.

but the way that it's transitioning doesn't really make sense to me. We do
phase out support for old compilers, so it isn't that difficult to manage
this transition smoothly - add a compat option in the new versions, switch
code later once old compilers are phased out and drop the compat flag.

The way it's currently done causes situations which can't be handled
logically - we end up having to regroup enums based on their value range
rather than the logical type they need to be because there's no way to
override the enum type on older compilers.

Thanks.

-- 
tejun
