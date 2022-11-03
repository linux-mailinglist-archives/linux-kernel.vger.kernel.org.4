Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62621617D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiKCMya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCMy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:54:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9048621AC;
        Thu,  3 Nov 2022 05:54:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so4975150ejc.4;
        Thu, 03 Nov 2022 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=miU7g+NHsqyy3M5Aizo1RDgHrGlyDeZ8d0dqj7GSP7M=;
        b=a7wsjvvTsvH25LtX4RmJDXCuYMvNHNc1HQrKl7k3C6hyn8xmpRgILgE8yx4CoSqAUn
         W19ViAYWy3h891EtWYXagzBsyuUtPbWpaCrPMASMn4yxYKojTc6woqAfLC8dG769C8qe
         hnEMRf+Ca/3YCPF4Exf6uF/EKg8mkM0f1+A5PQv7qczx8uWy+lFd6mSZxY59J+82A0NR
         CYeH5PCiAeW2lzJcwGzPCgfbw8EDR6zWm/L6XMKzgoBTajYZfJdziv11zNFyTaYaJCMn
         ckWI4RXTrsgCLu4K0I8osxP/tdoqSf3hRV+Kgfs3TtC1eAwi9ZeBIsquVfAqtp49amqN
         23TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miU7g+NHsqyy3M5Aizo1RDgHrGlyDeZ8d0dqj7GSP7M=;
        b=Dii4mVh3IDRV7Gi91SJ6Aa4VRNCajGlsLG4UfMBOQPv4zihp9xgU6xGVcCqheyaH6L
         inITrx8iNXM4SaUd5QxQr2EA3mxyhZoDnK2fX5iah1PzcnnDGTYg6ajkYRqlFQTbR/1X
         8pyQf41aU6YAPOKTzTW010kNeVYwpYp59RVRgNcXv0iJtqdz0EGxu7LqGo0MdYwUFGuV
         ljoqdKISX8HECUKlvXauXvD8+ibaua+yTLoUaWcvYmxcBPrhYJBPnrHy3C7Jo+jjFdzZ
         EFXjjK9tJ6oVzSX82w1OPl7v0W7hRpzDao1B+3FUud+D5hJhJX7fPKy58RVlxHKBSmzm
         yzog==
X-Gm-Message-State: ACrzQf165FFvRfhht8xerLnDY8953ebxSQfydJSPE3q+gYfVlEWow2xX
        X8JtkvIp6ns4kYiW7wQtOdY=
X-Google-Smtp-Source: AMsMyM7eCB2nRzQ45l0ieqT3T8XwayR0GLihEHpuuYZng0MTL+hs340ezErW5Cagm4a3azvmnlNxWg==
X-Received: by 2002:a17:907:8a09:b0:7ad:adff:ddf6 with SMTP id sc9-20020a1709078a0900b007adadffddf6mr29738309ejc.320.1667480066107;
        Thu, 03 Nov 2022 05:54:26 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o25-20020a170906769900b0078194737761sm453998ejm.124.2022.11.03.05.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:54:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 3 Nov 2022 13:54:23 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2O5/3vPoWILRj10@pc638.lan>
References: <20221029132856.3752018-1-joel@joelfernandes.org>
 <Y2JkoVV3jaVS4y0Q@pc636>
 <CAEXW_YRZO086TUJCFzuGpAWRpQ-uKD1S5wDipJ9hR9=XddNFSw@mail.gmail.com>
 <20221102163544.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <Y2KnxKDebPKiqTFZ@pc636>
 <CAEXW_YRquk15oGMCrYXLTKWtMzfPJhEJpjENM_rqt4qjwtAt+g@mail.gmail.com>
 <Y2K3jFv12yKJIAYP@pc638.lan>
 <CAEXW_YQWYfJPpeXoV0ZDGC7Kd585LJ+h2YbKfB3unDDZinxTRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQWYfJPpeXoV0ZDGC7Kd585LJ+h2YbKfB3unDDZinxTRQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Nice, I am happy you worked on it. A comment bellow:
> 
> Below what i have came up with to switch for polling APIs:
> >
> > From 799ce1653d159ef3d35f34a284f738c2c267c75f Mon Sep 17 00:00:00 2001
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Date: Wed, 2 Nov 2022 19:26:27 +0100
> > Subject: [PATCH 1/1] rcu: kvfree_rcu: Reduce a memory footptint by using
> >  polling APIs
> >
> > Total time taken by all kfree'ers: 6564718459 ns, loops: 10000, batches:
> > 1110, memory footprint: 5057MB
> > Total time taken by all kfree'ers: 8431051895 ns, loops: 10000, batches:
> > 1109, memory footprint: 2749MB
> > Total time taken by all kfree'ers: 9477830789 ns, loops: 10000, batches:
> > 1158, memory footprint: 2934MB
> > Total time taken by all kfree'ers: 9950211144 ns, loops: 10000, batches:
> > 981, memory footprint: 2704MB
> >
> > with a patch:
> 
> 
> >
> > Total time taken by all kfree'ers: 7712110118 ns, loops: 10000, batches:
> > 1660, memory footprint: 91MB
> > Total time taken by all kfree'ers: 7002403664 ns, loops: 10000, batches:
> > 1482, memory footprint: 86MB
> > Total time taken by all kfree'ers: 7842282319 ns, loops: 10000, batches:
> > 1738, memory footprint: 86MB
> > Total time taken by all kfree'ers: 7230161977 ns, loops: 10000, batches:
> > 1542, memory footprint: 72MB
> >
> > Tested with NOCB option, all offloading CPUs:
> 
> 
> > kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
> >   --kconfig CONFIG_NR_CPUS=64 \
> >   --kconfig CONFIG_RCU_NOCB_CPU=y \
> >   --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
> >   --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 \
> >   rcuscale.holdoff=20 rcuscale.kfree_loops=10000
> > torture.disable_onoff_at_boot" --trust-make
> >
> > According to data there is a big gain in memory footprint with a patch.
> > It is because of call_rcu() and call_rcu_flush() take more effort and
> > time to queue a callback and then wait for a gp.
> 
> 
> >
> > With polling API:
> >   a) we do not need to queue any callback;
> >   b) we might not even need wait for a GP completion.
> >
> 
> Wow, I did not expect an extra grace period or 2 to cause so much memory
> unreclaimed.
> 
> Does this kernel have the 5 second timeout change?
> 
Yes. But it does not matter. Why? Because 5 second time out happens only
when a system lightly loaded. It can be 10 or 100 seconds.

Once a flood is detected we start to offload back-logged memory.

>
> If yes, then I am confused why extra grace period matters for memory. My
> goal with the idea was to avoid pointless RCU work when we don’t need it.
> But I can’t complaint.
> 
This patch does the same. It avoids of using any call_rcu() because we
do not need it. I mean extra layer.

Why it matters for the memory. I explained it in previous answer. But it
is because of extra layer. Since it is a flood scenario such delays can
lead to higher memory footprint.

The test easily detects it.

>
> Or is it that this test floods the pointer page so we do not wait full 5
> seconds, and benefit when we reclaim sooner with polled API, than waiting
> for grace periods?
> 
Right. Reclaim sooner with polling API.

--
Uladzislau Rezki
