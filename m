Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB96150F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKARmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKARmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:42:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242A81C134
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:42:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 8so10071854qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VEycd8RlbAJ5XnCuKjnbIdJtCVqg8RDC/hCEwO7a6NQ=;
        b=YjRU+tsSmurMeVwzySzhPqI0t2VCknNkLnbOVIawDPOo1+GGY8Qoo5+fEXX3SaLP4S
         JLvN8q0IqPpqSC+bLu4zmaBYcCLAE4irKcs7j9Ox+/u0vFrKHctEBON7yKgVUju63ucv
         kDSte0QhaHpSgnfmPEpESzeoM157FKlvf+lLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEycd8RlbAJ5XnCuKjnbIdJtCVqg8RDC/hCEwO7a6NQ=;
        b=T46RObFXPOXV36aEnkorrtlCgoihrRR+MA5xPwtx278wR+aqDhBYhSK55fPO4xDn7r
         z7iwMCuZ4ub8WUrERtK1Oo+IMfjIqJPfQqMxECnYkfAPMxCWmw0z/8UsgQHUNgVqkge1
         GDc6cvklW5eRs2Kps+gDBIYCnMMnZ6lAB5uQab/QTETeD1apnsIOJpTvTA3WzgKuBB1n
         S/cRYXjncjWpBGa5nV4ElFmZTu65sNJA5oFM1C/XI4roYs5VMLT0gDjCGtyQOb0XQK5g
         rb2swM+Z8dJBYCvK3EmCawrO9b5MWH7GjAAxT0asE1dV8KSbbfjTSL3a08ZepegxYr5Z
         xlbQ==
X-Gm-Message-State: ACrzQf1PfM/knGDiYrnoCRNbdlpxm34koDuOjSJNfY6obPb8yR8NxrCQ
        o+oLzw55JeXswVtq77JReG+2BL5xj1skBQ==
X-Google-Smtp-Source: AMsMyM5eVKLrreMwXFqS1ahm6UhrjeaP8U4bJAQub5uleXF2uov5LJpSkdQDeiZhLkDZ4/N5dsu8Qw==
X-Received: by 2002:a05:620a:e1b:b0:6fa:1e52:30a5 with SMTP id y27-20020a05620a0e1b00b006fa1e5230a5mr11138292qkm.763.1667324549022;
        Tue, 01 Nov 2022 10:42:29 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a450b00b006fa2b1c3c1esm4487301qkp.58.2022.11.01.10.42.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 10:42:27 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id o70so18179745yba.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:42:27 -0700 (PDT)
X-Received: by 2002:a25:bb02:0:b0:6ca:9345:b2ee with SMTP id
 z2-20020a25bb02000000b006ca9345b2eemr7234903ybg.362.1667324547146; Tue, 01
 Nov 2022 10:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.711181252@infradead.org>
 <CAHk-=whKxHeW3tx8Q2_0sf=NW9RGUQYC1S2Km3eLC9jJ=whSRw@mail.gmail.com> <Y2EUEBlQXNgaJgoI@hirez.programming.kicks-ass.net>
In-Reply-To: <Y2EUEBlQXNgaJgoI@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Nov 2022 10:42:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2TN7Zj1uBGFo8H4dhxCgp-SPdon_Wm6kC8cYO8-i9Zw@mail.gmail.com>
Message-ID: <CAHk-=wi2TN7Zj1uBGFo8H4dhxCgp-SPdon_Wm6kC8cYO8-i9Zw@mail.gmail.com>
Subject: Re: [PATCH 04/13] mm: Fix pmd_read_atomic()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
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

On Tue, Nov 1, 2022 at 5:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So I've stuck the below on. There's a *TON* more to convert and I'm not
> going to be doing that just now (seems like a clever enough script
> should be able to), but this gets rid of the new one I introduced.

Thanks.

And no, I don't think the churn of converting old cases is worth it. I
just want to discourage *more* of this.

Using the same name really helps when you do a "git grep" for a
symbol, the whole '#ifndef' patterns for alternate architecture
definitions shows up really clearly.

So that - together with not having the possibility of mixing up names
- is the main reason I don't like the ARCH_HAS_XYZ pattern, and much
prefer just using the name of whichever function gets an architecture
override.

                 Linus

PS. I'd love to get an ack/nak on the "mm: delay rmap removal until
after TLB flush" thing.
