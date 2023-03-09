Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3626B25B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjCINnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCINnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:43:25 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3452A26F;
        Thu,  9 Mar 2023 05:43:23 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a32so1854024ljr.9;
        Thu, 09 Mar 2023 05:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678369402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSqyTtkVH//KFU0TvvADWxO4DxoXwsXcefBj8prULwk=;
        b=Rg9e0ZTSfWUMkYwoF2kMwo5b/FUW49IluCkbpuoL32e4KVBuZzUryUVgNvrZUDbRWn
         AO1gOp0y+Nc62zl6DFmejSz3RsEC7B8qtmBMUsb8RkuI678m5l8XwCLj0i1o9qWqhXLu
         WvtcVzbG7ibOtn+9XkgzUP7nOh0TZ7JqgnGw4dLaBU4cxoEn5ZVz67JN0/QujQ8+iC5V
         piKE+mE7bKxCcq9ceflgFQuOUGrHdQNEvsPXQqkxWkP38eCfhyn4+SCsTSqlRAIhRFrb
         4njb+eOgG5c0nTOnppUQDm02DbKZ03Di7rBLtPY9e/oqrBTdRGwdCrEpAu34pZShxLZz
         G0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSqyTtkVH//KFU0TvvADWxO4DxoXwsXcefBj8prULwk=;
        b=L04VmJae2zp32zptLVeN7peFhz4b0QeYzbVnkn3UalkbfH7EYB3sJLehqCO7n8x18W
         3ZJylfhXHIW7uWPtquVwVjpln9DknqdDyWTSGFiAX2ENoTCLscIf6KjPjok+CApWBkYo
         4MY5Wcn/Q6yUsNea4JYHcrU4LOVyX/yTSbaQ/wY4Y6ztOFGaf8EolhxQkSZfSF5W9bz4
         nQZuZMz6SXmM7tUZ1ulTJ3PdQMl+GVs6H9Ja1JbOE05gf+hYYKDdLdZQ6cDhPU+M50C3
         G5EcgN9bVq6SF7fKo8C+sRa1wfBmArtT75U69199HTb/7sPG3AI7ydKsM6PcuJpN/aOq
         6djw==
X-Gm-Message-State: AO0yUKWXvDvN/aNQSa4OfnQSdFS9fZKFhZHRv+45Sr9DX2RilN2OTs7g
        Aer/sORxn307eQ9fo7QxJKI=
X-Google-Smtp-Source: AK7set9EZi1/9oSWSns4aJm+/MqyF+TF0ys0Zilv4PWZXPArUgyBwZuuJ5cZ3TAaciBXP8vdxniQYg==
X-Received: by 2002:a05:651c:301:b0:295:9d32:a195 with SMTP id a1-20020a05651c030100b002959d32a195mr5656804ljp.32.1678369401843;
        Thu, 09 Mar 2023 05:43:21 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id t8-20020a2e9d08000000b00295a3a64816sm2966518lji.2.2023.03.09.05.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:43:21 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Mar 2023 14:43:18 +0100
To:     Theodore Ts'o <tytso@mit.edu>, Lukas Czerner <lczerner@redhat.com>
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
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH 09/13] ext4/super: Rename kfree_rcu() to
 kfree_rcu_mightsleep()
Message-ID: <ZAnidvBE8tL69qfy@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-10-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201150815.409582-10-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The kfree_rcu()'s single argument name is deprecated therefore
> rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> underline that it is for sleepable contexts.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>
Could you please add you reviwed-by or Acked-by tags so we can bring
our series with renaming for the next merge window?

Thanks!

--
Uladzislau Rezki
