Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F56EC180
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 19:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjDWRyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjDWRyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 13:54:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C3B10DC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 10:54:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94ef0a8546fso532436866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1682272489; x=1684864489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajc3OSoJBNJY54dtxIfH8gJgclQJ17/OnLquSrnGNHs=;
        b=aKnhENXaISvHLpuTquFn+OXkK6mk2sADL9n5xWaVwf0ERvQfoHbHWf+uuh1C+dkzIo
         6KWXVLtM/gVrF7GJzzN2vWQIsHiabNol6X/jR3q5glkK0ch2hRAea76cpiHNQ8EaeQkT
         if8h/4is2R3zcGDJ3I37WLoqn8+qPOMu8zLkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682272489; x=1684864489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ajc3OSoJBNJY54dtxIfH8gJgclQJ17/OnLquSrnGNHs=;
        b=fL6OubsJ+/Tc3E+ORFA2UDOhWA5IEFSbTkJ/M2c23GGWUaDE6TE6c9OnTebhTcn7+A
         8OfDPgz7ER5sXgJj1sD1GllNftABpLPfG6883WSU1ht9LLGq5Jgvijxu9jxekTEjFT38
         P1jUuc6EZ94GQTsH2kNwMUtvU62bSq3tjKimh1+gX+zlQcp6YRv620MLCWLfjrtEDOO7
         H6N/nBhTJWe6741tTHNA7NL7tDN+cD2ZlvPJodHgJksG67harfViSA2lqX0rlJpodCaD
         1FnWi9XcuvlGutLRfiQIck4oCAgXz7MLwVySnGgOQzyA4FhvsaUo+/MVuMubIv5nCdXq
         cPkg==
X-Gm-Message-State: AAQBX9eGOd4b4sEsuzrQHfboWWr9GNbMIk4zJvsRxQVbvmnz8VY77lJn
        vO9yXvBc6HOu+WwoPumo/6+uwlfxnpmfRqGZvAy+sw==
X-Google-Smtp-Source: AKy350apjWESRQzvKjFeX4OMuu62saFs+BoarRrJkYJDQ7dRJK3pY+dDKEoG0AHSGUmIE6E65Bq6Jofvwgq/cVB2Wms=
X-Received: by 2002:a17:906:7a16:b0:94e:f738:514f with SMTP id
 d22-20020a1709067a1600b0094ef738514fmr8673988ejo.13.1682272489621; Sun, 23
 Apr 2023 10:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230423075335.92597-1-kal.conley@dectris.com>
In-Reply-To: <20230423075335.92597-1-kal.conley@dectris.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Sun, 23 Apr 2023 19:54:38 +0200
Message-ID: <CAHApi-k1myxp5wqh4ojLKmVQyY=UG8hNT4Vk5c1V22Ua_i2kvA@mail.gmail.com>
Subject: Re: [PATCH] xsk: Use pool->dma_pages to check for DMA
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Compare pool->dma_pages instead of pool->dma_pages_cnt to check for an
> active DMA mapping. pool->dma_pages needs to be read anyway to access
> the map so this compiles to more efficient code.
>
> Signed-off-by: Kal Conley <kal.conley@dectris.com>
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

I forgot to specify the target tree. This patch should be applied to bpf-next.
