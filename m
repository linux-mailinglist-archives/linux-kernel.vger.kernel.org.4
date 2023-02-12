Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D90693B17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 00:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBLXWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 18:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBLXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 18:22:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03901BC8;
        Sun, 12 Feb 2023 15:22:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFNmc4LsWz4x7W;
        Mon, 13 Feb 2023 10:22:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676244160;
        bh=RsoH4zXDNZAI4qNZsfWd35WEMUCkQt/8RrKIyZ10p1M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YynPQDup6rae+tCL1eEOJ1zlIm3/LZm2bQGrIWVtXb56rnW05yxyi6CzGiK/P3XQI
         3sNpk8CCWQyF62t3juP4xzWyzQyXFZXCmvOMEBUsobRr7tPt6e3GviqRvcOkQhqBLc
         jpQGhw1fBrws35ObnzYg0P4gGoNvvCCStih0QbR6UrS1KM6kpUqr+nIm1PnmiOeZZw
         XI9AK6PkJrqGDdE0JHnBwwoGz3o7lkmIK1PeqX1Z27iYIPpepy6jvOMipBxcN1z+u1
         ROJXbCCaaRoZRXJGls2cFbzXx8x5GNnOU+c6Sft51pbVfAuz7rjchUfYS0gYkq5T9I
         TFnW3RhX8alSQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the powerpc tree
In-Reply-To: <20230210143829.4ab676bd@canb.auug.org.au>
References: <20230210143829.4ab676bd@canb.auug.org.au>
Date:   Mon, 13 Feb 2023 10:22:38 +1100
Message-ID: <871qmuwjsx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> After merging the powerpc tree, today's linux-next build (powerpc64
> allnoconfig) failed like this:
>
> arch/powerpc/kernel/setup_64.c: In function 'early_setup':
> arch/powerpc/kernel/setup_64.c:400:34: error: 'struct thread_info' has no member named 'cpu'
>   400 |         task_thread_info(current)->cpu = boot_cpuid; // fix task_cpu(current)
>       |                                  ^~
>
> Caused by commit
>
>   0ecf51ca51e5 ("powerpc/64: Fix task_cpu in early boot when booting non-zero cpuid")
>
> # CONFIG_SMP is not set

Thanks. I squashed in the fix.

cheers
