Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D863168A165
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjBCSPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBCSPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:15:07 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A362393ADA;
        Fri,  3 Feb 2023 10:14:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q8so4505497wmo.5;
        Fri, 03 Feb 2023 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJaZb5nxRdIAYZJXog7RT2LAiPazCIDi6rFA+K/IMHU=;
        b=WkWF1xJX0LbyTnZcglAxkECaVBwysEb4ZA29mQ1hmhOBgGoQxU5oygVqpa7SzcIIas
         mNZJ7/ewqqKeVV4HyTYlvNoTyTT6WF+IWFWcsY7NIC6qifISUjR06JAVoIzKTYQcZwq7
         /pjID3hNEOEYqWJlidpASY2MZxfFpIG5X+3Mh3YzLjdfIh8DY6Bb27Hp1eX7L/rDK8J+
         AAzVqZgUoRti2f5Z98W0gBPTRyh/puke3K7ZZCBrBOlVh9EEinoCAXN2DMzqGGUnPB6K
         oCkKN/NLM3L4OILzrSZrxIB6Jr60B4r8AIhiUA7IYICUUyzRty0FBoT8Qn6UrlIsz4wQ
         fUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJaZb5nxRdIAYZJXog7RT2LAiPazCIDi6rFA+K/IMHU=;
        b=xS4bPsobtJ3gQG4bYo+xeTJbQ5Vh3EiTJy2tdzg+utHaFhHihdnLZvcoArAtZyKvtm
         aoPopp8tD+dTRTYEDe+JbN5CI5abJlK0GupxIORMAgeTCyi0x7mO7tnBm8ykkirvrCVY
         qKUkkq5pGWji7PI80mJ6XoW6n0bDXWAHi23Fc1oob3vILH6w3D6WEDgW5V1eT51DKgv4
         ifbwaMNsJOyvdj+zKiSCPz/uvjohC8btA4Xx+6y1s0pkdtKtpmLEXw4jtr8bpzBFbmCP
         srxaIEMDPYKgF9zUy39x9dF1UIXPJvCzPDvvu1sbWzViXe2hg7cDwsbfe5h9Lekc2lKO
         swOA==
X-Gm-Message-State: AO0yUKUgkSE+tfIWBENoJ7gCIvpBn46IAJtA06D4RNR9raN6dvJEHsjq
        vlgVsB4/K/q4jRPXRuw3Xoe1mDOC8jvP8A==
X-Google-Smtp-Source: AK7set/YwXHbxCOm5eeeNleYZEdTH9c6TH6d3zxAuS8wiSB9Gw1dJUH4aEnWUuFfug0rBJ/Es0po6w==
X-Received: by 2002:a05:600c:2e06:b0:3dc:51f6:8f58 with SMTP id o6-20020a05600c2e0600b003dc51f68f58mr10931423wmf.6.1675448093089;
        Fri, 03 Feb 2023 10:14:53 -0800 (PST)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c205100b003dd1bd0b915sm5446445wmg.22.2023.02.03.10.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 10:14:52 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 6.2-rc7
Date:   Fri,  3 Feb 2023 19:13:13 +0100
Message-Id: <20230203181313.452449-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc7

for you to fetch changes up to a68e564adcaa69b0930809fb64d9d5f7d9c32ba9:

  ceph: blocklist the kclient when receiving corrupted snap trace (2023-02-02 13:58:15 +0100)

----------------------------------------------------------------
A safeguard to prevent the kernel client from further damaging the
filesystem after running into a case of an invalid snap trace.  The
root cause of this metadata corruption is still being investigated but
it appears to be stemming from the MDS.  As such, this is the best we
can do for now.

----------------------------------------------------------------
Xiubo Li (2):
      ceph: move mount state enum to super.h
      ceph: blocklist the kclient when receiving corrupted snap trace

 fs/ceph/addr.c               | 17 +++++++++++++++--
 fs/ceph/caps.c               | 16 +++++++++++++---
 fs/ceph/file.c               |  3 +++
 fs/ceph/mds_client.c         | 30 +++++++++++++++++++++++++++---
 fs/ceph/snap.c               | 36 ++++++++++++++++++++++++++++++++++--
 fs/ceph/super.h              | 11 +++++++++++
 include/linux/ceph/libceph.h | 10 ----------
 7 files changed, 103 insertions(+), 20 deletions(-)
