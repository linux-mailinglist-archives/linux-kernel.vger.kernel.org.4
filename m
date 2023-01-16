Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA366C06D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjAPN6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjAPN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:57:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1C823C58;
        Mon, 16 Jan 2023 05:54:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EFBF60FC7;
        Mon, 16 Jan 2023 13:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17CCC433D2;
        Mon, 16 Jan 2023 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877293;
        bh=OcdO1JWUCmNg+w34wlOYXhk+GGbIuoUVxALObErkpDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjEYHwEw8AAI8jKH8xHf87HKCVHBnLkFFdj5S3PdSbtrnzYa/tAPptPzdZ7CUKXlY
         y1DZg6Z8W5S25KWROoL6abELtO5nBpcE1MODTjXtUG+SutlyrsJoJaw5+T9GRK1ajk
         iQDNIf1ZoQUt4ChkdB4qZ3hqnoMBEj6B0vH+T9obdNUV+rpL+6qW+dsd8fdDnDeqzS
         s6XqqG4mVuWO8tV0PFIodtp3t/SCdXupA3r/NvEAqjt9cT25BQDQUsnk5Fmp1b6naA
         gjrMpnb1PbgMJL7mJt49NRyJSs9v0bOx0cuS9mIcYudcqPwcENUr7Tel3MjBCUAOQe
         ho4/OsDNyqk1Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHPx3-00043R-3M; Mon, 16 Jan 2023 14:55:05 +0100
Date:   Mon, 16 Jan 2023 14:55:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     johan+linaro@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        maz@kernel.org, platform-driver-x86@vger.kernel.org,
        tglx@linutronix.de, x86@kernel.org, yj.chiang@mediatek.com,
        phil.chang@mediatek.com
Subject: Re: [PATCH v3 0/19] irqdomain: fix mapping race and clean up locking
Message-ID: <Y8VXOQy09lJ+obLE@hovoldconsulting.com>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221220033042.27724-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220033042.27724-1-mark-pk.tsai@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 11:30:42AM +0800, Mark-PK Tsai wrote:
> > Parallel probing (e.g. due to asynchronous probing) of devices that
> > share interrupts can currently result in two mappings for the same
> > hardware interrupt to be created.
> > 
> > This series fixes this mapping race and clean up the irqdomain locking
> > so that in the end the global irq_domain_mutex is only used for managing
> > the likewise global irq_domain_list, while domain operations (e.g.
> > IRQ allocations) use per-domain (hierarchy) locking.

> Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> 
> We have the same issue and this patch series fix that.
> Thanks!
> 
> Link: https://lore.kernel.org/lkml/20221219130620.21092-1-mark-pk.tsai@mediatek.com/

Thanks for confirming. I just sent a v4 with a couple of clarifying
comments added to the final patch.

Johan
