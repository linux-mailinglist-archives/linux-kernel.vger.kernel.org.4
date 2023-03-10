Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BE36B5437
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjCJWYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjCJWYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:24:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B84EABAF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4C41B8240F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F2CC4339B;
        Fri, 10 Mar 2023 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678487037;
        bh=PF0r4oVSKwz6Sa0zCwkYZE9andpuDXiknZlr22VUKsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlIORatf08lO6gcjJ+16V7UhuFJZfk7ujZejaqcstA+ZavFBZfqkhk73ruql2eHjX
         tQWw7FcMM1vrgGQyk0w1QdPcLgVkwdZzmjt3tb6JFa4GVKGhE9f7TiSfDjQZ7ORZ9K
         6oBQjCMy2FA8qgxAMSvwzH7iGWbTeqWZu1mF4R0rvQxDdRiwjC4zHA5wRGTbsNZ+Y/
         ac1Ul43HKHi3czOpkQyeUMXxJ7eP0IcYOewjLfrIgpR1G5yQ7QstIHfEffmyAlzF27
         7YYiZF0pgNQIAGARKyDnZVvqvHA5LWdeN92AFURCPIVJSaZuf5/2yRNjOuIR/Kk/sS
         pEYw7nn7lu6gQ==
Date:   Fri, 10 Mar 2023 14:23:55 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC][PATCH 5/5] x86/kvm: Simplify static call handling
Message-ID: <20230310222355.digoem4orcpft2t6@treble>
References: <cover.1678474914.git.jpoimboe@kernel.org>
 <432e4844ba65840af4a24f5e3f561aead867f6e7.1678474914.git.jpoimboe@kernel.org>
 <ZAucD8gHx8Xp8Dlb@google.com>
 <20230310161354.1889b539@gandalf.local.home>
 <ZAuhQNS8mjRt1bOG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAuhQNS8mjRt1bOG@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:29:36PM +0000, Sean Christopherson wrote:
> > > I would much prefer to keep KVM mostly as-is, specifically so that we don't lose
> > > this WARN_ON() that guards against a vendor module neglecting to implement a
> > > mandatory callback.  This effectively gives KVM "full" protection against consuming
> > > an unexpectedly-NULL function pointer.

Ok, sure.

> > As in my reply to patch 0/5, I suggested that static_call_update(NULL)
> > would trigger a WARN_ON() always. Then this could be cleaned up and still
> > get that warning.
> 
> I don't think that provides the functionality KVM wants/needs.  KVM only disallows
> NULL updates for select mandatory hooks.  For optional hooks, KVM needs to support
> NULL updates in some capacity to handle the scenario where a vendor module is
> reloaded with different settings, e.g. loading kvm_intel with enable_apicv=0 after
> running with enable_apicv=1.
> 
> WARN_ON() a static_call_update(..., NULL) should be ok, but I believe KVM would
> still need/want macro shenanigans, e.g.
> 
> #define __KVM_X86_OP(func) \
> 	static_call_update(kvm_x86_##func,
> 			   kvm_x86_ops.func ? kvm_x86_ops.func : STATIC_CALL_NOP);
> #define KVM_X86_OP(func) \
> 	WARN_ON(!kvm_x86_ops.func); __KVM_X86_OP(func)
> #define KVM_X86_OP_OPTIONAL __KVM_X86_OP
> #define KVM_X86_OP_OPTIONAL_RET0(func) __KVM_X86_OP

Yeah, something like that might be ok, if we just refuse NULL as an
option.

If only Peter hadn't ruined my Friday with the CFI talk.

-- 
Josh
