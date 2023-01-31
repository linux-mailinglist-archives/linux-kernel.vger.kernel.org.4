Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D016835EF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjAaTBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjAaTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:01:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1B59274
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:01:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m13so4161988plx.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1NzJQj+IlX2uUKAqxA9aAlIl32T8LLkBO2KdikgTrw=;
        b=POpr6rtUzbOEXVUyz0KPld50XaTfjwTRbNMH8d5J2igr75HqUw8wn90WpgqoDKL046
         RcWTXbeXPGvoPjqcW07ptOP3iHwWFeBXc8tiekDXDvF/LejmGtoREbloLtMUw65NODPf
         oLHldBXWNOrGGkj8iaZ2PsUPUYS76S0jwd/L5Sc9KKEHVKr9aZG+R7WXc2vwu7vygNGe
         P1aYV5t9cwjivcY8xAN2lvxFbYP5B4cTaxxgPLtGWnioZz3B8tdeDySLdPApRBrSAy1O
         Qt66RkBR4C0rG5qG5bOOPsVqkWckGjC3CYJveB1HNOHTaHCeNWI0YuIxqPf2Oh86mxmt
         dr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1NzJQj+IlX2uUKAqxA9aAlIl32T8LLkBO2KdikgTrw=;
        b=tE33rKwelQkocsM+LaD8REqw7r/BoBODcUjg5oIpOY3SF1gnEgH8IngRRIyEgl1iCL
         VdS9puxN5EZDhZuIXaR9+/55ykjNN2y1val27RaTXg/AsIYL1sLfcbnQAp90J06H4HEg
         gr8cxvbuzImm58cIYBZutqYP+j3bSPZlHDdpzmH8YOKwZCMfnA8ac4qYYAHbo94UWrKQ
         3A+HVoQxCae/FosSxoVwCQkwsEv71XH+7Nl74Kcn5kYBlw/FNTm699cgESDBcLllBd58
         luQNSpnYviDAygqbqTVaNfXWJqHrLIiDl2o4AbF/Zp/DEkc9OjVGa9L4/Cx4B8DzZCn8
         B9HA==
X-Gm-Message-State: AO0yUKU4CVT/yjxtQgVm2iiEvVwi1tpwOj48yEr75q6M9moFer24f+8F
        M+zVPm008OWbbfpxjkaCuVbh2CcYh07/nbIHdk8=
X-Google-Smtp-Source: AK7set8bc7F3qbqkhbudXFapyZSTiQa6mULkelevw59uR/GLAtno9GuThVSykdKYn4f2fcDI1+Jga0NXpcHac0PMfeQ=
X-Received: by 2002:a17:90a:cc5:b0:22c:4462:fb92 with SMTP id
 5-20020a17090a0cc500b0022c4462fb92mr3207848pjt.44.1675191662752; Tue, 31 Jan
 2023 11:01:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
 <20230130161817.a13365bca60543e34da27f48@linux-foundation.org>
In-Reply-To: <20230130161817.a13365bca60543e34da27f48@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 31 Jan 2023 20:00:51 +0100
Message-ID: <CA+fCnZcu8hjK8GQ0j2UnWFjyED9ys52pFG7zbnuRkUzGnP2BGg@mail.gmail.com>
Subject: Re: [PATCH 01/18] lib/stackdepot: fix setting next_slab_inited in init_stack_slab
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 1:18 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 30 Jan 2023 21:49:25 +0100 andrey.konovalov@linux.dev wrote:
>
> > In commit 305e519ce48e ("lib/stackdepot.c: fix global out-of-bounds in
> > stack_slabs"), init_stack_slab was changed to only use preallocated
> > memory for the next slab if the slab number limit is not reached.
> > However, setting next_slab_inited was not moved together with updating
> > stack_slabs.
> >
> > Set next_slab_inited only if the preallocated memory was used for the
> > next slab.
>
> Please provide a full description of the user-visible runtime effects
> of the bug (always always).
>
> I'll add the cc:stable (per your comments in the [0/N] cover letter),
> but it's more reliable to add it to the changelog yourself.

Right, will do this next time.

> As to when I upstream this: don't know - that depends on the
> user-visible-effects thing.

Looks like there's no bug to fix after all as per comments by Alexander.

Thanks!
