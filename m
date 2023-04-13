Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352506E0DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDMMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDMMvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:51:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD6A253
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:51:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so15897010wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681390299; x=1683982299;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=49xLVHrspKSm1a8wJCoZVRSlPwE9xT9Y1ZadXVyJNEg=;
        b=2z5oZXaHlOTvgVBwEE09zefyoiTfL7dXyOrL3UaR6bRqtM5aMl+yBKFpfvriLk4nUf
         5V6y0EqAS8uB36aEwDwy0wizxzcdwIy2qwot0XH3fQw69N2dRIUWCBTpdpwH3KkUU1Vo
         6vqCB4w8u5E5kw7CoPLa2T8Xz95KU2Wka5ZPo/9P5Alf5l0NnfUFzFlfR+0YEEl42OGr
         g+9BlpzFBlMZyqRfTFcq8zfehSi6cX+OyXkc8381As6ZYEZHW+LNpQdf/taYlSrbmpCB
         pS8N7wUt6wISOFT9j2rO2RNZ1pbvFHe7A3n9ltE/qMPAfjYg7tyugtkji9qV3kCrjXa0
         SbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681390299; x=1683982299;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49xLVHrspKSm1a8wJCoZVRSlPwE9xT9Y1ZadXVyJNEg=;
        b=fMz4maU75YCLY9osC2cBsrsBUk2lkxVrmk20byPkE59zrVawosnbo9weHGk7cWO6xa
         bW6nKAuJHL9uqENoadeos5bNshWEEnHXO3eReDxYM2okfNgnkbgtLPO9KrKMNjjLGkip
         QfRn9y4D++zcpJ9pSB1RDxWjBb5YSTMQ3+39NlEdHUi7kK7GVcjZhR28/qP9M1cgvlOc
         krD+Hz2ef3X08mYw5R0m8H0cuS53nIjzFHRcAD8CEjAtgsVISCtiKsKVrb2I3R8DNhMs
         HxSHi7UZvcUJvQdsIZxwogZV12DXiXvMg4CZgRE4Wfd8WbLlRLoS6xfHS+SYZAXz7GZw
         VQyQ==
X-Gm-Message-State: AAQBX9daQ8V4pr9FKjVX8OaYD2CBlmRWLVE2Gx6FtvtGn2tPb0zVXONA
        J58hvIar5dWHtznWtX53swI8/Q==
X-Google-Smtp-Source: AKy350YNCcu7sfyoJFtK9vQbTWVf2clHHcvIihFMcemmZYifJ9kTOlj3H2x67y3zZ17zDEUT00tu9A==
X-Received: by 2002:a05:600c:2304:b0:3f0:7f07:e617 with SMTP id 4-20020a05600c230400b003f07f07e617mr1799961wmo.8.1681390299485;
        Thu, 13 Apr 2023 05:51:39 -0700 (PDT)
Received: from [127.0.0.1] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d66d1000000b002f67e4d1c63sm156356wrw.12.2023.04.13.05.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 05:51:39 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH 0/2] Fix mtk-hdmi-mt8195 unitialized variable usage and
 clock rate calculation
Date:   Thu, 13 Apr 2023 14:46:24 +0200
Message-Id: <20230413-fixes-for-mt8195-hdmi-phy-v1-0-b8482458df0d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKD5N2QC/x2MQQqDMBBFryKz7oAxDdSuu6iLnkCKTMzYzMIoi
 RRFvHtjl4/3/9shcRROcC92iPyVJFPIoC4F9J7Ch1FcZqjKSpdXpXGQlRMOU8RxuanaoHej4Ow
 3rFkZpa2xRA7y31JitJFC789CnnSB16V7Pl7N6efI/1iW7fs4fk/ly4mLAAAA
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've received a report from kernel test report [1] that a variable was used
unitialized in the mtk8195 hdmi phy code.

I've upon fixing that issue found out that the clock rate calculation
was erroneous since the calculus was moved to div_u64.

I'm providing those two fixes on top of 45810d486bb44 from the linux-phy
repository [2].

[1] https://lore.kernel.org/oe-kbuild-all/202304130304.gMtrUdbd-lkp@intel.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
Guillaume Ranquet (2):
      phy: mediatek: hdmi: mt8195: fix uninitialized variable usage in pll_calc
      phy: mediatek: hdmi: mt8195: fix wrong pll calculus

 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)
---
base-commit: 45810d486bb44bd60213d5f09a713df81b987972
change-id: 20230413-fixes-for-mt8195-hdmi-phy-9e1513b5baad

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>

