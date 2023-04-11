Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB1D6DD2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjDKGfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDKGfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:35:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDEA19B9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:35:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwbgT45QWz4x5c;
        Tue, 11 Apr 2023 16:35:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681194918;
        bh=0i/MF7gCE+jfpYMfZkmVNN8a0eFIvK4cruWauVxTQbw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bO8CmLMX11x3bONJMQkIhMGrq3f6X9/72wZE99FbwZb5H4yxTe1vFXU6/nU5PZjgA
         cFPWfKyuFNSrJXWEFjnZwBRNs1/EcmGNd9P+tTfUbVmMx/VBI701Wt0JoE33mTrTmM
         dC5hTT7Est3+86XxLhH6HltofYtb4h2v6yluihpVqMw81+GKKQ4hhCXwbx7xWAnbQP
         MxhQuK8p/mLlsdjVue8lbhV0ssup5KcOMgztRG1zftko3XMKZ7blwIdEyu72uQP9YE
         /t56nGXyMOEMWvYO/mEtRNmBadXl97YCOeuKvo1pgWrqdeekprToiZSXDy40LGQeIq
         JfMg1eQ4wjLUA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: book3s_hv_nested.c: improve branch
 prediction for k.alloc
In-Reply-To: <ZDTpGsT15s0iOrTJ@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230407093147.3646597-1-kconsul@linux.vnet.ibm.com>
 <ZDAeuL2fz1aEW6rz@debian.me> <ZDA+WdiqB2931xHB@google.com>
 <ZDTpGsT15s0iOrTJ@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
Date:   Tue, 11 Apr 2023 16:35:10 +1000
Message-ID: <873557j59d.fsf@mpe.ellerman.id.au>
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
> On 2023-04-07 09:01:29, Sean Christopherson wrote:
>> On Fri, Apr 07, 2023, Bagas Sanjaya wrote:
>> > On Fri, Apr 07, 2023 at 05:31:47AM -0400, Kautuk Consul wrote:
>> > > I used the unlikely() macro on the return values of the k.alloc
>> > > calls and found that it changes the code generation a bit.
>> > > Optimize all return paths of k.alloc calls by improving
>> > > branch prediction on return value of k.alloc.
>> 
>> Nit, this is improving code generation, not branch prediction.
> Sorry my mistake.
>> 
>> > What about below?
>> > 
>> > "Improve branch prediction on kmalloc() and kzalloc() call by using
>> > unlikely() macro to optimize their return paths."
>> 
>> Another nit, using unlikely() doesn't necessarily provide a measurable optimization.
>> As above, it does often improve code generation for the happy path, but that doesn't
>> always equate to improved performance, e.g. if the CPU can easily predict the branch
>> and/or there is no impact on the cache footprint.

> I see. I will submit a v2 of the patch with a better and more accurate
> description. Does anyone else have any comments before I do so ?
 
In general I think unlikely should be saved for cases where either the
compiler is generating terrible code, or the likelyness of the condition
might be surprising to a human reader.

eg. if you had some code that does a NULL check and it's *expected* that
the value is NULL, then wrapping that check in likely() actually adds
information for a human reader.
    
Also please don't use unlikely in init paths or other cold paths, it
clutters the code (only slightly but a little) and that's not worth the
possible tiny benefit for code that only runs once or infrequently.

I would expect the compilers to do the right thing in all
these cases without the unlikely. But if you can demonstrate that they
meaningfully improve the code generation with a before/after
dissassembly then I'd be interested.

cheers
