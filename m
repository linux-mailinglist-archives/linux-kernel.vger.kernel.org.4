Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5EB73EB51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFZTxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZTxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:53:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F3AE7E;
        Mon, 26 Jun 2023 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687809182; x=1719345182;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6SK8NB2LsBYbp7+J0GVDHHXUhFuGKobVNw10WdKFO2s=;
  b=YS61IW9SxFTXZYlrRSv7ZP452Gzb0cBZysYOYOEi9XnYglOlMdVI4oUy
   ZDhPLtnx/uTrstRjAIh8i9A+xqQ7DO8wOffFDFXBBAIJTmU+5w1Z1bo6y
   77zCoptY3h4GFqqGYGeS69ReYJQfMwXcFA9xEiyHmJ3o2vgS/cSPLhwGj
   FDzT+GD+RS+UWpM0CPEdHvEEEIsloeJwnse+v6NrboFZohxIiqN7R2hoZ
   S4YEUqAcN5OYuiHHIq2o46fo8hN+3yPetdTlJdizzuaFXxdSuYCVZP8ql
   oR5/2s8lkzbIIjAr8NcGqrv3gpkg7NNRW6iBV8UseBoaRLwRfonkixVWO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="340959275"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="340959275"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 12:53:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="781576168"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="781576168"
Received: from jingyan2-mobl.amr.corp.intel.com (HELO [10.209.115.106]) ([10.209.115.106])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 12:53:00 -0700
Message-ID: <d211d4dedd79330412e71a8b9b4b599cfe0fc80c.camel@linux.intel.com>
Subject: Re: [PATCH v4 06/24] sched/fair: Collect load-balancing stats for
 IPC classes
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Date:   Mon, 26 Jun 2023 12:52:59 -0700
In-Reply-To: <20230624000121.GA32639@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
         <20230613042422.5344-7-ricardo.neri-calderon@linux.intel.com>
         <ZJQN/KIwCUmzYoiN@arm.com>
         <20230624000121.GA32639@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >=20
> > nit: the comment is unnecessary, and a bit misleading, IMO.
> >=20
> > The comment says "This group will not be selected." but the only way to
> > guarantee that here is to reset the sum_score to 0 when you find an
> > invalid score, which I don't believe is your intention.
>=20
> You raise an interesting point. We will call this function for each rq
> in the sched group. Thus, if we encounter an error, the scores would be
> incomplete. Therefore, I think that the scores should be discarded and
> reset to 0 so that they are not used, IMO.

Since we still have other rqs to loop through, reset to 0 here does
not guarantee that it will stay that way at the end of the loop when
the sum could still be added to.  May need a special value like -EINVAL
and make the score a "long" to mark such case.

Tim



