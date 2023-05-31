Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD0718737
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjEaQVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEaQVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:21:16 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E717911F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:21:14 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7748ca56133so25041939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685550074; x=1688142074;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCNYIZMh0VCAQl5u0ro+C+7Me91NUFmJ7xbiQ3ZleV8=;
        b=MqO0Qkc6Sft8fEB3qZM360EkSqalNMCwvMjFTbWOGu66sPWBuCG5IJgUXUuZ5m2V8S
         5PeBprTTw2d0Da2qtV58unpQ7f9FO/BUa82lSVHAQzdNMW+8kFvKzDmmaww6X8ZqSP0s
         uNLgEMu/qCTy3U08EbCHMrAbqBC2Mamt+yjUMM7Los7dvOCzJgoVaCitstuvw10w0xmu
         9krP9H4u9CNElc5lhDagCUGt5eUTX4LrtZjiNV4SKETk92bdBtOStUMvc4+MKVX39D9D
         yyqBygfsY43tDmnu4rgMG0TjVbSK0X9dC8c6BhgXoYpPSRzhswbxVwK04BBd7g9wE0Fo
         bVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685550074; x=1688142074;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCNYIZMh0VCAQl5u0ro+C+7Me91NUFmJ7xbiQ3ZleV8=;
        b=OE+Zc7lao7KiAWhBPAbVGK/14xJgXnEdE+GHhqnUkIoe+jlZxbn3EMvnTtldexM5IK
         Yf53c/onpB0/ZHnZftFe7ETU2Aai35dnpggDCUYVUL4dxxbrWpp/02QLDtX3GMaoILGu
         S5kb1mHqy1J/1R8mL/ToTGldD81y3evc4aIwyYQrsaLld52aGk0hSkIfUzhPb5Gj0MH0
         meNyK0MMa5EFTgAk+11RwQ/BnM3mQmZD3UrrOKRmAd8lVBeI+MeVO/lPET9+tSeYziC+
         BSK5EpvoTxCfrB56glkfJMbaiZ5Ag7eSnE0XtvsCu14C3Y4qRDhC51CcchXxaSfqPCh2
         T/eQ==
X-Gm-Message-State: AC+VfDy2ts/acMvjcFcVpTroVK7+Ueq04fe9br6eQlrLMEfxb6An5sc9
        o0LBeS/0S47yBCPn8rU5Qqk6Yg==
X-Google-Smtp-Source: ACHHUZ7XkmaaL84ol4JPVQFe78ajEmm17OiN1f3wTJZYxvO25zasrvdApynXoJiQuf9643RbgcNMIw==
X-Received: by 2002:a6b:5f1d:0:b0:774:9499:6590 with SMTP id t29-20020a6b5f1d000000b0077494996590mr2005418iob.2.1685550074318;
        Wed, 31 May 2023 09:21:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w13-20020a022a0d000000b0041669a9fb62sm1486855jaw.131.2023.05.31.09.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 09:21:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, dlemoal@kernel.org, quic_pragalla@quicinc.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
References: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-ioc: protect ioc_destroy_icq() by 'queue_lock'
Message-Id: <168555007304.194776.14532611731698933970.b4-ty@kernel.dk>
Date:   Wed, 31 May 2023 10:21:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 May 2023 15:34:35 +0800, Yu Kuai wrote:
> Currently, icq is tracked by both request_queue(icq->q_node) and
> task(icq->ioc_node), and ioc_clear_queue() from elevator exit is not
> safe because it can access the list without protection:
> 
> ioc_clear_queue			ioc_release_fn
>  lock queue_lock
>  list_splice
>  /* move queue list to a local list */
>  unlock queue_lock
>  /*
>   * lock is released, the local list
>   * can be accessed through task exit.
>   */
> 
> [...]

Applied, thanks!

[1/1] blk-ioc: protect ioc_destroy_icq() by 'queue_lock'
      commit: 2dea233fdc6a00e53bf2ee5cd4b6fca353fd81f8

Best regards,
-- 
Jens Axboe



