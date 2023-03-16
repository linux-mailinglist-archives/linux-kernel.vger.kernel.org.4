Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD26BD407
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCPPjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjCPPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:38:40 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C492E2517
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:36:56 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id bp11so1210233ilb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678980957; x=1681572957;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYar2ybeVJqnai5t6j9VGmRtR2ovUMfBI/dkWezXyWc=;
        b=sVk1JuZmFUhd1tlBehU7iFt3sVXohrn+jnAzxsEhXyW1rV3rTUKOwK9OK1Sh1mDfzd
         Kdv9QjNsZcBRnPUFaxFo+MZqaO/wdpiUCKcD0WaWhPqnh8kAVh2LV8rzxLXlt/nl0ZkI
         zmuuw653yy4/0bfN11ybpCc2F1GxYJUez5q3lorEpqZmPHRWANi9M5ZirtBDnQaQV313
         h3yoZbRmcM/85ydvtqPw4hElb0MKrZBkT5NK+SHPVpIXcq/POirSUbuXiM63Nt1VDxJQ
         tmJwN2tMboNaBqDwf6Ag8Rl5xWxtCDFYcmMQQgdpU8duQc+zZpHZfsl8DtrjYmguNLfo
         5SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678980957; x=1681572957;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYar2ybeVJqnai5t6j9VGmRtR2ovUMfBI/dkWezXyWc=;
        b=3TTpTqpapEGlTA9F6TkuIHflhKqk7Ux5K7hXK1g74X7+AR+u+/PwZdPass46HqhBSF
         D7xQ5nLMZ1d5EQBvjKQm9hjWqi/qKcuDccxP6TnV/F2taBVyh8ZO69nAG6vaE75sfzVS
         b3Ff+gl8ubkvQpCmpKahQ3UdTUID0OSt5y+aRGTCRTTA3VjhiN+UxtN2fMUYylG2H8sJ
         SMZIi3KLS75OTxDwz9z4clO1DmhPSoA5Hoh6Q4owOH8QFZdiHuNbmSplwNhstcB7xbB8
         yHzNUEieqzDdZf8WgfrQ1hkviPAYlb/TNiDn+Ah041XlbX79NjJlpOxIfUmCRFH3M4ti
         bkNA==
X-Gm-Message-State: AO0yUKVmAo/u8BGlUYyMrIOGkDUGb1VzMYNBPcSTSIBpcJNVOlfH7257
        8FvykHCTyAB+ZX7v/FPp+gG6Rw==
X-Google-Smtp-Source: AK7set/W9ggxEyvzAzMZ4ShGBmfvBVdryiJ14kkiBwYaN78df/A1Lz33twWv8A/A/Ldki12xG+KOpg==
X-Received: by 2002:a92:d64f:0:b0:323:10c5:899e with SMTP id x15-20020a92d64f000000b0032310c5899emr4228071ilp.1.1678980957025;
        Thu, 16 Mar 2023 08:35:57 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t8-20020a056638204800b004050d92f6d4sm726970jaj.50.2023.03.16.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:35:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230316111630.4897-1-lukas.bulwahn@gmail.com>
References: <20230316111630.4897-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] block: remove obsolete config BLOCK_COMPAT
Message-Id: <167898095613.31557.5292857532580529637.b4-ty@kernel.dk>
Date:   Thu, 16 Mar 2023 09:35:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Mar 2023 12:16:30 +0100, Lukas Bulwahn wrote:
> Before commit bdc1ddad3e5f ("compat_ioctl: block: move
> blkdev_compat_ioctl() into ioctl.c"), the config BLOCK_COMPAT was used to
> include compat_ioctl.c into the kernel build. With this commit, the code
> is moved into ioctl.c and included with the config COMPAT. So, since then,
> the config BLOCK_COMPAT has no effect and any further purpose.
> 
> Remove this obsolete config BLOCK_COMPAT.
> 
> [...]

Applied, thanks!

[1/1] block: remove obsolete config BLOCK_COMPAT
      commit: 8f0d196e4dc137470bbd5de98278d941c8002fcb

Best regards,
-- 
Jens Axboe



