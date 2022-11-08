Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0F9621DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKHUrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKHUrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:47:05 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE82EA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:47:04 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id p18so5291167qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M8apV+JQ/XDpdKpjldXGN9Lci+S/grtcg+KJXQEl4jE=;
        b=B2pLdhd/PAfx5qL/KnZxHJ+Qarj0kriv6H2ySGnRIl61x3KIa4NRmdkU41vjNtSVlc
         A6nA9iJkSqi8K72XbR8QU1lo2aDUBSfpHOMTii8Qr4fJ+MgRnElYd1veASRKGfQ3dMQW
         ieiih7hSSX3zQPJ964A5ie3NUPOrTp8Wcbpco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8apV+JQ/XDpdKpjldXGN9Lci+S/grtcg+KJXQEl4jE=;
        b=g5WNMPP5vMTu4BWo0GE+3YWG/DPl6nM+epVge4Qw610tY6atS/M4wq/89KPvFb7OWg
         Ki1dce7EU+CmNge8hBFMUBJ6iLHklTc9P0wLGpKDRoBlP64ZXfSlZaisSbfA+bbQWiH9
         aO5zGTKaT56m9reKKyGhWxvrxQr2smx0hdvRGnQRMQQpo78qQokvheZEDZElksBlEzLb
         N1YgTAbiZhFc/O2OLpA51qzfxpHxzpk+IJ9BYgh5X9KNke04lceE1JA2B5NjmHmaysTc
         EAYH7FGNQ5md1WMHoL0J8RsmXVkeLZOgSAkTELQDkjEa8P5FcMoipf4/7JiXfbvH05YP
         aT3Q==
X-Gm-Message-State: ACrzQf3Jfg6Jq3vq6fmq6w5AEaRPE1Of5deHC8l8yhKoM7W5YG5AWYzU
        l2ChQrxABHwyjm+FjZtFCQ37cWBNhgOrSA==
X-Google-Smtp-Source: AMsMyM53LjLCxXrrjmOH+Gw+T51jgPLC4JmJt2Vr9gX8miVfzy26TiERKKW5AXojo75GpaMBfbPquw==
X-Received: by 2002:a37:bc02:0:b0:6fa:5af3:4208 with SMTP id m2-20020a37bc02000000b006fa5af34208mr25788383qkf.557.1667940423564;
        Tue, 08 Nov 2022 12:47:03 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a0c4700b006fa22f0494bsm10105460qki.117.2022.11.08.12.47.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:47:01 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id g127so18776066ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:47:00 -0800 (PST)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr58479884ybu.310.1667940420295; Tue, 08
 Nov 2022 12:47:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <20221108194139.57604-1-torvalds@linux-foundation.org> <15A1A033-73DC-4ACA-87B0-3535E9236F7F@gmail.com>
In-Reply-To: <15A1A033-73DC-4ACA-87B0-3535E9236F7F@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Nov 2022 12:46:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj10fOhx9-dkmRrttgXmhVihhwfTT=bdhqVQwC=sPUE2A@mail.gmail.com>
Message-ID: <CAHk-=wj10fOhx9-dkmRrttgXmhVihhwfTT=bdhqVQwC=sPUE2A@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: introduce 'encoded' page pointers with embedded
 extra bits
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 12:37 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> > +static inline bool encoded_page_flags(struct encoded_page *page)
> > +{
> > +     return ENCODE_PAGE_BITS & (unsigned long)page;
> > +}
>
> I think this one wants to be some unsigned, as otherwise why have
> ENCODE_PAGE_BITS as 3ul ?

Right you are. That came from my old old version where this was just
"bool dirty".

Will fix.

Doesn't matter for the TLB flushing case, but I really did hope that
we could use this for mlock too, and that case needs both bits.

I did look at converting mlock (and it's why I wanted to make
release_pages() take that whole encoded thing in general, rather than
make some special case for it), but the mlock code uses that "struct
pagevec" abstraction that seems entirely pointless ("pvec->nr" becomes
"pagevec_count(pvec)", which really doesn't seem to be any clearer at
alll), but whatever.

               Linus
