Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E532A5BF57F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIUEkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIUEkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A27DF53;
        Tue, 20 Sep 2022 21:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60053B822F6;
        Wed, 21 Sep 2022 04:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E05C433C1;
        Wed, 21 Sep 2022 04:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663735211;
        bh=vGuyQI+FIpieTlo0FPtCZO4Etx2WXiRfDhLbQSJCdRk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TRhzMDTurf2g0MLA+jsdQR2hU5WuzVsoYjoZTTP003TS3yZxFUrtflewh9u4HwOC1
         0E5KMpp5cf71jk92IFfgM1Gf2dpuvCcGV73jFGwukMWpbLcjDhpl/kZtqdaz1oWpz/
         akWC5JVgA+owxMuBDS1eDcK6B8X1QLiK0IIZT7NPfj7mR9r3+hwRJqP93pS+O/0w2a
         o+nuzEgu5EQY/HgzkEUJGMXu80ybb3Byhk0MOZnWBHtehZDjTnGjsa1ae1vSXTWruo
         bmW8IGbRbS0wVZous5A6bRKMXVjEEX7G2ObE0qmDBsmpteiMkMcdL4kRarV397NgtC
         oIvK7EppA86OA==
From:   Kalle Valo <kvalo@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/3] coding-style.rst: document BUG() and WARN() rules ("do not crash the kernel")
References: <20220920122302.99195-1-david@redhat.com>
        <20220920122302.99195-2-david@redhat.com>
Date:   Wed, 21 Sep 2022 07:40:00 +0300
In-Reply-To: <20220920122302.99195-2-david@redhat.com> (David Hildenbrand's
        message of "Tue, 20 Sep 2022 14:23:00 +0200")
Message-ID: <87pmfp8hnj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> Linus notes [1] that the introduction of new code that uses VM_BUG_ON()
> is just as bad as BUG_ON(), because it will crash the kernel on
> distributions that enable CONFIG_DEBUG_VM (like Fedora):
>
>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>     no different, the only difference is "we can make the code smaller
>     because these are less important". [2]
>
> This resulted in a more generic discussion about usage of BUG() and
> friends. While there might be corner cases that still deserve a BUG_ON(),
> most BUG_ON() cases should simply use WARN_ON_ONCE() and implement a
> recovery path if reasonable:
>
>     The only possible case where BUG_ON can validly be used is "I have
>     some fundamental data corruption and cannot possibly return an
>     error". [2]
>
> As a very good approximation is the general rule:
>
>     "absolutely no new BUG_ON() calls _ever_" [2]
>
> ... not even if something really shouldn't ever happen and is merely for
> documenting that an invariant always has to hold. However, there are sill
> exceptions where BUG_ON() may be used:
>
>     If you have a "this is major internal corruption, there's no way we can
>     continue", then BUG_ON() is appropriate. [3]
>
> There is only one good BUG_ON():
>
>     Now, that said, there is one very valid sub-form of BUG_ON():
>     BUILD_BUG_ON() is absolutely 100% fine. [2]
>
> While WARN will also crash the machine with panic_on_warn set, that's
> exactly to be expected:
>
>     So we have two very different cases: the "virtual machine with good
>     logging where a dead machine is fine" - use 'panic_on_warn'. And
>     the actual real hardware with real drivers, running real loads by
>     users. [4]
>
> The basic idea is that warnings will similarly get reported by users
> and be found during testing. However, in contrast to a BUG(), there is a
> way to actually influence the expected behavior (e.g., panic_on_warn)
> and to eventually keep the machine alive to extract some debug info.
>
> Ingo notes that not all WARN_ON_ONCE cases need recovery. If we don't ever
> expect this code to trigger in any case, recovery code is not really
> helpful.
>
>     I'd prefer to keep all these warnings 'simple' - i.e. no attempted
>     recovery & control flow, unless we ever expect these to trigger.
>     [5]
>
> There have been different rules floating around that were never properly
> documented. Let's try to clarify.
>
> [1] https://lkml.kernel.org/r/CAHk-=wiEAH+ojSpAgx_Ep=NKPWHU8AdO3V56BXcCsU97oYJ1EA@mail.gmail.com
> [2] https://lore.kernel.org/r/CAHk-=wg40EAZofO16Eviaj7mfqDhZ2gVEbvfsMf6gYzspRjYvw@mail.gmail.com
> [2] https://lkml.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com
> [4] https://lore.kernel.org/r/CAHk-=wgF7K2gSSpy=m_=K3Nov4zaceUX9puQf1TjkTJLA2XC_g@mail.gmail.com
> [5] https://lore.kernel.org/r/YwIW+mVeZoTOxn%2F4@gmail.com
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

[...]

> +Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
> +**************************************************
> +
> +WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it
> +is common for a given warning condition, if it occurs at all, to occur
> +multiple times. This can fill up and wrap the kernel log, and can even slow
> +the system enough that the excessive logging turns into its own, additional
> +problem.

FWIW I have had cases where WARN() messages caused a reboot, maybe
mention that here? In my case the logging was so excessive that the
watchdog wasn't updated and in the end the device was forcefully
rebooted.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
