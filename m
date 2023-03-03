Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDD46AA555
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjCCXFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjCCXFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:05:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071845C124
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:05:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E677C1F86C;
        Fri,  3 Mar 2023 23:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677884673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27lqruZljuPfJkQ+tYG/UdzlzZ+vGAxUjKG/wutxyHU=;
        b=aoN/taB0NokWd586+HSC8AXNrKth9RqeqF+1R/byPPAXlEWhDFm4e0LG76WEdPEkS2BOvS
        0tFqBrRBByl92+oWZGC3Zrs6r8OJCJ0P51XPN7ac30yt4JpUoNw+ouXFFHHiZLPX+RsNCu
        3wek+jV6Td48zXWopnGW3Q96sWoPRvc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AC601329E;
        Fri,  3 Mar 2023 23:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fw0WIAF9AmT2eAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 03 Mar 2023 23:04:33 +0000
Date:   Sat, 4 Mar 2023 00:04:30 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/mm: Do not shuffle CPU entry areas without KASLR
Message-ID: <ZAJ8/hryzQ18Gs2R@blackbook>
References: <20230303160645.3594-1-mkoutny@suse.com>
 <addc0715-7b75-59d3-fe82-dcfd6a7ef81a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addc0715-7b75-59d3-fe82-dcfd6a7ef81a@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:24:53PM -0800, Dave Hansen <dave.hansen@intel.com> wrote:
> Should this be kaslr_memory_enabled() or kaslr_enabled()?

Originally, I had chosen kaslr_enabled(), seeing the PGD requirement of
KASAN (whole randomization area CPU_ENTRY_AREA_MAP_SIZE would fit in PGD
afterall).

> The delta seems to be CONFIG_KASAN, and the cpu entry area randomization
> works just fine with KASAN after some recent fixes.

But then I found KASAN code trying to be smart and having the fixups,
hence I chickened out to kaslr_memory_enabled().

> I _think_ that makes cpu entry area randomization more like module
> randomization which would point toward kaslr_enabled().

<del>I understood the only difference between kaslr_enabled and
kaslr_memory_enabled is the PGD alignment of the respective regions.
(Although, I don't see where KASAN breaks with unaligned ranges except
for better efficiency of page tables.)</del>

I've just found your [1], wondering the similar.


That being said, I will send v2 with just kaslr_enabled() guard and
updated commit message to beware of KASAN fixups (when backporting).

Thanks,
Michal

[1] https://lore.kernel.org/r/299fbb80-e3ab-3b7c-3491-e85cac107930@intel.com/

