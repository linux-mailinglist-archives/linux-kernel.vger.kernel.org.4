Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DEB5E7E23
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIWPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiIWPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:20:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442AFE6A00;
        Fri, 23 Sep 2022 08:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED4B8B838C3;
        Fri, 23 Sep 2022 15:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B72C43142;
        Fri, 23 Sep 2022 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663946426;
        bh=zo7rFZiPS4WyTBZk4VHnI8cDdMwygNZyE43ol0e2o2A=;
        h=From:To:Cc:Subject:Date:From;
        b=h5A9XThDA/5s0nOAX9forsdLayrzgXUza7l79K6258CeVyLTGUt6X96ZBEPlttNp5
         ElY629wCutz4/DSMBngmRLN37ymIDXCrKV/Z2J6jov2aGTDZS4bkyZbVrUsPgnnbig
         yqDUPOVPVI82nAtprBZMueiVWOHOBWkCOsQi3r/9/PBuhqMgwsKjbhOa0KFz5Ia5ga
         FesASNFIjqev89LM8TbV6f0uz9NdHPJ6XfW7MlY5FZbM7WXYQZK/8HegplFfsL3tOO
         9djqqHdCD9lVmJpKW6oZAbuByK69CJ3xUbSxMjXmvykRA9FiAOhnIFGmLKDGuYyXRw
         uNUmczkVos0qg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Subject: [PATCH -next] thermal/intel/int340x: Initialized ret in error path in int340x_thermal_zone_add()
Date:   Fri, 23 Sep 2022 08:20:09 -0700
Message-Id: <20220923152009.1721739-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
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

  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:222:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
          if (!int34x_thermal_zone->ops)
              ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:279:17: note: uninitialized use occurs here
          return ERR_PTR(ret);
                        ^~~
  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:222:2: note: remove the 'if' if its condition is always false
          if (!int34x_thermal_zone->ops)
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c:211:9: note: initialize the variable 'ret' to silence this warning
          int ret;
                ^
                  = 0
  1 error generated.

If kmemdup() fails, -ENOMEM should be returned.

Fixes: f6f6f9a01374 ("thermal/intel/int340x: Replace parameter to simplify")
Link: https://github.com/ClangBuiltLinux/linux/issues/1717
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reported-by: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index ea05be8c2834..228f44260b27 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -219,8 +219,10 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 
 	int34x_thermal_zone->ops = kmemdup(&int340x_thermal_zone_ops,
 					   sizeof(int340x_thermal_zone_ops), GFP_KERNEL);
-	if (!int34x_thermal_zone->ops)
+	if (!int34x_thermal_zone->ops) {
+		ret = -ENOMEM;
 		goto err_ops_alloc;
+	}
 
 	if (get_temp)
 		int34x_thermal_zone->ops->get_temp = get_temp;

base-commit: 2b109cffe6836f0bb464639cdcc59fc537e3ba41
-- 
2.37.3

