Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42F06ED357
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjDXRQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjDXRQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:16:47 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410786187
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:16:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f0a2f8216fso209121cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682356605; x=1684948605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFrKoxBHGprwgkyWOKkqPAUbe8SAzISHnkMGiiR8Aro=;
        b=UfBxvwVKYODQclpyyYmaFw+7g6vxWtp7h7eOLJzSO+Z4ZTIFraL2+ZKsSs2aXXuwsh
         HbDf5lyhZa88b5+PXxEI3xiuHA63r0DZqaOTUAqjEiIyw3u7d736t+fN1KOyOsXqKSIA
         8X2Inx/COF34us2GlZKK5Cq3jAC6buT8baXyjzFdKs6GK//FxdZnoqKt3AevOqfjcddu
         LL0kCTlD6IvZg2NLITGh0pBzvgbkj8R0+iJtApNuZe+MvXkMU3T07tEhupSemhWHOECT
         MHOXbbv5i4QMRJGaUVdL+h3BdxuFWUXKUd9nXpgbJQoa3sgZX7tViIMGFDFh0eeD47kC
         nrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682356605; x=1684948605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFrKoxBHGprwgkyWOKkqPAUbe8SAzISHnkMGiiR8Aro=;
        b=kU+01STjzdxJpX1dcWdqbJ/MOH7AGBfEmg7Z+78T5ul4+182YZQ6m8P0jCld/781KM
         0hNTrB747NjxzJbhGOPRELtxsim7Ca3ahby2AcSXNlrXZQR8rpMB9mKOB+rH5TlK3tmi
         zl09Yo6dG1QbexO6aR3rte5sWzRiRASsP+8GHv9mEbsnPahHzWAED2C8yZFR55NaSJ9K
         2+p2rzozvW85iIeg1nPsiXWQy2hihw5fBjbb0i7tnZI3DAxyTY6LjFY/CEjvZICZCaz9
         cLU+Ql8tML00MiXXVDQQlGjjkC1tsZGvHJaJBv2dOwNENa0Jd9EKcmM6Bhj7RKs/5SNu
         YuJA==
X-Gm-Message-State: AAQBX9f1ALNUEX+fmnA+PovDhELgLfzaa8A5hsIYpiTySxh3SglfAKyX
        iek6Q3+2G8MEiaA3Seye2UJnMN/MG/EQRERx9egdDQ==
X-Google-Smtp-Source: AKy350ZnDr71CnPlS6YKCwTlmx4svJxw+adqlJzgwBem4WSs9tOuhtikeDKT3A7ezbeWXxpF8wg8qSWtoeT7Hro+Uj0=
X-Received: by 2002:a05:622a:1353:b0:3e3:8c75:461 with SMTP id
 w19-20020a05622a135300b003e38c750461mr2244qtk.6.1682356605323; Mon, 24 Apr
 2023 10:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230421174020.2994750-1-yosryahmed@google.com> <20230421174020.2994750-2-yosryahmed@google.com>
In-Reply-To: <20230421174020.2994750-2-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 24 Apr 2023 10:16:34 -0700
Message-ID: <CALvZod5g9MYjYB5eY4Z9rX5goyh7xSU_b3nfCpJCoUrzmHpyAg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] writeback: move wb_over_bg_thresh() call outside
 lock section
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:40=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
> flush, which can be expensive on large systems. Currently,
> wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
> have to do the rstat flush atomically. On systems with a lot of
> cpus and/or cgroups, this can cause us to disable irqs for a long time,
> potentially causing problems.
>
> Move the call to wb_over_bg_thresh() outside the lock section in
> preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic.
> The list_empty(&wb->work_list) check should be okay outside the lock
> section of wb->list_lock as it is protected by a separate lock
> (wb->work_lock), and wb_over_bg_thresh() doesn't seem like it is
> modifying any of wb->b_* lists the wb->list_lock is protecting.
> Also, the loop seems to be already releasing and reacquring the
> lock, so this refactoring looks safe.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Shakeel Butt <shakeelb@google.com>
