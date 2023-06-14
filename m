Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD8A7305B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjFNRL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjFNRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:11:54 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CA8213A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:11:53 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33d0c740498so4757225ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686762712; x=1689354712;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFGm7FqvVo6N2TIKugcE6wuGfwkXCoffvc2Z4/ZFrvk=;
        b=lm1oNKUB9xU8Pb6XFA19Ula4qGY1HRWrLbYsGRzV5RHzhzp7pwTPNlfXwJPIVxA0nJ
         lS2aewP3Q2LDai+BwjNnKBHv4pJ90hQ6cpZMLdko+u/M+lSkgm8XYrzzg18wpdMQ043U
         wBroNJCPhC8P8AxxZnWkw3zjxehqUOI0ZQ2twVjawryi4NAxzlEDV0a6xQxU9ShuBt9a
         3Pu4Vo7mbsM7bHmBYUNsE43Oa0MZDT8BOvemG5mLhkq9epAqbLyAvDmLMqCj36Mhu1JY
         wshaZs+i0Q3UyPO29s23hrcgXtnNYkwp8E2jlL41wew88vO9pymj1H93lM6MMp4MiWaD
         hjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686762712; x=1689354712;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFGm7FqvVo6N2TIKugcE6wuGfwkXCoffvc2Z4/ZFrvk=;
        b=I2vHm+Qz/LsvVaXWKu0BwJO2BSgyO51utjE+3Wj2cO0Sw1JLqWkOMHOg5/t/Pww3Hs
         i3tJmFsNhIw7Qk01RSkM0d3++hIn87rBtIRJil9d7yD5Pcyzf/CjR66ADeTUvUR816sk
         i3y0SZM2EOi9qyZdxFYjFYP/C8JOBdMPkZuS0kkts/92ihe0zBhQOyZxWidVxNLhXmWp
         sCziKPu0muxsjlcTYWsQbJBK3CnRRX5lCeSoeullU7DLu+14NYbZxhqpem6jq8B/4nD1
         hSqXxDpzkKmpg7qT0SyI5I6+AfOKq0+Q+0LbHzz4Dqyzp2PerS4HTDW4U9djKRnO3dV+
         mWeA==
X-Gm-Message-State: AC+VfDxoJQ3oqlTNDs9qBIvians2n6rgKhK9cGridVaIaC5WqhxXFbg/
        Kk/Msy2kQCsSfNcLMyF61u/6Xg==
X-Google-Smtp-Source: ACHHUZ6yQRQ1s8D9mzXhZ3rYN6V6cthldCfEgP5WF7NRHJ5KcSo9a5YXXGXUhFA/hu1SGecsAQuqGA==
X-Received: by 2002:a05:6e02:50f:b0:33b:1b5d:9723 with SMTP id d15-20020a056e02050f00b0033b1b5d9723mr10710356ils.3.1686762712334;
        Wed, 14 Jun 2023 10:11:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9-20020a056638020900b00418af04e405sm4313921jaq.116.2023.06.14.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:11:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kbusch@kernel.org,
        amergnat@baylibre.com, liusong@linux.alibaba.com,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, powen.kao@mediatek.com,
        alice.chao@mediatek.com, naomi.chu@mediatek.com,
        Chun-Hung.Wu@mediatek.com
In-Reply-To: <20230614002529.6636-1-ed.tsai@mediatek.com>
References: <20230614002529.6636-1-ed.tsai@mediatek.com>
Subject: Re: [PATCH v3] blk-mq: check on cpu id when there is only one ctx
 mapping
Message-Id: <168676271101.1830690.9612621068004159159.b4-ty@kernel.dk>
Date:   Wed, 14 Jun 2023 11:11:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jun 2023 08:25:29 +0800, Ed Tsai wrote:
> commit f168420c62e7 ("blk-mq: don't redirect completion for hctx withs
> only one ctx mapping") When nvme applies a 1:1 mapping of hctx and ctx,
> there will be no remote request.
> 
> But for ufs, the submission and completion queues could be asymmetric.
> (e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
> ctx won't complete request on the submission cpu. In this situation,
> this nr_ctx check could violate the QUEUE_FLAG_SAME_FORCE, as a result,
> check on cpu id when there is only one ctx mapping.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: check on cpu id when there is only one ctx mapping
      commit: 30654614f3d27230200b1650f6025a2ce67900b4

Best regards,
-- 
Jens Axboe



