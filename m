Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C8B74EF86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGKM4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGKM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:56:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE106120
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r9i6weXtCQBIcpKSCSUwr85Jp5moQkqAZtJtqfjaqy0=; b=Adup15vWkIxKZXzhNA9pSTKVa5
        Ld1dmFFs5pUEF4yW7ZoNV5oxJCw2TWlnhMqq0uV9jSoDJqOpj8p+Kp5sgu62H6pBhX3T8XhkuyRzs
        Q6GsiOAlAH/C/xj5vDLskBqYAtyzQePFZri/SOG7HyhofEAHYyJhnqlVytjX+HNJ+qihWEL8aNg/y
        9odb8F2lK+9mYNM555PNZJb6odZlXLKGMxSsy8IJ3L1/c7MQ4W9JxmeWxb1hO5uUy7sIVbxZ26+f9
        LvkBPeiYW0MDJnb7LWeoKqupfVthXWMNkwXOHl9bzsGCv13ePGZ97OSKpoLUQymAB4LurR0pYBEhT
        dOTJU9QQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJCuM-002OpK-1Z;
        Tue, 11 Jul 2023 12:55:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FBA130014A;
        Tue, 11 Jul 2023 14:55:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A99A243A2FA5; Tue, 11 Jul 2023 14:55:57 +0200 (CEST)
Date:   Tue, 11 Jul 2023 14:55:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     arjan@linux.intel.com, rafael.j.wysocki@intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
Message-ID: <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:25:51PM +0200, Bruno Goncalves wrote:

> R640 2x  Intel(R) Xeon(R) Silver 4116 CPU @ 2.10GHz

Gawd, I hate our naming :/ Google tells me that is a skylake.

> and start the VM with:
> 
> -accel kvm -cpu
> Skylake-Server-IBRS,ss=on,vmx=on,pdcm=on,hypervisor=on,tsc-adjust=on,clflushopt=on,umip=on,pku=on,md-clear=on,stibp=on,arch-capabilities=on,ssbd=on,xsaves=on,ibpb=on,ibrs=on,amd-stibp=on,amd-ssbd=on,rsba=on,skip-l1dfl-vmentry=on,pschange-mc-no=on

You tell it to be a skylake

> The decoded call trace:

> /builds/4626306068/workdir/drivers/idle/intel_idle.c:1820

And that's skx_idle_state_table_update() reading
MSR_PKG_CST_CONFIG_CONTROL and that code has been around since 2021.

So things are somewhat consistent. But I find it weird that intel_idle
gets selected for a guest, I'm not exactly sure what's up with that.

Oohh, this vm-guest mode is new :/ But it doesn't make sense, that
commit babbles something about waking CPUs from idle to do TLB
invalidate, but that shouldn't be the case, that's what we have
kvm_flush_tlb_multi() for, it should avoid the IPI and flush on
vcpu-enter.

Arjan, what is the actual problem you're trying to solve any why hide
this in intel_idle ?
