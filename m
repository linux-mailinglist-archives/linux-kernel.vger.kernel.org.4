Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B91160FD87
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiJ0QxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbiJ0Qwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:52:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F4D19D88C;
        Thu, 27 Oct 2022 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HICjCe/T3KktXFKRv+wo+yHgKZxC3DJ5boYWFpCcesE=; b=ibo+HdQTm3+r0wK7uqOdAST2le
        gsw90CiCXIlAGkIzYEC7A+1vAxYVvC2H0hZ10bgepKdLD3/JvHNjHYDSLBj6+IMEOO2t04AEf1jU5
        lu5U0nhrME+intT5DAO17p3zcr7TRGet6GnYJ2BJhLU/oAH8PbQD7ZdsHHdw75fDQWPxqDqypniA2
        fTj5J2gsP69L25Yrd0GAmXLnost182Tc7hcAyZJFAw3ovutFVUEzk+DjqTdznsdJ2E+BrW0AIFxFL
        kvXKgp74xWaP05RzSk/0hHsCaffJDUb4wbrqJOGF1vL51uheP2Y1gdQ8hpRXL7tUPBTLBx0Q9kbfO
        u8asqKmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oo662-006uvv-BB; Thu, 27 Oct 2022 16:51:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D75330008D;
        Thu, 27 Oct 2022 18:51:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 374FA2C64658F; Thu, 27 Oct 2022 18:51:09 +0200 (CEST)
Date:   Thu, 27 Oct 2022 18:51:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Yujie Liu <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        fengwei.yin@intel.com, ying.huang@intel.com,
        fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [tip:x86/core] [kallsyms] f138918162:
 WARNING:CPU:#PID:#at_fs/xfs/xfs_message.c:#xfs_buf_alert_ratelimited.cold-#[xfs]
Message-ID: <Y1q2/fdvXI67MRch@hirez.programming.kicks-ass.net>
References: <202210241614.2ae4c1f5-yujie.liu@intel.com>
 <Y1kDEmLeRA2UGeF8@hirez.programming.kicks-ass.net>
 <Y1kiuTIYobR4nexS@hirez.programming.kicks-ass.net>
 <Y1nobODPLUjcteJ0@yujie-X299>
 <2543dfb1-d9dc-0888-dbea-e420a19d732c@intel.com>
 <Y1qv3ku6ULHy8hOF@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1qv3ku6ULHy8hOF@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> However, I noticed that the callsite in the WARNING: message has changed
> from the usual 'asswarn' (which is the caller of WARN_ON) to
> 'xfs_buf_alert_ratelimited', which seems totally wrong since XFS log
> recovery doesn't touch xfs_buf objects at all.

Yeah; and I've meanwhile found more cases where it goes sideways.

I'll revert this patch and try an alternative approach. I'll post
patches tomorrow or something.

Sorry about this.
