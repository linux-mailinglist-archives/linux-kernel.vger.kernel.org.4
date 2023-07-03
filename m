Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB57454E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGCFek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCFed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:34:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA044180
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:34:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZP34pKxz4wxW;
        Mon,  3 Jul 2023 15:34:31 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <df36c6205ab64326fb1b991993c82057e92ace2f.1685955214.git.christophe.leroy@csgroup.eu>
References: <df36c6205ab64326fb1b991993c82057e92ace2f.1685955214.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/interrupt: Don't read MSR from interrupt_exit_kernel_prepare()
Message-Id: <168836201884.50010.18257455967677978392.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:26:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2023 10:55:26 +0200, Christophe Leroy wrote:
> A disassembly of interrupt_exit_kernel_prepare() shows a useless read
> of MSR register. This is shown by r9 being re-used immediately without
> doing anything with the value read.
> 
>   c000e0e0:       60 00 00 00     nop
>   c000e0e4:       7d 3a c2 a6     mfmd_ap r9
>   c000e0e8:       7d 20 00 a6     mfmsr   r9
>   c000e0ec:       7c 51 13 a6     mtspr   81,r2
>   c000e0f0:       81 3f 00 84     lwz     r9,132(r31)
>   c000e0f4:       71 29 80 00     andi.   r9,r9,32768
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/interrupt: Don't read MSR from interrupt_exit_kernel_prepare()
      https://git.kernel.org/powerpc/c/0eb089a72fda3f7969e6277804bde75dc1474a14

cheers
