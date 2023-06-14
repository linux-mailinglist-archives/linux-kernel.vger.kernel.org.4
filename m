Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060EC730730
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbjFNSNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbjFNSNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:13:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3926A6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:13:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-653436fcc1bso5758712b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686766394; x=1689358394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HOVYsIp+BNVnNXEjvbG7xYR2tkPqgQfOST29RZSiA8=;
        b=Arq5vahp11WeWMMNstve4XfluDy7bBtG+2dZe+Hn8oTec/TdTu1J1xgtyS763yCl6m
         1EcWD7rNKi5HD2gMEs/pF/VAXSVhyG1f80jSo8/fS4E//O2EMnWTBcTi59RKvJxqiUxa
         CxztbWoOlIqZGqtIVnuWbI99lX0McAmXHKe4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686766394; x=1689358394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HOVYsIp+BNVnNXEjvbG7xYR2tkPqgQfOST29RZSiA8=;
        b=ZTYPsFjYzG21HOfmfbws7Qz2G3NNBhkXvqu5N4vVmxiJqpBdC/MDRIy+SjqHkl4xIR
         X6HIPyQ3qxb7dGAmIIRGlY9uXQ2hX/OF+PQp4krrlBEYD2N8mP2ciAMhfSv1eNprBETz
         v87W9Lm7uUrkXNsM8KTlFKgdXBxYZRqO3b1oY8dDXaWw6e22rWpwAKNFPI44kANPF9PB
         IvRcUCC9ASxq4NatOK6WdTp5awf+1WNi0fJhR0R2/yEyX/O91X7SQ2/L2VEMIycrdIcS
         N8s4FczSON7SGUFo5SvuhJrc3mlwxu45QcHBEP2OJKOTLCbmvH4RQhA/t0kmfH90ndXu
         A4xQ==
X-Gm-Message-State: AC+VfDwItIOWYGzfn+/GGaDKz5+xzk98KeeW3+3dcl0JT+fRlOZ1OHtL
        U7i/nmgXu/AkKBvzsl/DqDT2YJB+iYZ3d8yVOpY=
X-Google-Smtp-Source: ACHHUZ4rxR6tIMcABwSIbciIoJJ2F5q64xk/3jB0Cwgn2jHH+rNv368YcOnktvJlNKTWTy4VhilYlg==
X-Received: by 2002:a05:6a20:7d9d:b0:ee:f290:5b5e with SMTP id v29-20020a056a207d9d00b000eef2905b5emr2571456pzj.43.1686766394399;
        Wed, 14 Jun 2023 11:13:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t11-20020a1709028c8b00b001ae0152d280sm12409104plo.193.2023.06.14.11.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:13:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] usb: ch9: Replace 1-element array with flexible array
Date:   Wed, 14 Jun 2023 11:13:11 -0700
Message-Id: <20230614181307.gonna.256-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; h=from:subject:message-id; bh=BC8U8xN+MrnnBw9m3tXW7ogZaXnoh7O6Bt+WmSFmWW0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkigM3X2rz4vWzN/vJib4rjtjbwXjlgC7OYE0iLv9o Dh/d+yyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZIoDNwAKCRCJcvTf3G3AJhojD/ 0bOCo6i5ny2n/wbMJ++PmMLUvPtE2oex8DssyDyhZW6+TthX26BDqiNXTKJnv+tPb3tRWFZ+wipDQ0 6ML+b8XpwIZDVx1cEG4/DlJxs8nWkQ2JnzEGVWZTV93GrBfc5iJvga7euh5RvYLGct2NQwP7YZv9PV AG5NI6VFGZZNCGs9tXDRGfzBdRZ+2sNuOnWHxDED6pLOF4fL1X5bZPkHlJTYDMOnOG4H1TXiP81X8b LOm95Fwn/1UCf4VoS9R46FEcwB26vocbJW6sq3SN+Zk2WAhLsuUzbRKsdaMdFk2VpFRqs+/kFGmJWh 77aJYX3bbeK4lNjHz/SV64LVBdAcUHmMkH83qwdOf/y4GUEjVwm3dE1NcsgKWsRarHy+mzXk86nDf7 KcFVnQ9LP/NsKdoxvjBVCq1ORvKILdg/R/iR3SsnJLoUiESfwJBBIhV7ZaZJY9n51WVOx14RC/XVhy leqJl9kxB6UMbTbcGhE/y8P8A0xaF/iW1yBpBq6BOAR/SrhgctRWl8u+BLablIOUj6Q76wfzTwd+HY 3V4MyhzWnMQpBESIUn+1e6b3CzY7anh36T4dhJN30EyoMlKtdSfk1SElTWDF2nm4L+yryrcmD+lIMM xQ0d4pPMoLiHlSTMPUqLkeHfvalyOMwlyoPvS4juREEsjDXovv2PKzWUEmuQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"),
UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
wData will trigger a warning, so make it a proper flexible array. Add a
union to keep the struct size identical for userspace in case anything
was depending on the old size.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202306102333.8f5a7443-oliver.sang@intel.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel test robot <lkp@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Jó Ágila Bitsch" <jgilab@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: fix commit log to avoid bogus Fixes tag (gustavo, gregkh)
v1: https://lore.kernel.org/all/20230613210400.never.078-kees@kernel.org/
---
 include/uapi/linux/usb/ch9.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index b17e3a21b15f..82ec6af71a1d 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -376,7 +376,10 @@ struct usb_string_descriptor {
 	__u8  bLength;
 	__u8  bDescriptorType;
 
-	__le16 wData[1];		/* UTF-16LE encoded */
+	union {
+		__le16 legacy_padding;
+		__DECLARE_FLEX_ARRAY(__le16, wData);	/* UTF-16LE encoded */
+	};
 } __attribute__ ((packed));
 
 /* note that "string" zero is special, it holds language codes that
-- 
2.34.1

