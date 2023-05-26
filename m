Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7317B712938
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbjEZPR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjEZPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:17:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F0FE7;
        Fri, 26 May 2023 08:17:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b01d912a76so2385555ad.2;
        Fri, 26 May 2023 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685114244; x=1687706244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GJ4FjJZGUQbYlU7p9/KEUG/m0QvCQkcEQflz9e85BA=;
        b=CBgDZBqozcfyIyps28kmp0tj2C2TBFEzz/wl0GdZHCplwflIh9DQDhJanR31wSI9dL
         2VTGrYdQJF/H9wrwirX32S3yryzWdyP9E+ujLt5fY4tEkkz4wi0d4LwzCORTQEhS3dcV
         FX2R57vttneDFQnmmo+cC6ZE197WCfkVEAF7lKB0CpQ/kKsQ+unNQY/HLZzfQWJivj34
         b1b9IWG4UOZERU0maKmtvz/3sYpjpmv+wyuT/JD8ApS54vqhcXwo8EZZygeripSnTw5X
         /SuF8GjB52AQATHdbaT7T5NlrIQ/A/kfLZWnT5N1fI6LNLqb89Pso4hWqG+zZjZl0noB
         AhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685114244; x=1687706244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GJ4FjJZGUQbYlU7p9/KEUG/m0QvCQkcEQflz9e85BA=;
        b=FLJnNSTcfE6xj1SskXRLV9AYfbUJoEjSep0qEIK2/v1/NCFmRf8SGlffo49hTeVu5x
         I0S1MjJIMd+PL42zWbXeFvpOo2vbiYm9JXiLtG8VywVBVyo50x+mrfc3VbP5qHCabwzQ
         5rgbUvcBeWGa3JmPGnI3ybeVV7TWA/0q3d26nwA+My05jtHrGpzTI7qqvKVCKQp2okQj
         39P87Rz6aPrVfDTVg1YGupXwZcBwEYOuwqSxa1ihnb6Pv+qf2+IUL8BBhhask8QOi7jY
         ZkSN2eIFR5J2+pODVaCWbuOjL6o4ypuCQtvmIfzQ55ioyD172eXpoqONjd3bzqif87Px
         ZkVQ==
X-Gm-Message-State: AC+VfDywmUTDcfahvfl1XFVrpaDPqLNGZFWwxyu1+8U06gpMUsmpA2WL
        H4kgglKbris79JirPcJJWuzVENxR6XuIbk5E2P0=
X-Google-Smtp-Source: ACHHUZ5FzgC88D1Oh16c7LccZZVN62tx6rIDc1X+XgPlLJEE9EwrkqdPzTLTYjzxzxquoK/j8Tp7x9qee/KxhJRhkGQ=
X-Received: by 2002:a17:903:456:b0:1ac:3ddf:2299 with SMTP id
 iw22-20020a170903045600b001ac3ddf2299mr2524049plb.44.1685114243731; Fri, 26
 May 2023 08:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230526092616.40355-1-linyunsheng@huawei.com> <20230526092616.40355-3-linyunsheng@huawei.com>
In-Reply-To: <20230526092616.40355-3-linyunsheng@huawei.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 26 May 2023 08:16:47 -0700
Message-ID: <CAKgT0UfuNqY240nfhBoZfYoL5uZ5hSqPOafKY1=4kz6v0MsWxw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] page_pool: support non-frag page for page_pool_alloc_frag()
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
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

On Fri, May 26, 2023 at 2:28=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> There is performance penalty with using page frag support when
> user requests a larger frag size and a page only supports one
> frag user, see [1].
>
> It seems like user may request different frag size depending
> on the mtu and packet size, provide an option to allocate
> non-frag page when a whole page is not able to hold two frags,
> so that user has a unified interface for the memory allocation
> with least memory utilization and performance penalty.
>
> 1. https://lore.kernel.org/netdev/ZEU+vospFdm08IeE@localhost.localdomain/
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Alexander Duyck <alexander.duyck@gmail.com>

The way I see it there are several problems with this approach.

First, why not just increase the page order rather than trying to
essentially make page_pool_alloc_frag into an analog for
page_pool_alloc_pages? I know for the skb allocator we are working
with an order 3 page. You could likely do something similar here to
achieve the better performance you are looking for.

Second, I am not a fan of these changes as they seem to be wasteful
for drivers that might make use of a mix of large and small
allocations. If we aren't going to use fragments then we should
probably just wrap the call to this function in an inline wrapper that
checks the size and just automatically pulls the larger sizes off into
the non-frag allocation path. Look at something such as
__netdev_alloc_skb as an example.
