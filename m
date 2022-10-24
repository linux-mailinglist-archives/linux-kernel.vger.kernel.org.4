Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39BF60BE22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJXXEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJXXDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:03:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9632BB27
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:24:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z97so33527734ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4TfgwncnU/HwDrEet2mPSVCmyGRLpO7aAKR17oXTOM=;
        b=ZvCH3I055bsQxyZ2EFbe/WK0etuo4Ftc4KWHjKWllkkcQHDdtU9Wih+G9leYJphdlX
         Eqo72/eHiCAO9cKSri1OYJOUn7RxXYE8rqflcXWY5suZSedpJykeoNPQImJy9RNN7zF5
         jG0e+X9NHnXcyOZuXz0CMwmvzUSkQ7qWuAbk4bEIGCZk6nUsh4RJKCXjAY55hGqmPAib
         jc36hCrwkdajUgB6zbzmUgw728cGkuBMXe91Kurk5XmL5KvB5cGJ6jBlQJvp4RQVmVRC
         k5kucKtxMeIEd6E5Rc6hb/Y7ZV0/gatFY7c8jwDT+tg6kQalpdC6nsclVEeaxYVnOYKm
         vJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4TfgwncnU/HwDrEet2mPSVCmyGRLpO7aAKR17oXTOM=;
        b=599izUmLkPR8Y2iWu7QYvxbe9hMRYFL5/CaA/loS3DGNrhZ1qvxPrr54a1pSW79bsS
         +PbphnSJEF/G/QeLQlP0LrnTGwuO+odXdsfH4UNs7EFhUN6YrauN7XT389k2yGMc5Buw
         DNmvpBk57treA/LUMfRvxfeoUV5/+xhLOvRvnNZK4DY6mSnDr9/XpYdRb+avXyU0CzSs
         UnqB8RVNVBJY3gnS16vi+dPOfqsFfioGs9imUb6tsEpNZJL97Q7fgZwQtIgEQedde58V
         vdInUcVePiybOtCOCYDHaX6jCeiAS4ZKlhZrzfOLs90NO8cpqJICElyLG9Hnl287uJJO
         9rTQ==
X-Gm-Message-State: ACrzQf3qz450WMlRe5Ni8ssHp4WqlNWUPbzkKOPLzIHf6bAZ4l0nbj1/
        sSrUu9IYCD1bHyqp3K2UTvU=
X-Google-Smtp-Source: AMsMyM7VgT0h8faK9qer4AruU019XwyqUcMD+U0WYjbRMdtVTBL+cM4HSyxblSfwbMnnndIhUT9SEg==
X-Received: by 2002:a05:6402:40c7:b0:461:ecdb:1c41 with SMTP id z7-20020a05640240c700b00461ecdb1c41mr3511218edb.288.1666646666234;
        Mon, 24 Oct 2022 14:24:26 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b007a9c3831409sm379354ejg.137.2022.10.24.14.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 14:24:25 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     namcaov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8712: check for return value of _r8712_init_xmit_priv()
Date:   Mon, 24 Oct 2022 23:24:08 +0200
Message-Id: <9314f33cc91f69d7d5c79912fe55136faca7927f.1666645510.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666645510.git.namcaov@gmail.com>
References: <cover.1666645510.git.namcaov@gmail.com>
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
index 47d7d998fa86..ade57dd89eee 100644
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
 		return ret;
 	memset((unsigned char *)&padapter->securitypriv, 0,
-- 
2.25.1

