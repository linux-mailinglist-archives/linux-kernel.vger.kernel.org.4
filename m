Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C0E5F6CD5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiJFRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiJFRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:24:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B9BBE09
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:23:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so1326971pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAw0bo7BpTjbC8TYsIXNTxWUDQl2qr0AwdNXiKiDC5I=;
        b=Vi5knA1otkqB5+jtpnDMPTqLoMRutD6lVJ8HpHSBZv0XiHl/hWWWrS5HE3UG+eRg4U
         trridq884uNFOrwcf7QHSavxXsVnNGAE4lFccLyS2HAp/c/Q+X7WfNe14oxf8V/igNRQ
         1NrgGnXJfSXOZEVSsD4FvFJTtmYfWzZ1SkjgpcouOyFjvbsFgZZAoL4cAbgAZAdCOiQS
         dSIkeOkMwUqcrYZgVyZZ9PyhhA/bDTAs2eBDmrpKcEqCkwKj4lG9NOx+SDRb5sOOgRZH
         lQIRQEJa73XHrWGVX+wakhbMTIY6suLIpzqSdsv1wMU6vrqK8i3LMkc8AVrZAfFDLuhj
         R1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAw0bo7BpTjbC8TYsIXNTxWUDQl2qr0AwdNXiKiDC5I=;
        b=sT5phUz+T+cnkNDCiBoi8TYtQXd5AEOGpYcucg+04PifPGSHm/zKLAwVP2xAoVsfXX
         HWkZcK2sUZp0LeDHRimSiBPaKMjFB2ux0d5/RdDYZZe8/XBT0h4H6DTV0srD+r7uUKPI
         48HKBnUPrtHOi3LV75IZb8/aqaouDDvv+d6Vespz1HNPB0eHi7anMVKQmfSECUFmGD0+
         qrzbTdpDTC8fepCJd/CPPIq0lJkZO1Y0HDGUazkpEXbDzRZb5frfNJrahVukO5daSP/Q
         54vzW9sFsVYgFJYM/Sz8tNqkAu86Rnhh7TJQS4jibKq6EvxmPUgwItULZsCcGdD3N3XV
         JH6A==
X-Gm-Message-State: ACrzQf1OMQ5b8yEOi9Jswbi3GdxGvRwwY58It2RBzjIHkNJ9YEZAe3r4
        492oxfg3uIB5X7KYe6snrT4=
X-Google-Smtp-Source: AMsMyM76SSe/RbAiHrLfTgpz8b467HPmPADlaDsRY97uhvhSLw0E9/3l2Zvsfj3NUUgzLaoQhZummg==
X-Received: by 2002:a17:90b:1805:b0:20a:cd8e:abd with SMTP id lw5-20020a17090b180500b0020acd8e0abdmr767315pjb.94.1665077020618;
        Thu, 06 Oct 2022 10:23:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y62-20020a17090a53c400b0020aaa678098sm3098894pjh.49.2022.10.06.10.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:23:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 Oct 2022 10:23:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lee, Alvin" <Alvin.Lee2@amd.com>, Alex Hung <alex.hung@amd.com>,
        Pavle Kotarac <Pavle.Kotarac@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        "Leo (Hanghong) Ma" <hanghong.ma@amd.com>,
        Hersen Wu <hersenwu@amd.com>, Paul Hsieh <paul.hsieh@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH] drm/amd/display: fix array-bounds error in
 dc_stream_remove_writeback()
Message-ID: <20221006172337.GA753466@roeck-us.net>
References: <20220927191200.216488-1-hamza.mahfooz@amd.com>
 <20221006064615.GA2817657@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221006064615.GA2817657@roeck-us.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 11:46:15PM -0700, Guenter Roeck wrote:
> On Tue, Sep 27, 2022 at 03:12:00PM -0400, Hamza Mahfooz wrote:
> > Address the following error:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function ‘dc_stream_remove_writeback’:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:55: error: array subscript [0, 0] is outside array bounds of ‘struct dc_writeback_info[1]’ [-Werror=array-bounds]
> >   527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
> >       |                                 ~~~~~~~~~~~~~~~~~~~~~~^~~
> > In file included from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:1269,
> >                  from ./drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
> >                  from ./drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
> >                  from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:27:
> > ./drivers/gpu/drm/amd/amdgpu/../display/dc/dc_stream.h:241:34: note: while referencing ‘writeback_info’
> >   241 |         struct dc_writeback_info writeback_info[MAX_DWB_PIPES];
> >       |
> > 
> > Currently, we aren't checking to see if j remains within
> > writeback_info[]'s bounds. So, add a check to make sure that we aren't
> > overflowing the buffer.
> > 
> > Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> 
> With gcc 11.3, this patch doesn't fix a problem, it introduces one.
> 
> Building csky:allmodconfig ... failed
> --------------
> Error log:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: error: array subscript 1 is above array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
>   527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
> 
> Building mips:allmodconfig ... failed
> --------------
> Error log:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: error: array subscript [0, 0] is outside array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
>   527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
> 
> Building arm:allmodconfig ... failed
> --------------
> Error log:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: error: array subscript [0, 0] is outside array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
>   527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
> 

#regzbot introduced: 5d8c3e836fc2

Complete list of build failures in my test system due to this patch,
observed when building with gcc 11.3:

Build results:
	total: 149 pass: 131 fail: 18
Failed builds:
	alpha:allmodconfig
	arm:allmodconfig
	arm64:allmodconfig
	csky:allmodconfig
	i386:allyesconfig
	i386:allmodconfig
	mips:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	powerpc:allmodconfig
	powerpc:ppc32_allmodconfig
	riscv32:allmodconfig
	riscv:allmodconfig
	s390:allmodconfig
	sparc64:allmodconfig
	x86_64:allyesconfig
	x86_64:allmodconfig
	xtensa:allmodconfig

Guenter
