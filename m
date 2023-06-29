Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B1742B98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjF2R42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjF2R40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:56:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D31FCD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:56:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991e69499d1so101389966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688061383; x=1690653383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jNOtAlZsxNFXBjiO7ePrUZV0+YgygUmrdD3PxgMZGw4=;
        b=XARa3SVN4NfQv2nZBsfksIva4mbWuedkl+RR8mKV6+zl4hg4QwKPyGPmh8iLekQIYx
         shKSY7SONko44IbPhyA1gMNTRLNPfcaLvpWsSCFwWVquAcn06qUC/Hf6wxdZOiXtLlC5
         R2PKqHLT3uvBSfJjiIXa3LV2xsTuyIYNVjIL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688061383; x=1690653383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNOtAlZsxNFXBjiO7ePrUZV0+YgygUmrdD3PxgMZGw4=;
        b=XeuxOWGy2eOXPh2JAUUP3BFsMD3hfnRGtXi1W748wcn5qvZP0GLP4nb4SO+LHNGdte
         oYYpGUYLHaDHJkBnZQZF+8IsHF9Ln9A0anvjrmqKOV9QMK/ONBa3eDq9L712r0FDLDpY
         BoFkME2dMBcU3ozmilx8bBVRwsUM7GPz81Axrpb32Ag+IcXWDaALBZDLFguXD9ykNAF8
         VP0jZpzSWManqEYdn2HECDVYqgBOp5R2Kjz3RncrgDRg6OQ2G9LUEpp8Eq9vZIarnkoi
         KFhNuzDyd6fhFMp/zH63yweGGeW9nbCYNMbAkxGR5GC1Pt0qry5Ay4wAI6Qv7L4aB/Pl
         mrtw==
X-Gm-Message-State: ABy/qLZqqczaTahCHhsgeBbh8Kvrtc4pTz9nIzE2qky1UKYrBKX491H3
        N+y7iIdNcGDjaWlYDr2ddZGNf939+QSsQ2i4WTzhH+wx
X-Google-Smtp-Source: APBJJlEcmg8OIpQ+A9SbZ3gxenkz9XZTLYJ/gUsM+3JWxE+WtKt4vTWsxV1E/bQEOpGcW7RuBdLD7w==
X-Received: by 2002:a17:906:3650:b0:989:4952:bf9f with SMTP id r16-20020a170906365000b009894952bf9fmr153898ejb.26.1688061383223;
        Thu, 29 Jun 2023 10:56:23 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090655cf00b00992099223a0sm3503391ejp.103.2023.06.29.10.56.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 10:56:22 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso1005576a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:56:22 -0700 (PDT)
X-Received: by 2002:a05:6402:f1a:b0:51d:8961:bf07 with SMTP id
 i26-20020a0564020f1a00b0051d8961bf07mr36999eda.3.1688061382069; Thu, 29 Jun
 2023 10:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com>
In-Reply-To: <20230629155433.4170837-1-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 10:56:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
Message-ID: <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, 29 Jun 2023 at 08:55, David Howells <dhowells@redhat.com> wrote:
>
> Matt Whitlock, Matthew Wilcox and Dave Chinner are of the opinion that data
> in the pipe must not be seen to change and that if it does, this is a bug.

I'm not convinced.

The whole *point* of vmsplice (and splicing from a file) is the zero-copy.

If you don't want the zero-copy, then you should use just "write()".

So I disagree violently. This is not a bug unless you can point to
some other correctness issues.

The "stableness" of the data is literally the *only* difference
between vmsplice() and write().

> Whilst this does allow the code to be somewhat simplified, it also results
> in a loss of performance: stolen pages have to be reloaded in accessed
> again; more data has to be copied.

No. It literally results in a loss of THE WHOLE POINT of vmsplice().

                    Linus
