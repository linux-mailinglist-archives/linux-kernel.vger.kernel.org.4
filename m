Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF826E468D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDQLeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQLeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:34:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237226194
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:33:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f3df30043so78838666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681731108; x=1684323108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieoEoxp7XLLVVNoBiYFjdbyo8hhVk+4kFcZN0CICVfI=;
        b=iYHU5cSNEeyAZ7OW2hsOl5WJ9ov7622OqkRKSoGekjLuddJd5NYEwfixQQaKAg1Z/t
         EIrrOgyotVOccz8y3Iw+FokKX6UV8TTIHMAfuVG1EJfnPGbnqsGzyYsMEhMyj5N7qo/t
         GWQFe5oa/KkpyJdc9+K8snOGtcwZEog+rPYQe3fCniXlejAD81Vq0s5nAeuFISoG+oxM
         jgwmtnf7BUtf14SiMh+lgEp7RqYtZPr/533TFU7qCT+JjlSJ4uoy81ArCM4xfE7ljx3+
         JjBNLS4Q+/P/GNGuUvUPwuRvkKu+8ULPXi68oZQnvkypYNdOWFbw0JqT8+ZB/ap3mjOt
         OQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681731108; x=1684323108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieoEoxp7XLLVVNoBiYFjdbyo8hhVk+4kFcZN0CICVfI=;
        b=TPnjySO8wnP2QFMadkCaKXB0gNVXTp9uMxsP+bDoZJwsDJl1Zv/DcQYl9QdqYP3aW2
         U8m+mBl8OB2bjYMcQYL5Oy2ab0EUfM7XNTP8nfV74Zz92WaL8cyBvY4uLXPV1SikzIAZ
         KQoGnED7qE7CLUx7wEyw2I+lYxCeY3PS3PPoXOwA0ldfB8ZaTaagvGGmZGLnznj5uuwq
         zycXaMerci8NTExy/xLJ/YtD9C3mqoSMFx7nPIm7ynbcHYMcTwwLiYvpOUnINzsBvdhb
         VQYl7+puOCRb9k4NaJ9xsYdk0ABjtkLFFaPdQUE/uQyvvAQobZ+oD0RT9ZyEwMWnPsm9
         LnKw==
X-Gm-Message-State: AAQBX9fM95QeWsn+lG0UES+EyldQ/+dPaXD1+kC35kkO8Qa3ikSua87T
        tNSfl/Py23Xa1y0pqqpNQ5tuiX0vu4J2TKJqxBuEQA==
X-Google-Smtp-Source: AKy350Z/hHQBTDPi94s7L/XNHFBEyJlzB/3Ucu8fJ/nuTEGRgzKgcnjy+O6n2q8+YZmNzWhTUfgRi/DzU0F82RnbQBY=
X-Received: by 2002:a50:9b0e:0:b0:504:7684:a23c with SMTP id
 o14-20020a509b0e000000b005047684a23cmr7128147edi.8.1681731107621; Mon, 17 Apr
 2023 04:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
 <20230416151853.GK25053@google.com> <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
 <20230417024446.GL25053@google.com> <CAOUHufYJtB0n314GnMH1ByXL5PTtzzsrMvi2YbHz2YVqTTcYfA@mail.gmail.com>
 <20230417035232.GM25053@google.com> <CAJD7tkZFufCacfu-EeqwhQBYXt8dpea1DYhyDgponjFjdLt5Sw@mail.gmail.com>
 <20230417111243.GN25053@google.com> <CAJD7tkah9kx2kAcTY47J2R5p7NYS+b+3A9S_R-hSv9z8OSzzqA@mail.gmail.com>
 <20230417112421.GO25053@google.com>
In-Reply-To: <20230417112421.GO25053@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Apr 2023 04:31:11 -0700
Message-ID: <CAJD7tkbC5drsA2s+=sxXGGm+2RAFXbqs_21KrGaWav_LKjA68w@mail.gmail.com>
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction algorithm
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 4:24=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/17 04:16), Yosry Ahmed wrote:
> > > That's a good question to which I don't have an answer. We can list_a=
dd()
> > > the same zspage twice, unlocking the pool after first list_add() so t=
hat
> > > another process (including another zs_compact()) can do something to =
that
> > > zspage. The answer is somewhere between these lines, I guess.
> >
> > But the first list_add() is (in this case) the correct add, so we
> > expect other processes to be able to access the zspage after the first
> > list_add() anyway, right?
>
> Correct. Compaction also can unlock pool->lock and schedule() so that
> another process can access the source zspage, when compaction gets
> scheduled it can attempt putback/unlock the same zspage one more time
> (the zspage may not even exist at this point, I assume).

Good point, that could very well be where the corruption is coming
from. Thanks for pointing this out.
