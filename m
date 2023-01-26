Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C8467C89C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjAZKdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAZKdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:33:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009D4EF9A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:33:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so3881446ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQjhGV/0aVWp2IZyvXT7wShj6bHZ7j1JsBRSr8P5b6s=;
        b=Tje+9PlWypsBHlBiHN8XTEPgX9fXO44cRzZMoUSzwve/dwHr6Si7U85prQvY0nP7gV
         9UWi0pIlUcoBkq/IlMymOf47A2mhDs7fEkGDgkdwRBOEiijvaQOFzxuS2Ou1/jsb29Xx
         vCN4pu8bJ1efBE/1PhcNTfJNHBkpi1cmqmRI5ccrrwlVmSYeLkd/AVUgWecPbCRq48gH
         VSubpMHwM1imurxLh9KfADoDLUnFwy1m74pUkmNI8fNimmNGZrgwe1jE1oXlNHkTz0Da
         xOuxyr52t93Sl/Jer3NchxnJDZthD9BIYmLuefNGLr0FdetydwP8EstY8bS6RjJjdqAS
         WZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQjhGV/0aVWp2IZyvXT7wShj6bHZ7j1JsBRSr8P5b6s=;
        b=MJXBr8kF5/aRHbeLodUsR8wgCXk2NAZ+DxMKssRbna2cOM/nv6MUkAHhg1lO6BHEg8
         Y8XlCSbAzo+YQ21KffYqufhj6Q+wCii1TmMsyD9ViXZx799MCJDHvRnH8/IC9XcPMS5D
         GdrI1HENswg0eS1tSaJ9NQHrDnLpcMMplG7MvZfrxL+7MjmZoWNRQecIO6UBerKufgV8
         Ta0RFQ1pDvBRBzoEzy1DmU9IflMxHKmLOvY7w6bcHFe1Ld/LxXgmg6XGOLhu3R8ksuAP
         0hGSEu3qnA4qLccKM+ezoiA4Sy4zciwss86tx5jGkm/nUyNZNi3qgF8BEvG22s4K4ZMM
         ZBKg==
X-Gm-Message-State: AFqh2kpYYlsa/onLGFOjhS6GPGaUzlbu67y7aW2QJDJvNP3LjABOzDZA
        gd+eSOmPdBUEFrS3SfzAaGQUlQ==
X-Google-Smtp-Source: AMrXdXvZL5wQse5aV2+qjk/2Gu5Ow2cFhkFqYOBdC4RLS/fRJLSc7ZRibdx9umdw6uiu1yx7c6Ztlg==
X-Received: by 2002:a17:907:75f5:b0:7c4:f501:e5b1 with SMTP id jz21-20020a17090775f500b007c4f501e5b1mr37370152ejc.51.1674729180506;
        Thu, 26 Jan 2023 02:33:00 -0800 (PST)
Received: from hera (ppp079167090036.access.hol.gr. [79.167.90.36])
        by smtp.gmail.com with ESMTPSA id z7-20020a05640240c700b0046c4553010fsm552806edb.1.2023.01.26.02.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:32:59 -0800 (PST)
Date:   Thu, 26 Jan 2023 12:32:57 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH] net: page_pool: fix refcounting issues with fragmented
 allocation
Message-ID: <Y9JW2Yzia5tafiTw@hera>
References: <20230124124300.94886-1-nbd@nbd.name>
 <CAC_iWjKAEgUB8Z3WNNVgUK8omXD+nwt_VPSVyFn1i4EQzJadog@mail.gmail.com>
 <19121deb-368f-9786-8700-f1c45d227a4c@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19121deb-368f-9786-8700-f1c45d227a4c@nbd.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 06:22:54PM +0100, Felix Fietkau wrote:
> On 24.01.23 15:11, Ilias Apalodimas wrote:
> > Hi Felix,
> >
> > ++cc Alexander and Yunsheng.
> >
> > Thanks for the report
> >
> > On Tue, 24 Jan 2023 at 14:43, Felix Fietkau <nbd@nbd.name> wrote:
> > >
> > > While testing fragmented page_pool allocation in the mt76 driver, I was able
> > > to reliably trigger page refcount underflow issues, which did not occur with
> > > full-page page_pool allocation.
> > > It appears to me, that handling refcounting in two separate counters
> > > (page->pp_frag_count and page refcount) is racy when page refcount gets
> > > incremented by code dealing with skb fragments directly, and
> > > page_pool_return_skb_page is called multiple times for the same fragment.
> > >
> > > Dropping page->pp_frag_count and relying entirely on the page refcount makes
> > > these underflow issues and crashes go away.
> > >
> >
> > This has been discussed here [1].  TL;DR changing this to page
> > refcount might blow up in other colorful ways.  Can we look closer and
> > figure out why the underflow happens?
> I don't see how the approch taken in my patch would blow up. From what I can
> tell, it should be fairly close to how refcount is handled in
> page_frag_alloc. The main improvement it adds is to prevent it from blowing
> up if pool-allocated fragments get shared across multiple skbs with
> corresponding get_page and page_pool_return_skb_page calls.
>
> - Felix
>

Yes sorry for the noise, that patch I referred to was doing a completely
different thing, elevating the page refcnt to BIAS_MAX from the start

Thanks
/Ilias
