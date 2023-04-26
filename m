Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE246EF906
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjDZRIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbjDZRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:08:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44309194;
        Wed, 26 Apr 2023 10:07:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f199696149so34484275e9.0;
        Wed, 26 Apr 2023 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682528857; x=1685120857;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JCpsle4OxxsL5c31zEHmi+00et+VHsUj5Z1y1dyYrA=;
        b=Z3TQSB1GmsI23fZn+HInNEdaAf+QpSrRg8IHLyJg5yOp0hItTh8madnDiN+glNhf4N
         XjtdSzLw8Ua2UvCFJvCdnBmNTTBr68IvKYJxFemlAfCYasLssd6LxN3l9Wop5EzO3mCl
         I3TLsQd+wLmeS3g7mwAVMfnHrHLzxLHbBdQrWZbeZfT6A2VVdBQHaoFqsQg5EQqYeMIg
         023xy3nJWUhylYSTzMZCEHWssV9e5jC0lLF9mWu1L9nnrbrk0oLvJH+yk7u8rekMbRv5
         BqVDO6AwofNDimvE2fFaAD9yQpeu62p+WXxahLyHgI7XIAxSRebaudfjkVOfoJP3gCuS
         +EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682528857; x=1685120857;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JCpsle4OxxsL5c31zEHmi+00et+VHsUj5Z1y1dyYrA=;
        b=LCE4TZIqwFqVnD57UjUHILNvmcqS5FkmU5l6xgGrygWzYG9hKRpf2wmRKv5CqO7887
         ZKs2dFcMDgrL4alewkMu3CtEDsN1PRfp0Nxu7fvo1YHT3f47U8w2cZhueDQb63Qgb8Jb
         XZqRcYtWvQO/M0LzaH3i/v9NPmrHeHwD0QhiOj5W96Kfi8RKw14aSSFIppi1h0iccXin
         si8fLk35v/FRJ49XEKnmWzQGtoHQm9uwHzgbJNe4PSN6AzIXTHYxvbf+4wVaMrqVWs6L
         eSrEWoCH944quNq0FF1Drv3YE3Dho8W4tJJ9cH1BULRa4dpNirfOPTbvrrM8rwrYoXhs
         pEow==
X-Gm-Message-State: AAQBX9djdvIOJjWmTuy5X0Jv/CCk+4FJrwtewFLffzYPZpDITTlgZoN7
        /Sn9OkHC7/f8HqQBSpIG2MXo9WKdjsE=
X-Google-Smtp-Source: AKy350Ymj/pKQUO/QPGEF2M9IelBgbBq9Huo99W/Yi8pR4Sbltd+PBQm1uc9D9M2pkw2673+Ew5q8g==
X-Received: by 2002:a05:600c:24cd:b0:3f1:6ef6:c9d0 with SMTP id 13-20020a05600c24cd00b003f16ef6c9d0mr12136173wmu.17.1682528856832;
        Wed, 26 Apr 2023 10:07:36 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b003f1738d0d13sm29742055wmq.1.2023.04.26.10.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:07:36 -0700 (PDT)
Date:   Wed, 26 Apr 2023 18:07:34 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: mainline build failure due to cf21f328fcaf ("media: nxp: Add i.MX8
 ISI driver")
Message-ID: <ZElaVmxDsOkZj2DK@debian>
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

The latest mainline kernel branch fails to build xtensa, mips, arm allmodconfig
with the error:

drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_inbuf':
drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:33:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
   33 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_outbuf':
drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:51:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
   51 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:66:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
   66 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

git bisect pointed to cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip

