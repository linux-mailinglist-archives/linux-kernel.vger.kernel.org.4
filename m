Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FAB6E4037
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjDQGyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDQGyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:54:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2D840E1;
        Sun, 16 Apr 2023 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xkIPaj9erlzr3gawq1t3kzbVATkla0GqAxUj1VxbIyI=; b=4t76V2ZNgYjjefldKIZ754057h
        6zVqGakkXtHT2jKf9JJT8XSNfGjqAqdgJRtLosZ+4W/0tL6CjO8c6lPIFCioNh6c7T7HbJGRV4lqZ
        LLvRUsPCno/jWlfJnyl9BE43//H36poZswDwvJKKqxw32xdiueB2ZBap3zyPXFlKyqH15TCbwkMhB
        LGoA0OUW5kYe6O1ZrRn1EQ/a3hlKAiil0qM/bmWP0RIjjgGkfqkQ0Xf4UuQcCdEanp8YY7avDwiXz
        lZsg79ROepphs5KUhmeXJ2vgI+0ZC7ShueKt26MD3agDQ6QdbhfaZSx0e6wGPjdCckvttasXHOK/k
        A3EgNWgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poIjl-00F6BL-2v;
        Mon, 17 Apr 2023 06:53:17 +0000
Date:   Sun, 16 Apr 2023 23:53:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8 0/7] Add non-coherent DMA support for AX45MP
Message-ID: <ZDzs3eYIKPFcv0HQ@infradead.org>
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412-populate-busybody-4c6d7cfc4667@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412-populate-busybody-4c6d7cfc4667@spud>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:32:30PM +0100, Conor Dooley wrote:
> On Wed, Apr 12, 2023 at 12:08:53PM +0100, Prabhakar wrote:
> 
> > Note,
> > - This series requires testing on Cores with zicbom and T-Head SoCs
> 
> As I said last time, I dunno what actual Zicbom stuff exists, other than
> perhaps the Ventana lads having something. I did some tyre kicking on my
> D1 and it was fine, although nothing has actually changed materially for
> either of them with this series in v8..

And as saying before, there is absolutely no reason to add non-standard
non-coherent DMA support and let this cancer creep.  If you want Linux
support implement Zicbom, be that in hardware or the SBI.
