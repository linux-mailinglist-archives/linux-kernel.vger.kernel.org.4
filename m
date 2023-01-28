Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F0F67F56A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjA1HQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjA1HQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:16:03 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90EB4A1F4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:16:02 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4fd37a1551cso95182187b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kZmZuT84cAULJ/LY40DGBxYFR04P706QHnRE/xzs2H8=;
        b=Qr6CoftSYRBDdaBYNF27PMg7qt18/TkVDIGpVWi5/eQUgfi5NgiAgtfnxj+rQ4RcSB
         5mVysS14tJ+rUYz+iutP+Bl2lsFKs8Yq/YheQ0REvM2BRSPwYzJ68bSy49k1zg0O5xYX
         xtzv1mfFJ7sE+bjUZwSMgkULPL1dHVxpoZhmaswKKGpOnvWswqiTLZz/DNTmI+HSZ2xo
         rPFLBKx4wHBEGrbP1z7u54EWK3afAKs7PSxumrQR8lHoq6XZC+ukbkWrKQzQY7Jm76Q5
         GYDlWjRTQaZALr1mcu2Gw6FaIBlBank9/RefW6H8XMy7OjjOwUwgGeZQAzsF41zeWjB9
         HyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZmZuT84cAULJ/LY40DGBxYFR04P706QHnRE/xzs2H8=;
        b=mrEqYBld6U5wybBGcn2nCQN1ImyFAGK1GFFeqSLrkUCf8SmUsEwgNpTHUANXLQYG3Y
         7vlkhppbIKM25sLUCV9oz6QPQtBOsPuOOO20CLokvHIjGQAhpnOCweskeBNI3NE66jlY
         Un8UbGAexBGeKMX3S1DIYsdEb4fZ1qZOeMNIgg0aP/puCWRCjK9MmfTKujVABnV87602
         jAwIfhIId81A5WwHFzLDdkgnIJyhmsMNAJgG5kkF3aONZPABqMuej46rzawfyv8k8XIX
         F14P8xMzj8COJv0k5aDmIGq5f7sJdvXbQniw6/xgmV/VvM2pjPAtcoHpzmlFq5FPzBPk
         kN+w==
X-Gm-Message-State: AO0yUKUyNR8xOYmilp7VWY2n3xT2kqRmg6zwnSuN9zEmzfycVCSgV9Ox
        ngSDnoszRe1K9FacShaVuXkupgRKC3XD3y6eM0Z0gw==
X-Google-Smtp-Source: AK7set9QzkXyPWFxKmXXH18EUv90h+vPUMHxWM4QMabwdPEWq73FHUWvPoohxRDbaTKKduR4eAU2yZtt171lDSWDKpo=
X-Received: by 2002:a81:5757:0:b0:50e:d390:d554 with SMTP id
 l84-20020a815757000000b0050ed390d554mr246646ywb.55.1674890161656; Fri, 27 Jan
 2023 23:16:01 -0800 (PST)
MIME-Version: 1.0
References: <04e27096-9ace-07eb-aa51-1663714a586d@nbd.name>
 <167475990764.1934330.11960904198087757911.stgit@localhost.localdomain>
 <cde24ed8-1852-ce93-69f3-ff378731f52c@huawei.com> <20230127212646.4cfeb475@kernel.org>
In-Reply-To: <20230127212646.4cfeb475@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 28 Jan 2023 08:15:50 +0100
Message-ID: <CANn89iL1x=Wis4xDRF=SJ-8_7FebY9y7hvG71gsvUPGXf6xwHA@mail.gmail.com>
Subject: Re: [net PATCH] skb: Do mix page pool and page referenced frags in GRO
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexander.duyck@gmail.com>, nbd@nbd.name,
        davem@davemloft.net, hawk@kernel.org, ilias.apalodimas@linaro.org,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 6:26 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 28 Jan 2023 10:37:47 +0800 Yunsheng Lin wrote:
> > If we are not allowing gro for the above case, setting NAPI_GRO_CB(p)->flush
> > to 1 in gro_list_prepare() seems to be making more sense so that the above
> > case has the same handling as skb_has_frag_list() handling?
> > https://elixir.bootlin.com/linux/v6.2-rc4/source/net/core/gro.c#L503
> >
> > As it seems to avoid some unnecessary operation according to comment
> > in tcp4_gro_receive():
> > https://elixir.bootlin.com/linux/v6.2-rc4/source/net/ipv4/tcp_offload.c#L322
>
> The frag_list case can be determined with just the input skb.
> For pp_recycle we need to compare input skb's pp_recycle with
> the pp_recycle of the skb already held by GRO.
>
> I'll hold off with applying a bit longer tho, in case Eric
> wants to chime in with an ack or opinion.

Doing the test only if the final step (once all headers have been
verified) seems less costly
for the vast majority of the cases the driver cooks skbs with a
consistent pp_recycle bit ?

So Alex patch seems less expensive to me than adding the check very early.
