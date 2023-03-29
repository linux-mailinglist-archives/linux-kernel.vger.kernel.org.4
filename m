Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87776CD2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjC2HSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjC2HRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:17:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B97212F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:17:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89EE5B820CE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B60C4339C;
        Wed, 29 Mar 2023 07:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680074256;
        bh=8NqDjRTRKipEiN3vLd2EfoPDzeFYiHCobShVCw9FOu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ALo5g5RoztptCZ7+qf9zjmQXAx6//O8hK04IgLj924HzskFe5QrCjhRb5KQW6Oopu
         EBLj6X3sV2SM6mrQuEjuV4KIFuKQAdR+Zmk2SQb1sC7VrZliXMmLXr25B+bI+1I/r1
         wPMkGEnfxxLoma9hmSrDPS6/KNTLQMBAbS8sgfdKvO7bsxv2ovE1c5Vp7kDwMFNmN5
         Dix90RfJ6RHcYFIq/H/LeDgXbSppjzrk7vGdvrIQ/4QLwGVyebj4Q1AIK+Xn8jpycL
         zPmTS4nGKyOK87hEbucozv+MQSA2bTLsyW45ul9sdm2P7Lmy84mDGHMR2GyUrLjjZv
         F29kUP4O3/b8Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1phQ47-00055h-BH; Wed, 29 Mar 2023 09:17:51 +0200
Date:   Wed, 29 Mar 2023 09:17:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     lee@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd:i2c: remove redundant dev_set_drvdata() function
Message-ID: <ZCPmH0HnqOYp4hpG@hovoldconsulting.com>
References: <20230329055724.43998-1-aarongt.shen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329055724.43998-1-aarongt.shen@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 01:57:24PM +0800, Guiting Shen wrote:
> the i2c_set_clientdata() is the inline function which is
> complemented by the dev_set_drvdata() internally. Do not
> need to use the i2c_set_clientdata() and dev_set_drvdata()
> at the same time.

In the future please break your commit messages at 72 columns or so (not
60).

Also the Subject should have a space after each colon (or that should
have been a slash, but in this case you should probably just drop the
i2c bit) and it's really not the function that is redundant but the fact
that it is called. Perhaps something like:

	mfd: remove redundant dev_set_drvdata() from i2c drivers
	
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
> ---
>  drivers/mfd/88pm80x.c       | 1 -
>  drivers/mfd/88pm860x-core.c | 1 -
>  drivers/mfd/aat2870-core.c  | 2 --
>  drivers/mfd/lm3533-core.c   | 2 --
>  drivers/mfd/max8907.c       | 2 --
>  drivers/mfd/max8925-i2c.c   | 1 -
>  drivers/mfd/wm8400-core.c   | 2 --
>  drivers/mfd/wm8994-core.c   | 2 --
>  8 files changed, 13 deletions(-)

Looks good to me otherwise:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
