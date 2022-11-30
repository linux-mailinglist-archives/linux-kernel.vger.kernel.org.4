Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2C563D7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiK3ON1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiK3ONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:13:01 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B071D81D8B;
        Wed, 30 Nov 2022 06:11:46 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 9so16915783pfx.11;
        Wed, 30 Nov 2022 06:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8cVvNyKtufNa8rAjSWHiN1tGPoWILfr7xg86SXOtMxo=;
        b=XKwVdAfOI1u1oPLKzd3snv3q/AZbbwGy3n8Lr7XL5R3R1ln0sKbkvKztrFolUep3wL
         DBQqw3BQANZ0judOonr2BgnmNyboGPg9nOs65Se5996SEOSgoZODKNcVl0T5qWQZbdrk
         9CfjK7DKNsFXwmr0gXy2IbSHVZRysBKiRdovbCi1wItupMJqQp04nKMuS8HMvaK87uam
         lGXcgU8lXCtRE8hM6lD6426YQ1cjp0PCQMZ85kCEflva3PJsga+pn3Rw4aQbdLdAMp2/
         fS9dKDlctIi8N2mw5CokipJbU0x+KM/A+DJ5Y6gNxsS1wiDg6PAC/cs5UIJeZxWPLOmY
         Qlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cVvNyKtufNa8rAjSWHiN1tGPoWILfr7xg86SXOtMxo=;
        b=BED/PWzb4Dq/cLgc0pokMgjXMza0JJp0q2zjNgOdlq+4psOLQQHOAbCAql4S1X6vdN
         0vdSvyki/LooYpWLoxi9B9AtMw04hVqwViECdLE8zo0V4On6PBKjXHnsbzx7YX7bod7A
         zKHqc1XSLMaiQjmWiqQrw38jQT0pgLkzJMjRuRvRHGDaOtVvzb4YYLvTgFidoe9MRh79
         WEc1VMU9RkeuC38Ud+/qsXBm+3K9hH6Q2o4d7/mhIqrATJlAr9PG7Z8m7fIKqV4eJmTI
         BpLcMFq0iHpEHszFuOx+eaViJqVO8BgIiDQ1a5MuNQut11UGSgbh4qybp1PMfzSJl/aV
         5D3g==
X-Gm-Message-State: ANoB5pmYOcwwBoKRa1fpGfsu6SeZhdXlACrB/cWU2gDs9XhdLf32hfI9
        ZDPv3EP62sPu+a1zcuzS/9cARXeQFilrlSHliU0=
X-Google-Smtp-Source: AA0mqf7yVsc7I8xt+oo4P1rrPtumZTeAyGc9Feqy40OPOKxUqMquajvaM/o/s/5QWepRzcJmv848dtFhVXPohDHxnGA=
X-Received: by 2002:a62:2702:0:b0:572:8766:598b with SMTP id
 n2-20020a622702000000b005728766598bmr42059861pfn.21.1669817506180; Wed, 30
 Nov 2022 06:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20221118035656.gonna.698-kees@kernel.org> <CA+fCnZfVZLLmipRBBMn1ju=U6wZL+zqf7S2jpUURPJmH3vPLNw@mail.gmail.com>
 <202211261654.5F276B51B@keescook>
In-Reply-To: <202211261654.5F276B51B@keescook>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 30 Nov 2022 15:11:35 +0100
Message-ID: <CA+fCnZeb_Q==L9V2Cc2JbOfh11ZH+V0FC5C_q0Rs1NQYm74dUg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 1:55 AM Kees Cook <keescook@chromium.org> wrote:
>
> > I just realized there's an issue here with the tag-based modes, as
> > they align the unpoisoned area to 16 bytes.
> >
> > One solution would be to change the allocation size to 128 -
> > KASAN_GRANULE_SIZE - 5, the same way kmalloc_oob_right test does it,
> > so that the last 16-byte granule won't get unpoisoned for the
> > tag-based modes. And then check that the ptr[size] access fails only
> > for the Generic mode.
>
> Ah! Good point. Are you able to send a patch? I suspect you know exactly
> what to change; it might take me a bit longer to double-check all of
> those details.

Let's do it like this:

size_t size = 128 - KASAN_GRANULE_SIZE - 5, real_size.

...

/* These must trigger a KASAN report. */
if (IS_ENABLED(CONFIG_KASAN_GENERIC))
    KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size + 5]);
KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - 1]);

Thanks!
