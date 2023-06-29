Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB474312F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjF2XlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2XlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:41:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5D0170B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:41:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98e109525d6so222660666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688082078; x=1690674078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MXt+lksofF+9QajMg5KFkux1Y51FEVAStlJ8D4Gn9U8=;
        b=TiSYapsJyNvcCW3/7ksyHr/MEXi0omJNCN06O/4J/PMOdzE7fPWCIRHM6DF7dt9wjI
         j1Vrqm9IOvtlyskTeV1aiS/h3xdaanaKURYZ21jctoqtTFaCY48XpiYR+jx+M1Ur52js
         ovBDbCaLA+BT4bj90Q5x1eh5RFHJODvWM5DXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688082078; x=1690674078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXt+lksofF+9QajMg5KFkux1Y51FEVAStlJ8D4Gn9U8=;
        b=Sx42SkKtaHYbCTifL+FAWbXSnQ5QR2slBIOOaRDyOMLqY5pZ48mqTPPk0Q18Hg9qb/
         XVPY3PeZ2aH+LGfw0lXgZCa1RxtKCLi6pQwFN7uX6v5KJNwKfdId0HvQJFgndmneNQVB
         KsZDcobV8gP5BDGvNgBttTFLPyLyrNFIUE1IuDIho3TrpVbnSHIgdB5yqOwTfYEiFB6c
         UvonJw+nLvxPx72n0UO3hVXcr1OkQLs7Qu9hldCiA4kASaBnxmp866mqhPe1fRRuINHe
         Hmf9FBj0wGPRH0RgjRk/9QRECl+sbiYHA1K9GHFSgp7icNOyMi7i1FE28+nNjzGxSISH
         TAPQ==
X-Gm-Message-State: AC+VfDxM8zpG3D3E5BPZ2GDVpzAftftWOltiTdRiaY5Y0VaOkg2VyxW3
        b8yYKrK/JDyEdTOpLdUlid7sdWa326QM0IRgFobfBFS2
X-Google-Smtp-Source: ACHHUZ73xaIbvXSZ1sBEU1F+ertYWxUGyd1ZsVdjGwK8LpJs3W+WZaTzFPLvDnR2vBNUxZ0L1x0+5w==
X-Received: by 2002:a17:907:1623:b0:982:a022:a540 with SMTP id hb35-20020a170907162300b00982a022a540mr5581000ejc.11.1688082078238;
        Thu, 29 Jun 2023 16:41:18 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id bx1-20020a170906a1c100b00992665694f7sm2572725ejb.107.2023.06.29.16.41.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 16:41:16 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so2167949a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:41:16 -0700 (PDT)
X-Received: by 2002:aa7:d3cc:0:b0:51d:d19c:298a with SMTP id
 o12-20020aa7d3cc000000b0051dd19c298amr1601506edr.2.1688082076332; Thu, 29 Jun
 2023 16:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230627084058.GM52412@kernel.org>
In-Reply-To: <20230627084058.GM52412@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 16:40:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkp6Cp_vNaJ02KGWwR6aj2JA5rMcTo505cuN__gknYfQ@mail.gmail.com>
Message-ID: <CAHk-=wgkp6Cp_vNaJ02KGWwR6aj2JA5rMcTo505cuN__gknYfQ@mail.gmail.com>
Subject: Re: [GIT PULL] memblock: small updates for v6.5-rc1
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Claudio Migliorelli <claudio.migliorelli@mail.polimi.it>,
        Yuwei Guan <ssawgyw@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, 27 Jun 2023 at 01:41, Mike Rapoport <rppt@kernel.org> wrote:
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock memblock-v6.5-rc1

Nope, nothing there.

I see the for-next branch, but no tag with that name, and no other tag
with those contents.

Forgot to push?

               Linus
