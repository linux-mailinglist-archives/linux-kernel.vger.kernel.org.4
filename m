Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEEA68DA7C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjBGOWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjBGOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:21:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF6EC54
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:21:53 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id hv11-20020a17090ae40b00b002307b580d7eso11299134pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuLo5xmCQA7HCDPYB+dPYCIEzUJh8YFIDf7ruxM4qCE=;
        b=mymHd5wVulEhDFURIvOVP6Canl4YaLV7h7awsmV6Nul3FH+zKN7q74r17SdAJYSeuP
         8JL5z/f/a7fW38AfgDMHY4+0SrSkuX186tfukvztq5d5D+cpoumBkozUNSUKrtqS5kWx
         jGfq5jYJk8pPqFEHPJVzH7Cq5eLFdyv+Ygh5OfoNCxwLlv7kRu5mDVv/Tm0DP9j5vmMR
         PnubS3nBbOdCuE1UIF7n1fIXwYdXEHHA4wqV0rfzRnZh0oICVMLJVxRA513Iolwpml1+
         KrXX/mk8GeXw+PSa+AvcFZH6meQ7USMkugMRBYJTL9oYTScX7lGL1D0YTOxa7t9HuQFX
         VEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuLo5xmCQA7HCDPYB+dPYCIEzUJh8YFIDf7ruxM4qCE=;
        b=KbNWo8tmk7Dr9Oy2KY4BWwNABemaWNvd4KQZl0ExhscSDcB6miI+yFVE/AgL5L3YFQ
         0HbwBdM/X2tnAZhMYTELZQeA8Urjm+q/w8WaqKiaJn3t7vQQsGsyjJvh3BPFfobK1GYL
         WsKgZUCsiu/iAvuDmVt2SWPkV+36SKarFHNc5V9ujULZvzocoTuX/piXy8h5eUkx3yYw
         yxQvoK6+zmFWuKmMj3Jbs4MOB9ZCIlxRA7/63yIKg+mwQ8iMSsIgi4fbzJlbmGwzOovt
         ivW/U2Lmv3obYQUzUWu0yZjmmx3JWgGb2nAXdHovDeRlszYGtPhn+omlh60xT05oUhPR
         1TBQ==
X-Gm-Message-State: AO0yUKVNKaUOdBqvZDsvzrRCB3Sgi75M15ENGiH8hVJ+7ZL3rrxGeufb
        Y7KdXH2xnHp0GeQCkcXOwpGrELtbpjM2nauF
X-Google-Smtp-Source: AK7set+lo6k1ZYQG6kZyGznnpvWpXiNfKJmSb4W9HbiZmZf0HC8PVSLbclmFhLiAR0S6qAJuDTZq4w==
X-Received: by 2002:a17:903:182:b0:198:a5d9:f2fd with SMTP id z2-20020a170903018200b00198a5d9f2fdmr3372813plg.6.1675779712592;
        Tue, 07 Feb 2023 06:21:52 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x20-20020a1709027c1400b0018963b8e131sm8937392pll.290.2023.02.07.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:21:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
In-Reply-To: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
References: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH RESEND 0/3] cleanup for ublk
Message-Id: <167577971177.163087.4942198134039715702.b4-ty@kernel.dk>
Date:   Tue, 07 Feb 2023 07:21:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Feb 2023 15:08:36 +0800, Ziyang Zhang wrote:
> removing unnecessary NULL check, unused variable and comment fix.
> 
> Ziyang Zhang (3):
>   ublk: remove unnecessary NULL check in ublk_rq_has_data()
>   ublk: mention WRITE_ZEROES in comment of ublk_complete_rq()
>   ublk: pass NULL to blk_mq_alloc_disk() as queuedata
> 
> [...]

Applied, thanks!

[1/3] ublk: remove unnecessary NULL check in ublk_rq_has_data()
      commit: 731e208d7b4b38d2bac4b7c53403c8abbf306d01
[2/3] ublk: mention WRITE_ZEROES in comment of ublk_complete_rq()
      commit: b352389e7ba34bdb5bcf4254fa1e85319ba76352
[3/3] ublk: pass NULL to blk_mq_alloc_disk() as queuedata
      commit: 1972d038a5401781377d3ce2d901bf7763a43589

Best regards,
-- 
Jens Axboe



