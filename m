Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9935F73F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJGFer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJGFen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:34:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86C6578
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 22:34:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r17so8983263eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 22:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4jbGxKrMNyFrPT2wGOijm8eTvwIabIkBrKxbAT6PEw4=;
        b=NMpqMafEZGLvFJinUjEMNwJc2rAJJOzrQbQOdjP2MzhyXzyrJ7ONGhlRfnm+bbla5q
         sT8r8tD2/aeMk/7D03Qpt2KVlLPIVxIigH5u6rby7moU9u9Rm4VwU1xHsx2+tktlldI7
         rESt98Ls4SirQGWP1FIGErVL3pTdrdstlH2UALxf52V6Uz6Fv5WkqRYuVBXje0laTjkJ
         6703B25OkSBwK0jz35y4duOLKSSyr4Pzs/pXSu14Xi3FpUM4xo6BCY9T8Ri3NNYn7r3H
         RvY3X04CLMGzbgNJdbK87hyKsXtt0vc6uvU689NZN5KTT30VRWwj3kyD5cW2G3hyh886
         5ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jbGxKrMNyFrPT2wGOijm8eTvwIabIkBrKxbAT6PEw4=;
        b=IXShci+vrc04/U3cs3WL0D1lnReRmDYtOoMGt2dhHbsli7XIQrFWq1PAIuyQIQb7/U
         957DHlkbUNBXy/Vg1VNTPRzT/q4BaBkK1+JoBiKAaHIOkzU+OZXGcXPzf8TNcvXZfk15
         ULiqpXoQwf6aozW51RB5+PO30R4Ms1dBWSlMspmsJhBbFlyeuBW4FXs9U8NGleisOodM
         DMck4BxuvxOWJ5saOwTi0ZWlpSwZE7NhosI6tqpLwmTiDbjuj8iusUFQHGzGyn9tw8fu
         +qQxaRvHVgb6rdOT+VB5DjSDXvqviLLbZn95x6EjlImq7CkfTgdsAXOJS/fCgjtA2FMY
         CIJw==
X-Gm-Message-State: ACrzQf1V4ytwjvTml4bWvhXJ9eYKpmCNjFBVc8qaOR3RFTH8uy1Z4+XS
        SNoiWNUi5SAii5DFkHZ4kDEqdc5TkXjlJh7KtU8crg==
X-Google-Smtp-Source: AMsMyM4aSI6BLQ/jCjVUkOo/hk2Rn1u7Y9p8ashAYqUw9TKQwDP4g3OmF6ynWNhT3kG/v6Q8x93bRBFLbXHIqmfrKLE=
X-Received: by 2002:a17:906:eec7:b0:733:189f:b07a with SMTP id
 wu7-20020a170906eec700b00733189fb07amr2774018ejb.230.1665120879890; Thu, 06
 Oct 2022 22:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <YzQ6pqykLhJVeD2p@infradead.org> <mhng-96bfb7a5-6579-4ebc-9517-db2e62d2f82b@palmer-ri-x1c9>
In-Reply-To: <mhng-96bfb7a5-6579-4ebc-9517-db2e62d2f82b@palmer-ri-x1c9>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 7 Oct 2022 11:04:28 +0530
Message-ID: <CAAhSdy15JqNAiuv84OogmoxyxwXE3EJzadfZk-wNcoUUXJ-fJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for
 systems with Svpbmt
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@infradead.org>, apatel@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        atishp@atishpatra.org, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mchitale@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 9:20 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 28 Sep 2022 05:14:30 PDT (-0700), Christoph Hellwig wrote:
> > On Thu, Sep 22, 2022 at 09:35:56AM -0700, Palmer Dabbelt wrote:
> >> Sorry I missed this, I thought it was just part of the rest of this patch
> >> set.  That said, I'm not actually sure this is a critical fix: sure it's a
> >> performance problem, and if some driver is expecting ioremap_cache() to go
> >> fast then possibly a pretty big one, but the only Svpmbt hardware that
> >
> > More importantly nothing should be using ioremap_cache at all.  It is
> > an API that has long been deprecated in favor of memremap.
>
> There's a few uses of it, I just send along a patch to make it
> arch-specific and make the users depend on it.  That should let us stop
> adding this to ports just to get the drivers building.

I agree, ioremap_cache() should not be used by drivers.

I encountered this issue with the PMEM driver which uses devm_memremap()
which in-turn calls memremap() (kernel/iomem.c). The kernel memremap()
still expects arch-specific ioremap_xyz() functions/macros to implement various
MEMREMAP_xyz flags which is why we need these RISC-V specific ioremap_xyz().

An alternative way is to implement RISC-V specific arch_memremap_wb()
but this will still look similar to ioremap_cache() added by this patch. Also,
only 32bit ARM implements arch_memremap_wb() whereas all other archs
(ARM64, x86_64, etc) implement ioremap_xyz() functions/macros.

Regards,
Anup
