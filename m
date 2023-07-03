Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B4D7454E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGCFeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGCFee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:34:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701851B6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:34:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZP416rjz4wxm;
        Mon,  3 Jul 2023 15:34:32 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <57834a703dfa5d6c27c9de0a01329059636e5ab7.1685080579.git.christophe.leroy@csgroup.eu>
References: <57834a703dfa5d6c27c9de0a01329059636e5ab7.1685080579.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/kcsan: Properly instrument arch_spin_unlock()
Message-Id: <168836201884.50010.3433894878909493070.b4-ty@ellerman.id.au>
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

On Fri, 26 May 2023 07:57:33 +0200, Christophe Leroy wrote:
> The following boottime error is encountered with SMP kernel:
> 
>   kcsan: improperly instrumented type=(0): arch_spin_unlock(&arch_spinlock)
>   kcsan: improperly instrumented type=(0): spin_unlock(&test_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE): arch_spin_unlock(&arch_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE): spin_unlock(&test_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND): arch_spin_unlock(&arch_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND): spin_unlock(&test_spinlock)
>   kcsan: selftest: test_barrier failed
>   kcsan: selftest: 2/3 tests passed
>   Kernel panic - not syncing: selftests failed
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kcsan: Properly instrument arch_spin_unlock()
      https://git.kernel.org/powerpc/c/396f2b0106ff343c61f7ae221dc6ae300f807760

cheers
