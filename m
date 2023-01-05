Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75A165F467
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjAET0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbjAETZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:25:52 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D13A46C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:21:37 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g20so17828179pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 11:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=97sxfhjaB8PxBR7URrYCExoGnpeZKnrOyMFs+deDqoA=;
        b=IFFFns4mTLHYiYPOdpH3k/Z6BfSYt1T8o7KcJMEOb7uldcq+iWk0U8tofOlIyAkpKx
         Zm2YjpnCHTIqDwutAyZ/t+YGUhFLuddGsBcIAIPJyosjV4qRzQJLBfboku0pRLxE3rwg
         E92VlWkAp8E1qj7r+WM0hJV4a+/SrUMEFxVSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97sxfhjaB8PxBR7URrYCExoGnpeZKnrOyMFs+deDqoA=;
        b=fzUlwyoKWrqnrAP/+8kC/yt2Gui5KMwawumxGAgayWp1I9MCOhXYMp0MPZBNEbRa4i
         +S1dgZz6B2a7eKXS0lunv2z/oyrnpUdFK36Pm1jfu7FQxfeup+142fcL0sy9pvg4S+Pr
         9IcwLXVX1jKqG2f5oWdT+138ag+4aeREDIG74zf23kwghuMyex5l8wO4OQXuV5fOdEt+
         4FjVjePX7xugR133EHCC0xJLhUKgnpE8C+Fw8WnW+wfzGEDgbJ7pZKiy+AF6mzaxWZxv
         5K04bAOcUjBdc0XLIi6gv+Jm6vDlQBl5HlVIhZNwEGsJRsNysOoE+0G+Wxa3dc2MekwF
         jwRg==
X-Gm-Message-State: AFqh2kpZdne+2lYoOuTM4QmUwp82lENYcNsLP7U8Wh1mIfPgkIM22aCR
        A3qizi+ATPnByd0r9Pz36pjFhw==
X-Google-Smtp-Source: AMrXdXtusMz0bppoL5uIlyajN4gT+TrhL1MIdwcwHem6NamVhADBBImbslU9eAUU89LaXsDyEkiXYA==
X-Received: by 2002:a62:4e8e:0:b0:583:3d70:3661 with SMTP id c136-20020a624e8e000000b005833d703661mr473651pfb.9.1672946440663;
        Thu, 05 Jan 2023 11:20:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h11-20020aa79f4b000000b00582bdaab584sm5868470pfr.81.2023.01.05.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 11:20:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] fbdev: Replace 0-length array with flexible array
Date:   Thu,  5 Jan 2023 11:20:38 -0800
Message-Id: <20230105192034.never.249-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; h=from:subject:message-id; bh=eBudshCogBtu2xin7cq/2EcDLuR1Ha1dnf+jDA9WM7A=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjtyMFUMFrIl5nzBw/rrohurWWx677rm+9jnFO2OEH EHsCmCCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7cjBQAKCRCJcvTf3G3AJh39D/ 9JXSePQkOSG9y/c/7C77a7sNLOH6tRaBYFyxy0DqaiEqTL/wMEaWTJIe/TCr3eh5BcFRGkvE9aIydJ k0rjqKkxDAuT1SXy1IBz60cx2VutSvE62Wg6uN3jeM3wPgOHq+ccnA71nY8P8nAsDE0iC/5YR4s0tO e1YWFmLBF8TiWofavtjiQzRN5JArRGAdoSseCu9rM4Agl2OI1Z99fhdxq3LrYJXFVDdZLIlMW8n1DO egCycrggYzOaG114EndKmY7TBCBUfZkAxDU0O/t/YRLEBYqVlpZTGugD+LL0Odn8sgVNk5qwzCabkA A6v2Azd+H1iC5u5tFAoJD01fRv6ehdA4UZP+Alp0cSfooDCbJ8gHvwkVaktKC6pwKotnrI9de/3zpO 46+EcziPobYfUE/n+MG406Cr5/DbX8EH9RPVHvhxCN4tY5nHwpnIrHnelwe0RJOypvREb+N9DWq3hk QV+e8YP2rpKcIn25nevZZYExlnnxRWg+81Eo2n4xhAAtGY0ixR7hSYBOTp3jD1BuSfucmRBNiCuXRL qAMcw3Ygfp9kKDBDxcXrVBF21hRPN0cv45Odmb5Ee2GoQKhWYwpTAqHsctn4r3fhnQU7DNTWYzTjXp EU6fBQVzpe+v4o+gD7iVUj1EdwkxfMj9MlKVTgdtSKn+PDYo58UfpL2zyUyw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1]. Replace struct aperture's "ranges"
0-length array with a flexible array. (How is the size of this array
verified?) Detected with GCC 13, using -fstrict-flex-arrays=3:

samples/vfio-mdev/mdpy-fb.c: In function 'mdpy_fb_probe':
samples/vfio-mdev/mdpy-fb.c:169:32: warning: array subscript 0 is outside array bounds of 'struct aperture[0]' [-Warray-bounds=]
  169 |         info->apertures->ranges[0].base = info->fix.smem_start;
      |         ~~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from samples/vfio-mdev/mdpy-fb.c:21:
include/linux/fb.h:510:19: note: while referencing 'ranges'
  510 |                 } ranges[0];
      |                   ^~~~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Cc: Helge Deller <deller@gmx.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 96b96323e9cb..bf59d6a3590f 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -507,7 +507,7 @@ struct fb_info {
 		struct aperture {
 			resource_size_t base;
 			resource_size_t size;
-		} ranges[0];
+		} ranges[];
 	} *apertures;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
-- 
2.34.1

