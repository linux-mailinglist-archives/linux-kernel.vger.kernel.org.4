Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B026B0B56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjCHOfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjCHOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:35:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6156C70BE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:35:38 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id fa28so10333215pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678286138;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQD4R0p59xc0wlS4lzBW2X31cx9x5bJ2LDM5iLuHKiA=;
        b=7WgpL6aComZ0lV2uFwlevdbQhP1FyvBD6EtPXcwxQKnfNjh/d5g7kzSNlRHjrQuTTz
         xcrwQ3HFU7cnUn6en7Rsh2q3ir5yKeaAIUrM99CBQkttYsTMBDltQ18ZdRqLSzvcLh9I
         YVr7SI5sFwD4K3R3FsbDLCX7lQrmLEMnpyO/83k2s+/LLB/o7RYVJrQzNzGrwZ0mGNH8
         raiC5mki1DIF+KSuMbeq6B8owL4TTvsB5GHVyECUZ+mlhtBCKAfmnqf5GihT2iwEAS4l
         2WhVuHjk/k4tx8742r90r027SbH2D2qwN7l8JNezMQQz7kWHrFY4bFrXNZm7KKIfpsjJ
         MBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286138;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQD4R0p59xc0wlS4lzBW2X31cx9x5bJ2LDM5iLuHKiA=;
        b=Iu3GdRUKncvUGGudo1BkgM5yUd2jVU+g9CIskzC5hXLc9CM93QlLCVD6sx5vlLGx54
         FO7qOl9xrn735rqmcpsvyutCfeOkfrWvqNC6XE/bDMr0jZXhRSNu4tcB3dSji4l8PZ9z
         Xy9RedJPs+JYywlEtXKirCBOr+l/fTpmZLLemwYxDhxRUvYSiLZofJo6mfPSIDFBwKC3
         WORIjvgONMXWQkZcjTpE6bBzD3qFI0xlkUfS57GlzRxdKAiMjgszc/9DlxjSEW2nCxeo
         gFMNMmrY8dd4FHKGtSkhXw0EnojuGQNtgpWvuWusCd76t1BX20nK2SRg2+o2E8lf6Z+r
         15JA==
X-Gm-Message-State: AO0yUKVh3Hd2YKCPbytCLk3nr/LHOSmwCtHjRExhpDYKMND4QjCr5LOI
        AZk84of+QuSl4YPYC8dVT5BrgDffrY0MIPlmAKk=
X-Google-Smtp-Source: AK7set+Dh42CNU1V5M8U4Rkrf+80aIUEbRP0v3h3CsqB6uPmUh1HyBeoBgw1JFg1lmODheJc2XnKKw==
X-Received: by 2002:aa7:8751:0:b0:5dc:6dec:da46 with SMTP id g17-20020aa78751000000b005dc6decda46mr15988194pfo.1.1678286138348;
        Wed, 08 Mar 2023 06:35:38 -0800 (PST)
Received: from [127.0.0.1] ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id h22-20020aa786d6000000b005e4c3e2022fsm9452574pfo.72.2023.03.08.06.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:35:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, shinichiro.kawasaki@wdc.com,
        paolo.valente@linaro.org, glusvardi@posteo.net,
        damien.lemoal@opensource.wdc.com, felicigb@gmail.com,
        inbox@emilianomaccaferri.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230308023208.379465-1-yukuai1@huaweicloud.com>
References: <4e6e1606-1d9e-9903-8a44-ccac58a1fe06@kernel.dk>
 <20230308023208.379465-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block, bfq: fix uaf for 'stable_merge_bfqq'
Message-Id: <167828613700.180504.7849236814026719917.b4-ty@kernel.dk>
Date:   Wed, 08 Mar 2023 07:35:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ebd05
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Mar 2023 10:32:08 +0800, Yu Kuai wrote:
> Before commit fd571df0ac5b ("block, bfq: turn bfqq_data into an array
> in bfq_io_cq"), process reference is read before bfq_put_stable_ref(),
> and it's safe if bfq_put_stable_ref() put the last reference, because
> process reference will be 0 and 'stable_merge_bfqq' won't be accessed
> in this case. However, the commit changed the order and  will cause
> uaf for 'stable_merge_bfqq'.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix uaf for 'stable_merge_bfqq'
      commit: e2f2a39452c43b64ea3191642a2661cb8d03827a

Best regards,
-- 
Jens Axboe



