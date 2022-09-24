Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C05E8E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiIXQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:32:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B625F1;
        Sat, 24 Sep 2022 09:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A95D6CE0988;
        Sat, 24 Sep 2022 16:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F35C433D6;
        Sat, 24 Sep 2022 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664037134;
        bh=PahxIU04ESTvZiacu5ZryDA08VTAB+qNsD1TEfobxFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VrjKKYBwxOWf78kLDaosBH9cNw3y9yGFkYgYR17EVIMBPiVK2dnujkEmI+7fqyfWw
         hwzVlYqR51f8FuarsYqBZ35kcXHeA5jglk2bbdP4rbdJrNG+40JlHK+CUYDhzxxsKv
         rblGLi0X66Y0w0MEXVIwyCX+8kBXOvi/Mq9p/pXABabAekjP5zxGffAJ9ADtdBYnuD
         0gNLq+EFs3kNw5rOFw6TTAUfJ2U1iacPKnN+XAcL7ijJXHpOwU98jcAQ3rxzc5lIFc
         LIyhrNmMbAFuzGJRk68oY+iD2AmEjLrclU7Wgmn6g2hC7y3Ctxl0BD50+3JdXqV6ib
         51nvtDlUwYO3w==
Date:   Sat, 24 Sep 2022 17:32:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 0/3] iio: temperature: mlx90632: Add powermanagement
Message-ID: <20220924173221.1174608b@jic23-huawei>
In-Reply-To: <cover.1663834141.git.cmo@melexis.com>
References: <cover.1663834141.git.cmo@melexis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 10:13:21 +0200
cmo@melexis.com wrote:

> From: Crt Mori <cmo@melexis.com>
> 
> As discussed previously on the group under the
> "Controlling device power management from terminal" thread the mlx90632
> sensor provides measurement capabilities under sleep_step mode. This
> series runtime suspends the unused chip to sleep step mode to save power
> but in case of continuous sequential reading it switches to continuous
> mode for faster readouts. This value is hardcoded to
> MLX90632_MEAS_MAX_TIME (with some buffer) and not user configurable.
> 
> The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
> hardcoded to 3 times as much as MEAS_MAX_TIME.
> 
Hi Crt,

Applied. However, we are cutting it very tight for the coming merge window
so I'm not sure I'll get a 3rd pull request out (this just missed the 2nd
one as I only queued up material that was in a final state last weekend)
So for now pushed out as testing and we'll see if Linus hints at an rc8
when he releases rc7 tomorrow.  If not this will be 6.2 material now.

Thanks,

Jonathan


> Changes in v6:
> 
>  - Revert changes to the suspend to prevent power mode regression
> 
> Changes in v5 (per review comments from Jonathan Cameron):
> 
>  - Migrate to devm also for driver removal, along with putting it to low
>    power mode
> 
> Changes in v4 (per review comments from Jonathan Cameron):
> 
>  - Migrate back to devm_pm_runtime_enable and remove the pm_disable function
>  - Remove pm stuff from remove and also sleep, since when iio device is
>    not registered also sleep makes no sense.
>  - Replace use EOPNOTSUPP as per checkpatch suggestion although some drivers
>    still use ENOTSUPP.
>  - Change the style of read frequency
> 
> Changes in v3 (per review comments from Jonathan Cameron):
> 
>  - Change the "available" attribute presentation to more recent way
>    suggested
>  - Replace devm_pm_runtime_enable with enable and devm_add_action_or_reset
>  - When suspending device also put it to lower power mode in case there is
>    dummy regulator
>  - Use more switch cases instead of if/else
> 
> Changes in v2:
> 
>  - apply review comments from Andy Shevchenko
> 
> Crt Mori (3):
>   iio: temperature: mlx90632 Add runtime powermanagement modes
>   iio: temperature: mlx90632 Read sampling frequency
>   iio: temperature: mlx90632 Change return value of sensor measurement
>     channel
> 
>  drivers/iio/temperature/mlx90632.c | 440 ++++++++++++++++++++++++-----
>  1 file changed, 369 insertions(+), 71 deletions(-)
> 

