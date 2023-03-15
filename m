Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19E6BB39C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjCOMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjCOMvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:51:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DC38C536
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:51:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y2so18678493pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678884672; x=1681476672;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZkbtoWja85fMLAbjXK98n41T/e7K5OhmawF7QD5eFY=;
        b=bF+iZZkg40UqrsVEUQ/fdqKax2RZLHQVGPSVjvFW4QDzwVaPa6RrvqjDS5UEoX/wpi
         o/VnZDCP288oppcit1QsMrBMIM4BVDfcEt4JgypAr/JIjyCqVFtah0iWYN2xhnPir9Cz
         sKtw8Qf5K0UgbzktJxeq1B0bG4oqgGtU58K3kWkTBhhEGeq4grRGDga3ocWxvwnRxrvk
         pEPQR0v2cxDvyz/HZqTEDr4AvjQj/BhyZm5M+ZDfps6IT1xaz1DeFBUAL1u5eivcP16q
         /jGik346ZKOzg3ufG7iUiSaRLzNfgMZQi6VoehmHoPZ16b2RGSdLZjJA0Tu58Bo5IF3A
         GP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678884672; x=1681476672;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZkbtoWja85fMLAbjXK98n41T/e7K5OhmawF7QD5eFY=;
        b=XmDfK+/mzsxtvoCOcJskM/VWTkkQwMGV36E6N2pMSWq6KyCLCa9olUNckK/GFvgKg1
         GYYMUaxYq5tcKcn7dgaA0jnH5uaIO9tswkJ+W91WU48lbGw+21QEf5/PjEv2sEtEUV7x
         c3IT64D2HME/xuA3OcQseODFSSiWgRGo2mSviPYSjLN7FstcKlowztXk4uSSW6AvXvvI
         w+3aoP5oj/cu1ZrIz1vXryC70aYe008RkDJBUk+EK6ru/xH6tPItFWTfLMB8LVSnQuG5
         fa/KV2mq8EVuA40oARNlWgwHrdr859uorrVWUYLu9fwE/R7Ium/zwaSZqj8IUcxkdGce
         ZiIw==
X-Gm-Message-State: AO0yUKWkgLSRRP1rZEDrhWTZtLb6iFpvO+yZWEbrXL7t7jNiO+qdvZhs
        /vCQIEhv7FWruOtc6Lb12i+qj6JWpMbt9rMayUcvtg==
X-Google-Smtp-Source: AK7set8mvMQnqXHAGVcsRNhmtQR25abfMXdfnIlu0KcIHFJ9oK72G+0n3KhChD9cmn8b8rdohn+sbQ==
X-Received: by 2002:a17:902:b713:b0:19a:7439:3e98 with SMTP id d19-20020a170902b71300b0019a74393e98mr2565786pls.4.1678884672475;
        Wed, 15 Mar 2023 05:51:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id kx15-20020a170902f94f00b0019f387f2dc3sm3618298plb.24.2023.03.15.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:51:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org,
        =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Daniel Dao <dqminh@cloudflare.com>,
        Waiman Long <longman@redhat.com>
In-Reply-To: <20230314183332.25834-1-mkoutny@suse.com>
References: <20230314183332.25834-1-mkoutny@suse.com>
Subject: Re: [PATCH] io_uring/sqpoll: Do not set PF_NO_SETAFFINITY on
 sqpoll threads
Message-Id: <167888467141.25248.3419360093103116663.b4-ty@kernel.dk>
Date:   Wed, 15 Mar 2023 06:51:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Mar 2023 19:33:32 +0100, Michal Koutný wrote:
> Users may specify a CPU where the sqpoll thread would run. This may
> conflict with cpuset operations because of strict PF_NO_SETAFFINITY
> requirement. That flag is unnecessary for polling "kernel" threads, see
> the reasoning in commit 01e68ce08a30 ("io_uring/io-wq: stop setting
> PF_NO_SETAFFINITY on io-wq workers"). Drop the flag on poll threads too.
> 
> 
> [...]

Applied, thanks!

[1/1] io_uring/sqpoll: Do not set PF_NO_SETAFFINITY on sqpoll threads
      commit: a5fc1441af7719e93dc7a638a960befb694ade89

Best regards,
-- 
Jens Axboe



