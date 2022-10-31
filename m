Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648861381E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiJaNcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiJaNcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:32:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA6A186
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:32:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so10281336pjd.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRx4c97dxlZARSf0pXzKUxKSmewMkvqFqpXULat30TY=;
        b=X7vQz0ynmmKHnuxcYEkg27UDLb7o7h65YUenYhNtFTothhirhX9GuYenupHtEu47x4
         8igUWatnuNoI6Wu9diYqgZW0gDhFw5S6dThL3dZ9I8reXtw4ZHdc361jGren3HXwU21Q
         jP7Bn9IvTgUT+CTvlnpGg3AHlmlWQbclEldVcbxUXXqmpgMmYEKHOYcuPEO3eXnW1oOj
         u2qOpt1YLy7cjj4undsoeNJbbs2M5G+nqQ+P338ZYlzlcjF99jAiZHBfsw8dnhkIaADc
         2NRFHnjv4DVPRuza2frVoR1E4TW3ABjj5dqG9iXbePf6uaYuVKuE+eJQM0E2rnFx1hQX
         BSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRx4c97dxlZARSf0pXzKUxKSmewMkvqFqpXULat30TY=;
        b=fj+b7o+cEhNxSOlaKLjg3qLHGhQl8K0/em30DXdl16e5kmoK6PA7qvT8+08Y3Niw1p
         fbd78vP1TjHL8R6ibUvq93cnh58ZMMktPYOF4V1S2EJUiCdzVAkfnoNsuDj/LzgMwSaD
         +sFjZHPjCbmfsqaC+B4DssvaNs69L1G/vSbPxoICwi7vFUUbPpOlVZSg0fUw2HTY5XcR
         XFeJbm6KWd2ZqJloiTJU3WrEAn1beKJlpFjupyhGXuaHvDvQLkp4QVpLygQsc1kmi/3l
         J3oohkUEH126O5q50DBXKmXdpP+K79fA0ADOV5gZ7KSRvwKKNP1XLutuvVn1li37zWN1
         akIw==
X-Gm-Message-State: ACrzQf1MmX7vmoJrKX4iZf+eAi5t4cnEx+ZsWLnC7VJ4oKvDX42kDoNC
        ahwdF55zeGisUJv9pYmcyiWnuQ==
X-Google-Smtp-Source: AMsMyM7prUdvNlfH2oRedW1t0cTpDNOHB43CbuNyJjjHLbSEN4IzOwU9QZdX0FKwfJV6AvwUqEE/Hg==
X-Received: by 2002:a17:903:2402:b0:184:29:8ac0 with SMTP id e2-20020a170903240200b0018400298ac0mr14040001plo.174.1667223133865;
        Mon, 31 Oct 2022 06:32:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t189-20020a6281c6000000b005668b26ade0sm4565791pfd.136.2022.10.31.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 06:32:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, bvanassche@acm.org
In-Reply-To: <20221030083212.1251255-1-nickyc975@zju.edu.cn>
References: <20221030083212.1251255-1-nickyc975@zju.edu.cn>
Subject: Re: [PATCH] blk-mq: remove redundant call to blk_freeze_queue_start in blk_mq_destroy_queue
Message-Id: <166722313299.68022.4225942407488507995.b4-ty@kernel.dk>
Date:   Mon, 31 Oct 2022 07:32:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2022 16:32:12 +0800, Jinlong Chen wrote:
> The calling relationship in blk_mq_destroy_queue() is as follows:
> 
> blk_mq_destroy_queue()
>     ...
>     -> blk_queue_start_drain()
>         -> blk_freeze_queue_start()  <- called
>         ...
>     -> blk_freeze_queue()
>         -> blk_freeze_queue_start()  <- called again
>         -> blk_mq_freeze_queue_wait()
>     ...
> 
> [...]

Applied, thanks!

[1/1] blk-mq: remove redundant call to blk_freeze_queue_start in blk_mq_destroy_queue
      commit: 56c1ee92246a5099a626b955dd7f6636cdce6f93

Best regards,
-- 
Jens Axboe


