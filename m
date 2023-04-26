Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F178D6EF994
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbjDZRov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjDZRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:44:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F9D1FDE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:44:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so4772233f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682531085; x=1685123085;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8jM2knRGN9BYsAyJBymJ0PdQVU0ygOmY27Y7/+qCDI=;
        b=dGNfBKb9cOspje21udAgXEAc23Tc4Z72X3t8ZVn2jE+rKhLcPb1xK5ro/DO1MAuRqm
         sbZZu2SQqlPJgJdpUHOhBxXY0L87NZsXNBhgZfRx/ZSywy1gaI/a2gkZOnjwdnQ39z9w
         4qxs8ss/9Bztm4JDUYEloRLQuBR0oVgPJ1vdc7BvBIME3an1PvbAFmSfuGmBKelDDQAT
         jn1bSrxxcJUaoy5XKd2HaBXRhHO6euuvR9COlgAtpTvN6Q3mSdSnswucBKXkXyx6L4K7
         M0TZUM5TkBIUyJA3fkYnZEfe1w/eOaXdmNp3E0N8TqYQG+q8ZFW94hZllEUSPP/6xitg
         98YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682531085; x=1685123085;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8jM2knRGN9BYsAyJBymJ0PdQVU0ygOmY27Y7/+qCDI=;
        b=gxmeplxbAymX9Qc8wCR19mnJKT9qpfozgY/tqPE6oxClUPFpB1ZQ5rmJ1eGjzvPv7Q
         R0bKtFojwYRhV4zGaSBcnZNlBjs/iZfFQVE1QVOmzJxMt+1rnmebmmZnchFRyJSxGD+7
         QglXIjPtE1ptrCSt62/bQg+ujmLy9RsNC99F2CzyluTQYodo0YfTt+R7nv9d1jtAcd5v
         mE0QHuX6DWXG7I4+oKFxqOGszgP0je33Xja5jLkkSpHpKYjyvqHDNKHKSKKPNZ2YZhZM
         IuHXo9IuWi/cPTaJ/Elr3uZS+zwTvb8ZSGTKRSO3HhM3AdlCKzocO4nUGKQWoJqBk+8F
         Myig==
X-Gm-Message-State: AC+VfDyqfmsmxHJbDLpCRgnCTibDJdzT8jE4tpkC5Z+TCLlXjBXO2K4N
        lWssx8tjtrEDQzU68eBy//E=
X-Google-Smtp-Source: ACHHUZ4cBwzwg8x4y5GrjX4A4GxBkfNdMxrAR8PRw2iXL2mzOpOy62rGGFU55CDvMzPtE6tS8QYQVA==
X-Received: by 2002:a5d:6610:0:b0:304:7bbe:87f7 with SMTP id n16-20020a5d6610000000b003047bbe87f7mr6871658wru.58.1682531084849;
        Wed, 26 Apr 2023 10:44:44 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id b2-20020adff902000000b00304aba2cfcbsm55744wrr.7.2023.04.26.10.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:44:44 -0700 (PDT)
Date:   Wed, 26 Apr 2023 18:44:42 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure due to 322458c2bb1a ("drm/ttm: Reduce the
 number of used allocation orders for TTM pages")
Message-ID: <ZEljCgVFnDl/C+l3@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build powerpc allmodconfig
with the error:


drivers/gpu/drm/ttm/ttm_pool.c:73:29: error: variably modified 'global_write_combined' at file scope
   73 | static struct ttm_pool_type global_write_combined[TTM_DIM_ORDER];
      |                             ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/ttm/ttm_pool.c:74:29: error: variably modified 'global_uncached' at file scope
   74 | static struct ttm_pool_type global_uncached[TTM_DIM_ORDER];
      |                             ^~~~~~~~~~~~~~~
drivers/gpu/drm/ttm/ttm_pool.c:76:29: error: variably modified 'global_dma32_write_combined' at file scope
   76 | static struct ttm_pool_type global_dma32_write_combined[TTM_DIM_ORDER];
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/ttm/ttm_pool.c:77:29: error: variably modified 'global_dma32_uncached' at file scope
   77 | static struct ttm_pool_type global_dma32_uncached[TTM_DIM_ORDER];
      |                             ^~~~~~~~~~~~~~~~~~~~~


git bisect pointed to 322458c2bb1a ("drm/ttm: Reduce the number of used allocation orders for TTM pages")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
