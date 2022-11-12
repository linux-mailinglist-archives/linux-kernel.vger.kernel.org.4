Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A43626752
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiKLGLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLGLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:11:13 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C83C5B5BE;
        Fri, 11 Nov 2022 22:11:12 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id d3so6720717ljl.1;
        Fri, 11 Nov 2022 22:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iiJFdVsZWeFbUIjvbGEQtUMcST9y103D3tolVec5T+c=;
        b=i1uk5ZvqoGFGK8nZB98WC92fomQizagpq5RkWwzGaZxrUMx8Mar8RsEQ6zlflsys39
         VEXDGMZYPBy2Pj+uY1RqAdyGuNBxjebmUN0xx+4iEOpAxKZueS7HWY2Ed+ZPPUt61uNu
         M63Y0Wbspp8O946RiLU+4GoBetu7HM48lDHoOW+c7ehId7zndefjnqA1nws50PmN0n3X
         NcykmvbrlZJzTYp9gDEdcc0l8ia40plvLqQlgy+Nke9jLaBpxpg0n4kI82SG+JefZQQg
         8zAPXb9Q64PmIFGsfDf2UlwTnQI5DjRqiqUtr5EtSTjxTQkVnm2Vt7I5TIZ9TufwtfIb
         nOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiJFdVsZWeFbUIjvbGEQtUMcST9y103D3tolVec5T+c=;
        b=vDs7cFDyaKVUcZSDgMgSmDECoMcFlK0zoa0RFqjsY9wRvnjn8qCgctn/zCee9pa6dc
         1gOAcK5qUcBEGiDqIQQUC+BXLzJ9EjMcMQL3nYumqG8Ji21r7rTNIBDiop0XJ4HfRx4W
         pJEeLRDAoTjaU4vT1MxYzVO0HOv1byDxHi1xafZ41cSGLzgkSDa5t+Ka+GpLEAVz3X0g
         imcMrk6k/r5vwdbrNwLqToAsNSxlo4adiit0MIrpDrVtdwmSRu/gjtFzJenGamu8M/vK
         FyT9lqq76Q5EbIlfeJ3ppWpjPnGIZJCUJuOe/htMCccqxxzIKy2lSjefWticTejfRjbx
         S/lA==
X-Gm-Message-State: ANoB5pmA8mx5MZSW78DyAFyOiJMAXEi8Z3xi7hxvfpKOzO9wWNs5sPZe
        +Z2pw20/42PTU1uncvTQ2Tw=
X-Google-Smtp-Source: AA0mqf5DMQ1ZxQn699hZeiFNPKSFjAUDJmBcQbglma+77N/i2qEdjx22sDKIZ5Bfce+GOAJMZNGrWA==
X-Received: by 2002:a2e:6d11:0:b0:26f:c081:9aed with SMTP id i17-20020a2e6d11000000b0026fc0819aedmr1524113ljc.222.1668233470786;
        Fri, 11 Nov 2022 22:11:10 -0800 (PST)
Received: from thinkpad-p72 ([78.133.163.249])
        by smtp.gmail.com with ESMTPSA id q9-20020a2e84c9000000b0026dced9840dsm736624ljh.61.2022.11.11.22.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 22:11:10 -0800 (PST)
From:   Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
X-Google-Original-From: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
Date:   Sat, 12 Nov 2022 07:11:08 +0100
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>,
        kraxel@redhat.com, Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udmabuf: add vmap method to udmabuf_ops
Message-ID: <20221112061108.GA679753@thinkpad-p72>
References: <20221111114528.608801-1-lukasz.wiecaszek@gmail.com>
 <2ee10e0e-a347-71a5-051a-02b9bac0bbb6@amd.com>
 <512e97ec-5d5e-4d6a-e547-13ca4036f3d1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <512e97ec-5d5e-4d6a-e547-13ca4036f3d1@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:31:15PM +0300, Dmitry Osipenko wrote:
> On 11/11/22 15:05, Christian König wrote:
> > Adding Dmitry as well.
> > 
> > Am 11.11.22 um 12:45 schrieb Lukasz Wiecaszek:
> >> The reason behind that patch is associated with videobuf2 subsystem
> >> (or more genrally with v4l2 framework) and user created
> >> dma buffers (udmabuf). In some circumstances
> >> when dealing with V4L2_MEMORY_DMABUF buffers videobuf2 subsystem
> >> wants to use dma_buf_vmap() method on the attached dma buffer.
> >> As udmabuf does not have .vmap operation implemented,
> >> such dma_buf_vmap() natually fails.
> >>
> >> videobuf2_common: [cap-000000003473b2f1] __vb2_queue_alloc: allocated
> >> 3 buffers, 1 plane(s) each
> >> videobuf2_common: [cap-000000003473b2f1] __prepare_dmabuf: buffer for
> >> plane 0 changed
> >> videobuf2_common: [cap-000000003473b2f1] __prepare_dmabuf: failed to
> >> map dmabuf for plane 0
> >> videobuf2_common: [cap-000000003473b2f1] __buf_prepare: buffer
> >> preparation failed: -14
> >>
> >> The patch itself seems to be strighforward.
> >> It adds implementation of .vmap method to 'struct dma_buf_ops
> >> udmabuf_ops'.
> >> .vmap method itself uses vm_map_ram() to map pages linearly
> >> into the kernel virtual address space (only if such mapping
> >> hasn't been created yet).
> > 
> > Of hand that sounds sane to me.
> > 
> > You should probably mention somewhere in a code comment that the cached
> > vaddr is protected by the reservation lock being taken. That's not
> > necessary obvious to everybody.
> > 
> > Apart from that looks good to me.
> 
> Adding a comment won't hurt.
> 
> We have the dma_resv_assert_held() in dma_buf_vmap() that will help
> spotting a missing lock at runtime by developers. While the
> dmbuf_ops->vmap() shouldn't be ever used directly by importers.
> 
> -- 
> Best regards,
> Dmitry
>

Give me some time guys. I need to prepare patch agains 6.1. And this is
my first time, so now it hurts. 

Lukasz

