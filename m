Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83F972AF7C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjFJWXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 18:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjFJWXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:23:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222B23584
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:23:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30af159b433so2859302f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686435795; x=1689027795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6uujsqxk2yhJUnZO8C8LMRZDFMVQxUsWZqX3BJiMYo=;
        b=dqE0P6GdikJnbYFdQSRIi2KOgVqaDnasOeFyR7JM2mKAp2+dj8QCflKMZr6ElaYn2y
         GUVRS50A9wAiwLMHfalqLzULubL7s+KOITKlPOhgMMds2NedshymH0QnPhsDvrcsaAmG
         LEDm8puQhRiHft4VBQW17t74P7WyDGyzBzEsiftvuhCe1cSVeqhFQXxM9qjwuM3u+np/
         WMBnlG+nFpJBh1xIHpSjO+TJvZ3Vyc3kbNQx0Ln0wzt7Q+hFY+0qh3A8KotjrEssuzoQ
         XhTomxufEdzbT8DzkwUL8Nu7B+G7ohtOlfpfoMTCCbBTjAMyP3kE2m0CsqfNzQW3SlrM
         9OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686435795; x=1689027795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6uujsqxk2yhJUnZO8C8LMRZDFMVQxUsWZqX3BJiMYo=;
        b=HMy0d1ERjmBD2ESqNcPFNldWNWsSSt2/x25kiSXkIrncFOFmdzBXAaSURwOMdy7Z6Z
         xwTvu/gO3ZxT/bMzSTTKoGqS2Dmj0Ms0RUw+bV66IDliMT0RDOelLty0FDlMTV0Ka7wJ
         UYWMckuW/HTnjx8gu1MJwqMxu+a72MHF1HlXsoh7ZJBKy9yATXEn2VPI7M5Sj8rNmZqM
         V5CMep+9WtJOHTKf4hQYoAc8UIQoObyk0pV4Yxmokv7F7ilAwBkdm0SRjjAD6XqOSQC/
         IsbhZjZGY6HFnrpLC0/+QsNjhZ3YeUB7m3NtlgixDydsioLUsDQIgZ9LXyQzRXmfNhlg
         yROg==
X-Gm-Message-State: AC+VfDyRZtiH00VNjHdo70+mtSAWwz3G0CNwn3Kk7o1XHC2E3NItAC1E
        sveA/M3O5bHlkqhLSAc+mzGiy8wyQXQ=
X-Google-Smtp-Source: ACHHUZ5bZ1sBnZaeM/asURPTfk2/lAvVnMr23APe2Et/y/Cg61gmXxb4Xy7tnYS2NdlK80vo63YpdQ==
X-Received: by 2002:a5d:4208:0:b0:2d2:f3e3:115d with SMTP id n8-20020a5d4208000000b002d2f3e3115dmr2232033wrq.59.1686435795330;
        Sat, 10 Jun 2023 15:23:15 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id b14-20020a056000054e00b0030c2e3c7fb3sm7961901wrf.101.2023.06.10.15.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 15:23:14 -0700 (PDT)
Date:   Sat, 10 Jun 2023 23:23:13 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:VMALLOC" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH] mm/vmalloc: Replace the ternary conditional operator
 with min()
Message-ID: <2489af27-0e6e-4005-b2c0-dd4e55d15154@lucifer.local>
References: <20230609061309.42453-1-luhongfei@vivo.com>
 <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
 <3fc87d60-4e81-4f49-95f0-0503ad5cdf35@lucifer.local>
 <f53f28de489f4c209776e404323ef5a1@AcuMS.aculab.com>
 <ba45584f-41a2-4d06-8443-e7e64375b07f@lucifer.local>
 <20230610150809.babdc5a7919258f066c8637e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610150809.babdc5a7919258f066c8637e@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 03:08:09PM -0700, Andrew Morton wrote:
> On Sat, 10 Jun 2023 22:06:35 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> > > > OK, as per the pedantic test bot, you'll need to change this to:-
> > > >
> > > > num = min_t(size_t, remains, PAGE_SIZE);
>
> PAGE_SIZE is a nuisance.  It _usually_ creates the need for a
> cast:
>
> hp2:/usr/src/linux-6.4-rc4> grep -r "min(.*PAGE_SIZE" . | wc -l
> 117
> hp2:/usr/src/linux-6.4-rc4> grep -r "min_t(.*PAGE_SIZE" . | wc -l
> 279
>
> Perhaps it should always have been size_t.
>

I mean I absolutely agree this not being size_t is a bit silly although I'm
pretty convinced sizeof(size_t) == sizeof(unsigned long) in all kernel
arches (correct me if I'm wrong).

So I'd not be against this at all :)

> I suppose we could do
>
> #define PAGE_SIZE_T (size_t)PAGE_SIZE
>
> And use that where needed.  Mainly because I like the name ;)

I'm not sure I love that name :P but it is kind of cute I guess!
