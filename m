Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533456F2C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjEAC5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjEAC46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB3419D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 19:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682909767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P71hh1hVX94ThG5yTOof07dnMP25hXjA33Fj1bRqY+8=;
        b=MTdAEWV1pOEGwpMUvVFulKRazUa/bi4k9+6kiXB+lZbnaLVEYg/7SsHEUQUKXxz8rKx68v
        2zEeA4ItZ84XzG9/yYrsqLrAfMJxDQ3kx2tuv1266gSfhR24EfAtezbI9zedqnCNSnc3Pf
        GMXAD5errsZyA0JYMTJsD4att+rN0H8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-A5AJ4H1zNJCReyvgn4rlOQ-1; Sun, 30 Apr 2023 22:56:05 -0400
X-MC-Unique: A5AJ4H1zNJCReyvgn4rlOQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ef65714d24so27614331cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 19:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682909765; x=1685501765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P71hh1hVX94ThG5yTOof07dnMP25hXjA33Fj1bRqY+8=;
        b=bPqdPDRM67IzeTXFyWauFKgZC5P0juq40XM4brZh4tvoJp0E8GqM9KSOkKNpFYto0O
         0lwtWKC3hlFnPRRlArRkwYVQ84triBFVQsxSQSJoPWoPO4BC9GRF3WEIkCjA0fKH9d8u
         IP4FnpTBY2CaA99lYy0LSY911yeVkZ6ywqJLpw3gp6AlYrDhQWge9FA2VYodVClnRmEN
         bh2uOd7DpkLixvlUk7mbwen1RxJcHekckV2j+SySFulePa7kSMX+BvyNM98loiOlv1Bc
         BUmflaXup6PjW6Fkbh2u6gz2776dkBlzDvwUDU0dEdyu83Z0YsKZGQqiqSI4nS2/zIwX
         6t5A==
X-Gm-Message-State: AC+VfDxUFn8GWHKSYRxpX3x81X9ZSCMB0JabajKIjPtavgxIhvJcvdnc
        qw+nNEOn8E9ZvtFYHALiC3DRoFv7M5S4tELqwWR4+o34JWr63abl3h5RErLL91OICrF/2TxgAaK
        PJ20Te7xEU+ipaZinWxK1bDhv
X-Received: by 2002:ac8:5dd1:0:b0:3ef:54c9:9869 with SMTP id e17-20020ac85dd1000000b003ef54c99869mr20599171qtx.31.1682909765217;
        Sun, 30 Apr 2023 19:56:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62YgtU1mxsZmkSlSss9+q+sO2G3Y4kjPIDvU2+bP5ieOPhlyiMmbSysV2BD1rj091m1GXrjg==
X-Received: by 2002:ac8:5dd1:0:b0:3ef:54c9:9869 with SMTP id e17-20020ac85dd1000000b003ef54c99869mr20599159qtx.31.1682909764947;
        Sun, 30 Apr 2023 19:56:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x8-20020ac86b48000000b003e39106bdb2sm9062696qts.31.2023.04.30.19.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 19:56:04 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] tty: define hung_up_tty_compat_ioctl with CONFIG_COMPAT
Date:   Sun, 30 Apr 2023 22:56:02 -0400
Message-Id: <20230501025602.2905173-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc reports
drivers/tty/tty_io.c:446:13: error: ‘hung_up_tty_compat_ioctl’
  defined but not used [-Werror=unused-function]
  446 | static long hung_up_tty_compat_ioctl(struct file *file,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~

hung_up_tty_compat_ioctl is used conditionally with CONFIG_COMPAT,
so it should be likewise defined.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/tty_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 553182753098..7fe404d56ce7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -443,11 +443,13 @@ static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
 }
 
+#ifdef CONFIG_COMPAT
 static long hung_up_tty_compat_ioctl(struct file *file,
 				     unsigned int cmd, unsigned long arg)
 {
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
 }
+#endif
 
 static int hung_up_tty_fasync(int fd, struct file *file, int on)
 {
-- 
2.27.0

