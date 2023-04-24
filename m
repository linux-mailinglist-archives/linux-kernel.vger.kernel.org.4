Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03DA6ED35C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjDXRRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDXRRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:17:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD551A2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:17:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1587501cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682356631; x=1684948631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0eRdTeN7jkM57vYYN0vPrAxj3a6rnjVZ2S7PSMzkMk=;
        b=7NKiu1IiwRRKF1fJQNyjBd8av5/cqtJU9MwybHOmeJ+dADdvaJ+DHco65RXZQcn7X0
         6JM1kMAWRWTmsRwLfIIpTIne4JD5RbLum/t9IInggIEJOXFzqJ5Btg3SH2BQ/iEayg49
         khUC9L54LBJse/JTK1luGsjzv3ex8pX8qi8Z9b/yuXuX7MbPT6jx7vYp1Q5wyLKe8V/3
         9wmskz5xZmaPS3BGEJsZbf5OTzsPTkI3qyOfEJcLpS6d3lzg8PXdje6yMaIi/eb8BipH
         oZWUdcwrxh54KXDhvz4VCshlClgQWMJHDSkB0sM3NQJzWIV52NuydPQUr9SBJnA4lWmz
         MLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682356631; x=1684948631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0eRdTeN7jkM57vYYN0vPrAxj3a6rnjVZ2S7PSMzkMk=;
        b=ibbGJL6SLMZEW/WJQc2GVSTkSkpi3mAZNdxPV5cWpT0z+4kgeR59rOI26sG2FK0q3e
         NlQsvKqaRG+1S4HpQH8E4RE4Fe//Tzae8KzenQLiYQRyKvsQkdBns8nlSRYV81jr6IeA
         v9zeuNtpZanQzQvraza/sCotIEW/iTkN14K+Bd/iYM61z8unaRXjj379qISc3lAezvgX
         ktR3xaKL2oVbBUG++BprLhBKn5UB2UoB1tj/nfGlKR4qdT9pfo7h+PwgufJxp7d3KTsz
         K5FRa+rsTFHx1GWXZwMP0WxxkK4p/Hy6L3baIaDo06HfBHBBDx6IuUfQQtPALdyVRQzs
         gr5g==
X-Gm-Message-State: AAQBX9cYjvTmqmJb9/Y4PE/KBCaRRw8MtbgXxKcmDJrXoZuvQC0i/wUq
        v8ldLdz8Gobkdv6bYmjMVOrCKpjvm2te5XeAzSsSVw==
X-Google-Smtp-Source: AKy350YtgyMieYjr0JvEnoJpmA/ps+11jar/nzBzxWKr51AeAPA8Y30sdbhN2GD3wvfyiHUpCqNYIzx9HSDTJyE3NRk=
X-Received: by 2002:ac8:5795:0:b0:3ef:3510:7c3a with SMTP id
 v21-20020ac85795000000b003ef35107c3amr693672qta.3.1682356631715; Mon, 24 Apr
 2023 10:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230421174020.2994750-1-yosryahmed@google.com> <20230421174020.2994750-6-yosryahmed@google.com>
In-Reply-To: <20230421174020.2994750-6-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 24 Apr 2023 10:17:01 -0700
Message-ID: <CALvZod4Ci1RamjLEk7e9zVnqSuEVKPEWjDUAwy6TWaU+X1WeVQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] cgroup: remove cgroup_rstat_flush_atomic()
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
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

On Fri, Apr 21, 2023 at 10:40=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Previous patches removed the only caller of cgroup_rstat_flush_atomic().
> Remove the function and simplify the code.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
