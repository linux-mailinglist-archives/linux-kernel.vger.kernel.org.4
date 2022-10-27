Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EBD60F197
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiJ0Hyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiJ0Hyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:54:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40D627B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RO3+Ms54cmiEAtpIFy0zI5rJu5Dg4jt0Si4uzbTVVAs=; b=brzCsqRECX0WGxeVNZX14pXjPI
        1Hw+qgYmIPcD8h/lzfAvuwX5l0CRt3G5Xe82cvHHamQnsYpc3Xp5jaeLC+1lZXS9GG/ERiWiYQIhG
        Ve1ZLE5U8jR4AqQRlBfvnN3zZj4DSqrVelJG8i05Qw9JXXh4MWtKVz7dYmtFp0DK+A4MNZc1QYvaG
        34WVVOpgJHJD5xawDGcFlWrj3LPqfA0ivJog2GeSSG4dCZ6D4vPYVqVvieE+JqG0dOOuW5n44LKun
        iaocvPGpnoHqCDELUIoxUELfTVTcQNRtpNdnB/bVVYEqTc1ruCQ7oSmWug59KGEeRvNPNbE+QOa7r
        QaysseIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onxiQ-0001w3-FN; Thu, 27 Oct 2022 07:54:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 484B3300322;
        Thu, 27 Oct 2022 09:54:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C46A2012B90F; Thu, 27 Oct 2022 09:54:09 +0200 (CEST)
Date:   Thu, 27 Oct 2022 09:54:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove max_vruntime() and min_vruntime()
Message-ID: <Y1o5ILxBd9erW5zR@hirez.programming.kicks-ass.net>
References: <20221027015351.2511149-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027015351.2511149-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 09:53:51AM +0800, Yajun Deng wrote:
> There is no need to write max_vruntime() and min_vruntime() functions,
> we can use max_t() and min_t() instead.

Here; I did your homework for you:

/* max.c */
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

typedef unsigned long long u64;
typedef unsigned long long s64;

static u64 max_vruntime(u64 max_vruntime, u64 vruntime)
{
	s64 delta = (s64)(vruntime - max_vruntime);
	if (delta > 0)
		max_vruntime = vruntime;
	return max_vruntime;
}

static u64 max(u64 a, u64 b)
{
	return a > b ? a : b;
}

int main(int argc, char **argv)
{
	u64 a, b;

	if (argc < 3)
		return 0;

	a = strtoll(argv[1], NULL, 10);
	b = strtoll(argv[2], NULL, 10);
	printf("         max(%lu, %lu) = %lu\n", a, b, max(a,b));
	printf("max_vruntime(%lu, %lu) = %lu\n", a, b, max_vruntime(a,b));

	return 0;
}

$ ./max -1 0
         max(18446744073709551615, 0) = 18446744073709551615
max_vruntime(18446744073709551615, 0) = 0
