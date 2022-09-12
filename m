Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D605B547C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiILGYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiILGYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:24:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082F2C670
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:22:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id az6so6445403wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Gh72+xybfCA8FBwxhnWF+Al39bZjJMaBK2yiRuBCeS0=;
        b=ZbDpMDinqj0thb/noDlUyZWiHuLMFOSxFm4xtMxlegMHeucMybV0Bq4YkVDOFDaC8Y
         Ig7lTcfYLpfdmB6KrCDXgHuo7w6jW/lDu6dfuMXl/arg2UgI67ylm7DsBY8bei3B91E3
         lanC0MoI0VIS0S0/JD3wHTJapZ9RfGrVZd5fPg792BsJ+JHG2nJ6dfFZNhTxEzGU/gd/
         bFJHLBqL4K7K7/Rr6vf9itetdYsV+wfSqjStu4ATfyiA5iD1y3RdobOL7oFMktEbOcMp
         HmqVEiPtbPT9qSMv1bctXIt3YML7J/9qD4jNZ34tjfXsRuWakajnoIbO56Tymmmunvgy
         9ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Gh72+xybfCA8FBwxhnWF+Al39bZjJMaBK2yiRuBCeS0=;
        b=kbRngsTODBIL3KC9Kk4duEmixIPrHSItNOJkdIpZEHpewaKcw1L5IX44eDGbHYE8SH
         gS0zk2vSZTXmckjk1/V6KqWmp86Ny3LEddTLiBo3I8aj0U09TYKhsnBK615QZxVDqgro
         1r0hx85IY5+TalOW+a6fSaCqTqoHRGmY5rs88quN9x2DsTwSof3/SqR79m5rF/upViL6
         LDGLHLHoLCqZE/fQdkCa3t893McSAqVVAJPyuue9OgecFdAQTKCNX35EUMCoIOtTcE3H
         K3QcfwWnkt7TK2ywvPpNtehr7zpwlFfq5xqkzjTHJZvlo2NjoFCkb0lzIqk52rJYPRHj
         WaMQ==
X-Gm-Message-State: ACgBeo1yKmszUijUQoHjWHeZDgLRlXXXc2A0kBB6QsKqtydJUDxEvjjI
        SCZWT9buIirNdAD9jSuXAUE2AQ==
X-Google-Smtp-Source: AA6agR42/4Wqi2cXsI8h1LZ6l7vZvLVnQxKnzOip/dy111wmBMHnZpDioPELfpSQ/WpcsCoLftBAbw==
X-Received: by 2002:a05:600c:3544:b0:3b4:6278:8b60 with SMTP id i4-20020a05600c354400b003b462788b60mr7759836wmq.188.1662963626808;
        Sun, 11 Sep 2022 23:20:26 -0700 (PDT)
Received: from [127.0.0.1] ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a60ff7c082sm8790639wmb.15.2022.09.11.23.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:20:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     mkoutny@suse.com, tj@kernel.org, ming.lei@redhat.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        yukuai3@huawei.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
In-Reply-To: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
References: <20220829022240.3348319-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v9 0/4] blk-throttle bugfix
Message-Id: <166296362587.59201.9043385966296424992.b4-ty@kernel.dk>
Date:   Mon, 12 Sep 2022 00:20:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 10:22:36 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v9:
>  - renaming the flag BIO_THROTTLED to BIO_BPS_THROTTLED, and always
>  apply iops limit in path 1;
>  - add tag for patch 4
> Changes in v8:
>  - use a new solution in patch 1
>  - move cleanups to a separate patchset
>  - rename bytes/io_skipped to carryover_bytes/ios in patch 4
> Changes in v7:
>  - add patch 5 to improve handling of re-entered bio for bps limit
>  - as suggested by Tejun, add some comments
>  - sdd some Acked tag by Tejun
> Changes in v6:
>  - rename parameter in patch 3
>  - add comments and reviewed tag for patch 4
> Changes in v5:
>  - add comments in patch 4
>  - clear bytes/io_skipped in throtl_start_new_slice_with_credit() in
>  patch 4
>  - and cleanup patches 5-8
> Changes in v4:
>  - add reviewed-by tag for patch 1
>  - add patch 2,3
>  - use a different way to fix io hung in patch 4
> Changes in v3:
>  - fix a check in patch 1
>  - fix link err in patch 2 on 32-bit platform
>  - handle overflow in patch 2
> Changes in v2:
>  - use a new solution suggested by Ming
>  - change the title of patch 1
>  - add patch 2
> 
> [...]

Applied, thanks!

[1/4] blk-throttle: fix that io throttle can only work for single bio
      commit: 320fb0f91e55ba248d4bad106b408e59099cfa89
[2/4] blk-throttle: prevent overflow while calculating wait time
      commit: 8d6bbaada2e0a65f9012ac4c2506460160e7237a
[3/4] blk-throttle: factor out code to calculate ios/bytes_allowed
      commit: 681cd46fff8cd81e387747c7850f2e730d3e0b74
[4/4] blk-throttle: fix io hung due to configuration updates
      commit: a880ae93e5b5bb5d8d5500077a391e3f5ec7715c

Best regards,
-- 
Jens Axboe


