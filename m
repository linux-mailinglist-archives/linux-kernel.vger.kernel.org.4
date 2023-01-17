Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C566E1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjAQPIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjAQPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:08:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E83D0AF;
        Tue, 17 Jan 2023 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673968106; x=1705504106;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQsT0mjx5ZWHQPoOgYAo5vZEfEWYhlkbbWw1IeCzlCs=;
  b=NQvW33I4t9cwLOsYzP1sbxM3OjdtHnm4ecLyHnSwt6PPPeFZ9ovdWMCC
   V8XW96+ir6uqfWy1dskFQOPx10/XQfdkJDFE9OO8N/dOad2vkIS0y/nSW
   nZKzJjrg83n3H6ilI6TBB49LeViFyOwiM64EELBVUzo8Qz22QM9Ya+XVN
   7r20/MIbNEmjVhb+tl/ExJKiCeq4dmFa1a5FqGJypWBHLRvoY+BisRfbI
   sFyeWl6Mb+Qo35J/xRonOn1Il/q9Xxd4ot/Pz1AJ7825ND8RVbHF7pXKB
   q98Ica1m5WJupkwK+gq/Z682wYPXjyxTSW88AlJtIscl54SAyg6pfC0Hn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="305093299"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="305093299"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:08:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="689821106"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="689821106"
Received: from mfmaier-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.214.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:08:26 -0800
Message-ID: <e4f08f6642939e9707ee6427affe3d4aca06410a.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/4] powercap: idle_inject: Add update callback
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
Date:   Tue, 17 Jan 2023 07:08:25 -0800
In-Reply-To: <c5167eb8-22d6-c230-5828-80e59154aeb0@linaro.org>
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
         <20230117020742.2760307-3-srinivas.pandruvada@linux.intel.com>
         <c5167eb8-22d6-c230-5828-80e59154aeb0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-17 at 12:13 +0100, Daniel Lezcano wrote:
> On 17/01/2023 03:07, Srinivas Pandruvada wrote:
> 
> [ ... ]
> 
> > +struct idle_inject_device *idle_inject_register(struct cpumask
> > *cpumask)
> > +{
> > +       return idle_inject_register_full(cpumask, NULL);
> > +}
> >   EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
> 
> Why not just add the parameter to idle_inject_register() ?
> 
> There is only one user ATM
That was done in v1. But Rafael suggested to avoid changes to existing
kernel source.

Thanks,
Srinivas

> 
> 

