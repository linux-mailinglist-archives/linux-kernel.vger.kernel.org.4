Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4638F68883A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjBBUZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjBBUYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:24:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB56EADB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:24:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v10so3251945edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M6HsC50aGCO7W8N50fVJSxtjDprl/+8JFYrOxszA6JA=;
        b=eVvqh/ZO+ZwZXJD78ngiSxjCCBWjvgqEglnRH+lPiOGmIRY47s7BBazSPfGb67DR28
         iQKUGRqpf0A56PDc1Ay8X9MNsLXEPCRIOE2BB6gnoYYrVQpBVH7WDPGsU4sBAU2Jtd83
         C5HNHPmOUYszp/BNQX+NTLE3aZ+WMpwktt/zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6HsC50aGCO7W8N50fVJSxtjDprl/+8JFYrOxszA6JA=;
        b=TGii7tnDsQFC/2e9ijseCbWgObqKKcKstwnO+fxyppUpPys5n26V2eQpL2T+L+iIFa
         gsVCjyHftBefILh4aysk4rUqAtjGYFWWdvyhkbZTPUf//R3NLKtvJAM61mUo06vDMga5
         NOYSp+sbQ578ZgiQX1AETiNkIco4b1isaexm1PrlJWVXtvYrP+nkgPJXOIWGG4Eo92rY
         R3cIszSwHp3GKW3L/KJCi0MeGgM00Al4qa3eWgAkRhY2GavBhTxpOfiLhnbWjAkNPWlB
         ExGOkY5/xJqmzHNQbe99BTWx8yFKSGNejHbNFd1Y7Tigo05cDQexvT6UBnropRuEtn9r
         cgow==
X-Gm-Message-State: AO0yUKXER406zeiqbfTTxgdgVCK/53rRMfiBldfUYtXGIESt6oOk+DMq
        chTMv0Wa8+foyw4JSUgoOYySp5JGG8+wmXZ0gykriQ==
X-Google-Smtp-Source: AK7set/WMOX7tSqxQWLrzivG1qX/o1we2/gPPiwWMBHqv5uwZnJHge3UrZb0PaNaTBdUk18trrJPeQ==
X-Received: by 2002:a05:6402:558:b0:4a0:b640:6505 with SMTP id i24-20020a056402055800b004a0b6406505mr7661291edx.34.1675369488871;
        Thu, 02 Feb 2023 12:24:48 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id er18-20020a056402449200b0046892e493dcsm186329edb.26.2023.02.02.12.24.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 12:24:48 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id bk15so9390682ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:24:48 -0800 (PST)
X-Received: by 2002:a17:906:f109:b0:882:e1b7:a90b with SMTP id
 gv9-20020a170906f10900b00882e1b7a90bmr2149759ejb.187.1675369487833; Thu, 02
 Feb 2023 12:24:47 -0800 (PST)
MIME-Version: 1.0
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info> <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
 <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com> <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
In-Reply-To: <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 12:24:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
Message-ID: <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 3:38 AM Christian Kujau <lists@nerdbynature.de> wrote:
>
> On Wed, 1 Feb 2023, Juergen Gross wrote:
> > On 31.01.23 23:50, Christian Kujau wrote:
> > > [Leaving the full quote below for reference and adding more appropriate
> > > people.]
> > >
> > > After a far too long round of git-bisect I narrowed it down to:
> > >
> > >    c1c59538337ab6d45700cb4a1c9725e67f59bc6e is the first bad commit
> > >
> > >      x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case
> > >      commit 90b926e68f500844dff16b5bcea178dc55cf580a upstream.
> > >
> > > And indeed, reverting this single commit from v6.1.8 (stable) makes the
> > > disks appear again.
>
> This also happens on mainline, not only in stable. Reverting this patch
> from 6.2-rc6 makes the disks appear again.

I think the patch is simply wrong and should be reverted.

The way hardware works, MTRR_TYPE_INVALID implies UC-, not WB.

So that commit 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR
disabled case") is simply wrong to say "disabled means the same as
WB",.

That said, I think mtrr_type_lookup() is wrong too. It has two bugs

 (a) it basically returns the wrong mtrr type for the "not enabled" conditions

 (b) it doesn't set the "uniform" bit for said conditions, which then
causes problems for callers - the hugepage case in particular only
checks for that MTRR_TYPE_INVALID case because of this.

 (c) it sets is_uniform wrongly for the fixed mtrr case, but I guess
the only thing that cares is largepage, so it works

and I think the !CONFIG_MTRR case has the same issue.

I'm not convinced it *ever* makes sense for mtrr_type_lookup() to
return MTRR_TYPE_INVALID (it makes sense for the helper functions to
do so to let the code know to look at other mtrrs, but not the final
lookup).

And at a minimum, the !MTRR_STATE_MTRR_ENABLED case seems very wrong -
if mtrr is disabled, it should return 'def_type', no?>

So I think that commit should be reverted as broken, and then people
should *maybe* look at something like this (intentionally whitespace
damaged, and people should *really* think about what the
MTRR_TYPE_INVALID case should be - returning UC- is probably what is
closest to "this is what the hardware does", but maybe doesn't make
sense for the largepage case, which might as well just always use
largepages in that case?)

   --- a/arch/x86/include/asm/mtrr.h
   +++ b/arch/x86/include/asm/mtrr.h
   @@ -53,7 +53,8 @@ static inline u8 mtrr_type_lookup(..
        /*
         * Return no-MTRRs:
         */
   -    return MTRR_TYPE_INVALID;
   +    *uniform = 1;
   +    return MTRR_TYPE_INVALID; /* ??? */
    }
    #define mtrr_save_fixed_ranges(arg) do {} while (0)
    #define mtrr_save_state() do {} while (0)
   --- a/arch/x86/kernel/cpu/mtrr/generic.c
   +++ b/arch/x86/kernel/cpu/mtrr/generic.c
   @@ -261,11 +261,13 @@ u8 mtrr_type_lookup(..
        /* Make end inclusive instead of exclusive */
        end--;

   +    type = MTRR_TYPE_INVALID; /* ??? */
        if (!mtrr_state_set)
   -            return MTRR_TYPE_INVALID;
   +            goto out;

   +    type = mtrr_state.def_type;
        if (!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED))
   -            return MTRR_TYPE_INVALID;
   +            goto out;

        /*
         * Look up the fixed ranges first, which take priority over

But note how I think the !MTRR_STATE_MTRR_ENABLED case really should
return the default mtrr type, and that looks fairly unambiguous to me.

Hmm?

            Linus
