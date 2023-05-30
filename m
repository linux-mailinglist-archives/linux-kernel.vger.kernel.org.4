Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7F715D68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjE3LjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjE3LjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:39:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516B8D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=skgjR6F9DHItr1aoTfD98GCYAxTdEkl5N8rKLD6rD1A=; b=FFrz0zlUhXRN2WkhehcXnR6Ezo
        8+o+IZTNVU9f4UlhKlCzjDTwmg5hrpcpVa6lWQRqU1UQ1BTH90595lsEAqFzhiDhB7F8dBswO0Kta
        /Rs799usj0ZhOUIu0mVH+I3a9IWfT8m721VAiDxC1aWj/MC876ba4HJLCvs5XbCwJ18ud979baL9H
        ogod+KpJkwv0rbFlGYQz6ed24hGi2i4e3KbQfVNMpmtL68Jh0bGPIPcgkXaxpgl8vjqSHypcjQntc
        rH/SO9c29fc2LkVqzc4djrYEwO6gigYwjC3ytKAPnnoXOctdxs4A+ACA3EEyC2QncAAEXmQxBnd12
        0k/KQpmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q3xgG-00DhqP-1z;
        Tue, 30 May 2023 11:38:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 610CE300194;
        Tue, 30 May 2023 13:38:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CC5024AEF73C; Tue, 30 May 2023 13:38:20 +0200 (CEST)
Date:   Tue, 30 May 2023 13:38:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tim.c.chen@linux.intel.com, yu.c.chen@intel.com,
        gautham.shenoy@amd.com, mgorman@suse.de, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v8 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_lowest_cache API
Message-ID: <20230530113820.GB156198@hirez.programming.kicks-ass.net>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-2-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530070253.33306-2-yangyicong@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:02:52PM +0800, Yicong Yang wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> Add per-cpu cluster domain info and cpus_share_lowest_cache() API.

Lowest cache is weird; that would be L1, but your implementation is for
L2/L3.


