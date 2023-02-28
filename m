Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51F56A5DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjB1RNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjB1RNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:13:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 530E2196B8;
        Tue, 28 Feb 2023 09:13:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47F06C14;
        Tue, 28 Feb 2023 09:14:33 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AC6E3F881;
        Tue, 28 Feb 2023 09:13:48 -0800 (PST)
Message-ID: <a95d0200-da28-4fbe-2bfe-ff948b4c2801@arm.com>
Date:   Tue, 28 Feb 2023 17:13:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/7] x86/resctrl: Add a new "snc_ways" file to the
 monitoring info directory.
Content-Language: en-GB
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-6-tony.luck@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20230126184157.27626-6-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 26/01/2023 18:41, Tony Luck wrote:
> Make it easy for the user to tell if Sub-NUMA Cluster is enabled by
> providing an info/ file.

I think what this is conveying to user-space is 'domain_id_is_numa_node'.

Does user-space need to know the number of ways?

Will this always be a single number, or will it ever be possible to have an SNC=2 and
SNC=1 package in the same system?


Thanks,

James

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index a0dc64a70d01..392e7a08d083 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -997,6 +997,14 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int rdt_snc_ways_show(struct kernfs_open_file *of,
> +			     struct seq_file *seq, void *v)
> +{
> +	seq_printf(seq, "%d\n", snc_ways);
> +
> +	return 0;
> +}
> +
>  static int rdt_mon_features_show(struct kernfs_open_file *of,
>  				 struct seq_file *seq, void *v)
>  {
> @@ -1451,6 +1459,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdt_num_rmids_show,
>  		.fflags		= RF_MON_INFO,
>  	},
> +	{
> +		.name		= "snc_ways",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_snc_ways_show,
> +		.fflags		= RF_MON_INFO,
> +	},
>  	{
>  		.name		= "cbm_mask",
>  		.mode		= 0444,

