Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669566B25D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjCINtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCINsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:48:20 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC06A4A;
        Thu,  9 Mar 2023 05:48:18 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i28so2406368lfv.0;
        Thu, 09 Mar 2023 05:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678369697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6OGN98Yt7Z0hrSJIKuZZabeELhtpRYvOhGbBz2/84I=;
        b=qltBbjjEexCUaZrP2Ecdcp2/zqNfoacyKxqBIp/lwGeFQbjksN+W+9q5VSrSdrP8BJ
         aN8Z1Z+L8BQhwEQ/WpAQSGQ9W8WFvu7vKoepWZbJ7TtS6rZPOQMxj94mwv68IFIZ2dkY
         Ib2O1w7PE6OXAsAKpBODGjpIjMYg/f4iKs5GM19B8cpVtkXQNvzD/lwd+uq0UD5Bqbmg
         jZjO61kcnY39k/8LDNOAWSUMOetJ9YxJ+9s8vxEZyjC6hDupDn+2pIVhG80DtIyxK0mI
         2jSHNEuvs/TZUlGvShI6yw/WYR5t/49H3+Rwjx/260KNyQjBrfru8JB+C3Vkt7W0NJaB
         c8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6OGN98Yt7Z0hrSJIKuZZabeELhtpRYvOhGbBz2/84I=;
        b=Cx5AqwIMEc7S2Can24BLsEwt975sLCJrydZ2/1U0TkIA1oS4shypTwkXlH8//nySdL
         aEQb5T/r3ViYR2eYH+Q5kOvVscevcxzGWUmAHLQTI/QgogMumKM2jw43mLyRJEeyOfGL
         cewgwfMvWVT6mgWAwK8+fT4ITYyZHsHDZSGxx6nMgi9nAJTMjyyLAjLmHfS4L00DiGJ7
         hSA+ek+uxXl7M8B1MYx0ys2n108r6FDkttT2RZE6vk2M/ZROfTGrtnnv2IKrZOsoXqg1
         oSvl/d9qgT41M2Pa8DXB/aMBUivAAxQMYLntlx0M00+qWFcwoPz1uX2Z3BZvxhq2sL/o
         oa2A==
X-Gm-Message-State: AO0yUKUFW4Sa6GSpsx2SBzuJQLiCo6zt6qP0hFO/X7DBSPh2nQTTZfy1
        5AY0lMuHz2R1fMk63NaW17s=
X-Google-Smtp-Source: AK7set/nFRQzhATlw91whzLbUm6oXWTG5eIPQdImbEtBB0cNEGnGwRDfQhoJbZL11dl2nJyGgMABLw==
X-Received: by 2002:ac2:5965:0:b0:4a4:68b8:f4f1 with SMTP id h5-20020ac25965000000b004a468b8f4f1mr5953697lfp.55.1678369696844;
        Thu, 09 Mar 2023 05:48:16 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id i22-20020a056512007600b004cb08ec4c30sm2664545lfo.99.2023.03.09.05.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:48:16 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Mar 2023 14:48:13 +0100
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 07/13] RDMA/rxe: Rename kfree_rcu() to
 kfree_rcu_mightsleep()
Message-ID: <ZAnjnRC1wY3RIFhM@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-8-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201150815.409582-8-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:08:13PM +0100, Uladzislau Rezki (Sony) wrote:
> The kfree_rcu()'s single argument name is deprecated therefore
> rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> underline that it is for sleepable contexts.
> 
> Please check the RXE driver in a way that a single argument can
> be used. Briefly looking at it and rcu_head should be embed to
> free an obj over RCU-core. The context might be atomic.
> 
> Cc: Bob Pearson <rpearsonhpe@gmail.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Could you please add you reviwed-by or Acked-by tags so we can bring
our series with renaming for the next merge window?

Thanks!

--
Uladzislau Rezki


