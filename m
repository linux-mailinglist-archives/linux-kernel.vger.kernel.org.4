Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB8664051
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjAJMUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbjAJMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448E315F2C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:18:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12BE7B811D8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F47BC433EF;
        Tue, 10 Jan 2023 12:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673353130;
        bh=aOUMcDhi1pc8g5lJzrCltSW1fWp7f/dto21aYxlxTAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwOAzfPkv07dfecMpIx84BMk7joW+fAJ/GVeNKwJEczUQW4ZMC1CBF4z21IYr9rk4
         EX9SneWAhsUx+EJ8RPEH86x4J7PdmHUz35fpyI5BoPuRMNP3HzK0U+7P15AVwZNKVD
         eGVJQXpFlyP0wr7Dw8f99iHKLpb2kIb25V11fN9mDhE9gQJg74xufGYa0ZE7UbGkj7
         U5SYh7veZyzOBHZHDUmo678xz8NE56Ser749qdKJCAyLY+T/FjU/nwWq1/6rKVYZ07
         o514SRRqbi61EA9955tiOmmyq/vHZRN3RtchkHRywuOl97agtO1xzNyzGrrej+uPoj
         e9W8820uIqc5g==
Date:   Tue, 10 Jan 2023 13:18:46 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, atomlin@atomlin.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track
 CPU-specific vmstat discrepancies
Message-ID: <Y71XpnJGumySL9ej@lothringen>
References: <20230105125218.031928326@redhat.com>
 <20230105125248.813825852@redhat.com>
 <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:06:37PM +0100, Christoph Lameter wrote:
> On Thu, 5 Jan 2023, Marcelo Tosatti wrote:
> > @@ -577,6 +579,9 @@ static inline void mod_zone_state(struct
> >  	s8 __percpu *p = pcp->vm_stat_diff + item;
> >  	long o, n, t, z;
> >
> > +	/* cmpxchg and vmstat_mark_dirty should happen on the same CPU */
> > +	preempt_disable();
> 
> If you are disabling preemption then why do we still need cmpxchg?
> Same again below.

Note I'm absolutely clueless with vmstat. But I was wondering about it as well
while reviewing Marcelo's series, so git blame pointed me to:

7c83912062c801738d7d19acaf8f7fec25ea663c ("vmstat: User per cpu atomics to avoid
interrupt disable / enable")

And this seem to mention that this can race with IRQs as well, hence the local
cmpxchg operation.

