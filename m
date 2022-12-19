Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F24650D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiLSOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiLSOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:34:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6CF21A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 06:34:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79F1460FC6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02B0C433D2;
        Mon, 19 Dec 2022 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460490;
        bh=WvJqO+O9grYq3EdoFlvoFSVrzmjasbVzPIMXkFDko5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHe6ZJtxRtmtfLTJ5dVTtz4MVEHrFRTi560vMdS8UG+0T3/vmISvveOiFj0GChCdH
         /9lC+DhEhV2ckHUcx72Aw3/SO6eYtWQDU/h7NOdpmQsiNnl2+I6S0MckSSgSCG24M3
         4c+wK/I20d+J9OFJNp5rlkH5SLEf/CGHhpnAI0V9GDPdxB0rN+hp2glAkfXn47vU/H
         Jznqxs2npEa/d0iFS+1LVNYblIj/UAQMY/lQhN/3M0eDo/YndakK3Na1UxH7WwoqqU
         5tIlEdteMfRmlFm/j/NQzU/+US+Zj6F9joU/4FZMS4+xJn+g/r3edAWRXVUhfADZRh
         ECISyfxMnaIzQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p7HEr-0000VP-MV; Mon, 19 Dec 2022 15:35:33 +0100
Date:   Mon, 19 Dec 2022 15:35:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yj.chiang@mediatek.com, phil.chang@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] irqdomain: Fix irqdomain->revmap race
Message-ID: <Y6B2tTQCLXz/Oytt@hovoldconsulting.com>
References: <20221219130620.21092-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219130620.21092-1-mark-pk.tsai@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 09:06:15PM +0800, Mark-PK Tsai wrote:
> The irqdomain->revmap(_tree) of a shared irq can be race updated
> as following, which result in an unexpected irq mapping:
> 
> ---------------------------------------------------------------
> (2 threads parse the same hwirq fwspec in the same time.)
> 
> Thread A 			Thread B
> irq_create_fwspec_mapping
> irq_find_mapping						Thread A: virq = 0, alloc a new irq_desc
> 				irq_create_fwspec_mapping
> 				irq_find_mapping		Thread B: virq = 0, alloc a new irq_desc
> irq_domain_alloc_irqs
> irq_domain_insert_irq						domain->revmap[hwirq] = irq_data(virq x)
> 				irq_domain_alloc_irqs
> 				irq_domain_insert_irq		domain->revmap[hwirq] = irq_data(virq x + 1)
> 
> virq = x			virq = x + 1
> ---------------------------------------------------------------
> 
> The virq x can't work because the revmap[hwirq] was
> overridden by thread B.
> 
> It seems both hierarchy and non-hierarchy irq domain have the same
> problem because the code from irq_find_mapping to revmap update are
> not protected by a same lock.
> 
> Do you have any suggestion about how to fix it properly?

This is being fixed here:

	https://lore.kernel.org/lkml/20221209140150.1453-1-johan+linaro@kernel.org/

Johan
