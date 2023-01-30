Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72630680405
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjA3DEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbjA3DEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:04:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D3C1BAE1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:04:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id r8so3357491pls.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKSk1kxX8w8OryNBbFAkE6XXIisn2OpGob9bqGZ1kIw=;
        b=KVWZ7VPW0Fk4DVi6LJe8UhymhFaSRg92W22V+se1HU4rDgby78TssGwuS3i5QWwiKb
         2gz6y5Ry1Pn+GLP9JmF1YPZyybGBBqqz4+1xdUQnN2Y0RBLb5N22evtXGC+W6821eMke
         ynk8OE6qZN2fxkgEIaRx6AFtIyI3KsZzTSYjHqbHlrQRn9FuJnf5hTIe5jiPdrp/ZjW6
         zF7+INmrKPioQIHQDcMIXQcxFQecIdF+T0RKWOO2P2Y213WFgVdna3z0HNang6RcG80K
         HtDAtKZoazYB6ynb1jx/DZ/4FrFX3flMgfSDYs4fKEyXoUH4xCRNaiiXgMfWmjcem2NF
         pSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKSk1kxX8w8OryNBbFAkE6XXIisn2OpGob9bqGZ1kIw=;
        b=SYb9a2MlXTvmNiA9DGOLWMRM3L4PCN0k3/2gR/OlHzfJ2QPuf3rcJgas8Mr8HCJ0ld
         FJawb5/7rQnM5bhwxxcCgh1CScYD9Wbw+rtcaxHOsEYhzqROShGuEwX+Zyt9GyuZL1CD
         yJ67seH8UHjCD+FbxU9tx16R6mBxw+Rqv93RYveB1YEmWuR18OtzmnkmAWC+P/byq0Qf
         ksoU00K811YrzgDde8IUVMQZVSQRVF+URHJQWG3bhUZ7UT7avi5Hv0R7MK8Iy4gCfhkz
         2YrArIskZOmLj0dRe49BR7yRgr/en9wH2dZRPfggiyjo9eQvQjg4dJnBxcbrLcAMkJ+t
         X0xw==
X-Gm-Message-State: AO0yUKVfa5QRO2X7HH+rX0qH/HpiBPeH5Ex5QVN0mIp2Be4QSXRvgxIP
        tpurQ6PQtczYOqKzXZo/5I+AGg==
X-Google-Smtp-Source: AK7set/VxTA1LambeEPhoLIFKUTPAENjkRuHt60pLVrAPDxbLjlTog9zzw0x2wAPg2X2Cq5z229rUg==
X-Received: by 2002:a05:6a20:c1a7:b0:bc:6c4f:308a with SMTP id bg39-20020a056a20c1a700b000bc6c4f308amr2774109pzb.0.1675047859655;
        Sun, 29 Jan 2023 19:04:19 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n29-20020a638f1d000000b004d3f518eea7sm5667103pgd.94.2023.01.29.19.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 19:04:19 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.com, damien.lemoal@opensource.wdc.com,
        paolo.valente@linaro.org, Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230116095153.3810101-1-shikemeng@huaweicloud.com>
References: <20230116095153.3810101-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH v4 0/8] A few bugfix and cleancode patch for bfq
Message-Id: <167504785862.199828.2932581437720147230.b4-ty@kernel.dk>
Date:   Sun, 29 Jan 2023 20:04:18 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jan 2023 17:51:45 +0800, Kemeng Shi wrote:
> mechanism and some random cleancode patches.
> Thanks!
> 

Applied, thanks!

[1/8] block, bfq: correctly raise inject limit in bfq_choose_bfqq_for_injection
      commit: 0c3e09e8854bcd3f7c45de85007ed283342b3464
[2/8] block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
      commit: bebeb9e582e8040944b12942ccc56f4ebacaa9f8
[3/8] block, bfq: initialize bfqq->decrease_time_jif correctly
      commit: 1c970450a7fd8be0298758c4e2c631e4a739292d
[4/8] block, bfq: use helper macro RQ_BFQQ to get bfqq of request
      commit: 8ac2e43c3559f29513377df8aff7a22a8277fcf8
[5/8] block, bfq: remove unnecessary dereference to get async_bfqq
      commit: 86f8382e6d3a74f783c23a3d773285e2637b8bc2
[6/8] block, bfq: remove redundant check in bfq_put_cooperator
      commit: 433d4b03e722bdfb1b6a75563cb45e8dca6784e7
[7/8] block, bfq: remove unnecessary goto tag in bfq_dispatch_rq_from_bfqq
      commit: 87c971de8157b90494490d7c869a21b7f2123305
[8/8] block, bfq: remove unused bfq_wr_max_time in struct bfq_data
      commit: 323745a3aa9ba172582d4549689146298fb68405

Best regards,
-- 
Jens Axboe



