Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA3A65B567
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbjABQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjABQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:56:38 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ABC33B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:56:36 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 186so30705585ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wKUflxNaDzEkyY/mzA+LlW6n4mjVpXQBQ+O9ORYw2l8=;
        b=qR9odOqKXr33I1Pul2uyRkhlTWeMYN4O3J2KjSbOijrEE1sg5N5UDAmrOtyLT8KyIU
         1DC+g2dQ9DUN6rK2dEeEQdPf2I1GsweK6bBy9o/1boZjOh5OFb9p+k1BTwiOzy6Ijpnu
         dVpjrwCbA6UoxQT/iQIDNw4eWdno/DRlXwC9OJs3wljgAQ11jXli4VPOXbnxmWWdoG6O
         elOV0E304NOb69aivr0GT6zw9qqPFGXhH6MZNoPGt0KOTHAozJpgSSrMC0EBKNg0rbQ1
         +yPEuu24esaAcyYddI9D+nxesaA2O8BoBS16HFT1ATcWLPNww1HpzRiSOE/GXoQ3615z
         65Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKUflxNaDzEkyY/mzA+LlW6n4mjVpXQBQ+O9ORYw2l8=;
        b=YhCGfCcFkKMseQ1Yey/lXKGQ7fy6ryHXfB1v6zeQrtGHiLCp3SLmGFXQ8ECBJyBmZU
         PCHjzX3eAGoQU+BBkU4sgV3nlfG+m0INZAwmxbo8Y0GDvR7WA84YDXtYqEuALJNfnBWE
         W4RzrLUsUp4OdnduNrkgnerQnIfO+JX9DkNKJr4DMPR/tLodbeQR3DqjtUSvpv5MSpIc
         z2Jp88ZOObCyDyHPP+DUSB6f9aQk9E56zY9PIMWGyQOaDElZ+538bbwoCfkrHTUQ7zAs
         i6OgfDjtqAMmxuYDbkwpbnO4B5mlZXbkVD2lN7r6MhieIkQZdQkRR5KJWdp6KCmlM9/w
         hq6g==
X-Gm-Message-State: AFqh2koXh4mNOjiK8oZg1h32lFtRMfE6DU21MASxLLFECVK6AUrmvAY3
        h+LfNrK/O4XxTT4UFSLRpliPmIw2JraJrV5O7Iej2lZn
X-Google-Smtp-Source: AMrXdXtiVaEYJev0Ttyv0djUxtirIUkM66KBNd7TvgzjvMT/amBFtknBDkktQ+s6kFzBGTm6SPlqbyLltMqZNQcH/No=
X-Received: by 2002:a25:4c81:0:b0:6f9:ece2:7b87 with SMTP id
 z123-20020a254c81000000b006f9ece27b87mr4712634yba.485.1672678595897; Mon, 02
 Jan 2023 08:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20221231004514.317809-1-jcmvbkbc@gmail.com> <CANpmjNNPTT+K3CRZN+RnUbHwmtUUzqb0ZDP=M6e8PHP0=qp=Ag@mail.gmail.com>
In-Reply-To: <CANpmjNNPTT+K3CRZN+RnUbHwmtUUzqb0ZDP=M6e8PHP0=qp=Ag@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 2 Jan 2023 08:56:24 -0800
Message-ID: <CAMo8BfJRb3aqkd6sdeT5DsDQAgZP4BBHCQgToCfN+Fxj6s-NuA@mail.gmail.com>
Subject: Re: [PATCH v2] kcsan: test: don't put the expect array on the stack
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 1, 2023 at 11:00 PM Marco Elver <elver@google.com> wrote:
>
> On Sat, 31 Dec 2022 at 01:45, Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > Size of the 'expect' array in the __report_matches is 1536 bytes, which
> > is exactly the default frame size warning limit of the xtensa
> > architecture.
> > As a result allmodconfig xtensa kernel builds with the gcc that does not
> > support the compiler plugins (which otherwise would push the said
> > warning limit to 2K) fail with the following message:
> >
> >   kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes
> >     is larger than 1536 bytes
> >
> > Fix it by dynamically alocating the 'expect' array.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
> Tested-by: Marco Elver <elver@google.com>
>
> Can you take this through the xtensa tree?

Sure. Thanks for your review and testing.

-- Max
