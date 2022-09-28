Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071FC5EDC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiI1MOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiI1MOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:14:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07663645C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qDfNcxR4PZwQzGc3aGCJZCt8MxsrwYbwS0ZGRLtOrLU=; b=t0ITpa0F56NZNCExQUSx1JsoCr
        W9qxPGQAhUqbLTEwOgX2LohY52mTpgFosRja72bTYXEAwniSsyJWNn3H1DObXdu46TTR3tZIgaNxR
        9XYiaScnwArIMH2HIY2gcrzo4up99aF4IRHtVRypG28ACCOMpYFWj9PpW3ZAtOEkx/V/q/NCKI0fh
        pv+yiS1v+gAszOzUUNAi+6g/SDS4vSCjW1i0zwf/rA74fC+9yizO0ctjHt3k5VBARF/gTu7qJNdn3
        qg2Qfz/U5CtkT8GntZERl5Y5vT8RhZ2kQUEdD+NRJ5Lw3/u/TkSOUoF04D0zbzuLzJsn7VyxxoLEo
        CLkV/t9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odVxO-00GAkC-MR; Wed, 28 Sep 2022 12:14:30 +0000
Date:   Wed, 28 Sep 2022 05:14:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     apatel@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        atishp@atishpatra.org, heiko@sntech.de, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mchitale@ventanamicro.com
Subject: Re: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for
 systems with Svpbmt
Message-ID: <YzQ6pqykLhJVeD2p@infradead.org>
References: <CAK9=C2WkqVgg58sKyDEMWue_vL8Pz7bCfERuaW_4DGnYTpcSMw@mail.gmail.com>
 <mhng-37586d5e-5576-448a-8d9c-4d277c252365@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-37586d5e-5576-448a-8d9c-4d277c252365@palmer-ri-x1c9>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:35:56AM -0700, Palmer Dabbelt wrote:
> Sorry I missed this, I thought it was just part of the rest of this patch
> set.  That said, I'm not actually sure this is a critical fix: sure it's a
> performance problem, and if some driver is expecting ioremap_cache() to go
> fast then possibly a pretty big one, but the only Svpmbt hardware that

More importantly nothing should be using ioremap_cache at all.  It is
an API that has long been deprecated in favor of memremap.
