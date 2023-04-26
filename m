Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CB6EF00D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbjDZIP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbjDZIPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:15:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCD3591;
        Wed, 26 Apr 2023 01:15:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682496949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7cSCpTFBU6gtNFDDvX9BBXJHGwRYvRyuVYMZSUvskg=;
        b=puMJndFvZk2DjG2oGhTaaANtFluqIT71fJ8veXKWgaKYEc7ZaIibudafgbLM64wYizw2Y+
        OXOoExk0mzZdwI+qZRCbqqN29gJr4bx9hGMM4FqEkCO4H6WN381K3f/yJnQUdMhiDoudkE
        v7q+YkKqQYiLDFXvBw9Q1TAKdQtU3EOXylf0wOjoPixyD8dhvyM5BYTWe0qo092Dn58dWD
        wK5mQfTO6pClT3oj6wx4w2PqZTUsjxsf5TLo5xJWNv/gc/U3RQVFJKGrWcJS7Q1p/NUtUU
        aUWCZ+sybUxpx87tAuGvu76aAkAfxwkf6VweEiexDbnjkrDzfgfAwBP2nQkz6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682496949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7cSCpTFBU6gtNFDDvX9BBXJHGwRYvRyuVYMZSUvskg=;
        b=4JTA5ZSC1xgsH2IPcOsiykb/g/HrD1bcjGUJcIN8iOa9ku/bVlaHwu78ldM0LGCo2BtXJa
        9xfjqD5Ed8VSHzCw==
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Sabin Rapan <sabrapan@amazon.com>
Subject: Re: [patch 22/37] arm64: smp: Switch to hotplug core state
 synchronization
In-Reply-To: <ZEjZ3pHjQWn4drs8@FVFF77S0Q05N>
References: <20230414225551.858160935@linutronix.de>
 <20230414232310.569498144@linutronix.de> <ZD1q3TF2ixVD1f2M@FVFF77S0Q05N>
 <87ttx3zqof.ffs@tglx> <ZEjZ3pHjQWn4drs8@FVFF77S0Q05N>
Date:   Wed, 26 Apr 2023 10:15:48 +0200
Message-ID: <87ildjys7f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26 2023 at 08:59, Mark Rutland wrote:
> On Tue, Apr 25, 2023 at 09:51:12PM +0200, Thomas Gleixner wrote:
>> If not then it's just yet another way of DoS which is an "acceptable"
>> attack as it only affects availability but not confidentiality.
>
> Sure.
>
> My thinking is that this is an attack against the *integrity* of the guest
> (since the vCPU that gets unpasued may write to memory), and so it's
> potentially more than just a DoS.
>
> I only mention this because I'd like to account for that on arm64, and if other
> architectures also wanted to handle that it might make sense to have some
> common infrastructure to track whether CPUs are potentially still within the
> kernel.

Fair enough.
