Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F45B82B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiINIPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiINIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:15:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69813F19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:14:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w8so23928766lft.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=I0k8tZU5EA1om2p0HrvWZQVrfuJRA9iwaMceluI49gg=;
        b=AU3CnAwBQXv3Uq2aLCAH3Cu2NRTkciuThvL6P2EotywNNuz5Hcosue5+HWnXbjiy/k
         0ajrsxJiDskN9nEu4KRYyAJz99BCAyzOXEg5CoCbWu2hMZOYFXa4a66jdOIo8wnordNA
         YnqEFYJKrAOsymBCWRmg+WaklkGFOseC7Z8qsWmNIRJeHu+Zuhxw84QPloRqhmqX8O5m
         NNmNJRCXWufMtwYlrGSNGYrIz2fkCUzgUK+D+mykCFbZ/Azkv8wj1OWD4qld4xi7jFjx
         9eb9mkdLJN5CKzLY6z3uJ+ptJ27jL0Nliz5BSNwiRKgjqO+m6l2vleak/y6RGQAYw/wm
         z7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I0k8tZU5EA1om2p0HrvWZQVrfuJRA9iwaMceluI49gg=;
        b=Avs0bLrRswBGVS06lL97u2Yiyp5+ss4exl/P3J9Lze1pCMFetPIjY+3XFkGN4NaNq+
         LeiUzITOoWvnbeKwxHeetIUPWP8DnvB4niQrQbOqdjsjxY1u4LV6pjxIF7Z0/ODnirP2
         6Ylo6qmIOusoKzAYLkH+WLanmzjslMFS9rsY0oDJ96TfGuyMI2+ET/8AwauJteogHHKv
         rpTGIlNwzj8bboH1Iusu39SQ4XyTNmo6kLiUnH5YLiKVItrjEX0EysCLN1y92dJzdDr+
         jhoQI8ZeYnflBdgbGV9WsKp3Ojd66C8A0KALwORDxyOMaocimumkPRwHdz4pdgONXBqd
         eMXg==
X-Gm-Message-State: ACgBeo2oa7xAwM83nPdP5KXkVFYnzJdMrE30f05D/uB6lx72PYdwOKP7
        FNlhok379RyoX0dN2UISRVCKQyZlOz7oLPwdBPs=
X-Google-Smtp-Source: AA6agR4ZGW+PVIYAdlIi72oYGw0MFVTgwkNPpggNR6PJmEis6+XHJWhjPA+2jz/oKwfLXaOoPhPqGJEB0tyRq4+Zb0Q=
X-Received: by 2002:a05:6512:1527:b0:48b:99:f3ff with SMTP id
 bq39-20020a056512152700b0048b0099f3ffmr11568941lfb.81.1663143297635; Wed, 14
 Sep 2022 01:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <1663126621-26926-1-git-send-email-zhaoyang.huang@unisoc.com> <YyGESKxm4eA7MSAG@casper.infradead.org>
In-Reply-To: <YyGESKxm4eA7MSAG@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 14 Sep 2022 16:14:29 +0800
Message-ID: <CAGWkznE48kKtMFFLrhKE5gP9qdOBtwNFWKeiqh+E0PxuYBMi-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: fix logic error of page_expected_state
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 3:35 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Sep 14, 2022 at 11:37:00AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > The page with special page type will be deemed as bad page wrongly since
> > type share the same address with mapcount.
>
> That's not wrongly.  You didn't clear the bit.  I told you you would
> need to do that in the first version of the patch you sent.
Yes, I have cleared the PG_trackleak since v2 as you suggested.
However, IMHO, the page which has page type should be skipped for
mapcount check. The present problem is there is no invoking of
free_pages_prepare within the chain of
drain_pages_zone->free_pcppages_bulk, special pages with
page->type(PG_guard and PG_trackleak etc) will be leaked as
bulkfree_pcp_prepare will deem it as bad by checking the mapcount.
