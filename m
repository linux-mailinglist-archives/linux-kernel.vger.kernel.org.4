Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A13678418
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjAWSGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjAWSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:06:08 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B911C30E90;
        Mon, 23 Jan 2023 10:05:36 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4FCF4921A45;
        Mon, 23 Jan 2023 17:58:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BB33D922158;
        Mon, 23 Jan 2023 17:58:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674496723; a=rsa-sha256;
        cv=none;
        b=gTdv1el61SZvUySAqF3vXYM8yJRVr/S0bkQJL5uH08tVKKBsz5lN6fEVVoY2Op8bd4CLcJ
        rIxjNz3I0nwJEVqYfwjHK0ZOzP/jSV+2ysElGGz09+O2drYhusHgBfEh6nXIY76FacURhA
        MVC49tzA66T3PAAzV+XoCyyqJ/qnBmN2Nr/ZkQUpSi/EK4CcgQqX1391wu4SAFWlLs9cAT
        Vs9di9mj7gm+yfnuHAT3ZN15ySn+teou7ssozpXyEtRdCIAXBrhCRTmXw9efFs5PUmkia0
        pCw7y8BVBlcyIFw+HYpf8qkpmLZj7r8zmuejmmEyIBP9uw/hNTYj1KxQwNBrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674496723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=BufXulOysFl45M9SRAl7NgoF0pjRTbINV3aTpO/3Ll0=;
        b=zZxNoI1hetwpPD3pqGMk345eWYZh6tKOS95sniBz/yzmYgkNE5MXFISifqBvPxXVNq1UqB
        CanMdekzeD7Fq46/GBYwK3fl+ANm8JEShYDqpRtlOB4iLiklx8pHd1/WqV4TV6J1oxj0Qt
        FUElpb7KpbnHe3ISV2R8lMdlPFfrHwwhzR2Wr6xdXYFoiodIturGp7pWGty5Yz+u1REd0r
        PxOW1dbta4J1l5wrM29P9DdCyNv2Bdb5SY9Exx5k7JiglZwnfC4e1tCeUc/mgZsEk7OHhB
        AI1BlswawDA1G9KRaOdM4G5ZnyzFnAzpYhneM8JboKp7owMaHKrL9NbNwGxl8w==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-cftxt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Slimy: 7b43e4ff71ed2569_1674496724060_560391479
X-MC-Loop-Signature: 1674496724060:1984612872
X-MC-Ingress-Time: 1674496724060
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.205 (trex/6.7.1);
        Mon, 23 Jan 2023 17:58:44 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4P0yX25qNBzL9;
        Mon, 23 Jan 2023 09:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674496723;
        bh=BufXulOysFl45M9SRAl7NgoF0pjRTbINV3aTpO/3Ll0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=YzI3MiKSaptB5+wAH+9AN/mEkKLgbIml37DGffhNydyFQuHHWQmiAw21ZcNWM/wKP
         GaAmk8JYbuYPYjyU9TwZ7aaW/YlEOzaxOBbuzmKPmr/0hM1AVMffKK7/Ic9ZxED6Ih
         PDVQF4uRzxHkZygBeMO/Hx9PTJupSk3Ew/2ioWRo48nYFvyRyfxN0+F7+ZyY4DxIqK
         oBPpws8actnMaHr89Moy+7E9mTTLXQDs5ux3zOeV4cdstPYo/H1ZG0aMOeFiXMO5tp
         5gYFbnR1N/68ckoY8yvS1nFLLcRRY0JIkiZ9NdxA8cbHqRrHGKX15rZeQSLPgyrnhQ
         S1koWzu2TVzIQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     mingo@kernel.org, peterz@infradead.org, bigeasy@linutronix.de,
        dave@stgolabs.net, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip 0/2] kernel/hrtimer: Ignore slack time for RT tasks
Date:   Mon, 23 Jan 2023 09:32:04 -0800
Message-Id: <20230123173206.6764-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch 2 simply ignores any user passed slack time in the case of RT/DL
tasks for schedule_hrtimeout_range, which is aligned to what nanosleep(2)
already does.

Thanks!

Davidlohr Bueso (2):
  kernel/hrtimer: Rely on rt_task() for DL tasks too
  kernel/hrtimer: Ignore slack time for RT tasks

 kernel/time/hrtimer.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.39.0

