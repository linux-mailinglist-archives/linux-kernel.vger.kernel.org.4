Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C865264D8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLOJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLOJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:31:52 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E545113D71
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:31:50 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id u10so1556999qvp.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a3EptiNNYz54B6ALuBWXOFkTd9baua/QSniBYKYKUZY=;
        b=d341/ShCuNm10nw7YXEAqsyxMI1C9+zYWCuxWP6KtFLWgNL1luRsAMab4cG331bjiF
         ecGvAPHxwavOY3dWh/uHTy6ZzCeHYX5xarp1CBq2xRMd+YM2rUqUkQ81muxHi6hq9AvS
         8XitkIVk/iec2mh+T3HoI3VF7oe4e27dAcGlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3EptiNNYz54B6ALuBWXOFkTd9baua/QSniBYKYKUZY=;
        b=3msA7CIkG2lfPfEjEYQIrn2j+2pTzlA6X+u+1ax81EOWhtQuHSZ7/TPwP+pvrV2EPz
         fxIy9jIVtK+gXr81LNpD0EO+9HJ3jTXI6HDT1zXDiCDdfT0joWDwH6RawNYH8DqKUEs5
         aaw2WxSTLl9Rz2rvJ8wtqfCA2YUkx40Qa3Og7Rdgmig7v/jD/4akgXdhy4FxYPrCf/cU
         OpaVjHn/f8RZ3XraePUaXOGOwvFKFivuRR+9b39E62+XGFmBLEs+PeBOlpFnSHI+cfBv
         fCNFQ22Ym8uQ6iAyiIo7aLfj7atgrAzRN0KzFMBEsHHsY0wT/hwNuyd1B4+IEO3ijN8a
         EmAg==
X-Gm-Message-State: ANoB5pmcSnafA8UXZfW9rvuAHxpyCQRXYPrYFnPcljaV3VJbVXtZu5N4
        /ARKjVvNlEsEfTLoghdcdgq4TwDgpOXLWrO96+fPDA==
X-Google-Smtp-Source: AA0mqf4MjWdBgRV6+uwFHEh1nlyzpA7P1m0VMHF4xYlbLdYqgj/mBMj62ZjpW/dyQJKfHN5RHUtk2CKEOv5B6fQnj7w=
X-Received: by 2002:a05:6214:4281:b0:4c6:8e11:b1ea with SMTP id
 og1-20020a056214428100b004c68e11b1eamr69618854qvb.18.1671096709828; Thu, 15
 Dec 2022 01:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20221209140150.1453-1-johan+linaro@kernel.org>
In-Reply-To: <20221209140150.1453-1-johan+linaro@kernel.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 15 Dec 2022 17:31:24 +0800
Message-ID: <CAJMQK-ht8_dvdCOQXfUMGGa6ZcPJSXf_AjDd0OLi79WF43NYGA@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] irqdomain: fix mapping race and clean up locking
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 5:22 PM Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Parallel probing (e.g. due to asynchronous probing) of devices that
> share interrupts can currently result in two mappings for the same
> hardware interrupt to be created.
>
> This series fixes this mapping race and clean up the irqdomain locking
> so that in the end the global irq_domain_mutex is only used for managing
> the likewise global irq_domain_list, while domain operations (e.g.
> IRQ allocations) use per-domain (hierarchy) locking.
>
> Johan
>
>
> Changes in v2
>  - split out redundant-lookup cleanup (1/4)
>  - use a per-domain mutex to address mapping race (2/4)
>  - move kernel-doc to exported function (2/4)
>  - fix association race (3/4, new)
>  - use per-domain mutex for associations (4/4, new)
>
> Changes in v3
>  - drop dead and bogus code (1--3/19, new)
>  - fix racy mapcount accesses (5/19, new)
>  - drop revmap mutex (6/19, new)
>  - use irq_domain_mutex to address mapping race (9/19)
>  - clean up irq_domain_push/pop_irq() (10/19, new)
>  - use irq_domain_create_hierarchy() to construct hierarchies
>    (11--18/19, new)
>  - switch to per-domain locking (19/19, new)
>
>
> Johan Hovold (19):
>   irqdomain: Drop bogus fwspec-mapping error handling
>   irqdomain: Drop dead domain-name assignment
>   irqdomain: Drop leftover brackets
>   irqdomain: Fix association race
>   irqdomain: Fix disassociation race
>   irqdomain: Drop revmap mutex
>   irqdomain: Look for existing mapping only once
>   irqdomain: Refactor __irq_domain_alloc_irqs()
>   irqdomain: Fix mapping-creation race
>   irqdomain: Clean up irq_domain_push/pop_irq()
>   x86/ioapic: Use irq_domain_create_hierarchy()
>   x86/apic: Use irq_domain_create_hierarchy()
>   irqchip/alpine-msi: Use irq_domain_add_hierarchy()
>   irqchip/gic-v2m: Use irq_domain_create_hierarchy()
>   irqchip/gic-v3-its: Use irq_domain_create_hierarchy()
>   irqchip/gic-v3-mbi: Use irq_domain_create_hierarchy()
>   irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
>   irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()
>   irqdomain: Switch to per-domain locking
>
>  arch/x86/kernel/apic/io_apic.c         |   8 +-
>  arch/x86/platform/uv/uv_irq.c          |   7 +-
>  drivers/irqchip/irq-alpine-msi.c       |   8 +-
>  drivers/irqchip/irq-gic-v2m.c          |   5 +-
>  drivers/irqchip/irq-gic-v3-its.c       |  13 +-
>  drivers/irqchip/irq-gic-v3-mbi.c       |   5 +-
>  drivers/irqchip/irq-loongson-pch-msi.c |   9 +-
>  drivers/irqchip/irq-mvebu-odmi.c       |  13 +-
>  include/linux/irqdomain.h              |   6 +-
>  kernel/irq/irqdomain.c                 | 328 ++++++++++++++-----------
>  10 files changed, 220 insertions(+), 182 deletions(-)
>
> --

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

The series solves a race issue when having non-populated 2nd source
components that share the same irq on ARM devices:
Previously we would see
[    0.476357] irq: type mismatch, failed to map hwirq-11 for pinctrl@10005000!
and the component failed to probe.


> 2.37.4
>
