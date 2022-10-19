Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189EC6050DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJSTzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJSTzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:55:09 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB99618BE33
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666209298; bh=rWuVo5ArWe0A4Pt0jIryo1pM/iFzQ7NFsBkrARvSvXo=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=gyCgb0pIvTLXHQ871p27n3Vrwl3FHTRJaV5uSbRBwbwV4dSlAk+aE7Y3Jv7dgXt+k
         rIprmUwHY6IJ/K/PZBYxrhJ1xfHTM2T/PoGX8i5GPgqeGJibXiivrGc5JufdsQs1hP
         F3kZnWm4zEzBVObyLYOBvvKki76U12CauNJS3MGk=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Wed, 19 Oct 2022 21:54:58 +0200 (CEST)
X-EA-Auth: AdR9hdmXB7TSkPVfT4xk/8eiuJeuqJrx3mvKeq4HmEc1ZfTC58atNSmqQf8dzzvh7bfNsoL+8Yf7C1zfhKo8638OrGLIKzOt
Date:   Thu, 20 Oct 2022 01:24:53 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: [PATCH v4 1/2] staging: most: dim2: read done_buffers count locally
 from HDM channel
Message-ID: <83fd237d2ac157d234e9c7cce1206904c2d8773d.1666208065.git.drv@mailo.com>
References: <cover.1666208065.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666208065.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dim_get_channel_state only serves to initialize the ready and
done_buffers fields of the structure passed as its second argument. In
service_done_flag, this structure is never used again and the only purpose
of the call is to get the value that is put in the done_buffers field.
But that value is just the done_sw_buffers_number field of the call's
first argument.  So the whole call is useless, and we can just replace it
with an access to this field.

This change implies that the variable st is no longer used, so drop it as
well.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

PLEASE NOTE:
   1. I have only built the module on my machine, but have not tested it.
      I am not sure how to test this change. I am willing to test it with
      appropriate guidance provided I have the necessary hardware.
   2. This was a standalone patch earlier. It is now combined into a patch set
      with another patch for the same driver. Hence I am carry forwarding the
      change log for this patch here:

Changes in v4:
   -- None.

Changes in v3:
   1. The patch log message is further improved. This revised verbiage is as
      thankfully provided by julia.lawall@inria.fr

Changes in v2:
   1. Update patch log message to be more descriptive about the reason for change.
      Feedback provided by julia.lawall@inria.fr


 drivers/staging/most/dim2/dim2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index ab72e11ac5ab..4c1f27898a29 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -259,7 +259,6 @@ static void retrieve_netinfo(struct dim2_hdm *dev, struct mbo *mbo)
 static void service_done_flag(struct dim2_hdm *dev, int ch_idx)
 {
 	struct hdm_channel *hdm_ch = dev->hch + ch_idx;
-	struct dim_ch_state_t st;
 	struct list_head *head;
 	struct mbo *mbo;
 	int done_buffers;
@@ -271,7 +270,7 @@ static void service_done_flag(struct dim2_hdm *dev, int ch_idx)

 	spin_lock_irqsave(&dim_lock, flags);

-	done_buffers = dim_get_channel_state(&hdm_ch->ch, &st)->done_buffers;
+	done_buffers = hdm_ch->ch.done_sw_buffers_number;
 	if (!done_buffers) {
 		spin_unlock_irqrestore(&dim_lock, flags);
 		return;
--
2.30.2



