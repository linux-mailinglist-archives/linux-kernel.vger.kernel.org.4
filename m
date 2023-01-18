Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479526723F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjARQq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjARQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:46:41 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0144830E8C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:46:10 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d22so7873972iof.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CBR9KRDrU62eYiKnf3g8Hj72EMYesEhZDgA5exJMeA=;
        b=nHt419y0vPb1nXvE+D0KK8cczLBlsYBZtxZdJJbaIYW9cR35eX5BQQvdP6Xy/fulMd
         kdlC4NAQg5Wu2ZRX1OARR+qjCRs9dpUB9XttLcchvnHTfsl327jLzQenUhVHSYIwPM0v
         W0XcNEDLPNv2/8tvG05DabQD6XDjr70/URhayVJ1hbTLaYtlXLd1RnIjMpgi6IDeAKlV
         TEXC4bADeIIVDXcVjHx7Ie6VfFBRV5/UfplMEqI0zakLZvYu4xMvGcAwAvsFBW0UsLxL
         8jG8Jqk4RDpLfKyZ5Psf2AchOgUsSxsQMskhbF4ngWhD0pQQMM0aJRId8+lA+Es1z0ME
         +9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CBR9KRDrU62eYiKnf3g8Hj72EMYesEhZDgA5exJMeA=;
        b=ghmiohQ1Chr39sbS0uV3GYrL7OAOKHmQTnTzEbv4Yvfwavz/kTN4peify9nXkCYzoY
         xKemdazhBSKdY1dKccDC8xDOp16IBwBTujwP14oCO7KtYjNrnnIvmYDD+9NjNaGLzZ8o
         oDAD+y+Cz88Nd7Vce/XUjVx8XUyBX1Zt90i0IsnW78TJHsBXuiDhMRsQpVeUAryL9hRE
         QCUTUbaIscl6XVlYyWY+2DTKGguSYIJTP62HuCgavIZxYpvDeaFiwRUU+2a3AecI9hRU
         k55XffXtlT1K9DIMSLfsfbf2wDFFAuoZ5wa9RVZRNh/+D4tD24Ly5K6canvhdHLX55PB
         f08Q==
X-Gm-Message-State: AFqh2kpa0a553InaT6bM91q6m6jRDROklyg+LnpXIqZzkIEfO3sGib44
        mUvkRBKguBAWgel1CoVPk3KSuA==
X-Google-Smtp-Source: AMrXdXvYb8IU8NcwX/Z9juezXwL0k6976BA7jU9TTuSWnFuDO53xZcO2Jm1Rblll8PPjv8qoggrQuQ==
X-Received: by 2002:a5d:9482:0:b0:6cc:8b29:9a73 with SMTP id v2-20020a5d9482000000b006cc8b299a73mr965128ioj.1.1674060370180;
        Wed, 18 Jan 2023 08:46:10 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b20-20020a5d8914000000b006d8b7bcaa6esm11641693ion.4.2023.01.18.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:46:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kemeng Shi <shikemeng@huawei.com>,
        Andreas Herrmann <aherrmann@suse.de>,
        Yu Kuai <yukuai3@huawei.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jinke Han <hanjinke.666@bytedance.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118080706.3303186-1-arnd@kernel.org>
References: <20230118080706.3303186-1-arnd@kernel.org>
Subject: Re: [PATCH] blk-iocost: avoid 64-bit division in ioc_timer_fn
Message-Id: <167406036877.186970.284730787614510141.b4-ty@kernel.dk>
Date:   Wed, 18 Jan 2023 09:46:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2023 09:07:01 +0100, Arnd Bergmann wrote:
> The behavior of 'enum' types has changed in gcc-13, so now the
> UNBUSY_THR_PCT constant is interpreted as a 64-bit number because
> it is defined as part of the same enum definition as some other
> constants that do not fit within a 32-bit integer. This in turn
> leads to some inefficient code on 32-bit architectures as well
> as a link error:
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: avoid 64-bit division in ioc_timer_fn
      commit: 08a39c820686f87351b21c6cf6af76a40677d3af

Best regards,
-- 
Jens Axboe



