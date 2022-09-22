Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE35E581E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiIVBgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiIVBgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:36:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F47BA6C03;
        Wed, 21 Sep 2022 18:36:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so608568pjk.2;
        Wed, 21 Sep 2022 18:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gd7+oFbG1hjjN2fqNYIyGBt9LR/XWM2Ka+1nuBL/Nk4=;
        b=LgVOdzlIDAXYYOMw04465vFeS2qL45I7SM0i+AL0koKS4e4Snb1+uJUEfEK3jTbWZy
         pzNJiYyJfU0zVeP9z0F7ksMSIQy0/5HodRMW0yb9/N909vhspWvT3rHWuymm6b3pi0VG
         PIfJy0WguHX6qN2x8LiK2GT2P8pZSHSohGz6uOEgmrHRfuKZcUQ1rt6GFHgvWPe0UTKu
         l1zBp1/pJr86nI/XeYFAjIortPqeWa/3lAPR5vnvWRvlhmBfMxQH3mIxSrvmJwhGDMS7
         qpkb/zd1dGbEJ2u2CIYIBxGQ9Aihr6hP29iHU6QPwihGCjngLUhAesAHsZcTBnJeVCah
         3zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gd7+oFbG1hjjN2fqNYIyGBt9LR/XWM2Ka+1nuBL/Nk4=;
        b=XFpCcu9U0vzXD5xB8G4wzzBYzm3kRaAhhrup9sjYNjZFl44juzEDeYOL96IoDiXG+v
         IFZuiiro0VoUMuyEDGOWMclijsy4dIbc2LCY/5gDuaK5egveiwAYDbIoiHwx7NMii2nJ
         oqzdQd6DWwlpXX+ozrphPQLGLvK00CLJoYbrD7mIxdcni8FHF1MOBxhlQryzetY/sG+4
         kPXs9ZlSWaizjwmHQ+nLC2E1Ob++20rWuDaAOXDYZw3AS23VaCT7MG7Oj2Lh1itBPXOw
         KJoq5vGSlKmlo5eCTYHkcABtHJXpxpTpcdwmKGeoeBWo7Fwy9GfsOpMDlHIOV9NXGL36
         KKgQ==
X-Gm-Message-State: ACrzQf2U60lUCy4o2oq3LAiHJazavyU79SnVWX0xP4esHi0YGWN+Or/a
        sM2ye8q6cdqwqiodfAeUqm4=
X-Google-Smtp-Source: AMsMyM7opy4wePWCsKX86akGj5Lt8CFfnwCBdbmt1ATfW3Zf6FdYmaHMYkhPRZdUqIt5oz4QiD4P4g==
X-Received: by 2002:a17:902:f684:b0:178:84d:ddc5 with SMTP id l4-20020a170902f68400b00178084dddc5mr928206plg.62.1663810610304;
        Wed, 21 Sep 2022 18:36:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id oj5-20020a17090b4d8500b002005f5ab6a8sm2465116pjb.29.2022.09.21.18.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:36:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf intel-pt: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:36:44 +0000
Message-Id: <20220922013644.233230-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 0ac860c8dd2b..0194e2003ba7 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -507,7 +507,7 @@ int intel_pt__strerror(int code, char *buf, size_t buflen)
 {
 	if (code < 1 || code >= INTEL_PT_ERR_MAX)
 		code = INTEL_PT_ERR_UNK;
-	strlcpy(buf, intel_pt_err_msgs[code], buflen);
+	strscpy(buf, intel_pt_err_msgs[code], buflen);
 	return 0;
 }
 
-- 
2.25.1
