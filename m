Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8573A707
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFVROZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFVROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DCF1728
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46FA361862
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E516C433C8;
        Thu, 22 Jun 2023 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687454061;
        bh=0p/7wDJ1WpnlaJGGYQlrL+ANC4cnKoEcAt+zejcaU8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AMC8cfuEWXrjDXDH8RIeyelx4TnwfZxc3EImbnknh3cnKnWJDkzqIY4Dg5H+Grgyp
         1XC9aWZqclXu6zOoHjfTuY9t4JfHVlYN4ZpkyLFzwukIZDnwmPQ5Bu8Kx3Z5N5TENN
         hJgnbVzM2a83YuLZbvoStKy2rp6U9rVK1Q+j9xeg=
Date:   Thu, 22 Jun 2023 10:14:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
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
Message-Id: <20230622101420.f50c8d702a5757647b92250a@linux-foundation.org>
In-Reply-To: <ZJQI6_P2yfJKZK52@alley>
References: <20230621164809.1.Ice67126857506712559078e7de26d32d26e64631@changeid>
        <ZJQI6_P2yfJKZK52@alley>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 10:40:11 +0200 Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2023-06-21 16:48:19, Douglas Anderson wrote:
> > The powerpc architecture was the only one that defined
> > arch_trigger_cpumask_backtrace() in asm/nmi.h instead of
> > asm/irq.h. Move it to be consistent.
> > 
> > This fixes compile time errors introduced by commit 7ca8fe94aa92
> > ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH"). That commit
> 
> Will this commit end up in the mainline wihtout rebasing?
> We could use only final commit hashes in the commit messages.

7ca8fe94aa92 is now in the mm-stable branch, which is is non-rebasing,
so this hash should be good.

Patches get moved from the rebasing mm-unstable to the non-rebasing
mm-stable when they're considered to be stabilized.

Ditto mm-hotfixes-unstable/mm-hotfixes-stable and
mm-nonmm-unstable/mm-nonmm-stable.
