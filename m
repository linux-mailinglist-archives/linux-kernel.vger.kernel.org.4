Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4173E401
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjFZPx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFZPxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:53:55 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93059121
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:53:53 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-345b234a77cso307015ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687794833; x=1690386833;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxYUiFwhtDVlTAVmP0i5cJapN3iCRWyez54K4Q3M5K0=;
        b=fdLOwHJv7E9Y9/oI7jGWPCAUo74FJC0T9kGCDMP3eKcy54hd6ejtYByg0NmOoIEdyr
         gj0afBnKBBbvcnvlJSD3tWZwAQK857zOub5M2aClWt8xZVL1eEu/MH3R3eNfCtShp8NK
         vzVrZP0lQhR8CvJ5TIK7Cs3q2y2rUoay2IjYw8OpjA7Qwe0AiARj7mTmz2FCvlMzjUnp
         KOV71fe4ad7eK13d6b8MlCIs0HqJLoGIwBH/rxN2f5CHWqmveJ63YVCcyPay8/+4K32z
         JnewvYc+JGyJ59T3v0VmPLUuvFOXAeDAPif976GY9jj1VlABIR08gifXKJBP4XXJNKDC
         cILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794833; x=1690386833;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxYUiFwhtDVlTAVmP0i5cJapN3iCRWyez54K4Q3M5K0=;
        b=Bn9xF34M8tnfRfG46m9ciM1b/owjF0cp63mlmn6hATIpIO825fwz1oRVLQja4fIZOj
         BxBgzHIaoIa2ZDGWBk3OIinvZDnKGwttDdHQuA7j8oizojOaisoe1IctOSGz/xOboHsB
         T2XnvhyNhX1oiUiYW4XbywOG5K6pY+5w4M0l6P0RxzRdx1CYdGH/NBPybIYY2JO3iKRX
         eLsfbYvwOK5UA0xvD3BVeSZNmYwOzsCNrSg4YnRb0pADrRAhP9jddjBM6f5bJmOQqbfA
         9p1Vct2lZgqrRtDqtdqQzyR0auFaAswTRhY/9ZRgSF1L0vCqtQOGxLHZffRC1W43oVc1
         Br5A==
X-Gm-Message-State: AC+VfDyigc6Tcj0aJ3zmPx8IBOBQmF+Ug1NyotxucsTBtXh4qVBtG7ph
        TxqPglg4aFbkc+Lc1XQN/t+3gw==
X-Google-Smtp-Source: ACHHUZ4nRcSpYBrb6wVzWbwMsFltauZSqk2epQ7Q09VlLGPrMGE/HyQypZzUg+d1X5viDDmbmIOtyg==
X-Received: by 2002:a05:6e02:2182:b0:343:9470:4ee8 with SMTP id j2-20020a056e02218200b0034394704ee8mr22302967ila.3.1687794832868;
        Mon, 26 Jun 2023 08:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z13-20020a92650d000000b0032afe23820bsm2061980ilb.17.2023.06.26.08.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:53:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230527010644.647900-1-yukuai1@huaweicloud.com>
References: <20230527010644.647900-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v3 0/5] blk-wbt: minor fix and cleanup
Message-Id: <168779483122.109817.4432808514358640761.b4-ty@kernel.dk>
Date:   Mon, 26 Jun 2023 09:53:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 May 2023 09:06:39 +0800, Yu Kuai wrote:
> Changes in v3:
>  - patch 1 from v2 is sent separately, and it's removd from this series.
>  - add review tag for all the patches.
> 
> Changes in v2:
>  - make the code more readable for patch 1
>  - add a new attr_group that is only visible for rq based device
>  - explain in detail for patch 4
>  - add review tag for patch 2,3,5
> 
> [...]

Applied, thanks!

[1/5] blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
      commit: 645a829e03384a235b3760959d4ebe420a0f2027
[2/5] blk-wbt: remove dead code to handle wbt enable/disable with io inflight
      commit: 71b8642e79f277459555629f2bea1a8d1fed307e
[3/5] blk-wbt: cleanup rwb_enabled() and wbt_disabled()
      commit: 06257fda83ebfd1c33fb992e41dba7be4e1184d4
[4/5] blk-iocost: move wbt_enable/disable_default() out of spinlock
      commit: eebc21d12f56c1e09a163abf91e351fa2a55a938
[5/5] blk-sysfs: add a new attr_group for blk_mq
      commit: 6d85ebf95c44e52337ca1d07f0db4b435d1e6762

Best regards,
-- 
Jens Axboe



