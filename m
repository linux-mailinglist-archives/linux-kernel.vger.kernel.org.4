Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE664E772
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLPHD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPHDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:03:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7E933C3C;
        Thu, 15 Dec 2022 23:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sfRWcakOzCImKuQ31GpyrKZZTEYpbr5TcvcIzBDp8iw=; b=y9IxiA19i+69W6+byTUlrSQv/D
        LmJsPsaswZRO+zL1k1S4sZS4yTvpf/2aAA3+sm6hOPmydQx+hG/M0IhDB+tt1bLYrYIjXSTiKqrvZ
        xqv2b3hr246ftg5sBr18Utmj+C1bb7HtIR2M92epTca1MQ6aW+VxWedt0Kv6MpCUCMUoTLzIkLGoy
        6NKYqktWcPR8b4ebW2isFepCJ9axKMeMWYgacikrIJD1xLkVFGXxww6PjzUU4sTnkUnu9sevp+vQe
        4rxs2lAZr9TnTMBB3NtvBhU5wv2otvSAbrvoGrtnvVC/j3evPnZv53rbN3Dnjyj1aFuyHkT+gRzx2
        SvCTlhxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p64kE-00DIki-Kq; Fri, 16 Dec 2022 07:02:58 +0000
Date:   Thu, 15 Dec 2022 23:02:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     geert@linux-m68k.org, Christoph Hellwig <hch@infradead.org>,
        soc@kernel.org, Conor Dooley <conor@kernel.org>,
        prabhakar.csengg@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, magnus.damm@gmail.com, heiko@sntech.de,
        Conor Dooley <conor.dooley@microchip.com>, samuel@sholland.org,
        guoren@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jszhang@kernel.org,
        Atish Patra <atishp@rivosinc.com>, apatel@ventanamicro.com,
        ajones@ventanamicro.com, nathan@kernel.org,
        philipp.tomsich@vrull.eu, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five
 SoC
Message-ID: <Y5wYIrMZIqu5f+WM@infradead.org>
References: <CAMuHMdUO7iFvh73u+m=EXYyxyePXHahJ=OVwQHdt0ap4vWDG4A@mail.gmail.com>
 <mhng-6160c058-408a-4ff5-8a7d-4fb2886d3d95@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-6160c058-408a-4ff5-8a7d-4fb2886d3d95@palmer-ri-x1c9a>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 01:40:30PM -0800, Palmer Dabbelt wrote:
> Given that we already moved the SiFive one out it seems sane to just start
> with the rest in drivers/soc/$VENDOR.  Looks like it was Christoph's idea to
> do the move, so I'm adding him in case he's got an opinion (and also the SOC
> alias, as that seems generally relevant).

Well, it isn't an integral architecture feature, so it doesn't really
beloing into arch.  Even the irqchip and timer drivers that are more
less architectural are in drivers/ as they aren't really core
architecture code. 
