Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74572A10B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjFIRPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjFIRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:15:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84F53AA3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:14:52 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9d619103dso1031cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686330892; x=1688922892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+m9vgj+axxj/sV+0YTVNEhE062Nk+Gu6UrzhqyO0tA=;
        b=5QVk/GVbkZi6vTXzW3g5GqMBVejzLD9NBNYpv4o72oGJn/J9ohwUsJFscyIffB9GKP
         +Yr+wSrkRIkEkEzqdtiERJH3m/4E6PRftxA5rgxZFEKqw+CMnEVtfeeToSaYdMCAi+11
         atr3F3ebDuu0FOPo7H6436wh9kni4AWX7hZL8sw27ndPGNpXaZVYEpEG2RJWzeFKCXZo
         yZGzD5qAlvF9i2SCJab0sEELk04jVvwJoLtIHTdrNofSYUPqTDgJ5cTm27/h3OKfnFIT
         A4j9IDF/+uE5PLdIG7gMqfl/Yp1BB/LQcI4ywhFwwLXApUnMP3oC7CFRTZ2qfS+7kyd3
         2D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330892; x=1688922892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+m9vgj+axxj/sV+0YTVNEhE062Nk+Gu6UrzhqyO0tA=;
        b=UpsuzTZ9JITm5HfGPs8mcCBS026WUIDWX9Y9LH6FOYDafX0fiv2S/HZvEJWPsG2t4+
         lqJGOp75fFQQq32/RX7VKpXYnvAYms8bg33Bh1QV5EDxaSGgn9y7tkmxt4gM66Xsky+u
         L6Y9XXsz1uhf1zrZA419MR6ZA8h3HwjqbTg5mikTgFzSJbah+Rmrot7204+tPeHkHnMT
         2n2hYvw0Jf8rfHKVhKaawp++SNWk4PmgwOfqSMaUL8cfkov9MIzU3CLegnvtlj+rvRam
         VfwCGeBJN3BVXzHClcfIhowfm1c1PWuOGfxNEVjNUr7oF1KDMp0QS76e2Bh3G4lBR/7Y
         5LJg==
X-Gm-Message-State: AC+VfDxqBG/3GEvIirLiQAlPiuB1F68KkZl29VwuGlWvw9XBY6fIpPAS
        ZlOtbzZGtmqZc4E1K/U/BXXlLJz6h1XcTv16R2PVWQ==
X-Google-Smtp-Source: ACHHUZ7kjPrLteDdzJ8Lax2PDdtS+UKrPLEFcXxTn/BvqDKFG1FGPoVwEG3yjdzRCEixe6dCEELWVtm1HPjzZ6K8efw=
X-Received: by 2002:ac8:5784:0:b0:3e8:684b:195d with SMTP id
 v4-20020ac85784000000b003e8684b195dmr495097qta.10.1686330891802; Fri, 09 Jun
 2023 10:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230609013901.79250-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20230609013901.79250-1-wangkefeng.wang@huawei.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 9 Jun 2023 11:14:15 -0600
Message-ID: <CAOUHufaiCjOnxKb0g1myg9sdZp=hVMhbCche=duTxf5+9y1UAA@mail.gmail.com>
Subject: Re: [PATCH] mm: kill [add|del]_page_to_lru_list()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
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

On Thu, Jun 8, 2023 at 7:23=E2=80=AFPM Kefeng Wang <wangkefeng.wang@huawei.=
com> wrote:
>
> Directly call lruvec_del_folio(), and drop unused page interfaces.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Yu Zhao <yuzhao@google.com>
