Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539486E7A81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjDSNVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjDSNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:21:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12B615464;
        Wed, 19 Apr 2023 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681910462; x=1713446462;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dwsCK/g+yR3m/NRJzizD8LYI/UOtsmhYlgVedbUwfzc=;
  b=gDvIf1JW1D+Bi5t8rXt/sX9f/iktC/Q7YcKNCqLc41uqmuP7TcWIpdUR
   7aqmhemVaKfsFUMyyEYi9WHX2Tczo+TmRoyUlj1XDxfd9odUd3wJ/hGfD
   luOHOne9kUAb8GgIDU5m9qeyRkvWIgEmayG0rB9+aQ8S43DWGxASA29iw
   YzgQQYyPfR1P0gpZ9NErhdw7OPKEgWRatp4O0czJUGT/wyT5QreQu1Hbl
   /quDoSuJyVWmSbp2OmAGp7Bopz1b+inWMCzWEdMKIz0Bmgw3dr1oKituC
   rdtYqWcIq+ZuxKsYBdf2DcNWV8lQp+lwKzO4E+QS9fSuoCFH9BcUfy/E7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345445495"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="345445495"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="802916016"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="802916016"
Received: from hbourgeo-mobl2.ger.corp.intel.com ([10.249.34.207])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 06:20:53 -0700
Date:   Wed, 19 Apr 2023 16:20:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, pawan.kumar.gupta@linux.intel.com,
        jarkko@kernel.org, adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v4 7/7] x86/resctrl: Add debug files when mounted with
 debug option
In-Reply-To: <168177451010.1758847.568218491528297451.stgit@bmoger-ubuntu>
Message-ID: <56497126-8f60-e590-bb13-b3739114375@linux.intel.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu> <168177451010.1758847.568218491528297451.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Babu Moger wrote:

> Add the debug files to the resctrl hierarchy.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   54 +++++++++++++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 1eac07ebc31b..855109abb480 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -288,6 +288,7 @@ struct rdtgroup {
>  #define RFTYPE_TOP			BIT(4)
>  #define RFTYPE_RES_CACHE		BIT(5)
>  #define RFTYPE_RES_MB			BIT(6)
> +#define RFTYPE_DEBUG			BIT(7)
>  #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
>  #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>  #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 15ded0dd5b09..1ec4359348c2 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1880,6 +1880,7 @@ static struct rftype res_common_files[] = {
>  		.mode		= 0444,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= rdtgroup_rmid_show,
> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
>  	},
>  	{
>  		.name		= "schemata",
> @@ -1909,6 +1910,7 @@ static struct rftype res_common_files[] = {
>  		.mode		= 0444,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= rdtgroup_closid_show,
> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
>  	},
>  
>  };
> @@ -2420,6 +2422,49 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>  			     struct rdtgroup *prgrp,
>  			     struct kernfs_node **mon_data_kn);
>  
> +static void resctrl_add_debug_files(void)
> +{
> +	struct rftype *rfts, *rft;
> +	int len;
> +
> +	rfts = res_common_files;
> +	len = ARRAY_SIZE(res_common_files);
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	for (rft = rfts; rft < rfts + len; rft++) {
> +		if (rft->fflags & RFTYPE_DEBUG) {
> +			rft->fflags &= ~RFTYPE_DEBUG;

I don't fully follow why you need to play with ->fflags like this.

Is it for the ->fflags test in rdtgroup_add_files()? Can't you just do 
some extra masking there for RFTYPE_DEBUG based on resctrl_debug which 
you already keep?

> +			rdtgroup_add_file(rdtgroup_default.kn, rft);
> +		}
> +	}
> +
> +	kernfs_activate(rdtgroup_default.kn);
> +}
> +
> +static void resctrl_remove_debug_files(void)
> +{
> +	struct rftype *rfts, *rft;
> +	int len;
> +
> +	rfts = res_common_files;
> +	len = ARRAY_SIZE(res_common_files);
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	for (rft = rfts; rft < rfts + len; rft++) {
> +		if (!strcmp(rft->name, "mon_hw_id")) {
> +			rft->fflags |= RFTYPE_DEBUG;
> +			kernfs_remove_by_name(rdtgroup_default.kn, rft->name);
> +		} else if (!strcmp(rft->name, "ctrl_hw_id")) {
> +			rft->fflags |= RFTYPE_DEBUG;
> +			kernfs_remove_by_name(rdtgroup_default.kn, rft->name);
> +		}
> +	}
> +
> +	kernfs_activate(rdtgroup_default.kn);
> +}
> +
>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  {
>  	int ret = 0;
> @@ -2433,8 +2478,10 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  	if (!ret && ctx->enable_mba_mbps)
>  		ret = set_mba_sc(true);
>  
> -	if (!ret && ctx->enable_debug)
> +	if (!ret && ctx->enable_debug) {
>  		resctrl_debug = true;
> +		resctrl_add_debug_files();
> +	}
>  
>  	return ret;
>  }
> @@ -2851,6 +2898,11 @@ static void rdt_kill_sb(struct super_block *sb)
>  
>  	set_mba_sc(false);
>  
> +	if (resctrl_debug) {
> +		resctrl_remove_debug_files();
> +		resctrl_debug = false;

Logically, this false assignment belongs to the earlier patch.

-- 
 i.
