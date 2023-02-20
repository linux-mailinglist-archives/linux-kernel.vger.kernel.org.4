Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2013069D400
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjBTTRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjBTTRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:17:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A441C5A8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:17:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A42EA60EFC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120EBC433AF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676920618;
        bh=F1Rex97yT+zOZHhEzwX9bEslpsDNC0igRGwkZmP5fFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TDekVCDE4aqGKMIreqJzrHlYCNhI4ScoKLLyUuvbfClW7VN3euXihPHQERIrQlTHN
         Omu0oUvOrLJasgryVYou4VgYBGqfSprA/vAVgrKs/dScAjhyL3gUywtIl0ewOTiYdA
         CmFeNno/iMTQjJqdQwe0RYHcIqmrsndDtYFWp6BuTHwDMmKzAFgPlay8VtwRVv4mRF
         Ed+dgGypvHvOHj8Lk7Tv/xkRPTYZZ7HMMKkbKvosDwh30uOjYx/SVkDKwC7xy+fIV3
         jm+b0ENZzKWNR4isD6WhX/iAe7/PN6bNfNwlE6V7AWPRpljGRpWNMnuv4Kr57Ca+wn
         poK84P+wq1WsA==
Received: by mail-ed1-f44.google.com with SMTP id ck15so9748761edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:16:57 -0800 (PST)
X-Gm-Message-State: AO0yUKWVEJ12Gxd5rwybgFs7IoYvlXjFjnrbxOVkwwzID0laOgiT6HxT
        71mw+cex4u2PKkWiY331B7VsbgSDEffQELMU+ANj/w==
X-Google-Smtp-Source: AK7set8/XWcNiuKiM5Usx03NLXI3uJiOGOSscb90Zzt90RIlIs/0HGbBCFhb6oat+OCxxW4E5eDBhqKOvz5qyzZ8ako=
X-Received: by 2002:a50:8a93:0:b0:4ad:7439:cec3 with SMTP id
 j19-20020a508a93000000b004ad7439cec3mr539944edj.7.1676920616209; Mon, 20 Feb
 2023 11:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20230220120127.1975241-1-kpsingh@kernel.org> <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <20230220163442.7fmaeef3oqci4ee3@treble> <Y/Ox3MJZF1Yb7b6y@zn.tnic>
 <20230220175929.2laflfb2met6y3kc@treble> <CACYkzJ71xqzY6-wL+YShcL+d6ugzcdFHr6tbYWWE_ep52+RBZQ@mail.gmail.com>
 <20230220182717.uzrym2gtavlbjbxo@treble> <Y/O9U4KFtXE8Yoyt@zn.tnic> <20230220190908.gfd2c4tuzeb7cft6@treble>
In-Reply-To: <20230220190908.gfd2c4tuzeb7cft6@treble>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 20 Feb 2023 11:16:45 -0800
X-Gmail-Original-Message-ID: <CACYkzJ58HoDz+hpLzWf0PZQX7ykWqB6-uQR9HVb5YqaF-rdScA@mail.gmail.com>
Message-ID: <CACYkzJ58HoDz+hpLzWf0PZQX7ykWqB6-uQR9HVb5YqaF-rdScA@mail.gmail.com>
Subject: Re: [PATCH] x86/bugs: Allow STIBP with IBRS
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?UTF-8?Q?Jos=C3=A9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:09 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Mon, Feb 20, 2023 at 07:34:59PM +0100, Borislav Petkov wrote:
> > Drop stable@ again.
> >
> > On Mon, Feb 20, 2023 at 10:27:17AM -0800, Josh Poimboeuf wrote:
> > > IBRS is only enabled in kernel space.  Since it's not enabled in user
> > > space, user space isn't protected from indirect branch prediction
> > > attacks from a sibling CPU thread.
> > >
> > > Allow STIBP to be enabled to protect against such attacks.
> > >
> > > Fixes: 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")
> >
> > Yah, look at that one:
> >
> > commit 7c693f54c873691a4b7da05c7e0f74e67745d144
> > Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Date:   Tue Jun 14 23:15:55 2022 +0200
> >
> >     x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS
> >
> >     Extend spectre_v2= boot option with Kernel IBRS.
> >
> >     [jpoimboe: no STIBP with IBRS]
> >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > I'm assuming this was supposed to mean no STIBP in *kernel mode* when
> > IBRS is selected?
>
> No it was supposed to be "no STIBP with *eIBRS*".
>
> > In user mode, STIBP should be selectable as we disable IBRS there.
> >
> > Close?
> >
> > If so, pls document it too while at it:
> >
> > Documentation/admin-guide/hw-vuln/spectre.rst
> >
> > because we will be wondering next time again.
> >
> > Like we wonder each time this madness is being touched. ;-(
>
> As far as I can tell, that document was never updated to describe
> spectre_v2=ibrs in the first place.  That would be a whole 'nother patch
> which I'm not volunteering for.  Nice try ;-)

This should at least be documented in the code.

Now it seems like it is not okay to work with people on the list and
just send revisions bypassing them. This is not something we do in the
kernel area I come from (an x86 favorite ;)).  Please feel free to go
with Josh's version (or its future revisions). If you want me to
re-spin with some comments, happy to. If not, please do at least give
me Reported-by here.



>
> --
> Josh
