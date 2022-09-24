Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0419B5E8931
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiIXHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiIXHdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:33:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30090D6937
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:33:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x1so2027715plv.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZMVsUMBAKMeduU+ys2KO9Tzke8RIAJ6IXsSd88ClynM=;
        b=VexB8OMgivKHIQttJFnZ9yevpt5OqU1P2L/CoE5HKTeqDzxuckcZufT68YFWJVSRKa
         mXGwdC6OK15QOHlaUILroAyLFQmLyBMBStlRMtzrny1Wfcf/uV2mh3WfC56QE/z/UtBk
         5+EqsikYVRmR3yylEBySsgNSZsN3+9O84H8sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZMVsUMBAKMeduU+ys2KO9Tzke8RIAJ6IXsSd88ClynM=;
        b=VXhkz3TpN0WGewEbQkk44sVtIXhTbxx50/FbiXYWfLOdesT4D+mESdfMG3I9H1L2iT
         ESs3Tg64NHPQqa8aK/zaFGbXsIveGkz55rM675Zl9/d3ADfB87eSP09hHabw+mAn6hiD
         dr+anomk1Lncb5wMe+9xONTPDswFacea+5IKG1ymZAYf7XwPsCbOA5s//kExOYHt/9tJ
         OPT5aT+QsWvZj8Df6gtOY/AQ6VLHbaHsnxOfZEDmt+jCETZgBksHdRit2cnsI9Gy0ogn
         aF2HsWIVodrHbUeTvJK7LUZc6I7Hp1WZcZ15psf5/L20l2Y9sS7rgEeAKDl6pR6demmS
         2Z+A==
X-Gm-Message-State: ACrzQf02JD1Bz+NWUgJQ9ATuMd/NuY7sqR2BfUuw2d+Zqflo9AFoPE0E
        POYkDxphXCrtgO+9ls4q3prrsQ==
X-Google-Smtp-Source: AMsMyM5dtkPYTYddrXNhG6ecfeRdFrVSWAw3E/y5q/8pGqLf6wSqaBYgu/mZR6ehjD0wqT3DD8x55g==
X-Received: by 2002:a17:902:ec85:b0:178:8a69:45fb with SMTP id x5-20020a170902ec8500b001788a6945fbmr12137091plg.130.1664004799686;
        Sat, 24 Sep 2022 00:33:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t185-20020a6378c2000000b0042c0ffa0e62sm6741145pgc.47.2022.09.24.00.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 00:33:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Kees Cook <keescook@chromium.org>, linux-unionfs@vger.kernel.org,
        syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] ovl: Use "buf" flexible array for memcpy() destination
Date:   Sat, 24 Sep 2022 00:33:15 -0700
Message-Id: <20220924073315.3593031-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518; h=from:subject; bh=6sc208vuicFU4j8f7/nNB0JUDwsqAqSCJXpZ1EpVcfA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjLrK73g/2u1z6Qo/0wbshT3zKYTCL0tirpBYjt0di TZlH9uSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYy6yuwAKCRCJcvTf3G3AJjWoD/ 9cpL/UxMQ3K7MgktDwxw4j1kV05thlGrqOrVhAt3OpsYa4oIe0WXK1G+UjF6BYlIkcWC8XynTIwBjj ZfmM/rQ3h4J1cjkWuGJUgHlAPvzsREZd0F/dAjYaF7O/lG65jMrVgOc/rkR5akfVjANgXZAPwkkSw5 K8PC11mmJkqIgOEwubt6fnJkBWKqjEDxgiswF75F9Xeg/XGe9S5AzAez4e2BRqpcSwtVHhztqeoktZ XX+N/47aHo9p/uuxcfFf4N1J2silCBgaVSJmjHywm6N/h5ZiK3Is9f0VfY4U7LZNZaUCE62GnjK4bD yrlOGc1XE6SRejHHIgAM4ev2GyokGwZJVMiff66WMomyzCTMRANXsePRNj+VLfqE8F/oczbKg/hGVw F134cU4/d/mb98CfKaCyddD82KWqUc0d9kIuyPGmOb0tDFsiYVYY2GXKiXqSD/f5Z2P9dTA5Nrn3eU w3O8OxgddbTmXgCwpXAaDRaykKAcl3PiQrK4lbZA2chRSVt0AtSda8nRJR+1mKlWVHHA/wPG70rFKc JqDG8MqGe2IWwMHASp4z+i8HNoQH2vjYROqq2+4cf7ILKRc0rTKxCVv3QK+cXKOlJbtlpSldo/zrxO bRWMT8NZKyDKUiwq1lOF6TLAoUa6wuszJLocHzK0lJKfGzdlies8D8TUjG+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "buf" flexible array needs to be the memcpy() destination to avoid
false positive run-time warning from the recent FORTIFY_SOURCE
hardening:

  memcpy: detected field-spanning write (size 93) of single field "&fh->fb" at fs/overlayfs/export.c:799 (size 21)

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org
Reported-by: syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/000000000000763a6c05e95a5985@google.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/overlayfs/export.c    | 2 +-
 fs/overlayfs/overlayfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index e065a5b9a442..ac9c3ad04016 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -796,7 +796,7 @@ static struct ovl_fh *ovl_fid_to_fh(struct fid *fid, int buflen, int fh_type)
 		return ERR_PTR(-ENOMEM);
 
 	/* Copy unaligned inner fh into aligned buffer */
-	memcpy(&fh->fb, fid, buflen - OVL_FH_WIRE_OFFSET);
+	memcpy(fh->buf, fid, buflen - OVL_FH_WIRE_OFFSET);
 	return fh;
 }
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87759165d32b..a0e450313ea4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -108,7 +108,7 @@ struct ovl_fh {
 	u8 padding[3];	/* make sure fb.fid is 32bit aligned */
 	union {
 		struct ovl_fb fb;
-		u8 buf[0];
+		DECLARE_FLEX_ARRAY(u8, buf);
 	};
 } __packed;
 
-- 
2.34.1

