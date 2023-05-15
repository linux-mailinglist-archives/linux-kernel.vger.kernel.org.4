Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5708A70272E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjEOIbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjEOIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:31:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA4A3C34
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X+EJoB0FgKSLQ0AVaiesc5FlXVXJoE99TUZvwoxW8Lk=; b=vbaVdMFsBmx3HDKChh0n8j3aF7
        AWRMcMxIevB0BWEBWudm/ox1HPmgU+GogoDlrvIuXSO3GmhpMz94TF2DSoaF4xMowxkVgNSXa8ZnB
        2sxz2wwVsjScMsrgmwsublmkQe5Z1Bil448V9OcApSEv2j65X6Kf9/Gmfn29qFm9zsIKo0HOpqvoG
        /ayLxmJqvvTmwksf5LwKyeU2zNEcV3+OAwg3O2vN53+fo4TPZEIsIDCL40urjWbBU9Sj8uU8/Fjsn
        w46xOG90dwlH4+mWeYkcr/yWU94cH0MUUlU4+Oyor9EPQfkx+8BENfiIUCuv43kZVLlfEKcS5OcwR
        CC9qr6jw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyTY1-003IkN-1u; Mon, 15 May 2023 08:27:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35CFF30003A;
        Mon, 15 May 2023 10:27:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05141202FCE90; Mon, 15 May 2023 10:27:10 +0200 (CEST)
Date:   Mon, 15 May 2023 10:27:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     yang.yang29@zte.com.cn, mingo@redhat.com, axboe@kernel.dk,
        tj@kernel.org, hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/psi: avoid resetting the min update period
 when it is unnecessary
Message-ID: <20230515082710.GE4253@hirez.programming.kicks-ass.net>
References: <20230514163338.834345-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514163338.834345-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 09:33:38AM -0700, Suren Baghdasaryan wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Psi_group's poll_min_period is determined by the minimum window size of
> psi_trigger when creating new triggers. While destroying a psi_trigger,
> there is no need to reset poll_min_period if the psi_trigger being
> destroyed did not have the minimum window size, since in this condition
> poll_min_period will remain the same as before.
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> ---
> rebase of https://lore.kernel.org/all/202305121642367753446@zte.com.cn/
> over git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core branch

Thanks!
