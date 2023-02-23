Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8716A04B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjBWJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjBWJYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:24:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2459A4DBC8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:24:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMnfV625vz4x5c;
        Thu, 23 Feb 2023 20:24:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677144274;
        bh=hFqhrt7u1WjD0sRxb0fgkvK3+Rpur1bct1FveQKjbjs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RtK2SFUch390YqXaK8RsAUngH74SLzJwAiXdlkX/eacGVfL9iaHhRMv0lAl4FEjNh
         LfksbWPPg5AMgAM3zgVVyU0j1ptpMoGBmUP1stTMbAynR6z3Y3r2BqStqR/+IN971L
         0O6arDFU5/UwRr5phmdEMjwZI5Psb5TGEac1tJpHm2IYDhcyeiucrpLWQt8oEb1v7y
         DAM/APeV+PKNdGk7O2rCueI0A6JOpapKtEAh5CQBfhXuQWu+GEFO8bc0Rn59EzMXMI
         W5SiF/zovskSMf0BPOf9Ce/40FBaJQHVZLSH3t8ojHh+6t9y5at7nACRT+cksChBAJ
         pjYoAqfVO61NQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc:     paulmck@kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rohan McLure <rmclure@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/powerpc/include/asm/barrier.h: redefine rmb and
 wmb to  lwsync
In-Reply-To: <Y/bvClrV60CXK79G@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230222090344.189270-1-kconsul@linux.vnet.ibm.com>
 <20230222174719.GA1400185@paulmck-ThinkPad-P17-Gen-1>
 <87fsaxavk2.fsf@mpe.ellerman.id.au>
 <Y/bvClrV60CXK79G@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
Date:   Thu, 23 Feb 2023 20:24:34 +1100
Message-ID: <871qmgbup9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
>  
>> You are correct, the patch is wrong because it fails to account for IO
>> accesses.
>
> Okay, I looked at the PowerPC ISA and found:
> "The memory barrier provides an ordering function for the storage accesses
> caused by Load, Store,and dcbz instructions that are executed by the processor
> executing the sync instruction and for which the specified storage location
> is in storage that is Memory Coherence Required and is neither Write Through
> Required nor Caching Inhibited.

Yep, that's the key sentence there. If you look at the definition for
"sync" it has not exceptions for different storage types.

I agree it's not very clear unless you're looking closely.

> Thanks for your time, Michael. Sorry for the noise.
>> 
>> Kautuk, I'm not sure what motivated you to look at these barriers, was
>> it just the documentation you linked to?

> I read the basic documentation. Now that I have access to the PowerISA
> document I guess I'll go through it more thoroughly.

The ISA is available publicly. There's links to most versions here:

https://wiki.raptorcs.com/wiki/Power_ISA

cheers
