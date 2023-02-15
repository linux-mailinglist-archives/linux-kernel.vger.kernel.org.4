Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21550698793
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBOV6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBOV6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:58:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4DD7A81
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:58:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHBmJ4JzKz4x4n;
        Thu, 16 Feb 2023 08:58:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676498320;
        bh=66RYPVgMpz94tBHchX7oiuUA6G3IDTuSBU9OW1M8NeY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pKqCwJljTt4SGKmbz+G4Yk1mAMdnLK4MLIleTw2C8g8lB+dmvGgsx9dgI11EarFab
         BoJf8gOMSeG3XTGzG2k0JeJQ6Gpj7rb881NYX+mRrBm+n13jEfiqkCEn280RXYS78I
         EU32BxU1ArVbJJHmrqFgWLkqWhvmOCBm9TrGox3ec50VLDMjQxrcc1E6PBYuiCwwB9
         bhi2+y8QOI3ncfNmNAghVA9I/8qhjje5ub5e27MRis44edHg/jyfHWajHmgTas1Y6z
         iAbN0Gfxu7C8L6LC9rMuvfEZ9YAfnng7i7HV9x8GjNuSR/fa4iNLdmHk/xJSe17s2W
         jvsNxsc0oTLQw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 3/9] powerpc/47x: Split ppc47x machine in two
In-Reply-To: <ae59e5bec0293b09a1e31690570cd1347b2d6fa6.1676465585.git.christophe.leroy@csgroup.eu>
References: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
 <ae59e5bec0293b09a1e31690570cd1347b2d6fa6.1676465585.git.christophe.leroy@csgroup.eu>
Date:   Thu, 16 Feb 2023 08:58:35 +1100
Message-ID: <87v8k2616c.fsf@mpe.ellerman.id.au>
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
> This machine matches two compatibles and sets .pci_irq_fixup
> on one of them.
>
> Split it into two machines, then the probe function can be dropped.

That will break the machine initcalls that look for ppc47x:

  arch/powerpc/platforms/44x/ppc476.c:machine_device_initcall(ppc47x, ppc47x_device_probe);
  arch/powerpc/platforms/44x/ppc476.c:machine_arch_initcall(ppc47x, ppc47x_get_board_rev);

It still compiles, because of the weak attribute in machine_is(), but
those initcalls will never match and so never run.

cheers
