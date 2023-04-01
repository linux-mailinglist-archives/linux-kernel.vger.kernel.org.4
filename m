Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291406D3145
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDAOY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjDAOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:24:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B52E9ED0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 07:24:25 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8698C1EC03DB;
        Sat,  1 Apr 2023 16:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680359063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PD3w4Nwo7kaJ7jfPsGbRR0uimH6/CZeRlShDkidkEPE=;
        b=ZwgPDzkc7Tu4KlOPKKz9T/pB397xCoH3IjLrQj7dfaPJDbwO8hkJMTszhwu8flqXFGzLph
        FJ8GuClbMhjpj+VW4yxo8L8APx86cOkDAKOTGN4+/dz1NK4fws8o1PWYvC8HQ7r+TXo20l
        NvLKOxCnvXHvyEn5Tpu9NPYFRRzk4KU=
Date:   Sat, 1 Apr 2023 16:24:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 09/12] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230401142419.GCZCg+k9fgFPdAO4c/@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-10-jgross@suse.com>
 <20230329125128.GAZCQ0UJUj48VKdG//@fat_crate.local>
 <a6c02861-f01d-fcfd-82e0-8c5695f581b6@suse.com>
 <20230331125538.GBZCbYSqr8kMP4bpwS@fat_crate.local>
 <8860c326-3ba5-bd4c-1dab-17772e8fcda0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8860c326-3ba5-bd4c-1dab-17772e8fcda0@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 03:23:13PM +0200, Juergen Gross wrote:
> In general the critical case is add_map_entry_at() returning 2 (in the
> case it is returning 1, the index can be set to -1, but there is always
> the "continue" statement right after that, which would execute the "i++"
> of the "for" statement).
> 
> add_map_entry_at() can return 2 only, if it detects "merge_prev" and
> "merge_next". "merge_prev" can be set only if the current index was > 0,
> which makes it impossible to return 2 if the index was 0.

Yeah, in the meantime I did add some debug printks in order to find my
way around that code...

> How should it be named? AMD TOP_MEM2 MSR?

It is already called that way - see "git grep TOP_MEM2" output.

> The problem isn't an added MTRR register, but a possibly replaced or removed
> one. Handling that is much more complicated, so I've chosen to do it the simple
> way.

Pls put that blurb over the function: needs to be called when MTRRs get
modified so that the map is kept valid, yadda yadda...

> In the end I'd expect setting of MTRRs to be a rare event, so there shouldn't be
> a performance issue with that approach.

Ack.

> Okay, I'll add some more comments.

Thx.

> OTOH, what was hard to write should be hard to read (just kidding).

I'm not kidding - it is not super easy.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
