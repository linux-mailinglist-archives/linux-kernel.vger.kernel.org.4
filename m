Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D041870DB9D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbjEWLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjEWLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:40:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5BE118;
        Tue, 23 May 2023 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u58gKGYImk19qWRxWKlrjAh5POyCRjifFqBhEoUWksk=; b=lYt51G6qfsyAQCtCCDMJ8pDclW
        04RPhDEpqBfjX7FDBwBQWngCk5Yxv6NjbE3gnd7tjLDDPdE8BRS3NA0NeuUBc83FgM9BfxCtzCNF9
        7/Zc50lwtiUDeH3HdQ0aOltxQZh6eSMz249+cnx4SgTAyMCGxf6KjUyOGI8oRfP8INZgC2MoUmTZd
        iJG9OUWHGd7wSAS5y1PQFgZxX7ttHCgYwXcksJYvkfOmywILB/BwVU7K07RH42xCQ/cHN24XWASYO
        Udd4D7WL0bwAl+Dnl7fh6oCy9nez0GLjgMgxZqscBmwe1WGYj4RU1f5pFGS2gxIoBlpq2gd9rn+kI
        WED2RC8w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Pjt-003UQV-1Q;
        Tue, 23 May 2023 10:59:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83490300338;
        Tue, 23 May 2023 12:59:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3571220A99311; Tue, 23 May 2023 12:59:35 +0200 (CEST)
Date:   Tue, 23 May 2023 12:59:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/topology: Introduce sched_group::flags
Message-ID: <20230523105935.GN83892@hirez.programming.kicks-ass.net>
References: <20210911011819.12184-3-ricardo.neri-calderon@linux.intel.com>
 <163344312261.25758.16010066552550079330.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163344312261.25758.16010066552550079330.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 02:12:02PM -0000, tip-bot2 for Ricardo Neri wrote:

> index 4e8698e..c56faae 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -716,8 +716,20 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  		tmp = sd;
>  		sd = sd->parent;
>  		destroy_sched_domain(tmp);
> -		if (sd)
> +		if (sd) {
> +			struct sched_group *sg = sd->groups;
> +
> +			/*
> +			 * sched groups hold the flags of the child sched
> +			 * domain for convenience. Clear such flags since
> +			 * the child is being destroyed.
> +			 */
> +			do {
> +				sg->flags = 0;
> +			} while (sg != sd->groups);


I happened to be reading this here code and aren't we missing:

	sg = sg->next;

somewhere in that loop?
