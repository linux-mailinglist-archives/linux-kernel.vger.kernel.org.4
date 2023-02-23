Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2AB6A08A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjBWMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjBWMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:34:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49AE5328F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AcrbEGeFeStRBuJzvLjFTyBE4ZFyRLTI8fFgvXrJzTA=; b=pNe33g49dHtgLXgw6CmGJ8ppZu
        sP8siLGVX+JQ7/Rp0etV4R2EQRBcGli9lP9Ur72kRrt6tvuIi5/Hr8FLygE3OOnAnpqCLzADRxSgy
        C1iR/yLfSKOM01Ryj2jyYTkHTrp301FrdPAHZLMFyGl8AtcoerOdc4tCj2zfKNzxTBydcKbZP/LYN
        h/VREVkQw65K2NdTufvVBq1jVY+sEBP8TmF79ZPBGaiWwW4IaVZdB1Bi0gJf+hq92t8XJjoFhLLJM
        G6pwVdkViz7ZoYbUJJVKQVItg7gHym1u/wQATVY9UJPN67zWrPd84yW/TwoGeURriQwB3J/i5dYKt
        3+GMDbag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVAo0-00EMIj-Ov; Thu, 23 Feb 2023 12:34:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C99973001C3;
        Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AD2F02C539B20; Thu, 23 Feb 2023 13:34:35 +0100 (CET)
Message-ID: <20230223122642.491637862@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 23 Feb 2023 13:26:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     longman@redhat.com, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com
Subject: [PATCH 0/6] locking/rwsem: Rework writer wakeup and handoff
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these here few patches boot but are otherwise very much untested. Please test.


---
 kernel/locking/lock_events_list.h |   1 +
 kernel/locking/rwsem.c            | 430 +++++++++++++++++++-------------------
 2 files changed, 213 insertions(+), 218 deletions(-)


