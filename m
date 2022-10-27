Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E061064D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiJ0XSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJ0XSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:18:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E5A0263;
        Thu, 27 Oct 2022 16:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89186B8283C;
        Thu, 27 Oct 2022 23:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9348BC433B5;
        Thu, 27 Oct 2022 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666912717;
        bh=PsF6KK3oiuiEmQj53gDFosnftgvkXoJMatC2imaZDfI=;
        h=From:To:Cc:Subject:Date:From;
        b=rwiu193D5bUhlJHvioCfiHfdV+sfIX6pOWww2EimCM8HhSdx2EZhbeMi4eHuR6aO+
         pTsIqcKJv7W5LCTGk1n5HS1GQAUZDA+zurf620nxiBYG1mPtQwyEQnFjyzl730Juqi
         wxQv4HbWzEDSYDr79dBLgNruwCaL1OG/G96iGQeb5tK3Gd9Njj6JNhZWT+6fr9YoMr
         DRMZlab8tKxWy8CqICHzqj+iyDK86xYInfS+h9LiQNklfPloEmV9/m02SVGhsrDTQv
         l0UYpN6xbbTqfSjrxeHanJ0Eb+V+fec05yXh0i5vacEOOj69S8XGX8QscIIlNWv/NE
         uMyCBpXVhaLPg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next v2] hwmon: (smpro-hwmon) Improve switch statments in smpro_is_visible()
Date:   Thu, 27 Oct 2022 16:16:12 -0700
Message-Id: <20221027231611.3824800-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/hwmon/smpro-hwmon.c:378:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
          default:
          ^
  drivers/hwmon/smpro-hwmon.c:378:2: note: insert 'break;' to avoid fall-through
          default:
          ^
          break;
  1 error generated.

Clang is a little more pedantic than GCC, which does not warn when
falling through to a case that is just break or return. Clang's version
is more in line with the kernel's own stance in deprecated.rst, which
states that all switch/case blocks must end in either break,
fallthrough, continue, goto, or return.

Add the missing break to silence the warning. Additionally, adjust the
indentation of a break and add a default case to the inner switch
statement.

Fixes: a87456864cbb ("hwmon: Add Ampere's Altra smpro-hwmon driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1751
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v2:

    * Add missing default case to inner switch statement (Guenter)
    * Fix indentation of break in inner switch statement (Guenter)
    * Reword commit message to include these changes

v1: https://lore.kernel.org/20221027195238.1789586-1-nathan@kernel.org/

 drivers/hwmon/smpro-hwmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/smpro-hwmon.c b/drivers/hwmon/smpro-hwmon.c
index ee54e21c2c12..a76c49dd8438 100644
--- a/drivers/hwmon/smpro-hwmon.c
+++ b/drivers/hwmon/smpro-hwmon.c
@@ -373,8 +373,11 @@ static umode_t smpro_is_visible(const void *data, enum hwmon_sensor_types type,
 			ret = regmap_read(hwmon->regmap, temperature[channel].reg, &value);
 			if (ret || value == 0xFFFF)
 				return 0;
-		break;
+			break;
+		default:
+			break;
 		}
+		break;
 	default:
 		break;
 	}

base-commit: 0ffb687b6508c36a17b99bdaf014b38532404182
-- 
2.38.1

