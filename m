Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962D861734D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKCATf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 20:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCATd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:19:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA3645C;
        Wed,  2 Nov 2022 17:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72EAFB8257D;
        Thu,  3 Nov 2022 00:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC18C433C1;
        Thu,  3 Nov 2022 00:19:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vh9ZF32y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667434767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mcmok62mxA5yi48HwvEwfpI0V5bJwILrpr/mqSiiPZQ=;
        b=Vh9ZF32yJixV6nU6uXNrd6rjYV/nySWWMzADticRkyBsQ2yV7HgXZ/J+YlWPXXrVBP0qPz
        hOoVeeHZis1/9sfBsuTIZZqto5LH3qzrTL3VN0BWUH14o6UwQLSDvkt/3J6qf1HfkgMBbG
        RuOyzMS+gPPASpjRFqARSxUGdIs7zVo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b57b712f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Nov 2022 00:19:27 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH] staging: media: atomisp: make hive_int8 explictly signed
Date:   Thu,  3 Nov 2022 01:19:14 +0100
Message-Id: <20221103001914.81849-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current definition of hive_int8 is a naked char, without any sign
specifier. This is incorrect on platforms such as arm, where char is
unsigned. Fortunately nothing in the kernel actually uses a hive_int8
type, but in case it gets used later rather than removed, this makes it
explicitly signed.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Greg - if you're going to take this for 6.1, that's fine with me.
Otherwise, if it's for 6.2, I'll take this in my unsigned-char tree to
keep all of these fixups together. -Jason

 drivers/staging/media/atomisp/pci/hive_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_types.h b/drivers/staging/media/atomisp/pci/hive_types.h
index 4b8a679fb672..55d36931f079 100644
--- a/drivers/staging/media/atomisp/pci/hive_types.h
+++ b/drivers/staging/media/atomisp/pci/hive_types.h
@@ -42,7 +42,7 @@ typedef unsigned int hive_bool;
 #define hive_false 0
 #define hive_true  1
 
-typedef char                 hive_int8;
+typedef signed char          hive_int8;
 typedef short                hive_int16;
 typedef int                  hive_int32;
 typedef long long            hive_int64;
-- 
2.38.1

