Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35BB63D94C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiK3PXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiK3PXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:23:17 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0EF4D5DA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:23:16 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w23so16982219ply.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkpn3JCLkN0zpicy7e0jcgZdD6YYDioTrx8v1I8/jMs=;
        b=GadttrHS1p84E1qQAQ/UpFhBhO77vSulBRtydG4Pe7Pg5UybNUOiEv+A89EITuLcSQ
         Wjz1o+kFDLytkP2JFdH9Lzyt+/+4z+7CWNQrxefS8Pjj+B17q/cZfRFJ5C2pVTAKrNi1
         TKgCtduuLidkKD1pMQdDdxWD0hUnK6hTlK7zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkpn3JCLkN0zpicy7e0jcgZdD6YYDioTrx8v1I8/jMs=;
        b=HyoCJLGNneobznS786BUbrqIOLXHkczNNp/vbbepPN1PjMNzf7MoPEB2AxXrQMae6m
         2vm+8havRDDhp38Yaw0tVeAA20y3UB4a9TdEDA1s1S8iDDaTGHAnqsrdqS0+OOAMOrVR
         hKhSi6xEBQjAAvkPY2idIXfW/qRjU7uI8v9Xl3bDjKDMlar/BxIVI8TCI80wTmZls2Fl
         N+yCtUlieMFXbY/Epc8ZzSDfhBNoRDhjV0OPNL90KTw+KDDSbWl3M7d0J8afH/p/znPr
         nmIUVGv5sGf+5yj+hC2umQDEBg+Pm3HSVbBNhnC7jb/ThOFpN/ybn53ATbL2hKqGgXO4
         0bBg==
X-Gm-Message-State: ANoB5pl2Brb9r9rfAUca5WOswHHybdRMZTWvsAxU2jhgGVU4n1Siiaa0
        vDp5qjxdGHICVmtuSCmF6GBtUcS/MFYooAiFwPAp5jRMiVI=
X-Google-Smtp-Source: AA0mqf5ZB+HWPqQCNZ8+DLlEcI0TmMzp56DEdnzGqqMW1Dq9ekan3CYchSohPjtlPTzd3UlL90WWVZM67cIwYPLp7kM=
X-Received: by 2002:a17:902:b40a:b0:188:635d:4b43 with SMTP id
 x10-20020a170902b40a00b00188635d4b43mr46622447plr.69.1669821796123; Wed, 30
 Nov 2022 07:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20221128191616.1261026-1-nphamcs@gmail.com> <20221128191616.1261026-5-nphamcs@gmail.com>
 <CAM4kBB+7boz+PZfPODbS-KMGOPZpa2QO5xZMoP2q_ZfGyqmQTA@mail.gmail.com>
 <Y4YRQdOd55K7iC+q@google.com> <Y4YrLbJltvzWvXoy@cmpxchg.org>
In-Reply-To: <Y4YrLbJltvzWvXoy@cmpxchg.org>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 30 Nov 2022 16:23:05 +0100
Message-ID: <CAM4kBBJXEZr3G9Jvfxm0dkn0bj_i4ce+CD_no8tNLvXtDN_ukQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 4:54 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Nov 29, 2022 at 11:03:45PM +0900, Sergey Senozhatsky wrote:
> > On (22/11/29 12:53), Vitaly Wool wrote:
> > > I think the amount of #ifdefs here becomes absolutely overwhelming.
> > > Not that zsmalloc code was very readable before, but now it is
> > > starting to look like a plain disaster.
> >
> > Presumably most of them will go away once LRU moved from
> > allocator to upper level.
>
> Yes consider it the "cut here" lines for refactoring the LRU into
> zswap, which we want to do next. They're not here to stay, and that
> work will remove a lot of duplication and complexity from all
> backends. So I hope it's acceptable as a transitionary state.

I see, thanks for the explanation.

~Vitaly
