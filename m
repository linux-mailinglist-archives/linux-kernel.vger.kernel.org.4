Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564CC67DD67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjA0GXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjA0GW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:22:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84689359C;
        Thu, 26 Jan 2023 22:22:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D1C8B80B19;
        Fri, 27 Jan 2023 06:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77553C433D2;
        Fri, 27 Jan 2023 06:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674800573;
        bh=QUqtfU/P3ivnDBusScut971BX1chlQ7xKCkHREbxHkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z68xagY6Yt3NyLoWbSYVy8V0DsBeB8/Lzemv0q3NBvo6Fdjn9gU9M1L8P+RzfwHQe
         8rY8MTIOnus5gdjNsuYlA013fywv+SMG5lKUSAzfk0Yw785xtBkIatqmZ7WES4KdT1
         rRNO2K/o3Gt3jkJwFBje9BhQZQORF0gezxorr1Ik=
Date:   Fri, 27 Jan 2023 07:22:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: MAX3421: Handle USB NAK correctly
Message-ID: <Y9NtvKbY1nfoVtw9@kroah.com>
References: <20230127024734.8777-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127024734.8777-1-mark.tomlinson@alliedtelesis.co.nz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 03:47:34PM +1300, Mark Tomlinson wrote:
> A USB peripheral can respond with a NAK if it is not yet ready to
> send/receive data. In this case, the transaction should be retried. The
> MAX3421 driver did do this, and switched to a different type of retry
> after a number of 'fast' retries. On at least some USB flash devices,
> this second type of retry never succeeds. This patch changes the
> behaviour so that 'fast' retries continue.
> 
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
>  drivers/usb/host/max3421-hcd.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

What commit id does this fix?  And should it be backported to older
kernel trees?

thanks,

greg k-h
