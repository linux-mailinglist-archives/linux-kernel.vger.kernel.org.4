Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB56758EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjATPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjATPlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:41:16 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3703DD0DB6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:41:05 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id p12so2867155ilq.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75d/J3khF4Dbn5fzcg9rN+6VjL8Dp9ov4rvyfMDhcrA=;
        b=d0ImBQUcvTZTl3HjI5diPzn7jbqkwmc3vqXckaGORUu5tvc7yjV+m9rM/VwD7qHNNC
         x2RtXoPZ4eQNDe+qK5E64wQxWuTvEMJW2JzdihOZMQXCTv7dfi8po7hZ9QSfZ8qkld3r
         McFuj7fZdPKHnfFWyx1ZLGCygyyrqw8DBo/T6lL9Gdy7yw7G2OExUaMVozQmRvKe00hS
         lyxPO5bCHwUAClFaQjzAc34hpaR+3De1IELIEZhc1krmX+3N3q3T5sKgesLgbkhNHmCW
         XzL2H8tm86Bsk80LTqCnZgO4OEOLilC/ctj2eBt+f1sLY3JvLnczzg8spDj7C+ZTXWVH
         AB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75d/J3khF4Dbn5fzcg9rN+6VjL8Dp9ov4rvyfMDhcrA=;
        b=ypqM4jgO7yTvHBKgfLF3PbdlwSLpCf89utG7ZhC/t7TylrWL8eZe1ZnUjZ7Ng6GNnj
         GWrTROWjDg2zFKPu98K5xosnazn9VB/4djU+4xalS4W5oYCgwv4cHOGq3L/jtsKl1VKs
         spfS4eCF4PGNPerz9XUCKzCE7pA2noxKpz/IA5tJAwHqYE0PdTDGxq3jHmsmo9Cr8fEB
         NxQsY72ZKHW6NPralI1nwBBgsf5RSAPFsQAQbf8ythiciulRiEA5oyl8Mq4RPUnvI2Tb
         Qc6/7kvcD86yLVYfetCtKM0LuxH8O1ZYxIDP0KVLy84q0ecgEKRzFElBDovccaalgi9V
         UI2w==
X-Gm-Message-State: AFqh2kr07/s6fIP74cxFbiZejgqdkNk2pmnKCDYggqmIqdEl3SywbwwB
        +JcVrjFPxNYwf5QJ2/U/xPspUA==
X-Google-Smtp-Source: AMrXdXsFAniWNJYHa0I4E+Li9JxU/x4AKyLut7pnBhtNvWpyJboraEoqFVg9HDjCLUwDIhX6MwrJLQ==
X-Received: by 2002:a92:c5d1:0:b0:30d:9eea:e51 with SMTP id s17-20020a92c5d1000000b0030d9eea0e51mr2273296ilt.1.1674229264495;
        Fri, 20 Jan 2023 07:41:04 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l14-20020a92700e000000b0030c27c9eea4sm11664570ilc.33.2023.01.20.07.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:41:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     asml.silence@gmail.com, io-uring@vger.kernel.org,
        Breno Leitao <leitao@debian.org>
Cc:     kasan-dev@googlegroups.com, leit@fb.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118155630.2762921-1-leitao@debian.org>
References: <20230118155630.2762921-1-leitao@debian.org>
Subject: Re: [PATCH] io_uring: Enable KASAN for request cache
Message-Id: <167422926391.670047.2726157847923072257.b4-ty@kernel.dk>
Date:   Fri, 20 Jan 2023 08:41:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2023 07:56:30 -0800, Breno Leitao wrote:
> Every io_uring request is represented by struct io_kiocb, which is
> cached locally by io_uring (not SLAB/SLUB) in the list called
> submit_state.freelist. This patch simply enabled KASAN for this free
> list.
> 
> This list is initially created by KMEM_CACHE, but later, managed by
> io_uring. This patch basically poisons the objects that are not used
> (i.e., they are the free list), and unpoisons it when the object is
> allocated/removed from the list.
> 
> [...]

Applied, thanks!

[1/1] io_uring: Enable KASAN for request cache
      commit: 9f61fe5e410444ccecb429e69536ecd981c73c08

Best regards,
-- 
Jens Axboe



