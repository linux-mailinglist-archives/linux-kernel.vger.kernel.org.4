Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE126F10D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 05:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345099AbjD1DZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 23:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjD1DZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:25:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B2211E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:25:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f6c285d92so1781615366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682652311; x=1685244311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtcfavXCgC97sXeM2tBhYDMeAO+0wKfV/28poedCpKI=;
        b=eGvbuwPngN5eh8s2qx04NIVRYGePJ2BrMcx8RZMZyG30Qana2OUuckQhxzKhr3UTSO
         5LoxVeOCIQLPiEyqi84VGNaqjaYIa3ciHotnSHjOSeQkCLRX78rq0onFe7Gx0kyiVwDc
         V/wscIV+WgGwx0NlyGNLfpg39xBgAIMR3eXjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682652311; x=1685244311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtcfavXCgC97sXeM2tBhYDMeAO+0wKfV/28poedCpKI=;
        b=L/LNaLPTJNxRGOUQXG5317+9My+tVVnDqkEQug7TIZxYdSgOUay1OsRwG3Te0Q3Hia
         GeFbZqyPn3WOWxtvlmXzpqicg2qU0HnP0SmSy7+Sjm+j3LuvU73a9pgp482X68+6QAPB
         BDzOp2AdKiDJOqYB4fmsuhbS+9poid4pWxC34Gh4afG8fiB9UMgsWweuMpRAfFh8o2wf
         zMYffIbmm6Nnf4kW++uM4pC37y7AoKuCT0BMGAT0N8+LYR/ncwA4ueVbOxHJilqZ2k1U
         m8Nrm1/QtH5WKkmhhgk3LIF1WHfGpDGsmmuaSIN6gqO/c+4fnrz82njCmqSq62fEwW7H
         AceA==
X-Gm-Message-State: AC+VfDwFENB8K/BSU/7LjKyBFjZOovVNbaIRo0znSD4hdRsVpA4se/7v
        r7XFBTRs7cRCYTyNiztV75S8CxHyLLQ8j0Q0wRIJOw==
X-Google-Smtp-Source: ACHHUZ7POC6cTJ0+RBcfWbDdYOnQ3tE/71huhAmm2Ur5zg8KA1Km45vK6LFOeSSfioXld7gCldwlSA==
X-Received: by 2002:a17:906:dc95:b0:94f:ca5:1a66 with SMTP id cs21-20020a170906dc9500b0094f0ca51a66mr4780935ejc.59.1682652311346;
        Thu, 27 Apr 2023 20:25:11 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906348d00b0095337c5da35sm10655981ejb.15.2023.04.27.20.25.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 20:25:10 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94f6c285d92so1781611366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:25:10 -0700 (PDT)
X-Received: by 2002:a17:907:2d8f:b0:957:278c:fb27 with SMTP id
 gt15-20020a1709072d8f00b00957278cfb27mr4205144ejc.21.1682652309848; Thu, 27
 Apr 2023 20:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org> <CAHk-=wjaYXeWKsyifQCS=gJf4mxav-b6cdf5boKpMO6M1C-2LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjaYXeWKsyifQCS=gJf4mxav-b6cdf5boKpMO6M1C-2LQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 20:24:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicaWSn3JLwpexH=gu1HoHWpecyWoLYBwD3qPd0-t9aJA@mail.gmail.com>
Message-ID: <CAHk-=wicaWSn3JLwpexH=gu1HoHWpecyWoLYBwD3qPd0-t9aJA@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
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

On Thu, Apr 27, 2023 at 8:15=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Most of the bulk of the conflicts were around __filemap_get_folio()
> now returning an ERR_PTR, particularly then with Willy doing the ext4
> folio conversion.
>
> So Christoph, Willy, mind just double-checking me?

Just to clarify: I do take a look at linux-next, but I do it as an
after-the-fact "let's double-check my resolution", and some of my
resolutions don't end up being identical because I end up doing things
differently.

For example, I found the linux-next resolution in
ext4_read_merkle_tree_page() to be nonsensical. I think it probably
generates the same code as my resolution, but doing "&folio->page" on
an ERR_PTR folio is some funky funky sh*t.

Only after looking at the linux-next resolution did I grep around and
notice that that kind of funky struff had already made it into
mainline in non-conflicting places. Willy - it seems to be you
spreading that crazy pattern. Please stop.

Anyway.

I did some things differently, and while I think my resolution is the
right one, the fact that it is different could also just mean that I'm
confused.

                   Linus
