Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3CB696174
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjBNKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjBNKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:50:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F585FFD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8D4EB81D09
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3206C433D2;
        Tue, 14 Feb 2023 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676371836;
        bh=68uai7TNsXOvIYCr3lz6Q2xPOcuCjWD5YKeKDVLTc6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6PRg6muznqee2CtAkR0BoD74iNmhyAx+hOSJWA2cg2rm1O4i4XF6G01Ld6PZAZcc
         Syg6f7XTgdrgXYP4QKgorkXZKt9RD/13bOwPQ0bfpbJYZHgNmEbhB1syOuN0Bjrf3n
         b+t1sQjjPppZg9COplgvu9/WKN5i4e+/g92GfNhk=
Date:   Tue, 14 Feb 2023 11:50:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Thalmeier <michael.thalmeier@hale.at>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: ttynull: implement console write
Message-ID: <Y+tneRpVV2KK3Iqy@kroah.com>
References: <20230214102317.382769-1-michael.thalmeier@hale.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214102317.382769-1-michael.thalmeier@hale.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:23:17AM +0100, Michael Thalmeier wrote:
> Since commit 3579b59c7edc475013ae769a2d26d99733c95f13 ("printk: refactor

Nit, sha ids should only be 12 digits, as per the kernel documentation,
can you fix that up?

And wait, that's not even a commit id, are you sure that is correct?

> and rework printing logic"), con->write is called without checking if it
> is implemented in the console driver. This does make some sense, because
> for all "normal" consoles it is vital to have a write function.
> As the ttynull console driver does not need any console output the write
> function was not implemented. This caused a "unable to handle kernel NULL
> pointer dereference" when the write function is called now.
> 
> To fix this issue, implement an empty write function.
> 
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> Cc: stable@vger.kernel.org

Adding a Fixes: tag here would also be good to have.

thanks,

greg k-h
