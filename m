Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA56C39BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCUTCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCUTC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54B75650C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679425298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jDgIhgp53F4LHTSbzXO+YUJfE0aKRCAlyTc2/nXzqFQ=;
        b=E698QrxuB8XhYn7YBnkL8kpOWofZ4GFcuKSHiLMFu5oZ6070FJYmfZgNy1cnUBLF2j8213
        h+beXYSQCQdqpsosoeWyAGXkC4b3pospsLC5fB54BE9BAl/kwny0ITTog/F+FKeKiogdjY
        6DxAg/YDe07iKrT+6rsX5OvMNVZ36EE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-9Dr7K1M8OdOgkvGohOI46w-1; Tue, 21 Mar 2023 15:01:36 -0400
X-MC-Unique: 9Dr7K1M8OdOgkvGohOI46w-1
Received: by mail-qk1-f200.google.com with SMTP id b34-20020a05620a272200b007460c05a463so7548673qkp.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679425296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDgIhgp53F4LHTSbzXO+YUJfE0aKRCAlyTc2/nXzqFQ=;
        b=GPwcdgO7FDrOolnf/nGlmhRcZLZAo+fAcM0gtpgDAcru5GXmJ3kZM99Z/Co8k01QTM
         hXcrx/6fpMyKix31uxSUQEO+yxdGizm0Y3qeT1KtRqFOZKUIcWbvz4tkO7Vp3DwWuep6
         qQzvZvtPOT0omRfoxOjU33Bi7WkFSMOuP9ajmcKZWPTyTQtTRatEUXgeXD8/s3DlOig3
         XwhYOyb52aYQM2A7SVWaAYuZ0IdJQSOwpIlFJiLgjwnLBV95PkP0DOQKP46ASxpkujMc
         HWiJdC8FhHlqmrHJ2W/PLgTbEkzdnLn+jeaJXSnVmcutK99HriIcPh5aXPAtPg+DygIu
         CaiQ==
X-Gm-Message-State: AO0yUKW3eUAUfxN69bz1nbK6BCCcsFDmb2VkNzn4gsx+2teGI/cpT4mp
        D2hx4ppkmRZhqJGHmLkH+b8dom+gfdaq7oeXe9OXKhFSFw/qfushOErAGk2NI4y6CFKtJlvLL6K
        6G5J79hsN8xssiCiWK+nFuiE3
X-Received: by 2002:a05:6214:d07:b0:5cc:e059:efa3 with SMTP id 7-20020a0562140d0700b005cce059efa3mr1487154qvh.23.1679425296008;
        Tue, 21 Mar 2023 12:01:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set9UtNWa/XtHHXbYeSxWPiA8fhZvXtBktHVWK/DoCGMPKvnMpcnYyKocZiXKb0EXFRGGYKumwA==
X-Received: by 2002:a05:6214:d07:b0:5cc:e059:efa3 with SMTP id 7-20020a0562140d0700b005cce059efa3mr1487112qvh.23.1679425295618;
        Tue, 21 Mar 2023 12:01:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v127-20020a379385000000b0074230493ccfsm9847029qkd.73.2023.03.21.12.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:01:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] staging: rts5208: remove unused xd_check_err_code function
Date:   Tue, 21 Mar 2023 15:01:27 -0400
Message-Id: <20230321190127.1827703-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/staging/rts5208/xd.c:34:19: error: unused function
  'xd_check_err_code' [-Werror,-Wunused-function]
static inline int xd_check_err_code(struct rtsx_chip *chip, u8 err_code)
                  ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/staging/rts5208/xd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index 42cab93982c0..c0af378ada71 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -31,13 +31,6 @@ static inline void xd_set_err_code(struct rtsx_chip *chip, u8 err_code)
 	xd_card->err_code = err_code;
 }
 
-static inline int xd_check_err_code(struct rtsx_chip *chip, u8 err_code)
-{
-	struct xd_info *xd_card = &chip->xd_card;
-
-	return (xd_card->err_code == err_code);
-}
-
 static int xd_set_init_para(struct rtsx_chip *chip)
 {
 	struct xd_info *xd_card = &chip->xd_card;
-- 
2.27.0

