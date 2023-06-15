Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE3730EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbjFOGAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjFOGAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:00:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AC726B9;
        Wed, 14 Jun 2023 23:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ML9VMp4RIG14LapkjOfTTLIBvPrls/xfIJ+IS48qD5Q=; b=TVYtRFJg8K8uqLENzR/ActzZHN
        wElNdCQzqpBSSrjPTOAsfjn1GAoE9zMlkAso93BtAuVCFm41sPlUaswPyuLnXELflsjCacSCsM9yl
        7uSvIvrlqm4jTLwxEIDJRrDDN1gfyZ9r9OF/ILr5Uilct+ouGKQnW0+3uVJKebSh+/gxAI3+cuR2n
        iJ3F4n43CMudq9FX2PMGmBDHMavYlP5rU+aOacbXPhxjC3cSYyiA/IcS8ii56GXWZNqwPJqBibMvp
        i9Iau+MQ5ZL5gX3HwsUDwGIR2z+2mGQhk95ith6k01lHhX/QByDU5hrrzGqxUugXWRxEuNMCxZ9w0
        HrMLawqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9g1Z-00Dn3R-2f;
        Thu, 15 Jun 2023 06:00:01 +0000
Date:   Wed, 14 Jun 2023 23:00:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v9 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
Message-ID: <ZIqo4TsHJr9vdQaU@infradead.org>
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230614104759.228372-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <4f69fcfe-debb-4979-9070-1d58ba35032c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f69fcfe-debb-4979-9070-1d58ba35032c@app.fastmail.com>
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

On Wed, Jun 14, 2023 at 02:35:44PM +0200, Arnd Bergmann wrote:
> I understand that Christoph will still not like this, but I think this
> is as good as it gets, making the standard variant the fast path,
> and using the function pointers only for the nonstandard cases.

Yes.  And I really do not want to make the non-standard cases easy.
The extension to do cache maintenance have been ratified for a while
and under discussion for much longer.  Adding random crap because
vendors suck is a bad idea, and we should not be adding this crap.
