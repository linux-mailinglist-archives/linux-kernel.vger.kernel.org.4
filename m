Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDD068375A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjAaUUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjAaUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:20:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734AA1969B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:20:43 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 134301EC0682;
        Tue, 31 Jan 2023 21:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675196442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MfMP1AQjgJVYD/W9qVZ3W7rRxX1GjgBbbYC8SUbtKEc=;
        b=H43TWTH2Ru4Cr8AHXhIqXpIb+cnAYJ2HvliulGMEmjP1S5IMG7X0E97H+GQVxEcHu8Pn09
        GeMe1Rv8ZbLt62TyjRB4+UUApoU+bOHTc0fRSa7b4sCnBfDI3HE4WWG4ktTTvbIQTc3PNe
        qp7SK1jYtsEa27aJRRJW4xGX8cFXDek=
Date:   Tue, 31 Jan 2023 21:20:37 +0100
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
Message-ID: <Y9l4FdvytLqMc3jm@zn.tnic>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
 <Y9kAlKFfdek2rq6g@zn.tnic>
 <Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 08:51:25AM -0800, Ashok Raj wrote:
> remove ret = 0 during initialization since its cleared right below. (tglx)

Sure.

> Need to set ret explicitly to either -EINVAL, or size. Otherwise it will be
> endlessly waiting for write to complete. (As Aubrey pointed out)

Then do:

        tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
        if (tmp_ret != UCODE_NEW)
                return size;

to signal what it is. It certainly ain't an error if it doesn't find new
microcode.

> I think its safe to leave ret as is, since microcode_reload_late() only
> returns -1, or 0.

No it doesn't. Hint: stop_machine_cpuslocked().

> Pull this into the ret == 0, so taint only if the update was successful? 

Ok.

> And add a message so its not silent?

You'd add a printk for every possible operation, wouldn't you?

See, the world doesn't revolve around microcode loading. If that thing
fails, then someone has done a bad job at the CPU vendor testing,
provided the code does the right thing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
