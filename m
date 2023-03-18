Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9DD6BFB13
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCRPAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:00:09 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4B21C30D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:00:05 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id mg14so5217831qvb.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679151605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsQYvSyu4jE6lask5SYWYAq4ElRHC2rwYckfb3oqNdE=;
        b=wr5DjoR+6RGWJ3uHk+BSybCSScobbiyf6OuH5vJ7BRuOHoeOnJPzXwBooDTH2JcZou
         TFSWAcjlmy9WI1QZDh9wDKMRWmbJhTSy0vfJy0CmSMgO+7b00j+D+ElR4LmZ0dvojUv+
         qN4WfwwKgbWurm1crHs+ysoEZ/u8miJqVaLyFqmyA31m7GHTvD06/iMwDRO1CY2j7q5L
         T6bDmApVJAl1auQjGdlLI/oPnTk0mtEyxKFnbj5P2QjLkxnkvtP8/CcgskXoA0hmCzEL
         ezKzkcZcaK+c+yG6LfcovRP7HRfXBGqDPGPQWJzULIlR0ID/Ya+cRkphyt1xC1mNn1lw
         ad1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679151605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsQYvSyu4jE6lask5SYWYAq4ElRHC2rwYckfb3oqNdE=;
        b=KVSrBtqHrShsuGhzw3FphZQ/lqek2PRBLMAzgFTxOdmnUW7RXWUoqocObYg2HD6EjU
         ccEX/z/2H38cF7hVyc5E68bOxuZhQiOvEcelG5NTRNcY2RbPvEiVDNqegEl5/tpXxlkw
         BlEjRkfPjE0yupXpHJIr0AMUzLk8Jsm3Ep+1Qf4QhcDM5JAwZbo3eg9fPAw7P6DxGz3k
         LRoWdqFRTdKs7E2a2werXgXH1hSi/+TFRxyLuXeMxQ9cbJhVKTToAnPH16HEZMzVZfXx
         6+BtEerGkrNWIdJ3GALnfFOo50+72bg1Fq5FP0lA8wCYj6imQlpWyMzqeXDMZU92H3Yz
         46Lw==
X-Gm-Message-State: AO0yUKWNe3FwDfyODBJExQzdnp6uxwR6pfmFBG7jrfrUp8Rzeh4EIlCT
        p/AIvSns94PaxD1EvwBLN+O86w==
X-Google-Smtp-Source: AK7set8rBT6kFz0Qf3+xdNmfCbabiaft7H5JcwzQCk4AwdBUdI+d4/kiIwOOQjCmpLcd6cNWbgJhUA==
X-Received: by 2002:ad4:5fce:0:b0:579:5dbc:ab8b with SMTP id jq14-20020ad45fce000000b005795dbcab8bmr44111231qvb.52.1679151604641;
        Sat, 18 Mar 2023 08:00:04 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f67-20020a37d246000000b00745daadd210sm3709162qkj.71.2023.03.18.08.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:00:04 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 2/4] bitfield: Introduce the FIELD_MODIFY() macro
Date:   Sat, 18 Mar 2023 10:59:49 -0400
Message-Id: <1c1492558c1a72b64bb26f7a44c4e69fff0e6b44.1679149543.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679149542.git.william.gray@linaro.org>
References: <cover.1679149542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a common code pattern to modify a bitfield by masking the field
and performing a bitwise OR with the respective FIELD_PREP. Wrap such a
task into a macro by introducing FIELD_MODIFY() which modifies the field
specified by a mask from a bitfield by putting a val in the field.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 include/linux/bitfield.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ebfa12f69501..b06a98f0a87f 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -38,8 +38,7 @@
  *	  FIELD_PREP(REG_FIELD_D, 0x40);
  *
  * Modify:
- *  reg &= ~REG_FIELD_C;
- *  reg |= FIELD_PREP(REG_FIELD_C, c);
+ *  reg = FIELD_MODIFY(REG_FIELD_C, reg, c);
  */
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
@@ -155,6 +154,21 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
 
+/**
+ * FIELD_MODIFY() - modify a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_reg:  value of entire bitfield
+ * @_val:  value to put in the field
+ *
+ * FIELD_MODIFY() modifies the field specified by @_mask from the
+ * bitfield passed in as @_reg by putting @val in the field.
+ */
+#define FIELD_MODIFY(_mask, _reg, _val)						\
+	({									\
+		__BF_FIELD_CHECK(_mask, _reg, _val, "FIELD_MODIFY: ");		\
+		(typeof(_mask))(((_reg) & ~(_mask)) | FIELD_PREP(_mask, _val));	\
+	})
+
 extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
-- 
2.39.2

