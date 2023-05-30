Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DE0716893
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjE3QDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjE3QDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:03:31 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B657E40;
        Tue, 30 May 2023 09:02:52 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-19e7008a20aso2023773fac.1;
        Tue, 30 May 2023 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462571; x=1688054571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTprFbIMr9Ml4gU9NLG04/KP+iIXZDlKABcpIGgf4KA=;
        b=gncDrLiFvN6sQW+evUoQZySgAFc2B4v0RXm9Y+WHUmMgSxLVfAg3A8VlWFRO3+mui7
         vlwbWyFy98AEsQto0vQVXIB+xlekby7aXcuMGA7GhXaRzrKL06PnT1dnVEobq8lL8Z4K
         lAHNsfTfvL43dhSrVGZ4cON/11pmKZ9oQubO+OSnJZ3YeVg75xtj6QxbcU1YgSl0BXRa
         laCea2RqQBaqPX2W40fVONDS5pAlwno4EtrxxKeY6hvkLBnV8qiSr0Na266E0aRjYbUV
         qGW3wXQws5hQ1jrgRvs1hKHay92wTFl59daxiPaS0SyA2ZSOrwI/YJ1rSWOydkD8FB+f
         PkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462571; x=1688054571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTprFbIMr9Ml4gU9NLG04/KP+iIXZDlKABcpIGgf4KA=;
        b=CcEs0ZfNKHyCTAjXPnWJrV/TjquL4WGbyVRsoxDiE6OpvaJXfT4n7k+55OhkJJZ1FI
         xdWJHJJaLuZIbvYvpFuSWQU+sY989J9tq7wYKqp7zITqDHajY51C++7TxPnZuKqoNp8J
         h15PFZ0UY/1yPPwFlHHdjPYi/6nOjfihL0fd/qP8EolXCZ37geFdS+mZcT0FBuuUWt1C
         8q/ET+MnMkq1B64iIdtXlUx4+A5IerLQ1tWb+DggLTZhyPQ4aBpJUFw27O9MgW6/3DAN
         QfgZyOE8CBxZ6VFoQMZdKSrgmGfsEnPTnETVfBSIa6Tnuzxg0tCTh/jVGRBxEPk8aAaT
         lbjQ==
X-Gm-Message-State: AC+VfDzGwbYmU2/YGdkojIwYMY3UAhWAGpzd4ot4vxn0sOA0Rl/FZq3l
        9jN/dpxfC6t2sBeM9+WMaOU=
X-Google-Smtp-Source: ACHHUZ44GvVRtEbnpksoS+dSzIbLGzX3TdCD6l8fKp/oTGA0fXomdEcvb1ffLG7B2/HKzMrO3E5/2g==
X-Received: by 2002:a05:6870:487:b0:195:c46d:496f with SMTP id t7-20020a056870048700b00195c46d496fmr1181514oam.8.1685462571577;
        Tue, 30 May 2023 09:02:51 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id w27-20020a02b0db000000b0040fa0f43777sm792648jah.161.2023.05.30.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:02:51 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: message: fusion: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:02:48 +0000
Message-ID: <20230530160248.411637-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/message/fusion/mptbase.c |    4 ++--
 drivers/message/fusion/mptctl.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 4f0afce8428d..4bf669c55649 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -712,7 +712,7 @@ mpt_register(MPT_CALLBACK cbfunc, MPT_DRIVER_CLASS dclass, char *func_name)
 			MptDriverClass[cb_idx] = dclass;
 			MptEvHandlers[cb_idx] = NULL;
 			last_drv_idx = cb_idx;
-			strlcpy(MptCallbacksName[cb_idx], func_name,
+			strscpy(MptCallbacksName[cb_idx], func_name,
 				MPT_MAX_CALLBACKNAME_LEN+1);
 			break;
 		}
@@ -7666,7 +7666,7 @@ mpt_display_event_info(MPT_ADAPTER *ioc, EventNotificationReply_t *pEventReply)
 		break;
 	}
 	if (ds)
-		strlcpy(evStr, ds, EVENT_DESCR_STR_SZ);
+		strscpy(evStr, ds, EVENT_DESCR_STR_SZ);
 
 
 	devtprintk(ioc, printk(MYIOC_s_DEBUG_FMT
diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 1decd09a08d8..dd028df4b283 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -2408,7 +2408,7 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 				if (mpt_config(ioc, &cfg) == 0) {
 					ManufacturingPage0_t *pdata = (ManufacturingPage0_t *) pbuf;
 					if (strlen(pdata->BoardTracerNumber) > 1) {
-						strlcpy(karg.serial_number,
+						strscpy(karg.serial_number,
 							pdata->BoardTracerNumber, 24);
 					}
 				}

