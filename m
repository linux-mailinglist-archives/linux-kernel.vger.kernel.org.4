Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD563C438
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiK2Py2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiK2Py0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:54:26 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8731363
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:54:23 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id cg5so9165792qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MZ0P22eZbT2LoWXuBc+NaiT5UofF++vBgLaQchK06k=;
        b=vBLgT7GncsxnI7YHNF1M/hBCGJ1BDruwVuoRpqwL3j1bsDrfOowrud81uwfvsAhSBg
         jBG8DniuxCEaX344IhAHSD85tpqiZZqckP3L32jk9iMtv3gl7eN69ai7GGK12xg4fYIv
         A3z8UKYKOCxX4IIrqKfEiVIMcN5KkQ9lSXVClS/nSuTFqkaR5cHIuF+MEB+NjiG+TLLJ
         P1U/mFtT6S/CwQJcIScou3DKvpuhIpdbGIeOW/KBYfwoXU32kQvvKl6mk+3t17Eb9VPt
         jgJ/dZhYJB+qbKPFXWRhAOn0XGa682SGcb4C6suA3YWO72buB8snn0SJmLcfx0r5e11b
         S6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MZ0P22eZbT2LoWXuBc+NaiT5UofF++vBgLaQchK06k=;
        b=oJ8wFcbILmIpjECAM2tD48VGkR65/Xh57E/12sbcqzooy/Fn3awGC9ga0s/ZWIz0Oa
         x/whzQg1qZ29btntfb4SD7ZPP0PMMNEc7P2sD008JXOwZAOqpgggU10ohs45bW+9XVsK
         sJZ9y+yxsn9aKmPrP1QSt6gTnslEvFGzzrIK5xdGKPC0LoDMopfc2/17ZF0esUgASNoJ
         wW6TFo375qFeh8ob1v79KV3ac2+sz6ffb1Hb/Xf2Si6UZL++k2Fivo4esEoRW7EikLuh
         EecWMsQGeHj9OPlpz0rRYaL/QJ8uyzqpB1Ia67cR8C2EJhChgz5VxDaG7E5JGW0SahEm
         C/hg==
X-Gm-Message-State: ANoB5pl2tFhQq82YlSI9TCHXIKikHGu/lQdl+0Hk0dU9gFkaFZNrzinZ
        TDDFn6Afz40gEJ/aBDlNjFggM3K2Y1AySg==
X-Google-Smtp-Source: AA0mqf4oKvSWCujdTl6t2i3G/hJjIRdSrYNV1/0SajLPgSolL4WWDryzk2+X/8x+lMlh7B24AG21uA==
X-Received: by 2002:ac8:1347:0:b0:39c:b637:a890 with SMTP id f7-20020ac81347000000b0039cb637a890mr52739459qtj.613.1669737263151;
        Tue, 29 Nov 2022 07:54:23 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id g11-20020a05620a108b00b006ec62032d3dsm10533307qkk.30.2022.11.29.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:54:22 -0800 (PST)
Date:   Tue, 29 Nov 2022 10:54:21 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org
Subject: Re: [PATCH v7 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y4YrLbJltvzWvXoy@cmpxchg.org>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-5-nphamcs@gmail.com>
 <CAM4kBB+7boz+PZfPODbS-KMGOPZpa2QO5xZMoP2q_ZfGyqmQTA@mail.gmail.com>
 <Y4YRQdOd55K7iC+q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4YRQdOd55K7iC+q@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:03:45PM +0900, Sergey Senozhatsky wrote:
> On (22/11/29 12:53), Vitaly Wool wrote:
> > I think the amount of #ifdefs here becomes absolutely overwhelming.
> > Not that zsmalloc code was very readable before, but now it is
> > starting to look like a plain disaster.
> 
> Presumably most of them will go away once LRU moved from
> allocator to upper level.

Yes consider it the "cut here" lines for refactoring the LRU into
zswap, which we want to do next. They're not here to stay, and that
work will remove a lot of duplication and complexity from all
backends. So I hope it's acceptable as a transitionary state.
