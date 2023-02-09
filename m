Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6507F690B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjBIOMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjBIOMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:12:40 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D125B7A95
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:12:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so1867584wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=su3TQDz5yXTmF+RZfbDiKjq2ZfrEp5aKu2QeW5sUFdk=;
        b=ld4R5ktQZflVtgBBzpKMH0OzWbuGN45SzQrGVks1RKxCPOIVBpvh7kY4zrbu+7pVdz
         cGBvFV4zH6KUkjTL6eDqzcQgUCppzvyjInzejUAvl5ZOQDeXyWF5MeX+4NdjHb7cmK8n
         9MT7pzR3i7/lMgq+YeGtApWvBsapRPsjo3kv3aXYR4sSNt4u1MnkoExKEVDxOlFCKaEe
         WJenb5rdez74rOV0mYwb7BDAEc3XEuWaczRzPDVLP56O5cRdP+3pRiINqFwOW7IcRK2x
         n6xRMjSV6h5wk10RurXzcNgWBETokcmLqjTCQDfbc3mVOnAyyOL1d1Dfw5FBiQiAP6s1
         OxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=su3TQDz5yXTmF+RZfbDiKjq2ZfrEp5aKu2QeW5sUFdk=;
        b=Dia3vCi5GXVp56yl864XuoSiYLZ4GaL66f7JsBB070kANGhCoKdo/PXgDZ94h80qPp
         zo6/8mhdOO0nohYjb1IhzkfG4DLtm5mRwrFIYSnMvD4Adc9rTq7fciltRKc2R/k12bCd
         jowcgfL5W5Mt3w6+UJ3mjUxenmAFAclolQyEE9gEM0NUK4WnP8CCKvTDUdVdNDnSt6oo
         /AYicbXCwLoTjxmq3haGurrR7HZSkjbOPTibMQ4i5ZU/MCAx+bCTGQ07JgNyesNFRmrt
         x3svYGZ5HMhOf+OwikDtZVi98ydmpS3YfWi0DY8yXDIkurfElGyXrxPLqbvCQG0JEyiI
         0DZg==
X-Gm-Message-State: AO0yUKW+d/ucBGk+koZrQhJomgAf9pcR/x0c+r2YkwkPTQiOD6EHg2Bv
        vJIribCiNM9qDBTw1tijr+AdzFsM4TboLpbPX17NXA==
X-Google-Smtp-Source: AK7set8G2aGfD230MGz2VhLMCgokNfco/vuVdLeUaR6D87k9Ih6xZya1aU75ZSxWIto6vtE5QwVkQS+ZUkeVh7eqmOg=
X-Received: by 2002:adf:e64a:0:b0:2c0:8af7:8153 with SMTP id
 b10-20020adfe64a000000b002c08af78153mr677353wrn.565.1675951958391; Thu, 09
 Feb 2023 06:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com> <20230123220500.21077-9-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230123220500.21077-9-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 9 Feb 2023 15:12:01 +0100
Message-ID: <CAG_fn=Wzs5341St=W+16OSaaZ711nymv2K+-C0fxqgOo45LwqQ@mail.gmail.com>
Subject: Re: [PATCHv15 08/17] x86/mm: Provide arch_prctl() interface for LAM
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
> Add a few of arch_prctl() handles:
>
>  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
>    of tag bits. It is rounded up to the nearest LAM mode that can
>    provide it. For now only LAM_U57 is supported, with 6 tag bits.
>
>  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
>    bits located in the address.
>
>  - ARCH_GET_MAX_TAG_BITS returns the maximum tag bits user can request.
>    Zero if LAM is not supported.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
