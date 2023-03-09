Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7121A6B25B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCINpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCINpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:45:31 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADA65D76D;
        Thu,  9 Mar 2023 05:45:26 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id n2so2308869lfb.12;
        Thu, 09 Mar 2023 05:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678369525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKgvZLUlZuhxooxItJkocqXL7cPyMVL7JY/lQAfuAiE=;
        b=qS6HSkeLV80FkWz+Rb63KqQBO15xYBVc05JdKWTv8oVCO/KhEN3P52KUnJuewvmASe
         dsqz0uswMVv6+nZ5UL7SglBJvdmccv0o8VmjliNvSsdzQcyXpUqh6h6GDq43QoOFGpbq
         /76j3KeJ7n5Vl7IQjoCqApMrFrl2T11PDart32JvTZrkozb74ML/OIytV7FnPOK2Ij3o
         d2/98QrYLUddpoRu8vLW4MhuMlv+sSWuA836BxRoFpH72xsOTAtyN+2KiAT+P+6K2Eob
         Z4TfIlPcdk8EF1X57YYRSHH62o7iC1oCkx+VAcjHwkZHcXV8LvJG7YA5PcCDltmC1VLj
         NDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKgvZLUlZuhxooxItJkocqXL7cPyMVL7JY/lQAfuAiE=;
        b=gMuK78GIB5PnLYiuf2aub9+vlgzw535dpIs+K+HxXCcSifaaPAVA3k26eIrEr5lFuc
         Pp+87YMSdv4c2lbSggwLh6HtpetKT/VBpVE2q7dPIDGr3ki7hWRiHvb+hNXro+KBdJ45
         mxRU8sNhH/xUJ6Gu0M42/mj9eAC5dbeaUAMuj5nAgiVNstdP/Y8bOjo6JCAOcHV/AHpd
         6U4OR6Vf2AJiGzuIpz+ZluB8MKu5Rnih/cwus3ShsEjsAYypK1WBmLws7gepe/0uWtbf
         HU66tCv/CFRyAaDIfy+aHVdZiSwxzoQaFVpnGRErqPd4Mf5lYcWkA9jhP/mI/7cELC43
         DVrA==
X-Gm-Message-State: AO0yUKXqI4hjIh1riH0p/N5BSTTAw7f568AbAtAwyDf3P1aT/vETxvTB
        ABCWEFdbImfnDYvASp+VdfI=
X-Google-Smtp-Source: AK7set+oudKKexcg2ZnPUbedjmR/rPbyZ6Hr7ph/xkV7m4xghu7Jam/t0pyFWh3LmZtuLR7Bfn5bEQ==
X-Received: by 2002:ac2:5385:0:b0:4de:869f:687e with SMTP id g5-20020ac25385000000b004de869f687emr6859547lfh.42.1678369524957;
        Thu, 09 Mar 2023 05:45:24 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id x6-20020ac259c6000000b004cb1de3f487sm2660708lfn.104.2023.03.09.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:45:24 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Mar 2023 14:45:21 +0100
To:     Steven Rostedt <rostedt@goodmis.org>
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
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <ZAni8Q1NW9cWrvHJ@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201150815.409582-5-urezki@gmail.com>
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
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>
Could you please add you reviwed-by or Acked-by tags so we can bring
our series with renaming for the next merge window?

Thanks!

--
Uladzisslau Rezki
