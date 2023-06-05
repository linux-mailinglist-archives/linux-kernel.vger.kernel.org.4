Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE188722EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjFESbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjFESbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:31:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC0F1;
        Mon,  5 Jun 2023 11:31:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-653bed78635so2076679b3a.0;
        Mon, 05 Jun 2023 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685989877; x=1688581877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usnkZ76/foY9UJhYGSnPlQxyp1CPa9L1vTnAf5ryxaE=;
        b=SCjp70qdzoSdFk7YXwoHOJPQVKrUFWBcHQolEZVkY2amb+A3jADHUmcS1aVDjXhIrc
         Rb/Go5IKAWmq8DE1jldzMhxAl8wk6/SF/BKWxFfhD8YMYYYF54U83bKZE1m5SEAnC6wK
         0s1FrlMB687vMqXXkiCnMQ/XlRafSRgodlJl4P20vTsS2LdqMuP/f5xGzkb9Vbm4YgkF
         aO08qbYuEis9S0DPMrhyIKTg6qe2vGCf6Xt92UHUMlhGrGvy69kHQStrpWVYCykIIoPH
         4pAK27TAC/uDzKSedKFhEfXNKX7A+wZsRlWxb2oLRcSa1NmeGaYwQ62Icglq3KXQtew4
         86cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685989877; x=1688581877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usnkZ76/foY9UJhYGSnPlQxyp1CPa9L1vTnAf5ryxaE=;
        b=DwOZkqS3Wl5bmMrZdhjEs1D/yHvjBPcsG4xDtYaTJJxoXaGc4Qk25P6u3RKWfi7YCh
         VW8YOcM4y+Zxjy7n77Ty9DnRfy2towYanqqHItUoFFrRjvBZ98UA3KRyKHyBMQXE2BdC
         lpd3AKVpq64CzDJt1I0L881H7fnms6RS5R/pA2z2okCzAVL4XuYyCIiEn+iWIIwtXvJr
         YFEBWTOio0raOp4/s24M9FKutlnsYwghSieDIMI8BS5HSXsTOv0V0GxwB5fG2xwo0txF
         R6VG1z28vbiKabPE1ekjP34OCIROFqhPWT0gwas2Nhz99w+WgCSiKVP6X5O0hfclwBFX
         bjQw==
X-Gm-Message-State: AC+VfDyQj5TCS3ji2ugckN7GtcTwT/CMFMhXbzw89CtDlZjEJE9GFrUo
        0m+MKcrPdqOqKWucFJo9vew=
X-Google-Smtp-Source: ACHHUZ5Icpc8CzidVyFb2h3eh8Fzgit98a+Fj8QQKyYRTtqfutHMQNWANvdlM4IZTQ7I4TCY6G9/ZQ==
X-Received: by 2002:a05:6a20:1450:b0:10a:b812:bcc7 with SMTP id a16-20020a056a20145000b0010ab812bcc7mr8686501pzi.17.1685989876594;
        Mon, 05 Jun 2023 11:31:16 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id t24-20020a635358000000b0053f1d55676fsm6060144pgl.2.2023.06.05.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:31:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 08:31:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] blk-mq: fix incorrect rq start_time_ns and alloc_time_ns
 after throttled
Message-ID: <ZH4p8tqFc57_OYoH@slm.duckdns.org>
References: <20230601053919.3639954-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053919.3639954-1-chengming.zhou@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jun 01, 2023 at 01:39:19PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> iocost rely on rq start_time_ns and alloc_time_ns to tell the saturation
> state of the block device.
> 
> If any qos ->throttle() end up blocking, the cached rq start_time_ns and
> alloc_time_ns will include its throtted time, which can confuse its user.

I don't follow. rq_qos_throttle() happens before a request is allocated, so
whether ->throttle() blocks or not doesn't affect alloc_time_ns or
start_time_ns.

> This patch add nr_flush counter in blk_plug, so we can tell if the task
> has throttled in any qos ->throttle(), in which case we need to correct
> the rq start_time_ns and alloc_time_ns.
> 
> Another solution may be make rq_qos_throttle() return bool to indicate
> if it has throttled in any qos ->throttle(). But this need more changes.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Depending on the flush behavior and adjusting alloc_time_ns seems fragile to
me and will likely confuse other users of alloc_time_ns too.

Maybe I'm misunderstanding the problem you're describing. Can you give a
concrete example of how the current code would misbehave?

Thanks.

-- 
tejun
