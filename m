Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2564CEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiLNR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbiLNR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:28:43 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329FBB68;
        Wed, 14 Dec 2022 09:28:41 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x11so7315102ljh.7;
        Wed, 14 Dec 2022 09:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VLmoAaTp6wol86VtBLyFlQuLv7H9atQ1IdPrQrK6e1U=;
        b=gUniewjYrsFEVx4VVGgw3BZkpdBKd3E2uBxGvTkRe5GM6xMCAsiy7emDJGFOu/Hiqz
         /gBNj1OpoC6u1WihZ9Eg2tHJlL0SLD/5VTZLWa4ms/MapQM/fdJl5B/jJ10kV48UbwyN
         NgucQ/9Zdk3xSYxKkATrqeegdeHrWAocaGF77YeneWVnzF+1t0tyifBdRNbrltdMvUfI
         laUAb0eMurKECC7Mke0Olw2VOkfhRD5yjtEwuCTnjzM7t8fobjppfc6LgVhSQc/4TctG
         E4EdsyzSQykEpgtbM60RMIu7mDyV0I2s071H7/My7o/UuZZgt/iV1Y8fAi0nS38Gm0Ze
         CB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLmoAaTp6wol86VtBLyFlQuLv7H9atQ1IdPrQrK6e1U=;
        b=Q3G/jJ2B0SMu4DgCLvezOrolpnBQulcOjLtO3YEhZGAwghhe7T0OoPsJcRdEzFlx7r
         UrUMFnQEPCJaPKeVkG/KWeWwJJvwgwlMZSB2JYppbPxhb2Z7Q10lEDBuMUbiKeb51jbX
         43XZY5yCyn5YVz0wOkAWIf6PLRXKcObreCt37HTIVgp0nO01nAErlmjaYCDF+P908Jsk
         nVmA83envgdXIrCni9QwySbytr8IkEIbsw0RVC2yc7Tu/z9OsG11+6B6ZzzH12mXDX7D
         l13DvZPwLxQvq1MNwuYy4nG20Jyw2BHsVub8hrm4BYZWCyR7rJ0hOJwMWh7clJUbVx/3
         Jzbw==
X-Gm-Message-State: ANoB5pk7hLtWPDUIpYM3olbD44PgBBIRReYhaT3jjpu9ei2jak+mMOSp
        dSRESSyzFU5sSrmfl5V1bBX+BcO1Z9A=
X-Google-Smtp-Source: AA0mqf5CXR6iO1+0lw0M469LBnHPvB7gKa2hJ+p3S3J6mZvi40oITIMqbSGiNWEdDfg2poLfW6vX7Q==
X-Received: by 2002:a17:907:a409:b0:7b8:947e:61c3 with SMTP id sg9-20020a170907a40900b007b8947e61c3mr27839753ejc.77.1671038907503;
        Wed, 14 Dec 2022 09:28:27 -0800 (PST)
Received: from zambezi.redhat.com (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007aed2057eacsm6110711ejf.221.2022.12.14.09.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:28:27 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 6.2-rc1
Date:   Wed, 14 Dec 2022 18:28:20 +0100
Message-Id: <20221214172820.96191-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.38.1
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

The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa2476:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.2-rc1

for you to fetch changes up to 68c62bee9d081cf815310b3a96e38d94fc16007d:

  ceph: try to check caps immediately after async creating finishes (2022-12-12 19:15:39 +0100)

----------------------------------------------------------------
A fix to facilitate prompt cap releases on async creates from Xiubo.
This should address sporadic "client isn't responding to mclientcaps
(revoke) ..." warnings and potential associated MDS hangs.

----------------------------------------------------------------
Xiubo Li (2):
      ceph: remove useless session parameter for check_caps()
      ceph: try to check caps immediately after async creating finishes

 fs/ceph/addr.c  |  2 +-
 fs/ceph/caps.c  | 25 +++++++++++--------------
 fs/ceph/file.c  | 26 ++++++++++++++++----------
 fs/ceph/inode.c |  6 +++---
 fs/ceph/ioctl.c |  2 +-
 fs/ceph/super.h |  5 +++--
 6 files changed, 35 insertions(+), 31 deletions(-)
