Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BA671961F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjFAI4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFAI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:56:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C159F;
        Thu,  1 Jun 2023 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IERKOjEKyf18wgepZ6PVsFyXGDY0D1hSJu6aJ7xPHYM=; b=ASQCSikna46d++tN1LTNTf4e43
        3biFaP5qTr34eQ05eGHmxSTBgf2+axXRW5TzGuAhL3YbLrwCarpwkaV2jrYfMAvU6R0MaHkf/ry5L
        GdvIY7eESaJ9FKMd2kenXy+D/vATlabu11EtsptKZ1dMWGvIDG3hr4rk2z1XyKDMCKZsk9JDrCx8/
        Pplb87cH88Uo29iBO9RvkT/mzBZvnMerDRrCLX1g4scRUDeLUmlxd4iG5OQzhYtCvROJ7LiuJ7Bq5
        OqSgP/4/dQE5a/S6jIWhiFdlJhViVlSbQgGAX8vf3KF/4FJ0VZHl3Z3k6QgCac0rkwT+hz9rd8Ku9
        wttg8n2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4e6G-008C8h-OU; Thu, 01 Jun 2023 08:56:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2782330031F;
        Thu,  1 Jun 2023 10:56:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B9D021484ABE; Thu,  1 Jun 2023 10:56:03 +0200 (CEST)
Date:   Thu, 1 Jun 2023 10:56:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Steven Noonan <steven@uplinklabs.net>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
Message-ID: <20230601085602.GR4253@hirez.programming.kicks-ass.net>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 01:45:35PM +0500, Muhammad Usama Anjum wrote:
> Hi,
> 
> I've been looking into a problem where Windows applications misbehave
> across suspend/resume when run on Wine on x86. These applications see time
> going backwards. The timestamp counter (TSC) is reset when system resumes.
> In case of Windows on Intel and AMD, the timestamp is saved and restored
> when the system resumes from suspend.
> 
> These applications read timestamp by rdtsc directly. These calls cannot be
> intercepted by Wine. The application should be fixed such that it handles
> these scenarios correctly. But there are hundreds of applications which
> cannot be fixed. So some support is required in Wine or kernel. There isn't
> anything which Wine can do as rdtsc call directly reads the timestamp. The
> only option is that we support something in kernel.
> 
> As more and more things are being added to Wine, Windows application can be
> run pretty easily on Linux. But this rdtsc is a big hurdle. What are your
> thoughts on solving this problem?
> 
> We are thinking of saving and restoring the timestamp counter at suspend
> and resume time respectively. In theory it can work on Intel because of
> TSC_ADJUST register. But it'll never work on AMD until:
> * AMD supports the same kind of adjust register. (AMD has said that the
> adjust register cannot be implemented in their firmware. They'll have to
> add it to their hardware.)
> * by manual synchronization in kernel (I know you don't like this idea. But
> there is something Windows is doing to save/restore and sync the TSC)

Wine could set TIF_NOTSC, which will cause it to run with CR4.TSD
cleared and cause RDTSC to #GP, at which point you can emulate it.


