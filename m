Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086ED6DF264
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDLLAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLLAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:00:20 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C548C65B0;
        Wed, 12 Apr 2023 04:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1681297218;
        bh=xR4GuTL5Nmxsxu18JrbipI8OGiSCJg9nlLups6OAbag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=THfXqEBdjK14et4Ik0idqXMu7LfYqJY7h/jq/AXfwPLM9Lico4dOaOkW7jkqfFwQK
         b1pZ2hoKCYrblbz0q/6YkguN6Ejq8zm1O9W/XLdrdSPE42Pi1neLaqLPqhL91LIkrF
         3jOjZ7XmbNY6Aq5DMJItnxRSS2jBlw2PMUA03eQk/6Hof38BXvBdpsQ3m7Ua4ofCAI
         V/SLD1x8nkrmO7bYb+rAx0IRaxGxMp5sIVic7l3Ag/IEZsqU6TsL4CrXpahHcOMgdv
         h7KnVf/JaR+mdmoBqC7ZHDjEn65aRbYGyX295KOGs5uhu+wR+lEEnHGiHmZetM9umA
         pcx1ExMLp2Oqg==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.211])
        by gnuweeb.org (Postfix) with ESMTPSA id C9409245324;
        Wed, 12 Apr 2023 18:00:11 +0700 (WIB)
Date:   Wed, 12 Apr 2023 18:00:07 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
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
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux regression tracking <regressions@leemhuis.info>
Subject: Re: Linux 6.2.1 hits a display driver bug (list_del corruption,
 ffff88811b4af298->next is NULL)
Message-ID: <ZDaPNx7WSKeMqgmj@biznet-home.integral.gnuweeb.org>
References: <6feae796-db3f-1135-a607-cfefb0259788@gnuweeb.org>
 <ZAGqet3U8AMm4Uf1@debian.me>
 <ZAOTU5CRwdEC1lGH@biznet-home.integral.gnuweeb.org>
 <87v8jetaik.fsf@intel.com>
 <ZAXT1B1GTlmA78Ld@biznet-home.integral.gnuweeb.org>
 <ZDYw0vVg7Y1oExJL@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDYw0vVg7Y1oExJL@debian.me>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:17:22AM +0700, Bagas Sanjaya wrote:
> From gitlab issue above, I don't see any progress on bisection attempt.
> Ammar, have you successfully boot Ubuntu 20.04 with v5.10 kernel and
> test there?

I am still using Ubuntu 22.04. Haven't tried 20.04. I'll arrange time
for it this week.

> Anyway, I'm adding this to regzbot (with tentative commit range):
> 
> #regzbot introduced: v5.10..v5.15.103
> #regzbot title: Linux 6.2.1 hits a display driver bug (list_del corruption, ffff88811b4af298->next is NULL)
> #regzbot link: https://gitlab.freedesktop.org/drm/intel/-/issues/8274
> 
> (Also Cc: Thorsten)

Not sure why you marked it as regression. I haven't even found the last
good commit. It's possible that it's always broken since the beginning.

-- 
Ammar Faizi

