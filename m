Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB666D9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbjAQJ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjAQJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:27:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D072196B7;
        Tue, 17 Jan 2023 01:25:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673947525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5e+vj8y4gZxJvE+IQBTE9Xgv6M39htwQZxrfUb3QY8=;
        b=UwVs7ytQrTRdVdmlRSzM5Y4sQF+pvpjRCzkfFiBG0+p7hVnTCiW+6zkEp1VEdEflwP6/Uw
        7UxdUTLtsJdkJ+iNAmLWscM+NdC5G0nipNrQAEHcXVkCGge0oKUXg9ZzjCMKTKsSECsIKQ
        c6SQahLYG4KwbAJhXefQPTlvsL9vdFRn2p2IXR4nKMOU4zlQSKtmYVkgYju/9c5VlygSEF
        55CjvNid36/gG1ON8WADc3FuKeGwUv51gsNFqwxIrOneOEK2XE2dPYdllmmkKuF0TbWwFz
        ShDyCHiX7FQOjAzNiHFXKnvuCpmTdFVIQdEcxN+cLka4v+/OOfvlO69Dgjv6Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673947525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5e+vj8y4gZxJvE+IQBTE9Xgv6M39htwQZxrfUb3QY8=;
        b=dCnwZoGIWL2sICu4Ti7wnioETqtgVxTR3CcLsQCruxUVYv76EgpCxwv9UjYn7JeMIv/cAB
        GZe7w900+jtCPqDw==
To:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        maz@kernel.org
Subject: Re: [PATCH] irqchip/imx: Do not unconditionally enable GENERIC_MSI_IRQ
In-Reply-To: <Y8FL0ATYr/fYk8Gh@gmail.com>
References: <20221111122014.524842979@linutronix.de>
 <166869769649.4906.4149362707512771458.tip-bot2@tip-bot2>
 <Y8FL0ATYr/fYk8Gh@gmail.com>
Date:   Tue, 17 Jan 2023 10:25:24 +0100
Message-ID: <87wn5lldh7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13 2023 at 13:17, Ingo Molnar wrote:
>   config IMX_MU_MSI
>         tristate "i.MX MU used as MSI controller"
>         depends on OF && HAS_IOMEM
>         depends on ARCH_MXC || COMPILE_TEST
>         default m if ARCH_MXC
>         select IRQ_DOMAIN
>         select IRQ_DOMAIN_HIERARCHY
>         select GENERIC_MSI_IRQ
>         help
>
> But that's not unconditionally valid - for example on x86 UP kernel builds
> that have the local APIC disabled there's no MSI functionality - resulting
> in build failures like:
>
>   ./include/linux/gpio/driver.h:32:33: error: field =E2=80=98msiinfo=E2=
=80=99 has incomplete type
>   kernel/irq/msi.c:739:19: error: invalid use of incomplete typedef =E2=
=80=98msi_alloc_info_t=E2=80=99 {aka =E2=80=98struct irq_alloc_info=E2=80=
=99}

What prevents us from either

  - exposing msi_alloc_info_t unconditionally (it should not matter)

or

  - killing that 32bit UP && APIC=3Dn combo (which removes quite some
    ifdef cruft)


Thanks,

        tglx
