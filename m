Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F78B5F8BA2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJINsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJINsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 09:48:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93440275E8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:48:42 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f140so8773210pfa.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkNfwa52J7sMrLHZ8QvF0WkiVrf7CKgOKzcDQJ9/luI=;
        b=k1m17xlTOhme5LjnFHKgn+i6FDJf1/xcwuohDL5UtMkB761MepQ/yAEfb8Vu2qwdt4
         QqpKlms3H9ASE6pAkgt/UR6ZOvmQ9g2Gf/KQV8SXwCLfUEgt6Xs+vswmLnsjankLpP1I
         2qnFNwZIk0NxQXqUfKcOlwpcLOXJLXED0Oi2Q6cpGOSJpb3ouXuEg53gy21L982u3kzm
         IRqumO28nEn9zaXXFeyCJC1U4u27cPK1XXdU8Hx0+r4u+oWxICi2xB8Kpks+Z/R5NdHN
         aMUtLxynywtPa5fMF0SB7rDrKzvc3WE+/KG1KKxNnYwAcB4VVuY4jYA8/Jv2gPMoodIA
         hAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkNfwa52J7sMrLHZ8QvF0WkiVrf7CKgOKzcDQJ9/luI=;
        b=PvVn59KpVUPSRQ8scOH3yCuXVEUOxJv05jaQDVDm7XPeSskRoHCyIZ33FOLIE4W7tp
         7OSpG8JhTv1fzWg8CL9s/7kgKqzXeET8uI9wgqmZfg1Dan3tfV9F7otJTh9pSZ5wRgew
         ULZENTuLTn1iqlT1s54neD4zYYCJFb4DUYQQ2e9IKruDymApLmLhsG037zdp1HloXQ6/
         +h1f1Y9/fQ+UbcI9lrn5ziOMqijc9BpEZXlM+JXc9sTFD4BIzEWzlrI8ZHFHqHp/LND2
         TzPYbyN5w4m+xT0Og839vpGOEQfGjDY5NOpl6N29kctfqgiYCGhLzD5JzedWimYFr1mw
         4pSA==
X-Gm-Message-State: ACrzQf0cUn6p3+FthnSnVCUe+HfX7ZlRLjGOIhk+rLZURqpFgUj3V1Id
        7PYhWpbFsPI9/qkN+NTiAl4pWg==
X-Google-Smtp-Source: AMsMyM4a6Z/RTEnbk7OiUCFaWLzKQzrmrN4JMt/asnxx6nbq0RCO/svzV1FCFxRUYVbmbDgniR502g==
X-Received: by 2002:a05:6a00:430c:b0:562:6897:7668 with SMTP id cb12-20020a056a00430c00b0056268977668mr14652393pfb.23.1665323321833;
        Sun, 09 Oct 2022 06:48:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i72-20020a639d4b000000b0044ed37dbca8sm4601703pgd.2.2022.10.09.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 06:48:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai1@huaweicloud.com>, fengwei.yin@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com
Cc:     yi.zhang@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221009101038.1692875-1-yukuai1@huaweicloud.com>
References: <20221009101038.1692875-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-wbt: fix that 'rwb->wc' is always set to 1 in wbt_init()
Message-Id: <166532332067.4035.10826406194481023090.b4-ty@kernel.dk>
Date:   Sun, 09 Oct 2022 07:48:40 -0600
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

On Sun, 9 Oct 2022 18:10:38 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 8c5035dfbb94 ("blk-wbt: call rq_qos_add() after wb_normal is
> initialized") moves wbt_set_write_cache() before rq_qos_add(), which
> is wrong because wbt_rq_qos() is still NULL.
> 
> Fix the problem by removing wbt_set_write_cache() and setting 'rwb->wc'
> directly. Noted that this patch also remove the redundant setting of
> 'rab->wc'.
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: fix that 'rwb->wc' is always set to 1 in wbt_init()
      commit: 285febabac4a16655372d23ff43e89ff6f216691

Best regards,
-- 
Jens Axboe


