Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC97647C23
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLICSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLICSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:18:48 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98012389E3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:18:46 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d3so3400214plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYhgDtLT1/+lNjUBnC/Tj1FN4K09VPMmhd3xjWRLpKw=;
        b=INBjSokBRTZXwnjY8FPZjRqY1Z1YHJju1JFvVAqCrHYCJqo5uwBh4QvbRcLhqigpJ6
         Cqp4y3WZVTtFFczyzzCpHbUbX0I3sne9HmblMvLECuo3k3YXi25ujSP9J1cjaoHVHCtt
         fv8gvqKzPYRPL0C6VKiO75du2I0nAcRV5tsRKmayyVrDCRvvp9fJU5Ro6IvgyCuJQu9h
         zrfbxKkgW3nBDQB+j1IlaqNGBHUk4p+S50JvsiDo0Etj/289PWo69PFBabIYPdqG4w7B
         p2QVmE9xBv4T5tgoc0CiB949I2nhlhPpSJi8R//IknlR01jM8CFXxALDWsX8ZPYaUpwq
         ifdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYhgDtLT1/+lNjUBnC/Tj1FN4K09VPMmhd3xjWRLpKw=;
        b=18DD4N1n1PJWtSEzV90A0BzoNW2HzhXrNQDPhcCr7lb9STdKT9MT8WqjiXRWCAFfFn
         N2bhbPMoco/bqkSdbb020ID839XNCK46Jm5WWDW0odrwm22KaIftXCvEwWA09Ky2RnD5
         dfL3dzrGr5DWYlYCloRArvrLHbCv7ucllSRL7MUtjeJF0kNUU2n8KnQk3CD7eQZGOHFZ
         IMxKZan22PQiiXqsdccy26p471mXV7J2GJOGHpPpOz2kYPWnbk1bcAMtHN4+6HxvCzJC
         7mk/VrXdb9ZCWAzjmmI3qMzkGm2nssyW+YgEgTyS0/hB1njjAkXABJXVRUfeU50DqfQw
         IDHA==
X-Gm-Message-State: ANoB5pnYnDX2VPpNZkmhJ37+itwf7ZVpc3GRISgOyrAmFwGVw7cDXUVG
        +8Wl3i4/onu3JdfeJCdTLKY=
X-Google-Smtp-Source: AA0mqf7XtpDQyJSsGJrWNXVf4Jt7ySISaZ5hMQJMkCyjLXHGMnGhzg+b6MJRFh29YYFJCZ8jRuFCEA==
X-Received: by 2002:a17:902:e8d8:b0:188:d405:63c0 with SMTP id v24-20020a170902e8d800b00188d40563c0mr4022098plg.6.1670552326276;
        Thu, 08 Dec 2022 18:18:46 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e283-776d-8739-aa48-f251-9f2f.emome-ip6.hinet.net. [2001:b400:e283:776d:8739:aa48:f251:9f2f])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902779000b0017f5ad327casm116249pll.103.2022.12.08.18.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:18:45 -0800 (PST)
From:   Matt Jan <zoo868e@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Matt Jan <zoo868e@gmail.com>
Subject: [PATCH v3 1/3] staging: vme_user: add the spaces around the "*"
Date:   Fri,  9 Dec 2022 10:17:54 +0800
Message-Id: <20221209021756.5597-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Add a space around the "*" at vme_bridge.h to clear up a checkpatch
check.

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---

Changelog
v2->v3: Resend the patch set in properly threaded and move the patch
		changelog to correct position, noted by Greg Kroah-Hartman
		<gregkh@linuxfoundation.org>
v1->v2: Resend the correct patch set, noted by Greg Kroah-Hartman
		<gregkh@linuxfoundation.org>

 drivers/staging/vme_user/vme_bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 0bbefe9851d7..e17a8f7de165 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -4,7 +4,7 @@
 
 #include "vme.h"
 
-#define VME_CRCSR_BUF_SIZE (508*1024)
+#define VME_CRCSR_BUF_SIZE (508 * 1024)
 /*
  * Resource structures
  */
-- 
2.25.1

