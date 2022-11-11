Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2029625577
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiKKIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiKKIhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:37:50 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACC47C8D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:49 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 21so6690872edv.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si9XFxNri8mLzDVBs0OAg9hzoexdDFNJE3YaOOciu+c=;
        b=XSBHG4K3p/UZ1gh1fnNp1FKmdxFFb86t/hTrcXm/F/Jg3sWvT63v7SO1kiP4P3dvL5
         qgWEMfqY4lTw39sNBWEzvM7sPBP1PJh8/V9/S0mTdQuCTANNeM3MKh6ZOzhVjo7wKTAC
         IqqgQ2zZu3fSO3tqVYm5vYSk6bF0o819y2tiS/OTF1wCzCmWQ/eoczRz9GSfkHXdqNGn
         ET7ixl/C+7sh/jdAecuHccCSm0fXfJk+h85RNfD7WVPwHCj0RFGD63MWbMkghCx1S4JY
         XBmDfjUChVxH8mOgoNDI/FS5bqQ76XsVAmKIo++I6j+KHIi7h3rnZoAQWvr9pUkC/Ne1
         VrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Si9XFxNri8mLzDVBs0OAg9hzoexdDFNJE3YaOOciu+c=;
        b=U+6Fp1i+WQpA4dshXpWDJgxlR5ixXA0GK1gCyKf99/qftRnKiOG1HDupWvU9WiVkPa
         YutHdCwE58fxS+KIVQB/8J1JTFgnApEFq3lGNDKEmmfzrAsyfnvDg2ZnFmFWDQ7W5e9b
         bztq6tTOF7LIGt7FEPg5SHy3GJlsIpL9Qc+I79yo+zE2E7oJB3Dw9FKHYd9zutOvuDLk
         JoxU/oeA7txVgTlEag1XTPc3CwkCUgrHuJoZc0wr34oViKMrPdqwC1n13QGc0asn28rr
         tM7W1yhWu/i6oYgaRCilEQLLEWSUl71Y7C2+rYe8ohgOy6uOSJcNoq7Ka81oQKxNHcnP
         yLgQ==
X-Gm-Message-State: ANoB5plfevxvSVsxfGKlHZ4oFahNDZQVzbjudHgO7Aj7dCJla/9m3rAf
        hIG0hAbC55YSzcdbSjIgrk0=
X-Google-Smtp-Source: AA0mqf5qmgSJlE3KEXHw984duxSXDyi5NfCNIjnyM+o48hqQOKctWFmzTu0yEcJubYuMW6BzpV95mw==
X-Received: by 2002:aa7:c3d1:0:b0:45a:2d7c:f3a0 with SMTP id l17-20020aa7c3d1000000b0045a2d7cf3a0mr597699edr.98.1668155868387;
        Fri, 11 Nov 2022 00:37:48 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9a.dynamic.kabel-deutschland.de. [95.90.187.154])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b007ae566edb8bsm643190ejh.73.2022.11.11.00.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 00:37:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: binstallGrpkey is set to _FAIL
Date:   Fri, 11 Nov 2022 09:37:33 +0100
Message-Id: <20221111083733.3144-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111083733.3144-1-straube.linux@gmail.com>
References: <20221111083733.3144-1-straube.linux@gmail.com>
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

The variable binstallGrpkey is set to _FAIL which is defined as 0.
Use false to set the variable to get rid of another use of _FAIL.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/os_intfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 44eb95a7682c..2f59bb994796 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -405,7 +405,7 @@ static void rtw_init_default_value(struct adapter *padapter)
 	pmlmepriv->htpriv.ampdu_enable = false;/* set to disabled */
 
 	/* security_priv */
-	psecuritypriv->binstallGrpkey = _FAIL;
+	psecuritypriv->binstallGrpkey = false;
 	psecuritypriv->sw_encrypt = pregistrypriv->software_encrypt;
 	psecuritypriv->sw_decrypt = pregistrypriv->software_decrypt;
 	psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open; /* open system */
-- 
2.38.1

