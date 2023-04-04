Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374026D67C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjDDPml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjDDPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:42:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5481D4687;
        Tue,  4 Apr 2023 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=booTjXEjDItMr83/eVTfoDxuM3Rup1He0ErLuQdXd0Q=; b=OzxbHVtyfERSnBcrsPOVWl5N74
        Wwjt4FFnh4JL6wj151vcbY8Ho3YWAWJmTY6uBMrEgRtcKeCF8r/WsbIGbNJktlDNxLc7QgJvQzT7d
        slGICmuquA4zKFpITpkzSJJCRMA2AK86yE7PBeajq9NP2lbyykUECAdvP9xA8kf6EMBpu+234Rg01
        ctn8sDyiKq4TvMXuzbc/GTSOoNwnnTC+sNQIoQKC6sDM9bLksyTEzubF/MQbdYx/bykf8T1zjKG9t
        d4rVicC0bmCCQjeyxb5B/JrlCbErkI74h4UdE9tb4p5kAT+STXHwmO2jG1Jfs74FkQi7chhw87d/H
        qWGoE7Hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjinR-0022mB-2C;
        Tue, 04 Apr 2023 15:42:09 +0000
Date:   Tue, 4 Apr 2023 08:42:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <ZCxFUb8+eQPzqBmo@infradead.org>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZCu1tFrQCVe2sgNz@infradead.org>
 <OS0PR01MB59224C99770F84D8CE2D0DBA86939@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59224C99770F84D8CE2D0DBA86939@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 06:24:16AM +0000, Biju Das wrote:
> Just a question, how does function pointer makes a performance difference compared to
> ALTERNATIVE_X() macros?
> 
> On both cases, we are pushing function parameters to stack, jumping to the actual routine
> And then on return pop the variables from stack. Am I missing something here?

Indirect calls have always been more expensive, and with the hard- and
software mitigations for spectre-like attacks they are becoming even
more expensive.

But other other point is adding more cache flushing variants should not
be easy.  Everyone should be using the standardize version.  If it's not
implemented in hardware despite having ratified extensions you can fake
it up in SBI.  Yes, that's way more expensive than indirect calls, but
that's what you get for taping out new hardware that ignores the actual
architecture specification and just does their own made up shit.

