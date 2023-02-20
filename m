Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C950969D3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjBTTPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjBTTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:15:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C21EBEA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:14:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81B36B80DC5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA77C433D2;
        Mon, 20 Feb 2023 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676920151;
        bh=bhNIobQbVGcXtF02rL+clFkrFHheOF5W60xYcWPqN2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQwyJZKg/TcLRuwH/pddgabF6QELoOe0ei/u9uSNu4O23gBqCMKG09emLnN0oA1PK
         HVyisfSuTuSuxuX+/mWMy2sEqktEA4X8iMIuSjgbNmkU8+/sSOuvy3wWMf7BUt3LUo
         bBpmsVxyWvM4JOLOQiF/8YQ/zhTfBtVY0R//bfOVMS7YhuynCxI6nugS7IgM20EobT
         7UzSezwvGkMO/sfSx/Hb8wmSClGYbknz6Q6oUrvyuPb/49fq++0VOFF2tD2jKQD5VO
         cP2fxAwdqJMzr0MkNeGPs8xd0Gb6Qf7ppwZtAz4TZbn0MaxBUpSexjEcXn35OWvKjj
         qFZtHKOsY2bBg==
Date:   Mon, 20 Feb 2023 11:09:08 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20230220190908.gfd2c4tuzeb7cft6@treble>
References: <20230220120127.1975241-1-kpsingh@kernel.org>
 <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <20230220163442.7fmaeef3oqci4ee3@treble>
 <Y/Ox3MJZF1Yb7b6y@zn.tnic>
 <20230220175929.2laflfb2met6y3kc@treble>
 <CACYkzJ71xqzY6-wL+YShcL+d6ugzcdFHr6tbYWWE_ep52+RBZQ@mail.gmail.com>
 <20230220182717.uzrym2gtavlbjbxo@treble>
 <Y/O9U4KFtXE8Yoyt@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/O9U4KFtXE8Yoyt@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 07:34:59PM +0100, Borislav Petkov wrote:
> Drop stable@ again.
> 
> On Mon, Feb 20, 2023 at 10:27:17AM -0800, Josh Poimboeuf wrote:
> > IBRS is only enabled in kernel space.  Since it's not enabled in user
> > space, user space isn't protected from indirect branch prediction
> > attacks from a sibling CPU thread.
> > 
> > Allow STIBP to be enabled to protect against such attacks.
> > 
> > Fixes: 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")
> 
> Yah, look at that one:
> 
> commit 7c693f54c873691a4b7da05c7e0f74e67745d144
> Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Date:   Tue Jun 14 23:15:55 2022 +0200
> 
>     x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS
> 
>     Extend spectre_v2= boot option with Kernel IBRS.
> 
>     [jpoimboe: no STIBP with IBRS]
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I'm assuming this was supposed to mean no STIBP in *kernel mode* when
> IBRS is selected?

No it was supposed to be "no STIBP with *eIBRS*".

> In user mode, STIBP should be selectable as we disable IBRS there.
> 
> Close?
> 
> If so, pls document it too while at it:
> 
> Documentation/admin-guide/hw-vuln/spectre.rst
> 
> because we will be wondering next time again.
> 
> Like we wonder each time this madness is being touched. ;-(

As far as I can tell, that document was never updated to describe
spectre_v2=ibrs in the first place.  That would be a whole 'nother patch
which I'm not volunteering for.  Nice try ;-)

-- 
Josh
