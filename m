Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1764172CACD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjFLP4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjFLP43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:56:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5108219D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:56:28 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33c20462fa3so2282235ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686585387; x=1689177387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDv2++4y4WHcpliO9UwrmYpCoiXZ+M28TkOhP00UkEw=;
        b=D6ZmOLjyzxaHcs6eQLunqJpIwEWY7jErsCxy4YXZMy8YUeZa4hC1v4nWBjFjlgxiat
         F4GFarXBrfWyPoPZyNzH+cJBZos7Piv33/NrTfWCsqlHS+ZBjj77NTbAUvlbw4S10Kqr
         x8lr/AdVbZ1LodiLsSh9jMSHosmau+wYeR2MAH6wj1a3dDfyQ/dhaHEIuS3Fcs+1yFZL
         pgQtLAloz6it7Hj7JSHGme8c3777opKpREUanyhWMdJP1uDdFU1MI/TLW3qnE4RdHE+h
         xll2x/dOweKwGT6+jmP9wT3P0IMeGcAZ4/dUGGb/gPST0A5cgfY+axrLhDng7037RBYp
         wmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585387; x=1689177387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDv2++4y4WHcpliO9UwrmYpCoiXZ+M28TkOhP00UkEw=;
        b=astkuzSP9kP3SpmTrkn2I4mj3hZb79UhQwIqBZcxkqawdr+OunGmwlxWK5uXmXsP4X
         XD4B6DoJu5FUpM8b6oUnkMVJzyVVF11FKBtNSPbq9GXL3WWio8tUkP41YZz8y3rVLS07
         nW1uR7XfnKXo+ICNTKSc52+5eCMZK7mhx0/qyt9GFx9VfQ7rUxKIObUIIFqKBhtvQ7Vi
         Tzgs/cBqAKFQfeavh/h4v/GDGpLxKcW8NaeKT4Ei69K0jbJ1PQ/VF24FNeaST71U6t12
         /tus8z2v/H62QJTzLr3mhBbRd+vKPbcsUZecMV7fuQ1o7qJkGK4lmJXEdwo0pUW5lJhr
         K2Ng==
X-Gm-Message-State: AC+VfDxAuKI3HjpX+Rmn2COynb3vTMgYSzQ4lYWge4GynO5I7JtodZtZ
        BvLVh+tEx0TPCTY5AzQv83iMtlEi2U/tUzcXQcg=
X-Google-Smtp-Source: ACHHUZ5D2TB3x2QAL8IlcUNXKrqNOABHBJlGyqgh/qrlzc8p3NCE7wnJM6hOjxnkWc1Joo8I6QmbEg==
X-Received: by 2002:a05:6e02:1a2c:b0:338:4b36:5097 with SMTP id g12-20020a056e021a2c00b003384b365097mr6968899ile.1.1686585387673;
        Mon, 12 Jun 2023 08:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m10-20020a924b0a000000b0033355fa5440sm3291980ilg.37.2023.06.12.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:56:27 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, qiulaibin@huawei.com,
        andriy.shevchenko@linux.intel.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230610023043.2559121-1-yukuai1@huaweicloud.com>
References: <20230610023043.2559121-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v2] blk-mq: fix potential io hang by wrong
 'wake_batch'
Message-Id: <168658538673.969588.639148205003839147.b4-ty@kernel.dk>
Date:   Mon, 12 Jun 2023 09:56:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Jun 2023 10:30:43 +0800, Yu Kuai wrote:
> In __blk_mq_tag_busy/idle(), updating 'active_queues' and calculating
> 'wake_batch' is not atomic:
> 
> t1:			t2:
> _blk_mq_tag_busy	blk_mq_tag_busy
> inc active_queues
> // assume 1->2
> 			inc active_queues
> 			// 2 -> 3
> 			blk_mq_update_wake_batch
> 			// calculate based on 3
> blk_mq_update_wake_batch
> /* calculate based on 2, while active_queues is actually 3. */
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix potential io hang by wrong 'wake_batch'
      commit: 4f1731df60f9033669f024d06ae26a6301260b55

Best regards,
-- 
Jens Axboe



