Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49CE608067
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJUUzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJUUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:55:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081AEE0B2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:55:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so3417686plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F7u5LENBlh/N8BqD1OrpsNANMRi3dqvQvqj7Z7ssiI0=;
        b=mYmgYlJLNMQSWHbPU91tYuq+vNAdaCvkR6a5DcOjqAK1Fk/X3l9VcfI1d9MnP4sMkj
         JmPZgLbSeMd6kNNtcn0DcYp2A6aqodCC6wxc6agmNWsJ6VYaV2NsWcm/Ome9Hy8YMyDk
         oQR5Da8gL42iggH2mY3sGSeTDr5z5QVmlSouLSUIUS7tA4JqysDPrQtP7k9R2SYcDFwM
         UQnl+Vt8q29C1TFbhSoYTdKyLEoW9C4QsmCBIEuqulgo8oNwi55JEVsk8IePPwrSio3I
         Ds4ZUyBfswFGMadLVAszIGW7XMByMcO90iInmIQu3fs01fZF+I1wgNYT5xIhOWKnfj4u
         ayWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7u5LENBlh/N8BqD1OrpsNANMRi3dqvQvqj7Z7ssiI0=;
        b=oyZEQU+PVW/1g4xRd2VYI/970E2+b1qm5VaJis00jg2x3HyBr/m9cVjuAwytL86Gs4
         OZV4h2xRKkOnMrtK2aMl484DptBLmHM80sGs2AMhhj48XBz9V0rk2Tzyvl332kJv47P4
         wFtvdEpTaQGbbLfLdLzGfj8LVd9GoG+INUoJ+nY5zy3kLXOhUmHPlxc8JzquJXePQS4j
         SLQpJ0C7PQUFghlxzrP/dXXLxPSLcGmMvuGaoAy62a13vb1JRCVtCm4iz5FzLw3c6aEo
         81FG+tul3L7uzRMykPyyMmlSUctGdlFjHwU8QR7Plgc0NCCRfWJIFiHJ4HO6kFdcUOnN
         x3uw==
X-Gm-Message-State: ACrzQf0sfUIU8SjanKnTsTsKw5agbvpgB5ppRO25aqqdFgYC1PksSgIe
        Nmh3xtLqyAgTX1hvpJoQ6okwi8d3j4Lxs8eiVpU=
X-Google-Smtp-Source: AMsMyM4ZwGIw9LrZbmC9Nz2xCv+makqVTogU6wOpbhsZd7w12UlTZV0wFWpKJOi1ejJdrXeQrbgDuamcbx0N17Iqk3g=
X-Received: by 2002:a17:902:e88a:b0:183:9ecb:ff85 with SMTP id
 w10-20020a170902e88a00b001839ecbff85mr21222893plg.169.1666385720645; Fri, 21
 Oct 2022 13:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
 <20221021114149.eadf6fafdd0b2c2409a46389@linux-foundation.org>
In-Reply-To: <20221021114149.eadf6fafdd0b2c2409a46389@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 21 Oct 2022 13:55:07 -0700
Message-ID: <CAHbLzkpv3TkUag9+0mdBE5PbNuN4o3xbDT-Z4p-CjB6Fq775Hw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: migrate: Fix return value if all subpages of
 THPs are migrated successfully
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, david@redhat.com,
        ying.huang@intel.com, ziy@nvidia.com, apopple@nvidia.com,
        jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:41 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 21 Oct 2022 18:16:23 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>
> > When THP migration, if THPs are split and all subpages are migrated successfully
> > , the migrate_pages() will still return the number of THP that were not migrated.
> > That will confuse the callers of migrate_pages(), for example, which will make
> > the longterm pinning failed though all pages are migrated successfully.
> >
> > Thus we should return 0 to indicate all pages are migrated in this case.
> >
>
> This had me puzzled for a while.  I think this wording is clearer?
>
> : During THP migration, if THPs are not migrated but they are split and all
> : subpages are migrated successfully, migrate_pages() will still return the
> : number of THP pages that were not migrated.  This will confuse the callers
> : of migrate_pages().  For example, the longterm pinning will failed though
> : all pages are migrated successfully.
> :
> : Thus we should return 0 to indicate that all pages are migrated in this
> : case.
>
> This is a fairly longstanding problem?  No Fixes: we can identify?

It doesn't seem like a long standing issue. It seems like commit
b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
fixed one problem, but introduced this new one IIUC.

Before this commit, the code did:

nr_failed += retry + thp_retry;
rc = nr_failed;

But retry and thp_retry were actually reset for each retry until the
last one. So as long as there is no permanent migration failure and
THP split failure, nr_failed should be 0 IIUC. TBH the code is a
little bit hard to follow, please correct me if I'm wrong.

>
> Did you consider the desirability of a -stable backport?
>
