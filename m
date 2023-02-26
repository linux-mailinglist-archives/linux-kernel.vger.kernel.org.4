Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32406A2CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 02:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBZBum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 20:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZBuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 20:50:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5FFF09
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:50:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62779B80B68
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 01:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A77C433A4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 01:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677376237;
        bh=0ec8hqU/IcJqPrO03/gIMI1/Z8q9iuH3dZL66CSWwz8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AJtri/wB/SKFE6K/mAE/MK5ktv5dmwtYgmTUyinfUW6kXtdzUqv9JdsWZw9pR9UMS
         gEpuvRwB6nVXFFc60uPh7glhfKvGHv0rJerBkENe83beBUucIeFxopViVeV+FPjEfE
         zz9FjFOYVBxHhZE8TNTNMfg2S42/9j+KLOYDMVuo2n6NSLdEru7TEF7xArNBQ6oaO4
         zXBgdMVuSXGMg0i7TpL76K+I9xauJlvdJ1MLUJPe+91dc0CD/gPNsWkqmj9uh5U81L
         SSTPYIIwMHUdw4ikdON1qES5+v3WO7Qn5uIZCjf0JNRFiSkdmbnMq9pWx/bLDcA6Yf
         6mQ/L1/uUPtbw==
Received: by mail-ed1-f51.google.com with SMTP id cq23so12398894edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:50:36 -0800 (PST)
X-Gm-Message-State: AO0yUKUxtQG2V0DXUExJsPuA3tmqDlQrEu9NYUS5rxANcnkwHOIB4v5s
        3iyi6C+H43Mt6m/A2tH2uebT3uOGZVwc1aVJO1I4zg==
X-Google-Smtp-Source: AK7set/xRFpwnCoxLgum99HQ8FIFLRRgT/l3eH1cvDGf+UzSwwXcm9V5PbhfhnYZYOxG7ukQKQgQl3xTop4QDQVG4wI=
X-Received: by 2002:a17:907:1dda:b0:8b0:fbd5:2145 with SMTP id
 og26-20020a1709071dda00b008b0fbd52145mr12925454ejc.15.1677376235219; Sat, 25
 Feb 2023 17:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20230221184908.2349578-1-kpsingh@kernel.org> <Y/YJisQdorH1aAKV@zn.tnic>
 <CACYkzJ4cSA5xFScgS=WTc6tPis-vUCtYkh3LyEr8EkXoDCm-uA@mail.gmail.com>
 <Y/ZVaBKwbWUbF7u+@zn.tnic> <CACYkzJ4WigzaOCR4V9=e60ka=NNncWRB-j78DLRuzdSOZXvwrA@mail.gmail.com>
 <Y/dfyh1U/qDR1Ymw@zn.tnic>
In-Reply-To: <Y/dfyh1U/qDR1Ymw@zn.tnic>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sat, 25 Feb 2023 20:50:23 -0500
X-Gmail-Original-Message-ID: <CACYkzJ6U9HbMCPbZTnLf5_vWzRwCxk5j74pOSAVt-26ZS_C=pw@mail.gmail.com>
Message-ID: <CACYkzJ6U9HbMCPbZTnLf5_vWzRwCxk5j74pOSAVt-26ZS_C=pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/speculation: Allow enabling STIBP with legacy IBRS
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        jpoimboe@kernel.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        corbet@lwn.net, bp@suse.de, linyujun809@huawei.com,
        jmattson@google.com,
        =?UTF-8?Q?Jos=C3=A9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 7:45 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 22, 2023 at 11:41:59AM -0800, KP Singh wrote:
> > Sure, I think the docs do already cover it,
>
> I mean *our docs*. The stuff you're adding in your patch 2.
>
> > but I sort of disagree with your statement around the commit message.
> > I feel the more context you can add in the commit message, the better
> > it is.
>
> That's ofc wrong. And you'll find that out when you do git archeology
> and you come across a huuuge wall of text explaining the world and some
> more.
>
> No, commit messages should be to the point with a structure similar to
> something like this:
>
> 1. Prepare the context for the explanation briefly.
>
> 2. Explain the problem at hand.
>
> 3. "It happens because of <...>"
>
> 4. "Fix it by doing X"
>
> 5. "(Potentially do Y)."
>
> concentrating on *why* the fix is being done.
>
> > When I am looking at the change log, it would be helpful to have the
> > information that I mentioned in the Q&A. Small things like, "eIBRS
> > needs the IBRS bit set which also enables cross-thread protections" is
> > a very important context for this patch IMHO. Without this one is just
> > left head scratching and scrambling to read lengthy docs and processor
> > manuals.
>
> Yes, that's why you say in the commit message: "For more details, see
> Documentation/admin-guide/hw-vuln/spectre.rst." where:
>
> 1. you can explain in a lot more detail
>
> 2. put it in place where people can find it *easily*
>
> > This sort of loosely implies that the IBRS bit also enables
> > cross-thread protections. Can you atleast add this one explicitly?
> >
> > "Setting the IBRS bit also enables cross thread protections"
>
> Ok.
>
> > Not at the stage when the kernel decides to drop the STIBP protection
> > when eIBRS is enabled.
>
> We can't dump every possible interaction between the mitigations. It is
> a huge mess already. But I'm open to looking at improvements of the
> situation *and* documenting stuff as we go.
>

Well, we can try our best to print a message when we take a decision
on behalf of the user. As I mentioned, had I got any message that the
kernel was doing this it would have been much easier for me to figure
out why the POC was working. It was tricky without this to figure out
and I am capturing my broad chain of thought here:

1. cross thread training seems to work, this seems to be a bug
2. let me enable cross thread protections with a prctl
3. it still seems to work, did I get a printnk that my prctl did not
succeed or the kernel did something special? - no - why?

I will still go ahead with the patch that was "re-written" for me and
we can add debug information subsequently / as a follow up.

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
