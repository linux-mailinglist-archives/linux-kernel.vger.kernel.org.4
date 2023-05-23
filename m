Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F8570DD44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjEWNMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjEWNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:12:26 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6A118
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684847545;
  x=1716383545;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Oi147oEa3nhPtkW+NY7SaOGr0dK4fTZurgjJRfIU1zs=;
  b=j0bGHBndqZEiReTf85k3nhV49GTbOI1d2TFueZoNlk0B92dkTBeeKEjM
   jjrjiWHipcxLfZvirQwa5HKRfFTl8b1WeDl4axaGY8H83rc4e/T8gzeS6
   W+CO1+pJWArMreGPHGMSaqPu2oOn3+5MhW7Qkd3px+nZ+nwEVytarTSSs
   hmIS00ZsQbEyLf+/Aor70nPS019AdUwRQTpeuTVaE4j/R3QimDZ2HK1k4
   jJhYFUxAOSUUJo8VNkRw5j1o5/vpad3Lpwxxjkz7bokVDXebQ5p/jAFH8
   l5xuQLlRos/wG9UOyPkpvjw/YRXDYUdt9IW0jP6eE5X5kkZ5lNlo8iVGx
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 0/2] ubi: block: fix use-after-free and deadlock
Date:   Tue, 23 May 2023 15:12:15 +0200
Message-ID: <20230523-ubiblock-remove-v1-0-240bed75849b@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+7bGQC/x2N0QrCMAwAf2Xk2UDX4hB/RXxIauqC2kiKQxj7d
 zsfj+O4FZq4SoPzsILLok2tdhgPA+SZ6l1Qb50hhpjCMSb8sPLT8gNdXrYICvE05jKdUgnQK6Y
 myE41z3tXzJg87ubtUvT7f12u2/YDeDoMensAAAA=
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a use-after-free and a deadlock in ubiblock's removal
handling.

---
Vincent Whitchurch (2):
      ubi: block: Fix use-after-free of gendisk
      ubi: block: Fix deadlock on remove

 drivers/mtd/ubi/block.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230523-ubiblock-remove-eab61cf683f0

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

