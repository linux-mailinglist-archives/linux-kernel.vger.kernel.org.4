Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EA160D7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiJYXER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiJYXEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:04:15 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312BCFAE74
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:04:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id be13so25181868lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DaQELqlFLvXEPdT/zDFeJ4WkfQwHRjYd9ttvRyNegUs=;
        b=i1ejxtNl77wAirC8S39dSHkV+2hiVlK3cTF5TVaq1KzmKh1Ekqe5T0w//MB+Q3zHUy
         ZIqVgFnD8dC9B2UtYoOGw2hbJdlH2bl7O85Dsqci3j9jAFwXvksDdaKxnL/OF3NwsSrZ
         8q5ntSZSw64Ue/W0HUhiixkYYjJvD2QZssDSI85WKeG+lki0duIG0uffTpMe0uPFGxgU
         tLTn5/wrNMycfgK3qoILAvDjdKPJi/cc6apXU/38v+CVhYoyQypRD7l9rRZKBUybGGrL
         NDNW2VOKBBf9ZHDnrVaC4+xduhPLuggqN+8DfsWmfLid7RBZXr/31CJvLPiL+oZTvBu1
         zEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaQELqlFLvXEPdT/zDFeJ4WkfQwHRjYd9ttvRyNegUs=;
        b=UL5LJJRFPfGRRA0BmVGpqwEcI7sdETso28aZwIhY99c061sM2zKzDm2oEz6Va8t9li
         iEtEaLm8N64vPNG/H7llIO/P2uZcpFhuQxcBCfn82QEa0ADrYuQpya7A4J4h3pgjk7S1
         LvdwZo5Nr2rBhtZ/nTcLD+4PQfR7+Dx94pNQiYtUV4ZFnVcy+iOdoxV8zizWwEdZfu3r
         3isf9nbbfrBJ94o4zdmiPWBE99Rq5dPbxGV37GX1RcJ2nFOKy78BhdJYEJSaI5V0nyVO
         8H9L+Ghah3j0oWW1B7nrkZIExj0a/jNRoim4VLdSAjkK8Sut/XcN/3wNQ55ONciIEp/P
         jhCA==
X-Gm-Message-State: ACrzQf0wHEH22I7ruy/hMVGWnSylfqDg2YJKhk1DTXYh3tgsDTOCMO5+
        9szcyplwW11H2++w8sO9nl0bZaBxqrjCCw==
X-Google-Smtp-Source: AMsMyM6IHGxFPJf9Q8DTTmytvQlQ3JqBJcPyM9Rf2dnu4c45WJgw9RlpG0m8e2qm+P65Z27/wNAi1g==
X-Received: by 2002:ac2:44cd:0:b0:4a2:3fcd:c960 with SMTP id d13-20020ac244cd000000b004a23fcdc960mr15194583lfm.590.1666739052273;
        Tue, 25 Oct 2022 16:04:12 -0700 (PDT)
Received: from localhost.localdomain ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id p11-20020a2eb10b000000b0026dc7b59d8esm700892ljl.22.2022.10.25.16.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 16:04:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PULL] qcom: replace split a530_zap firmware with symlink to the mbn file
Date:   Wed, 26 Oct 2022 02:04:10 +0300
Message-Id: <20221025230410.3737306-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the discussion on Venus firmware update, I understood that while adding
a530_zap.mbn we forgot to drop the old a530_zap.{mdt,bNN} files. Drop them now
and add a compatibility symlink.

The following changes since commit 0cac82d36af9f9b1d3e532dccf0c690408ccb454:

  Merge branch 'for-upstream' of https://github.com/CirrusLogic/linux-firmware (2022-10-24 12:07:56 -0400)

are available in the Git repository at:

  https://github.com/lumag/linux-firmware a530-mbn

for you to fetch changes up to 59c14bf982bfa388e04d0bcf165d5699fde0ed6e:

  qcom: drop split a530_zap firmware file (2022-10-26 02:02:00 +0300)

----------------------------------------------------------------
Dmitry Baryshkov (1):
      qcom: drop split a530_zap firmware file

 WHENCE            |   5 +----
 qcom/a530_zap.b00 | Bin 148 -> 0 bytes
 qcom/a530_zap.b01 | Bin 6536 -> 0 bytes
 qcom/a530_zap.b02 | Bin 4900 -> 0 bytes
 qcom/a530_zap.mdt | Bin 6684 -> 0 bytes
 5 files changed, 1 insertion(+), 4 deletions(-)
 delete mode 100644 qcom/a530_zap.b00
 delete mode 100644 qcom/a530_zap.b01
 delete mode 100644 qcom/a530_zap.b02
 delete mode 100644 qcom/a530_zap.mdt
