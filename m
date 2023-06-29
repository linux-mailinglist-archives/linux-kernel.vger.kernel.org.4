Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B165742AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjF2Qmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjF2Qme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:42:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0675630E4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:42:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9891c73e0fbso154690066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688056951; x=1690648951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5w9ol53Pbytsh9JJtWN5s3IG7GIlT/ijcbnJWBLshdM=;
        b=KLEnhdgtu1c8kM62lKXQjj5JgvBYesh4er2kkookEOPNPvUhB+y6XBGIpsThY4Oz7c
         RqoxMNfBA/d6bI/EI60+uuUD06gTkpYEAI5h5V8fB0cCJJXD/2n7qzNNP/cDrK/lWzxu
         qg3NX0vGeSu/SOth9o5WfCH+j1hi/gtxz9+Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056951; x=1690648951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5w9ol53Pbytsh9JJtWN5s3IG7GIlT/ijcbnJWBLshdM=;
        b=d9zQY0st/J4Y8QkdFfpCF3HYj8UtQP6sYEXJ1m4HS49hhGp+r71plAG96rk4QwX1iJ
         J/paD4FMDRn9/MBafYyT4zltSymNibOqz7nFadD6R2rGgz9Vuc2X5WtKQFlWWAWIOAoZ
         G0jPV9yMCok79hcWAgrEulzbD71piWfwpI9ZVagA914o4r91IYhHLHAL5v+3MQ7OBYoc
         jaM73I9WqhQgu9x2FbR2lJDrsKW4RCmeYovUgmmZbdN3U/PPyGAlJHPAd9jlnrnx2IUz
         p1zN1gFt+rnzaPYLFCIRfi46pFc6uj9KUdXE6keBbLh6f4sGiapa0kInUBJG/3xP0q0j
         GVqQ==
X-Gm-Message-State: AC+VfDydZr+arMu8NCBgcjykkghXuqmHpVDmARLaMFXOfIXJy6995OZv
        37nSrSjfcwhtZFcrE7gJXG3rzYkM+c2+Sd9FbZIRWonl
X-Google-Smtp-Source: ACHHUZ4SS6DRqQoLyftMUj/lX9RP9IPTO/hfu6AWs5BKF1WKsOp6HMHVhl0Q7pApdy/kXkSPqGwB4g==
X-Received: by 2002:a17:907:6d09:b0:991:f0dc:c930 with SMTP id sa9-20020a1709076d0900b00991f0dcc930mr4947224ejc.16.1688056951131;
        Thu, 29 Jun 2023 09:42:31 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906948e00b0098d2f703408sm6984954ejx.118.2023.06.29.09.42.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 09:42:30 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1567907a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:42:30 -0700 (PDT)
X-Received: by 2002:aa7:d94f:0:b0:51d:a2d9:85a3 with SMTP id
 l15-20020aa7d94f000000b0051da2d985a3mr478016eds.8.1688056949878; Thu, 29 Jun
 2023 09:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230607053135.2087354-1-stevensd@google.com> <f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com>
 <CAD=HUj4vVbyHiT7vPmRorS+v9t2+N46ak=Xrew2cFf5+utC=tQ@mail.gmail.com>
 <8ef3ee-ba41-8e9e-4453-73736ff27783@google.com> <df5819aa-c79-6b10-4ce1-a45af118c0f3@google.com>
 <CAHk-=wj8b6joppjpYW=pi2r2LJgKHQKDwB9NkDmbsQAzWgf4AA@mail.gmail.com> <ee572217-204b-45d4-64f1-f6822fc6c35@google.com>
In-Reply-To: <ee572217-204b-45d4-64f1-f6822fc6c35@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 09:42:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWKTht64h8N6PcD=P-2mYTq3ThuqC4E2wZdzSyQxXt-Q@mail.gmail.com>
Message-ID: <CAHk-=wiWKTht64h8N6PcD=P-2mYTq3ThuqC4E2wZdzSyQxXt-Q@mail.gmail.com>
Subject: Re: [PATCH hotfix] mm/khugepaged: fix regression in collapse_file()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Stevens <stevensd@chromium.org>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 21:31, Hugh Dickins <hughd@google.com> wrote:
>
> There is no xas_pause(&xas) in collapse_file()'s main loop, at the points
> where it does xas_unlock_irq(&xas) and then continues.

Thanks for reminding me. Now applied,

                   Linus
