Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CF1605584
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiJTC0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiJTC0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:26:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6E1C25D8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:26:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d24so19005017pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 19:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zH/lcm6LmIXvgGP1ltmqCC3mJjw/Vvw4xUY5ydYPviw=;
        b=ilEEMWRnUl3o49fNEPGwCo+yy7Lklg/mWQuFr9uNU+Od4sCkzxROw6s2pk9C1PUpz0
         UGFE1VKwiHehojbJTf4JiS+G1x+G2qZcptiODeMpQtG083R/1hxG2H3tfhrWvMMpBN5W
         J8p+RBvYpnA5Ow2Jq1w37xhs7q2I7H/Oeyo8UpfJjA2g/Up6Hd/u+9t27wkUWeQ1z4+N
         woqEO97+2DawOh0kbE+IvRNboPgGKHtdQJb1zp2WcHtZakh9z4eoL11u+D2THcoNY3hQ
         C6EAU9hDeXHJBwoE5ac3D77ZpP/LauDjQpgmQhafl9gCpP93vrVejX8XrvmyiR0x718k
         jcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zH/lcm6LmIXvgGP1ltmqCC3mJjw/Vvw4xUY5ydYPviw=;
        b=YXFo46Ah9rN/zVkU+aG9pLPyXajiOdI+9/IyikIh1Cl+UF7USM0sLbtIvprZQyyorP
         nmLB7RpUCe6A8oMItnf4W7VbvR7iRiZNAG5722WHnjOPIYrOhiep+cwymGNORAvhy4z/
         rDQYVTJZgGMgsgq6Cq9S5mGddy80wRGeQjdeN/9yawLULaquf34tRHpPxJqji7lgwGxb
         W33IpA+U9lyAxs8ccV5GS/15L8iBDKl6gz9DkeQ2pyADR5H8I8Lb9Ofz8Tm3R7kXsNCd
         WtcQhmpbxtZQZdQN9I3E1nd3/Fa1eSEUUHMk/e4sEo1eMs9DOqpgp27iur/HOPj6MtIb
         9rAg==
X-Gm-Message-State: ACrzQf1CESBo6VYDQkXtKiKNIWLqtyjZOEuET2HzLvZI5k/P/BGeW+o2
        npwn8KVkJl2F/v02F29F1MoX6Q==
X-Google-Smtp-Source: AMsMyM7c8RTmfI+75QrXdZQGyYNNXuzZYsJrOTCHFJN7lC6X/4vpOGOmoZtTK1Kh0qp/J3bexjiSUA==
X-Received: by 2002:a17:90a:8c8e:b0:202:883b:2644 with SMTP id b14-20020a17090a8c8e00b00202883b2644mr48398722pjo.89.1666232791147;
        Wed, 19 Oct 2022 19:26:31 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id n190-20020a6227c7000000b00565cf8c52c8sm12435892pfn.174.2022.10.19.19.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 19:26:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221020014710.902201-1-rafaelmendsr@gmail.com>
References: <20221020014710.902201-1-rafaelmendsr@gmail.com>
Subject: Re: [PATCH] io-wq: Fix memory leak in worker creation
Message-Id: <166623279015.153364.8618304798678076215.b4-ty@kernel.dk>
Date:   Wed, 19 Oct 2022 19:26:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 22:47:09 -0300, Rafael Mendonca wrote:
> If the CPU mask allocation for a node fails, then the memory allocated for
> the 'io_wqe' struct of the current node doesn't get freed on the error
> handling path, since it has not yet been added to the 'wqes' array.
> 
> This was spotted when fuzzing v6.1-rc1 with Syzkaller:
> BUG: memory leak
> unreferenced object 0xffff8880093d5000 (size 1024):
>   comm "syz-executor.2", pid 7701, jiffies 4295048595 (age 13.900s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000cb463369>] __kmem_cache_alloc_node+0x18e/0x720
>     [<00000000147a3f9c>] kmalloc_node_trace+0x2a/0x130
>     [<000000004e107011>] io_wq_create+0x7b9/0xdc0
>     [<00000000c38b2018>] io_uring_alloc_task_context+0x31e/0x59d
>     [<00000000867399da>] __io_uring_add_tctx_node.cold+0x19/0x1ba
>     [<000000007e0e7a79>] io_uring_setup.cold+0x1b80/0x1dce
>     [<00000000b545e9f6>] __x64_sys_io_uring_setup+0x5d/0x80
>     [<000000008a8a7508>] do_syscall_64+0x5d/0x90
>     [<000000004ac08bec>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Applied, thanks!

[1/1] io-wq: Fix memory leak in worker creation
      commit: 839a0c962971a5a95515c1637aede8a4fbc6547f

Best regards,
-- 
Jens Axboe


