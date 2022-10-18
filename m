Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD2601EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiJRAMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJRAKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F8487FAB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1947761324
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E679C433D7;
        Tue, 18 Oct 2022 00:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666051731;
        bh=AlZaKY37ue9+sm+yUDIPpRy/WBGnr7bxFdjTk/HgI0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yil+6klrYruP1T2/F7D8VW4gCXboxfI2Nx2hnyLAID8xE8fKEScVmbCsOOYBeOZEP
         ZpUGvs66s2cZcy0+Avtpa7oeBLnNMBi5nkHxhH94NVSw2K0dhyJyhctoxxW5pEB6Mc
         SDIHQrePYB5nP35MDIpA4syd/ntd3cmEhjUHrZYQ=
Date:   Mon, 17 Oct 2022 17:08:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv3 4/8] zram: Introduce recompress sysfs knob
Message-Id: <20221017170850.034705ad83c54b92236d14f7@linux-foundation.org>
In-Reply-To: <20221009090720.1040633-5-senozhatsky@chromium.org>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
        <20221009090720.1040633-5-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  9 Oct 2022 18:07:16 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Allow zram to recompress (using secondary compression streams)
> pages. We support three modes:
> 
> 1) IDLE pages recompression is activated by `idle` mode
> 
> 	echo idle > /sys/block/zram0/recompress
> 
> 2) Since there may be many idle pages user-space may pass a size
> watermark value and we will recompress IDLE pages only of equal
> or greater size:
> 
> 	echo 888 > /sys/block/zram0/recompress

It's helpful to describe the units ("bytes") here and in the
docmentation.

> 3) HUGE pages recompression is activated by `huge` mode
> 
> 	echo huge > /sys/block/zram0/recompress
> 
> 4) HUGE_IDLE pages recompression is activated by `huge_idle` mode
> 
> 	echo huge_idle > /sys/block/zram0/recompress
> 
> ...
>
> +	if (IS_ERR((void *)handle_next)) {

IS_ERR_VALUE() avoids castsing back and forth.


