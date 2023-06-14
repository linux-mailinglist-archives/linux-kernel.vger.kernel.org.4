Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0AC73032F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbjFNPOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343608AbjFNPOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:14:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821AE2101;
        Wed, 14 Jun 2023 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UbFlhjvrs4yVUIifiHFAt8+Ke12wfSm4l9j/zsHycX4=; b=sg4IjbsCmgg1KldkL37VIqOk/v
        0iaB3rRbD/ol+9WGiDHXY+cwG0257Tu8u3myIJlRD8+quu0f3VaibDaaxuID31a36RN+6mFlI0OMC
        JMmWXn7qZ8B/2Qmy6lIvU1bkREP+KcKZ3REG8NGt4hpY+RJ7mVRveS8D9Atz5/n84luLJHzfeZqYa
        iKpX9EtfJKKsTB6cNbve0WKvuqwRiGq43/fAysVvAOzXGJfWFSO2nkZYEnciOJTdUXHvBbhzBgplb
        Zg383lL3VMhUfDtn6ZxbPXK9t3d9fTAjsxunAtjdXNg+jtNRvgFqJLZU+cHfeQFt02PDubwFtCXuE
        9GaNedfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9SBx-006SiF-U1; Wed, 14 Jun 2023 15:13:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E179D300195;
        Wed, 14 Jun 2023 17:13:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAC31240FDF97; Wed, 14 Jun 2023 17:13:48 +0200 (CEST)
Date:   Wed, 14 Jun 2023 17:13:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230614151348.GM1639749@hirez.programming.kicks-ass.net>
References: <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
 <3402dcc4-d52f-d99f-e6ce-b435478a5a59@amd.com>
 <20230614081757.GA1639749@hirez.programming.kicks-ass.net>
 <ZInVjPRLsyaKksfZ@chenyu5-mobl2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZInVjPRLsyaKksfZ@chenyu5-mobl2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:58:20PM +0800, Chen Yu wrote:
> On 2023-06-14 at 10:17:57 +0200, Peter Zijlstra wrote:
> > On Tue, Jun 13, 2023 at 04:00:39PM +0530, K Prateek Nayak wrote:
> > 
> > > >> - SIS_NODE_TOPOEXT - tip:sched/core + this patch
> > > >>                      + new sched domain (Multi-Multi-Core or MMC)
> > > >> 		     (https://lore.kernel.org/all/20230601153522.GB559993@hirez.programming.kicks-ass.net/)
> > > >> 		     MMC domain groups 2 nearby CCX.
> > > > 
> > > > OK, so you managed to get the NPS4 topology in NPS1 mode?
> > > 
> > > Yup! But it is a hack. I'll leave the patch at the end.
> > 
> > Chen Yu, could we do the reverse? Instead of building a bigger LLC
> > domain, can we split our LLC based on SNC (sub-numa-cluster) topologies?
> >
> Hi Peter,
> Do you mean with SNC enabled, if the LLC domain gets smaller? 
> According to the test, the answer seems to be yes.

No, I mean to build smaller LLC domains even with SNC disabled, as-if
SNC were active.


