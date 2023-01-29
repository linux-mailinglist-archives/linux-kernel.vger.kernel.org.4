Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7849868016D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjA2VLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2VLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:11:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC31E1CE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:11:38 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AB641EC0513;
        Sun, 29 Jan 2023 22:11:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675026697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ao4ZTyLFQER6FOusfpBp1QZgnuC0RebzWTieewGKCy0=;
        b=Kfq03Fhc5OPkEx4IRb2s/f1plL+k2fCS3ohYAZvzC80tIV8HnqyUqM9teNjuC168araFhw
        K0xUPNrvQvY+h3gl3eKtHN1ooiXWTN86h1M7JQfLhKFo2gFmGEwooI8I0y41ST3D+m9LGS
        9lazr5xtTWxCOslkPz4RdEV37WlsCGg=
Date:   Sun, 29 Jan 2023 22:11:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Subject: Re: Failure during Stack Depot allocating hash table of 1048576
 entries with kvcalloc
Message-ID: <Y9bhAyu9IJ9yBdN2@zn.tnic>
References: <Y8Fq5m0CLfcFLCOY@zn.tnic>
 <07e42002-e78d-7947-19a7-0dd035466f50@alu.unizg.hr>
 <Y9UBFNwBeuePPsk3@zn.tnic>
 <d4871e70-c7c9-e638-d7c0-304ec8aea77b@leemhuis.info>
 <Y9UweHxSfPiAqgZx@zn.tnic>
 <20230129125014.fcd459335c9b8eae71067c1a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230129125014.fcd459335c9b8eae71067c1a@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 12:50:14PM -0800, Andrew Morton wrote:
> OK, thanks, I didn't realize this issue was so serious.

Yeah, I wouldn't call it serious - as a precondition, you need KMEMLEAK enabled
which probably shouldn't be run in production. For some reason it was enabled in
that test box's config - that's how I even saw this in the first place...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
