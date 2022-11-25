Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB716638EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKYRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiKYRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:15:33 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D07251C1B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:15:32 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id h206so3432946iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IW9TW2hjrT+/De0pJl1J2xvxRS2i1/S0hDRBrqezdyE=;
        b=i95daCPbgmjJiaRUVDPwpjztsQpU5y1IZdtrbvbWhoqPaeLXPbMAiWP5GlDzc9//P+
         1x7oYxNZsjvdPj5ccAZRy+GC4mjgA5WwpSUILvWLfYvYR7I0rjh1oo0ny5jCePDycVn1
         2RZu7gZtDqX6wFcDUgcQT0WzCzKDMp8hbCeBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IW9TW2hjrT+/De0pJl1J2xvxRS2i1/S0hDRBrqezdyE=;
        b=OUH12t+ct5WHEkzHI30KQHgm0c8QE6hV89PB6vaAEYEGwI/Alg4IATkfnkphxeXaZc
         IDkZRpNQbw5yMy2zg0QEotoVuyBuZHh1bBeYYOJ9Yb/152JuKYyKSN0Kz5Cny6QjNQMX
         PfsR1IoA0Ycgm0U549LBPb3LneFeP/oKHpjkqxAtIriwA6mvmvHjnFZQjNbiZDvMapE7
         dar9wMvG8/wx7GAh9RjzyDf6549hK8aAe6zn00Qu+26SKD0fmXM/qNC8Sds4YFurhdXj
         Xf8qHGWZq3LZLRRFO6LVPZ+TjHcGiHWP7WjnZxEqOraMsc6NrL7qqiUedxPkgmSTj1we
         rcpg==
X-Gm-Message-State: ANoB5pnjOtpQgYlNKjS82YWdQuwxhnRby9m/vvSTuX+QbTzj9a+GLDSB
        BZ2dkLayGTgSGYK7SSxFRaRlDU9L/XRfNqY1
X-Google-Smtp-Source: AA0mqf6F4TKg4T7/eHo7V4aQyJAoQOmyYf+k25iVwv2tNZjFOMTTELlfNHNYZiUZzaQ0SlqGPyaYqw==
X-Received: by 2002:a02:ccf9:0:b0:389:b9a5:f162 with SMTP id l25-20020a02ccf9000000b00389b9a5f162mr1409454jaq.14.1669396530950;
        Fri, 25 Nov 2022 09:15:30 -0800 (PST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id w8-20020a056e0213e800b003024dd5c682sm1408854ilj.71.2022.11.25.09.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 09:15:30 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id g7so2252100ile.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:15:29 -0800 (PST)
X-Received: by 2002:a05:6e02:1312:b0:302:f7e9:ca64 with SMTP id
 g18-20020a056e02131200b00302f7e9ca64mr1841112ilr.133.1669396529417; Fri, 25
 Nov 2022 09:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org> <b5682296-4844-863c-83c1-1fb9a35009d8@arm.com>
In-Reply-To: <b5682296-4844-863c-83c1-1fb9a35009d8@arm.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 25 Nov 2022 18:15:18 +0100
X-Gmail-Original-Message-ID: <CANiDSCv14WNUmAf5H6H-nsz8WZTTT5niUO-dAGtkdohPnn3b1Q@mail.gmail.com>
Message-ID: <CANiDSCv14WNUmAf5H6H-nsz8WZTTT5niUO-dAGtkdohPnn3b1Q@mail.gmail.com>
Subject: Re: [PATCH] iommu/mediatek: Fix crash on isr after kexec()
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin


Thanks for your  review!

On Fri, 25 Nov 2022 at 18:02, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-11-25 16:28, Ricardo Ribalda wrote:
> > If the system is rebooted via isr(), the IRQ handler might be triggerd
> > before the domain is initialized. Resulting on an invalid memory access
> > error.
> >
> > Fix:
> > [    0.500930] Unable to handle kernel read from unreadable memory at virtual address 0000000000000070
> > [    0.501166] Call trace:
> > [    0.501174]  report_iommu_fault+0x28/0xfc
> > [    0.501180]  mtk_iommu_isr+0x10c/0x1c0
>
> Hmm, shouldn't we clear any pending faults at probe in
> mtk_iommu_hw_init(), before the IRQ is requested? mtk_iommu_isr() might
> still want to be robust against a spurious interrupt, but then it can
> simply return without doing anything at all if the domain is NULL, since
> we'll know that's the case.
>
> Thanks,
> Robin.
>
> (It might be nice if request_irq() had a flag to say "if this IRQ looks
> pending already just clear it" for drivers that know it could only be
> spurious at that point; kexec seems to lead to this problem quite a lot...)

It is not only about the "last" IRQ before kexec. The peripherals
under the IOMMU might still active and producing faults and therefore
IRQs.

I tried this:

@@ -886,6 +886,11 @@ static int mtk_iommu_hw_init(const struct
mtk_iommu_data *data, unsigned int ban
                         upper_32_bits(data->protect_base);
        writel_relaxed(regval, bankx->base + REG_MMU_IVRP_PADDR);

+       /* Clear previous IRQs */
+       regval = readl_relaxed(bankx->base + REG_MMU_INT_CONTROL0);
+       regval |= F_INT_CLR_BIT;
+       writel_relaxed(regval, bankx->base + REG_MMU_INT_CONTROL0);
+
        if (devm_request_irq(bankx->pdev, bankx->irq, mtk_iommu_isr, 0,
                             dev_name(bankx->pdev), (void *)bankx)) {
                writel_relaxed(0, bankx->base + REG_MMU_PT_BASE_ADDR);

And I still get the same crash


>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > To: Yong Wu <yong.wu@mediatek.com>
> > To: Joerg Roedel <joro@8bytes.org>
> > To: Will Deacon <will@kernel.org>
> > To: Robin Murphy <robin.murphy@arm.com>
> > To: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: iommu@lists.linux.dev
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   drivers/iommu/mtk_iommu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 2ab2ecfe01f8..17f6be5a5097 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -454,7 +454,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> >               fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
> >       }
> >
> > -     if (report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
> > +     if (dom && report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
> >                              write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
> >               dev_err_ratelimited(
> >                       bank->parent_dev,
> >
> > ---
> > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > change-id: 20221125-mtk-iommu-13023f971298
> >
> > Best regards,



-- 
Ricardo Ribalda
