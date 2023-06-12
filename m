Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2F72C2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjFLLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFLLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:36:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B11982
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UNgxxIWKRNKpQwlHP1KcC4wpeFs5yQtKdY9XE7EOhUE=; b=r+hVUwUSdXB1J2bferuwIur7xv
        ReGSTN8VeVUxt3ghjhiXvnbBclv/A4Byh+KIAjwD20pcSLAnvy8VimybcOT815fKi62BzWQe7hxMV
        PSvwmmI0BqSpfktmk8sMwPUsO71vU/c1jeZcyXNVKxx+P07ERp+BtnbaPBSyTIzwe7b4b/BJ+7DOc
        6TSQF8HYknfSGbx16MA1isKPXPeqJSzIo5Xstc9zlNFRpim7Bq3AXuKVdZOwxrodBZMALumlMj4aW
        8PF5WV94/YVduMcsDFX57njjeUsU1btsOBp/qMSGmHdGlfhlupDYO9hyGXSJRWpXol0naooTohNcb
        arVJMdvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8fWl-002Z8u-IK; Mon, 12 Jun 2023 11:16:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6EDCA3002A9;
        Mon, 12 Jun 2023 13:16:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5263024513501; Mon, 12 Jun 2023 13:16:02 +0200 (CEST)
Date:   Mon, 12 Jun 2023 13:16:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v2 1/6] sched/fair: Determine active load balance for SMT
 sched groups
Message-ID: <20230612111602.GJ4253@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
 <253f5272200d3cec3f24427262bb4e95244f681c.1686263351.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253f5272200d3cec3f24427262bb4e95244f681c.1686263351.git.tim.c.chen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:32:27PM -0700, Tim Chen wrote:
> @@ -10371,6 +10436,11 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  			 */
>  			goto out_balanced;
>  
> +		if (busiest->group_type == group_smt_balance &&
> +		    smt_vs_nonsmt_groups(sds.local, sds.busiest))
> +			/* Let non SMT CPU pull from SMT CPU sharing with sibling */
> +			goto force_balance;
> +
>  		if (busiest->group_weight > 1 &&
>  		    local->idle_cpus <= (busiest->idle_cpus + 1))
>  			/*

Could you please add {} for all of them? The comment makes them all
multi-line.
