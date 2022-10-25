Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881B860D4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJYTmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiJYTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:42:15 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9CBD640
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:42:14 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id o65so11394003iof.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo5gCdV4HOvdCiIDRmFlmf80DqTwgnkZIIgLG7LqzFw=;
        b=POGwl/v2rAIo0Tt8sQBMm76r7/ZH/JK2/Bf6HuuKIWp+RTvj20FhYbzdX77Nur/6Bv
         VaYgFwBsjPzEQN6j70X43WCcut6uSzrwySJTL9c2SJWkNu5QCLte63YBL05pklfjK4Pw
         avjIVI1XK7tlszMx5qvLCLFKLVw/cZjy1/UVZkc8RX4BLMRcehnJVpPdGIwa7R/+67u9
         U2tnUaFc7AI8AWJn17LTsd7imwunI6K4zK97jEB44Z8yuNM9wRZAyWUCc1NDNhUn1cK8
         3+FT8wZNLu4QfCTqhlA6Rm+auoPbYvHBhxpc3aATbmhWwVOLltX8J/mTYEglJCDMucdc
         Ff6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo5gCdV4HOvdCiIDRmFlmf80DqTwgnkZIIgLG7LqzFw=;
        b=RLJ+zfKXGlM7IDqo6V2MWX/QpwAVmc8fD1+SiT0bZ8K0m6MDwUon2dmoFmLZWZBAFS
         ChRGrvLV42zZl+sSyQB07WozqiPgobnppxuTnAJxWWu6av2JEN1ioNMhBVQzmeCvHlX4
         8r/0G8UO/Elh7UjuqHvH2c5JgPRq94dHAR/X4MM+D7Wto7sPOPapYBukBCxOioXHqd3J
         KW14nL6ycFUjmp0VOddv1iAiyQHQUslbpqo8jXaVoN5MhQnSLYzvCBZYbsR4p7oLXgTu
         y0fuzaIXLjoDsy/AHNL+O+EdVc9z104eqe5RspRczvL6HaZk+5NehV1lMMjJg/vZBHpT
         xdSA==
X-Gm-Message-State: ACrzQf1ed99w4Fh8jo4mOLwB6s0Rr5XFxs9XdNW1G1PCTr2Fv6MeZaxc
        DEQq22tqPY+Wl9qotlEtBEnFracpmXkCA8Go
X-Google-Smtp-Source: AMsMyM48aBtAi9RmmmRoZZeLkaEfwha1HYWhziCKd3iVYYUja5LyHNtr3FZa1xP/yiCE6+RA1WsXTg==
X-Received: by 2002:a05:6638:25d1:b0:374:f8c2:bf7a with SMTP id u17-20020a05663825d100b00374f8c2bf7amr5089585jat.270.1666726933999;
        Tue, 25 Oct 2022 12:42:13 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n17-20020a92d9d1000000b002f9b55e7e92sm1318548ilq.0.2022.10.25.12.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:42:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        io-uring@vger.kernel.org
In-Reply-To: <cover.1666347703.git.asml.silence@gmail.com>
References: <cover.1666347703.git.asml.silence@gmail.com>
Subject: Re: [PATCH for-next v3 0/3] implement pcpu bio caching for IRQ I/O
Message-Id: <166672693299.6037.1642967404693492462.b4-ty@kernel.dk>
Date:   Tue, 25 Oct 2022 13:42:12 -0600
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

On Fri, 21 Oct 2022 11:34:04 +0100, Pavel Begunkov wrote:
> Add bio pcpu caching for normal / IRQ-driven I/O extending REQ_ALLOC_CACHE,
> which was limited to iopoll. t/io_uring with an Optane SSD setup showed +7%
> for batches of 32 requests and +4.3% for batches of 8.
> 
> IRQ, 128/32/32, cache off
> IOPS=59.08M, BW=28.84GiB/s, IOS/call=31/31
> IOPS=59.30M, BW=28.96GiB/s, IOS/call=32/32
> IOPS=59.97M, BW=29.28GiB/s, IOS/call=31/31
> IOPS=59.92M, BW=29.26GiB/s, IOS/call=32/32
> IOPS=59.81M, BW=29.20GiB/s, IOS/call=32/31
> 
> [...]

Applied, thanks!

[1/3] bio: split pcpu cache part of bio_put into a helper
      commit: 0b0735a8c24f006d2d9d8b2b408b8c90f3163abd
[2/3] block/bio: add pcpu caching for non-polling bio_put
      commit: 13a184e269656994180e8c64ff56db03ed737902
[3/3] io_uring/rw: enable bio caches for IRQ rw
      commit: 93dad04746ea1340dec267f0e98ac42e8bc67160

Best regards,
-- 
Jens Axboe


