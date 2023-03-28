Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0530C6CBE58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjC1MCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1MCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:02:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB1199
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:02:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pm7b53gtQz4x1N;
        Tue, 28 Mar 2023 23:02:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1680004929;
        bh=8FDe1fg4SUXw3vXWP1S6Odi0LQ6CVYYIgUVbgRZCZ3s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=m5cCeyYR2p3PPUbj/yrWGMmlLNwWye53nH07sVfKf3OocZC1+0spJyyrdR0mRUNWS
         +aylyoKZz8WfJPB6jdCGAD0jMGyOChQ6aPUNeJw5KfvvTNwnvZ7CQ2vJxFpKpfK22P
         48WYvkdJHQWgLr3DTLNOY25Itdjg+qZJ1QStFw2ekloTI3+aFlVPxK5Ahl1G6X5c8E
         uS8JqmQk/PO2NGrGrMlT8HyuejUo0LW8lTZb5E1EdpmpCog1gao0Ie4Gt3B9ynqlYz
         z/3UhKFL+W7A+K4QwIUA18WwAq3ioLcOUFwJfVgGLvha6fEl1kDCfG+rVhPqpH6nzZ
         cZ6w8g0oydlEA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc/kvm: kvmppc_core_vcpu_create_hv: check for
 kzalloc failure
In-Reply-To: <ZCLHFw1U4Mq/QK2A@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230323074718.2810914-1-kconsul@linux.vnet.ibm.com>
 <87pm8tcir3.fsf@mpe.ellerman.id.au>
 <ZCK96ohvWRY12zZ3@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZCLHFw1U4Mq/QK2A@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
Date:   Tue, 28 Mar 2023 23:02:09 +1100
Message-ID: <87fs9pcce6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
> On 2023-03-28 15:44:02, Kautuk Consul wrote:
>> On 2023-03-28 20:44:48, Michael Ellerman wrote:
>> > Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
>> > > kvmppc_vcore_create() might not be able to allocate memory through
>> > > kzalloc. In that case the kvm->arch.online_vcores shouldn't be
>> > > incremented.
>> > 
>> > I agree that looks wrong.
>> > 
>> > Have you tried to test what goes wrong if it fails? It looks like it
>> > will break the LPCR update, which likely will cause the guest to crash
>> > horribly.
> Also, are you referring to the code in kvmppc_update_lpcr()?
> That code will not crash as it checks for the vc before trying to
> dereference it.

Yeah that's what I was looking at. I didn't mean it would crash, but
that it would bail out early when it sees a NULL vcore, leaving other
vcores with the wrong LPCR value.

But as you say it doesn't happen because qemu quits on the first ENOMEM.

And regardless if qemu does something that means the guest is broken
that's just a qemu bug, no big deal as far as the kernel is concerned.

> But the following 2 places that utilize the arch.online_vcores will have
> problems in logic if the usermode test-case doesn't pull down the
> kvm context after the -ENOMEM vcpu allocation failure:
> book3s_hv.c:3030:       if (!kvm->arch.online_vcores) {
> book3s_hv_rm_mmu.c:44:  if (kvm->arch.online_vcores == 1 && local_paca->kvm_hstate.kvm_vcpu)

OK. Both of those look harmless to the host.

If we find a case where a misbehaving qemu can crash the host then we
need to be a bit more careful and treat it at least as a
denial-of-service bug. But looks like this is not one of those.

cheers
