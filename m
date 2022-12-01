Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011E363E739
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLABrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLABrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:47:06 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5EB52140
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:47:06 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b21so203247plc.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG1FRF6NvvTrQgh7hkGSM1RofK5aGr38w3ooW7oI78w=;
        b=nue/1SmJ1LCPfvm3ohnTASWGXwKcSs3WqqLHKlqlyaFhuQ1+BPaoBv38LB/i/Mm6x+
         kgdpsRx520nsbxizSIgZdsSF94bQdGEG7rKZ+nzgfedNWWYuY8btrChtXNxbgwj6G1EU
         EP9dR0OW85GOBoxGKYXThtht9b/kVgQJA760EHWDfN+2xoRaQ9lzmgVZ9AAdDbqqenqj
         WcMNXZXx21mAm5js47qVwwZr2OU2QaWTojn12g85PxwmurYyyezYF3ItaVhTTRtMK2hT
         kFtHStmx1pC/xPqSYSQN6fQW2tlywRzXKaeONI45fZvV4Ia9oQr/5swgQU45jLaKZcxU
         2Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG1FRF6NvvTrQgh7hkGSM1RofK5aGr38w3ooW7oI78w=;
        b=lUVGDe0JddOs6QC1aqrLoW39FEelaTASu5CuFsDPdHB33+yhtxZMuEZLdKkC0mMXoU
         yModYeBzf0OXDj9c8v3j+3Dw4oLBOCBVOynJPUgx6ixZ5UMiLXqrPAGUNY351voOwFAM
         l9+phOaCmO5GdMGFVGLCBn6BetUjgmrnswE4Bm2MDkzbnBB17PJ4A1i/I0ZAX6MXrHVM
         qvj/oyeRox5aqA+I46aRPAUiqe9ngj2cJ/f5AcBsALFBf+r0hhECZKBGBOs0wvCKnqrg
         CSyanu7Nss1uXxB8cqeDwnhaNqEEygsYgdXmZuJntD0ArcLrCOy7uc7aJywVbQEBZqzO
         ZAzw==
X-Gm-Message-State: ANoB5plFGNo0sq+bR04NQYts6sBjPgpJAW/Gs2pm+XykJpuzed4NI6/A
        FTYgHWHuTy25YtLYnX4uUaC8aQ==
X-Google-Smtp-Source: AA0mqf6Xq5rFthMl9MozMuFDWfE41NWQOupHJghdq9afHJdJf4VxHFmZjkVlNCm5/e0cUCYkjYpHww==
X-Received: by 2002:a17:903:452:b0:189:6574:7ac2 with SMTP id iw18-20020a170903045200b0018965747ac2mr31099929plb.65.1669859225822;
        Wed, 30 Nov 2022 17:47:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a088800b00213a9e1ec44sm3671307pjc.52.2022.11.30.17.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 17:47:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Kemeng Shi <shikemeng@huawei.com>,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
In-Reply-To: <20221018121932.10792-1-shikemeng@huawei.com>
References: <20221018121932.10792-1-shikemeng@huawei.com>
Subject: Re: [PATCH v2 0/5] A few cleanup and bugfix patches for blk-iocost
Message-Id: <166985922489.517656.7936907108096958272.b4-ty@kernel.dk>
Date:   Wed, 30 Nov 2022 18:47:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d377f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 20:19:27 +0800, Kemeng Shi wrote:
> This series contain a few patch to correct comment, correct trace of
> vtime_rate and so on. More detail can be found in the respective
> changelogs.
> 

Applied, thanks!

[1/5] blk-iocost: Fix typo in comment
      commit: e12d34fce7652a870fac62e9749a6623883d6fd8
[2/5] blk-iocost: Reset vtime_base_rate in ioc_refresh_params
      commit: c81d97a61c8c3c25a576c3db4c4dd34316256f05
[3/5] blk-iocost: Trace vtime_base_rate instead of vtime_rate
      commit: 0c0d362dc97d19d898219c13a357e167a9ee77ee
[4/5] blk-iocost: Remove vrate member in struct ioc_now
      commit: f44ed8722034ef7d214fa121ae2402100a3590e1
[5/5] blk-iocost: Correct comment in blk_iocost_init
      commit: b4c0482bfe89cd6c4f030314c86aae35642c44a5

Best regards,
-- 
Jens Axboe


