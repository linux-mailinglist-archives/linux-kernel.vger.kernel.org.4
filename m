Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8444562E6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiKQVSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbiKQVR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:17:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6689984334
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:55 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y203so2985953pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7lCHfRItoVgEuH12a2Mks7lBSPSXZSQzuXgs8OSirI=;
        b=Q4b7l3elIhePbNo4ocmXOKzQ9mQpM0uyG0mfme5yue9qWYKZgzmj8YwNgz/WsoVPNN
         S5PQx5tzK/LK2Ec2FQRMN+rx7iQUhyzMoPyRXVZsTZ9IBMbqBxRa6Ts6LRBacGdYp4My
         /k+ScWuqhACCUU+MthvvG/HbFqoGmT1bo25V7F8Vin+G2Mo6v1vgslyiXaWG1buWZxdJ
         hfsOenUyGIFCl+lG3OcZ1qC26keIzL0UPL5vtQk2hgOO+dqJhqNfVAzz68AkxcteDn4y
         bf0zCztptbocL+HtVZvPNMh6rrPAWLdIxAhdapOpV7xlz/wslYgvgGJF90vyd0CQyNge
         Mstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7lCHfRItoVgEuH12a2Mks7lBSPSXZSQzuXgs8OSirI=;
        b=MLHKICm95DWVd5Kf6pd2nox8TZuQJFYPmjoY7H5nGJcUnXVm7Y0ZAIpRJsB8Nn4q4i
         4scMM5aEx9sudtH8r/jpE2DCw6Wx3FFEaAj+sHRQvIf+FJFexyk9aQ5nbEmlJ5aOjEoo
         ngt+U1ynieY3d/AGy/wPPkQP1K2+vgeF4P496gZVVwT2DVPutoXe5IX+7dKv3TXz4Fo2
         hF12rez9NyPlYBD9XfnT9L+uyyG8Hr2BrxXx+HGudmwe+Rq6T9gLBGZt7ucKUejd2L2i
         +EvJ7mH9qqXAhTunry5hzr64dHeOvKhnQRIzTJCzE4A37WepwvbT5+o59YOzsO+dU5I2
         mV7Q==
X-Gm-Message-State: ANoB5pkWCWWz0ZrkWeS5rMUOfJhhwtlElT8kZAE9aiEZStewtfvGepHt
        /RO5SnrNId5GAhveiCFpOcgrRA==
X-Google-Smtp-Source: AA0mqf4B0z4lD3FVz9t8mBX8+7D0QX1G3p2MIcsFLd+TkIbwQUMmkjNjeJCdyquooYa8ucQkH3PuRw==
X-Received: by 2002:a63:117:0:b0:476:f43d:913e with SMTP id 23-20020a630117000000b00476f43d913emr3707293pgb.386.1668719754196;
        Thu, 17 Nov 2022 13:15:54 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090a46cc00b0021877447313sm1650957pjg.24.2022.11.17.13.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:15:53 -0800 (PST)
Date:   Thu, 17 Nov 2022 21:15:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Message-ID: <Y3akhjmJEcD0nDK/@google.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
 <CALCETrW1doHX3=za+KDuB=4y+wHsnaZpVkDP3OhZXGrQU2iffw@mail.gmail.com>
 <2f191ddb-de89-52c0-e7da-26ac0239b8fe@efficios.com>
 <Y3KpxR4ABRxvD+kj@google.com>
 <273f4883-25bc-44ad-9c35-3950ca8a3fcf@efficios.com>
 <Y3aHMTNv0yiyHCun@google.com>
 <a1b401e7-cbfa-0add-17fe-ebb2ae54850c@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1b401e7-cbfa-0add-17fe-ebb2ae54850c@efficios.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022, Mathieu Desnoyers wrote:
> On 2022-11-17 14:10, Sean Christopherson wrote:
> > On Thu, Nov 17, 2022, Mathieu Desnoyers wrote:
> > > On 2022-11-14 15:49, Sean Christopherson wrote:
> > > > On Fri, Nov 11, 2022, Mathieu Desnoyers wrote:
> > > > > On 2022-11-10 23:41, Andy Lutomirski wrote:
> > > > > > On Thu, Nov 3, 2022 at 1:05 PM Mathieu Desnoyers
> > > > > > <mathieu.desnoyers@efficios.com> wrote:
> > > > > > Also, in my mind "virtual cpu" is vCPU, which this isn't.  Maybe
> > > > > > "compacted cpu" or something?  It's a strange sort of concept.
> > > > > 
> > > > > I've kept the same wording that has been introduced in 2011 by Paul Turner
> > > > > and used internally at Google since then, although it may be confusing if
> > > > > people expect kvm-vCPU and rseq-vcpu to mean the same thing. Both really end
> > > > > up providing the semantic of a virtually assigned cpu id (in opposition to
> > > > > the logical cpu id on the system), but this is much more involved in the
> > > > > case of KVM.
> > > > 
> > > > I had the same reaction as Andy.  The rseq concepts don't worry me so much as the
> > > > existence of "vcpu" in mm_struct/task_struct, e.g. switch_mm_vcpu() when switching
> > > > between KVM vCPU tasks is going to be super confusing.  Ditto for mm_vcpu_get()
> > > > and mm_vcpu_put() in the few cases where KVM currently does mmget()/mmput().
> > > 
> > > I'm fine with changing the wording if it helps make things less confusing.
> > > 
> > > Should we go for "compact-cpu-id" ? "packed-cpu-id" ? Other ideas ?
> > 
> > What about something like "process-local-cpu-id" to capture that the ID has meaning
> > only within the associated address space / process?
> 
> Considering that the shorthand for "memory space" is "VM" in e.g. "CLONE_VM"

No objection from me for "vm", I've already had to untrain myself and remember
that "vm" doesn't always mean "virtual machine" :-)

> clone(2) flags, perhaps "vm-cpu-id", "vm-local-cpu-id" or "per-vm-cpu-id" ?

I have a slight preference for vm-local-cpu-id, but any of 'em work for me.
