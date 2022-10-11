Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB205FBBB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJKUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJKUBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:01:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC63C9AF96
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:01:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u71so6192852pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Clkl7sDDQHghO/ypxBC14MAK6bs8T6Bz2Y1WZWOgF70=;
        b=Kw8L4w5cqV2WKNFJQo0lxvi9sJ0Ov0LxkH3jd+E5PI+N6/35YqCpDSUw88u7kFeZxP
         xMdnVFHEyvaCNwjVh9Wv4RBSkFn+iWZz4cP8y1Wl1iD4SSFeZv6lTlh3A44ptwCT3/qi
         uX44dBPu7krn/7J+Xt0H7EEYiZmlMwliaRcEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Clkl7sDDQHghO/ypxBC14MAK6bs8T6Bz2Y1WZWOgF70=;
        b=r2EqEyY/ecDXXwfXqXXc8sc0EwekHMg9DSBYYM0Dmx3tHUE8rsdY/36/cSNj0fudnj
         8CLJxXJBdPP24S11GqLdMiLv0h+IZQkQFVHR+6s0Pc6/Vgg6p6jyEmKYyJ1hbwuQ04EA
         IzA5vqOcDWPqovMZ5xBO4d53NhhiTv3FdR4RNyM4lTsqEeNeDGB4bAszqojikTHsZf/3
         gX9xKB1OX4wHb728mgokiRbJx22Gh7u1CriC8alHsBQv556mByTpIqQETcN2P596vSWf
         hSpCweZdYCmZAdW3fwMJC5Mv2N0LiZcADShwmt95IG81AkSUyV1brD8U+wHH3x0QOGRd
         4Y4g==
X-Gm-Message-State: ACrzQf0nwVkahEJr0NziJh/VAI2XqbBN5HRZvlUgvdlQbeu5lJ/73PDH
        vgxR8jMeQ1fjygDr0MEDmQxS6Q==
X-Google-Smtp-Source: AMsMyM4PGptQ/w4q+1kMp053Ezi8lqADgxTiHlKNMDrS/ErIrf1RBw0zNMaOS8r+yEqoJjvlCtymMw==
X-Received: by 2002:a62:1a8d:0:b0:544:1309:19f3 with SMTP id a135-20020a621a8d000000b00544130919f3mr27063444pfa.37.1665518478315;
        Tue, 11 Oct 2022 13:01:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b00176b3d7db49sm9137909plg.0.2022.10.11.13.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:01:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] pstore/ram: Set freed addresses to NULL
Date:   Tue, 11 Oct 2022 13:01:11 -0700
Message-Id: <20221011200112.731334-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011200112.731334-1-keescook@chromium.org>
References: <20221011200112.731334-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3305; h=from:subject; bh=GntXT/nvbdx1dBrVA0MLCZlYHgp6NkAOT9li9W5m9BE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjRcuHHZkp4XXEmL/p7hSvwf7bwXmHmVfFKPObqGkd tYzT942JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0XLhwAKCRCJcvTf3G3AJpT8D/ 9GMM6Izv5Sa2SBFTY6sptDGgvibdH7dXmh0r5QTwklo8rwGGkOoarSoIlXQ1rpdx8PZJ/JKCOGeYIs QQtDfPgWa4ZQCiJcpFo0Ty6SUk9jUZ1L0DHicH2EBTbKkkju4KPGytkgOH17KyoHSqYaYkhdRZ7QHK vpKrQcdIZ2OLPwy893b13XSVOqqXfkw2S+DfFGRtwLQVnKesZRjKfHjnL7pMVzsgDTcKW46kd0859e NO4S/2a3ixvtnismX3tVEy394nezRxwL+brVQYSvjjDD6Mby2kyq/fj7BLOr/XB6LVbg/5MTrhYcPf RsISkBZGQYRWo9ECe4MEUze8zO4CgLicVHWZh/hRTT9/ltAmqNHRCZvfLlY+f9hvZoB/s93SN8miWx qoiVhw+iJan/8fPP318+ygy+f38KHNHY7FRp7+OhxXCX3MIRrXw6EE3C4T8Y1Zj+lASWG1hlQPr/uW W6/PjRNQS7aIHkaiccgIx3DP300AyRH7LBWhjo+Ti/b7Wz7Ug/nDHkv3HzdAU66XKg3ChIjd1Wm9CX SgZCWRN4PEl3gLm7NawFQ1mUbrHzLDsqXHK1/O3EFGi9yvVgyk6Ee0njknRv1AztZlf9XBUYbTi2yr 1NXvJ6SySJzAqhQgo59683Ru4xTrdVLE2wymKaKlCOB8bMfg/+SqWnF6Hl+A==
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

