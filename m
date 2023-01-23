Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8456788B8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjAWUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjAWUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:54:03 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E112E1114F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:54:01 -0800 (PST)
Received: from ipservice-092-217-089-134.092.217.pools.vodafone-ip.de ([92.217.89.134] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pK3pC-0000Lk-7g; Mon, 23 Jan 2023 21:53:54 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/23] staging: r8188eu: some more xmit cleanups
Date:   Mon, 23 Jan 2023 21:53:19 +0100
Message-Id: <20230123205342.229589-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another series with cleanups of the xmit part. Amongst other
things, it replaces some __queue variables with standard list_heads.

This series also includes rebased versions of the patches that caused
conflicts during the last review cycle.

Martin Kaiser (23):
  staging: r8188eu: we use a constant number of hw_xmit entries
  staging: r8188eu: pass struct adapter to usb_write
  staging: r8188eu: remove struct intf_hdl
  staging: r8188eu: remove struct intf_priv
  staging: r8188eu: simplify the sta loop in rtw_dequeue_xframe
  staging: r8188eu: simplify the code to initialise inx
  staging: r8188eu: remove an obsolete comment
  staging: r8188eu: remove unused function parameter
  staging: r8188eu: remove dead assignment
  staging: r8188eu: use list_empty
  staging: r8188eu: simplify dequeue_one_xmitframe
  staging: r8188eu: remove redundant parameter
  staging: r8188eu: make rtw_chk_hi_queue_cmd a void function
  staging: r8188eu: decrement qcnt in rtw_dequeue_xframe
  staging: r8188eu: simplify dequeue_one_xmitframe
  staging: r8188eu: use list_head for xmitframe list
  staging: r8188eu: merge dequeue_one_xmitframe into its caller
  staging: r8188eu: use lists for hwxmits
  staging: r8188eu: fix rtw_xmitframe_enqueue error handling
  staging: r8188eu: remove rtw_xmitframe_enqueue
  staging: r8188eu: struct agg_pkt_info is unused
  staging: r8188eu: apsd_setting is unused
  staging: r8188eu: merge rtw_free_hwxmits into its only caller

 drivers/staging/r8188eu/core/rtw_cmd.c        |  16 +--
 drivers/staging/r8188eu/core/rtw_xmit.c       | 119 +++++-------------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |   7 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  18 +--
 drivers/staging/r8188eu/include/drv_types.h   |   1 -
 drivers/staging/r8188eu/include/osdep_intf.h  |  32 -----
 .../staging/r8188eu/include/rtl8188e_xmit.h   |   3 +-
 drivers/staging/r8188eu/include/rtw_cmd.h     |   2 +-
 drivers/staging/r8188eu/include/rtw_io.h      |   8 --
 drivers/staging/r8188eu/include/rtw_xmit.h    |  23 +---
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   6 -
 11 files changed, 57 insertions(+), 178 deletions(-)

-- 
2.30.2

