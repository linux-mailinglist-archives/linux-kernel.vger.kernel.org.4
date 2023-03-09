Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552796B25AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCINmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjCINmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:42:02 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71670F16AD;
        Thu,  9 Mar 2023 05:41:51 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i28so2381724lfv.0;
        Thu, 09 Mar 2023 05:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678369309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vI6EqZn5OrU2uQAhBy8UoxoxXLM2CrgGfWuraPjDA/8=;
        b=aTVPGWnSKEHtUvMM9QNshpoPtC2kHuHAV842JT50UMOixZ4SjsgAGW2euh08FCKj4u
         P4WX/+/mX7Mysmwb9igEuqFvRZbL/a5cOkBMD8cHIyClsQCIets3JvnO4KucC09SPOV7
         +Rh1FAqIQcg7fzZvu5GfFBDKluZEzs5X4GZ3A48/jAW9yJgANLGp4nEjZVLeZAJt4dao
         l+MrA36X6bqoHQy7tVm3xK+u19i4+YZh5uiS2m7DGU/ZUDZrve3xuMr8yhrIjP4X0TE1
         ri+zPuLfKr8D3NEvJAhDGBI+ykiQpti4ql+6t1cK8vZsyzOuWgzgfPtOs6sY+pN0i521
         MhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI6EqZn5OrU2uQAhBy8UoxoxXLM2CrgGfWuraPjDA/8=;
        b=F7qPwHQMNFIGbwuBl7yjtYftiooChX2PyKH5wjRK2FSkui7A8sVTaid2epGpnmusdY
         9SB/rOClifIOn5c0Ck6zbrPJ25nx1wu+5aBx0Xjw95fE3sQ9/a+BLJqOJdgAvMuzz4wL
         XD6nkRmuYA7WqLWWnERJ16OAQOKqt7Cc/pYK0pWPTy7y38/Vjb38WD/YBIT6oCtIse+D
         awNbhi3XJiCYvyZa9Ma3P0O6TGs5KLi0DEekvxmo4sJm1+M0xU2BRZotewpTn42laKEf
         9lU56h8haNtoxytUp+xt9to9JY2VclEK6sEHwBNEu0sxx7h9E5enf11IQSsFwoK8Pe60
         W3vQ==
X-Gm-Message-State: AO0yUKWq4keia/2UiWhyr50C38Bg9YVK6YznkkDqfsWmaoAhW9ZorHHd
        obe/3EzXUH/nsvEOEgsT0s4=
X-Google-Smtp-Source: AK7set/ORtgYJR5itMKBdfkPWCgfMKPt3m5G75Sv0FX9qCqfgWlzPCyzpUHjG2f+EJ96ShsRYsgc6A==
X-Received: by 2002:ac2:4439:0:b0:4dc:7e7a:a72f with SMTP id w25-20020ac24439000000b004dc7e7aa72fmr6403317lfl.16.1678369309700;
        Thu, 09 Mar 2023 05:41:49 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id q14-20020a19a40e000000b004cb0dd2367fsm2661872lfc.308.2023.03.09.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:41:49 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Mar 2023 14:41:46 +0100
To:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>
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
        Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH 03/13] misc: vmw_vmci: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <ZAniGoy7wOEkGEBg@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-4-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201150815.409582-4-urezki@gmail.com>
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
> Cc: Bryan Tan <bryantan@vmware.com>
> Cc: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>
Could you please add you reviwed-by or Acked-by tags so we can bring
our series with renaming for the next merge window?

Thanks!

--
Uladzislau Rezki
