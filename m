Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AE271962D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjFAI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjFAI7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:59:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B5119;
        Thu,  1 Jun 2023 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xmMkHzGdzpjqRjrvVYimkISzPUzm7dBn70bajFZ+I2c=; b=MlgHun9WGr1HjxDFXuy4L7QI+e
        DSpMW4DJ5ONl0ltimC6YRZhTCmq+E9L39CHUv/7tKL1wLVgMN1P4DdovDHQvx1ycs8LQWdNurgZZG
        E6qbRtfiRZyqXX8Ym7fMuFjRMXfNezuhHj2TFJ6lppKTgjpuPY4ECRnmnLHZ/mNa0NL15aILni1yC
        Qy2vtwA5YtJmlUSjiJRbl/6CURleiUPT5W7wWvNLJepgVwaakz+1vPNwLz8PCQO2+QitObCnSsMRm
        IqDRof7njSYC1+YwAQggUmtqF1TD0SlnzcDAa+oqEw4E+QqfsbM/WEyoOOU+RjoADuqDL7+WzO39O
        TtiCMUvg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4e8f-00H7SI-0r;
        Thu, 01 Jun 2023 08:58:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06E0430031F;
        Thu,  1 Jun 2023 10:58:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8F1021484ABE; Thu,  1 Jun 2023 10:58:31 +0200 (CEST)
Date:   Thu, 1 Jun 2023 10:58:31 +0200
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
Message-ID: <20230601085831.GH38236@hirez.programming.kicks-ass.net>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
 <20230601085602.GR4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601085602.GR4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 10:56:03AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 01:45:35PM +0500, Muhammad Usama Anjum wrote:
> > Hi,
> > 
> > I've been looking into a problem where Windows applications misbehave
> > across suspend/resume when run on Wine on x86. These applications see time
> > going backwards. The timestamp counter (TSC) is reset when system resumes.
> > In case of Windows on Intel and AMD, the timestamp is saved and restored
> > when the system resumes from suspend.
> > 
> > These applications read timestamp by rdtsc directly. These calls cannot be
> > intercepted by Wine. The application should be fixed such that it handles
> > these scenarios correctly. But there are hundreds of applications which
> > cannot be fixed. So some support is required in Wine or kernel. There isn't
> > anything which Wine can do as rdtsc call directly reads the timestamp. The
> > only option is that we support something in kernel.
> > 
> > As more and more things are being added to Wine, Windows application can be
> > run pretty easily on Linux. But this rdtsc is a big hurdle. What are your
> > thoughts on solving this problem?
> > 
> > We are thinking of saving and restoring the timestamp counter at suspend
> > and resume time respectively. In theory it can work on Intel because of
> > TSC_ADJUST register. But it'll never work on AMD until:
> > * AMD supports the same kind of adjust register. (AMD has said that the
> > adjust register cannot be implemented in their firmware. They'll have to
> > add it to their hardware.)
> > * by manual synchronization in kernel (I know you don't like this idea. But
> > there is something Windows is doing to save/restore and sync the TSC)
> 
> Wine could set TIF_NOTSC, which will cause it to run with CR4.TSD
> cleared and cause RDTSC to #GP, at which point you can emulate it.

The other option is to have Wine run itself in a (KVM) virtual machine
and mess with the VMM TSC offset :-)
