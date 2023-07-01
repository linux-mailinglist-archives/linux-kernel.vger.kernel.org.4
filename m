Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A3744875
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGAKWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGAKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:22:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B680F1FCB
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:22:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6985de215so45236741fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688206957; x=1690798957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7ztS2/YuspzN8dr6Cszov8eINdOPb7ES0wdsgpSETU=;
        b=qE9ClLyDGIQVk6lK3tl+1wB1faJtgiF4dXaD0FBMSjU1maCOgJQ5E+ps9EHiPXqWHR
         RHp/hX1HKFm9N2ke/5gygjgyIbsIqIwLh/mX75P4zkzYDML1TGFraywUhtSBezTRvkRR
         ztH73D3uWzcjj177RvdNaQWlKC2ydAsiRT1S7hGUC2iGz0i9Gd/aR3zwxVp30o2BthaC
         OiwEyhf7M4G/7hbmr8H3MXj2kKW+nLPJnecZLNcBwwEb1e+kAo9qmGteP3tldqRCKOLv
         +cQlH10AQYzE15T1O9X8tW0FEvLzoxnc4QCoAqi6F2LIeYCrlv4FfjVPW5ChrUgupEet
         UWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688206957; x=1690798957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7ztS2/YuspzN8dr6Cszov8eINdOPb7ES0wdsgpSETU=;
        b=bKCfQ2Cy7/+cD4qQC4LFKt2OeZQyqlMrJ75v7LhLInE7+axYYEkFUV9CLZz6N2x43L
         Qdu7HK+hbjEbG/ZEL1ebq7y700Ct8OsISrneOEcdYIdcAefVgs6oxoJYNbzxyB7JlZ3q
         zPE241Rz32eZAkHY+HH8e024/oPBNGU9mceu4OJGGxbi5ogIMzT8WA7UOnn0TmJp33kK
         miVse3ir01e5aXLPhuLHLdKXMNO6KDL5lqUvzuIuIl6kQqhXSlO7hlrN7rPTmCF7VdYs
         sN89Jj3F52UKaQlIkG2jzmpO/zL7w7c8LrpyRw3iI7XN62u0NJh52YBvxkDUxPp4hfrk
         i6PA==
X-Gm-Message-State: ABy/qLbaBeWhibOEE/5vXX9wHx9ncuDVwQ7wlhYl8ltrA9wf7Wcm3vYY
        RW0GTFnCyxDlvg4O8OGfBb8=
X-Google-Smtp-Source: APBJJlEb7pbVUyHFOEsJrzzu2ifqVihvcHGkgpq9vleSGT5UTlnJEVODEq09XV3/ETLPAONHkbnTpw==
X-Received: by 2002:a2e:b60f:0:b0:2b6:cd12:24f7 with SMTP id r15-20020a2eb60f000000b002b6cd1224f7mr3523688ljn.44.1688206956661;
        Sat, 01 Jul 2023 03:22:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:185:3db5:c5f0:49bb])
        by smtp.gmail.com with ESMTPSA id jt24-20020a170906dfd800b00982cfe1fe5dsm9073393ejc.65.2023.07.01.03.22.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Jul 2023 03:22:36 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, quic_vjakkam@quicinc.com,
        guozihua@huawei.com, eperi1024@gmail.com, hdegoede@redhat.com,
        tegongkang@gmail.com, gregkh@linuxfoundation.org,
        dan.carpenter@linaro.org, philipp.g.hortmann@gmail.com,
        Franziska Naepelt <franziska.naepelt@googlemail.com>
Subject: [PATCH v4 0/3] staging: rtl8723bs: Fix some checkpatch issues
Date:   Sat,  1 Jul 2023 12:22:23 +0200
Message-Id: <20230701102223.5308-1-franziska.naepelt@googlemail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches to fix some trivial checkpatch issues. Not all
issues have been fixed. I intend to submit another series to fix more stuff.

Testing:
* Build the module
* Boot the kernel with busybox in initramfs
* Load the module
-> No errors or warnings

---
v4: Fix sign-off email address and cover letter header

Franziska Naepelt (3):
  staging: rtl8723bs: Fix space issues
  staging: rtl8723bs: Fix alignment open parenthesis
  staging: rtl8723bs: Fix remaining blank line issue

 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 164 +++++++++---------
 1 file changed, 85 insertions(+), 79 deletions(-)

--
2.39.2 (Apple Git-143)

