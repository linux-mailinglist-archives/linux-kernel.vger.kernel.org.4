Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E167A6F4978
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjEBSIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 14:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEBSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 14:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCAF3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683050840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N6mCYnN9DA30kBXb3G+hAjObknC+PiKLk5wLjv+kTMk=;
        b=DkhZpXjifUHWN5zwM4AMiTSbAVJS4xfqvZn8PRzQMS2iHtHCE4v+nw9t3GLqy9LNHCmcWy
        NSC1RyXgRXPL+W3JuMG7BpP7acUEze9aTz4jzzo1+SVBCxARhLi0LzrU/uof8MAfdG9jgx
        DdpjAfWMwzMKPEoni+g4A15HkRRq7j8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-T9P0zxT8NzGJakVshLzSqQ-1; Tue, 02 May 2023 14:07:19 -0400
X-MC-Unique: T9P0zxT8NzGJakVshLzSqQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-61afc445dd5so18069796d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 11:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683050838; x=1685642838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6mCYnN9DA30kBXb3G+hAjObknC+PiKLk5wLjv+kTMk=;
        b=ZkqxehTJMb1mVJ3/JVmSWNR+TUkqWMGG+LBCZYMIeV/l6rI8QZWjSkT3RmzU5nI3X3
         LOEjQwRfoMLF3Is1iS514v0rXldB3HcenLhNcMYiZC95aBhCBj8VnwsoMK9tbdjWHLJx
         gZU+JHWEQYSF+gfhgrmJfwB/kqieWE8jP08DviEiplMFwTwVLL9whdCzq0+8sO/TQHQ5
         GkYP1W7jQMtndaeo/DB4KVeJMuvRBzBaa2cj+ygqsNPyZR+YHvA30vEvpUzwDQl2i9xA
         v3u00p6dlBsmF9bO7ma+UkuN8J6ZFijx/mAVC6cuSWccHEKjW31gYr1IZpvrjlitF+OT
         jCGg==
X-Gm-Message-State: AC+VfDx5ZIHbGyC734XL8epoAIskWn3dwpbScVBUC0W/OmS0KLFdNfqc
        FzVQSwYWRvnVBtO+Z0GVVeU6FRPtCYG1UFk/Rre4eAK66D4Dp909ab0TuINzyzaeuFFKIfHjwfi
        xsArAkZx21ZneE+XEToJ/6Z1P
X-Received: by 2002:a05:6214:c4c:b0:5cc:e059:efa3 with SMTP id r12-20020a0562140c4c00b005cce059efa3mr7170300qvj.23.1683050838390;
        Tue, 02 May 2023 11:07:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ60IbjRgAV7pfKjXBYm8E1s/ey98/EL5Ltf5kTf0FlgrhKbA+fTrMRqMeiGCtcFDaLjSZ8dkg==
X-Received: by 2002:a05:6214:c4c:b0:5cc:e059:efa3 with SMTP id r12-20020a0562140c4c00b005cce059efa3mr7170265qvj.23.1683050838119;
        Tue, 02 May 2023 11:07:18 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y15-20020a0c8ecf000000b005e7648f9b78sm9626671qvb.109.2023.05.02.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:07:17 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] lockd: define nlm_port_min,max with CONFIG_SYSCTL
Date:   Tue,  2 May 2023 14:07:13 -0400
Message-Id: <20230502180713.2930022-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 and ! CONFIG_SYSCTL
fs/lockd/svc.c:80:51: error: ‘nlm_port_max’ defined but not used [-Werror=unused-const-variable=]
   80 | static const int                nlm_port_min = 0, nlm_port_max = 65535;
      |                                                   ^~~~~~~~~~~~
fs/lockd/svc.c:80:33: error: ‘nlm_port_min’ defined but not used [-Werror=unused-const-variable=]
   80 | static const int                nlm_port_min = 0, nlm_port_max = 65535;
      |                                 ^~~~~~~~~~~~

The only use of these variables is when CONFIG_SYSCTL
is defined, so their definition should be likewise conditional.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/lockd/svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index bb94949bc223..04ba95b83d16 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -77,9 +77,9 @@ static const unsigned long	nlm_grace_period_min = 0;
 static const unsigned long	nlm_grace_period_max = 240;
 static const unsigned long	nlm_timeout_min = 3;
 static const unsigned long	nlm_timeout_max = 20;
-static const int		nlm_port_min = 0, nlm_port_max = 65535;
 
 #ifdef CONFIG_SYSCTL
+static const int		nlm_port_min = 0, nlm_port_max = 65535;
 static struct ctl_table_header * nlm_sysctl_table;
 #endif
 
-- 
2.27.0

