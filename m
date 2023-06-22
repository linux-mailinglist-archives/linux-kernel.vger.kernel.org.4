Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE5C739DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjFVJv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjFVJvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:51:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73583AD05;
        Thu, 22 Jun 2023 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GIRkJ9xBSI9qzG3Aq2E0VHbn9jmHIdB63mJn4oOnJd4=; b=Vsylbf9yg8HFGDmU9o87kvXJFj
        YIDeQUSpR3gmRDEb6wu2lIngamtpNoncgU7ddfm2nw7xNYMw25rqynfQwQnZqXsd/x+VEb2tR1YaP
        +U/AFc6F4G/pVeK8F5q/B2LjcfP5praVDbvAx/4XZES8OncCKktL3v65nsZhsWpbh0KRPg2A9OKGE
        qNI1PSjFAW9OllGkC0/Z/ygZ0SMDzWWjMd/g6lgGpkRm9iCl5Aw1pJ6s0kzYTpTo7guKRb/wATGNl
        +w+Ji0ejwNG0RLTKU1AbbBJb6qIAN8svTx4o8nORDlMWJ/QKyxULK2QxKDqswNGDk2bDd1EekDlyJ
        MBZUIFtA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCGo9-00FTiX-86; Thu, 22 Jun 2023 09:40:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0577E300338;
        Thu, 22 Jun 2023 11:40:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6D8324216AD3; Thu, 22 Jun 2023 11:40:51 +0200 (CEST)
Date:   Thu, 22 Jun 2023 11:40:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v3 2/3] intel_idle: Sync up the SPEC_CTRL MSR value to
 x86_spec_ctrl_current
Message-ID: <20230622094051.GF4253@hirez.programming.kicks-ass.net>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-3-longman@redhat.com>
 <20230622054633.ulrurzzvzjijvdhn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622054633.ulrurzzvzjijvdhn@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:46:33PM -0700, Josh Poimboeuf wrote:
> On Wed, Jun 21, 2023 at 08:36:02PM -0400, Waiman Long wrote:
> > When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to
> > 0 in order disable IBRS. However, the new MSR value isn't reflected
> > in x86_spec_ctrl_current which is at odd with the other code that
> > keep track of its state in that percpu variable. Fix that by updating
> > x86_spec_ctrl_current percpu value to always match the content of the
> > SPEC_CTRL MSR.
> 
> Is this fixing an actual bug or is there some other reason for doing
> this?

No actual bug, he did this for his debugfs file -- which is no longer
part of the series. With that on, you can observe the
x86_spec_ctrl_current value while idle.

Arguably that's not even inconsistent because we disable/enable the
thing with IRQs disabled, so nothing can observe the difference.
