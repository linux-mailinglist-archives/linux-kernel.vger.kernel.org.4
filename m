Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831026E9E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjDTWKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDTWKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:10:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06EDAD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:10:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24733b262fdso217544a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682028619; x=1684620619;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq8kvKP0mTJEmtb5lHkCR7d4m4oQ1PJeoKQIkottUnE=;
        b=0L/jgWqlEpn2/W+Oqrfi2bayfxyzNQCMNTnOf0wXt+Oshq+coWJFAFQhbe0mpIgLr4
         KgBRI1g80BDKfwzj2hekcoafYa6y3uZorskjP2ynS26n+IGHaTiNY2l5x9oa12HI80AZ
         1oK/eLQ2HtNICBtFelvRLfzZDKw7ejnpgbNC7eKal0mSk9RlGujptFjVsHi3geHddZVQ
         4wFkd94e8kCRSR2O8KX7tdPigYhRrzQ7xTRh0/ZVRqu9cQBNGbspLM5wtulN5Rcjinw/
         wqEwjyh4+uJcJHMieC53UJ93UQirFyiUkq6KUJGkIxneaUwuKdv3aIx1gJhddNMdd9Hx
         rgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682028619; x=1684620619;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yq8kvKP0mTJEmtb5lHkCR7d4m4oQ1PJeoKQIkottUnE=;
        b=K0WH0zFr0Hv+H4YQ8eDBvtY5IjFawx5EhkxGO5iXAcKEkYAdwNnyGib2SjjC2SIZA2
         6+1ApGzK9jBA231GZ7SLgHC11Zs9e8d7yr14imgT2m67LAIAzl0QOz9t8PWzVC55gHuc
         UbvBoninXthuM2K/jYHpoErQ6dZje73v+vd/+WYQSdtr2vslGU6o1CyYfCms1GeE4WMP
         G7/WO2vjwXnPBvYe5jwSZube5+QyyBH6GvJ5yFHGWy4eWX14CyDIWxc8v8y2HU/iS+rD
         i9MwNOcALbj930qjEc59+tc8d5Sbdvz2DouMIQN/SmCe4Lvs/fdFR1DXuszAzTnUqUUM
         pK1w==
X-Gm-Message-State: AAQBX9dGOOaJOLlwWXxgCsyekNnLHIQttnj/VtN692n1h2CZkJqFNgxB
        WvQPAGPKRM7WI4pl4cC5/jDbQw==
X-Google-Smtp-Source: AKy350ZhMBy5GKPZV59Ht+GzZkefxM2EyRmdhC3qSdMPg5RpTSYC/as5CqeeIR8Pc77vGTXyBXq6DQ==
X-Received: by 2002:a17:90a:1d3:b0:245:eb4c:3df8 with SMTP id 19-20020a17090a01d300b00245eb4c3df8mr2843826pjd.2.1682028619241;
        Thu, 20 Apr 2023 15:10:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b00247bdd05fe5sm1590001pjn.29.2023.04.20.15.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:10:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230206145805.2645671-1-zhongjinghua@huawei.com>
References: <20230206145805.2645671-1-zhongjinghua@huawei.com>
Subject: Re: [PATCH-next] nbd: fix incomplete validation of ioctl arg
Message-Id: <168202861821.155232.3879480866523352390.b4-ty@kernel.dk>
Date:   Thu, 20 Apr 2023 16:10:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 22:58:05 +0800, Zhong Jinghua wrote:
> We tested and found an alarm caused by nbd_ioctl arg without verification.
> The UBSAN warning calltrace like below:
> 
> UBSAN: Undefined behaviour in fs/buffer.c:1709:35
> signed integer overflow:
> -9223372036854775808 - 1 cannot be represented in type 'long long int'
> CPU: 3 PID: 2523 Comm: syz-executor.0 Not tainted 4.19.90 #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x3f0 arch/arm64/kernel/time.c:78
>  show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x170/0x1dc lib/dump_stack.c:118
>  ubsan_epilogue+0x18/0xb4 lib/ubsan.c:161
>  handle_overflow+0x188/0x1dc lib/ubsan.c:192
>  __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:206
>  __block_write_full_page+0x94c/0xa20 fs/buffer.c:1709
>  block_write_full_page+0x1f0/0x280 fs/buffer.c:2934
>  blkdev_writepage+0x34/0x40 fs/block_dev.c:607
>  __writepage+0x68/0xe8 mm/page-writeback.c:2305
>  write_cache_pages+0x44c/0xc70 mm/page-writeback.c:2240
>  generic_writepages+0xdc/0x148 mm/page-writeback.c:2329
>  blkdev_writepages+0x2c/0x38 fs/block_dev.c:2114
>  do_writepages+0xd4/0x250 mm/page-writeback.c:2344
> 
> [...]

Applied, thanks!

[1/1] nbd: fix incomplete validation of ioctl arg
      commit: 55793ea54d77719a071b1ccc05a05056e3b5e009

Best regards,
-- 
Jens Axboe



