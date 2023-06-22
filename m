Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCD273A1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjFVNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFVNfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:35:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADB199F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687440951; x=1718976951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vQ6rkJEF3ruEwzFBfVeGREL1m1atfFP0GWQnnVL7boo=;
  b=dr9tg9p1AcvEMELquFu4BqqflkNUAP4GEIYSHRbtERpk+RYGMHzlYUz1
   euWS7Z8xDlz42GPN+6g87V0q6Gl4eJvI6ntTuGAwCHmQj+oy0rFELqq/9
   gwppqmhB6jLzHI5W3znO4M/lTZmdySPGb0ERXap+j2jpqponpDYS6rGtS
   oF1xQdo2CHzmKXUgnX5jyZFU44WT6hJGSAjAJS+T67/3sKpH08CXT0Ni9
   t66PdTzx0NvY+0ACVNO1tG/PUayOsaHsnjoAFxIKgIb/U69FUwSljbNZH
   6HqTOlm+aXPuu5MgqQpPEe8SBWLiCFr6zG+TB8tFAXZwVpCmguENeF+iG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="390229916"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="390229916"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="718087254"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="718087254"
Received: from akivisil-mobl.ger.corp.intel.com (HELO intel.com) ([10.251.215.96])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:35:47 -0700
Date:   Thu, 22 Jun 2023 15:35:44 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] i915: avoid unused-but-set-variable warning
Message-ID: <ZJROMM5iN68XpjA7@ashyti-mobl2.lan>
References: <20230622101848.3482277-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622101848.3482277-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Jun 22, 2023 at 12:18:41PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The mchbar_addr variable is only used inside of an #ifdef:
> 
> drivers/gpu/drm/i915/soc/intel_gmch.c:41:6: error: variable 'mchbar_addr' set but not used [-Werror,-Wunused-but-set-variable]
> 
> Change this to an IS_ENABLED() check to let the compiler see how
> it's used and no longer warn about it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Thanks,
Andi