For good measure, set all the freed addresses to NULL when managing
przs.

Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c          | 13 ++++++++-----
 fs/pstore/ram_core.c     | 11 +++++++++--
 fs/pstore/ram_internal.h |  2 +-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index f5bf360cf905..5da31565f93a 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -453,25 +453,27 @@ static void ramoops_free_przs(struct ramoops_context *cxt)
 	int i;
 
 	/* Free pmsg PRZ */
-	persistent_ram_free(cxt->mprz);
+	persistent_ram_free(&cxt->mprz);
 
 	/* Free console PRZ */
-	persistent_ram_free(cxt->cprz);
+	persistent_ram_free(&cxt->cprz);
 
 	/* Free dump PRZs */
 	if (cxt->dprzs) {
 		for (i = 0; i < cxt->max_dump_cnt; i++)
-			persistent_ram_free(cxt->dprzs[i]);
+			persistent_ram_free(&cxt->dprzs[i]);
 
 		kfree(cxt->dprzs);
+		cxt->fprzs = NULL;
 		cxt->max_dump_cnt = 0;
 	}
 
 	/* Free ftrace PRZs */
 	if (cxt->fprzs) {
 		for (i = 0; i < cxt->max_ftrace_cnt; i++)
-			persistent_ram_free(cxt->fprzs[i]);
+			persistent_ram_free(&cxt->fprzs[i]);
 		kfree(cxt->fprzs);
+		cxt->fprzs = NULL;
 		cxt->max_ftrace_cnt = 0;
 	}
 }
@@ -555,9 +557,10 @@ static int ramoops_init_przs(const char *name,
 
 			while (i > 0) {
 				i--;
-				persistent_ram_free(prz_ar[i]);
+				persistent_ram_free(&prz_ar[i]);
 			}
 			kfree(prz_ar);
+			prz_ar = NULL;
 			goto fail;
 		}
 		*paddr += zone_sz;
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 9e1047f4316d..97dde525150a 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -544,8 +544,14 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	return 0;
 }
 
-void persistent_ram_free(struct persistent_ram_zone *prz)
+void persistent_ram_free(struct persistent_ram_zone **_prz)
 {
+	struct persistent_ram_zone *prz;
+
+	if (!_prz)
+		return;
+
+	prz = *_prz;
 	if (!prz)
 		return;
 
@@ -569,6 +575,7 @@ void persistent_ram_free(struct persistent_ram_zone *prz)
 	persistent_ram_free_old(prz);
 	kfree(prz->label);
 	kfree(prz);
+	*_prz = NULL;
 }
 
 struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
@@ -605,6 +612,6 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 
 	return prz;
 err:
-	persistent_ram_free(prz);
+	persistent_ram_free(&prz);
 	return ERR_PTR(ret);
 }
diff --git a/fs/pstore/ram_internal.h b/fs/pstore/ram_internal.h
index 440ee7a35e10..5f694698351f 100644
--- a/fs/pstore/ram_internal.h
+++ b/fs/pstore/ram_internal.h
@@ -82,7 +82,7 @@ struct persistent_ram_zone {
 struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 			u32 sig, struct persistent_ram_ecc_info *ecc_info,
 			unsigned int memtype, u32 flags, char *label);
-void persistent_ram_free(struct persistent_ram_zone *prz);
+void persistent_ram_free(struct persistent_ram_zone **_prz);
 void persistent_ram_zap(struct persistent_ram_zone *prz);
 
 int persistent_ram_write(struct persistent_ram_zone *prz, const void *s,
-- 
2.34.1

