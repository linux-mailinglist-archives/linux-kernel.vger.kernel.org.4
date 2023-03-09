Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942486B25DD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjCINvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjCINvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:51:08 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69EDDB6F7;
        Thu,  9 Mar 2023 05:49:47 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a32so1874099ljr.9;
        Thu, 09 Mar 2023 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678369781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H87ub/+VWwfxayqJFMh8X8yTlGNaMEeVvnZCDbCbXiw=;
        b=NN2C2tku3JvppywjX9WmE6WVvUuXbUlokf2RhduAJb2lCIz/HeoTNQbVq3rt2vuepC
         RqZISBn5quAlZFl3apUWJ7fs8ZynyD+QsLgZa+/dJK7aJQC3D9wUgQrzwH+LzQpSWQ4z
         qjiAK8ZR38qz0lx+XI+krMGuuuZY8GsI7k/yZCKDygXolUT3ENBgxYW57SmVx+LJ/cUo
         A0k0Cc8/j6vqPx8MdYAlcrpOEJx1VgcdC/4txP8pDteHIstdw+WauT2EghX/HHe/xejk
         q+zKyxYJ3RraGQvoBzaHG7DLDBQQyeFHmRIhVMbwNuRWLX+w7mS0+LJsakUHZCWz3NCA
         qgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H87ub/+VWwfxayqJFMh8X8yTlGNaMEeVvnZCDbCbXiw=;
        b=6PP67gcxK+Iw9BW6wf+I7nWg3EtOp3BVJSL/mNXNJr35XZ4YBUCbiYU0+ww5LU8W7b
         Z52g0Dswxx25vs8sP82sL6hjmVBO3kqQpE2VwbI4qSaM3B0q2U+QmcIcIyYE15LiPyHf
         MXTFAWRSyjqaBtQOFbjapgpsKjel4fRADWyUfqTIn/SGKPWAzk/3WAHbAlCOCRG+VAyc
         3Eq1MymJH8Fv1JpNqBBKSkgpCnOJ3/Dg+9vKqXW8b6upNU3tMUMlSTuBpxZASZUQ4/Es
         /km1hPUMI1K+KVwc1hPiTyNM1w71lg2EvTwcN+rnW6jLY4b+LgInU9t4xGdet8cwXnyC
         WtZg==
X-Gm-Message-State: AO0yUKUBXl+NVBF3el/qPzfhSvQ/npFwvqnu5+cRM9iVb34rNZflzatu
        JKIZpP0rTzdgN8HcbCRMXBU=
X-Google-Smtp-Source: AK7set9FKg99NdgLRDemEXBeo3W7bnPXBocthd8sCaFpFTXSlCjvgVntnioj3X4ua8yiFwHB4/GCCg==
X-Received: by 2002:a05:651c:211:b0:295:c51e:18ab with SMTP id y17-20020a05651c021100b00295c51e18abmr6482122ljn.37.1678369781113;
        Thu, 09 Mar 2023 05:49:41 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id f6-20020a2ea0c6000000b002959d2cc975sm2959141ljm.37.2023.03.09.05.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:49:40 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Mar 2023 14:49:38 +0100
To:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
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
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 06/13] net/sysctl: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <ZAnj8o38Pjjwez9j@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-7-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201150815.409582-7-urezki@gmail.com>
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
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  net/core/sysctl_net_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Could you please add you reviwed-by or Acked-by tags so we can bring
our series with renaming for the next merge window?

Thanks!

--
Uladzislau Rezki
