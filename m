Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD75B534E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 06:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiILEgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 00:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiILEgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 00:36:03 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC121AF28
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 21:36:01 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <m.v.b@runbox.com>)
        id 1oXact-009cFM-Sa; Mon, 12 Sep 2022 06:00:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From; bh=UB4fTYWfrW3vEt2oDlOTKBk6EbS08X1+1sCyJYpMX6M=; b=wsBt9B
        rNhZlSmXaFOaUsL7bzGgtj6T7a5eDibuOqEJyMGFsWPJHhhEZ7XYhJuc4B5Nl1EqurFY12BPedUZz
        bfHkSGxrj1XbJp1AwXJy0UOSEcx2IeWNvPkf3IKz50q84/OFGAMT03HUT1v3MeAGEyBUOOdnZzM8a
        /o0ye5rKua9T7Klgi/hJwrnQqymFfyE5e4cG5MtZ19CYsFxRMRXUnrV+FKN21itSK65H6euVC3LGJ
        MQiDuyeA+4MVqW75zaAkcDGoAX+cBOMvTuYilUiWPpXxB0ZDLOvM12//HqjbLUNrSCWzHlJbg8B1B
        9z7JeYqQ1fpFHHDJI73HWwoCXW9A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1oXact-0004X5-Cu; Mon, 12 Sep 2022 06:00:51 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (536975)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oXach-0003S3-DL; Mon, 12 Sep 2022 06:00:39 +0200
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     m.v.b@runbox.com, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/2] xen/gntdev: Fixes for leaks and VMA splitting
Date:   Mon, 12 Sep 2022 00:00:00 -0400
Message-Id: <20220912040002.198191-1-m.v.b@runbox.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The changes in this patch series intend to fix the Xen grant device
driver, so that grant mapping leaks caused by partially failed grant
mapping operations are avoided with the first patch, and so that the
splitting of VMAs does not result in incorrectly unmapped grant pages
with the second patch. The second patch also prevents a similar issue in
a double-mapping scenario, where mmap() is used with MAP_FIXED to map
grants over an existing mapping created with the same grants, and where
grant pages are unmapped incorrectly as well.

These commits were tested on top of Linux v5.15.67, but I have also
verified that they compile fine on top of the base commit mentioned at
the bottom of this cover letter. The base commit in question is tagged
as "next-20220909".

Thank you,

Vefa

M. Vefa Bicakci (2):
  xen/gntdev: Prevent leaking grants
  xen/gntdev: Accommodate VMA splitting

 drivers/xen/gntdev-common.h |  3 +-
 drivers/xen/gntdev.c        | 90 +++++++++++++++++++++----------------
 2 files changed, 54 insertions(+), 39 deletions(-)


base-commit: 9a82ccda91ed2b40619cb3c10d446ae1f97bab6e
-- 
2.37.3

