Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1572F73E644
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFZRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjFZRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:18:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD162D70
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687799756; x=1719335756;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kVVX1jZXw7UiUHNqK+3RXuQGDJL//etFDJear+JO/nM=;
  b=UnhAG/nlfqJHVYjKFla6r2njO7IGpRP3qUrg+ILN3hVZSEnpCVG0sm8d
   XGYfkQCchk4/EWbHXE28mfMvA5GvkR5jh2KcBBn17GLfTy34d0OuELQ9M
   d9SceCoeGe/P4D+EH4TqijCWfA4NR8a/lRGQ7emiBVtHTAtkAOHjRDl6K
   /VHe9h57IQb5Ctf3iKj157i5bJKPcrffzTT/qA20tbLawlKO+zsNBAoRO
   X3pY8RgJ7F5ZuABsDtFB1WftFC2Suc0mNR3wHBJBxg4vJdU9vWZKm9eKR
   W8JxOn1RmiQEtdImPXVbN3vlAz7I7LTd0hQaRz9XJ+ySkXKpStRMFlX2f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="351109667"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="351109667"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 10:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="710298776"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="710298776"
Received: from jingyan2-mobl.amr.corp.intel.com (HELO [10.209.115.106]) ([10.209.115.106])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 10:09:10 -0700
Message-ID: <0a611696cbc63a3a9b99a7966b8fe4f7e20a014b.camel@linux.intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce
 false sharing
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Deng Pan <pan.deng@intel.com>, tim.c.chen@intel.com,
        linux-kernel@vger.kernel.org, tianyou.li@intel.com,
        yu.ma@intel.com, lipeng.zhu@intel.com
Date:   Mon, 26 Jun 2023 10:09:10 -0700
In-Reply-To: <ZJlDsbyNmcKtweg4@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230621081425.420607-1-pan.deng@intel.com>
         <20230626054756.GA435374@ziqianlu-dell>
         <ZJlDsbyNmcKtweg4@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-26 at 15:52 +0800, Chen Yu wrote:
>=20
> =20
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec7b3e0a2b20..067f1310bad2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1958,8 +1958,10 @@ static inline void set_task_rq(struct task_struct =
*p, unsigned int cpu)
>  #endif
> =20
>  #ifdef CONFIG_RT_GROUP_SCHED
> -	p->rt.rt_rq  =3D tg->rt_rq[cpu];
> -	p->rt.parent =3D tg->rt_se[cpu];
> +	if (p->sched_class =3D &rt_sched_class) {
> +		p->rt.rt_rq  =3D tg->rt_rq[cpu];
> +		p->rt.parent =3D tg->rt_se[cpu];
> +	}

If we avoid the assignment for non-rt task, do you see it further improves
c2c bounce?

Tim

