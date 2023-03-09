Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10D46B25C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCINrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjCINrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:47:19 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567E65D479;
        Thu,  9 Mar 2023 05:47:18 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id z5so1870190ljc.8;
        Thu, 09 Mar 2023 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678369636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKYdyCghNYdoyBXOgpg5ofmE3QV+ajZ50HuS4IU19N8=;
        b=gAMtP+LsJ1axe0618LDnbI7QcevWkknD9zrczOZzkHNCijB7J2DiusoIVp/JweHWdU
         PqYCD58irQHYfvmtgkW07JqUtoyqaq46gqSPkfuOArqaLUNVex05jgEz2dGrIt6GETcz
         rFNf4rDtY8oNHcd+KnB4S8JSLPwbnlD+82HveQJVXngA/yAK1EatdFe1c/sRarb80FPC
         oZGDvTk5csgj52Obb+Om3m6Q5ULDFxVZ5iUgX9rkHJ5VvrJqIEp5Es/PyHiP++QmnUqz
         p4dYr5WOB+6V9dM8h5zc974fC7YAob2z1A6TQEM9TmrgRPzwFnjozHpNWaMHOBGj2Rju
         ylSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKYdyCghNYdoyBXOgpg5ofmE3QV+ajZ50HuS4IU19N8=;
        b=lxdPn0MSPYgOpRhymtjXDKbD0zA5K4Bgo3Zl/+VL3wptel+bcQPoRJTKFavq623rFu
         VcZk0rjDQtECtrOZwqH3dG9kRtbt2n+xyj76JOqw5OroFasS/Ke1iSFrsQ5fLYVKb3i/
         WPilT2qR+J0ECzOZpPmnBS8vRGmgrTBjcaqqkmFlM1Zvdz3NakjIKMVmz2je/P0uG6I9
         rYk6bFUTNXB+NF6JCTTJNOwVhQjyFVnMtCOycrFt4cxJCGDoXwVNUdW+eVjnPuvaIHtL
         q2TBCyoSdKmm8AeC2GByywvOYAZPkUXOdWNAwo9wWOa2XwPvML6Wdqdeh+q1EQjAsRTq
         ZStA==
X-Gm-Message-State: AO0yUKXEvppeRhElY3G4BxI8LVDay/gRaWoJNXW8x/YdV+bit7oWYzy2
        b8tDyg/0g4JibD0pUSunBy2vEy7md7T+9Whm
X-Google-Smtp-Source: AK7set+O+XacSRTP1TuGlJYExW5QCBLCjGsNn+2uIVe8N+6v1PQoRqVTsf/P315mg1+FZQKZcHMoMQ==
X-Received: by 2002:a05:651c:1047:b0:295:a8fc:6ba4 with SMTP id x7-20020a05651c104700b00295a8fc6ba4mr6515884ljm.38.1678369636650;
        Thu, 09 Mar 2023 05:47:16 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id f18-20020a2ea0d2000000b00295a21c7954sm2953380ljm.50.2023.03.09.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:47:16 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Mar 2023 14:47:13 +0100
To:     Ariel Levkovich <lariel@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Vlad Buslov <vladbu@nvidia.com>
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
        Saeed Mahameed <saeedm@nvidia.com>,
        Vlad Buslov <vladbu@nvidia.com>
Subject: Re: [PATCH 08/13] net/mlx5: Rename kfree_rcu() to
 kfree_rcu_mightsleep()
Message-ID: <ZAnjYc0u7rjdmqFt@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-9-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201150815.409582-9-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:08:14PM +0100, Uladzislau Rezki (Sony) wrote:
> The kfree_rcu()'s single argument name is deprecated therefore
> rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> underline that it is for sleepable contexts.
> 
> Cc: Ariel Levkovich <lariel@nvidia.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Vlad Buslov <vladbu@nvidia.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c  | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
Could you please add you reviwed-by or Acked-by tags so we can bring
our series with renaming for the next merge window?

Thanks!

--
Uladzislau Rezki
