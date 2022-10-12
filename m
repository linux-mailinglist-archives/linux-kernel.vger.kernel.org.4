Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AF5FCA07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJLRqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJLRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:46:05 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69B81C93F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:46:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id u71so8618198pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iadacU8HjMHZCZhJygxiIG7/MygN7METMFxWBA2IfjE=;
        b=Yf1mCOSuC0WDz6zTEAp5QbI0HxH6ymxd5/zia+3afDO9yUKDLS+JDYybBqIpyHg2Dm
         LWkFjYvZlU+lltgGLwmCmY0sjldmPQKxu+JgxLtghVhKKE9d2EGEo+4yL94ZOAonjxeV
         kbj59D/U9GRzVI/buQnBYqv35sfmPZojLKOw5xjRiaI4ZELfvb/wGHiFtRagCRnx8ZcY
         1Q2dHtoW+D8FBefYRYVjTKHhY/gfwrZKot2sJULgk+EIeE0Ckuti06zdPv2Ov1Wei8vx
         t5+V2RKfZU6QUWknZ5QRlC7CW9PWtEWhquV1zMTl8C3mmCuTW7lX/uMUWODsxD2bXs1u
         Kc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iadacU8HjMHZCZhJygxiIG7/MygN7METMFxWBA2IfjE=;
        b=wH7qCf+WrwHpSmfObLtmLEUSKLLp+UwB+iHwTUfsIOgtwoqR+Wl7yoajLjfSrG17PA
         iGl/mNdxtkUUc3Pb4tO/LFT5g93Y9AIPa7c7mEhScHBHeGv+SZ8bkPNk6RVgSTxtUDkp
         aj1w7Xx+V2dPofWkmj5pOJuxdgaMj6r5X1ViC9bvFMPVpfMtYUg2YLj9Cc2o/2vCd3t+
         Kl+rbRQBdE2CgOa81wnKh6Sl94qAjljoJhjisIVgbpl6O0M23l5JZZMEWByJTHb9bUcV
         L2fNfyvVIjymnzx00LMc0GR/pVvaxjW2nb0VBlcP0B9Hz/tF+HsUOU3OnnXA8WLfmi3V
         veAQ==
X-Gm-Message-State: ACrzQf3DomHB7moFXWmN04IBlwuMNJsLUZ/99V81hfWhn8q7zrw5rmkT
        y+m+rW+i9T4Xo8WPE+L4nhFQC/om0dZQWbR1
X-Google-Smtp-Source: AMsMyM7vJ/PR4P14DLQBaJpzHCGqSoud7gaIwx0eOUsQHSMeqXrfDtMP4isskWzcfYApPERl8yACrg==
X-Received: by 2002:a17:902:dad1:b0:183:243c:d0d0 with SMTP id q17-20020a170902dad100b00183243cd0d0mr13409687plx.157.1665596751184;
        Wed, 12 Oct 2022 10:45:51 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:5351:89a8:5e92:8bed])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b00185002f0c6csm197132plg.134.2022.10.12.10.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 10:45:50 -0700 (PDT)
Date:   Wed, 12 Oct 2022 10:45:45 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Y0b9SYI7v94ig5v8@google.com>
References: <YlllpH+PB8XVUn6h@arm.com>
 <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
 <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
 <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com>
 <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com>
 <YypfJQqj8PeOp8A4@google.com>
 <Yzc2UrX7ndWw1vKI@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzc2UrX7ndWw1vKI@arm.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 07:32:50PM +0100, Catalin Marinas wrote:
> I started refreshing the series but I got stuck on having to do bouncing
> for small buffers even if when they go through the iommu (and I don't
> have the set up to test it yet).

For devices that go through the IOMMU, are you planning on adding
similar logic as you did in the direct-DMA path to bounce the buffer
prior to calling into whatever DMA ops are registered for the device?

Also, there are devices with ARM64 CPUs that disable SWIOTLB usage because
none of the peripherals that they engage in DMA with need bounce buffering,
and also to reclaim the default 64 MB of memory that SWIOTLB uses. With
this approach, SWIOTLB usage will become mandatory if those devices need
to perform non-coherent DMA transactions that may not necessarily be DMA
aligned (e.g. small buffers), correct?

If so, would there be concerns that the memory savings we get back from
reducing the memory footprint of kmalloc might be defeated by how much
memory is needed for bounce buffering? I understand that we can use the
"swiotlb=num_slabs" command line parameter to minimize the amount of
memory allocated for bounce buffering. If this is the only way to
minimize this impact, how much memory would you recommend to allocate
for bounce buffering on a system that will only use bounce buffers for
non-DMA-aligned buffers?

Thanks,
Isaac
