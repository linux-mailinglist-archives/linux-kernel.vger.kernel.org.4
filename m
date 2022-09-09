Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8695B3067
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiIIHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiIIHgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EECFD5703
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AEE161EE5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5E2C4315A;
        Fri,  9 Sep 2022 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662708894;
        bh=TwanRK/R0DaOUl8s+MGdP5tuX2z+kZ/zhcAXRv1Dj9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpFhFI/0WDt4zOtGrQvIQ/qGgJF3aDOQ3GQDq9QEzvRnZ3f18UNZTlOlnnSkQFox9
         m9bjjDrfEm/oiOfWnOvUPca8WQQWIb31KV11PGpCbkUdavhbF9+mqqiLoQFo5gTQz+
         Su1YQaphf05icyQ9sBQRAATWA5+tHbFy40DvqEuiUgPOwctiLMGo8lCAD5F8NYBZKX
         KeIPH3vLyC44Qx/v91aypyr58R8v8eWEGcNtEWwAjti5K2jdWqCh4KL0STZ8l9VgQW
         5Y6U2qZPkdjEQgH/wV5lxS3f/fc20/ctVKrQpfjmhSqaAAOb+Do0aWXYpXVq49+wLb
         0KmN9N0zKETuw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oWYXG-007FGZ-CP;
        Fri, 09 Sep 2022 09:34:46 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/37] drm/i915: intel_pm.c: fix some ascii artwork at kernel-doc
Date:   Fri,  9 Sep 2022 09:34:22 +0200
Message-Id: <0c993e585f1fbc26cdd86c1325fdfd7f7c969f10.1662708705.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662708705.git.mchehab@kernel.org>
References: <cover.1662708705.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preserving ascii artwork on kernel-docs is tricky, as it needs
to respect both the Sphinx rules and be properly parsed by
kernel-doc script.

The Sphinx syntax require code-blocks, which is:

	::

followed by a blank line and indented lines.

But kernel-doc only works fine if the first and the last line
are indented with the same amount of spaces.

Also, a "\" at the end means that the next line should be merged
with the first one.

Change the ascii artwork to be on code-blocks, starting all
lines at the same characters and not ending with a backslash.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/37] at: https://lore.kernel.org/all/cover.1662708705.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/intel_pm.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index eb9c54bbf51f..1f5e520a6728 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -683,18 +683,20 @@ static const struct intel_watermark_params i845_wm_info = {
  * FIFO is relatively small compared to the amount of data
  * fetched.
  *
- * The FIFO level vs. time graph might look something like:
+ * The FIFO level vs. time graph might look something like::
  *
- *   |\   |\
- *   | \  | \
- * __---__---__ (- plane active, _ blanking)
- * -> time
+ *   ^
+ *   |   |\   |\      (                          )
+ *   |   | \  | \     (                          )
+ *   |   __---__---__ (- plane active, _ blanking)
+ *   +-------------------> time
  *
- * or perhaps like this:
+ * or perhaps like this::
  *
- *   |\|\  |\|\
- * __----__----__ (- plane active, _ blanking)
- * -> time
+ *   ^
+ *   |     |\|\  |\|\   (                          )
+ *   |   __----__----__ (- plane active, _ blanking)
+ *   +-------------------> time
  *
  * Returns:
  * The watermark in bytes
@@ -730,13 +732,14 @@ static unsigned int intel_wm_method1(unsigned int pixel_rate,
  * FIFO is relatively large compared to the amount of data
  * fetched.
  *
- * The FIFO level vs. time graph might look something like:
+ * The FIFO level vs. time graph might look something like::
  *
- *    |\___       |\___
- *    |    \___   |    \___
- *    |        \  |        \
- * __ --__--__--__--__--__--__ (- plane active, _ blanking)
- * -> time
+ *   ^
+ *   |     |\___       |\___        (                          )
+ *   |     |    \___   |    \___    (                          )
+ *   |     |        \  |        \   (                          )
+ *   |  __ --__--__--__--__--__--__ (- plane active, _ blanking)
+ *   +---------------------------------> time
  *
  * Returns:
  * The watermark in bytes
-- 
2.37.3

