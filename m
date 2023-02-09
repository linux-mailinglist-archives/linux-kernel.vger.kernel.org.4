Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFCB690B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjBIOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBIOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:09:32 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4F5D1F0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:09:31 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j23so1940554wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2wWrZfW6w5Lo0h1Oy2ItuQA9D/VzF8nnzUDHyvuMrIU=;
        b=qucTY+VUgkLKMzXYSk/yBQjtFtNj+c6L7TTuwK1Io3r7kfJFAj3KyITqXu/AW2vv6y
         FXdqmlgbpFi7gWp9TTtNm3Aao/lrwrh4V62bDLN4gAJD5gQbj7e9CEkTAMgFWIvpL/F2
         +EMDd3E+d6HSt0wFZa9G1DxwExyyCorEczfhrmQ/QA8tXN2QUTXxJauRsHWtkMUX5K3J
         q89nv1MIusbn5ds4ECYKtNBgrKgPUR7Lgro/zOyYEnVK11GhWmc5x4FtgWiVO8vvGWYo
         C1RSvB0MrHvwXpljDmuImmWC2NBYDBFKIPWOrDy0zBuUzXkj+VZI+KXvoC0wED4Qi6V0
         ZshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wWrZfW6w5Lo0h1Oy2ItuQA9D/VzF8nnzUDHyvuMrIU=;
        b=KtqePitPrIMt+86w3mT0wagsHxgC9Lzz6LKUsiXu5/aLK1HgbJ717pMoKXKPUC4eZF
         RR2g1H5zyD4UTWTklXG95RlKi3rnJ404mm8cEICgsMw36rMJDGNv+WzCwMPLyvjSjdlb
         63SVRiIPim29Gyn/ks6h9GB9d5GMKJdNep7GimojnjF03Vjxf9o8ZMxiMXr9R5Z4D7I3
         x+UThjhYpTN08m7Klt5mDXCruaT3BH/7U7vq49t8c9kgjLxfcQU54TGNy84LDVSlsOeb
         08xQZSkdTb3j7nCzfRPUa7mICEbo7yMl7Rym40DqwhKOfHTQi+UjbrppW/0CJ3RLDrfX
         Gpnw==
X-Gm-Message-State: AO0yUKXfwJoVCfTUHGjUwSPFH+88oRqJF3R7U822CEVR0hTkAZKtcqTe
        qvOXDzFhJP7Ae/jWFPIW597T0bE0jOBqtnaTGJ0HGQ==
X-Google-Smtp-Source: AK7set+1bMzTWNOQIBzf1vZLZYYVwjIVEW9uY+AIm1FM1LTCANjOjwy7DgqukiLUd8hdl+u6TgYhMmTwN8PRU8N0hbk=
X-Received: by 2002:adf:d0c1:0:b0:2c3:e5e3:c57 with SMTP id
 z1-20020adfd0c1000000b002c3e5e30c57mr234444wrh.400.1675951769996; Thu, 09 Feb
 2023 06:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com> <20230123220500.21077-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230123220500.21077-6-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 9 Feb 2023 15:08:53 +0100
Message-ID: <CAG_fn=WuxXWfDRAnJdNu2i0_g6jFhhh27fHHUksb12bSW+53Sw@mail.gmail.com>
Subject: Re: [PATCHv15 05/17] mm: Introduce untagged_addr_remote()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jan 23, 2023 at 11:05 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> untagged_addr() removes tags/metadata from the address and brings it to
> the canonical form. The helper is implemented on arm64 and sparc. Both of
> them do untagging based on global rules.
>
> However, Linear Address Masking (LAM) on x86 introduces per-process
> settings for untagging. As a result, untagged_addr() is now only
> suitable for untagging addresses for the current proccess.
>
> The new helper untagged_addr_remote() has to be used when the address
> targets remote process. It requires the mmap lock for target mm to be
> taken.
>
> Export dump_mm() as there's now the first user for it: VFIO can be
> compiled as module and untagged_addr_remote() triggers dump_mm() via
> mmap_assert_locked().
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
