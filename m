Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138D55E581F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiIVBhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIVBhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:37:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C93A6C43;
        Wed, 21 Sep 2022 18:37:32 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so649547pjq.3;
        Wed, 21 Sep 2022 18:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=4bjrfPHHm3HMxmZcB/1HB2OdzsLh1iJDhyxEKBMvRvc=;
        b=IiHS2KiLYZ5Zh0SHzTt2RHmrY77xJ/oq/QQNOmP1OsMnp7Mzx4eIgX6mR5+ZFLqCI8
         C6w1g791govHxYi9fI2Nn5Y1ij3p6dgFiAHMM8Yi/gtJ8zzs4FAGqFL6uHju+7n7N5Zp
         coXDzOIoCOTEEL2posxF6N27K/Lmd/LdqUDXB/4oaNtU2tcKo1vhFVUpLXmAuBg4Or/S
         EcTNIiPVDbijfnSpGVSv0Tm5TiMkZJFYDNR/4H3WLwKIuYQFIZo3TnoMEAqHanxJMe2D
         6A9w5ZP+JEjUs33RxYmVmpW5Y1cOBy0IXdsUbJjytthSyZb/HPkMVvPR/cFUHQuoVybH
         Aeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4bjrfPHHm3HMxmZcB/1HB2OdzsLh1iJDhyxEKBMvRvc=;
        b=M41cIgVZW0NJvNvtgJ2qYF6cG670qrm2EMDfGcFslUamcGXtcEoaGy+DulMJZbjGHr
         gtBNMZtZtZn0jdGO/OKDYsywAlAisJiHzQ/mnkXdas1qiZLyyUV+2JZpKNlTUdG/8V4m
         F4vxzwW7PeicVjzs3LHkOkUY26pit4/AtbZGjbMQTFRdQQn2v1wHMdoacBQCf+JQfvMY
         i25LrCSJkedMTxG70jwdBXD1RhMXjWlFtVLzNf0GFGm52iuNbHDrhb/o4GNuNRpS9Osw
         tVADwXwoxEpAciy9pjKNdxDoPH71hxgrSZXVhu4vcpZq/hkgHC9exmdbrEhc2kHxoOoc
         UDGg==
X-Gm-Message-State: ACrzQf3RUOpRfQQltq6ZeZ69gHpikjHKgzx0MaEsOvgKzNayvqTwQ15U
        wn8MOVCng45iYcTpxvIv568=
X-Google-Smtp-Source: AMsMyM5f7Q7QllkUSfpKSHHMAwn6ucjOkKEpbhgtaZKKHOR9jQLLg+IM6BDS7R1upBlRypNHRwzAnA==
X-Received: by 2002:a17:902:c3cd:b0:176:a876:a5a5 with SMTP id j13-20020a170902c3cd00b00176a876a5a5mr904267plj.94.1663810652301;
        Wed, 21 Sep 2022 18:37:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a294f00b002000dabc356sm2537842pjf.45.2022.09.21.18.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:37:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf jvmti: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:37:28 +0000
Message-Id: <20220922013728.233286-1-ye.xingchen@zte.com.cn>
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
 tools/perf/jvmti/libjvmti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index fcca275e5bf9..04d6825d23c8 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -158,7 +158,7 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
 		result[i] = '\0';
 	} else {
 		/* fallback case */
-		strlcpy(result, file_name, max_length);
+		strscpy(result, file_name, max_length);
 	}
 }
 
-- 
2.25.1
