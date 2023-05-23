Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F670E369
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbjEWROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbjEWROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:14:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D8E10D3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684862061; x=1716398061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dY7KCAOnU07WEFz6ayJqrtvxrA/ZFCHwWSfNvSIA8Wc=;
  b=fStj2qChfLql58+tBW6w112Y/AEQPXU2cgxjwXAeKSv8Uio9eL0OtzmO
   xMJVAuk5F5b+JH7u0wZRk47HwIvpSRl4y9AWvCnsw+fBgdF0up5zCnKyD
   hKrZJxt+VovsONpayfPHOC5ZOZv9fUt0mujr2ZxtfoyAoWpmc6CwTd5lY
   dtpwVBcLOhePV5j0MpS/W6qAftoHa6xJoWqMW7BpDAny7AZBNlkweKE74
   J4F9ItvKrwTwDJHZYXyObDA//AVBtKX3PdT7ZS4j3W6kf8O8XEJ0m0A7x
   H/QfBY1KnFh9MhpH/uM0HVO1xdye3tEDpNTXuF1L1c62alrPWdjPUn3b6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="350813947"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="350813947"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 10:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="1034167355"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="1034167355"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.104])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 10:14:19 -0700
Date:   Tue, 23 May 2023 10:14:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: Re: [PATCH v3 00/19] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Message-ID: <ZGz0as//iEbRpHHs@agluck-desk3>
References: <20230320172620.18254-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320172620.18254-1-james.morse@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Looking at the changes already applied, and those planned to support
new architectures, new features, and quirks in specific implementations,
it is clear to me that the original resctrl file system implementation
did not provide enough flexibility for all the additions that are
needed.

So I've begun musing with 20-20 hindsight on how resctrl could have
provided better abstract building blocks.

The concept of a "resource" structure with a list of domains for
specific instances of that structure on a platform still seems like
a good building block.

But sharing those structures across increasingly different implementations
of the underlying resource is resulting in extra gymnastic efforts to
make all the new uses co-exist with the old. E.g. the domain structure
has elements for every type of resource even though each instance is
linked to just one resource type.

I had begun this journey with a plan to just allow new features to
hook into the existing resctrl filesystem with a "driver" registration
mechanism:

https://lore.kernel.org/all/20230420220636.53527-1-tony.luck@intel.com/

But feedback from Reinette that this would be cleaner if drivers created
new resources, rather than adding a patchwork of callback functions with
special case "if (type == DRIVER)" sprinkled around made me look into
a more radical redesign instead of joining in the trend of making the
smallest set of changes to meet my goals.


Goals:
1) User interfaces for existing resource control features should be
unchanged.

2) Admin interface should have the same capabilities, but interfaces
may change. E.g. kernel command line and mount options may be replaced
by choosing which resource modules to load.

3) Should be easy to create new modules to handle big differences
between implementations, or to handle model specific features that
may not exist in the same form across multiple CPU generations.

Initial notes:

Core resctrl filesystem functionality will just be:

1) Mount/unmount of filesystem. Architecture hook to allocate monitor
and control IDs for the default group.

2) Creation/removal/rename of control and monitor directories (with
call to architecture specific code to allocate/free the control and monitor
IDs to attach to the directory.

3) Maintaining the "tasks" file with architecture code to update the
control and monitor IDs in the task structure.

4) Maintaining the "cpus" file - similar to "tasks"

5) Context switch code to update h/w with control/monitor IDs.

6) CPU hotplug interface to build and maintain domain list for each
registered resource.

7) Framework for "schemata" file. Calls to resource specific functions
to maintain each line in the file.

8) Resource registration interface for modules to add new resources
to the list (and remove them on module unload). Modules may add files
to the info/ hierarchy, and also to each mon_data/ directory and/or
to each control/control_mon directory.

9) Note that the core code starts with an empty list of resources.
System admins must load modules to add support for each resource they
want to use.


We'd need a bunch of modules to cover existing x86 functionality. E.g.
an "L3" one for standard L3 cache allocation, an "L3CDP" one to be used
instead of the plain "L3" one for code/data priority mode by creating
a separate resource for each of code & data.

Logically separate mbm_local, mbm_total, and llc_cache_occupancy modules
(though could combine the mbm ones because they both need a periodic
counter read to avoid wraparound). "MB" for memory bandwidth allocation.

The "mba_MBps" mount option would be replaced with a module that does
both memory bandwidth allocation and monitoring, with a s/w feedback loop.

Peter's workaround for the quirks of AMD monitoring could become a
separate AMD specific module. But minor differences (e.g. contiguous
cache bitmask Intel requirements) could be handled within a module
if desired.

Pseudo-locking would be another case to load a different module to
set up pseudo-locking and enforce the cache bitmask rules between resctrl
groups instead of the basic cache allocation one.

Core resctrl code could handle overlaps between modules that want to
control the same resource with a "first to load reserves that feature"
policy.

Are there additional ARM specific architectural requirements that this
approach isn't addressing? Could the core functionality be extended to
make life easier for ARM?

-Tony
