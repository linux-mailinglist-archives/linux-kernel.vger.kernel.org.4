Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20188709C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjESQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjESQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:17:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B06F4;
        Fri, 19 May 2023 09:17:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f7bf29550so82622466b.3;
        Fri, 19 May 2023 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684513027; x=1687105027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XyK//vEzfvrporW5SGYOV+ZJI8CYViWlRIsmu5rRO84=;
        b=Q2Vr/M1upp+ZFWSYpmD2OYAz/MFf1cprMBnnKq9oIqAtvJVD3PdNwLb7MOUbCXj6y9
         DVcSmlD7NlAASKCAuyeiZ0MXGP2FruehzTIZKWIwt3h0RoaIiuW4fIy4/PKCtCO/rwWC
         OnQB9HXTkNqnBAkQQ8wjlZ3LjICZ5amKEnEGagJlTDkGWM8T3HCV8CK5igjqVnm7wOfW
         /4hY1Bau4K6SoBhYr9X0tpZ+RrR82+QCFrBobXOceVjP9FCYL896ZYzZx+xIq6jKGOgG
         Gkjy+rJDxMmFoUIMI0Dld6OiSpsLQt1QNFYn9zEfkulo7djj4U27T06aaPXbbS17qTsv
         2z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684513027; x=1687105027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyK//vEzfvrporW5SGYOV+ZJI8CYViWlRIsmu5rRO84=;
        b=DLEGMeDcJkPcZyW+mnTS+qCGoHnGYlgZb6ZYKLINDTM9Dg2tdkmbieLUVTkb/ycX6Y
         W3s9OMrU33z8CVF96G/zHCNLitIqebU/isQ905aPpuytXeWw45kLKXJhjnsz42T43a/3
         qT4lL2icseAU0dWIP0qnV4MnF0KltTMWqId5B0Cm0DN55zVSNmlgImXXWBWYLH0AdxpS
         a1NTMxvdFr6cyidOP+mr3IJac6ehpJBzpnigtbIIrNECjmMJSWmhJTBad/dghrxU480r
         FgadWctdBLEf4aQkORSp47m61VjEd9vmSEfGpIXuTBg+9as1/0LG+WIE0R7x0xnY7qs9
         6xYQ==
X-Gm-Message-State: AC+VfDw9xqI/1NSPHxL3jzv344hz7xv+PLBq9g0uNO+HDdqskVUEIRsK
        Fr5+SIiN5q9SNmbVDpvOr1hUdyixXgc=
X-Google-Smtp-Source: ACHHUZ79V3BiIdSacllCViEFZmQoZoO8U2OuyWGirUSsRBfzPPfnvxrC1Z9r+X9DI87F0AYL++WTVA==
X-Received: by 2002:a17:907:26c6:b0:969:f677:11b4 with SMTP id bp6-20020a17090726c600b00969f67711b4mr2424877ejc.37.1684513027285;
        Fri, 19 May 2023 09:17:07 -0700 (PDT)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id zc18-20020a170906989200b0096f689848desm935102ejb.195.2023.05.19.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 09:17:06 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.4-rc3
Date:   Fri, 19 May 2023 18:16:55 +0200
Message-Id: <20230519161655.667685-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.4-rc3

for you to fetch changes up to 4cafd0400bcb6187c0d4ab4d4b0229a89ac4f8c2:

  ceph: force updating the msg pointer in non-split case (2023-05-18 11:15:28 +0200)

----------------------------------------------------------------
A workaround for a just discovered bug in MClientSnap encoding which
goes back to 2017 (marked for stable) and a fixup to quieten a static
checker.

----------------------------------------------------------------
Xiubo Li (2):
      ceph: silence smatch warning in reconnect_caps_cb()
      ceph: force updating the msg pointer in non-split case

 fs/ceph/mds_client.c |  3 ++-
 fs/ceph/snap.c       | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)
