Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE6F72C632
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjFLNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbjFLNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:40:35 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEA91A1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:40:31 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-56d07c7cf03so19362997b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686577230; x=1689169230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HCfCynw9maP7T2H3b6SF9iHZLNkIpnhfq4BKVNG+mcU=;
        b=bB2klCXowkeQCD7ydffQk/ZCdLueoAPlGFLh0UW/eDaaGUo7U54xEAZK4yPHjSgTHy
         fQkASPKV8JqwsUTj6YeP7WD+QD5RYptoHZfjRgBGF3LApYvU4ykIQDJ5OIuCCtOCHMq5
         6mz41hc1YGWNG/Yp3Qi99kNgEEwNLMiaQ/+Kepo/WYlRYGPcGzff+/PakBWtRxZy+F8m
         ra5bKyJgpECKcwrxAJUl0AgN6ykHIc16bgYc4J0eF7HyMRg2OavrwALZP/ggHW82C6yF
         HAr/QxjILfjcgqa750YIgyva/6iRVSX/Wxc5Uqoehb9ACtZpPUtrIWSJNbMwA5Soym3l
         lJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686577230; x=1689169230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCfCynw9maP7T2H3b6SF9iHZLNkIpnhfq4BKVNG+mcU=;
        b=hPs4NuGxsd2+MWleBUI2r1fLt6ZMC5OJRm7NmmF8sxwhSUb0iq/v0BMJe+GM2oMcDM
         pqYlOlzT3vIT6Cq8PHWVxy2URSrxUQjmuTi+1okGOOPcLV/pdZF2qTO6nLEt41tZR1Bs
         2/OG+JVJV7XjYhySM/sKTu6XCpNJ36sVdNvLIE1kXiFkVOW9F14f50BpScgTo8vDrX2m
         Sla9aTYICh7llc11bFvJHnEF8o52pStl//oqWukkYwoUFLztgwQNox/JPr4N8Z7bYcSH
         Mh0giyTk65BFLK5FhV4c5NqZaMenDJfcVzapG4Fmq92p7dkDT7XFBf3JdORx3GaYrxUT
         6FWg==
X-Gm-Message-State: AC+VfDyoqbJQjBDI0EKByuRUz5gZFsRfK4idV8jBxsQ637WsUC3rEWD0
        52vRrmt/eOBFYPSchGkBda6veA==
X-Google-Smtp-Source: ACHHUZ7QxRcEIS1oGnewylXZV/6b8P1kGCITgoNYLFT1cO0xOtFzTDCoXYpXWh4FwFTUmVk7YcH5wg==
X-Received: by 2002:a25:cf92:0:b0:bc7:be38:41f2 with SMTP id f140-20020a25cf92000000b00bc7be3841f2mr4941692ybg.49.1686577230740;
        Mon, 12 Jun 2023 06:40:30 -0700 (PDT)
Received: from localhost ([2601:58a:8200:2b0::e699])
        by smtp.gmail.com with ESMTPSA id m14-20020a819e0e000000b0055a21492192sm2476446ywj.115.2023.06.12.06.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:40:30 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:40:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, minchan@kernel.org,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
Message-ID: <ZIcgTEvxeAJ5SHuy@cmpxchg.org>
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531221955.GD102494@cmpxchg.org>
 <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
 <20230605180013.GD221380@cmpxchg.org>
 <f3f15b6a-8618-f755-f21c-4193c502e65c@quicinc.com>
 <CAJuCfpFB33GLbwvYspg966b6AGMopS3ca68hjL94kgpM7et7CQ@mail.gmail.com>
 <4543c4e5-43f1-bae2-245e-951437e4bd07@quicinc.com>
 <CAJuCfpE42OJZur-1u2hvvXmPkRdV1uOfK-Aqm2POmvrDpRwg0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE42OJZur-1u2hvvXmPkRdV1uOfK-Aqm2POmvrDpRwg0Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 04:13:14PM -0700, Suren Baghdasaryan wrote:
> On Fri, Jun 9, 2023 at 5:42 AM Charan Teja Kalla
> <quic_charante@quicinc.com> wrote:
> >
> > Thanks Suren & Johannes,
> >
> > On 6/7/2023 1:18 AM, Suren Baghdasaryan wrote:
> > > Hi Folks. Sorry for being late to the party.
> > > Yeah, userspace does not have a crystal ball to predict future user
> > > behavior, so there will always be pathological cases when usual
> > > assumptions and resulting madvise() would make things worse.
> > >
> > > I think this discussion can be split into several questions/issues:
> > > 1. Inconsistency in how madvise(MADV_PAGEOUT) would affect PSI
> > > calculation when the page is refaulted, based on the path it took
> > > before being evicted by madvise(). In your initial description case
> > > (a) is inconsistent with (b) and (c) and it's probably worth fixing.
> > > IMHO (a) should be made consistent with others, not the other way
> > > around. My reasoning is that page was expelled from the active list,
> > > so it was part of the active workingset.
> > >
> > That means we should be setting Workingset on the page while it is on
> > the active list and when it is being pageout through madvising. Right? I
> > see, this makes it consistent.
> 
> This was my opinion but others might think otherwise, like I found out
> in some recent conversations. So, it would be great to get some more
> feedback before making the change.

I also agree with the consistency fix: it should set Workingset when
madvise zaps pages from the active list.
