Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBED674B83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjATE7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjATE6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:58:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BC472C17;
        Thu, 19 Jan 2023 20:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674190069; x=1705726069;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VKlkEluwzJx1bj6eFWl73Hm4fIxQY3vcaficrH565kY=;
  b=Vv4z2GrqHqXbd4XHg5Dh4NS4Q/m8ehWlcfXUarrwLXuUWJmrtbbE2yjA
   984kwRg+ekXjIAHvyCXaC/ADQdzTs9sCqpVUYAR0nzbQnqteVIT/p8Ujn
   qTTogwhw7BUfxA2h66278Mn5kdu6LhVG2fZPdoSEq2+HJjG+mdimFXZX9
   YNPhHvw1sOtCukeQG5UhFb2Qq7s1NLovFGagv2hREAoeT1to6n5luTLlG
   0hzm7AZdmr08z2a4C0/rTWxDG2yvy8aOA1dv3KeijCXoyuGpJBWZEtm7F
   eY3oU6pyGM/t3Yy4DjjIE07REaP+brL6Qs7GQlLo8QvRSoh/3kPpZIZGt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="308944380"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="308944380"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 10:01:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="749012040"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="749012040"
Received: from wardsamx-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.216.92])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 10:01:06 -0800
Message-ID: <75ce7c301f0f3b8d1bd7fa94e0f54984ccb851be.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/4] powercap: idle_inject: Add update callback
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
Date:   Thu, 19 Jan 2023 10:01:06 -0800
In-Reply-To: <CAJZ5v0jzYbpeVxtuqMWUN+X-wwYtKYq=7Ky3jRnb_S6NZc1RVQ@mail.gmail.com>
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
         <20230117020742.2760307-3-srinivas.pandruvada@linux.intel.com>
         <c5167eb8-22d6-c230-5828-80e59154aeb0@linaro.org>
         <e4f08f6642939e9707ee6427affe3d4aca06410a.camel@linux.intel.com>
         <CAJZ5v0jzYbpeVxtuqMWUN+X-wwYtKYq=7Ky3jRnb_S6NZc1RVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-17 at 16:09 +0100, Rafael J. Wysocki wrote:

Hi Daniel,

> On Tue, Jan 17, 2023 at 4:08 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Tue, 2023-01-17 at 12:13 +0100, Daniel Lezcano wrote:
> > > On 17/01/2023 03:07, Srinivas Pandruvada wrote:
> > > 
> > > [ ... ]
> > > 
> > > > +struct idle_inject_device *idle_inject_register(struct cpumask
> > > > *cpumask)
> > > > +{
> > > > +       return idle_inject_register_full(cpumask, NULL);
> > > > +}
> > > >   EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
> > > 
> > > Why not just add the parameter to idle_inject_register() ?
> > > 
> > > There is only one user ATM
> > That was done in v1. But Rafael suggested to avoid changes to
> > existing
> > kernel source.
> 
> However, it can be done if Daniel prefers that.  It is 1 callback now
> only, so no big deal I suppose.
Do you have preference? I can submit an update.

Thanks,
Srinivas



