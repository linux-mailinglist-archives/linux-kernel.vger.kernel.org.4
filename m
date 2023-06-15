Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDAD73196F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbjFONA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbjFONAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:00:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9AB1BC9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:00:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so10519191e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686834052; x=1689426052;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TctcZvXGN43HwETUwBc1JHngngPXfmJv1grpN3Hs04=;
        b=kWH5wT1655+UGW6aDb53bxMa3hBYH17QrxPTsuS34rPkI7u4/If0ZBBvHfEtUeStHD
         pruKT02Tr8NLLGcgRr1TK7G2XHjFbZ8e2sdxJg3ERDs/kgZEEJYqLQeee++MYsEWpj1Z
         75Thz7oRqM3LRvJWI7ulD1ArHNj3llb7ylJ7HnmUn7o7mlcQp/Uvi6zY7D5dScmS0X03
         i3V6q7GBE7qQo3b1C3Kgs/oNgCVyOGWTDmUoUr25o1zw1xZuvPrS78pgq/q9ns7q2R9p
         FrsaTnnM0L7C/Ii0Ht5Xg64CoisL0wJ8Q2H4ZK1LZvVgtoXFqSranXUZHnqgqVUs2bga
         kgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834052; x=1689426052;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5TctcZvXGN43HwETUwBc1JHngngPXfmJv1grpN3Hs04=;
        b=kolu0l2LZh1JrYpTLVcV+rmLCQHreU/ePU3WLvtyYc/ufK3YwH4RI9ZmO96FqGtVD0
         e0wZYwXmQPNn5UJ/fBeSTKbdCCsWovcJRW40NsNQnRDETzY7qNY75vTaI0Eylu6CF2aX
         +6Sg3xzP2CHETCy1+wMsqI1+UjQhhGeGbIdmL489GRjkCeUVkdLMsDpZL5ch6OdZf4SR
         WMXBj0oN/WPuR/f7g809jl9VCQVr38cBZ/VOWrj8ltqr5OR9I2dTEuGlACU98+1JIFNp
         3HEuySvmbfRAjqQZGiD2qTe3KsoDvq0hbqK9eHo0DKE+FNaii3+cSaeahi5f3HiQ2yui
         iS0A==
X-Gm-Message-State: AC+VfDxuoSUnIqv/F20M3UthCt7W8xCE2Be9ykmt6zT4J9AiAyuAVeKB
        osOXZP7RJtOJsVDLFhurdrckBg==
X-Google-Smtp-Source: ACHHUZ5WnNmjpeWjgFMIShPC0wbAbHETohuoX3sQ4DalX61hG477WQFaQIWdr0WyVeYjQBNyGwTjjA==
X-Received: by 2002:a19:7b05:0:b0:4f1:3eea:eaf9 with SMTP id w5-20020a197b05000000b004f13eeaeaf9mr10605445lfc.24.1686834051722;
        Thu, 15 Jun 2023 06:00:51 -0700 (PDT)
Received: from rayden (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id d29-20020ac25edd000000b004e83fbba141sm1860644lfq.164.2023.06.15.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 06:00:51 -0700 (PDT)
Date:   Thu, 15 Jun 2023 15:00:49 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Use kmemdup() in OP-TEE driver for v6.5
Message-ID: <20230615130049.GA979203@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch to the OP-TEE driver that replaces
kmalloc() + memcpy() with kmemdup() at one place.

Thanks,
Jens

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-use-kmemdup-for-6.5

for you to fetch changes up to 6a8b7e80105416cc7324fda295608ea2d3f98862:

  tee: optee: Use kmemdup() to replace kmalloc + memcpy (2023-06-15 08:49:55 +0200)

----------------------------------------------------------------
Use kmemdup() in OP-TEE driver

----------------------------------------------------------------
Jiapeng Chong (1):
      tee: optee: Use kmemdup() to replace kmalloc + memcpy

 drivers/tee/optee/smc_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
