Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D19C6D3664
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjDBJGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDBJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:06:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD87B762;
        Sun,  2 Apr 2023 02:06:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15644B80DD2;
        Sun,  2 Apr 2023 09:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826F5C433EF;
        Sun,  2 Apr 2023 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680426365;
        bh=tstDOziMek5axEwzqeGOS4xIyUKdT0x7UNiG+x46cAk=;
        h=From:To:Cc:Subject:Date:From;
        b=SUDLEiUmZd2M1RI9wUDKRUVEeV/HdPsXS+MjJD/eZftQxGBCcLvHuatVpIyRnxcuR
         RvGM4EGuMAIht5//BYns6EzaBON7q3NASjPqGIVqOFR1oaUrNjeEV9TE0/JZLDfixj
         78w4Ura2Z1HhUDYidKF9iNAhMM5gRZS2ejE3M+b8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        John Crispin <blogic@openwrt.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yang Yingliang <yangyingliang@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] MIPS: vpe-cmp: remove module owner pointer from struct class usage.
Date:   Sun,  2 Apr 2023 11:05:45 +0200
Message-Id: <2023040242-pursuable-frown-48d8@gregkh>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=tstDOziMek5axEwzqeGOS4xIyUKdT0x7UNiG+x46cAk=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmarulHPKZdSzJ7I/Up7v9T/is3dTUKdwrYa97om/nSO /k9r7x1RywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwksI5hwYG4qeWZC4XMk16F cr/xjXm58fXSWwzzA3atvvxUVSxgt/aK2yWL7Dh+lF3IAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 6e30a66433af ("driver core: class: remove struct module owner
out of struct class"), the module owner pointer was removed from struct
class, but this was missed for the mips vpe-cmp code due to lack of
build testing (and it being burried under a very unused config
settings.)  Fix this up by removing the module pointer to resolve the
build error.

Note, there are other problems with the driver model usage in this file
(static struct device usage, empty device release function, etc.), so it
probably could use some good cleaning up, but odds are this driver
really isn't used so hopefully it will just be removed entirely someday
soon as part of the general "remove unused arches" cleanup that is
slowly happening.

Cc: Dengcheng Zhu <dzhu@wavecomp.com>
Cc: John Crispin <blogic@openwrt.org>
Cc: Qais Yousef <Qais.Yousef@imgtec.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-mips@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304020802.xbRTJKjW-lkp@intel.com/
Fixes: 6e30a66433af ("driver core: class: remove struct module owner out of struct class")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/vpe-cmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
index 92140edb3ce3..4ef7f49a4c6d 100644
--- a/arch/mips/kernel/vpe-cmp.c
+++ b/arch/mips/kernel/vpe-cmp.c
@@ -79,7 +79,6 @@ static void vpe_device_release(struct device *cd)
 
 static struct class vpe_class = {
 	.name = "vpe",
-	.owner = THIS_MODULE,
 	.dev_release = vpe_device_release,
 	.dev_groups = vpe_groups,
 };
-- 
2.40.0

