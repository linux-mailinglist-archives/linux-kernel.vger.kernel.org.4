Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B4B60B5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiJXSko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiJXSkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:40:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A257A8365
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:22:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ez6so8621707pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfwpvweGi1Ucx8HQshpxviuI+RQIpmr8edZSxz2ZyS8=;
        b=cRHBNse3LDl7knerfXifthateEO5UMiwl8a2j41s/BW6mt9+2V3xiOBC2HFZioyyJH
         i+yc2YUJzK2L4RQsm7M3cbP6yJybDkXRaeZV/j2urLVjf0krimJh45HbXtqBVhQL1Iqq
         JmXAxZ1V4PIuXYnDklyo4doMEr87jbivpe/Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfwpvweGi1Ucx8HQshpxviuI+RQIpmr8edZSxz2ZyS8=;
        b=EWBu6cBAZB8xztusCBkReEzuVr1wvhomECDsFEKRcmm4LD54I30QgXFRcQLOF8PRvI
         ViUg2sLpHfL9B1G8GfpqKX67Mq9a+hEgmO5E+XrT7pI8Vpw8KHFDL7Q+m1YAvgroLP9Y
         EKW8rCCFQ+qefhFnUWILPqa5j0yRoHQgMB/qZMm3gfQ9IbkoTRQJsBFlpcrde2s4hqX/
         3VS0mK8ry/TqASdWu+BL+9GHyDRif3k9qYeDQ9uM6a//YNt1NJEY4Z9ZtFyhwygfjpH1
         qRY6cvZgVDdzzGrtsGOOqKWhe0oswoEKE0yKEtgsaZtvHH3Jk+rG397yZXgJbRSgjrUk
         Y63w==
X-Gm-Message-State: ACrzQf3vA7gQKkZXq69ULntMic9uW0/54EcXq0XBCDhHMBl5Rs8wu7BA
        W9IDDJmFt1W8kbNV8Gy0+Ig/UQ==
X-Google-Smtp-Source: AMsMyM7PFXJJIVqkR6UWadHj6ls9b0femM8h8ZBqzJ3mOQ08s0OS0x6/s1Yef5s8sJBjNsSBl/joMw==
X-Received: by 2002:a17:903:2307:b0:181:e618:b4c5 with SMTP id d7-20020a170903230700b00181e618b4c5mr33087193plh.172.1666632060401;
        Mon, 24 Oct 2022 10:21:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i188-20020a626dc5000000b0056262811c5fsm72421pfc.59.2022.10.24.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:20:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Zorro Lang <zlang@redhat.com>,
        linux-xfs@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Daniel Axtens <dja@axtens.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] xfs: Use flex_cpy() to check extent copying
Date:   Mon, 24 Oct 2022 10:20:58 -0700
Message-Id: <20221024172058.534477-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024171848.never.522-kees@kernel.org>
References: <20221024171848.never.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; h=from:subject; bh=x7Rm68JdcafZ41E9GsTynBW1VglPIkAcCBWjMgC1XZs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjVsl5e3fUqEVHLRTWTi07FP0i2KlufVIIqNEwvzK+ yPgcmKOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1bJeQAKCRCJcvTf3G3AJpMWEA CCEj7newKc7qcVZhldSpFBK/EeIB9fXY4+iLuVdu3LFqPY13Hef3MaSmkB/Y4IRnNYMG1z40nYXPIX BRl9opcuI31xnN1rs9ZUql+0uHLhCbkvPekMurdx40/rXV8JSpfAawk6g/Hu4CzhhSEZPdV2BCmaA2 gPls9t3srVcaoPQcet6h5Vl878GD2tUPabyGLFzf2zrvkrYFuVG9Vcf8M6rzhWjAgTUrKXTOgGosnk yGdKK2sRbrNnAI3hLfunqyLQKTE2SM35KEak96gL9DDY4Yj+Jir7NkBast9okeDQfOYj3pfkyZyvVv yq3vnuORIfjZgdqMs/p+kv8pQKeOqwBTmplsuSM9xrTvOT1ElTE4P2+4hKNvRivsAlyme/BYPaUdW/ sUfyLqIoCWWsRNTtJ1BkJsPqnHMTxkelyCDmn5xTuYv+GAbx/2UG13vPbNvmJUPLxYTw+YeksRdUYl ZrMgfde6Ifb4yzbsuerEt/fkpd6/85Y7vJ4vf/GtZOdVt/QN4BDxlETGpas8pgV+Bs4tqMNFPpHRHm eFd8JmG9/qGYmtuaMepu/Rn7zhnwIYUevSDwoH+OanWEGdftSxXaQyEO28EEoMYEGbyWDTqkz04/4O zC5bLw/JhL8gPbVuJHIo7cu+CcKMc0HdtDfDGHW0LDUBdHrqREEUb2tKT8hw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use flex_cpy() instead of memcpy() to copy the bui_fmt flexible array
structure, which will perform bounds checking internally. Avoids the
false positive warning seen under FORTIFY_SOURCE:

  memcpy: detected field-spanning write (size 48) of single field "dst_bui_fmt" at fs/xfs/xfs_bmap_item.c:628 (size 16)

Reported-by: Zorro Lang <zlang@redhat.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216563
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/xfs/xfs_bmap_item.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 51f66e982484..5f135893df66 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -24,6 +24,7 @@
 #include "xfs_error.h"
 #include "xfs_log_priv.h"
 #include "xfs_log_recover.h"
+#include <linux/flex_array.h>
 
 struct kmem_cache	*xfs_bui_cache;
 struct kmem_cache	*xfs_bud_cache;
@@ -624,10 +625,10 @@ xfs_bui_copy_format(
 	src_bui_fmt = buf->i_addr;
 	len = xfs_bui_log_format_sizeof(src_bui_fmt->bui_nextents);
 
-	if (buf->i_len == len) {
-		memcpy(dst_bui_fmt, src_bui_fmt, len);
+	if (buf->i_len == len &&
+	    __flex_cpy(dst_bui_fmt, src_bui_fmt,
+		       bui_extents, bui_nextents, __passthru) == 0)
 		return 0;
-	}
 	XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, NULL);
 	return -EFSCORRUPTED;
 }
-- 
2.34.1

