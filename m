Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6EC6F8C85
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjEEWtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjEEWtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:49:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A345262
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683326952; x=1714862952;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mzJPPT00qeVh4kQwQPwrzE64qbDTj0npqbd3Oea+bDE=;
  b=TFgtz7wUKMGoWEEETYAKLEn3pzroUr/IFwJOtz45yhZMk+K3jUaUE540
   s85sm2bY6Z+uvDrVY6Idl/k6Oa+lnpKDtZnbILuJ73aAGVlTOO96XWUhH
   qvhku4ndg+GZvA/RCHBk+VfdcPU0od4zKDWsO6E1cYhC/+kbnH12WB6gI
   4OHMPIxh/LqIkukmlkyB1VbmobaEwNmR1AZuYk3SdblYfnHMr+Bti8LDS
   GrE6HjgVXWOyUIM+GktSqDdo4yG3TOeqPKKM6LlEtOIdKKUPojAN3Jgv8
   ojDoJLLOyOU9nxhNei/Fz5jCqxlp+8aAAuVeG7wq58ToYCDws0LAfszcn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="412554050"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="412554050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 15:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="841944268"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="841944268"
Received: from rmarepal-mobl3.amr.corp.intel.com (HELO [10.255.231.148]) ([10.255.231.148])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 15:49:08 -0700
Message-ID: <fb54d3f550883ec7eb92a41261dabcc196634e33.camel@linux.intel.com>
Subject: Re: [PATCH 5/6] sched/fair: Consider the idle state of the whole
 core for load balance
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Date:   Fri, 05 May 2023 15:49:08 -0700
In-Reply-To: <20230505071735.4083-1-hdanton@sina.com>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
         <20230505071735.4083-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-05 at 15:17 +0800, Hillf Danton wrote:
> On 4 May 2023 09:09:55 -0700 Tim Chen <tim.c.chen@linux.intel.com>
> > From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> >=20
> > should_we_balance() traverses the group_balance_mask (AND'ed with lb_en=
v::
> > cpus) starting from lower numbered CPUs looking for the first idle CPU.
> >=20
> > In hybrid x86 systems, the siblings of SMT cores get CPU numbers, befor=
e
> > non-SMT cores:
> >=20
> > 	[0, 1] [2, 3] [4, 5] 5 6 7 8
> >        b  i   b  i   b  i  b i i i
> >=20
> > In the figure above, CPUs in brackets are siblings of an SMT core. The
> > rest are non-SMT cores. 'b' indicates a busy CPU, 'i' indicates an
> > idle CPU.
>=20
> Better if l2-cache affinity is added in the diagram above. And better
> again if the diagram is available upon introducing hybrid x86 in the
> cover letter.

Good suggestion.  Will update the diagram and add it to cover letter.

Tim
