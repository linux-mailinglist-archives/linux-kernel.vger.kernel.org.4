Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B58A7199B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjFAK1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjFAK07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:26:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F610CE;
        Thu,  1 Jun 2023 03:26:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685615163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBG6LSgcL4OvuvT5P5sO0vfG/HZ7VoTB8zrMnek3QXE=;
        b=Ok0pAI37eBUUxtyD72XEi/kWXDtqF2cyYqQakQgqv1gcVzpImTA0v1e4tUg95X+deC5XY9
        lOx47kKlGoTmsXGCE7EJ8FFCDq0IIAETyX9nAxQzzMabggRrIUwUDHi3Q38QabiIEi/O69
        lsy60XfNp/vNnOw4dz9L9Gsa11esS6vzwsjT7S0pn071wo0R1w/ccoe4RpM7TvQdijxVLK
        350OsLzpSOPzbxwTX7gY8DVi3dtt4lbk4LWsqX0zWOwWz3FSomSuS5pM54azU6D79g2DK1
        w5RLaq2RkizcDigKlOoH9QpZygySmYqEvWyDw9WX9SUW02hgYzsZ3BbnhSx2Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685615163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBG6LSgcL4OvuvT5P5sO0vfG/HZ7VoTB8zrMnek3QXE=;
        b=/tzvg4GZZVLmApTKNWPjobcVJPi6uoWunc8Omj06UJ53lq6lcsRwJ2UMOKZxbB4erfpMIa
        N71tNcFW6TSNEOBw==
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Steven Noonan <steven@uplinklabs.net>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
In-Reply-To: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com>
Date:   Thu, 01 Jun 2023 12:26:02 +0200
Message-ID: <87mt1jeax1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01 2023 at 13:45, Muhammad Usama Anjum wrote:
> As more and more things are being added to Wine, Windows application can be
> run pretty easily on Linux. But this rdtsc is a big hurdle. What are your
> thoughts on solving this problem?

Who would have thought that rdtsc() in applications can be a problem.
Interfaces to query time exist for a reason and it's documented by
Microsoft:

https://learn.microsoft.com/en-us/windows/win32/dxtecharts/game-timing-and-multicore-processors

But sure, reading documentation is overrated...

> We are thinking of saving and restoring the timestamp counter at suspend
> and resume time respectively. In theory it can work on Intel because of
> TSC_ADJUST register. But it'll never work on AMD until:
> * AMD supports the same kind of adjust register. (AMD has said that the
> adjust register cannot be implemented in their firmware. They'll have to
> add it to their hardware.)
> * by manual synchronization in kernel (I know you don't like this idea. But
> there is something Windows is doing to save/restore and sync the TSC)

Synchronizing TSC by writing the TSC MSR is fragile as hell. This has
been tried so often and never reliably passed all synchronization tests
on a wide range of systems.

It kinda works on single socket, but not on larger systems.

We spent an insane amount of time to make timekeeping correct and I'm
not interested at all to deal with the fallout of such a mechanim.

I could be persuaded to make this work when TSC_ADJUST is available, but
that's it.

But even that might turn out to be just a solution for the moment
because there is a plan on the way that TSC grows an irreversible lock
bit, which prevents everything including SMM from fiddling with it,
which in turn spares the TSC_ADJUST sanity checks post boot.

Thanks,

        tglx


