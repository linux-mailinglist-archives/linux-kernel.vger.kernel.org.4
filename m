Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C2072F3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbjFNEwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFNEwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:52:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD6F183
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b4f8523197so3475685ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 21:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686718342; x=1689310342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YHHOxlInWG/EMNSSTIpmL8pTXVUvf1wMI3WxkD872/o=;
        b=J+TxTDiJTPboucEa+tW6hFc/DHBLo/YBJMqjafgFNTyxWcBTYOfCddFzS73N91Pryz
         AZC9GiIHnAE77ICMNwi9m/8hPSAMGDWHzxekljBgoQhxrxTqhlkDuUDWptVLAP9N+hXD
         d4hZgmTdwLqORB6UgGJMdAfI3Ussb1CrfS9MDORFb8jjQHpGWtGJrGDDAHSaFiF+MWB0
         sgeS1cnJd7eZgGyFuIa68zMCoUI/qvyENlyYEnTyoES/74YCcea1Csc6oRiqHkxIgjj5
         uEFHR4NYXEe/nLzXsAgv+GzTY/FVXeWyARwUoGSyoE5vBlvAqS3nPHy7KB2X8C99bfrY
         3QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686718342; x=1689310342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHHOxlInWG/EMNSSTIpmL8pTXVUvf1wMI3WxkD872/o=;
        b=Avbfy4MgdHj5jfkmqtGycP5upaPYE6djEeORrTlkdsJE5RLmh2clYHXbZAx5gzReyT
         /NOCTqZzGioNJbOvDVYQkbujghyz5WHBr2YhftsaGTeJIs0RqJC2l+/qBtpMke3wMifp
         YA/pLsWtFg8cV6UJDStT2iplIV+ifgD/6tvmgLBgHzgh5O96YmVpJsNATbUc/hK/aLbh
         xY0uo7u5zktMNGthz8qnD24DqhwDzSB4MYg8qpkcartjdSUltWCuSrCHxU0VrVJ3iWlw
         qs2SY7Q6gKqmBj+Fg6CVm6B+XWjJNlwzUMjl1zKmObiyKOZokQ1vybKc0gvdKMzzXTRF
         8how==
X-Gm-Message-State: AC+VfDwipWdXkv6CbGku2WAAfKbVpoXY2I3IS2UIooM1HffJr16l4dy2
        Rq24N+cLrx9b/RsAOnmDMOx1/Tk/XCs=
X-Google-Smtp-Source: ACHHUZ65ef1Xsw+ITW3IYqM56xZ/vWXi6JSmTwZRL9/AA5V1Q2lBTS5ktzq3TptEROWweQPg7ksz5A==
X-Received: by 2002:a17:902:e892:b0:1b2:3e9f:69d1 with SMTP id w18-20020a170902e89200b001b23e9f69d1mr733076plg.18.1686718342244;
        Tue, 13 Jun 2023 21:52:22 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:bf5f:2e99:78f2:6007])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001acad86ebc5sm11089790plg.33.2023.06.13.21.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 21:52:21 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/4] xtensa: add load/store exception handler
Date:   Tue, 13 Jun 2023 21:52:08 -0700
Message-Id: <20230614045212.2534746-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series rearranges unaligned exception handler and adds load/store
exception handler that allows transparent 1- and 2-byte wide reads from
memory attached to an instruction bus of an xtensa core.

Max Filippov (4):
  xtensa: move early_trap_init from kasan_early_init to init_arch
  xtensa: always install slow handler for unaligned access exception
  xtensa: rearrange unaligned exception handler
  xtensa: add load/store exception handler

 arch/xtensa/Kconfig             |  12 ++
 arch/xtensa/include/asm/traps.h |   7 +
 arch/xtensa/kernel/align.S      | 256 ++++++++++++++++++++++----------
 arch/xtensa/kernel/setup.c      |   7 +
 arch/xtensa/kernel/traps.c      |  27 +++-
 arch/xtensa/mm/kasan_init.c     |   2 -
 6 files changed, 221 insertions(+), 90 deletions(-)

-- 
2.30.2

