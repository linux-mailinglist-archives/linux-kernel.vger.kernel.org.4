Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25503683045
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjAaO7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjAaO7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:59:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DAA18B29
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:59:08 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r18so10217741pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUfO17LvPiRheZ8oG+2011HzX6ga1U8/AUR7L9wf9Zk=;
        b=Lr3v2mrb150h2pJM4MQnadP+BOfvUvu0hwUSdoI7GNe/BdGFGJfg+mTPW2RFrrnqEd
         lzThfrWhlPcZmpxb5xXDOPqWCTlyuEDBuYTvqYowH0r8mlLnpMwtSOm+YFER49t0tDFx
         YCIASHE6ZJ8Wo8kuTfqFSgHUwa5V+sysf23hZpa9hYHBK3tHOpO9haB1/mY90R4zIuBA
         xC83eiO3pFXRRegBNmByEyY14Z9VSADQaPVoqX2kDfrHvpvSLUIj+3a1eTXlZe4dtro0
         S8cIjmg5IfnCG2LRPZ7dbtxeAiSaQu0rlOU6kMtMvqTPEDMybTDQSgtQHdldqfs13oxd
         S5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUfO17LvPiRheZ8oG+2011HzX6ga1U8/AUR7L9wf9Zk=;
        b=wAW07AzTyW5qhuJ+hN9O2wOF8H836POGlhb1LmPYH9lZyhNGcpks7//lBq7V4WNzTE
         vLI2Sc+ger+6+QlrSUiRgoGERi0r1jQd9cLLMC5tioGmqi+iayx0g1m3QzJelUmtQNqb
         iQen6levzE1THmZrveNU8GTS94c03YXXy9XhnTRB9pJGbqPe7RUwsOruXPkn3IeoBm0j
         2hbQ2aNx0ZX9OLuvRw4wF9hI9JUGu5HxpLOrw/GUh8XM4BwJ0ptg1cmp/0oAPPq4N2N5
         Mbghj0Rn9JlzpTRdIcuVtGjl8MT5Oe4+wFBqKFdCXtKOden7ypBzn1+qpngln+eFF+gt
         6n3A==
X-Gm-Message-State: AO0yUKW9AXVdH1oiDbf56x2X2II4k8+7e16JlwLE5U7ToYIBnCbdEy/4
        37obstjY0fjLnkutIU6ocFSsBg==
X-Google-Smtp-Source: AK7set+TCp7yav5Xbny8PMKaEDhPqtoQXkXy7s+bif9gmvTWhWrz9QrwUovAbMzHReZE9EwcI0616w==
X-Received: by 2002:a62:1643:0:b0:592:d41d:4ef8 with SMTP id 64-20020a621643000000b00592d41d4ef8mr5634184pfw.1.1675177147735;
        Tue, 31 Jan 2023 06:59:07 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a00078500b0058d8db0e4adsm9918139pfu.171.2023.01.31.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:59:07 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Harris <james.r.harris@intel.com>,
        Ben Walker <benjamin.walker@intel.com>
In-Reply-To: <20230131070552.115067-1-xiaodong.liu@intel.com>
References: <20230131070552.115067-1-xiaodong.liu@intel.com>
Subject: Re: [PATCH] block: ublk: extending queue_size to fix overflow
Message-Id: <167517714685.21899.10299241689859963675.b4-ty@kernel.dk>
Date:   Tue, 31 Jan 2023 07:59:06 -0700
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


On Tue, 31 Jan 2023 02:05:52 -0500, Liu Xiaodong wrote:
> When validating drafted SPDK ublk target, in a case that
> assigning large queue depth to multiqueue ublk device,
> ublk target would run into a weird incorrect state. During
> rounds of review and debug, An overflow bug was found
> in ublk driver.
> 
> In ublk_cmd.h, UBLK_MAX_QUEUE_DEPTH is 4096 which means
> each ublk queue depth can be set as large as 4096. But
> when setting qd for a ublk device,
> sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io)
> will be larger than 65535 if qd is larger than 2728.
> Then queue_size is overflowed, and ublk_get_queue()
> references a wrong pointer position. The wrong content of
> ublk_queue elements will lead to out-of-bounds memory
> access.
> 
> [...]

Applied, thanks!

[1/1] block: ublk: extending queue_size to fix overflow
      commit: 29baef789c838bd5c02f50c88adbbc6b955aaf61

Best regards,
-- 
Jens Axboe



