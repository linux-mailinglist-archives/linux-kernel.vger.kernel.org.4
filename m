Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7666CF7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjC2X73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjC2X71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:59:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4523C03
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:59:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pn3S816GNz4xDn;
        Thu, 30 Mar 2023 10:59:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1680134360;
        bh=QjU/3+HiBzvoD78RQQNgOACB6ehBJw/P/6iRJxUBDyo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=in9YqqklVEuhZ4RAJvrGnZpVvzZKa0iFvTasr4dGVU11K1xIULrTEsOjqio4zrxBq
         0abG6VEPkZ0qDCtyUZeOyJcz/LbuD0tZ7aNNY1PhwmPslm/ozPoel60SBWi7eFbsM0
         wVAkpDhQZMzB/OoMdLXqRX6CLwyi+CvndbdWepQWLnhftOtUw9Qw0dH2YSOHtAkVzq
         tfIhsBnGCrq/Rfr0BpNQow712QXrXMSiV8YtjtiL2pP8LlC0R/u5P+t//P7Dbceelv
         GnSiNYwQYjSgpyQANKqMkT3zd/GZx6ekk+jPbZYCywnApYpfqrxqMtg+wBcxchl16x
         Nd9uj5uptR/WQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc/kvm: kvmppc_core_vcpu_create_hv: check for
 kzalloc failure
In-Reply-To: <ZCLe2Jf0n6GR9Qhw@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230323074718.2810914-1-kconsul@linux.vnet.ibm.com>
 <87pm8tcir3.fsf@mpe.ellerman.id.au>
 <ZCK96ohvWRY12zZ3@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZCLHFw1U4Mq/QK2A@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <87fs9pcce6.fsf@mpe.ellerman.id.au>
 <ZCLe2Jf0n6GR9Qhw@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
Date:   Thu, 30 Mar 2023 10:59:19 +1100
Message-ID: <87tty3az3c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
> On 2023-03-28 23:02:09, Michael Ellerman wrote:
>> Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
>> > On 2023-03-28 15:44:02, Kautuk Consul wrote:
>> >> On 2023-03-28 20:44:48, Michael Ellerman wrote:
>> >> > Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
>> >> > > kvmppc_vcore_create() might not be able to allocate memory through
>> >> > > kzalloc. In that case the kvm->arch.online_vcores shouldn't be
>> >> > > incremented.
>> >> > 
>> >> > I agree that looks wrong.
>> >> > 
>> >> > Have you tried to test what goes wrong if it fails? It looks like it
>> >> > will break the LPCR update, which likely will cause the guest to crash
>> >> > horribly.
>> > Also, are you referring to the code in kvmppc_update_lpcr()?
>> > That code will not crash as it checks for the vc before trying to
>> > dereference it.
>> 
>> Yeah that's what I was looking at. I didn't mean it would crash, but
>> that it would bail out early when it sees a NULL vcore, leaving other
>> vcores with the wrong LPCR value.
>> 
>> But as you say it doesn't happen because qemu quits on the first ENOMEM.
>> 
>> And regardless if qemu does something that means the guest is broken
>> that's just a qemu bug, no big deal as far as the kernel is concerned.

> But there could be another user-mode application other than qemu that
> actually tries to create a vcpu after it gets a -ENOMEM for another
> vcpu. Shouldn't the kernel be independent of qemu?

Yes, the kernel is independent of qemu.

On P8 we had kvmtool, and there's several other VMMs these days, though
most don't support Power.

I didn't mean qemu specifically above. If any VMM continues blindly
after getting ENOMEM back from the KVM API then that's a bug in that
VMM.

>> > But the following 2 places that utilize the arch.online_vcores will have
>> > problems in logic if the usermode test-case doesn't pull down the
>> > kvm context after the -ENOMEM vcpu allocation failure:
>> > book3s_hv.c:3030:       if (!kvm->arch.online_vcores) {
>> > book3s_hv_rm_mmu.c:44:  if (kvm->arch.online_vcores == 1 && local_paca->kvm_hstate.kvm_vcpu)
>> 
>> OK. Both of those look harmless to the host.

> Harmless to the host in terms of a crash, not in terms of behavior.
> For example in the case of kvmhv_set_smt_mode:
> If we got a kzalloc failure once (and online_vcores was wrongly incremented), 
> then if kvmhv_set_smt_mode() is called after that then it would be
> not be setting the arch.smt_mode and arch.emul_smt_mode correctly and it
> would be wrongly returning with -EBUSY instead of 0.

But again that bug only affects that VM, which the VMM should have
terminated when it got the ENOMEM back.

It's definitely a bug that we increment online_vcores incorrectly, but
it only affects that VM, and a correctly operating VMM will terminate
the VM anyway because of the ENOMEM.

cheers
