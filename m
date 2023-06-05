Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52817232FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjFEWP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjFEWP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:15:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC74BAF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:15:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-65c6881df05so280435b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686003355; x=1688595355;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMXtmKfbmokYLB7uQ5WSAk4+F8MAIPB5154UaLInYwo=;
        b=vei6ExKysQ7iDwD6QEZv3q1BJOraZZbXS7bWyFKfXKTEJyQtnx+0vEvTGw1ZiK6AY1
         6U9nvYngrLgVK7yZTOwk/g426NNAzZK50mh13tss5VFpfWgM29HcogMwhRrAlPaIPDvE
         g4b1PLcezAipJxKae1nfnVVV6bq5AG/XuydPg7PapwT32xiJ1mu0boaqkQ5UTZc0WK5S
         9IQ/On5lGqZIXJs4Dhr0iwRIAxkG/H9CicAXHj/ssv3lY14UXiL2y5DpIbAafB73gFnL
         6Geb/6tAg/+mVL913Xu4NpErQajq4JO+A3mRMoY3WUBjnBWz7jIWyx/ucmI9LoQ8p9B9
         xY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686003355; x=1688595355;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMXtmKfbmokYLB7uQ5WSAk4+F8MAIPB5154UaLInYwo=;
        b=HuxR0xeibq7DopQfQL5x821/+y65B6sgvaGXqR3vEqxcaYOKF4yFEn/Kcc9EoVuZVJ
         UfTbYHpPAtq4HvWwnRFsiCPW6THijfS0IaAm7NQHxz7cS1K4xh8Bc1plqzbmoXqJe3+h
         SG/pMy0lkRH7CMDppcQIBNem8KPt0ffh8uumI8dHwMCEZODTv5kYurmFtJKf3plZRwnf
         40Z5mkxIul4AVGIGjvKg8zUeVmwBBT9mR6GZ5FUQ/9rwSlWxCo1gb0RHc2peD6ECuX5g
         Txtam6pt1D1LADDLrXG5FZiJdVC5WboyljplHcC7RMOW9d9IoVLkxbekhGToJLD/TRns
         vkzg==
X-Gm-Message-State: AC+VfDyGIYkZtJ6gKKOYASSsMyigtZg8iIuTsQOHAgBaDIUmtHD5mQpI
        9aEAA87qY2HqtvzSKeL2gRDIbg==
X-Google-Smtp-Source: ACHHUZ67jn+VdenMIEOVfi+mg7Ss98shsK/fQiwlJI+PQXlvvUsREifLADhk/fPRpTResEnTuVRfkA==
X-Received: by 2002:a05:6a00:2490:b0:656:7b53:fed4 with SMTP id c16-20020a056a00249000b006567b53fed4mr6852360pfv.1.1686003355126;
        Mon, 05 Jun 2023 15:15:55 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:c017:83c2:f698:1aad:6875:3e53])
        by smtp.gmail.com with ESMTPSA id x17-20020a056a00271100b0064f39c6474fsm2804545pfv.56.2023.06.05.15.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:15:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230605062354.24785-1-nj.shetty@samsung.com>
References: <CGME20230605062713epcas5p15f43412fdef92c01567dd9c59a931d9b@epcas5p1.samsung.com>
 <20230605062354.24785-1-nj.shetty@samsung.com>
Subject: Re: [PATCH] null_blk: Fix: memory release when memory_backed=1
Message-Id: <168600335395.173234.7376041996345283408.b4-ty@kernel.dk>
Date:   Mon, 05 Jun 2023 16:15:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 05 Jun 2023 11:53:53 +0530, Nitesh Shetty wrote:
> Memory/pages are not freed, when unloading nullblk driver.
> 
> Steps to reproduce issue
>   1.free -h
>         total        used        free      shared  buff/cache   available
> Mem:    7.8Gi       260Mi       7.1Gi       3.0Mi       395Mi       7.3Gi
> Swap:      0B          0B          0B
>   2.modprobe null_blk memory_backed=1
>   3.dd if=/dev/urandom of=/dev/nullb0 oflag=direct bs=1M count=1000
>   4.modprobe -r null_blk
>   5.free -h
>         total        used        free      shared  buff/cache   available
> Mem:    7.8Gi       1.2Gi       6.1Gi       3.0Mi       398Mi       6.3Gi
> Swap:      0B          0B          0B
> 
> [...]

Applied, thanks!

[1/1] null_blk: Fix: memory release when memory_backed=1
      commit: 8cfb98196cceec35416041c6b91212d2b99392e4

Best regards,
-- 
Jens Axboe



