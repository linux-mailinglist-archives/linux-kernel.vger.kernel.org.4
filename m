Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311F6AD98D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCGIuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCGIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:50:13 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D56B5FF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:50:10 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cw28so49292944edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678179008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GFQv4/Ns3Nfi73ZwFrLlp9/6YwSGNlJakq8RjW9OfI=;
        b=mb6HCoQdgbUdoTO5sLWloyZgOY6Jk+NIF6Xl+Vo94MFkonwtA5Wa0oHgbVAgC7dZSj
         TE2wxofcsK5scYjpqMTgAR75sspJKXjNqhPV7iSVkpmIQVpPIXa7TMIPCRERdp6CqFpL
         FLx8MG0xu0yUBb3bVfB05mvl8RbEShHyyVJd731fKm2bppuHH0NotaUSlV89VogZi9vY
         DK8ySsOBLrzyDyAiM/3RRVjWJ7abz1ikONmVXMseyzC25hsOXe6+sS5rmUAp8/lEf74d
         r69zEegsa27Z1jBpH0VC7uey4gbouSaBD3yOFVJeXXmP/rEyzTmxELiOmnou6QpnFxuz
         LK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678179008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GFQv4/Ns3Nfi73ZwFrLlp9/6YwSGNlJakq8RjW9OfI=;
        b=4zCr8QD+mo+0mz1i8sjcmjIuyeTm73142IN+lSZ0MM+rBI1IjYGmA6YR1gfZ3ZG3gm
         XRQf1lknEFf/idZaAEhAq/P3coehKgNgpmmue9Fi802i+SCtDGw7+deFbDXsemHplLYk
         je+jswWAQKOw7G+GK+ZIyN92BTqI+LDYf4Amdy6VAoq5a51XVxoQ6fkE/IUZL73m0s0W
         esXTAepuDT/x+nV17PgtcYGAdEfT81I9SCb5ijvtM6cCF+Ml23ngJwiHpUbN1rDbHS/P
         3I5ySmz4RvcvNRrB7f7epaA8GBmi3umI8Q9XEjjDBwdWCI4n47KocF0CydcMMx5T0vTO
         SSkw==
X-Gm-Message-State: AO0yUKVC8KhSMg/Pt36Alqqz6BXanCmrFwFf//BKtnkGZyY0ofleMKzd
        yetMkL/Br653b4/lxvUvR2M=
X-Google-Smtp-Source: AK7set/Zw8sivf7IxlWxAPdvgsvetEX53dZnC6qiHXJuYGjRPFNcTEuSL3FDBGusA0dQgUnQI15F3Q==
X-Received: by 2002:a17:906:dfca:b0:884:37fd:bf4c with SMTP id jt10-20020a170906dfca00b0088437fdbf4cmr12474897ejc.19.1678179008745;
        Tue, 07 Mar 2023 00:50:08 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbe7.dynamic.kabel-deutschland.de. [95.90.187.231])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b008ef42f9cf48sm5707402ejd.82.2023.03.07.00.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:50:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: busetkipkey is boolean
Date:   Tue,  7 Mar 2023 09:50:02 +0100
Message-Id: <20230307085003.5025-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307085003.5025-1-straube.linux@gmail.com>
References: <20230307085003.5025-1-straube.linux@gmail.com>
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

The field busetkipkey of struct security_priv is set to boolean
values only. Remove unneeded comparisions from if statements that
use this field.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index fc7568cf948b..741c17121c9b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -471,7 +471,7 @@ static struct recv_frame *decryptor(struct adapter *padapter, struct recv_frame
 			break;
 		}
 	} else if (prxattrib->bdecrypted == 1 && prxattrib->encrypt > 0 &&
-		   (psecuritypriv->busetkipkey == 1 || prxattrib->encrypt != _TKIP_))
+		   (psecuritypriv->busetkipkey || prxattrib->encrypt != _TKIP_))
 			psecuritypriv->hw_decrypted = true;
 
 	if (res == _FAIL) {
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index df88b3e29e77..cc3894101673 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -626,7 +626,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		pattrib->iv_len = 8;
 		pattrib->icv_len = 4;
 
-		if (padapter->securitypriv.busetkipkey == _FAIL) {
+		if (!padapter->securitypriv.busetkipkey) {
 			res = _FAIL;
 			goto exit;
 		}
-- 
2.39.2

