Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9676763F5AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLAQva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLAQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:51:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02962A429
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:51:28 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r18so2135826pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frCt6pKGWIhEPpxLesPSV/Mh3cTSx4zBWHAWHmqSudQ=;
        b=DwwmIVJCxrknnFgsAtQfghmeg6nsCZ8RoEEzEVvPbBI+wiM0sY1ZbxrczIzURz/60h
         G8+ccZ3zqtKCwPp2UrvRxEqizKfqh6SQv4BeP2xqCrHbJk9Y4Sz6MxKuuG404UkEWsv7
         8oV4Q0b0J53QS6xITTCYCcyqbBzo42atOFmjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frCt6pKGWIhEPpxLesPSV/Mh3cTSx4zBWHAWHmqSudQ=;
        b=Sbk54wxbeyYj9Hn+4jswA37z/YcoeZmobzu0QtDt8JbUF7xOG6+Sn/tEi8Cq9zveDu
         aMMtQLCnoRXVo1m5DewJi4O2Buf+rmLS2Z3fA+PFvIQYNBC5CL7ALLiBHLC8GjCsInFe
         6lQAxwrK45DfP7v70mysvzGo8tV2I8io4iz8eeyuEUCfoAxBJ7cb5EmdpdzH9AO0MqAZ
         FE0kvs4eTh5Y0wnKA/67d/59pBMhWDG9Fdb0rXRi1Z8yHoiglq1WtGUcOe1MbsMitsMJ
         kep01TZ7toXInNf0tvic8t0kzbmYVzoeKoqCnCsY0wNjt+AVQyPRJIV5LlzvdQBaZmv3
         EiXw==
X-Gm-Message-State: ANoB5pkwWMoYBjkJUWW437D70yaPg7/iPHtaL3qDh2uH3FFcEe6jXw4j
        a1HGIxkbizSRqY8Q3+Y5u5PRGg==
X-Google-Smtp-Source: AA0mqf7SQT+A6xpC5K3KTNxK3qiYLvhaoNq+xncGf94HScz3Qcx2ku1px8PEYfDLlOXelx/lEs/iXQ==
X-Received: by 2002:a63:5262:0:b0:477:6e5d:4e44 with SMTP id s34-20020a635262000000b004776e5d4e44mr44707636pgl.7.1669913487993;
        Thu, 01 Dec 2022 08:51:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001745662d568sm3844626plg.278.2022.12.01.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:51:27 -0800 (PST)
Date:   Thu, 1 Dec 2022 08:51:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
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
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
Message-ID: <202212010851.33009FA7@keescook>
References: <20221118035656.gonna.698-kees@kernel.org>
 <CA+fCnZfVZLLmipRBBMn1ju=U6wZL+zqf7S2jpUURPJmH3vPLNw@mail.gmail.com>
 <202211261654.5F276B51B@keescook>
 <CA+fCnZeb_Q==L9V2Cc2JbOfh11ZH+V0FC5C_q0Rs1NQYm74dUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZeb_Q==L9V2Cc2JbOfh11ZH+V0FC5C_q0Rs1NQYm74dUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:11:35PM +0100, Andrey Konovalov wrote:
> On Sun, Nov 27, 2022 at 1:55 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > > I just realized there's an issue here with the tag-based modes, as
> > > they align the unpoisoned area to 16 bytes.
> > >
> > > One solution would be to change the allocation size to 128 -
> > > KASAN_GRANULE_SIZE - 5, the same way kmalloc_oob_right test does it,
> > > so that the last 16-byte granule won't get unpoisoned for the
> > > tag-based modes. And then check that the ptr[size] access fails only
> > > for the Generic mode.
> >
> > Ah! Good point. Are you able to send a patch? I suspect you know exactly
> > what to change; it might take me a bit longer to double-check all of
> > those details.
> 
> Let's do it like this:
> 
> size_t size = 128 - KASAN_GRANULE_SIZE - 5, real_size.
> 
> ...
> 
> /* These must trigger a KASAN report. */
> if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>     KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
> KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size + 5]);
> KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - 1]);

Done, and tested! Thanks :)

-- 
Kees Cook
