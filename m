Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC31169C3B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBTAmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBTAmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:42:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92B0CC13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 16:42:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKkCk2nhqz4x7y;
        Mon, 20 Feb 2023 11:42:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676853762;
        bh=awL0LswKWKQU0tm7U0FyvskVuBx2M8+vxaPhhqV23ug=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IQA2gF1Pd/CGSf8+a0zgq6k2DXLp9teYLySBIzInVqukEPLw2XlVJCwiUoHAFcSdp
         Y9/ZYFyBIWRLUgjCQcCHeOfRyDtu0gUMIr652VyGS/vsb1TU2Yn0PP0ltuDaIchuqN
         X7+2nkjkncI9glOdsgedKyNgVon5wzY1ZxbnnW4gItc13eztnhiQUR2jpzLh809lJ1
         efDm1+lYxxspKEXmaGOaPhpjnm3Owec++PvViQOk1DgTkcqPV2mAFE0/KidDEWfArR
         iGt+bJyde/12EvJWTkvXYiDZncHIHmG7e9qY+NkENi9Or4ci3ziqvwKVxKNoZV2Ahx
         zV9gprLHcg5cA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joe Perches <joe@perches.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 09/10] powerpc: Use ppc_md_progress()
In-Reply-To: <45807c0e9fc818dd433746fbb55988c73b016477.camel@perches.com>
References: <6cb9865d916231c38401ba34ad1a98c249fae135.1676711562.git.christophe.leroy@csgroup.eu>
 <c4416002503fa19e930bc78177bb85641367c40f.1676711562.git.christophe.leroy@csgroup.eu>
 <45807c0e9fc818dd433746fbb55988c73b016477.camel@perches.com>
Date:   Mon, 20 Feb 2023 11:42:36 +1100
Message-ID: <87bklpyxoj.fsf@mpe.ellerman.id.au>
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

Joe Perches <joe@perches.com> writes:
> On Sat, 2023-02-18 at 10:15 +0100, Christophe Leroy wrote:
>> Many places have:
>> 
>> 	if (ppc.md_progress)
>> 		ppc.md_progress();
>> 
>> Use ppc_md_progress() instead.
>> 
>> Note that checkpatch complains about using function names,
>> but this is not a function taking format strings, so we
>> leave the function names for now.
>
> If you are changing almost all of these uses, why not
> drop the unused 2nd argument 'hex' at the same time?

The hex argument is printed by some "progress" implementations.

rtas_progress() will print it to the machine's 7-segment display on some
very old machines. Grepping around I think it might be only old CHRP
machines that use the hex code.

And we only have a handful of sites that actually pass a non-zero hex
code anyway.

So I think we could drop the hex argument.

But the vast bulk of the uses are just printing "foo_setup_arch()" which
is of dubious utility and could probably just be dropped.

If the machine has a working udbg backend then before we get to setup
arch we will have initialised the udbg console, and so all printk
messages should be going to udbg anyway.

cheers
