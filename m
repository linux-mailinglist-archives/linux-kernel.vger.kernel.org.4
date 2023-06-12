Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A36F72D4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjFLXEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFLXEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD56E4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 16:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C77461F4C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45BDC433EF;
        Mon, 12 Jun 2023 23:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686611043;
        bh=VGVC+n+rB8PnKBUWaIKBuLjDMui58ZeepT338bJUEDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpxX/k65SlYeODpEyApi4SJsxFJS2jUwsIE2D6l13Y3fCKyersZkyiHrmX6DHCuG4
         MsBBN36qvguFG4zIhfw6UNAwWGwrlI1zOyxxEPGp24MBEaQPQv0gr7C1OjM+Zgp7En
         eBuGMzml76Ve/YoEy8GpSHvrvP+rvl386UyywuHdoaZF9ByoJP7U+QgJ/ICFqhl8vk
         KO6sKIzG1seKoOO4+wvOL3AoBaHp0Y/o1yHKVV/mCxZRIDNZdGDmRU67V7gN2uzQCv
         Yoa8QYBljpLLa/8+ZS91ah44KKWBjnq4zsX0Jsb6sFjDsxNd7JKmrgIqET4DGqyCqU
         pzBmIbc+0GcDw==
Date:   Tue, 13 Jun 2023 01:03:59 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gmch: avoid unused variable warning
Message-ID: <20230612230359.swzobgrc5asfnolw@intel.intel>
References: <20230612124408.521325-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612124408.521325-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jun 12, 2023 at 02:43:59PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_PNP is disabled, the mchbar_addr variable is only written but
> not read:
> 
> drivers/gpu/drm/i915/soc/intel_gmch.c: In function 'intel_alloc_mchbar_resource':
> drivers/gpu/drm/i915/soc/intel_gmch.c:41:13: error: variable 'mchbar_addr' set but not used [-Werror=unused-but-set-variable]
>    41 |         u64 mchbar_addr;
>       |             ^~~~~~~~~~~
> 
> No idea why this showed up now, but it's easy to fix by changing the #ifdef to
> an IS_ENABLED() check that the compiler can see through.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

applied to drm-intel-next.

Thank you,
Andi
