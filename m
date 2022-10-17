Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA86960116E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiJQOqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJQOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:46:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9946967148;
        Mon, 17 Oct 2022 07:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DE5BB818F3;
        Mon, 17 Oct 2022 14:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF8DC433C1;
        Mon, 17 Oct 2022 14:46:30 +0000 (UTC)
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH for 6.1 0/4] vivid crash fixes
Date:   Mon, 17 Oct 2022 16:46:24 +0200
Message-Id: <20221017144628.489271-1-hverkuil-cisco@xs4all.nl>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a number of vivid crashes, usually due to insufficient
checking of userspace values. 

While the v4l2-dv-timings.c patch is not vivid specific, it is only
vivid that can crash if bad values are passed. For actual hardware
drivers bad values will just mean that the receiver is not able to
lock to the video signal.

The videodev2.h patch is there to avoid using interlaced blanking
values if the 'interlaced' flag isn't set, it's mostly for userspace
to avoid applications that use this define to return wrong values.

Regards,

        Hans

Hans Verkuil (4):
  vivid: s_fbuf: add more sanity checks
  vivid: dev->bitmap_cap wasn't freed in all cases
  v4l2-dv-timings: add sanity checks for blanking values
  videodev2.h: V4L2_DV_BT_BLANKING_HEIGHT should check 'interlaced'

 drivers/media/test-drivers/vivid/vivid-core.c | 22 +++++++++++++++
 drivers/media/test-drivers/vivid/vivid-core.h |  2 ++
 .../media/test-drivers/vivid/vivid-vid-cap.c  | 27 ++++++++++++++-----
 drivers/media/v4l2-core/v4l2-dv-timings.c     | 14 ++++++++++
 include/uapi/linux/videodev2.h                |  3 ++-
 5 files changed, 61 insertions(+), 7 deletions(-)

-- 
2.35.1

