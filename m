Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52D5FBA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJKSd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJKSdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A257235
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 741D761260
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333C4C433D6;
        Tue, 11 Oct 2022 18:33:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KGhqAT2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665513230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pIGwSmYHsrzA+DL8rI+QHCJpPu01LsNs7nitpVxvlbU=;
        b=KGhqAT2IdAs59xKO74CZ6Jm5McfJryAv6Ea5cluMu2Xd07o9zZYYjeSVIp/FwrUFHZPu6O
        cMy90EsNqAjVD3l9FhUD7pPrqxmVACdDOEG87FfpLApS4dqNlz1I0mO/iN89PksV4N1hqh
        ob8brn1KeOmIXyBXUMYJK1Lkfaw4a3E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 821224bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Oct 2022 18:33:49 +0000 (UTC)
Date:   Tue, 11 Oct 2022 12:33:47 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kernel test robot <lkp@intel.com>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [crng-random:jd/get_random_u32_below 24/26]
 include/linux/random.h:64:77: sparse: sparse: cast truncates bits from
 constant value (e24d4d50 becomes 50)
Message-ID: <Y0W3C5n4Tjy/Cri6@zx2c4.com>
References: <202210111756.pMpxXUwp-lkp@intel.com>
 <0dc78ec5-e934-fcb4-5153-1e8d3840f473@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0dc78ec5-e934-fcb4-5153-1e8d3840f473@rasmusvillemoes.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:21:44PM +0200, Rasmus Villemoes wrote:
> On 11/10/2022 11.59, kernel test robot wrote:
> 
> > c440408cf6901e Jason A. Donenfeld 2017-01-22  53  
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  54  u32 __get_random_u32_below(u32 ceil);
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  55  /* Returns a random integer in the interval [0, ceil), with uniform distribution. */
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  56  static inline u32 get_random_u32_below(u32 ceil)
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  57  {
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  58  	if (!__builtin_constant_p(ceil))
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  59  		return __get_random_u32_below(ceil);
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  60  
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  61  	for (;;) {
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  62  		if (ceil <= 1U << 8) {
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  63  			u32 mult = ceil * get_random_u8();
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08 @64  			if (is_power_of_2(ceil) || (u8)mult >= -(__force u8)ceil % ceil)
> > dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  65  				return mult >> 8;
> 
> I don't have a good suggestion for how to silence sparse, but I think
> the cast and unary minus here needs to be interchanged. I.e., the
> condition should be
> 
>   if (is_power_of_2(ceil) || (u8)mult >= ((__force u8)-ceil) % ceil)
> 
> Otherwise it fails to provide uniform distribution for ceil=11, 19, 22,
> 23, ... [these are the numbers that are not divisors of 2^32-2^8].

Thanks! Note that this is an incomplete dev branch I haven't posted to
the ML yet. As for the sparse error, I think I'll fix both issues at
once by just doing (256 - ceil) % ceil.

Jason
