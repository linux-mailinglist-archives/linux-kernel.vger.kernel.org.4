Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098766DB5E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjDGVvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjDGVuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:50:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273F3D328
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:50:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94706a972f3so30767666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680904243; x=1683496243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdeCi9ynBBJ3STbkPEllMJlg5rsYYkXlBNCjPQYQj9o=;
        b=KXb7MwaLEC/Ok7JTRQaP0KVNxzKIRgKDnJ4/fxfBHzR57E2DE2GH2C9GgP+YaS+9KJ
         s19Vri+omz4YKyGgEMHouVTE7TCNiOT+cXTVJlrIzn9hDdFGliu0Ej+mud0nCymMqUXx
         XjXolaCrrpQiF2tC/dLUbgocLnHsrD7HpougKGOdipP9iNRj4Ror1t9pYFIjIwrMhA9f
         FDN4z3c7Yf+dJ+yJmk0eve9W/WFXjWfWkStslXWIF0KnHxmvVKzOudxTP9fTM9t6xuFL
         ZHVXMDSk22QZ3Toy8q2lTnw6hfuDWjFMIWEpyc4psXsPBQZ7pjZbuM/ubCgviN7v5cST
         IPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680904243; x=1683496243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdeCi9ynBBJ3STbkPEllMJlg5rsYYkXlBNCjPQYQj9o=;
        b=saH0tgpVWWYZ19U/4UCnkjBdpwhrSTHNlFCMh0POOgUIrR1upXwRZQgy+oFHTXashw
         BZiJPUz5Tk9rdIDb0izBflVjOypM1UPJIeAbOnPqTikx0JJzyf0+S7R5OcAKGjmhshH2
         AuBzSmFoULXFbcyhDy3emC0YxbPoolqXU4LIeyla1XF1GNIiMN6opqi4ppFqAyEdzG4w
         LeVbLuASwhkHpwClTJXzUdmIwKewusvkDxeJTwbLlkvnU+xAt+GtNAtX7/Nf0ZXCRfLN
         MrEFioWGJIgprvxP6UuY/UJ58QsX6BOWwofZxZt/5dbzkDYAk2E6o/L3Cwdm4uZBwTdV
         lZiQ==
X-Gm-Message-State: AAQBX9fEpgnyQ0lJEmG8a2satUy7lD02NVp+DIl2PN8DqkiXD3RNkR1F
        cF6O9F9hxPj+gJpfQuxqTCNDbmb7EVU=
X-Google-Smtp-Source: AKy350ZKZdm0dRFxGifIQ3GKK8AkOBHlkVuwM6+I/CnRiDVsliuK6S6zz+C8e3YJPFFDy8rSemaOFw==
X-Received: by 2002:a17:906:74cc:b0:933:23c4:820b with SMTP id z12-20020a17090674cc00b0093323c4820bmr640720ejl.4.1680904243432;
        Fri, 07 Apr 2023 14:50:43 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ke19-20020a17090798f300b009306be6bed7sm2417284ejc.190.2023.04.07.14.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 14:50:43 -0700 (PDT)
Date:   Fri, 7 Apr 2023 23:50:41 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] staging: rtl8192e: Remove unused variable RF_Type
Message-ID: <7710a87f627dcfd2d0c34f14f583625ffab10660.1680902603.git.philipp.g.hortmann@gmail.com>
References: <cover.1680902603.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680902603.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable RF_Type.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1a0177cd64af..b1729d65f67f 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1393,7 +1393,6 @@ struct rtllib_device {
 	size_t assocreq_ies_len, assocresp_ies_len;
 
 	bool	bForcedBgMode;
-	u8 RF_Type;
 
 	u8 hwsec_active;
 	bool is_silent_reset;
-- 
2.40.0

