Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6D5EA689
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiIZMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiIZMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:52:50 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA6151004
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:27:56 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id s14so9796667wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pYI5zmDFx/C+Gngj0n9osNCGzV4YuNxNfzv+IfUjAvY=;
        b=VF1hX6ebYRmgkJzzQVGKqMJ+8IoUaAc6k6Mf9Ksbsimsz2qlAFlzLJWZcjaRRkmLfh
         RgB5Zx1llE8IVjEM7vpij+/iTBO+SMY3ze8VS0iD1NqCWPvKmFTIE1iFF8OcPTuwlyhq
         C55whwJGJoQ2+km2IK5SYHh3QwaeecBjpFAkyAL5xlmsm9UcKX1/Pr3pd6qbJ2McWYXc
         Rxxcx2UlpZOIt5Nd124NPW35SCalyk9tIDPH7QA8EaPXAS/pL39kK7mXF0x1fIQBydmY
         EwRQyvrLaVQZ9RcbtVUTh4BztthZ/C8nbrJitFJk+Yo60OuGCf+Lx8wEzRYoWpUacn8v
         3low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pYI5zmDFx/C+Gngj0n9osNCGzV4YuNxNfzv+IfUjAvY=;
        b=xAs7NCxmdype7hA8HQ8LaKMTN5bpx0MakjY/kQeASuNWbs1eu9nqDFHwlQVMdu7g89
         zzhhhoDPs7RwsYroZ1x+1sL55ucr9ZlYuvkCiEvqpSmzReepmjtmZYeHtEonBbZszliI
         Hb/biEOe4qCNn5xYgN5Q3sBAYtA3c1mbHHhjynIMKifbOvR6bDDdgE5WzWAhqVbplMYg
         j8J1u6KpyvUGzwrC7O8a9zxn+bntT+lcKrdDSjF36Kc4JzxipyjrxAykYIRZNj97BE1J
         yqL+ReOzXJZOlyzZqpsPMXNEaI2g61oJeSSrfTh6uinHUy+CWWzqSaqgcKKcMS7dW3B6
         5Ngg==
X-Gm-Message-State: ACrzQf1sBIIED40mXGyHUaFlmofq08qViuAzIpKppifnAneGM2td8P1j
        oo3TmAOjx3knsjfcAUeqvO1u1om/mkDO1fe1yHNzdQ==
X-Google-Smtp-Source: AMsMyM47axr3KS3piWD9iwfWMUqziIc4l9f9La8IAm+EGnHJdjvZlrwb24HERQLurx0j3CqQAiTH0gyMfm4RU1ok/Rc=
X-Received: by 2002:adf:e609:0:b0:22a:a6fd:cfe1 with SMTP id
 p9-20020adfe609000000b0022aa6fdcfe1mr13645240wrm.0.1664191499269; Mon, 26 Sep
 2022 04:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220926084428.1792815-1-weiyongjun@huaweicloud.com> <20220926084428.1792815-2-weiyongjun@huaweicloud.com>
In-Reply-To: <20220926084428.1792815-2-weiyongjun@huaweicloud.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 26 Sep 2022 13:24:48 +0200
Message-ID: <CAMRc=MfjB4QTf_zp5Rk3T_ndqDjCCjAW2HmGpJ9EF-i1epSLcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] genirq/irq_sim: Allow both one and two cell bindings
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:27 AM Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
>
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> The IRQ simulator only support one cell binding now, this patch make it
> works with either one or two cell bindings, where the cell values map
> directly to the irq number and irq flags.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  kernel/irq/irq_sim.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index dd76323ea3fd..73a90b7b6022 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -149,6 +149,7 @@ static void irq_sim_domain_unmap(struct irq_domain *domain, unsigned int virq)
>  static const struct irq_domain_ops irq_sim_domain_ops = {
>         .map            = irq_sim_domain_map,
>         .unmap          = irq_sim_domain_unmap,
> +       .xlate          = irq_domain_xlate_onetwocell,
>  };
>
>  /**
> --
> 2.34.1
>

You'll need Marc's (Cc'ed) Ack here.

Bart
