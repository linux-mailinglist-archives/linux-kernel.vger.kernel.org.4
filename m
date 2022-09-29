Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB715EF436
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiI2LWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiI2LWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:22:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A527E149780
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8s1JifOy0cPNpzouKxvGh4Yyk4fI0qaKRu5cXLa+AmI=; b=LQpQq9BO8tmiEpHo+Mu+LesFu2
        UXuMFPKWaIO3mgZaRXGXplRgHZFf4rMHZstHGr2Mn+bj9xUl+6uoTc9LvXPbaC/yPaWO/Ho6MjkFD
        hiDmCsdkP6cI4fOQzUKUbz2nYMgO8IMu7kUmcUSM++sNTHwIexJhsjA7Da/+cAkjqjVAukHRAZuXX
        r5DdTBbjVBBssm7veJLvmLIDAio1dZ6R65kui2HbyiVf9p2DajNjim9hZri77lSlja4Hix0YZWkF3
        hzJdkqGB007oYBkxNjj+uVNSaozYtIdrL7iTnuFqBAm2fBZNjTyl3yDdHrKGXt2Dz8lfLFbGGXkUy
        KjjRd3Qg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odrbx-00DE3Q-W9; Thu, 29 Sep 2022 11:21:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F26B430013F;
        Thu, 29 Sep 2022 13:21:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D41402019CD2C; Thu, 29 Sep 2022 13:21:45 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:21:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     Jian-Min Liu <jian-min.liu@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:10:17PM +0100, Kajetan Puchalski wrote:

> Overall, the problem being solved here is that based on our testing the
> PELT half life can occasionally be too slow to keep up in scenarios
> where many frames need to be rendered quickly, especially on high-refresh
> rate phones and similar devices.

But it is a problem of DVFS not ramping up quick enough; or of the
load-balancer not reacting to the increase in load, or what aspect
controlled by PELT is responsible for the improvement seen?
