Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22158602560
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJRHSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:18:27 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C32DFD4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666077497; bh=JY+F/SHTji7yOJKf7kIwhuyuxqxS/UIyEF/eUKTINHY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=DBnQxKQIF3BAtTgwgrxXyyez6l9qB4wCoX4YFetoL+wgJLJP6Hu4ZH8d8HCmIPqQJ
         sJf048JxLgUr78H6dbFjTmJkCEDRxsymNaxvYEP+sAukWZj9Nv9EJNrzARTM8bZTuF
         lGR1EcyoVbgKkogRl7MFcPJdUoaNpwQxJqxfBH04=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Tue, 18 Oct 2022 09:18:17 +0200 (CEST)
X-EA-Auth: 6rT+wPigKGh1Mdrwk3Lv2jTuS8zK1Zg7IHlGJdXHmCgmvhAy30enuoasUdm5RTgSwa8XSukxbrGq2Pq7eDT29cTRTzcK23u0
Date:   Tue, 18 Oct 2022 12:48:13 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: [PATCH v2] staging: most: dim2: read done_buffers count locally from
 HDM channel
Message-ID: <Y05TNQBXLMJMgQ2r@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The done_buffer count is already available in the hdm_channel struct.
Calling dim_get_channel_state function to source this value out of
the same structure is unnecessary.
Further, the second parameter struct dim_ch_state_t to this function
is filled by using the hdm_channel inside the function. This filled in
variable is never used in the caller and can be altogether removed.
So, a call to dim_get_channel_state function in this context also
deems expensive.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v2:
   1. Update patch log message to be more descriptive about the reason for change.
      Feedback provided by julia.lawall@inria.fr

PLEASE NOTE: I have only built the module on my machine, but have not tested it.
I am not sure how to test this change. I am willing to test it with appropriate
guidance provided I have the necessary hardware.


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



