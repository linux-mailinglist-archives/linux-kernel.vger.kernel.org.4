Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24A72117B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjFCSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFCSIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:08:31 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D092132
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 11:08:28 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3EED7820DBD;
        Sat,  3 Jun 2023 18:08:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a268.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A29DB820D2F;
        Sat,  3 Jun 2023 18:08:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1685815706; a=rsa-sha256;
        cv=none;
        b=mqiBEqoLdgQSfFAH9HGsvYvoYsGU4qCpqLa7QLF+UneX5Py6UKFYUEuvvSZmXdG7iP/xFW
        08fmhhXnkp0xsho3R1r+3bzpuE7PhceO4JiJbB1ya6VqbSK+EtYm0bZpw/vUwlYhFni68Z
        1XaLvChPjsL2bXsSJeUr7rpMSC+V9IS8C9oWpOBlqBOx9o7D+qDN0YSNRQOVFg5fm5LK6Y
        v5gtg0Y+soZTjc+Mexs1WRF9inff15tAXfsqlclkY470BQVBpxI/Q6rSP2Ovl0MhIxmCfN
        a/QJfJI+dImuYOrjZdFO6mbhRwV3xyoYs4PbQe5T9W6OO/GJQDZrJ+ik8sGXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1685815706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=edsV1yfGqFjC4oidIwYZYQtUalRFvmfjBeoSyFbKiFs=;
        b=B4UyH0OcAj2BLrPG4w6Hkp/1V8+sU1Tkpd2V5RILYST9QI3qri0kDJ2hxOgmq0XTRWWNuJ
        pOmPXBASlFpCxxT8hn+7v8J/IIFbGvZPOhuQIRPn/PTKYaht4ok3t2+CBHkiQan84J+fPJ
        oQC8Bfz10tGHIUDyMAOIkJ8dyjznimXR48NUToBbqLtBGn1Fg6eLmHWpL6kE2qdHDDb6EL
        YUQ/t+MprjRDft1mN5eUOZgEmz9Mzf+R1UNlIYou0RqHsxzR2ftPNff3F9WzomatSUjQbm
        +uOqdtB8BB0/qCy+h4NxZbi1CDGnA6+htPDb+5iuXbhaH1e2Ke6ItB5bsZAFcQ==
ARC-Authentication-Results: i=1;
        rspamd-5f966895c-mxj6h;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Juvenile: 67d3880475b78c39_1685815707049_473911325
X-MC-Loop-Signature: 1685815707049:1656340810
X-MC-Ingress-Time: 1685815707049
Received: from pdx1-sub0-mail-a268.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.229 (trex/6.8.1);
        Sat, 03 Jun 2023 18:08:27 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a268.dreamhost.com (Postfix) with ESMTPSA id 4QYSXn5zk3z2p;
        Sat,  3 Jun 2023 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1685815706;
        bh=edsV1yfGqFjC4oidIwYZYQtUalRFvmfjBeoSyFbKiFs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Yd8T0hZS6rdOv1n4oPbiyI4EemMWfjrkJ1flOLco/mKWuxNy9BsZ43usrwJZ8quI5
         ZLkmuLfL/Bj3DYXJ1+FP4fJ4QpJXe8ztSVCCifzY9c17UyMKwlOkmbOoMc+mkqEX2E
         UtkfzCxMGv47wPgQpyFT9AQ2dVvBJp1nzCGWfNtO7yfH1bZHpDE7r4Ld1x0meo3rgf
         JsfpKb+StEM8DeqLmcm7yq9QRVvB2ZIVXfjUfJvLCjtXCf7hLNmrXHRdD8Rr+SLfLd
         OM+Y+DHMyJYFzHGW6RncCEO5p15DfE/zQJYuR4B2d2vvuFidClKEbzQFM6umpKjWz3
         RyHjMz7xRlR9A==
Date:   Sat, 3 Jun 2023 10:34:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] torture: Add lock_torture_writer_fifo module param
Message-ID: <zzteweboj3hmif5akuxxokyvu6truhy3ygh6w5nwb26zxjlqgs@uqzxhzx3eim7>
References: <20230602220221.600774-1-jstultz@google.com>
 <20230602220221.600774-2-jstultz@google.com>
 <c2415658-de0e-4497-889a-d5401cbc134a@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c2415658-de0e-4497-889a-d5401cbc134a@paulmck-laptop>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Jun 2023, Paul E. McKenney wrote:

>On Fri, Jun 02, 2023 at 10:02:10PM +0000, John Stultz wrote:
>> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>
>> Modifies locktorture writer to run as RT task.
>>
>> To use it:
>> insmod /lib/modules/torture.ko random_shuffle=1 lock_torture_writer_fifo=1
>>                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> insmod /lib/modules/locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3
>>
>> This patch has been helpful to uncover issues with the proxy-execution
>> seires.
>>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: kernel-team@android.com
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> [jstultz: Include header change to build, reword commit message]
>> Signed-off-by: John Stultz <jstultz@google.com>
>
>Queued and pushed, thank you all!

Both look good to me. Feel free to add my:

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
