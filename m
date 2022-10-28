Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B326113AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJ1NzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJ1NzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:55:12 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594AB4E42B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:55:06 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e19so2973961ili.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tj6XPZgUzW8NJ94b23+3IuXwJoGOQr4AlpD0AF0r/6w=;
        b=Xlu1uPNMpYPUg0+TCziv/31NEm7rrpAH9J9cxIJ0HL4Ks3WBfICWa1sJYzimYnSruR
         MSHyU607tb/52sAo0Dlw5AN7oYNOwz1iPvMJjPNTPrxrDx9v0Cx3kCrdJrCM1p1wE9E/
         ox2mCg65fPbX6FrTZEwrmGkusuDTJSOgqZIUbvSpgmv+i/VWSqD4qUB8g4YbGUK7AtmS
         9ZDDk60XjREUnCoImKiS0YLPcXmv9CT3eaVKWpDre9DZrrb7KwcNMavUFRBOgCnqeFqB
         Pl61KwVnz141j7ZUqdwhFhQsRFqZvRtcgTmqnZ9xA2o5/DbVYm3M21fga+iYK080DQQ6
         NP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tj6XPZgUzW8NJ94b23+3IuXwJoGOQr4AlpD0AF0r/6w=;
        b=ZoY2nI53HIg3cisH4st5zhgYnmgqNdo/PPR0EaPNjYlPW9g739J2mUy1TB4GdTYDfh
         SZg0mq1JqdY9fUOvjh8ltjxEUbr9K1qqZ2daL69VG6HO85DiJdVhu1XzCQMgeoj2HFWA
         8/wzh90ktMYsVWikb7RrmjkEO29F77zqUxVH/n7/K5TycytkDQkE49jFCVlHwgtl6oY0
         vcJ6c6m9jGFH5xPf3a5KQYw7232qKRjoBCxLvjwIpNGP9prvXLdXj8RR3KUlKfFst3ZV
         tdqoVA1nEVlxUUIFsA3rwY4Cq7R6S9GAVOaHQYCaV02Y/XyYHpe9pyPMBe7HoH+CMxlo
         G7Cg==
X-Gm-Message-State: ACrzQf18KYdeiWsbj42Im1znC9/f2DayEjVrCcL38JSSpbpzbFYRs2nl
        /0QJafvc4HUDnhDouqPGzR66IODYiZyWg5iL
X-Google-Smtp-Source: AMsMyM4xFQNkAsTtD+ONkVrsD9AIwgTvJR5bGZF0QsaRtxvMxMiYp3OH0bt/EAjWQOe7H1sGReFw/w==
X-Received: by 2002:a05:6e02:1605:b0:2fc:405a:d04d with SMTP id t5-20020a056e02160500b002fc405ad04dmr34107225ilu.320.1666965305346;
        Fri, 28 Oct 2022 06:55:05 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y16-20020a92d210000000b002f9f44625fbsm1616544ily.52.2022.10.28.06.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:55:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        bvanassche@acm.org, linux-kernel@vger.kernel.org, hch@lst.de
In-Reply-To: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
References: <1666780513-121650-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH v2] blk-mq: Properly init requests from blk_mq_alloc_request_hctx()
Message-Id: <166696530392.41700.5029897700030243844.b4-ty@kernel.dk>
Date:   Fri, 28 Oct 2022 07:55:03 -0600
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

On Wed, 26 Oct 2022 18:35:13 +0800, John Garry wrote:
> Function blk_mq_alloc_request_hctx() is missing zeroing/init of rq->bio,
> biotail, __sector, and __data_len members, which blk_mq_alloc_request()
> has, so duplicate what we do in blk_mq_alloc_request().
> 
> 

Applied, thanks!

[1/1] blk-mq: Properly init requests from blk_mq_alloc_request_hctx()
      commit: e3c5a78cdb6237bfb9641b63cccf366325229eec

Best regards,
-- 
Jens Axboe


