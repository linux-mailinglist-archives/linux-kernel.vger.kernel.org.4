Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94473D1E1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFYP4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjFYP4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:56:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA26F3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:56:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d9865b8a2so325907a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687708604; x=1690300604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJwT14TihBRqB0zuCMTLR/0JBnFHysVCjPaJH4ilQiA=;
        b=XMp7U5DAmUm81cnyjU5jLJU0/yVd4ezhGfFWVgeONlsIvAaSITWyXb2G7lYg+8TrdV
         3DPodAe+9bHFHDUiA8HZVlaf8Avudsl3NUCjoJPqu79v0LdfTHopfeo6MEubAGF5qBrq
         34s6L8cNGpvlujVjOGDVCnkb3gPI2QwycwPDq/wiR1jo+bwiK0U6pb5I5xwl4Ly/Zj6a
         Pfu1WLdAFmVuN7FxV7IW/JIqnku5sGVTt0BGO2eVwQxpU8qpeLx/g9aborjR4+hA0mEL
         Fb8x7mGCL6q6gzkX5C89uwXt7mNWQWk5gwII86WGzVQLX69IxB0LPLPQ1+MjpDgpQrHN
         mE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687708604; x=1690300604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJwT14TihBRqB0zuCMTLR/0JBnFHysVCjPaJH4ilQiA=;
        b=dsTNA9Sz6sorx5b/PD60Lx4WpljwJEHdRcTNrvyMxH2kQPwrlC29KLOLS5K1re6NPk
         tHvSgWIN+BqAYdudTKX7YY94G0DrfOaBLjz/Nb+aOaNxeMzLhdMuhy1Pdi8EyEnt9YeQ
         zvGSNyRcNw+z2i7+0gQrbG8+reDOma3hMmXBHNwZ2+vM/7QDbUaeHOnFuBu4ia3ZFHwY
         OCIH76PFGFSuE2ZPD3zFBF/yXYW3S+lh4GZPgmFqnhjvjyL67WxLZXmoZoUPQll9dy1s
         dGhkWWFDyoQZZOFYpcyqI4AEAbwuK1GkEUilprmnI7vCfWDyWzL2qpvnJsYZ0tkXDnwm
         T0Eg==
X-Gm-Message-State: AC+VfDxyGj4dJDqRoHa4FGE0QfmEuI6EyI2bMtzDSMEFvPqw8aprN8mX
        s/EeFnZQtx51nssJfUP6pslXohM8KGtYMA==
X-Google-Smtp-Source: ACHHUZ4qIwnHicnRfn4cD9whZBDuWdb247+g7jvt9pwfiXbGEl10GQ5tYSD5oUqV3RRWP9DKw2twAQ==
X-Received: by 2002:a05:6402:786:b0:51d:9883:afdf with SMTP id d6-20020a056402078600b0051d9883afdfmr492829edy.12.1687708604163;
        Sun, 25 Jun 2023 08:56:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:484f:5091:3ba0:ecc])
        by smtp.gmail.com with ESMTPSA id r26-20020aa7d59a000000b0051d961ab28asm660933edq.67.2023.06.25.08.56.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Jun 2023 08:56:43 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, eperi1024@gmail.com,
        hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        gregkh@linuxfoundation.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH v3 0/3] Fix some checkpatch issues
Date:   Sun, 25 Jun 2023 17:56:32 +0200
Message-Id: <20230625155632.32403-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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

This is a series of patches to fix some trivial checkpatch issues. Not all
issues have been fixed. I intend to submit another series to fix more stuff.

Testing:

---
v3: Series to contain only remaining patches.

Franziska Naepelt (3):
  staging: rtl8723bs: Fix space issues
  staging: rtl8723bs: Fix alignment open parenthesis
  staging: rtl8723bs: Fix remaining blank line issue

 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 164 +++++++++---------
 1 file changed, 85 insertions(+), 79 deletions(-)

--
2.39.2 (Apple Git-143)

