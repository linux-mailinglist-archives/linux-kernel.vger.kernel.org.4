Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680B7659B38
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiL3SHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiL3SHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:12 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2158760E2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:11 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJma-0004rR-KX; Fri, 30 Dec 2022 19:07:04 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/20] staging: r8188eu: some xmit cleanups
Date:   Fri, 30 Dec 2022 19:06:26 +0100
Message-Id: <20221230180646.91008-1-martin@kaiser.cx>
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

Start cleaning up the code that transmits data frames to the dongle
via USB.

This should be applied on top of the "merge public action functions"
series.

Martin Kaiser (20):
  staging: r8188eu: make xmitframe_swencrypt a void function
  staging: r8188eu: remove some unused CAM defines
  staging: r8188eu: cmd_seq is write-only
  staging: r8188eu: return immediately if we're not meant to encrypt
  staging: r8188eu: remove unused parameter
  staging: r8188eu: simplify rtl8188eu_xmit_tasklet
  staging: r8188eu: remove rtl8188eu_init_xmit_priv
  staging: r8188eu: remove duplicate psta check
  staging: r8188eu: simplify frame type check
  staging: r8188eu: simplify rtw_make_wlanhdr's error handling
  staging: r8188eu: clean up qos_option setting
  staging: r8188eu: remove unused bpending array
  staging: r8188eu: remove unused dma_transfer_addr
  staging: r8188eu: bm_pending is not used
  staging: r8188eu: terminate_xmitthread_sema is not used
  staging: r8188eu: tx_retevt semaphore is not used
  staging: r8188eu: remove unnecessary rtw_free_xmitframe call
  staging: r8188eu: phwxmit parameter is unused
  staging: r8188eu: rtw_init_hwxmits is not needed
  staging: r8188eu: we use a constant number of hw_xmit entries

 drivers/staging/r8188eu/core/rtw_cmd.c        |   4 -
 drivers/staging/r8188eu/core/rtw_xmit.c       | 239 ++++++++----------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  27 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  14 +-
 .../staging/r8188eu/include/rtl8188e_spec.h   |  21 --
 .../staging/r8188eu/include/rtl8188e_xmit.h   |   4 +-
 drivers/staging/r8188eu/include/rtw_cmd.h     |   1 -
 drivers/staging/r8188eu/include/rtw_xmit.h    |   9 +-
 8 files changed, 116 insertions(+), 203 deletions(-)

-- 
2.30.2

