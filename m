Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089C6F1C46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjD1QIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345415AbjD1QIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:08:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A91BC3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:08:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9505214c47fso1899248166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682698121; x=1685290121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfSng8MyOFNSU5Ks9K4WLSf/Qc3whKmNVFv1pCFwpjk=;
        b=S0QZsTDHV/QsE8SxaCJVfdCeghM/5ottpsfawwTOtbtMNdBeUseCb70w8siqbSpdY3
         DdYjQMoJrCwpTIlmFl1QMBNlRJkr/F6GAMsrl5ktWUq4SvGoTOxfB3Y0/8rZg8kskQp1
         +OCce9DGyB2GiTapK82PooKCfQWSQVnqrHWJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682698121; x=1685290121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfSng8MyOFNSU5Ks9K4WLSf/Qc3whKmNVFv1pCFwpjk=;
        b=PFtx6eiW3bsR+6TsHWxxZ1+gkghqLcClhGDwHHdaJqlDAhW+byszsjyIHkWWFD/tR3
         /d8IXJyNLyDF8Tt1G+G59RX/rXifhGP8Gr5ZCxcrtGlm39Z8fQsLF/WPVQUwjp2HHVI8
         KMvOuNBervvlsNybTn7xRy6y8B7wylIkMxyhsfIrj9xTfxbQN0JxqwibaHFdvCIOBDRP
         GWO3gbCJWcscjNGaXLSM2+SZjJths8PJM9dzvQs0gYVZwQzut0UIFNJl8ey3waq0iBDT
         0nj0fyfNeQDyEIHTD19YUZ3gYPOOSzaPcG58IuwSwRAfxvp84K2IxAmhyvD7UG3Dnsu6
         4uMQ==
X-Gm-Message-State: AC+VfDx5U9DoY82XFCLko4EdTOOA8j1r3oRLhRT/uOll6/FHOrETisXN
        eDnFWIWAT0Gwp3ZMeHioccQuxpoXg70JRmuIwreDWQ==
X-Google-Smtp-Source: ACHHUZ6otjjuAOJ6AgbSwbDPZHtEKw6/eSACKBd8T9UwZCe//2Eu4Xm6IYm2QTWTmK3bqjuy7rQ05Q==
X-Received: by 2002:a17:906:5d0d:b0:94e:3d6f:9c0f with SMTP id g13-20020a1709065d0d00b0094e3d6f9c0fmr6589965ejt.55.1682698120656;
        Fri, 28 Apr 2023 09:08:40 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id vh7-20020a170907d38700b0094f31208918sm11278514ejc.108.2023.04.28.09.08.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 09:08:39 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9505214c47fso1899237166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:08:38 -0700 (PDT)
X-Received: by 2002:a17:907:988:b0:959:bbda:fa51 with SMTP id
 bf8-20020a170907098800b00959bbdafa51mr5254889ejc.41.1682698118661; Fri, 28
 Apr 2023 09:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
 <CAHk-=wi5=LfeCMv5ZPAtzWhJyW=y1rVJFTRBfgcqzoUNk5NRDA@mail.gmail.com> <CAJuCfpHZSEjG2nti5iWbPQjWgXcHZ95hFS2FKwaPC-sZPdSznw@mail.gmail.com>
In-Reply-To: <CAJuCfpHZSEjG2nti5iWbPQjWgXcHZ95hFS2FKwaPC-sZPdSznw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 09:08:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SyFDp_sdcEH-D+LNxuzL_dWA1vZEowUN16n_+yRHPQ@mail.gmail.com>
Message-ID: <CAHk-=wg0SyFDp_sdcEH-D+LNxuzL_dWA1vZEowUN16n_+yRHPQ@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 9:03=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> I wanted these stats enabled by default to be able to identify
> possible pathological cases and to also let users disable them if they
> can't tolerate even a small overhead in the pagefault path. Should I
> document this reasoning for the config option?

You should document what the stats actually count (at a high enough
level for a user to understand), and why anybody would want to keep
them on.

Honestly, 99% of the time, these are things that *developers* think
they might want, but that nobody else will ever ever use.

Really, ask yourself if a normal user would ever look at them?

Now, ask yourself whether this might be something that a cloud
provider would want to look at to gather statistics.

And if it's the latter case, then it should be "default n", because
the default should be for the people who DO NOT KNOW, AND DO NOT CARE.

The cloud provider will be using a custom config anyway. The default
is irrelevant for that use. The use that *matters* is literally the
clueless end user who I bet will never look at these numbers, and will
never be asked for them.

               Linus
