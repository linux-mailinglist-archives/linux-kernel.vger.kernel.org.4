Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06CD69232D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjBJQVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjBJQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:21:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45EA7284;
        Fri, 10 Feb 2023 08:21:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so4456808wmb.2;
        Fri, 10 Feb 2023 08:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nt8Gh4/OONJu6PpXJeU0AbL49OiKDt7nnRYsckchfN0=;
        b=QrGz91cJj7opg88MsdPrKWB+iQxzHrgJYIUn/ZbG0qWZxAWA5PGDmdJToQl5HTBXsv
         OWKQptZ8fffhwxl1oPrIOx1VL1ZXhuBGDYHku9eUXO/j0EOAZd5hH9NkxK+d8BLSNudc
         GGQy2OfqAFF/Iw/oihCudX2U/pzfDroW00EbKAEjNjQ8jrf9EXmsSgUeE08sd67dltEl
         PEwqCsZJ5s0v5bx0MQFLw4l1UR59s3zwcyEWaiG35Pie0LGDiM3a4OVJxb2O2astx+vp
         uwZIUsGXDqGbDTyzEe10r4xDmJG9B80nZsVz2nynrl/6+hqvHKlhGkbIIgOImkuY9tY/
         RBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nt8Gh4/OONJu6PpXJeU0AbL49OiKDt7nnRYsckchfN0=;
        b=v1EfK8fr2MNFKZpdZzXgAmgH/VFzUHgHdjvaoPtZNAQ1ruBwDayKUCcIWGYVgH+V2C
         OsfD77iNnNeVbaFNgBqa68cTSiJvmY+98T1Cd1aqAU08T26ilEwxJ05Jaf/75SE5EVPp
         XQiFIZQOF0UTigwK8x9i5ltrLl5Jmsf8VO24SRFEFxvEx9nVbafpLmoRMlyKobtKX4D4
         LxjEwyBzrOuLnE4HDGcAcKoLuFl7JERgnv+g9fAqyE6xrFGDHOI7lOJnphHzq3N7LD+q
         TilN2+Fgn3RfSGSdMPQWVpmppCyo4pz/rmE6OmX1S9e5oM4AyEflLFl3wZPDSJgPEKWt
         KJ1A==
X-Gm-Message-State: AO0yUKXUVpvEag9AnbbgTElck2FNSUdPfJLqgdn3gvHCXQqV5Dk5psGc
        nSNUsiv33avTR0u8M40MzhETKBLyp8U=
X-Google-Smtp-Source: AK7set9vKeb8b8PsM2fowagD0M4M9mIigwCOtgIQrevOWk1YhsweGHC52Ic/fCxHdlwBxJYCvhH6ZA==
X-Received: by 2002:a05:600c:1656:b0:3e0:fda8:7e26 with SMTP id o22-20020a05600c165600b003e0fda87e26mr9654204wmn.33.1676046081464;
        Fri, 10 Feb 2023 08:21:21 -0800 (PST)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003d9fba3c7a4sm7995040wmi.16.2023.02.10.08.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:21:20 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 6.2-rc8
Date:   Fri, 10 Feb 2023 17:21:12 +0100
Message-Id: <20230210162112.534456-1-idryomov@gmail.com>
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

The following changes since commit 4ec5183ec48656cec489c49f989c508b68b518e3:

  Linux 6.2-rc7 (2023-02-05 13:13:28 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc8

for you to fetch changes up to e7d84c6a1296d059389f7342d9b4b7defb518d3a:

  ceph: flush cap releases when the session is flushed (2023-02-07 16:55:14 +0100)

----------------------------------------------------------------
A fix for a pretty embarrassing omission in the session flush handler
from Xiubo, marked for stable.

----------------------------------------------------------------
Xiubo Li (1):
      ceph: flush cap releases when the session is flushed

 fs/ceph/mds_client.c | 6 ++++++
 1 file changed, 6 insertions(+)
