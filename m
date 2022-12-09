Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E44647BC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLIB4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiLIB4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:56:03 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685F77D073
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:54:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3442649pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 17:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWEbjZuwz21qMAipQfSCpbrlbb3ehRFAaolDfDj6BYE=;
        b=HWIrb+g3Tr8iHSI08FLnXtwM1i+s4LoF5DGHrWkGkf+Jqd903i77WQVYt1WBH7Qct9
         klab4063qWxSiA74HCSP0IITwFbCCyN3P8PRFEDy2xhRV/7YZ50oznUDXEwAWLwkgW8I
         YDILBWWtcPHtKRQOTSfuthWLM7k1bBrLZAVKOEMe4LbxfJUUf3Z6/PWEvT6i/r4O9s9d
         u4L+z3DmRqn38SSLNtVIiIKDPuvfPjZJP1P/vY0vHP88Lf0e5ylCy63U66UqvQhgGW0t
         FYw1MhLQvENAXdggUrPFaLx8+RdSNcayIslxBv9OjiMsLuYZZfuH+TrHBYpSIZqbpAji
         jong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWEbjZuwz21qMAipQfSCpbrlbb3ehRFAaolDfDj6BYE=;
        b=DH1Xs8eek58QWgj+l2Ib/N3GEXcMuuypvbVGfPmLj9cUIY6J6E/kVL2Q0KRV3zdZp9
         HpnXRGuAFoqnBZ7oSyFJfkqDnjXilPsF7QgJJsSDLIxSHKTs4ZSl6S3Tr6o2qx0xv2HY
         p/uMpctDkYWlOnGD6haH2jKzVtNdCKq4BJ4ejRvakkho5IA/01lFjIKKSo8zmZNrLcie
         V+Ll+jum7tjSMZTW3Un5p3HZiocOjsrWxELTYJ+xq83ob/oCy1hHum38gj5sEWxgzdgC
         Obd8ydKShNsFzMa48n+8i2jhq7mh3iCGwdJQnBvZnVIr3Yd0QUeHQnGFzzfhKFVLVCLN
         X7iw==
X-Gm-Message-State: ANoB5pmqFIWC6u1vk92URdUVPIIX+r9TjuGuj3AWflYvCe54AFEOvqUm
        6MLiLuw3fLo4QzAqRrSN+TA9NWlo9dt/dnZXAWU=
X-Google-Smtp-Source: AA0mqf5o+H2Twq4K0sRizhUqxKyhJr5qkHexPhiRcOmmbFrKC5rYQUzAqenv3kypsZUo3oYqgkuY0YV3O5aaSGMlSRM=
X-Received: by 2002:a17:90a:c087:b0:21d:203f:a306 with SMTP id
 o7-20020a17090ac08700b0021d203fa306mr1064859pjs.148.1670550883960; Thu, 08
 Dec 2022 17:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20221208180209.50845-1-ryncsn@gmail.com> <20221208180209.50845-6-ryncsn@gmail.com>
 <Y5I3lSfsTmZ6tlJk@casper.infradead.org>
In-Reply-To: <Y5I3lSfsTmZ6tlJk@casper.infradead.org>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Fri, 9 Dec 2022 09:54:31 +0800
Message-ID: <CAMgjq7AuY_oi9Rw2r8rnA_tr7NeEXAd0OgZ4sNz4CiVV+2i9Rg@mail.gmail.com>
Subject: Re: [PATCH 5/5] swap: avoid ra statistic lost when swapin races
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2022=E5=B9=B412=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 03:14=E5=86=99=E9=81=93=EF=BC=9A
>

Hi, thanks for the review.

> On Fri, Dec 09, 2022 at 02:02:09AM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > __read_swap_cache_async should just call swap_cache_get_folio for tryin=
g
> > to look up the swap cache. Because swap_cache_get_folio handles the
> > readahead statistic, and clears the RA flag, looking up the cache
> > directly will skip these parts.
> >
> > And the comment no longer applies after commit 442701e7058b
> > ("mm/swap: remove swap_cache_info statistics"), just remove them.
>
> But what about the readahead stats?
>

Shouldn't readahead stats be accounted here? __read_swap_cache_async
is called by swap read in path, if it hits the swap cache, and the
page have readahead page flag set, then accounting that readahead
should be just the right thing todo. And the readahead flag is checked
with folio_test_clear_readahead, so there should be no issue about
repeated accounting.

Only the addr info of the swap_readahead_info could be updated for
multiple times by racing readers, but I think that seems fine, since
we don't know which swap read comes later in case of race, just let
the last reader that hits the swap cache update the address info of
readahead makes sense to me.

Or do you mean I should update the comment about the readahead stat
instead of just drop the commnet?
