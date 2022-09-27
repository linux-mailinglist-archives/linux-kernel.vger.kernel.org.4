Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA35EC2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiI0Mcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiI0Mcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:32:31 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C1125DA4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:32:28 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id k9so4863009vke.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qikns/GO0HK79nuBO+XHthWmQJO+zDe5/PqMTWeNaJo=;
        b=CY98cOIMNBpJ33H5q7aB0pV39ZUfBY0ghgR3H2VqMy+f9Netlbce9kK/cI7KGh20Cf
         YGV2xI9TIYRJfbsJVDUu6mS08GSjZVcGldYOIqmsPrirJ4m9OTCbr2EjClDgw4MPqqba
         kx9q8LHywYmky+mgOUJe92xZspC6DMrGekl4Tlv8of7uTSrm1HxA5OY3xYVAihQ3MEYV
         I8LAxttdCQAVcHxdioQMKPUKSbG/CvBT2ssDXpNWsTUvjMIMpdEZLMbBvger9eZoB4R3
         fmqb6ZDbeR5Dfcqi4yfYuSpi4vaUVKXm56vjAkm+dQTNgBLTKNQVbGgG844vI5dWZ406
         acgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qikns/GO0HK79nuBO+XHthWmQJO+zDe5/PqMTWeNaJo=;
        b=KZU+208mfIKhg0c/A75FtN0eWO7c6NjrBYMAoLxUzUMy50IXnX77XPSnOiI5YxYIju
         ZGxCrx3IINe2ldhs5pCHb0EtV1So8IkjIk3CfnlCAPWuivzfDTTpxSNLQmUP54n2WbE5
         hsjAGrJUAuUBKQ1y+Pc2o4qz9xJm21nF635y3QDNR+SuMXREInX3HOPv3l99MDD53Wsm
         T6z4yih9jHdziVR76Hxck4zZJVFnL8fAxdQDD5yI7PM7WpeBuYAHvXxgnRA6YvbnZOS1
         Ubp+/PAJtNXkS7a+aTjp8gBIAR8bg4EUSW0cG7WT6wfYhJW87t8e2h+ngoIRzfiG7cYb
         cQIg==
X-Gm-Message-State: ACrzQf3mUYelG1tqISg9rlxpiKV6bJ833OUIm25YCkC/dY8XT0oMDKg0
        NBu1IoFuLDRNWsSlzPhiYvef9eixxdNU+q5A1rE=
X-Google-Smtp-Source: AMsMyM5K3vAI87c1DjRjTQjJNndJPHlRbd2M9Fianx1WFom9QGlFpzMHr7IwWc3aYi4JTcpn9sKh8zhJg63LMTWUpgA=
X-Received: by 2002:a1f:a90c:0:b0:3a2:ddcd:a0d5 with SMTP id
 s12-20020a1fa90c000000b003a2ddcda0d5mr10894647vke.19.1664281942807; Tue, 27
 Sep 2022 05:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220927045514.2762299-1-chenhuacai@loongson.cn>
 <e0efb8a9-b4b0-47bf-ab84-ea71c3630f9d@www.fastmail.com> <86tu4t6obg.wl-maz@kernel.org>
In-Reply-To: <86tu4t6obg.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 27 Sep 2022 20:32:11 +0800
Message-ID: <CAAhV-H4shgJZ9_zazOVBpKVDw-x_d55Hwk0Muwqokt-W8-nLCQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Make irqchip_init() usable on pure ACPI systems
To:     Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 7:37 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 27 Sep 2022 03:51:04 -0400,
> "Arnd Bergmann" <arnd@arndb.de> wrote:
> >
> > On Tue, Sep 27, 2022, at 6:55 AM, Huacai Chen wrote:
> >
> > > @@ -28,7 +28,9 @@ extern struct of_device_id __irqchip_of_table[];
> > >
> > >  void __init irqchip_init(void)
> > >  {
> > > +#ifdef CONFIG_OF_IRQ
> > >     of_irq_init(__irqchip_of_table);
> > > +#endif
> > >     acpi_probe_device_table(irqchip);
> > >  }
> >
> > I think that #ifdef should be in the include/linux/of_irq.h
> > header, with an empty inline function in the #else path.
>
> Agreed. Please keep the C code free of #ifdefs if at all possible.
OK, I will send V2 for that.

Huacai
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>
