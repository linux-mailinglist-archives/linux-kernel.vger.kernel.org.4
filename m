Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAA0731A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbjFONmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343965AbjFONlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:41:37 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31341296C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:40:58 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b2c6238cf3so4880877a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686836457; x=1689428457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGiRhDtKXKdPnyQZXUiGE0ms6YPJSlCDLGcXV/MnxP0=;
        b=G4hXBT6PybkC8KH4jDO+6jRK9k12fnRxCoaWSRP2wr+gO1sKPWpEMyOL87J/po3GLL
         KHckQV+ZPZ8XXKPaxxy7BnkWmNwSF/k3ON8UBg/HeFtEOGy5uSnEy3ra3izcRgbXokXp
         HJzo4pzIOJAdB0eSM8WxGgXk7Sofu06gGpFRFzr0QKqAs/cYDopNhL/yGGO10A/wJLmm
         BdN1H1shXDMf35pIgpkv0vDspO3LSmUlE3Rv5xpyOiZuvQoaH5STIA/lKVHcgRbKPxVS
         kpwZcztOeLCajx8hdzuMmWm/Wv+JCgJMLoXMgGAipJ+8P256gry4ceC9A5KEvI1Qim0g
         GdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686836457; x=1689428457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGiRhDtKXKdPnyQZXUiGE0ms6YPJSlCDLGcXV/MnxP0=;
        b=EqlpQGWqzyN3TtkTMwFyMpVij4IA4RR0Ue119qorEbRVHOSoglAmIYKHUSu83Opp/B
         mTurWQK2NfKnSHxREiuywkzx1QEHlF7juHchADG9nR6zoHB32yGwjWoSok6iSiXkcIzq
         chV88/ZCFFOJ2x9oO3D17R3PeMbjZ9nK7SiVBPoJ7rRYC+mFw3RPnAVMqUaoH910ocbb
         kJN8kGrBrLWw53aEK2GtKRrX8pFO/fX+mpUYo+PJs5UFsI5GSLAbOIdKn6RpNlpL3Tko
         VuE0MRjuUBl0YxpG/6tOM/DimMxJ+CJbF+/SQ09q3z7YSR5xm0mYmBSA6noJUrM9u8Cq
         2Knw==
X-Gm-Message-State: AC+VfDzhKCMsfe2L4PmF0i+C2khZ15E50rf8I36+AUohqUn5hlSTrs6O
        IH7jhgMLie8ELaeRAUIKSGqJENPGivZTMcoQzfheFQ==
X-Google-Smtp-Source: ACHHUZ6XCgEjbimdsWu4x2GNy+nm0L5U2fMv9VbzlJkrjSGth16K34QWIgjt8FDBjyfwI7uf2iQOX1EwMlNCSc7ezUU=
X-Received: by 2002:a05:6870:87c3:b0:19e:c567:6020 with SMTP id
 s3-20020a05687087c300b0019ec5676020mr13345394oam.38.1686836457449; Thu, 15
 Jun 2023 06:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <d9b22eaa-00a1-6c5c-99a0-126b085f7cb0@redhat.com> <CACSyD1NxcYn_Uy2DUk1ywSyWsxFzq4H+poaWvF55SZZz5W-uRw@mail.gmail.com>
 <3f54542e-235b-8456-f13f-786d21c6c14f@redhat.com> <CACSyD1OxAMowHTE7KnL8nac_-=Vp4eyO00oyMLFo0qcEHx33GA@mail.gmail.com>
 <bd119703-7b7b-c4ab-0c38-9b85809de252@redhat.com>
In-Reply-To: <bd119703-7b7b-c4ab-0c38-9b85809de252@redhat.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 15 Jun 2023 21:40:45 +0800
Message-ID: <CACSyD1NfbD_YBADH-3bR0=sGkrkEqxfgYLvyNyTiWdTvw2R6vA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     David Hildenbrand <david@redhat.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect for the swap->zram we should always get charged pages, because
> we're effectively writing out charged anon/shmem pages only -- without
> any buffer in between.

Hi David=EF=BC=8Cthe charged memory will be released in swap->zram. New pag=
es
are allocated by alloc_zspage(), and we did not charge the page directly=EF=
=BC=8Cbut
the objects(like  slab), because the zspage are shared by any memcg.

>
> For the fs->zram or direct zram access device case I'm not so sure. It
> highly depends on what gets mapped into the bio (e.g., a kernel buffer,
> zeropage, ...). If it's a pagecache page, that should be charged and
> we're good. No so sure about fs metadata or some other fs cases (e.g.,
> write() to a file that bypass the pagecache).
>

Yes=EF=BC=8C the pagecaches are charged in fs->zram, but  will be released =
if
we drop the cache. the compressed objects are not charged.

> --
> Cheers,
>
> David / dhildenb
>
