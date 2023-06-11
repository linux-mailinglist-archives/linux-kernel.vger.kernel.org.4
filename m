Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9698572B1AE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjFKLdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFKLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 07:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDFA173B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 04:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686483138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fvk9nsOU+Ghrao8Fb/Dy7MlM3Rdl5iJgFNPzrlJhwHU=;
        b=NLeWky71Ag08I9v9ErIitvJ6lIwwgVs20IPjXbNxilCaOWYsPJKnb+YsbVdSI/sRc7me3v
        U4+DbV/o+2yUzlg4KxkJIVonz7w+eWe4PzbPP8WlhLr3aP86BPna+967KmYtR5DJ6bpu6K
        RXWddKxuxGnjvPUi78PyhN1l8rsWC1U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-zi30w2TlPIqs5C0M7iQg8w-1; Sun, 11 Jun 2023 07:32:15 -0400
X-MC-Unique: zi30w2TlPIqs5C0M7iQg8w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75eba2e48cfso248115585a.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 04:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686483134; x=1689075134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvk9nsOU+Ghrao8Fb/Dy7MlM3Rdl5iJgFNPzrlJhwHU=;
        b=KO8oEBd9VSIWqZoCRdKNsDrvEZf/HkIAmvcXf5Y9CeU/qXl3SapkCoXSdN5UTHVoG1
         z6m5BQQ0ySGd4YksHvwF8tt2Y1ioQBCUAlivaibnkspSgpy1gTDUk8ODCa5sfVrD0vXp
         sydErfcuAYXo3HJmlY4HCuKExuTLT8tmOM7OJwa5agI1E8k/FkigrS4jTcii9EfIJD/E
         H5jyHw+2wxtjVdCjl1Qa60GNHofXAqAFEEZv9nWVwW6fmCI4+3afoR1hmXboyblDe/FB
         70rOdO8AkRNXbrOefUO6T1mDs3atji+m5Eui+RM0YpKMHTqXzBuA3gCnOKUMTYV2X7Vr
         CocA==
X-Gm-Message-State: AC+VfDw1YSX+OgBSxlCrCnGgTdVJMTP3kirob7j9P7nNWUkkEkXJMH5C
        lRokCv87x+m1WeklituCSt7uuz8gw9aDNLwvaEPSRDfmYh0+rgNaTONHUSxHC6vgoA3/Ww50q/F
        zk6cexoJscbzraHEYtJ3pBQO/
X-Received: by 2002:a05:620a:4903:b0:75e:dbfa:e221 with SMTP id ed3-20020a05620a490300b0075edbfae221mr15325329qkb.20.1686483134729;
        Sun, 11 Jun 2023 04:32:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vRb+f79/ygAXa3we8n0GBP8ylntMxHI3QIBUyoHCWYEcnmdtQzonemXCDV99sYqP6L8PJ1g==
X-Received: by 2002:a05:620a:4903:b0:75e:dbfa:e221 with SMTP id ed3-20020a05620a490300b0075edbfae221mr15325311qkb.20.1686483134522;
        Sun, 11 Jun 2023 04:32:14 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z24-20020ae9c118000000b0074e0951c7e7sm2199166qki.28.2023.06.11.04.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 04:32:14 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sysctl: set variable key_sysctls storage-class-specifier to static
Date:   Sun, 11 Jun 2023 07:32:10 -0400
Message-Id: <20230611113210.182652-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
security/keys/sysctl.c:12:18: warning: symbol
  'key_sysctls' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/keys/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
index b72b82bb20c6..b348e1679d5d 100644
--- a/security/keys/sysctl.c
+++ b/security/keys/sysctl.c
@@ -9,7 +9,7 @@
 #include <linux/sysctl.h>
 #include "internal.h"
 
-struct ctl_table key_sysctls[] = {
+static struct ctl_table key_sysctls[] = {
 	{
 		.procname = "maxkeys",
 		.data = &key_quota_maxkeys,
-- 
2.27.0

