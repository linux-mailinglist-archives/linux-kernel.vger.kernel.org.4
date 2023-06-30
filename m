Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C51743E53
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjF3PLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF3PLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:11:41 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A69EE5E;
        Fri, 30 Jun 2023 08:11:40 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-341cb9528f5so8429005ab.1;
        Fri, 30 Jun 2023 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688137900; x=1690729900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJ6dAaTmXC8YvTGPcO1hUCIEXunyHjIMen2eUlluveE=;
        b=hT6ZzhGq8qtqn3PTryDBxi/iXTrK8wgzKBz2hLhguFWqQcZ/nt0qpknHTQT8ovUdyN
         /NPTeCds5QGtnoZJw1srTMAjcnlCcFr5yy3o9AT0BQfsU2gqlV/4ouUchiOH37N6QOTc
         5viTLxaULslF+jDSHGlyTKCd0dbnqv+PObcuU7snn+4qkXkOnvYIMLLEqLS7cW20E8p7
         CA0z7zFz+0rgWBHw0GZm4ujC2vqZUpgkgS8PE/FqHeyneLMhF0k5E9hqFyFTTymCqE3r
         HjmkrW5bMBjlDp7vdxFmSETdSdicVCsnJx7KJRVsLrVUp0vHUvR5ZctKHX1d2R8XUYsT
         oqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688137900; x=1690729900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJ6dAaTmXC8YvTGPcO1hUCIEXunyHjIMen2eUlluveE=;
        b=TX+RmgDX1LhJVnD1ePY9y1qp1i9LWCTF7QRmiDYD/AZx0ys3iGzgW5bKKqVWaRChX/
         PRM1CMYKowdGgpzYtxDXfYF8gM2mJqJtA32bOXuckusr/2luMvBHH8IlZNjeWSL7R8R5
         5tIED6wUXnVf5T9bacfHnLwaqAtYtIaPCdEyRV47QBXIGiQBq/y68bftOcfwdd4F34pZ
         +Pci2pmFQCisx8tALR6gItRCCpdGcN/IUyONdNMmHsOLfgey8ZHk3VwOmFyZpB73yvgZ
         c+fHCW6oCPyJwvcaQSaLU0ZrVg2DshBSfxXQjrGtN72tvFy/G4jiYNV9S1WXPwV0ClOB
         o2kQ==
X-Gm-Message-State: ABy/qLb099sdc8RPfXkHkmwjUPJyRZRVIf/XJ7aLZ+roQL8RxHZVddi6
        pyEFEx8t7bXll9F/qr344cCYrTnIcDmW1FULnQg=
X-Google-Smtp-Source: APBJJlGwBj6808SDKSQi/DAsOCX/PCBWPzmUEjX/FjIJa7wnuj9IB1imf7kor/WPadmIDVkbaFFLk9tJLQnqgyyts2E=
X-Received: by 2002:a92:c70b:0:b0:345:cf3f:2fd with SMTP id
 a11-20020a92c70b000000b00345cf3f02fdmr2486298ilp.13.1688137899763; Fri, 30
 Jun 2023 08:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
 <20230629152305.905962-2-aleksander.lobakin@intel.com> <b7dda3fe88bb3d302b1cbb2016387d5e98e2f946.camel@gmail.com>
 <6d79614b-1258-08be-1bd8-cb02ffd9dc6e@intel.com>
In-Reply-To: <6d79614b-1258-08be-1bd8-cb02ffd9dc6e@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 30 Jun 2023 08:11:02 -0700
Message-ID: <CAKgT0UcDZ50FCk7bbvbQ5=6kLuXx8EG9mWcy18iLfuik2yb1cg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 1/4] net: skbuff: don't include
 <net/page_pool.h> to <linux/skbuff.h>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 5:39=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander H Duyck <alexander.duyck@gmail.com>
> Date: Thu, 29 Jun 2023 09:55:15 -0700
>
> > On Thu, 2023-06-29 at 17:23 +0200, Alexander Lobakin wrote:
> >> Currently, touching <net/page_pool.h> triggers a rebuild of more than
> >> a half of the kernel. That's because it's included in <linux/skbuff.h>=
.
> >> And each new include to page_pool.h adds more [useless] data for the
> >> toolchain to process per each source file from that pile.
>
> [...]
>
> >> +bool page_pool_return_skb_page(struct page *page, bool napi_safe)
> >> +{
> >> +    struct napi_struct *napi;
> >> +    struct page_pool *pp;
> >> +    bool allow_direct;
> >> +
> >> +    page =3D compound_head(page);
> >> +    pp =3D page->pp;
> >
> > So this is just assuming that any page we pass thru is a page pool
> > page. The problem is there may be some other pointer stored here that
> > could cause issues.
>
> But that is exactly what you suggested in the previous revision's
> thread... Hey! :D
>
> "I suspect we could look at pulling parts of it out as well. The
> pp_magic check should always be succeeding unless we have pages getting
> routed the wrong way somewhere. So maybe we should look at pulling it
> out and moving it to another part of the path such as
> __page_pool_put_page() and making it a bit more visible to catch those
> cases".

Yeah, I have had a few off days recently, amazing what happens when
you are running on only a few hours of sleep.. :-/

Anyway, as I was saying it might make sense to wrap the whole thing up
as a page pool accessor that would return NULL if the MAGIC value
isn't present. Alternatively one other possibility would be to look at
creating an inline function here that could check to see if the
skb_frag is page pool and then just keep that in sk_buff.h since it
looks like it should only need to rely on the page struct and
PP_SIGNATURE which is a poison.h value. With that napi_frag_unref
could avoid an unnecessary trip into the page_pool_return_skb_page
function entirely if it isn't a page pool page and we could look at
dropping the return value from page_pool_return_skb_page entirely.

> Anyway, since some drivers still mix PP pages with non-PP ones (mt76
> IIRC, maybe more), I feel the check for magic is still relevant. I just
> believed you and forgot about that T.T

Yeah, sorry about that, my bad. I was a bit too focused on the main
drivers we use and not thinking outside the box enough.
