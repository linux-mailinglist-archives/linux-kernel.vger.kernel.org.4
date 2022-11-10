Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB762487C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKJRlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKJRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:41:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C821627FD8;
        Thu, 10 Nov 2022 09:41:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v1so3303146wrt.11;
        Thu, 10 Nov 2022 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Up6hiDVLuWAaCEN91nYS7vd27XRu7U8JIDCkwO+t6lI=;
        b=E0uv4fSb9P0wlitTRStqfRsf0aV2OKoYbr14lqt/oMRU+SON8yHHC1Jk85u31a8szc
         deN20WYp7dTMccJoFy1hk7/ZZ23WxWDYLAV3HGv7nelChydO9rkmKHkzlUJJC5ZPjg9X
         se5IXrPIGDaZ9DfmfOFYaklSCcfxulgcauEAIXJpg/RRoOjYkHnrUPXv76g7c7YFFqVz
         b310a6EnhQf2R1ekUr9quG72BQ+EcCx9RZVCUTXEq8rHGzNUYlYbT9Vr30ovG2ksBAVL
         3XuKvcoRuTMyQuwvffx01qnVS4rZuq0hm9nAbeX0jF4MKTwFkva6BV26wtY6jt6s2co8
         OE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Up6hiDVLuWAaCEN91nYS7vd27XRu7U8JIDCkwO+t6lI=;
        b=chqw6jA+QCF+kM77MVmwowI3wSCNK5f37BzEkmH8MdjGyYm6l/mVvurFjjhKkkglOs
         GkHwTvhmoLsyAmVBiFvkQjhJOETtQahRe3mxkVd/FFYd85D4LQpWn5wFotSanx3vDaH2
         iKGooo4PMi7g5bjl79g9zevIali/inOVBUpjHXVscxm+lvB9g5BeYJ8uiIkBNmlcZ0lh
         Q/fCaPvgYFLFJ6J3cM4Txykzq6ZAiTwemsBHpEW//MxVY6dueIl+hA4qbTwYle6cQ1WX
         ucQOdN5UUnFRkCR+G/NrkkMVJsTG65p2G4V2JBhGdgrEAwnps0Qqz1ItXrc/1djyaiCF
         YPSA==
X-Gm-Message-State: ANoB5pnB9yElhs5kipffc4zWkokK4366zadIQSFhkqBHa2icc+WrMKMN
        CrquQVqF+AdpWTBC4/wNuYJyYdH8TF5gEg==
X-Google-Smtp-Source: AA0mqf4wMA+98QzusmPHP9MzmidlM23GOI6GGkj5zD+NTQeANkRWYvlz5MW+idM0YOworZkVsW+Oog==
X-Received: by 2002:a5d:6248:0:b0:23e:245b:edf1 with SMTP id m8-20020a5d6248000000b0023e245bedf1mr676186wrv.142.1668102059257;
        Thu, 10 Nov 2022 09:40:59 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0023682011c1dsm16268026wrq.104.2022.11.10.09.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:40:58 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, openglfreak@googlemail.com,
        alex@alexyzhang.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/1] HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk
Date:   Thu, 10 Nov 2022 18:40:55 +0100
Message-Id: <20221110174056.393697-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

About 3 months ago, Torge Matthies sent a patch fixing an issue with
his XP-Pen Star G640 [1].

His patch changes the IS_INPUT_APPLICATION() macro to accept
HID_DG_DIGITIZER. However, it looks like it is not being merged because
of the possible side effects that changing that macro could generate.

This patch aims to fix the same issue but using a more conservative
approach hoping that the bug can be fixed.

Torge, Alexander, could you test it and confirm that it fixes your
issues, please?

Thanks a lot in advance,
José Expósito

[1] https://lore.kernel.org/linux-input/20220804151832.30373-1-openglfreak@googlemail.com/

José Expósito (1):
  HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk

 drivers/hid/hid-uclogic-core.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.25.1

