Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C8C6EFA13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjDZSbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDZSbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:31:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B53B19BC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:31:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-506c04dd879so12942388a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682533877; x=1685125877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uTv2Sl9PDUU54eNd3QncqSfjAzwjfz21lg3kZ1obAs=;
        b=en2KQ6jA3+qMSieJhDnfovGfYROoA8+yYoy81+MjkpL259xbRA3XKAEpm97Ov/VspE
         N04WDGKWmt8aNRY4rr76U5iYXJhadKvdTUN61NLFBWUfR/lsl7t+nH8G5GIBXLcpWxTD
         JoifHNadRH0wQioTUsr3VPb6kBllZ8thmIQQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682533877; x=1685125877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uTv2Sl9PDUU54eNd3QncqSfjAzwjfz21lg3kZ1obAs=;
        b=P2aDPsS//j+WhHi3D5fkBJiO6arPeKeRb5nnO+zWQez0K44oLC2Hq9o87ietZbCILe
         HVCGZ1ut3m1CEQgpx7lNTcye5gWu2Pte+rtq/LMl3Y+TefIR6ovRRUkeGDNOsTFT4AAv
         t1P41XtytCpx4iUgcbDA425603agmVtP4OQvLQRM927THWSKEIx26hARGY42K7Q1zHvU
         1cEY2PpBI76sKaXLVcbxepx1KHFsRA2kcGM5IGENoSX86zeQiGT8UIbIynMQJgzYMDSX
         ms0GxQRWwt/BqjOnpwV+AtRDgHs6/GgjVhwBlshVm0osferNb6mGGTYJkrtNgoEQ7o0H
         N56w==
X-Gm-Message-State: AC+VfDz+flZI/c/VxDKIYln9JXYucSyNBuBKTeq576LagkkYjQYUJTCa
        sk/MMIawxxg5YzGA+6W9IWuT9BLQL2BREy05+DszDA==
X-Google-Smtp-Source: ACHHUZ4/5V4D3uVQC0Ax2hR1x4BnKnmx3aKtEtuAHWjyzs1SkMQKIPDnkKUHlIHg03d7ygFvPiRuQw==
X-Received: by 2002:a17:907:a605:b0:95f:133a:9b60 with SMTP id vt5-20020a170907a60500b0095f133a9b60mr2784930ejc.57.1682533877165;
        Wed, 26 Apr 2023 11:31:17 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id gj19-20020a170906e11300b0095ec8dfc439sm1806076ejb.166.2023.04.26.11.31.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 11:31:16 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-505934ccc35so12949758a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:31:16 -0700 (PDT)
X-Received: by 2002:a05:6402:1a4e:b0:506:b228:7b03 with SMTP id
 bf14-20020a0564021a4e00b00506b2287b03mr19505052edb.13.1682533875997; Wed, 26
 Apr 2023 11:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <ZEljCgVFnDl/C+l3@debian>
In-Reply-To: <ZEljCgVFnDl/C+l3@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 11:30:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=winmePW-RJdPEE031U=7z92aAv5TAnTU0bR74uEZOMb3Q@mail.gmail.com>
Message-ID: <CAHk-=winmePW-RJdPEE031U=7z92aAv5TAnTU0bR74uEZOMb3Q@mail.gmail.com>
Subject: Re: mainline build failure due to 322458c2bb1a ("drm/ttm: Reduce the
 number of used allocation orders for TTM pages")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Apr 26, 2023 at 10:44=E2=80=AFAM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> drivers/gpu/drm/ttm/ttm_pool.c:73:29: error: variably modified 'global_wr=
ite_combined' at file scope
>    73 | static struct ttm_pool_type global_write_combined[TTM_DIM_ORDER];
>       |                             ^~~~~~~~~~~~~~~~~~~~~

Ugh.

This is because we have

  #define TTM_DIM_ORDER (__TTM_DIM_ORDER <=3D MAX_ORDER ?
__TTM_DIM_ORDER : MAX_ORDER)

which looks perfectly fine as a constant ("pick the smaller of
MAX_ORDER and __TTM_DIM_ORDER").

But:

  #define __TTM_DIM_ORDER (TTM_MAX_ORDER + 1)
  #define TTM_MAX_ORDER (PMD_SHIFT - PAGE_SHIFT)

which still _looks_ fine, but  on 64-bit powerpc, we then have

   #define PTE_INDEX_SIZE  __pte_index_size

so that __TTM_DIM_ORDER constant isn't actually a constant at all.

I would suggest that the DRM code just make those fixed-size arrays
use "MAX_ORDER", because even though it might be a bit bigger than
necessary, that's still not a very big constant (ie typically it's
"11", but it could be up to 64).

It's a bit sad how that macro that _looks_ like a constant (and is one
pretty much everywhere else) isn't actually constant on powerpc, but
looking around it looks fairly unavoidable.

Maybe the DRM code could try to avoid using things like PMD_SHIFT entirely?

                Linus
