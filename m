Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66ED73056B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjFNQuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjFNQuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:50:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928419AC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:50:07 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f9aa383527so21445801cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686761406; x=1689353406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Xh6X95qQ4DKgCGH6vSh1zNOD+c5n9iWRwnQijGvBds=;
        b=dsskxX9aeYFjsrOcIx3DHDQpEY4ERJCKdwVqYZCSpgugbUzHGvRMkohghaw4/+u8Wy
         wcvIylrAGJmwAq/pVQUec7zDf/W41hOfu805hrZGAp1J2PDCKQOapMj/YEqVrF8MBicr
         OAEI+IV+qixaozNZGYSaH1Y5uF85sBn6W2AzMPJ6er4nKcP+RwiOuRs5VYOXaqUhFWUs
         7Kawvn2xj3fhcTXWZ8lLQrdqKk818nnwDp9OaprO2/kXgC3sWv6i14DRZeSuQ1p4mf4w
         2K+CFzY3gKpZIHeJDGQsz4fBXVzUIZkLfpdWGVZ8w/mP5vqAzZsW2zFFrbpkiR19z+V/
         K4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761406; x=1689353406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xh6X95qQ4DKgCGH6vSh1zNOD+c5n9iWRwnQijGvBds=;
        b=R9lzuaXkJ5m/FC8UAr/Bv1JBwl9/xtk197KiUmrVZ9c4mDZQbvZjErGNfTqcjiqIDc
         bNHrmXXKvliJtk/uQxonns0yWlc7ZejA9NeAnKbyYy2K+68pPlUFxmDRervZ03442lOx
         6lAd2oRUPMmSSN3zih805a4bNUBuK7ahSsJzFi9MRZ5sLDky9eakKuQO/T1hdZjOx9XR
         ijqOy/gWIUNhUQlW9qr8b4zMUQneBjtwCzq/7C9w3vl02bPW9L46MD0GZljF/wJrYjAI
         bNd7nmA2POoNivka06/Fvj0v2gDaxYse8BrA83C167yonPcEAwIz9Y5Q8yMHOeKNWH8t
         yvlw==
X-Gm-Message-State: AC+VfDxVsuieYUAKweF+seHe0T++zM0+9v3yN01390Vg7EEvRGHoCAt4
        cN7KBCMfxQCrBKrEsEuBW3w1dmDsfB+AvjNVmkk=
X-Google-Smtp-Source: ACHHUZ66gdwAQVn8ETVVjnmelI9LapHpISswaU4wiKmZDwt9r7b0rzQ0VjaameNq5XrIkQhgzt3XBg==
X-Received: by 2002:a05:622a:354:b0:3f8:4905:9533 with SMTP id r20-20020a05622a035400b003f849059533mr2381471qtw.50.1686761406694;
        Wed, 14 Jun 2023 09:50:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id bb6-20020a05622a1b0600b003e1cf472b17sm4236320qtb.97.2023.06.14.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 09:50:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q9Th6-005A4Q-Ov;
        Wed, 14 Jun 2023 13:50:04 -0300
Date:   Wed, 14 Jun 2023 13:50:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v4 06/10] irqchip/riscv-imsic: Improve IOMMU DMA support
Message-ID: <ZInvvMZvrP4U/LL+@ziepe.ca>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-7-apatel@ventanamicro.com>
 <ZInSqC6b7RPD1nzX@ziepe.ca>
 <CAK9=C2XBObBGh2R2pxVgM0E1gFPBn4m7DKzoTxEmDdZ9V1QLrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2XBObBGh2R2pxVgM0E1gFPBn4m7DKzoTxEmDdZ9V1QLrA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 09:47:53PM +0530, Anup Patel wrote:
> On Wed, Jun 14, 2023 at 8:16 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jun 13, 2023 at 09:04:11PM +0530, Anup Patel wrote:
> > > We have a separate RISC-V IMSIC MSI address for each CPU so changing
> > > MSI (or IRQ) affinity results in re-programming of MSI address in
> > > the PCIe (or platform) device.
> > >
> > > Currently, the iommu_dma_prepare_msi() is called only once at the
> > > time of IRQ allocation so IOMMU DMA domain will only have mapping
> > > for one MSI page. This means iommu_dma_compose_msi_msg() called
> > > by imsic_irq_compose_msi_msg() will always use the same MSI page
> > > irrespective to target CPU MSI address. In other words, changing
> > > MSI (or IRQ) affinity for device using IOMMU DMA domain will not
> > > work.
> >
> > You didn't answer my question from last time - there seems to be no
> > iommu driver here so why are you messing with iommu_dma_prepare_msi()?
> >
> > This path is only for platforms that have IOMMU drivers that translate
> > the MSI window. You should add this code to link the interrupt
> > controller to the iommu driver when you introduce the iommu driver,
> > not in this series?
> >
> > And, as I said before, I'd like to NOT see new users of
> > iommu_dma_prepare_msi() since it is a very problematic API.
> >
> > This hacking of it here is not making it better :(
> 
> I misunderstood your previous comments.
> 
> We can certainly deal with this later when the IOMMU
> driver is available for RISC-V. I will drop this patch in the
> next revision.

Not only just this patch but the calls to iommu_dma_prepare_msi() and
related APIs in the prior patch too. Assume the MSI window is directly
visible to DMA without translation.

When you come with an iommu driver we can discuss how best to proceed.

Thanks,
Jason
