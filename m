Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB3705F93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjEQFt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEQFt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:49:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93F35A5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:49:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52cbd7e73d2so277296a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684302565; x=1686894565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCbjMLR0MZgcNfob+sgwKSmJL6K6D2r7QJTL+XYxuoY=;
        b=neCmu+kmQQCi6kMbUvpKbB3crrQIIlJOMJaAX5+04o65SAm/rJJCULnMqUZtV9DUZj
         TS3Bj10pryxxtgQi2zKgGImlwFJ8h9KjXeJkwzavmE09947Ia3Dw8/z59I7LL+Bv8+Ge
         NJv56L2xKXKFgtXxkFFv5dW3hkStv92iKK7l+4Xv0jUMatFTRZGKOANQo/wh6n+C6YJj
         ftCW9eI1zRxJ2qpKs2jECnogoiP/FV0KTa9tl/cYElWMQfYvpCrp6XwHack8ieAWRRMl
         SrsbyOrN0dLztIsY+mGw04SwsdzDz9xD8Kr1Wv5w8dfa6iMZaWd7ceOBRA4iveWzeHSB
         qAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684302565; x=1686894565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCbjMLR0MZgcNfob+sgwKSmJL6K6D2r7QJTL+XYxuoY=;
        b=h/YYCU0EfbNElHTcnVMsWgXoYwLJfgHy/MKlC+rSplfrdfw5fSC9CacqDB3W32+3I3
         OWzvQkW18clOultehEQlwu7ykINXlri6IVokTG9rjtqY25YK6lEkCwbVf2Np5mFtD+JT
         GAykxblHlhk9s/MlxIrQpvUvBvH5uM1m/Zk42G68bUNifq+YUvLHNc+WEDv6hcxVE/zX
         CGoarfvPACTE++Zct9t9n6HkhPcbM1OgcPbozwXQMouZgRAJrdYwxIiC4/JP2oCgcgPs
         SN/AjJXyASgoWx5+XnchRxmO9USKjypF+vnZAq0Hj57JCYsGRIsnjNVso3Wn8cVf6FPN
         +ikg==
X-Gm-Message-State: AC+VfDzxjXAwKauZmfF73S3XlVBl14Lvj7mDFuNYMxV6zW38xS61NQVK
        Ag2kEqHwUyUb61cPY8EpOVWpntsjcZui039BA1Rs3A==
X-Google-Smtp-Source: ACHHUZ5fIT8xDntcFkwurCfHm8u1oNZsfnad+A4aQBt5Vv8q8opPNnB5kZgQuSA6fqq3MUIaDWfXwkaqeTY2nOTeU4g=
X-Received: by 2002:a05:6a20:3d09:b0:100:5f62:be76 with SMTP id
 y9-20020a056a203d0900b001005f62be76mr43582822pzi.54.1684302564708; Tue, 16
 May 2023 22:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230426203256.237116-1-pandoh@google.com>
In-Reply-To: <20230426203256.237116-1-pandoh@google.com>
From:   Jon Pan-Doh <pandoh@google.com>
Date:   Tue, 16 May 2023 22:49:13 -0700
Message-ID: <CAMC_AXUkiHvBaWQm8fnAbgbxe59iF9UM59=yBoa3LcuLGQ=E3A@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 1:32=E2=80=AFPM Jon Pan-Doh <pandoh@google.com> wro=
te:
>
> When running on an AMD vIOMMU, we observed multiple invalidations (of
> decreasing power of 2 aligned sizes) when unmapping a single page.
>
> Domain flush takes gather bounds (end-start) as size param. However,
> gather->end is defined as the last inclusive address (start + size - 1).
> This leads to an off by 1 error.
>
> With this patch, verified that 1 invalidation occurs when unmapping a
> single page.
>
> Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM=
")
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Tested-by: Sudheer Dantuluri <dantuluris@google.com>
> Suggested-by: Gary Zibrat <gzibrat@google.com>

Cc: stable@vger.kernel.org
