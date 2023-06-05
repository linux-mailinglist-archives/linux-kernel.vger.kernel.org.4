Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB372338A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjFEXJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFEXJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:09:15 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8AE10A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:09:12 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f13c41c957so481931e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 16:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686006551; x=1688598551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfB0IIWFmWA4byjR9DVd4G5yzVB/O8UFaT2kngw6pT8=;
        b=gKrDQ3qGpfMey/ovGm/oMR0K3L0BQUFiQt4YIUY2WbdvsplesYneJTzKMUDHOBdLkz
         0CgEZDQDedPLED7TZHq+FJ1uX7h6R2v9qlRXwFgalTs2/hnYVDyInnB/B71JfRds4krV
         hZ8svK6u2KFWW9/xLTM3DCZxXZiXU3luGS9vjjnLJmqg0pzozQXu2a/OQPweduDSPcnP
         UziJMD9dp6yXh0ybJZ45WA/Ycn/4g/TQ9/tNcuKmdTn3FeWzKrkfsXxeHsPU/TGedkow
         QLqMAykZqMP1rGSVcKN1qaZGyLXly5aKX/3io1gHOFGeS+P7leI2o3ECc28yoKC0Dq7e
         kr7g==
X-Gm-Message-State: AC+VfDw0Vm9HJdmf0zixEX+ABBXhGDvxjj9sDlv1bEGPqxji72sOgRdM
        k7M7/1v+i79kjMoEpSYAErWji14HSgM=
X-Google-Smtp-Source: ACHHUZ6ckcSXrcgzv3Nd4m7RtjFZaG5I73JpjFq5tAshEFLiJbb9ULiae6jnWiV3Ad0VmSk7xnBpug==
X-Received: by 2002:ac2:52b4:0:b0:4ee:d640:91eb with SMTP id r20-20020ac252b4000000b004eed64091ebmr162880lfm.3.1686006550601;
        Mon, 05 Jun 2023 16:09:10 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id t4-20020ac24c04000000b004f14591a942sm1263613lfq.271.2023.06.05.16.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:09:10 -0700 (PDT)
Message-ID: <bd1676d2-4078-4c02-14a9-e2f5ebe2dd29@grimberg.me>
Date:   Tue, 6 Jun 2023 02:09:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Content-Language: en-US
To:     "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1685350577.git.chunguang.xu@shopee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cover.1685350577.git.chunguang.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> We found that nvme_remove_namespaces() may hang in flush_work(&ctrl->scan_work)
> while removing ctrl. The root cause may due to the state of ctrl changed to
> NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_tcp_error_recovery_work()/
> nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this time, ctrl is
> freezed and queue is quiescing . Since scan_work may continue to issue IOs to
> load partition table, make it blocked, and lead to nvme_tcp_error_recovery_work()
> hang in flush_work(&ctrl->scan_work).
> 
> After analyzation, we found that there are mainly two case:
> 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() while it issue
>     new IO to load partition table.
> 2. Since queus is quiescing, requeue timeouted IO may hang in hctx->dispatch
>     queue, leading scan_work waiting for IO completion.

Hey, can you please look at the discussion with Mings' proposal in
"nvme: add nvme_delete_dead_ctrl for avoiding io deadlock" ?

Looks the same to me.
