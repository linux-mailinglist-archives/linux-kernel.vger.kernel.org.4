Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB2C6E8A27
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjDTGJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjDTGJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:09:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4468B4680;
        Wed, 19 Apr 2023 23:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y1fiSpe5uktHaZN3qkwBIPcw/lgTQnLW61fjLn3awpQ=; b=P9zNLRHuEhBiVT+zGB6b2yq//c
        acvSSYExcgeQnHqcGr+fLeZmv1lraHehspc6NwXdIRVMZVL1wx9+dhd6MInoduQCtEZ3IHtKe+2Ja
        KsWIFONkA4fjrhC006b7bY8fPjss6woJy4e6i7pFmsGHiebAP2byEhT7wrXGrKbzQ815v/qsV3XOk
        HdZ25STspMYr8+kKkVI0HoQOeGmDb8RzfjOAh/XNQipx3ktvR+Kj61kaW3/JFom9xyGYS1OFgqCm+
        vsRVXn5eaRcFk8XKejBG7BzNMKvSrdsUlMvKhId10kJx8w+bfTa7qwNCLojV3X9OKJPPFPFsyBzCZ
        29uO92mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppNTd-0079ll-1v;
        Thu, 20 Apr 2023 06:09:05 +0000
Date:   Wed, 19 Apr 2023 23:09:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Conor Dooley <conor@kernel.org>, prabhakar.csengg@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        geert+renesas@glider.be, heiko@sntech.de, guoren@kernel.org,
        ajones@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, samuel@sholland.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH v8 0/7] Add non-coherent DMA support for AX45MP
Message-ID: <ZEDXAV7EJn9MH0Hd@infradead.org>
References: <ZDzs3eYIKPFcv0HQ@infradead.org>
 <mhng-e296c86c-71b1-46f8-88c6-16eda3590a3d@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-e296c86c-71b1-46f8-88c6-16eda3590a3d@palmer-ri-x1c9>
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

On Wed, Apr 19, 2023 at 08:59:03AM -0700, Palmer Dabbelt wrote:
> IMO we should just take the support in Linux: trying to hide stuff behind the
> SBI leads to more more headaches than it's worth, we end up with a bunch of
> broken firmware to try and work around.  We've already got a mess here because
> of the D1 support, we might as well just live with it.

I strongly disagree.  Adding more and more per-vendor ops simply does
not scale.  We're getting us into a giant long-time mess that will be
unfixable.
