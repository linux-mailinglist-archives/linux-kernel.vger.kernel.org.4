Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF769C51C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 07:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBTGAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 01:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBTGAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 01:00:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A5A6EA8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 22:00:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKsGm23WDz4x7j;
        Mon, 20 Feb 2023 17:00:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676872848;
        bh=iolXeOUuWKzcYomt55jMlX8MUnHJcpkscdJ1uF5zKw0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kI/JF0f+wHy5CyAR3A93DGSnEBScZIlEunUMBtYVYXyPKVhJOGrvNcDm0oHP7y3WO
         Uv+yMSW9OC/wZkBbB61NcIegGy+E3pPLv0zugaVPsPrRl55vAhldfkO6iXJR/z24de
         r93RFODGuSQIV9+VunlUaQX2cAqD1jK2oP2XtYuDJjv4112O+5hoHbE0EZYJv/OoGL
         4ptPAFiuXdIFNlkU+/uc9/J+hdWzwPbJzF8mG2BRZjqQZL+Ar0ZfYMyjFs7hTTr7TF
         vB9TRAlNnbPrLPqnyFXDRlpOByglBc69oo31r8YY24ogbTbBVCCDb2DyKJKwRSXC2A
         s7JRkI/dwe4lQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>, jbglaw@lug-owl.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 4/5] powerpc: Remove cpu-as-y completely
In-Reply-To: <9e43ad8b173c2fdb540e2555a8ba3e375419f3cf.1671475543.git.christophe.leroy@csgroup.eu>
References: <38a8d765ed9149bc6b5484a7142e3bc59ffa3b1a.1671475543.git.christophe.leroy@csgroup.eu>
 <9e43ad8b173c2fdb540e2555a8ba3e375419f3cf.1671475543.git.christophe.leroy@csgroup.eu>
Date:   Mon, 20 Feb 2023 17:00:47 +1100
Message-ID: <873570zxio.fsf@mpe.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> cpu-as-y is there to force assembler building options.
> But there is no need for that. Gcc is passed the necessary
> options and it automatically pass the appropriate option to
> GAS.
>
> GCC is given -maltivec when relevant, so no need
> for -Wa,-maltivec in addition
>
> And -Wa,-many is wrong as it will hide innapropriate
> instructions. Better to detect them and handle them on a
> case by case basis.
> -Wa,-many was added by commit 960e30029863 ("powerpc/Makefile:
> Fix PPC_BOOK3S_64 ASFLAGS") in order to fix an issue with
> clang and the passed -Wa,-mpower4 option. But we have now
> removed it expecting the compiler to automatically pass the
> proper options and instructions based on -mcpu=power4

I wanted to apply this one, but it caused a lot of breakage for big
endian Book3S-64 builds - where we build for power4 but have lots of
code that uses >= power5 instructions.

I'll try and get those all fixed and pick this up for the next merge
window.

cheers
