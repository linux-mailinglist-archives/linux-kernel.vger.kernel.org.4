Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF57747A5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjGDX1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGDX1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:27:08 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 16:27:07 PDT
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA010E0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 16:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688513227; x=1720049227;
  h=mime-version:from:date:message-id:subject:to;
  bh=IIcGzf0mh9g73nBCtmMFvgNM+Eq+aaBo6WfZ0QBu17E=;
  b=EWxCfJfavl25s6vfPVSpb+ux+tgcO6Nad71YGb4vIoNodDk+CvgCYPk1
   6iuAB3gND6n4E8HgzMAEJaSq6ubCZxVs2wVEKM1OMirqW6nibh7Bh0M6Z
   qBC+nEhWFPVAZm1e/q1sLUtfSQhGR6LigOBgjBDLPBkvHHMcZ9nhJ+IY7
   J/a1wBrwFrhRgjhKzHtZJ+wlivHBAkGaG8y7J1HKaynyZOfqwV2LZVzWQ
   ONd9+tDhc7zZo/ke3fcPY7j16u2VCMIUZIm6myhjmTyJOfCKoG/AMOvIa
   di3OXiIMBVxIwZDZH7mI3aMf39F6wTUsmoQJFSAKN4AcyptrxCHoxTx6j
   w==;
Received: from mail-wr1-f71.google.com ([209.85.221.71])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2023 16:26:05 -0700
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3141c6f4173so2935858f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688513163; x=1691105163;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kX4KQkS9n4VAC2qSIaAGCx3GNGd1xoIMp65oHXNSsCU=;
        b=Wna9BBKFzEMaCEtvGZB+yT8Jt70cwhNa/5N4yycxRMDqD2SVM3Ig7/UpjLd/B6MuMK
         4tT2DCl14duFCEFfZTC5jKSccqa+xR/c+J1TVxRp5jUH5pPz/01KynduoYnUeD//LQNt
         iyiwyAXPs8bgYMETS85D9W6KeU3LoonWikSlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688513163; x=1691105163;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kX4KQkS9n4VAC2qSIaAGCx3GNGd1xoIMp65oHXNSsCU=;
        b=CR0rGbaZIO373VBRJQsghQn0WPoOA3DxTIqOdENoEYjgTxGN8dPFaqjQItCJGxwFCS
         hV/HRtM3n47PHXSWdBt5CRaHHGva9zlOwM2+nE4RNLcPLU47wI8lUfKfd8BKEHMueIJX
         VVexkuKmMijqFGpHFJKrJ8m/U9Mi6599ZsGUb6iyVhluZ8uBkEIz5cu8VEGd1SAokmhN
         YGnJZufE+wpHUxJ2UZYtaPSMYQZ67YWY+SgTNIVwZfHnYI7XjgmK4vqeRBW5HJs8iyfC
         EhykO5CWsSNIRvBbUbU7nFD46C/0UV2TORKrMK4S6q+ww5dVr/CzQ6gSnltxvo21/w+W
         3fKQ==
X-Gm-Message-State: ABy/qLY5I9bz07EzqMeJKXD7ze6MrR/ayL/qKYVw8wOHyI+lBfMH5gjj
        Z1YecXHetY4O60Z5xcGjwYZiMXQ8U3H1FZAngqX9PzzuJtRQr9A5956wh/rxm9LMkBh8iMpM2Jv
        QASTyyLG1U71HygSfdSbiKufrq2GkyQrHRPQcjGTRBg==
X-Received: by 2002:adf:f6d1:0:b0:313:f7a1:3d92 with SMTP id y17-20020adff6d1000000b00313f7a13d92mr11357203wrp.66.1688513163267;
        Tue, 04 Jul 2023 16:26:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPHNfkxxQrUTgpCNAWDSLPEBOshdPoSSdm8s4Xq/52TYuqpLWxYADoNTOT/rraoqVUff/OQdjCnMkVyzUAnlI=
X-Received: by 2002:adf:f6d1:0:b0:313:f7a1:3d92 with SMTP id
 y17-20020adff6d1000000b00313f7a13d92mr11357195wrp.66.1688513162932; Tue, 04
 Jul 2023 16:26:02 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Tue, 4 Jul 2023 16:25:50 -0700
Message-ID: <CA+UBctDxfb6+70+hzuXJ-gwb65E0uoNzXYEhpJT92sXr2CE7OA@mail.gmail.com>
Subject: [PATCH] usb: mtu3: Fix possible use-before-initialization bug
To:     chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct usb_ctrlrequest setup should be initialized in the function
ep0_read_setup(mtu, &setup). However, inside that function,
the variable count could be 0 and the struct usb_ctrlrequest setup
is not initialized. But there is a read for setup.bRequestType.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c
b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index e4fd1bb14a55..67034fa515d0 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -638,7 +638,7 @@ static int ep0_handle_setup(struct mtu3 *mtu)
 __releases(mtu->lock)
 __acquires(mtu->lock)
 {
-   struct usb_ctrlrequest setup;
+   struct usb_ctrlrequest setup = {};
    struct mtu3_request *mreq;
    int handled = 0;

-- 
2.34.1
