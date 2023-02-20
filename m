Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559CB69D2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjBTSfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBTSfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:35:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EDD1ADD0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:35:00 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 653CE1EC04CC;
        Mon, 20 Feb 2023 19:34:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676918099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1bHT9AJljCQca1SrfqoO65rJvzjVNwjrn2lJJ27XoOg=;
        b=GFiGBcPUqWgWrZOED/0n9MEY7JJkG3yXNQk51i5WNZ/rpoyZTo9T7yTY2/3/CJbKmI+SBL
        SIfu+WFv28Ha9+zJYiTi51/24YLI6XXvu9op/qKCAQamA555ZoNq1LzoU5p8EsaQp8fT85
        +tlekny4UIeJUiDx8K97VfhycdTNuCM=
Date:   Mon, 20 Feb 2023 19:34:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?utf-8?B?Sm9zw6k=?= Oliveira <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] x86/bugs: Allow STIBP with IBRS
Message-ID: <Y/O9U4KFtXE8Yoyt@zn.tnic>
References: <20230220120127.1975241-1-kpsingh@kernel.org>
 <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <20230220163442.7fmaeef3oqci4ee3@treble>
 <Y/Ox3MJZF1Yb7b6y@zn.tnic>
 <20230220175929.2laflfb2met6y3kc@treble>
 <CACYkzJ71xqzY6-wL+YShcL+d6ugzcdFHr6tbYWWE_ep52+RBZQ@mail.gmail.com>
 <20230220182717.uzrym2gtavlbjbxo@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230220182717.uzrym2gtavlbjbxo@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop stable@ again.

On Mon, Feb 20, 2023 at 10:27:17AM -0800, Josh Poimboeuf wrote:
> IBRS is only enabled in kernel space.  Since it's not enabled in user
> space, user space isn't protected from indirect branch prediction
> attacks from a sibling CPU thread.
> 
> Allow STIBP to be enabled to protect against such attacks.
> 
> Fixes: 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")

Yah, look at that one:

commit 7c693f54c873691a4b7da05c7e0f74e67745d144
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Date:   Tue Jun 14 23:15:55 2022 +0200

    x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS

    Extend spectre_v2= boot option with Kernel IBRS.

    [jpoimboe: no STIBP with IBRS]
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I'm assuming this was supposed to mean no STIBP in *kernel mode* when
IBRS is selected?

In user mode, STIBP should be selectable as we disable IBRS there.

Close?

If so, pls document it too while at it:

Documentation/admin-guide/hw-vuln/spectre.rst

because we will be wondering next time again.

Like we wonder each time this madness is being touched. ;-(

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
