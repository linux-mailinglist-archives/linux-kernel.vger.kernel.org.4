Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BCB61DA7C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 13:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKEMvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 08:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 08:51:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D4D26498;
        Sat,  5 Nov 2022 05:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6CF42CE0908;
        Sat,  5 Nov 2022 12:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5E5C433C1;
        Sat,  5 Nov 2022 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667652699;
        bh=wJ53NrXtBVlvwsCD+pq4vqfXgC66XQxI0vOJmFMQkkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lgAg44TQ0kR3Jr6AXQ1mdrWI9DSASKddyzx0h2/ruf7K9mlcu2sNE4rGumt4uoW/V
         7G02QEXY2FDdUO4h+M3+9WWmkLmrtOCzbHDkgwJB8nXnG+FZpun9rqTNF5ZS/VyWuy
         e5+CW5QHboAaDPs3L+3SWFywuVX58Y6iWdvPRxG7vZuAM5RL51/n1uiDWrAvmFkhrg
         wedI8s7XEHt3WHpycfHeoF0Fut9T7ojVode5HBxt+cDkhYkTl/d2wSo8oLj7UkpOFW
         m5Sj6ZcEuPqZ3nXwLMfoSdhk2rcO64t3jGcDoTSsPaQAf2ms0b6+vxqj3lgHRvG2V7
         eNdFVDHC6RMUw==
Date:   Sat, 5 Nov 2022 12:51:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     coverity-bot <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: mlx90632_probe(): Error handling issues
Message-ID: <20221105125131.04710178@jic23-huawei>
In-Reply-To: <202211041235.FB1AF7F6F@keescook>
References: <202211041235.FB1AF7F6F@keescook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 12:35:22 -0700
coverity-bot <keescook@chromium.org> wrote:

> Hello!
> 
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221104 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
> 
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
> 
>   Thu Nov 3 21:42:26 2022 +0000
>     c83d3e5ca97f ("iio: temperature: mlx90632 Add runtime powermanagement modes")
> 
> Coverity reported the following:
> 
> *** CID 1527134:  Error handling issues  (CHECKED_RETURN)
> drivers/iio/temperature/mlx90632.c:1270 in mlx90632_probe()
> 1264     	mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
> 1265     	mlx90632->interaction_ts = jiffies; /* Set initial value */
> 1266
> 1267     	pm_runtime_get_noresume(&client->dev);
> 1268     	pm_runtime_set_active(&client->dev);
> 1269
> vvv     CID 1527134:  Error handling issues  (CHECKED_RETURN)
> vvv     Calling "devm_pm_runtime_enable" without checking return value (as is done elsewhere 21 out of 24 times).
> 1270     	devm_pm_runtime_enable(&client->dev);
> 1271     	pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
> 1272     	pm_runtime_use_autosuspend(&client->dev);
> 1273     	pm_runtime_put_autosuspend(&client->dev);
> 1274
> 1275     	return devm_iio_device_register(&client->dev, indio_dev);
> 
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527134 ("Error handling issues")
> Fixes: c83d3e5ca97f ("iio: temperature: mlx90632 Add runtime powermanagement modes")
> 
> Thanks for your attention!
> 

I'll post a fix shortly.  Looks like a simple
ret = devm_pm_runtime_enable()...
if (ret)
	return ret;

will be enough here.

Also turns out there is a missing static marking related to the pm support. I'll fix
that too.  Not sure why I didn't get a 0-day report for that.  


Thanks,

Jonathan
