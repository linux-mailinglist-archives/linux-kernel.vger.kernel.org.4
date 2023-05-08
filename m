Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFABB6FB3AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjEHPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjEHPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:23:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB872128
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 08:23:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30796c0cbcaso1096430f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683559397; x=1686151397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIqlbvBpKNHDcdBlMehVEfriFGPu86aKbtxQbd1EvP8=;
        b=Z2pjaqI5TeuW80dRPj7WDVOmeTxvEh65GHYS5YL8i5gpVEL/vjYQFvTGCjwE44TKdT
         elmk+FhRPzqAqFQqvWN/kcw+GURmAJ8tw5c2YuYogfqC2LWHSb9FmDXuEIci0oN82gk6
         GvQT71XZurkFhWh+Zx3APsMzOkgN0Lh/bsT9vUDZFbFVREcE3k+rllWBpx5IdopXH+ZY
         +Z9b4Bl8zKkj3VnfNYHSOEMclhREHBBJTQ6qTm/KN6MDRh3TbEtySg6AND6curNsQ78Y
         kbs6D+VS9iFjqeaIG5kAl4MNkKQv1MPtEIbrWkWC9WGyFR8Gbd5H5Uaq7fiIE7u6nLQw
         Uf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683559397; x=1686151397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIqlbvBpKNHDcdBlMehVEfriFGPu86aKbtxQbd1EvP8=;
        b=JuO2iUgWcDbdXadWT1OrPw9BOaGJl4IH/AVX53YDxfMU6P+PfP5lGERW31d5lLlbSn
         TBnHePqBvHuizxtJhEdOvOsebGF7SFu2oCfmDssNUiT4OC0DoaqG5AO6E8tdvqgfMf7L
         Shrf5fiE19FaUqDwM+/ozjrRp1/4BmK69d6f3tAbIWVt4wIuaQoUtZqHJP4OjWeFS3ok
         7aDjeu8Zvtt3oTfj6HiodJdwptW9pDlYgGgKWnXxU844POtDy5zAKWEBiriSmN1+4v3q
         Gm9Dc+yTA2w464n6JwGD36/dE1AmTP/XVF7DSqDAuCzU/+gAYWPnkXRVLFbo59Jv7CRZ
         C09A==
X-Gm-Message-State: AC+VfDyZ4k1XHwtUAta/E9/12JWhNdA+FvSzmsSXfFq7LDQVH4T5t5JZ
        tnerUbxbavHJiEevezzpYA6PESe8Xlg1GWwrfeI=
X-Google-Smtp-Source: ACHHUZ75D9K90XmdX0sBvwPuQdxjBVdmv+VWAEcRGjXj/SWygfADYv77PY4xM3LSROge4a4r1/nobBHmF785AXz+kjo=
X-Received: by 2002:adf:e70a:0:b0:2cf:f01f:ed89 with SMTP id
 c10-20020adfe70a000000b002cff01fed89mr7227713wrm.24.1683559397428; Mon, 08
 May 2023 08:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230117164041.1207412-1-arnd@kernel.org>
In-Reply-To: <20230117164041.1207412-1-arnd@kernel.org>
From:   Thierry Reding <thierry.reding@gmail.com>
Date:   Mon, 8 May 2023 17:23:06 +0200
Message-ID: <CA+PwDYdmSZE8ip3C7W_7CH4+74MzLf3nO-JTJu1xhQxRBauvVw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: fix enum type for gcc-13
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Richard Clark <richard.xnu.clark@gmail.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
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

On Tue, Jan 17, 2023 at 6:00=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> In gcc-13, the WORK_STRUCT_WQ_DATA_MASK constant is a signed 64-bit
> type on 32-bit architectures because the enum definition has both
> negative numbers and numbers above LONG_MAX in it:
>
> kernel/workqueue.c: In function 'get_work_pwq':
> kernel/workqueue.c:709:24: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>   709 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
>       |                        ^
> kernel/workqueue.c: In function 'get_work_pool':
> kernel/workqueue.c:737:25: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>   737 |                 return ((struct pool_workqueue *)
>       |                         ^
> kernel/workqueue.c: In function 'get_work_pool_id':
> kernel/workqueue.c:759:25: error: cast to pointer from integer of differe=
nt size [-Werror=3Dint-to-pointer-cast]
>   759 |                 return ((struct pool_workqueue *)
>       |                         ^
>
> Change the enum definition to ensure all values can fit into
> the range of 'unsigned long' on all architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/workqueue.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Thierry Reding <treding@nvidia.com>
