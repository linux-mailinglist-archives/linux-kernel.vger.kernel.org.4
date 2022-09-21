Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBAA5BFB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiIUJb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiIUJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:31:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612190C41;
        Wed, 21 Sep 2022 02:31:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r23so5346684pgr.6;
        Wed, 21 Sep 2022 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=enYLZNICUKW7Y1hOBxlZadyr2pjN63G4o9wEaQCXqSk=;
        b=ZqYUXAGALiCAH13c/fsSm3N3n2GhmekjKu2+LwcBD5vtjCrC409O05gs9KXoo3WRbw
         GDxIFixwjS2x/XSR9lnt8196b3jC4DzNBqQXIJF6AyvHY6JTkup2BCUcyyu7HLeyDZHm
         VTIxHczUdyVFlrkI3oxIuuWlNsE5doJ/TVGoDTgXBK1NTUaOKEX7gsB9EilFgMooR+PP
         7Q9MHDfVUVYXCROZUn+O2C3/nT0yKOYXpK5hMICk+ydrzxkzgq2ZsT/bZDZtSZLy3ShL
         2sc7XPNutJE4Vex20OCTzxRsYidiI0HXhsIi07D0KU95mzHskmxq7tDdbCtAolU9HJSt
         hd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=enYLZNICUKW7Y1hOBxlZadyr2pjN63G4o9wEaQCXqSk=;
        b=6f/J3+HaquRjSng8CPu7rFLrLPtiRyWktJ6THW/dkDwp1YC6r0KwESFKxQ/JOQLV1e
         enWtREV74fs5k06ohfPhR6Pj79mq1zbI+YrDAEIot3fp22lRZwBJZhcR6d3Vo4iY/sX5
         kHOQH3LyBmdUJrdg6mCBOANy/B+B9GPAo6zLHj/7ALMOcUW+cK0WtDksrbZmhFhZhZbC
         ME91Ta33Xf5lN7sWZLpxnoGuusJisW+kglrBh4f5cahIVJ87oHcnSXLCmDTH35bMfPHg
         rpbsO6FdXginqc41TJeVOLx1PNxv7YDI7pDXIu4pGVoPTL38yO1r7EWe6ap+y8DQ65Bt
         1Veg==
X-Gm-Message-State: ACrzQf1/qCOEFUqda7kVn6SLYidxJwRTUMQMfbX1hvNZhy0EAZJYzvZG
        N2kdDDHPY3Q2QjH110gIUDE=
X-Google-Smtp-Source: AMsMyM66h4wA8Iqa4eEdk6dvfp9wMUONjq/LDxxKJtst/E5y5K4SR0dthydAxlHbnUd7ox6Ui7azEw==
X-Received: by 2002:a63:6384:0:b0:434:a42a:3629 with SMTP id x126-20020a636384000000b00434a42a3629mr23581286pgb.243.1663752714176;
        Wed, 21 Sep 2022 02:31:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902b18100b00176ad86b213sm1459766plr.259.2022.09.21.02.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:31:53 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf buildid-cache: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:31:49 +0000
Message-Id: <20220921093149.230523-1-ye.xingchen@zte.com.cn>
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
 tools/perf/builtin-buildid-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index cd381693658b..0cc4c39558ad 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -36,7 +36,7 @@ static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
 	char root_dir[PATH_MAX];
 	char *p;
 
-	strlcpy(root_dir, proc_dir, sizeof(root_dir));
+	strscpy(root_dir, proc_dir, sizeof(root_dir));
 
 	p = strrchr(root_dir, '/');
 	if (!p)
@@ -104,7 +104,7 @@ static int build_id_cache__kcore_existing(const char *from_dir, char *to_dir,
 			  to_dir, dent->d_name);
 		if (!compare_proc_modules(from, to) &&
 		    same_kallsyms_reloc(from_dir, to_subdir)) {
-			strlcpy(to_dir, to_subdir, to_dir_sz);
+			strscpy(to_dir, to_subdir, to_dir_sz);
 			ret = 0;
 			break;
 		}
@@ -121,7 +121,7 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
 	char from_dir[PATH_MAX], to_dir[PATH_MAX];
 	char *p;
 
-	strlcpy(from_dir, filename, sizeof(from_dir));
+	strscpy(from_dir, filename, sizeof(from_dir));
 
 	p = strrchr(from_dir, '/');
 	if (!p || strcmp(p + 1, "kcore"))
-- 
2.25.1

