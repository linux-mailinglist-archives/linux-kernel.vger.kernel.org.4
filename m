Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26E73EC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjFZVBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjFZVB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:01:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205CA125;
        Mon, 26 Jun 2023 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687813287; x=1719349287;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LOc6tDobeRpUuyxloHqratDaLJtesBy6Kzgu4za2HvY=;
  b=BP9MAkq8hhXmztbOjxFIiumcGL/Auph0U8fqdjku7xIz9/H64eIzpJLm
   iP0YsAYxx49eRZ5VMcsj/AMmr2IUrAHUaT0jIP4VNxXr9TPOiagKyNzOp
   rKKIUnICyvNRd8Yimf7K4K2traNhzlTiBFm9Moj729ktLQo/jz63MgwXh
   pRZXnT1wpoV8RRVvED0MlWxkM3kz4wbTnLbcQzMQUrHVMroh8nzuNPR1q
   Vti6FOlSH1HfTbBfsCybCgkGntLj2Hv19hwjpAi1vKDadQFn5VZWHvcaq
   JpVQTg1Iv4TkuXNNbTrTwTEsUnqBwJ7apNQRroxT6Kb4Un/CAub44WznI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364836490"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="364836490"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 14:01:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="666435927"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="666435927"
Received: from jingyan2-mobl.amr.corp.intel.com (HELO [10.209.115.106]) ([10.209.115.106])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 14:01:26 -0700
Message-ID: <7ca035b73ebcce9fde270227a5b630b169ebdeaf.camel@linux.intel.com>
Subject: Re: [PATCH v4 07/24] sched/fair: Compute IPC class scores for load
 balancing
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
Date:   Mon, 26 Jun 2023 14:01:25 -0700
In-Reply-To: <20230625201155.GA3902@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
         <20230613042422.5344-8-ricardo.neri-calderon@linux.intel.com>
         <ZJQONIinvSengWa8@arm.com>
         <20230625201155.GA3902@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-06-25 at 13:11 -0700, Ricardo Neri wrote:
>=20
> > > +
> > > +	score_on_dst_cpu =3D arch_get_ipcc_score(sgs->min_ipcc, env->dst_cp=
u);
> > > +
> > > +	/*
> > > +	 * Do not use IPC scores. sgs::ipcc_score_{after, before} will be z=
ero
> > > +	 * and not used.
> > > +	 */

The comment is not matching the check below.  If zero
is not used, the check should also reflect the case.

> > > +	if (IS_ERR_VALUE(score_on_dst_cpu))
> > > +		return;
> > > +
> > > +	before =3D sgs->sum_score;
> > > +	after =3D before - sgs->min_score;
> >=20
>=20
Tim
