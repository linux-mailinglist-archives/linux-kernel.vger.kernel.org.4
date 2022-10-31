Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487496138FA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiJaObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiJaObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:31:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541DA65B1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:31:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h193so2154074pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxCaUCeOv04svZ2y77cTIK0oMsYuJugdQM+dBKql0sI=;
        b=IRZ7eArpvlGdYkmcQnoG9wRJvZZRYTOjv+75+y7qrqJKP2eRSqTED0/2qbTkhBWLQW
         qn6F2oOnAkXe27Mlw/oX0MzgGhHNnKSSeUVp1LwXVkfASc9oJmR9NUJDoZLNK/A3QG1B
         GmbS7ns5SNp/q1n+LLOfa64KEfp0iHYPXHbvbaCa9ITNIC1pR/x7eGt/GQF2iXVRZSqA
         qomXVk0ErCe9GL1yOpI0pfSEa6Mxrkb4r8R8yFhVatklAs3hKVhzpxNSUak7jLw2GCqM
         aeScFdmz9vKOOVTOm5EL0jHJ1+f6j4vYA5SoJm/ZacGiQQNgyROHfnSxjZHBastsJFPd
         +Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxCaUCeOv04svZ2y77cTIK0oMsYuJugdQM+dBKql0sI=;
        b=KmduG7vxT+yLil39I3OSUTPSj35esJBqZiJO7Ybln0ZxIy7ADw0Sfd81k7F00L5l27
         wUmpZAfsRSuYLXO6hffFGKBRmCbz2qUbjLcJ+QRxtrjYz2dseowa1Wgh0SD8pFgi9Uy9
         lS1YzRZPKFSRAYXG3vy4ruF2PLoouLgTmd2IvqW6A0NcfSAQ/yQxjn+h+v4qz/mR74Jx
         zrTWGZfChs9620Wyi4t+KgClG/OvpO8ouki2xCoPtAzueoZ8sH2ZahnSiPeVsJOVkwsH
         aZ5i4RhgScgrbp6RaruDFUh207YbG9PGqlggOQCjhaxqKwKMWv8MSgSo7jFsNHATt+jl
         1S4A==
X-Gm-Message-State: ACrzQf3ywWpcOCGpXMlCZyC4iq3iN0CYDR3fftnAqx0FkQ5pfRMHPiF5
        yIRh+SgJMMVarI3Mn8jBAVjuCgM9H7PiMsUk
X-Google-Smtp-Source: AMsMyM6k2sHCrwoWqguXpQcWH+977dJthW1xU3lPj4RysM6XzuN+9vHs092ZksVUjGHPd1nUx3Gv5w==
X-Received: by 2002:a05:6a00:16c4:b0:535:890:d4a with SMTP id l4-20020a056a0016c400b0053508900d4amr14795660pfc.0.1667226668625;
        Mon, 31 Oct 2022 07:31:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b0017f36638010sm4552508plg.276.2022.10.31.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:31:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, will@kernel.org, ming.lei@redhat.com
Cc:     xuqiang36@huawei.com
In-Reply-To: <20221031031242.94107-1-chenjun102@huawei.com>
References: <20221031031242.94107-1-chenjun102@huawei.com>
Subject: Re: [PATCH] blk-mq: Fix kmemleak in blk_mq_init_allocated_queue
Message-Id: <166722666769.125558.7022234189834891609.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 08:31:07 -0600
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

On Mon, 31 Oct 2022 03:12:42 +0000, Chen Jun wrote:
> There is a kmemleak caused by modprobe null_blk.ko
> 
> unreferenced object 0xffff8881acb1f000 (size 1024):
>   comm "modprobe", pid 836, jiffies 4294971190 (age 27.068s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff 00 53 99 9e ff ff ff ff  .........S......
>   backtrace:
>     [<000000004a10c249>] kmalloc_node_trace+0x22/0x60
>     [<00000000648f7950>] blk_mq_alloc_and_init_hctx+0x289/0x350
>     [<00000000af06de0e>] blk_mq_realloc_hw_ctxs+0x2fe/0x3d0
>     [<00000000e00c1872>] blk_mq_init_allocated_queue+0x48c/0x1440
>     [<00000000d16b4e68>] __blk_mq_alloc_disk+0xc8/0x1c0
>     [<00000000d10c98c3>] 0xffffffffc450d69d
>     [<00000000b9299f48>] 0xffffffffc4538392
>     [<0000000061c39ed6>] do_one_initcall+0xd0/0x4f0
>     [<00000000b389383b>] do_init_module+0x1a4/0x680
>     [<0000000087cf3542>] load_module+0x6249/0x7110
>     [<00000000beba61b8>] __do_sys_finit_module+0x140/0x200
>     [<00000000fdcfff51>] do_syscall_64+0x35/0x80
>     [<000000003c0f1f71>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> [...]

Applied, thanks!

[1/1] blk-mq: Fix kmemleak in blk_mq_init_allocated_queue
      commit: 943f45b9399ed8b2b5190cbc797995edaa97f58f

Best regards,
-- 
Jens Axboe


