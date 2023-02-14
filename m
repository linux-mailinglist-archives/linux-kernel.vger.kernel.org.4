Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E966965F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjBNOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjBNOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:09:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE78E29400;
        Tue, 14 Feb 2023 06:08:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0230F61652;
        Tue, 14 Feb 2023 14:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B239C433D2;
        Tue, 14 Feb 2023 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676383663;
        bh=zce8QKVBJkEIXF59dxMyDtcW4qvuXPNLJ6sOhE8RueQ=;
        h=From:To:Cc:Subject:Date:From;
        b=l3txA3xWDmy4ooFkvP7a5PQ7BIHvWpV3aTqjbR5wtUChigPobs0oCXRVdK0QRgWen
         TDT+mSJD71UNB57zahQLRycH6xKd81Sw0M4cr+rNVRJz3K/3/7zbsYwc5seltenHIB
         N+SxGGaMnA06DbxbDhTPkpix5+7ccGris499RL7Yg5j/BVHcqT6onexKczZXC9ZQZl
         XMihRoVWr8ZIZPFy5gfGZOjVoTmmwlRx9V1npvxM1vfTlMJfHrRytuA90Nn7YOz6hM
         rqNy0rwEiGAf+cte9ESjyQntRAbj+APkwss5PKVo70x15m7/k6Wi7T7IEgjJGdKJFD
         XxWTCPceUj8xw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org
Subject: [PATCH 0/2] fixups for generic implementation of pfn_valid()
Date:   Tue, 14 Feb 2023 16:07:27 +0200
Message-Id: <20230214140729.1649961-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Hi,

Guenter reported boot failures on m68k-nommu and sh caused by the switch to
the generic implementation of pfn_valid():

https://lore.kernel.org/all/20230212173513.GA4052259@roeck-us.net
https://lore.kernel.org/all/20230212161320.GA3784076@roeck-us.net

These are small fixups on top of mm-stable that address the issues.

Mike Rapoport (IBM) (2):
  m68k/nommu: add missing definition of ARCH_PFN_OFFSET
  sh: initialize max_mapnr

 arch/m68k/include/asm/page_no.h | 2 ++
 arch/sh/mm/init.c               | 1 +
 2 files changed, 3 insertions(+)


base-commit: f67d6b26649379f8520abe6a6c7ed335310bf01e
-- 
2.35.1

