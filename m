Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41073D8FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjFZH6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFZH6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C468583
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7B6okcQX5DvR+o2sW8uBe3UYiOMl6OT7JIHNly8h6yU=; b=ZncGQtQhxUTzraJizW2ZrM+rSH
        Oz9z05YQewLNQpl1p4Js2qLMCkQxx/UTTg+cx+4U1uPZ4bo0V9jG9kXpYPzEPU1Bp3hTWSPTR88as
        TH/GgG1LtSwD4kWXymNNtZVEY2Cr9F1/pVEXGiuj96gyUL0+w25/DkHKeWff438DvraVBjIKQneeA
        Ft2LuzTJshBYS3PKL+vcwbI2swwzmkK0FVmgZH89mG89ESUBXOMBc2JcLTi32/+al8ULN7UeWudFu
        UjKm9xK8JDnMatC9MBhhyMiabIHBrEvDfWPfqI9OwVGJHOJmHtZ5Ud3dSj5HGirhB8gbs3jlW40Om
        uB2zETDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qDh78-009bXc-1k;
        Mon, 26 Jun 2023 07:58:22 +0000
Date:   Mon, 26 Jun 2023 00:58:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: loongson: fix address space confusion
Message-ID: <ZJlFHtmJE6vPyT0k@infradead.org>
References: <20230622101235.3230941-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622101235.3230941-1-arnd@kernel.org>
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

On Thu, Jun 22, 2023 at 12:12:22PM +0200, Arnd Bergmann wrote:
> Change the driver to instead use the physical address as stored in the
> PCI BAR resource directly. Since 'dev_addr' is a 32-bit address, I think
> this results in the same truncated address on loongarch but is otherwise
> closer to portable code and avoids the warning.

This gets rid of the warning, but is still broken.
pci_resource_start retuns a resource_size_t, which really is a
phys_addr_t, but certainly no DMA address.  To map PCI(e) resources
for DMA the driver needs to call dma_map_resource.

