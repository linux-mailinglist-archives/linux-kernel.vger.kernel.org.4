Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3D60C7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJYJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiJYJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:18:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681216C223
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so7305204ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiyKXU5FxcBo4aQqXip+DivTGxVo/DuU5b7lG8hm9nY=;
        b=N+hlx+k2SXKWFiaDXDxEXL3461ZtjohMXc0sKc9tjykAPxjCG6LqEohmxBA1TsSLM6
         upsrJeB37h9M+z3m80c1fQ/x6+x1ZnOpq9/RZCvb6iU8FAvytsqVm3sz7QKpibjnv5/B
         MG0ViYyYuQO2Leb6BKBFnq4V6SNT3dlVpdd6pLPwg/FLQ/8eppJkxIU7QxO4dK7d5dF4
         pKaemWVBLB5hYMym1kB/U7VQhi7CekPVu77u9QwXUSWixAxDQtHPf6o0H9BPiuw2FfRD
         hkQIX8mU5EcJUh4Yjl+F8VnDtb5Mrj+SJcg0lTPqrVv416yhS1jh2ptDKfp1Q3Uw2V7d
         449A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiyKXU5FxcBo4aQqXip+DivTGxVo/DuU5b7lG8hm9nY=;
        b=McfHmKoXburTMroNQVQ2FS+NoREyk8QOh33/olv51ODRuLajQTVwe5810WERv15pVN
         N19a9Y4RMd6zrSXW4bIchdO7ZPeqFnS4Y9PgBmrjLLvgpnFy3oNw4lr91prDzK0cgnOn
         PFXYSJtLVgUMYNnoRmUV3l5xe1dvggyYHNvjx+ABJFGxqrZOj7FEVx8hL7r479vrIGma
         ZwpfhuCLlO9BjS/Hl/FiEkps/bI6JINTY2qrPjMCZ+2+VFwp41aq6i7Htaxr11ydDcmV
         gN/w6hSDxmSxE6c8xjA5mNHgvsOgrddVK8xVKW7Ydp29LbpQu7yQfsbvE6JawTDAvwhN
         n6Bw==
X-Gm-Message-State: ACrzQf1vfiEEuWuCBHats3bpqRJUvDNrupgyKqX484TfyOYbtl54GCEG
        d+hGPs9tMaRK5R4O1a8csMg=
X-Google-Smtp-Source: AMsMyM4N/OKd2AmDOmparUNDFZPpsU/fR47DrbDTYIypTubcUNU2WdBUWUrzBxPphI7T/oHKbd239g==
X-Received: by 2002:a17:907:6eac:b0:78d:ce9c:3761 with SMTP id sh44-20020a1709076eac00b0078dce9c3761mr31116005ejc.738.1666689164330;
        Tue, 25 Oct 2022 02:12:44 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id bo12-20020a170906d04c00b00780f24b797dsm1061953ejb.108.2022.10.25.02.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:12:44 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     namcaov@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] staging: rtl8712: check for return value of _r8712_init_xmit_priv()
Date:   Tue, 25 Oct 2022 11:12:25 +0200
Message-Id: <b550803561acf26af71f2377215c28b94435a644.1666688642.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666688642.git.namcaov@gmail.com>
References: <cover.1666688642.git.namcaov@gmail.com>
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

The return value of _r8712_init_xmit_priv() is never checked and the driver
always continue execution as if all is well. This will cause problems
if, for example, buffers cannot be allocated and the driver continue and
use those buffers.

Check for return value of _r8712_init_xmit_priv() and return error (if any)
during probing.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 12adb470d216..205b7d66a40a 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -308,7 +308,9 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	ret = r8712_init_mlme_priv(padapter);
 	if (ret)
 		return ret;
-	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
+	ret = _r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
+	if (ret)
+		return ret;
 	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
 	if (ret)
 		return ret;
-- 
2.25.1

