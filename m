Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B111E60C26B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJYD6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJYD6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:58:30 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC282648E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:58:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id w3so6848789qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lF0FOzyra0GLG3l8w3os7D3TSDroC4u5G5xxnWbgASY=;
        b=MPuWEKHz6RTBfkMCR68F8G3+sfyRyn18Un82bYIsDwgRhug5tJdkscZyv3TvWdsy/K
         OSi+QtnYb10GgRsbsT4eHWWdp154o1jJ2CDYpjVyovvb1DrnBGV7f2OgG/sG9PIINPIn
         yED8rnUu2bEIG7hsA9fH/QTICnGfIyUFuHmpIsk4zviyWDlRgQQNI+NDqXfC6cgIVKOD
         VOYkIzU7BkVermeg0wkHxmmX5mRRF+QKpwkGqtHicul4KKBAlj3KvDziGDuZ+Lbgu4xT
         ckRHLJYnETb4aPRH3sAoARLlbQnZQ68sA4luYR24U8gM9GLZMdpayBJllElybOmz0Ds9
         tE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lF0FOzyra0GLG3l8w3os7D3TSDroC4u5G5xxnWbgASY=;
        b=YrAIS+ImjU2+IGWN68PnJasKluS4BMB/6yBttXAJD68Xc7GV7fTuBEGxZ43LoYW0W5
         ojDYjHy40l4mLaHSeutwncGc3wjwtX0NIvTuCFWCMVIRN5Vzt2z7GXc0hTxF9OUR1t7B
         QfCZh0Ibc6kViOp203zJbfNLYLIuDI/xIEG1ZaqNRpVQc1iqgG0r2vVyqA/3bhJEwKJf
         BDrOldiCM1I0VzFSTNBRBNORni97BdKi47JXqP9ru2Fyt3IxmEXi0z1ey+YYrcIWT+ON
         MAr2aYZtUk9Hrjiw9k0Yt3wseINbio4X4+g2fjix2E3WOWltofk5vCDY6JfbcwoAD3HM
         2R3A==
X-Gm-Message-State: ACrzQf3V1x1VfAbcg76DKymz8XVfEWzY7Cd2DY/QvsQrzDMDpKk1vybU
        s8uGUVf0tNqmQC1YfhOoiANRMQ==
X-Google-Smtp-Source: AMsMyM6PNYY/66fWp7yFfKQr/jYhKwwRE8zhOICbNGDutEYNvGqd0rRSff+W4AR9eR9SjpJvLajwGQ==
X-Received: by 2002:ac8:5cc9:0:b0:399:98dc:2c6b with SMTP id s9-20020ac85cc9000000b0039998dc2c6bmr30225835qta.549.1666670305584;
        Mon, 24 Oct 2022 20:58:25 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id br20-20020a05620a461400b006bbb07ebd83sm1247877qkb.108.2022.10.24.20.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 20:58:24 -0700 (PDT)
Date:   Mon, 24 Oct 2022 20:58:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 07/13] mm/gup: Fix the lockless PMD access
In-Reply-To: <Y1ZB6QeuzIk0W9m6@hirez.programming.kicks-ass.net>
Message-ID: <b8f7bbd3-e8e2-8bcf-5188-52415aa4925@google.com>
References: <20221022111403.531902164@infradead.org> <20221022114424.906110403@infradead.org> <796cff9b-8eb8-8c53-9127-318d30618952@google.com> <Y1ZB6QeuzIk0W9m6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022, Peter Zijlstra wrote:
> On Sat, Oct 22, 2022 at 05:42:18PM -0700, Hugh Dickins wrote:
> > On Sat, 22 Oct 2022, Peter Zijlstra wrote:
> > 
> > > On architectures where the PTE/PMD is larger than the native word size
> > > (i386-PAE for example), READ_ONCE() can do the wrong thing. Use
> > > pmdp_get_lockless() just like we use ptep_get_lockless().
> > 
> > I thought that was something Will Deacon put a lot of effort
> > into handling around 5.8 and 5.9: see "strong prevailing wind" in
> > include/asm-generic/rwonce.h, formerly in include/linux/compiler.h.
> > 
> > Was it too optimistic?  Did the wind drop?
> > 
> > I'm interested in the answer, but I've certainly no objection
> > to making this all more obviously robust - thanks.
> 
> READ_ONCE() can't do what the hardware can't do. There is absolutely no
> way i386 can do an atomic 64bit load without resorting to cmpxchg8b.

Right.

> 
> Also see the comment that goes with compiletime_assert_rwonce_type(). It
> explicitly allows 64bit because there's just too much stuff that does
> that (and there's actually 32bit hardware that *can* do it).

Yes, the "strong prevailing wind" comment. I think I've never read that
carefully enough, until you redirected me back there: it is in fact
quite clear, that it's only *atomic* in the Armv7 + LPAE case; but
READ_ONCEy (READ_EACH_HALF_ONCE I guess) for other 64-on-32 cases.

> 
> But it's still very wrong.

Somewhat clearer to me now, thanks.

Hugh
