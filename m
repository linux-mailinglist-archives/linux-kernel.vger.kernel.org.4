Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B363A119
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiK1GQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiK1GQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:16:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B2A11174;
        Sun, 27 Nov 2022 22:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B33F60FB0;
        Mon, 28 Nov 2022 06:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6428FC433D7;
        Mon, 28 Nov 2022 06:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669616199;
        bh=ypKwixzldPb7kQWuOxo+5LWR+IrDt1cLNbjX20e7Zeg=;
        h=From:To:Cc:Subject:Date:From;
        b=EdX6WAuLVe+R0n4yj7msuQgS3CTsToakfIhaZE0DkQqcxaDZunj9Y1UMhywWEDQmr
         fcMsF1PO0y5nkdbTGi3HXxvE+nkDwWNCaZto8bnVkqRZ2G10lEdmbsP2otwhvX4Neo
         TCfLlJxQfsnVqYDCWtoLCeQ1ljU09NnqZkbHWnf3lZBfA2gtUCaS4f5RZ4do0s5zSF
         D+11y7EDCeGmeY85WX9D0xA69Tj0YwYr8WV/bb9OBSd+nw6OHzoQnwYOWjAikfTN3T
         DkPqtWqB4Lw/64iBIvXT6l4UsAY/hnIVIzMyl+l2sBrLxjGXJR8VKW5YBiQGXZsxmQ
         S/exotE8Yv7uA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] media: rzg2l-cru: Remove unnecessary shadowing of ret in rzg2l_csi2_s_stream()
Date:   Sun, 27 Nov 2022 23:16:22 -0700
Message-Id: <20221128061622.1470489-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:445:7: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                  if (ret)
                      ^~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:475:9: note: uninitialized use occurs here
          return ret;
                ^~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:445:3: note: remove the 'if' if its condition is always false
                  if (ret)
                  ^~~~~~~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:441:7: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                  if (ret)
                      ^~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:475:9: note: uninitialized use occurs here
          return ret;
                ^~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:441:3: note: remove the 'if' if its condition is always false
                  if (ret)
                  ^~~~~~~~
  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:431:9: note: initialize the variable 'ret' to silence this warning
          int ret;
                ^
                  = 0
  2 errors generated.

ret is unnecessarily shadowed, meaning the assignments to ret within the
first 'if (enable)' block are only applied to the inner scope, not the
outer one as intended. Remove the shadowing to fix the warnings and make
everything work correctly.

Fixes: 51e8415e39a9 ("media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1764
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index aa752b80574c..3deb09be6400 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -431,8 +431,6 @@ static int rzg2l_csi2_s_stream(struct v4l2_subdev *sd, int enable)
 	int ret;
 
 	if (enable) {
-		int ret;
-
 		ret = pm_runtime_resume_and_get(csi2->dev);
 		if (ret)
 			return ret;

base-commit: 6a5a4514854a637d01c50f5ea17b28f78b31ddb8
-- 
2.38.1

