Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42316C3ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCUTfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCUTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:34:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A583A4FF2C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:23 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bn14so1794409pgb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679427232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AANWMLFPRmqhsaZtqr8wdmw+KFHZMOER6tyEOUd1jY=;
        b=BwuMojxwrYqAFQterytV0n+RM88osD26Ot+yVGJW4oVuyU7P5Ia+32TPE3TQ4xe2P4
         fzICA8yNvs3AAnTn9WehPU+vl9xIM8RMRxSlGzV2O6ivAvuad/cKYlR04nu/+NoUQIzk
         91zilV8eNPrh6E6LjPEbh6RC2tIXsL8xzsUFx+jHhGNbz6z2et/5kUvhG4fT0Z2sfBSg
         rpD6gHm7+ZA0c6tSROeMfrRs39OS1ljzdbSwA0q1b5s16xb7lJEUFF1KgG4Tp4D9ush5
         k6Bf3Rz7JQDZkYmlcizT6A7O+5J8+JqxX69/6hL9wA3IZycxDdELGFP6+vVkachhah5Y
         oRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AANWMLFPRmqhsaZtqr8wdmw+KFHZMOER6tyEOUd1jY=;
        b=ewf4JVrW9YPsuEh5le2rXVMVyrxmhXuT9mg76NjR845BQM9jYJUKdSkqXUcAYBHgSQ
         aqUTVMjy6b9vxs8SoaatG7YauKIwFeQFYHNhP5vjbAc2tPP8DcO7r9aFcB04cpdjZXO4
         R2l867gC8Zeu+0/EFqut1w0EjpZQ87tEGadOJwg1k7pHDYmL7p+NXOSeg8T1NPVkXTm7
         +Vhh2CjHthi1XqB91y/Keid2Y/QEpM40lvvtP6aw/DiWuAfkDPv1JVk7BLTXa0tb67Sb
         tPbHX7mehHT7/j4CFoFrMdeSMBNhcoenyEMh9Zp1jICx/XDu2wckiHL6NWFXNpuzUuaH
         pdWQ==
X-Gm-Message-State: AO0yUKWOOIUviVwij3B0ri1GK3uHxWdK4srhS/0MalQCuyJf9zL27+tF
        8gZ59CIkhlBspx2hr/48hek=
X-Google-Smtp-Source: AK7set9RXxBO1t5rxnn03oPkEDUp9bqa/iXCFRosc2odnBEaopFz8gT18I6/NOs3EfQ6fY6LHWk5mQ==
X-Received: by 2002:a62:6245:0:b0:627:e342:7f0e with SMTP id w66-20020a626245000000b00627e3427f0emr734685pfb.30.1679427232441;
        Tue, 21 Mar 2023 12:33:52 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm8843044pfk.143.2023.03.21.12.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:33:52 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com, yesshedi@gmail.com
Subject: [PATCH v6 6/7] sign-file: use const with a global string constant
Date:   Wed, 22 Mar 2023 01:03:40 +0530
Message-Id: <20230321193341.87997-7-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193341.87997-1-sshedi@vmware.com>
References: <20230321193341.87997-1-sshedi@vmware.com>
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

From: Shreenidhi Shedi <yesshedi@gmail.com>

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index d3abc5721a7e..e8dfbdd3eea3 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -71,7 +71,7 @@ struct module_signature {
 
 #define PKEY_ID_PKCS7 2
 
-static char magic_number[] = "~Module signature appended~\n";
+static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
 void print_usage(void)
-- 
2.39.2

