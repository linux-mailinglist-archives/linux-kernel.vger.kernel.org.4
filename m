Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CA16051DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiJSVVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJSVVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:21:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2C216D553
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:21:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y8so18393123pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dj0xZ1Dkg4xYll0gq3dc/cKHh3HAtgA0/5nqHUBQtNA=;
        b=Hliu61acZJ5HS4cjpboBws44ZSH4NbJfPBzbR5C2Jyf6bYa8tegpNLN/MJnT7pVL4l
         JyxwH4qetwBIKpST1TAPslBdR/2DauEy7zdrAs7puFkvrNh6Lg2Xk0wBb1b/R6rUszpC
         CDxg9b8vnGsq/PyWXafF2KcTw3esz5kziO5nnyi65cnomf5mioODYMgLt+JD/lUvjZQY
         HWA22vFGVFQfnb38i2e+XPXOWoQiaKrHJEatTnItqiKMPJbKczEsP4XS70OrsbFEXOeA
         ptMGawxpiRTu3X44UcHkuyDPbXDOgWbOup2ZYURruTblOOYK0q+FbpJVCV0BO01zL+UP
         5f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj0xZ1Dkg4xYll0gq3dc/cKHh3HAtgA0/5nqHUBQtNA=;
        b=AgyedufbFHS9vsKrujHy3ZqPoc0si6FIO3HpyDgktkAggc5pcw6+ddLPv8U4h76Mgx
         r1qxPkimHhtElixl97VZyTJOvSxKoa7uaqyrQuiQQD9pf4rT76Oa7LmdnhcJOfu+pB2l
         JVT6it75mQT3scqmsY5LPM3Os8iYbCnqUIfJSHNGG7oQJgJQDKRw/LtM7TDksvBRfWXr
         RPDJHlgpEv2r7UZKKH2gxKbAE2TvBnvUkLvkbe/pjgvWT54H8awkFGwyd0tN6ElfPuCc
         4PogDskWVoFaZnImRhe+uGaACf9DNyOzT28xdZr4Ig+bZzfR6EoVM8QS03fScU+LlNsU
         cncQ==
X-Gm-Message-State: ACrzQf1ZzdK65k3ioUD/CsDrsiamSeeTVUVJhEpVqXuiPI4xZK1PWcig
        pfdmAX8XD39b7CYyr6yoZ/s=
X-Google-Smtp-Source: AMsMyM4QCgngN5J3mBKq1il/R1K8zc8Lu+96JmS1FxYMoTH/71wsDnzjPmkAzoo2EZvpzHxcoFoz8w==
X-Received: by 2002:a65:6bc1:0:b0:462:4a88:4fef with SMTP id e1-20020a656bc1000000b004624a884fefmr8804552pgw.282.1666214480796;
        Wed, 19 Oct 2022 14:21:20 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ix6-20020a170902f80600b00176cdd80148sm11169206plb.305.2022.10.19.14.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:21:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 19 Oct 2022 11:21:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        htejun@gmail.com, lizefan.x@bytedance.com, vschneid@redhat.com,
        bsegall@google.com, Abel Wu <wuyun.abel@bytedance.com>
Subject: Re: [RESEND] sched/fair: Add min_ratio for cfs bandwidth_control
Message-ID: <Y1BqT59ovFitahJa@slm.duckdns.org>
References: <20221019031551.24312-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019031551.24312-1-zhouchuyi@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 19, 2022 at 11:15:51AM +0800, Chuyi Zhou wrote:
> Tasks may be throttled when holding locks for a long time by current
> cfs bandwidth control mechanism once users set a too small quota/period
> ratio, which can result whole system get stuck[1].
> 
> In order to prevent the above situation from happening, this patch adds
> sysctl_sched_cfs_bandwidth_min_ratio in /proc/sys/kernel, which indicates
> the minimum percentage of quota/period users can set. The default value is
> zero and users can set quota and period without triggering this constraint.
> 
> Link[1]:https://lore.kernel.org/lkml/5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com/T/
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> Suggested-by: Abel Wu <wuyun.abel@bytedance.com>

This is a bit of a bandaid. I think what we really need to do is only
throttling when running in userspace. In kernel space, it should just keep
accumulating used cycles as debt which should be paid back before userspace
code can run again so that we don't throttle at random places in the kernel.

Thanks.

-- 
tejun
