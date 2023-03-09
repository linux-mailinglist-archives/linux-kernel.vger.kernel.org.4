Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0CE6B2598
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCINjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCINjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:39:10 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411F0EBDA8;
        Thu,  9 Mar 2023 05:39:09 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h9so1866766ljq.2;
        Thu, 09 Mar 2023 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678369147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jj+nAMhd294m4r8r3v4RfFoTZThpiv0zLQAEtOcyNM=;
        b=fKqDIH7zpxyLe65casyn1uInN7KRShTKhjeW4kwUiVzB0ITu528S3IM5DI2Vwegvkp
         Pr961K2dqYNJ7V5k9T4KgAI9mnvDrUD0LxTT8l76IvDvsFHdi7Jd0l0rCx3AsLKO2Fu7
         x9Kw1xZWsNVrYYoHluz6/bM+IVMvqwMSz710+uAiEw/q7krFUFrJs1yDW7lP+tfceQRn
         4hdXTdIunCsqIQl6vPe86wCMTORk4A2ZqnnqMQ8ERpnfA8TIpPIeFSVc94LhjRO1zvUV
         IEVte9mWn1SE50r66ZekI/ydOsj3SVmLqc3tylkxE/83VgyWh9CKAn1M0DlUj4Cm1geP
         qMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jj+nAMhd294m4r8r3v4RfFoTZThpiv0zLQAEtOcyNM=;
        b=AWB8GhuPKVkitI7vynzFGg0nkbHIVQXWsFIFUh1F2D7BmBVUhIaPBV0yVnLeq7C/P9
         2Me/wl2zYWSO29YbLg8EwO/093949XFU1VS00f8aArQcRYM6yv56C/UAt8J717Uj8TST
         md9isPTiS4m/R+rmFh1B6iyGWEGPIB9qbR8NrXkTNSTQPxxXEIqOKlqmh+lMYbhMnYho
         MXgHJfzhiKgDYlEoRm1i37UcFN7R88uhoqIRYfenmMsZm0cniQdCF2eUtWg5QIR7K2Sl
         gxCxysIFHRiJy42rhNBialRIrihGnW/vD5MgptIPxglMK4FXXFEDGSdn9m9CFeLY2XkE
         n/hQ==
X-Gm-Message-State: AO0yUKUf3NrHUX5+iS8JRfJ6oBqCVdr4KDc29Nvfdd2WSCAuBRPdAti6
        Olc5USFrmwqZxyUTtwVzeGA=
X-Google-Smtp-Source: AK7set+L7wznDfgi2YEU2HN8+J9m6CEQp02DLJhTAmpZLt3y9KKXjBDBITbRor6/8lFNEZg3NP+7Yg==
X-Received: by 2002:a2e:b0e2:0:b0:295:d31b:59d1 with SMTP id h2-20020a2eb0e2000000b00295d31b59d1mr6467837ljl.13.1678369147348;
        Thu, 09 Mar 2023 05:39:07 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id x19-20020a2e7c13000000b002946fb5b50asm2943465ljc.139.2023.03.09.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:39:07 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Mar 2023 14:39:04 +0100
To:     Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: Re: [PATCH 02/13] drbd: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <ZAnheG1zDQUe9NJu@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201150815.409582-3-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The kvfree_rcu()'s single argument name is deprecated therefore
> rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
> underline that it is for sleepable contexts.
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  drivers/block/drbd/drbd_nl.c       | 6 +++---
>  drivers/block/drbd/drbd_receiver.c | 4 ++--
>  drivers/block/drbd/drbd_state.c    | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
Could you please add you reviwed-by or Acked-by tags so we can bring
our series with renaming for the next merge window?

Thanks!

--
Uladzislau Rezki
