Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67396ABEC1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCFLwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjCFLwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:52:01 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9839128227;
        Mon,  6 Mar 2023 03:51:59 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 93F598314F;
        Mon,  6 Mar 2023 11:51:52 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1678103518;
        bh=7mp2IVJ+mYOWVTN/6Ljscq5f7jZl+nO1fDzxD+/mR7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0xJQah7pjDgMM/+kwBLX8mlew7B9eLbWu8sc7emjX1hXKrNhB3TkrduSJID4sB42
         AIW/ZVP9N8RtpJi0a/8v6yDhwTjbX6T4dWHOwwPPVv9SZyHyJJMrnDkgVtmzRDCcn2
         HqqoD/MI5raOfTvTC6WUaq/VH/GlhgeW6p0Tc4LT8d84vIJFFKOMARe4Ahb3ywN9IB
         mRCXfKfG29XOoTYwkCSoXuRGzGqikswnXIAJJjQFLQ/R7BH5a99RtxX1znauRvAuBi
         8t7U4A6XaF1lhGMRZ3hPx8ChNpfhhbP+kigP7HDaYlhL+Psv45wzc0jSheNIZUY+mr
         rx2NDiKNG9xcg==
Date:   Mon, 6 Mar 2023 18:51:48 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Intel GFX Mailing List <intel-gfx@lists.freedesktop.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: Linux 6.2.1 hits a display driver bug (list_del corruption,
 ffff88811b4af298->next is NULL)
Message-ID: <ZAXT1B1GTlmA78Ld@biznet-home.integral.gnuweeb.org>
References: <6feae796-db3f-1135-a607-cfefb0259788@gnuweeb.org>
 <ZAGqet3U8AMm4Uf1@debian.me>
 <ZAOTU5CRwdEC1lGH@biznet-home.integral.gnuweeb.org>
 <87v8jetaik.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8jetaik.fsf@intel.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:54:59PM +0200, Jani Nikula wrote:
> Please file a bug at fdo gitlab:
> 
> https://gitlab.freedesktop.org/drm/intel/wikis/How-to-file-i915-bugs

OK, I posted it here https://gitlab.freedesktop.org/drm/intel/-/issues/8274

Thanks,

-- 
Ammar Faizi

P.S:
I had to create a new account because I forgot my previous freedesktop
GitLab account password. I tried to use the forgot password feature but
didn't get any email to reset my password. My old GitLab email address
is ammarfaizi2@gmail.com.

Just in case someone can tell what goes wrong with the forgot password
feature on there...

