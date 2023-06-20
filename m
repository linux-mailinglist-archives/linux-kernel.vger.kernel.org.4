Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DDD736374
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjFTGQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFTGQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D910D7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84EDA60FD7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C47C433C8;
        Tue, 20 Jun 2023 06:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687241781;
        bh=LMpBGTUUUELkIM6EQvSKyMUkDFcwpA6qZ213us++S/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McUN6c30/9B3DyabSlV3RNOLOHpvJxz3x2/QO/PqBi1TJJTBj3ovgS4HP0J/GaEXe
         KDhYuEFd7/lPv4hkpbvMCsxo5+Me0Ixyf9I/NUQjXVT4G6twavRfo5HcXshpgWFF5G
         MlrdanTDPkbYMwgsyND8dU3Jw1wKB2kxOVYSO+XXWESEy4pXfYBwZC/nRoON+mTobc
         QB1yN0kBk/rlxO9no3utaa4R6KHWzbfzdCvjzhtVqwnw3wfTSWsxdG8f9KRmpci8PJ
         s+viyKm8QgrKQX3aEy6cc0z5btJ0KGd4FDQzZjdwY991SaF5kuwphQq4SgCoJyb9Gz
         3EyLjHvJxcB5Q==
Date:   Mon, 19 Jun 2023 23:16:20 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yangtao Li <frank.li@vivo.com>, Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: f2fs async buffered write patch
Message-ID: <ZJFENFDFVx++RmhA@google.com>
References: <1dc1a0f2-9be4-8ae0-da26-3c00c8a71b41@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dc1a0f2-9be4-8ae0-da26-3c00c8a71b41@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19, Jens Axboe wrote:
> Hi,
> 
> I came across this patch in a news posting:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d618126911829523e35a61f4a5a4ad159b1b2c8d
> 
> which has me a bit worried. As far as I can tell, all that patch does is
> set FMODE_BUF_WASYNC, and then just hope that the lower layers handle
> the rest?
> 
> What happens if iocb->ki_flags & IOCB_NOWAIT is true, and now we do:
> 
> generic_perform_write(iocb, from)
> 	...
> 	->write_begin() <- does this block?
> 	...
> 	->write_end() <- or this one?
> 	...
> 	balance_dirty_pages_ratelimited() <- this one surely does...
> 
> If you look just one level down the latter to
> balance_dirty_pages_ratelimited_flags(), you'll even see the 'flags'
> argument documented there.
> 
> This looks pretty haphazard and cannot possibly work as-is, so please
> get this reverted until f2fs is converted to iomap, or IOCB_NOWAIT is
> handled by generic_perform_write() and below.

Thank you for pointing that out. It seems I haven't reviewed it carefully.
Hence I removed it from -next, and hope to have some time to convert iomap
soon.

Thanks,

> 
> -- 
> Jens Axboe
