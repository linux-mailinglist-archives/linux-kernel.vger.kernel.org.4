Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B847B67A4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjAXVXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjAXVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:23:48 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BB44EC3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:23:47 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q9so12168694pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyVp6L65vrlfh47jIwStCxDGJjlhMDEStL5pdHuuEkw=;
        b=O87y40OdSZpdhNSuht3+q/63BpXj9Qlnk7ebL1XkfT5xvT0WPfa9YAYy9kmSo/+5mI
         w8Mgrj4XRQFOfpvATXffXIxHXeHINHLnAXWPfaVhSQ5PTEjHpDKYQ7BGIKfldLVNmVAN
         YmdJFdljWKwbiScMhHK9/26EjLsnmMjUkx1aNi1WetiRFLQ0vTEzJx3wj1/nH/8d4Ki4
         3egWn3A2NMoL7hf59gBMui6KAKON/+tKDKy8Na9e23Zjz40+w2257Qg2KArvAs/VNUPs
         RIlvyEsHDkMJCFVCX3hojdQxCdgoOCowahObb7J2eRP6VcBKxs2vXxe2i5htEYLyOSPS
         PxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyVp6L65vrlfh47jIwStCxDGJjlhMDEStL5pdHuuEkw=;
        b=3hIHGlKZmoR1WnMePWuoAghD8hLWKCGifNMQRWV3DbBtvpokrXhKpJliPv7vLhvG8v
         c+XCNY0U5ceqRGwkF46Jine4nTiGPQjOR6dtWtOlatCYiHgbOLwYATL77CtEd1RCQOWd
         3oXndf/4ZoSpeh8qXrxCi1Er7/gH0gg3W2H+elM6BKJNDRlIKCLyxTQ14UK9PXm+8u1Z
         eJJxBNtIeY9pa25/KXOX3QPIbPVCKqjZ+A/MxcO+P12hLBIMSyHSw0JuIHPht1JPgsC4
         t0ReCn9UdjLQh7Ve2B0ujcDmrY4Jnb3iYllA00KW3Ne9e3CIpgK2HQyeiTUtpTh8jP87
         QSig==
X-Gm-Message-State: AO0yUKUyMqPUAk+Gz+lmTgk7/1Yv1SbZhmIXC3v15K1FUxgQ+MEv2Hm8
        eM2DuuFxfjg/naYovkIyaNZfgQ==
X-Google-Smtp-Source: AK7set+Y2p77+zW1MTir8HIs/jfqblThQjd4fpJJF03yf/UENHvTMdI9au6m+MeEP5nbjgsIu5zpDA==
X-Received: by 2002:a05:6a00:23cb:b0:581:bfac:7a52 with SMTP id g11-20020a056a0023cb00b00581bfac7a52mr381062pfc.1.1674595427089;
        Tue, 24 Jan 2023 13:23:47 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:b15:b561:51fb:73c3])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b0019101215f63sm2128562pll.93.2023.01.24.13.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 13:23:46 -0800 (PST)
Date:   Tue, 24 Jan 2023 13:23:42 -0800
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Fixes for kmemleak tracking with CMA regions
Message-ID: <Y9BMXq36fZ/xppbD@google.com>
References: <20230109221624.592315-1-isaacmanjarres@google.com>
 <Y8gpfgEXtialPVLk@arm.com>
 <Y8neaPB2y689WKOf@google.com>
 <Y8/96eIu47UfqsWO@arm.com>
 <20230124122015.9f4e93e197153183085afbff@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124122015.9f4e93e197153183085afbff@linux-foundation.org>
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

On Tue, Jan 24, 2023 at 12:20:15PM -0800, Andrew Morton wrote:
> On Tue, 24 Jan 2023 15:48:57 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > Thanks for digging this out. This patch shouldn't have ended up upstream
> > (commit 972fa3a7c17c "mm: kmemleak: alloc gray object for reserved
> > region with direct map"). I thought both Calvin Zhang and I agreed that
> > it's not the correct approach (not even sure there was a real problem to
> > fix).
> > 
> > Do you still get the any faults with the above commit reverted? I'd
> > prefer this if it works rather than adding unnecessary
> > kmemleak_alloc/free callbacks that pretty much cancel each-other.
> > 
> > > I'm not sure if that commit is appropriate, given that reserved regions
> > > that still have their direct mappings intact may be used for DMA, which
> > > isn't appropriate for kmemleak scanning.
> > 
> > It's not. I think it should be reverted.
> 
> Could someone please send along a patch to revert this, along
> with the explanation for doing so?  And please consider a cc:stable.
Yes, I can send a revert patch later today. My patches that are
currently in mm-unstable depend on this patch though, so those would
have to be dropped from that branch as well.

--Isaac
