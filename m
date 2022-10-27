Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C612060EF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiJ0EnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ0EnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:43:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0494156244;
        Wed, 26 Oct 2022 21:43:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9so250345pll.7;
        Wed, 26 Oct 2022 21:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0isRSvxKOUKWvo+ShVUDgJ9UCs7Mq+apMEV7CTZEMk=;
        b=N2AJ9L/0qCKpQPijTw8x49MBqW2P0RpzCe8819sLrCro+2o24U/vLj05vRH3Q/mWIK
         uMzgF2KBW+sOJtrHUxHojNiPKvKE14OsrchOSK/EiYNEzNj7xkzR0QYzH8m9XmW+llm7
         V+a4NCGC+5B3c0bNLref33ejocHMoHVUbawBLStmL/qxkbAbk85YZKOhcRhFpIibxjOo
         qmQ387RT1I9h9SD1esWs5cr+c+H1I1L6Ge6taNcWykUfVCcBrq+5RdbV/o1Ssr9/e+oP
         Eg72UOZMWjax0G+DKrAqLy23+HHYAu5PCAkCfai7Vdixjax/Xm6elFn0qz+A0+eeTyoB
         sntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0isRSvxKOUKWvo+ShVUDgJ9UCs7Mq+apMEV7CTZEMk=;
        b=8SHkeBwzlsc3E64M+k94orJts4LwcJ5xVB9IIL0i6Ez6Uka20hEN3Cx517IChHfq5+
         Io+hMri809wSB+wXyl5vxYPoivZWG394773N6tB7uUCLjwYOhX4uefSKYQUUdQWLXQwR
         wHz8AfXVib9YnXxvlnfAPD2mt5mSLlCGnKEdvScvG7v9AUr5uFDt8oJxcfnQfIZhSMQz
         FHNekjnZeAWCkXqYDt7DyCmHPtIsmXJHl3HUWS5WPRk9lkqm0xJ26vGuK4poWCALqEJl
         uBI7PGuoDFFD5SA3NkGE7pSZt2oKH2laJ0M7s5YIStBr9uX4/lcISJu/oFss89lQUCJ4
         vo6A==
X-Gm-Message-State: ACrzQf0urjKKw5NpoclpUyk+cRnNhT7b0Ia5Z6tUITS2okpMtZ4o8yOE
        zfCpK6Pf+36E9KrNtZ5l21Y=
X-Google-Smtp-Source: AMsMyM4rgdABOZ7G87wg1z2ZmiSU4FTB0mDsl/gKDZi09g0dgYADtvL8rnrohhIoq51iaQ/ZUfRZoA==
X-Received: by 2002:a17:903:245:b0:178:e0ba:e507 with SMTP id j5-20020a170903024500b00178e0bae507mr49071531plh.115.1666845791170;
        Wed, 26 Oct 2022 21:43:11 -0700 (PDT)
Received: from carrot.. (i220-108-44-211.s42.a014.ap.plala.or.jp. [220.108.44.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b00186a2274382sm186929plx.76.2022.10.26.21.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:43:10 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+e91619dd4c11c4960706@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] nilfs2: fix UBSAN shift-out-of-bounds warnings on mount time
Date:   Thu, 27 Oct 2022 13:43:04 +0900
Message-Id: <20221027044306.42774-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Andrew,

please apply the following bug fixes to -mm tree:

Ryusuke Konishi (2):
  nilfs2: fix shift-out-of-bounds/overflow in nilfs_sb2_bad_offset()
  nilfs2: fix shift-out-of-bounds due to too large exponent of block
    size

The first patch fixes a reported bug by syzbot, and the second one
fixes the remaining bug of the same kind.  Although they are triggered
by the same super block data anomaly, I divided it into the above two
because the details of the issues and how to fix it are different.

Both are required to eliminate the shift-out-of-bounds issues on mount time.

Thanks,
Ryusuke Konishi

 fs/nilfs2/the_nilfs.c | 73 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 8 deletions(-)

-- 
2.34.1

