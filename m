Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD06A158F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBXDlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBXDla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:41:30 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6DF5E856
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:41:03 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DE7823C1128;
        Fri, 24 Feb 2023 03:40:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 708FB3C0FB1;
        Fri, 24 Feb 2023 03:40:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677210058; a=rsa-sha256;
        cv=none;
        b=7K9FRdsL1j7Q5dxfoglNLIQ4xAR09umfX4hbIYJjboypmNTQuhVImxRCTkNGPrcOQccoRk
        PKXaXyeUUImOsPCKgU+1Ef/p5WujBWeChbXkYrDn+PIlUB5HhbP9BawgFr4jqS9bYBgpt/
        LGSVxbpDXPSCDz+VbInY4W6vo0WptuXSW6C4m15ZsyWST6yJhQmcaJ63YUTvM2I+o/bDoJ
        w2fKNEI+y6whXYyp+PWBCHBVPicb8mVwcCKaSB88vkPnhj4fOlkSu/1scG+VCu8yAkt3Vu
        ob0zrPOhriDyVdGhPh9GTyyGO+NSKr2tO4tRgOdt/f2Za89VL0f3Wwqm3xPyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677210058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=A/TcfuTIihl3awh1wSRTFZGbGWLlOvW7TyeWtEiw3cU=;
        b=r/fA4KFRIJTTVHPKUT6yD3inuGkz1LOJgTfKoMhTn/uYRv+ddb6KyE467Qmh3YquWwvhl7
        uzqs0g6/XJ4nCyLrL8X84Qto+ThTtidjlXhtjdsxfPwfZM17DCzGvMUiwC4Ryh0g72NaIC
        2BUUT8SaRlwU/ptpcdf9OPpukimbO57N/mNPpvt5hK5m6nhvO8CSvqY7L4fAjbdsYp09Dp
        JzeSzMIeYOzOWyaiSnbyQjAaZhtKCi5GQ9zDA82b96+1JjRFnBN1ku9rVHL7cAixIDbfJl
        OGSWE3YQe4plwD3ak2nprHskMBIn5o1PGhqbaVdFWrrb+G8EVtlJwdQpYgvJqA==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-ll7r5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Bubble: 14de97c3378113d9_1677210058715_2094943583
X-MC-Loop-Signature: 1677210058715:3913963233
X-MC-Ingress-Time: 1677210058715
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.37 (trex/6.7.1);
        Fri, 24 Feb 2023 03:40:58 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4PNFzY6YQXz1L;
        Thu, 23 Feb 2023 19:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677210058;
        bh=A/TcfuTIihl3awh1wSRTFZGbGWLlOvW7TyeWtEiw3cU=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=YWad8tIZpmwYHkhm2zXuUvNnWRsNw3zvktVRA6CPXhTWaYH4obcKdDkZgFCCvPRDS
         q9xGQBw5ax9UUeWVezD2cuQSDneDq96jlC/E8OdUKMHSC8/HFyRDNJvyhw92ttM1DV
         tyqQYfmy8dGHZNfINZy2ObcKC1lv3SGZu38IwRCN199BgF5jF+ks4p5Nl/GDzZNQxm
         aIW/iRJzwcaRIgZXX8nrgUAo5oks19NWoUHh8xCGeUaZCQbqrs1gf7VcvXNXkzCB4H
         MC+cIymQV/Lk8uPRaDTVwkQ0IIOjzQuSRtCGvviscqO4vFB2c/hKUiWWBlJzWoJ9by
         jDBnfyf0CVy6Q==
Date:   Thu, 23 Feb 2023 19:12:32 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Message-ID: <20230224031232.mivsss3ofifbagsb@offworld>
References: <20230224012035.2693610-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230224012035.2693610-1-qiang1.zhang@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023, Zqiang wrote:

>In PREEMPT_RT kernels, both spin_lock() and spin_lock_irq() are converted
>to sleepable rt_spin_lock().  This means that the interrupt related suffix
>for spin_lock/unlock(_irq, irqsave/irqrestore) do not affect the CPU's
>interrupt state. This commit therefore adds raw spin-lock torture tests.
>This in turn permits pure spin locks to be tested in PREEMPT_RT kernels.
>
>Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
>Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
