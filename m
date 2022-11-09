Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C8C6233E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiKITsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiKITro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:47:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE32FC0F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:47:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so2836624pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 11:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji3jE3hXnmqLHI1Okuz207fU1hW+Zpv9OqIu7+ip1Ck=;
        b=Vgu5b8na8f9uR+ZgJj6JxLwhacGOy6Yoa73w1yMHmqO2PFj/He6F9wOAQh9yZ8pVLQ
         Uz8pDO8JzQBt3sRzxCWnp4D2K8xrCEAAPh8kuV9Bajzpem6my64SztPPCrOw9c1JEogz
         YViIeiQ6JHCdWg4CQqe2k5WY7jOqpQttqixHpy1TDxBMaPDkYhWOjACazEpR1BVyhNID
         n/GMTyiY6veGtcZ0OkSN11IRnQXatefsfdh6eWg+kgtBo48v9F9bKQr0ITCKPYIkZD0P
         ew4OsXuQVLVy/q4n80AfYISgrxi9atbpBmlSzBY0M7pag+o3hcijk3AGH0c0cRoxznDP
         xU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji3jE3hXnmqLHI1Okuz207fU1hW+Zpv9OqIu7+ip1Ck=;
        b=jtEzGKNR/94VmS1knNF+xsG2vYUqsdphAMgwRuTZpNrHK3cV8rEP9hM+ObQZepRPh1
         a5gmdTdUjc7swpQvwUJ8w8s0zBkU4kKQESlSrnJTo7dNIeOVy72Br4qYyKrfBir1ysVX
         I+UVnmn/BDOZorHXAMCW6dlR0UOV8UisbP+Q2btHGxO07m7cDqgPpAieySICS10z24b3
         aW/yRVpB4t/WwTBnACgrLs+9zpyPp/+s+EiYzn4EwgRRlsonv5AVFS4EQsfIIlabwFp4
         QqxndD37hvd5fhDhRlyTMnkUWRbMQYMMQignNAuc+GO0K+um6WaZeyYDkYsaLBPjsXht
         8y4w==
X-Gm-Message-State: ACrzQf3xNvOIBZAV31UBU2EUKqOpcdu/sRjiZLb4XxTKAngO26IEAAq4
        Nxv3vN1x/SjRsTAQivLFBrPIIg==
X-Google-Smtp-Source: AMsMyM6wcFvbTofo8v6P98DN2ugtF4pGS4/8UEO+3aVCPqs/WWehDyIUSMqG241zmFtgUyC+4O4vtQ==
X-Received: by 2002:a17:90a:77c6:b0:216:92a9:fd60 with SMTP id e6-20020a17090a77c600b0021692a9fd60mr1001916pjs.24.1668023222666;
        Wed, 09 Nov 2022 11:47:02 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b0017f48a9e2d6sm9514355pls.292.2022.11.09.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:47:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Khazhismel Kumykov <khazhy@chromium.org>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     Khazhismel Kumykov <khazhy@google.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
In-Reply-To: <20221108181030.1611703-1-khazhy@google.com>
References: <20221103013937.603626-1-khazhy@google.com> <20221108181030.1611703-1-khazhy@google.com>
Subject: Re: [PATCH 1/2] bfq: fix waker_bfqq inconsistency crash
Message-Id: <166802322145.66062.9011104820940557467.b4-ty@kernel.dk>
Date:   Wed, 09 Nov 2022 12:47:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 10:10:29 -0800, Khazhismel Kumykov wrote:
> This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
> but woken_list_node still being hashed. This would happen when
> bfq_init_rq() expects a brand new allocated queue to be returned from
> bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
> without resetting woken_list_node. Since we can always return oom_bfqq
> when attempting to allocate, we cannot assume waker_bfqq starts as NULL.
> 
> [...]

Applied, thanks!

[1/2] bfq: fix waker_bfqq inconsistency crash
      commit: a1795c2ccb1e4c49220d2a0d381540024d71647c
[2/2] bfq: ignore oom_bfqq in bfq_check_waker
      commit: 99771d73ff4539f2337b84917f4792abf0d8931b

Best regards,
-- 
Jens Axboe


