Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C20608EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJVRzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJVRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:55:37 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B4625D8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:55:36 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z8so3523614qtv.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PbMp9nRV4Rb1lNBp4ackx21snQ7p1o3AwWoBrCj3z4o=;
        b=YEvmspKkGkWBhn47N+fWxLUtC3jfzU4GqR7K00ks1EDc2cklpxvqvo0QWLjKAXbKRr
         z4iR+l75jIZEi+o+Dd0yB0w7OadiYkedJGd245WsA1+U9lWmMVvXf/KgKLcqV1dWYl7d
         Qcyxzs/vKjVZEuc/FwHAQYErTqXn7/0sE6WsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbMp9nRV4Rb1lNBp4ackx21snQ7p1o3AwWoBrCj3z4o=;
        b=jXZ/V35BgC/83Zxa+FQcgQnUzE4lGs2j5m0NQftOhi2vhny9oMCHzwtNXagGjRz243
         ffRsL6caqHhaVnhQIzbsLZuNDYyUTInK4eY98Wo6i+IRRNUMJqE9aM4+ei6bIvlABaEV
         1zLf65w5nl1A6wA0qS4CGz0PXeroTUu6MhV9th5Oai5yLbOXogCWkKwW1Ii72Pw6B/fA
         uDFaKRd2XmQEUq1Yzh5yxte2E17jGC6uptYKmZMtqjaHggt1jocRI4/VGqAl/fgVAmnM
         4iiZ15BByVWfZDB9F8x+bivuyOFWJbxN9CUlhspgWmd6rvQmwOj5aJg4qw/3giFsV5nE
         phAA==
X-Gm-Message-State: ACrzQf2dnUK/EvpETfPYl+aFnb/aHNFc7Ha52j0DJ4HhpEIm+3EfouRk
        3PZN3Tpox3LTdG2ay1K+L33bdcbrzOtiNQ==
X-Google-Smtp-Source: AMsMyM4809gWNGJ3W5xSQWCAmRHiEXdDT8r5P1sgGzzxr/ZwX0UpgsNO9532cdDQI3gJ9Xo90eQDCQ==
X-Received: by 2002:a05:622a:1aa0:b0:39c:ce01:8764 with SMTP id s32-20020a05622a1aa000b0039cce018764mr22061884qtc.401.1666461335072;
        Sat, 22 Oct 2022 10:55:35 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id bq12-20020a05620a468c00b006ee957439f2sm11524672qkb.133.2022.10.22.10.55.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 10:55:34 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-35befab86a4so51654927b3.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:55:34 -0700 (PDT)
X-Received: by 2002:a81:1902:0:b0:36b:2578:f6e2 with SMTP id
 2-20020a811902000000b0036b2578f6e2mr3138851ywz.352.1666461334165; Sat, 22 Oct
 2022 10:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114425.168036718@infradead.org>
In-Reply-To: <20221022114425.168036718@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Oct 2022 10:55:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjG4YzLQiQEE2cywyjG95Pi=nQWOsHydt03hWdJFTSDBA@mail.gmail.com>
Message-ID: <CAHk-=wjG4YzLQiQEE2cywyjG95Pi=nQWOsHydt03hWdJFTSDBA@mail.gmail.com>
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
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

On Sat, Oct 22, 2022 at 4:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The use of set_64bit() in X86_64 only code is pretty pointless, seeing
> how it's a direct assignment. Remove all this nonsense.

Thanks. That was really confusing code, using set_64bit() in exactly
the situation where it was _not_ needed.

                  Linus
