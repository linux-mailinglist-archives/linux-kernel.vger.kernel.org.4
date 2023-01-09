Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95CE661CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjAIDaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjAIDaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:30:08 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DAD5FC9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:30:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso8022424pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 19:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1Q0s3QZP3zgMoieH09ETwIZdLie5eQr6iy50h+rqPs=;
        b=53o2f2czGsiadqF8jeoKIJ9bjpIMB+3jP+24mrPAyfFwUmUX6qSkx0LpX8JBjk/y2D
         /zVzBFSraoYAG/2RZZNqZm6+7XyQ8qGpOB0d97N2ATqfS0AFBsBGjmD7dbUtaoD1Efti
         EPDzn3gUBg+rAFjHwy8VAxPg8a/RIxruvrKbFg2/DyWNnrXa/XM6FpphPhyG/0fd4JyK
         8mccONWce58PXfyURCPRZbDGQpwgBzQyLLzLV9d6oY5Ztgu7hQl0cdT+X4jPwYPnwMfB
         tQ56VmDyFhqMj94Z3D6Y+XPiJLF4L61cTueI67N2tar93NMNbYTBMFECfnTAAvZ6D3E/
         B7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1Q0s3QZP3zgMoieH09ETwIZdLie5eQr6iy50h+rqPs=;
        b=OYrC0AgqCqrBpGLC18RJJgZYPnFCzJQpUZwzTZk7Gr+1iVLRGwHhunzpVcQteoDqso
         cd5Ix2XEzEofKsbvwdMvXLrqOE8IbzMF1eUTovC+x8u9cZcSa8a52pxb7yp+Fe3fSuz0
         TKcoCiki8UI6wSrvWobF+16akW2MgSpb16yg+MT6UxxJzmZxNQAZFBc8d+gJINa/g3Gv
         F+oamV+1Hf15NX+rFMFuHbv9N9ruvis9py2H1HrEReTty+I0FO81WVPt0GCXqMCBNQV+
         1JQmRV5ACa40N1ZFBomFAE+/Nzuk3ayheKrMk9ygLEJ8JSkpgai8kORZNJYsOB7V3EUJ
         gwag==
X-Gm-Message-State: AFqh2kom2SXNJJ7leidj/agKVHDNa6cxv2hS3Da0TmJqY9YS1Wpxybvv
        a/G2EABLf/GlLbfBMkgb3W220YjkvmtLQZTN
X-Google-Smtp-Source: AMrXdXsxPtBfJ2yhCEFV7jgfVbDZJ4zEnmdJgwY/fXZ8EruCYvaNWOFlrqmk9onvRakIQ2QISugdbQ==
X-Received: by 2002:a05:6a20:a6a7:b0:b5:c751:78ac with SMTP id ba39-20020a056a20a6a700b000b5c75178acmr780704pzb.2.1673235003564;
        Sun, 08 Jan 2023 19:30:03 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ik9-20020a170902ab0900b00183c67844aesm4858264plb.22.2023.01.08.19.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:30:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Y7iFwjN+XzWvLv3y@slm.duckdns.org>
References: <Y7g3L6fntnTtOm63@kili> <Y7hbYPSdLqW++y/p@slm.duckdns.org>
 <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
 <Y7iFwjN+XzWvLv3y@slm.duckdns.org>
Subject: Re: [PATCH block/for-6.2-fixes] block: Drop spurious might_sleep()
 from blk_put_queue()
Message-Id: <167323500264.3803.6715346209932603598.b4-ty@kernel.dk>
Date:   Sun, 08 Jan 2023 20:30:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-cc11a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 06 Jan 2023 10:34:10 -1000, Tejun Heo wrote:
> Dan reports the following smatch detected the following:
> 
>   block/blk-cgroup.c:1863 blkcg_schedule_throttle() warn: sleeping in atomic context
> 
> caused by blkcg_schedule_throttle() calling blk_put_queue() in an
> non-sleepable context.
> 
> [...]

Applied, thanks!

[1/1] block: Drop spurious might_sleep() from blk_put_queue()
      commit: 49e4d04f0486117ac57a97890eb1db6d52bf82b3

Best regards,
-- 
Jens Axboe


