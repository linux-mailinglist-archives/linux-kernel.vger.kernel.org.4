Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41D6DA885
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjDGFdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDGFdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:33:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AC47EE1;
        Thu,  6 Apr 2023 22:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YZA3VDxNwuLMMCf5Mdacs2Ilyk7N3IG7rNmv3k3HKHg=; b=pOpSwHGhZbphyJ6E2RBHf8vYzk
        EJHIdAjGggY0Y8ga67fthdofF5rVQ19RTywQc5/NHlZBZ2U4Ep82yAI59iDirWl/aLiIK+VFZyvOu
        wtD8MlFe5y9p43JELnibMq3OTOXcwwcAabthOlvZEVj+EzPhPCatvQ5R8Zj0Z1CPvB4nxOyXP260t
        8asF6PuRdlRdMOgJo8jjUNQdmbR7AEDQ0tm5APNT4+qKog13wfHNvIJlRbLCo5J0cW0aBLFY3P4uH
        ud1gbJL4yUzVvsgN0LFrsg/XqLBNhxi6GtUuk3+PAhcMNmq0eUWAms15PPASKXAXeP7vJWqCvP1a4
        /N3WGLzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pkej6-009Cga-1f;
        Fri, 07 Apr 2023 05:33:32 +0000
Date:   Thu, 6 Apr 2023 22:33:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Message-ID: <ZC+rLBDkdXWgj7YX@infradead.org>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZCu1tFrQCVe2sgNz@infradead.org>
 <OS0PR01MB59224C99770F84D8CE2D0DBA86939@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZCxFUb8+eQPzqBmo@infradead.org>
 <ZC9d2DIOMy27AAT9@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC9d2DIOMy27AAT9@andrea>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 02:03:36AM +0200, Andrea Parri wrote:
> > But other other point is adding more cache flushing variants should not
> > be easy.  Everyone should be using the standardize version.  If it's not
> > implemented in hardware despite having ratified extensions you can fake
> > it up in SBI.  Yes, that's way more expensive than indirect calls, but
> > that's what you get for taping out new hardware that ignores the actual
> > architecture specification and just does their own made up shit.
> 
> FWIW, ALTERNATIVE_X() for "three instructions with (what should be a)
> crystal-clear semantics" already smells like "we're doing it wrong" to
> me, function pointers would be closer to "we're looking for trouble".

Thanks for putting my feelings into such concise words.
