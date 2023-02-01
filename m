Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA168662C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjBAMpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjBAMow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:44:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFC96387C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:44:37 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE0F41EC04C1;
        Wed,  1 Feb 2023 13:44:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675255475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rfUQDWskzPrTe9GBsY7ZTg7RpORlMhHhSgk/IKIXZuM=;
        b=L6q2eQ/ymn0dR9BKoFgvh61upt2x7b7Wb78Wzshj5ZfG7VZMnFrHHvQhyKQJB54vx5crf/
        Rk9VHDu/LyDkx0lrjflRNEt47NcL6QyuNjWMHvFecmTyS03vV0MDcfBLPIWB9QbW02dbcW
        +ri/zW7XgYx3ZITbO26z8vwAAvt6Ops=
Date:   Wed, 1 Feb 2023 13:44:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        "Li, Aubrey" <aubrey.li@intel.com>
Subject: Re: [Patch v3 Part2 1/9] x86/microcode: Taint kernel only if
 microcode loading was successful
Message-ID: <Y9perwfaheZqAJWl@zn.tnic>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
 <Y9kAlKFfdek2rq6g@zn.tnic>
 <Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com>
 <Y9l4FdvytLqMc3jm@zn.tnic>
 <Y9mcCxYK/VPB0ATM@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9mcCxYK/VPB0ATM@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:54:03PM -0800, Ashok Raj wrote:
> It's not an error, only when request_microcode() returns UCODE_ERROR, should
> it return -EINVAL,

So looking at ->request_microcode_fw(), it looks like we return
UCODE_ERROR when something with parsing the blob has gone wrong. So I
guess we can return something more fitting here to state that we failed
while parsing the microcode blob from userspace: it is corrupted,
truncated, what not.

Looking at the error codes, this:

#define ELIBBAD         80      /* Accessing a corrupted shared library */

seems fitting as it has "corrupted" blob in the definition. EBADF sounds
fitting too. In any case, it should be a distinct error value which
hints at what goes wrong.

> This shouldn't be noisy, but if you think this isn't needed, it can go
> away.

I think all this preemptive development - it might make sense so let's
do it - needs to stop. If there's an *actual* real use and need for it
sure, but let's issue a printk just because is not one of them.

> When it fails due to current_rev < min_rev, Isn't it good to add indication
> to user space that it didn't succeed? Thomas wanted these return codes, so
> someone scripting can get a status after an attempt to load.

Return codes: yes. Random, flaky, potentially overwritten in the dmesg
ring buffer error strings - nope. Soon someone will come along and say,
"hey, don't touch those printk formats - my tool parses them and it'll
break if you do." Yeah, right.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
