Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1271B62F44A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbiKRMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241833AbiKRMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:11:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5497346
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:10:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j16so7870700lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBu6kfL23BcHBPVJQ1UWIgnUmXbGAwIjzt4B4fPiJ0w=;
        b=AXFZY+/lx/aXVTzw/rhvD8HHbAZHbfn8g6+fkD/V55tKKVPkHQ+YLiOo5hkqyMChTO
         3ZGQ0NXC86du4aWC1Ho9MB4lVacnDbi2SKl0dppOJlTNwiaQlLuBB217wMb1gcKoDrXh
         lnsewn4fbKJJyjf+nvNmdo+ORJlPZDhqNLiSNM4YP6V47KvuPuzCI7uGyVe8SZ/cP6uw
         QxrelX349mqG8VgoPXN6zFjtGNb0szbYWouhnnHjeLzgKA6sBbHCbOAg+IcSn1ryjGuT
         6vm9nLNBuAAzzfxoTGwA9s2Y3+t9OrvkkOVAUuV/BGx3K2eqVT1/b3eYHGmd10SQvoPN
         sihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBu6kfL23BcHBPVJQ1UWIgnUmXbGAwIjzt4B4fPiJ0w=;
        b=RFCEF3hcPnyF5xcvzGvTNIjRU0IDd4Sje0CS1qQkWkO5nKIJbHEWdGKDXGeZN+HvHM
         Ja0x5XAiecB/t5hmyYKfXy3MnxGvsBi66Px1zRw4fOG6XK8Ms5c7oJX0i+dEPoCwXKSg
         pJ5k99c/XyMyZePMf0JQpBd1rlOPumzEBCkyd4P7f0BgWlDtFiAMe8VkY/6p2hmMVxUG
         7RW1wnVtSi70b33M/NrKsjGaq5vvnYZJ7ciNyh+1F4lJuPY4GsJqltVPecRWVV7lMj8E
         THNtfLptgRYf8lArUTz9r6IBZPl8MukrcfhCEmWJItDWrOC9ZgOo58QjGaCg0P6HkVWG
         OBiQ==
X-Gm-Message-State: ANoB5pmYKJyHKG8oCsVHqj48QI2DUJHYTM7Z1DquZMHC/02BtTCSV7JJ
        vWYbJyKEawLOLZRAhfEg5fkf9A==
X-Google-Smtp-Source: AA0mqf6TUNjX0jmjkVETnHxatVQPJY6CHiLkVsJECbdcfEKrcYaJUvEtI7EWHfRx00vjlERgtoW6Yg==
X-Received: by 2002:a19:9113:0:b0:4b1:e3ec:d99d with SMTP id t19-20020a199113000000b004b1e3ecd99dmr2241140lfd.95.1668773436318;
        Fri, 18 Nov 2022 04:10:36 -0800 (PST)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id bd4-20020a05651c168400b0027628240ff7sm631838ljb.135.2022.11.18.04.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:10:35 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:10:34 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix possible memory leak OP-TEE driver for v6.1
Message-ID: <Y3d2OuJ60U30OkZe@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch in the OP-TEE driver which fixes a possible
memory leak in the error path of optee_register_device().

Thanks,
Jens

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for-6.1

for you to fetch changes up to cce616e012c215d65c15e5d1afa73182dea49389:

  tee: optee: fix possible memory leak in optee_register_device() (2022-11-17 09:22:12 +0100)

----------------------------------------------------------------
Fix possible memory leak in optee_register_device()

----------------------------------------------------------------
Yang Yingliang (1):
      tee: optee: fix possible memory leak in optee_register_device()

 drivers/tee/optee/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
