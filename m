Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E96ECF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjDXNpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjDXNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB86C975D;
        Mon, 24 Apr 2023 06:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 426CF6248F;
        Mon, 24 Apr 2023 13:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C14DC433D2;
        Mon, 24 Apr 2023 13:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682343906;
        bh=5sfgyIuNq2ILFQ4VsBFdjYGPPsfoIxp5LfrdNP3N/fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rz7x3uIsGqwII1yccpVzKa5cOo3jvsM6SKLY5GYaC8x7gxxeLpbp5wMiWedrp21jf
         eb4D7WEkpEsM+7F9BUe3EPv20CL03aumbIRBOQ5h+CP1pVgCmPKOWVqNSkF8y6lI6E
         TVi7qou02trdwJmWpYgx77QKuIyvtYRNsSEBgNPPdiVCGLpEciIPhEa1M/c5dWqzIT
         wmnpTXxgY+pzsJAhS3NPv3pfXK/wkGPefPbkvO3sXxU9KuoZf3KH80kUbSkGGezS9L
         t+q9OuKcQGmHf2XLlo+Tr9kVSu++qzomQuQR7elnfAXXxa/NiEKzuzzgrMO3JdfzJI
         HMXWLhH08PRAg==
Date:   Mon, 24 Apr 2023 14:45:02 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Martin Schiller <ms@dev.tdt.de>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 5/5] leds: trigger: netdev: use mutex instead of spinlocks
Message-ID: <20230424134502.GK50521@google.com>
References: <20230419210743.3594-1-ansuelsmth@gmail.com>
 <20230419210743.3594-6-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419210743.3594-6-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023, Christian Marangi wrote:

> Some LEDs may require to sleep while doing some operation like setting
> brightness and other cleanup.
> 
> For this reason, using a spinlock will cause a sleep under spinlock
> warning.
> 
> It should be safe to convert this to a sleepable lock since:
> - sysfs read/write can sleep
> - netdev_trig_work is a work queue and can sleep
> - netdev _trig_notify can sleep
> 
> The spinlock was used when brightness didn't support sleeping, but this
> changed and now it supported with brightness_set_blocking().
> 
> Convert to mutex lock to permit sleeping using brightness_set_blocking().
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
