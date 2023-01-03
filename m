Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7D65BFC5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbjACMVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjACMU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:20:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A763EE1C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:20:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBCB8612EE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C263EC433D2;
        Tue,  3 Jan 2023 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672748457;
        bh=xm2NByl3yjI2ATYgGnkJecO2t0pzu8NkiSD8Bp3s/4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=koaoedWK+pn5ufUeWMRqgRhcaK3NVYSy0CN4EfakCQ4C6Rcz+IPeXA1t1uVBEoT5B
         NQ3h1ouEY9dc2Dz0xsCxljhoOnJAefu0j8q0UnRQSVlsV0mkZuWacbGbgF6qF6d9F3
         rmlhb7pHbCCuLja8FKvHYZpX8AvdoANNr+k10xF1u3J0TBULOHqwPAslUPD2//jS/l
         UvdW2PIaj2oSkdU5wKgek8errhwB6/MwOIxiS6xdz/WQATTes6WMtzwHutRv5XxwKs
         UcWaO0ObD6JNsrWREqltvat/wPFumQnmBdULysYakbrXPn8vFEvEaIH8B1pmC0Hv6W
         Tfnw8V/zEzKRg==
Date:   Tue, 3 Jan 2023 12:20:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aren Moynihan <aren@peacevolution.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megi@xff.cz>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2] mfd: axp20x: fix order of pek rise and fall events
Message-ID: <Y7QdpAgutLYM4BrX@google.com>
References: <20221208220225.635414-1-aren@peacevolution.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221208220225.635414-1-aren@peacevolution.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022, Aren Moynihan wrote:

> The power button can get "stuck" if the rising edge and falling edge irq
> are read in the same pass. This can often be triggered when resuming
> from suspend if the power button is released before the kernel handles
> the interrupt.
> 
> Swapping the order of the rise and fall events makes sure that the press
> event is handled first, which prevents this situation.
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> changes in v2:
>   - add comments describing the reason these are out of bit order
> 
> previous version:
> https://lore.kernel.org/lkml/20221123230741.2430813-1-aren@peacevolution.org/T/
> 
>  include/linux/mfd/axp20x.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
