Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0942363A242
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiK1HrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1HrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:47:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80013D64
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 23:47:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D163661010
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3266EC433D6;
        Mon, 28 Nov 2022 07:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669621635;
        bh=+WYQFpWUKXr9b62rzVenfF+a3NLG9DBKuJ3zWIaJbFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trelwF4unhGqqJGOzUJ2U/lkT86Tjnibc09mApQkJO/TZ2q0Mrmah178G0hbKdiyQ
         EQnzDwZrv/ScpfLZ1b2cGjnZC/VPkC8RZuGfdaIoWesbK14u3nv17qMoTv+jQrWDlV
         bCH6iANTSynehLUnJnqJ9iPhELkk3SSyRfaHpLvfnQagMMdYvCs/l5MCHRpmwZJxGZ
         HAr+LxGZms0NZS/glR1N58y53ypXoE2J7TOHso9rc5OOgM9EfTu487WUM1d181ZDd/
         v+cSSAscgZr4odczemM+jp7Xe0ZaV3zqT61Yq1WzKSNuHZC3eRLHm2QF8ngrWgP55g
         dUFTpihSBZcfQ==
Date:   Mon, 28 Nov 2022 07:47:06 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     arnd@arndb.de, nathan@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        ndesaulniers@google.com, trix@redhat.com, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] Fix a bunch of allmodconfig errors
Message-ID: <Y4RnesCbA0yOFI8/@google.com>
References: <20221125120750.3537134-1-lee@kernel.org>
 <20221125161325.bed715211b887d0a298813de@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221125161325.bed715211b887d0a298813de@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022, Andrew Morton wrote:

> On Fri, 25 Nov 2022 12:07:48 +0000 Lee Jones <lee@kernel.org> wrote:
> 
> > Since b339ec9c229aa ("kbuild: Only default to -Werror if COMPILE_TEST") WERROR 
> > now defaults to COMPILE_TEST meaning that it's enabled for allmodconfig        
> > builds.  This leads to some interesting failures, each resolved in this set.   
> 
> I'm not sure who this patchset is aimed at, so I'll take my usual
> approach of grabbing it and seeing who complains.
> 
> > With this set applied, I am able to obtain a successful allmodconfig Arm build.
> 
> b339ec9c229aa is a year old and I've been doing arm allmodconfig for
> ever.  What am I missing here?
> 
> A broken arm allmodconfig is pretty irritating - I'm thinking that a
> fix should be backported into -stable kernels.  But I'm clearly missing
> something here.

I will be taking these through all applicable Stable kernels.

-- 
Lee Jones [李琼斯]
