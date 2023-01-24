Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8559A678DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjAXCHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjAXCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:07:45 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB659D8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 18:07:43 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id g10so10704470qvo.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 18:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=50sV1PQzpmv1GIPT6kqd6Ira4hwJi3tIjgRJ3whHKLE=;
        b=WC1LKNctfy4eydnASIndDHtIy8Wr4/3stuvjbJa8Uvd4/TD1f/sxkn9c3TltV1SMSi
         z/eASwJUMfjRuTspusNfBoD1HfR/DHYXfc+XbjZtgckiHylwiUdf0SOY9RhYxzfAPX1v
         tx0sOnmDOgq2ZfqssRyVQobRRRs1X1c5blmrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50sV1PQzpmv1GIPT6kqd6Ira4hwJi3tIjgRJ3whHKLE=;
        b=HgYFlgYwYQM2Ou04auV1Ii/9nZQqX7BkPMMq9sdD7pdqcViL4NEYinR5fN0MHSYFy3
         SUe/DUVU2EObcZcO7q/kPIcpQgPy1Vgl5AelHQxWdyzN7akZWd2lw7NWuZiIC/Yp0BEa
         NXiAC1RRSmCIS/9KyLHxAGWFo2hAlFyJVhHeNr+6zh/F5ZevZwovRwysRAyTQ4OPEdcs
         C/QrIZL1+sr3bJ6KiR9WodfAJSvo7wY5LUeVR47n3pkr+mQBFbtt1y/yVd45XHwpDjjQ
         +lwoPSLXWPYVilJtjCp8MWyZyca6jmrAVyjGYHIQWcgNlFNazeXnbK+ShAVvV4PPI5R+
         +mTw==
X-Gm-Message-State: AFqh2kqjzIID/1WvRudCZfMfGbzDq2tbEwviRbCABAXDuY8SzBilBstD
        o3ydQOf60Eq3kMkUI3YPZldvQk/nA0J5ODMk
X-Google-Smtp-Source: AMrXdXtxQRq3a7CaRJlxj0WnahidE4dP9yqPt2nqQJcYWXCiWj72knz5JOsmjWjB4zQNmyu15Fkepg==
X-Received: by 2002:a05:6214:310f:b0:4c7:9ef7:68b3 with SMTP id ks15-20020a056214310f00b004c79ef768b3mr37925613qvb.19.1674526062739;
        Mon, 23 Jan 2023 18:07:42 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a229800b006eeb3165565sm557036qkh.80.2023.01.23.18.07.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 18:07:42 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id z9so7394536qkl.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 18:07:41 -0800 (PST)
X-Received: by 2002:a37:6387:0:b0:706:92f4:125 with SMTP id
 x129-20020a376387000000b0070692f40125mr1467123qkb.72.1674526061654; Mon, 23
 Jan 2023 18:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Jan 2023 18:07:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJ2-ReHbDfLwjTVY=Sx=cFq+zNzp80ALQOb=V1+y0taQ@mail.gmail.com>
Message-ID: <CAHk-=wjJ2-ReHbDfLwjTVY=Sx=cFq+zNzp80ALQOb=V1+y0taQ@mail.gmail.com>
Subject: Re: [PATCHv15 00/17] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jan 23, 2023 at 2:05 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
>
> The capability can be used for efficient address sanitizers (ASAN)
> implementation and for optimizations in JITs and virtual machines.
>
> The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> this time.

I didn't react to anything objectionable in the series.

My only reaction was actually to ask "when / what CPU cores are
expected to support this feature"?

Maybe it was mentioned somewhere, and I'm just blind and not finding
it.  But even the "Instruction Set Extensions and Future Features"
paper seems to just be talking about the CPUID bits, not about any
actual "this is when we expect it".

(But again, I only scanned it, so maybe it's there and I just missed it).

                  Linus
