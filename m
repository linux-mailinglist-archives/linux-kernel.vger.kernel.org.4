Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC9739A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjFVIkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjFVIk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:40:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FAB1FD8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:40:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 88A3320427;
        Thu, 22 Jun 2023 08:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687423217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJUeHRwvSRI1USK97hB/jvNr2ApKuOYeUxF/NEMnAOo=;
        b=ps0suCBTBthe6h0Nfl48mHNnsZr5TTQOTH2AvK9D3K1jom6XmgEiduYWXRN7jhwIr7Q24d
        MRFAbIkqkq6luq/8bxxMkxc5T059iRnT6N7MBpKOrCqbETiNOcLWUAeeY89i+aSh2ofn9u
        mrwh50t0CC6d/jj7vksrsGgCk6SdodI=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 393382C141;
        Thu, 22 Jun 2023 08:40:15 +0000 (UTC)
Date:   Thu, 22 Jun 2023 10:40:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Move arch_trigger_cpumask_backtrace from nmi.h
 to irq.h
Message-ID: <ZJQI6_P2yfJKZK52@alley>
References: <20230621164809.1.Ice67126857506712559078e7de26d32d26e64631@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621164809.1.Ice67126857506712559078e7de26d32d26e64631@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-06-21 16:48:19, Douglas Anderson wrote:
> The powerpc architecture was the only one that defined
> arch_trigger_cpumask_backtrace() in asm/nmi.h instead of
> asm/irq.h. Move it to be consistent.
> 
> This fixes compile time errors introduced by commit 7ca8fe94aa92
> ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH"). That commit

Will this commit end up in the mainline wihtout rebasing?
We could use only final commit hashes in the commit messages.

> caused <asm/nmi.h> to stop being included if the hardlockup detector
> wasn't enabled. The specific errors were:
>   error: implicit declaration of function ‘nmi_cpu_backtrace’
>   error: implicit declaration of function ‘nmi_trigger_cpumask_backtrace’
> 
> Fixes: 7ca8fe94aa92 ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Closes: https://lore.kernel.org/r/871qi5otdh.fsf@mail.lhotse
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Looks like a reasonable solution:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks a lot for fixing the regression.

Best Regards,
Petr
