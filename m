Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914F35BFB06
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIUJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiIUJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:30:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454390C43;
        Wed, 21 Sep 2022 02:30:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id jm5so4067153plb.13;
        Wed, 21 Sep 2022 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kgfZA96d0PwscAXe2/1ba6uFwFqh9GxR0E2lMqdA+hs=;
        b=ZmLGfW5iGxdi5f6zDz48UPLyANPZyhi5zqo0Ajda8u2zHRJRWdu0AbaLvinw5AHr84
         a9sSRaf4SeUx58NcVUjL4h/XwLt+TZalm5env/82KEhEovn4jH1XONssw9WqiwRox+Aw
         TB+UYj3KkSPiLljzC6CbCJqIVeNrgeM1nTGOygO9LvfxsuNeHyQ3QH6suruIePBeOJF0
         CAbHmriVEYGJqiXvw5D34eM4K4EPOr9qudnk/YBBmEGrcorDfGxTQv7NUIfTVV5Edapz
         y4OlJ61DjYNykSr47ID6UlTWQR2uZQZeQGFO8Tusa29h1FC2M/mZYIMB2CWWygzIajxd
         m8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kgfZA96d0PwscAXe2/1ba6uFwFqh9GxR0E2lMqdA+hs=;
        b=JUbblLEZffPSRi9Gn6WpoghiXJiSZBcHC5qdBCDs+CvtnBO25OAgZcdjdvZiJZ3xVh
         7zY108ey7QIcydlsQ2ycNVSrNuAkFo1UOB09Jp2P9HSYUniPDONg4hbvqsbFTdJcKBF8
         0z5oNEGTtcuGhz2tw0MhPFSmRbclekbj2ynJMNt6Afs1wtxjd0zI9ftqu9ISZXtnak0z
         a9DXJkPc0PEYXC4zoS24QoeoyuCTiPiTD8AV91hJUAbAK369MSDHH1Esr7k6H8cdZPRe
         Cw+SJ/JzFV+fPOnVx4szH82fb81PHsNdsrWLVpcEz6nocZFju8Y3xJObNbiAVfQwt1MP
         19aA==
X-Gm-Message-State: ACrzQf3Es2Sq+AvSAYilTYhwyuQvDGiDdWsArR7zE5YQaCxpi/QWJeKf
        2JF4ceeWXSQigeyW2NsSz9c=
X-Google-Smtp-Source: AMsMyM7uD1SUb9QLAu8VTbRYkgWpFwiFnjve+4NHST/sOmX7eM2m7L70Bc3I11ii3AaDXEJSS8Izvw==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id z2-20020a170902ccc200b0017829f95c5emr3658773ple.21.1663752650254;
        Wed, 21 Sep 2022 02:30:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c196-20020a621ccd000000b00537b8deef41sm1615141pfc.136.2022.09.21.02.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:30:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf svghelper: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:30:45 +0000
Message-Id: <20220921093045.230468-1-ye.xingchen@zte.com.cn>
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
 tools/perf/util/svghelper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 1e0c731fc539..1e40bcb479c2 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -332,7 +332,7 @@ static char *cpu_model(void)
 	if (file) {
 		while (fgets(buf, 255, file)) {
 			if (strstr(buf, "model name")) {
-				strlcpy(cpu_m, &buf[13], 255);
+				strscpy(cpu_m, &buf[13], 255);
 				break;
 			}
 		}
-- 
2.25.1
