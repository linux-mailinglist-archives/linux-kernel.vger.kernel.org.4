Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9870653A08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiLVARp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVARm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:17:42 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E481919035
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:17:41 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id ay42so48414uab.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QboiySatMa2yY2OmJacoU8/7uhUxbdGJEP86nNkt4ho=;
        b=gXBAZGGgMBNREkkdVr2Esw432H4rgyzcMliFThnuOVwwRIJNdew3xHHChS3udMXoGL
         CieMQ7JQvGfbNP/JGgH8ClNucnRlSD5hJtftXRqqEDasd11qlJt1wr2cCmgMPtOWROJ+
         YeQttU0fFU+cjRE+cIJUz6cz1bMtmFSCDk3/SVBrnhiWe3+BtrvP08+zak0lN2EfhenW
         TpQ8PiIHBiYcE1J9KLWGH8s7Z7QJGphyJWhufSGGYQfHGJCgz+lCmEDVKd+wOXWTl8xH
         CfhSwrrD9EY7rmJDiK9PfUlB91I2aK/XygylkHWktMbu/I2FAC0Lx3JwcFFSc7ccqRNe
         sB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QboiySatMa2yY2OmJacoU8/7uhUxbdGJEP86nNkt4ho=;
        b=Gbovl4fKcNoLdoRwmOSJq6ydZxfrMoPSzZKZbT/hWmuFKzfaBdDhbuOFsKAH+gTrRd
         5nxPiLatH6h0+PK6wK7W7y4E6WWrrG8C2uDj4ZDeF0C2baMOaOXMPbmCbkiRdGURALTc
         gYxSQrP32x/yroLUNflGIPuPt3Pe1Zbi8JOoC8DPldrWdHVEPxSWNlBBymhmDmKCddPw
         w88mBsFFLhXmSQjRLxNpj4zB+ftvO2/0zlvhMI9QdZ64Mow6pRUo75PnmfAVaaoWrwhw
         6173gglFomYw9fkYyaFhBbOPaY/UbxuZD1NXVXgFr2HYgTFyElUYZ9qW/W7TBJC106Ip
         HnGg==
X-Gm-Message-State: AFqh2kp6dC5UNL3iUZFrCAXF4D0g14p24CCboEB3NDfs1Vw0y3j2Dsfd
        ui9Kg1eWvn/31hzHHYUj4aKao0wIC6QNcajTAoHJFg==
X-Google-Smtp-Source: AMrXdXuP9IIt9KGbG/zIDsxNItvaUnnxOL6QMKOPD/kiYkTPAQI4oHd0UFN0Gx05m0eQGAEM2hGE03xiOiLGvcG3EJY=
X-Received: by 2002:ab0:3446:0:b0:488:68b3:4ba5 with SMTP id
 a6-20020ab03446000000b0048868b34ba5mr129489uaq.51.1671668260959; Wed, 21 Dec
 2022 16:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20221221001207.1376119-1-yuzhao@google.com>
In-Reply-To: <20221221001207.1376119-1-yuzhao@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 21 Dec 2022 17:17:05 -0700
Message-ID: <CAOUHufa_WsuD6UAW16G8aeuHaBGuBPEjoLekM3n7R4eeqb2RZw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 0/8] mm: multi-gen LRU: memcg LRU
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 5:12 PM Yu Zhao <yuzhao@google.com> wrote:
>
> What's new
> ==========
> 1. Rebased to the latest mm-unstable.

Apparently today's mm-unstable doesn't have prandom_u32_max() anymore.
IOW, this series now has a conflict with commit 8032bf1233a7
("treewide: use get_random_u32_below() instead of deprecated
function").

Will post v3 to use get_random_u32_below() instead.
