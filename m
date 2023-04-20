Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54B16E9C23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjDTS4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjDTSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:55:54 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94352705
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:55:52 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3e0965f70ecso895951cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682016952; x=1684608952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbCxu47aXqOZFjOgElAuAaCkhQzE3b3RJfWYjmehSCc=;
        b=oa5zJsQrq+PRcAacYKvPmJFEiT892k3KGbGwJQk5suWva6mPaVh1qqAA8IzY+Jj/hD
         VFBYO4okZJxeVSzysh4ToRnXR/6o5DYUVATkBJfNde9WKEOtWJJ8yy7sY1xXBfZGEY3q
         xOZ0jkjwyMWdnarfIh0L8R4nUzdGSyWIKSazjknGk1r11LI/2RO684ecfw7UrQTVXs/M
         GzaTUPkrFcjqNquKq6y2UAqISLWfsxVd028RdcSxBegIpsM6e0JAtRgxUzO7FY9aKxf+
         Lt1hLlXFBFqgRdkJ2/8j3ivRECJ5MYEvxha3Z2O262UcpC3xjQwUKeyV2yCazEbahUJf
         4cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682016952; x=1684608952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbCxu47aXqOZFjOgElAuAaCkhQzE3b3RJfWYjmehSCc=;
        b=G6lSAAY9710jtuFB3f/pPuAYxs26gaUT8DRTngaZJNve39Q2XlFrVD03HweE4E+dWa
         cpvHLUI2hRUvGR0ppjz1xNtQYo/5AUMAN/+MAsS2jqSucdnX4BpR9raJScMsKPI/WPDf
         71zJBRIYEKyhZWDeKXyia1Dc8hqsgNoYAecrm9jKIyens1vzdp9HLG41JFHFTiUaDBQm
         YZLxiIUYRK3C/B5LvFoKtCH9n6oE1AXzQayLgHlJk77NcjtzRc7gzWJZ3O+2sJaiC1ey
         0MOJp71lRcPrwd9NBnzoNK9tHEHW6hwTZleZBJBZ+4TjNoEMcNQzSMjwjOYVRi4V39Rz
         Fe8A==
X-Gm-Message-State: AAQBX9efP+D4jgDU86ABUKTlFsxaB5pM+QEXM1X0/BHwrkGZEgo+6v6I
        +TKX8O8q0PntLjxq+/8l+55+J5+GxoMfJE7uYStOyw==
X-Google-Smtp-Source: AKy350YQ85co+lRTcuWRO1Vltk6Lkvqveeyi1jPBPoTaqbL7736XRkZW9Hessn4M1C1JBov0tCRU8RrPiXoZoB3KNYs=
X-Received: by 2002:ac8:5b10:0:b0:3ef:343b:fe7e with SMTP id
 m16-20020ac85b10000000b003ef343bfe7emr60397qtw.2.1682016952049; Thu, 20 Apr
 2023 11:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com> <20230403220337.443510-3-yosryahmed@google.com>
In-Reply-To: <20230403220337.443510-3-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Apr 2023 11:55:40 -0700
Message-ID: <CALvZod5mxE8RAtCEZkaq2fce-Od5MZtyPppn-ns0XzXHMcFm9g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 2/5] memcg: flush stats non-atomically in mem_cgroup_wb_stats()
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
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

On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> The previous patch moved the wb_over_bg_thresh()->mem_cgroup_wb_stats()
> code path in wb_writeback() outside the lock section. We no longer need
> to flush the stats atomically. Flush the stats non-atomically.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
