Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054766E8E67
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjDTJnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjDTJm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:42:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5939A4EEC;
        Thu, 20 Apr 2023 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681983660; x=1713519660;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SJZGrNGmLN2kZK2Jr9vAjtwWFXN9KIm1PDWUodF12fo=;
  b=DicMO4cT4wajUyGEf/f1RdqtA6daoomS//AUpETHledau0yr3h0SpMmo
   QtbxQlMrGYwsb7UoVbnIduNJ7S+10/nFBF6zWs90hFUDL7fMoiXrrq72D
   XES7jLXWM88iXBygyKkYn1AHhMNPzyilLnVBuE3MVyuu/K50xik3G050M
   7jLp66uV8W9KiOvXCyfluWkM/Z9YKL2+gT1rIxyorzK+UfQPhmyqwqIRc
   aJybrwbCVR12qAsM4mo3HgruL/jOPNjBeVOg9E0FPvRjHy44Iv49zU6yo
   8AIoj9+SZH1fBtyjMVl+/uC9iLDloDdT5gthQegT60+1Bs2s5+rNku+ue
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="343165355"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="343165355"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 02:38:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="691847837"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="691847837"
Received: from akirasen-mobl.amr.corp.intel.com ([10.252.32.100])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 02:38:51 -0700
Date:   Thu, 20 Apr 2023 12:38:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Moger, Babu" <babu.moger@amd.com>
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
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
In-Reply-To: <36ef8031-40a7-3324-7b4e-4510f11a488b@amd.com>
Message-ID: <a0f1bb9a-7cc4-b4af-9ad8-6dc03217d5a8@linux.intel.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu> <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu> <d046eebf-15b-2d23-b8f6-5dd06b49d0d3@linux.intel.com> <36ef8031-40a7-3324-7b4e-4510f11a488b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2094653454-1681983541=:2051"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2094653454-1681983541=:2051
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 19 Apr 2023, Moger, Babu wrote:

> Hi Jarvinen,
> 
> On 4/19/23 07:58, Ilpo Järvinen wrote:
> > On Mon, 17 Apr 2023, Babu Moger wrote:
> > 
> >> The resctrl task assignment for MONITOR or CONTROL group needs to be
> >> done one at a time. For example:
> >>
> >>   $mount -t resctrl resctrl /sys/fs/resctrl/
> >>   $mkdir /sys/fs/resctrl/clos1
> >>   $echo 123 > /sys/fs/resctrl/clos1/tasks
> >>   $echo 456 > /sys/fs/resctrl/clos1/tasks
> >>   $echo 789 > /sys/fs/resctrl/clos1/tasks
> >>
> >> This is not user-friendly when dealing with hundreds of tasks.
> >>
> >> It can be improved by supporting the multiple task id assignment in
> >> one command with the tasks separated by commas. For example:
> >>
> >>   $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> >>  Documentation/x86/resctrl.rst          |    9 ++++++++-
> >>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   31 ++++++++++++++++++++++++++++++-
> >>  2 files changed, 38 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> >> index 387ccbcb558f..f28ed1443a6a 100644
> >> --- a/Documentation/x86/resctrl.rst
> >> +++ b/Documentation/x86/resctrl.rst
> >> @@ -292,7 +292,14 @@ All groups contain the following files:
> >>  "tasks":
> >>  	Reading this file shows the list of all tasks that belong to
> >>  	this group. Writing a task id to the file will add a task to the
> >> -	group. If the group is a CTRL_MON group the task is removed from
> >> +	group. Multiple tasks can be added by separating the task ids
> >> +	with commas. Tasks will be assigned sequentially in the order it
> >> +	is entered.
> > 
> > "Tasks ... it is ..." doesn't sound correct.
> 
> How about "Tasks will be assigned sequentially in the order they are entered."

It sounds better.

-- 
 i.

--8323329-2094653454-1681983541=:2051--
