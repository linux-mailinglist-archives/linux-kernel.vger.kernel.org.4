Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD84068879D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjBBTjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjBBTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:39:37 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D6F7AE45
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:39:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j17so4573726lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JmnIaySd7zoAM6xF2ibXT8yo+UTOpvQnMVr9b5O/7+w=;
        b=ca1h9KkMFNsKgO7Ao0NeYlaifxp7NzGcaaakgNFyQLMxBSXDHTcSanf/uonLuKRR18
         lO7gVsm341hb9Nhg1BLsB8gPuvWRYHLOlq9HV87cUF6Vj8wjTPtsHShRpe/Vd30GyM78
         DjJAMh6ZqNcvDd+rLB79O+fNMlUiqjmmCA6so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmnIaySd7zoAM6xF2ibXT8yo+UTOpvQnMVr9b5O/7+w=;
        b=irPj4O9Ly2PhkeCVdox/ZDm+4aNU6tkf985Z6El1oTvbb22SNHshlW4h4RnBGRQ4ix
         ER1LyFytV+ARnCVBykMAt2/vpi0c+RoLfRkfbQIrCHQBWT/71yb4zCMNRZ265bML/pdQ
         L7EIFtTnCj8BRX90oPov5xFkiQNyG5Bgdao10NUInGnwiSN2XpFE+sLlFjhENW1xSxfi
         VfbdElxg2Vta5kYkBt+Lu+WRTO9zfzVpkXyWI3w+lHrFM1bljUK5+Gsy8ys5DymRs1ds
         5G+FMHN+2PczdFgZlpsk111huwOOajqm6pbkcgBi7Cy+4LfPhy869mzhuuVqywJupw8s
         Qe8Q==
X-Gm-Message-State: AO0yUKXTMfM9NzMjaNp/LdYqIa6/htsHaub4RW2iSz4HkhNw/8ru/uNM
        v9CW2QnCOAKhCI//FXaP+i7QLt77jLmfQwHhOUI=
X-Google-Smtp-Source: AK7set9vkxvLWxixnMnygEWTTjPJTw3TvXVuMZVP+OhKO22Hc4pUhjpGSmgxDvWhy5U1bUL/+nLJDA==
X-Received: by 2002:ac2:54af:0:b0:4cc:96fc:7b5d with SMTP id w15-20020ac254af000000b004cc96fc7b5dmr1782503lfk.52.1675366772154;
        Thu, 02 Feb 2023 11:39:32 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w18-20020ac254b2000000b004cb430b5b38sm25570lfk.185.2023.02.02.11.39.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:39:31 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id f34so4525295lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:39:30 -0800 (PST)
X-Received: by 2002:a17:906:f109:b0:882:e1b7:a90b with SMTP id
 gv9-20020a170906f10900b00882e1b7a90bmr2112186ejb.187.1675366759217; Thu, 02
 Feb 2023 11:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20230202145030.223740842@infradead.org>
In-Reply-To: <20230202145030.223740842@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 11:39:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF6y7CwR1P5_73aK2f=x=RZjwgh3sgeO3Mczv4XcDc8g@mail.gmail.com>
Message-ID: <CAHk-=wiF6y7CwR1P5_73aK2f=x=RZjwgh3sgeO3Mczv4XcDc8g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Introduce cmpxchg128() -- aka. the demise of cmpxchg_double()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     corbet@lwn.net, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-crypto@vger.kernel.org
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

On Thu, Feb 2, 2023 at 7:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>  - fixed up the inline asm to use 'u128 *' mem argument so the compiler knows
>    how wide the modification is.
>  - reworked the percpu thing to use union based type-punning instead of
>    _Generic() based casts.

Looks lovely to me. This removed all my concerns (except for the
testing one, but all the patches looked nice and clean to me, so
clearly it must be perfect).

                Linus
