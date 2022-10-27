Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2960F6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiJ0MFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiJ0MFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:05:14 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADAD6A52C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:05:06 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-36847dfc5ccso12069817b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qknsrrbVYmn1Ib/QmtnzvnQ1FotFocWgYawUVExSORc=;
        b=kDAj/+QzV+GnIAl89MVn+6bsaO43262/lst84N6GLEppFSvsHBzOeLghyWNKT1KPEl
         eIhI29hvYay1zSC0ExaoOhUO/yRQYAmiEsjcBgRnvtNaM/NvtooZnOBlnqKhdxekYlSQ
         HEihk43r1nvzJJYf6ZEIDPnHV1mowWHSawP1nH/06wxkhXJH3Z1CSnkKnCuslWa8oPp5
         DgsvOnhRSy8rueiyaIGJM5onQDSvUUVyqN/2zXDns18EyQH6K9oFKwOD3n7/lbZkViSB
         hEFnXgkpGgip7CELstT93J478R+tnrrF/GVz3ZfosMdcmtOtuL9U89r31fdECOg4+Q9O
         Bqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qknsrrbVYmn1Ib/QmtnzvnQ1FotFocWgYawUVExSORc=;
        b=cgsXdtUG2QFI2mHko4u+GO4IYFGBzq05DiYvlXD1mUuJ1D5hV9guSnRkkqa7uhEjSH
         JmQXAYcmBtyQfUK9dq9EDgjsqipsruuP6gL1NmQOaSPAZNVdRzWvyV4aY178XJWXvTvC
         n1l1JASc1u4vgH/IuM1cnOXmXL4PYGQ9zQrGZuXk9/siOAAY17TaH6zqSLgJyCpI7k+2
         hRG69POxjmDXUCPXVTMsziVyJ5m1B0n7IPoupkb3kvHfJuFvNUK5MII0Vs3NFhTOmiC7
         fQIuayVqcxtiAGYYeNCLXfMnLFa68qxtdNZKSvOP9698gVj+yXVqocirpr01dr8pCygN
         b2Lg==
X-Gm-Message-State: ACrzQf36foCA+Zz6/XTv8H4Th5Ei6kgJpQKMblSIHLKKlohCINfNlEvH
        EDPlK7NIHX8jAPTIpuQ/mfeQ6fvgTOweYFpOGaINfQ==
X-Google-Smtp-Source: AMsMyM6I8YFZk6yU1HJa7CB4BQnoTdN1q32V2q3kIL4ut/vRUT+zzspyg2RYAuACG1yriwxZ9GpsUaLYvk1FNk4qgPc=
X-Received: by 2002:a81:7585:0:b0:368:28bd:9932 with SMTP id
 q127-20020a817585000000b0036828bd9932mr35457213ywc.332.1666872305338; Thu, 27
 Oct 2022 05:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221026151558.4165020-1-luwei32@huawei.com> <CANn89iJQn5ET3U9cYeiT0ijTkab2tRDBB1YP3Y6oELVq0dj6Zw@mail.gmail.com>
 <CANn89iLcnPAzLZFiCazM_y==33+Zhg=3bGY70ev=5YwDoZw-Vg@mail.gmail.com>
 <fd9abfe4-962e-ceef-5ab8-29e654303343@virtuozzo.com> <CA+XRDbMma1e26HHoYm2pExANACH8n83bE7vB_Gwh3-RZUsOe2g@mail.gmail.com>
 <8083c822-1493-3596-d292-520fb16b113f@huawei.com>
In-Reply-To: <8083c822-1493-3596-d292-520fb16b113f@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Oct 2022 05:04:54 -0700
Message-ID: <CANn89iJ1JVG_H-FAQRg3JdPtNkq2T++K9Xc-mLo_VaUdcp38KA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reset tp->sacked_out when sack is enabled
To:     "luwei (O)" <luwei32@huawei.com>
Cc:     Pavel Emelyanov <ovzxemul@gmail.com>,
        "Denis V. Lunev" <den@virtuozzo.com>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, avagin@gmail.com,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 5:00 AM luwei (O) <luwei32@huawei.com> wrote:
>

>
> thanks, I will send next version

Yeah, what about first agreeing on what the plans are ?

In order to avoid confusion and lkml/netdev bloat, I think you should
describe why existing checks are not enough.

Since this was probably caught by a fuzzer like syzbot, do you have a repro ?
