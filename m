Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1F73256A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjFPCxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjFPCxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:53:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641E92953;
        Thu, 15 Jun 2023 19:53:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso177154e87.1;
        Thu, 15 Jun 2023 19:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686884011; x=1689476011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kFgu8FWM4Gf6hm5nPlre0K9PgbWZtv1AsAuuIyVNe4=;
        b=q5+Utgokxvif9/N22sEUcN6nL79Azu+IUrd+5OfrEL/EpRPDSK3xLEYFdQUT2KcCk3
         mu5lXN3UZjYK3Wt9yOW7uVwrO3CiO1QOXIkQBqfT+J5WoM0fR1VXZkHyECQsXjhN0mlU
         su2NJPbsc37uBxuNXdtXntu+UjngUBGhEn4ZDs00XgQL8yqnSt3ApsSkJ6gKYe1DWAzQ
         V5SsnLoymI1vET1P4g6dQ0ceu/l6KmUvcwRto8dsXJoeMdp+M37wM7aPDZGJKsVHYMF6
         FkPY8BRS3HkcnDoBTheWzKFBrdlRihUmdD7pDMhUahCwmVEN7H4yv0CTSV+DDxNNpFVV
         WLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686884011; x=1689476011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kFgu8FWM4Gf6hm5nPlre0K9PgbWZtv1AsAuuIyVNe4=;
        b=XWA559beib/bP+c6kUXcKb1HN3n0RjO187GNSidvr2qt/C5Z5nkJDQMqtfxDMgz+hw
         ypSuGq3qpx4X11LzE0ryJvTuTp8g9nmDmf2dESnKP4F0JajxVgGZRJgZV0dRiFqolXMQ
         vkN7gDdPMBw8J/WUgfk8/Qi5yoj9UudyozO1vqN2r+li10dRNxoFByv0iJFm43mjbumh
         px6X5NOuhdvKjoK5Jnzo++1u4dHtH9LxTjHPC/lrcmJccvfSz+Y8vOXWB4r3rxDq1FWB
         RylK2s3NPZhFDAPIyjQQAnf8YyOwPm8Ejgk4zkT6Z0Gfr7AtkL1eJSM9q/PHQRD3iwQO
         Ogrw==
X-Gm-Message-State: AC+VfDyq1Up+z9YjQLy9taz0IvBhtnvBsE5AgTOgUz57i4pOodlRjjY1
        ZDNxNM7uTPB/KtZSlcudKkM=
X-Google-Smtp-Source: ACHHUZ5ebDOQw0QiINFOr/jhMlWot9TCSLb7tYwG1tgN3cqvI+jQcmJFsciUE1fYE1pvNeHAFBEB8w==
X-Received: by 2002:a05:6512:328c:b0:4f3:b49b:e246 with SMTP id p12-20020a056512328c00b004f3b49be246mr323458lfe.5.1686884011259;
        Thu, 15 Jun 2023 19:53:31 -0700 (PDT)
Received: from arinc9-Xeront.. (athedsl-404045.home.otenet.gr. [79.131.130.75])
        by smtp.gmail.com with ESMTPSA id v15-20020a1cf70f000000b003f8d770e935sm890328wmh.0.2023.06.15.19.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 19:53:30 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Landen Chao <landen.chao@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net v5 0/6] net: dsa: mt7530: fix multiple CPU ports, BPDU and LLDP handling
Date:   Fri, 16 Jun 2023 05:53:21 +0300
Message-Id: <20230616025327.12652-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi.

This patch series fixes hopefully all issues regarding multiple CPU ports
and the handling of LLDP frames and BPDUs.

I am adding me as a maintainer, I've got some code improvements on the way.
I will keep an eye on this driver and the patches submitted for it in the
future.

Arınç

v5:
- Change the comment in the diff on the first patch with Russell's words.
- Change the patch log of the first patch to state that the patch is just
  preparatory work for change "net: dsa: introduce
  preferred_default_local_cpu_port and use on MT7530" and not a fix to an
  existing problem on the code base.
- Remove the "net: dsa: mt7530: fix trapping frames with multiple CPU ports
  on MT7530" patch. It fixes a theoretical issue, therefore it is net-next
  material.
- Remove unnecessary information from the patch logs. Remove the enum
  renaming change.
- Strengthen the point of the "net: dsa: introduce
  preferred_default_local_cpu_port and use on MT7530" patch.

v4: Make the patch logs and my comments in the code easier to understand.
v3: Fix the from header on the patches. Write a cover letter.
v2: Add patches to fix the handling of LLDP frames and BPDUs.

Arınç ÜNAL (6):
  net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP
  net: dsa: mt7530: fix trapping frames on non-MT7621 SoC MT7530 switch
  net: dsa: mt7530: fix handling of BPDUs on MT7530 switch
  net: dsa: mt7530: fix handling of LLDP frames
  net: dsa: introduce preferred_default_local_cpu_port and use on MT7530
  MAINTAINERS: add me as maintainer of MEDIATEK SWITCH DRIVER

 MAINTAINERS              |  5 +++--
 drivers/net/dsa/mt7530.c | 44 +++++++++++++++++++++++++++++++++++--------
 drivers/net/dsa/mt7530.h |  6 ++++++
 include/net/dsa.h        |  8 ++++++++
 net/dsa/dsa.c            | 24 ++++++++++++++++++++++-
 5 files changed, 76 insertions(+), 11 deletions(-)


