Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1E6F24EC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjD2Nqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjD2Nqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D4198A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682775966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MrC2Plo9OYii15Nm2M6PoTQXMjK5jmikMyISz9U2Pqs=;
        b=TaNLNtMZPfigJq5sLxNTq1q03J98rG/iM2TmZP91dTbstJXwc/1Jn16bs6FdRRPGBWUktm
        3ZgvIXkDc+ExaNUQzSUbGt0U8KrefLklVkVfl14qRUZn1dVsdad0P4ifJTzqv0LOX+X+E4
        ps12EFg7uWDaHk9GivDgP2v+ZP6a1Bk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-HEtbNlR3MnuGpU46vAcXdw-1; Sat, 29 Apr 2023 09:46:04 -0400
X-MC-Unique: HEtbNlR3MnuGpU46vAcXdw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5ef65412174so5745556d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682775964; x=1685367964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrC2Plo9OYii15Nm2M6PoTQXMjK5jmikMyISz9U2Pqs=;
        b=jELmADicxAxUhnAc17HgidXGsLS/fsIvXNZ78WP1gPF1Zq26eD/38O32Bk6ZGlud0E
         iwePL0N5T+reOJhIfAT5g1s25yJFbt8MlwcMHpnlnfsrI+mz8clLhRt3aoyhS/6yDtnZ
         /CFOoVZ86hA3ldG7gZ7pVEypSvikGd4aOwz9x+XZjCLoUtDK17+vpY9AgLjcab+3Ek26
         8jIhsZla8i38vej9H+O5RRUGkmzwIUhK0ZiWke+NLYGjbcUbLbII4MnpiwoEXgOVbMK2
         pICbTIGaGeRNZuNGNl3jcTAzYFNoBZSKsQhHNwi876mYY+uIffoJX3YKx74EhoVgjWA9
         1EvQ==
X-Gm-Message-State: AC+VfDzty7mNoL7oTlKfuQTjYBuo8zFAwm1/XsDtKb1gc5GojbzgPw4s
        FchUns4Y9p5/L2ojFkKWEBcAAQfPe6LjN3GcNzG3MT0ziMdul1Y8YcHwdnlUsvhprp8D+LuOcdn
        w0i2py351pG/vgweLMlcJVwKRbro+RXyJ
X-Received: by 2002:a05:6214:23c9:b0:5ef:a5b5:5b99 with SMTP id hr9-20020a05621423c900b005efa5b55b99mr15853603qvb.0.1682775964163;
        Sat, 29 Apr 2023 06:46:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49CsiS83CUAu+aC5eNde28TyzbGRWjnbNx01U3hlQtODmk55RuB0tMAIfLw0kfaG9RSSmiNw==
X-Received: by 2002:a05:6214:23c9:b0:5ef:a5b5:5b99 with SMTP id hr9-20020a05621423c900b005efa5b55b99mr15853582qvb.0.1682775963891;
        Sat, 29 Apr 2023 06:46:03 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i7-20020a056214030700b005eedb5cebd1sm7112753qvu.130.2023.04.29.06.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 06:46:03 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jk@codeconstruct.com.au, alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] i3c: ast2600: set variable ast2600_i3c_ops storage-class-specifier to static
Date:   Sat, 29 Apr 2023 09:46:01 -0400
Message-Id: <20230429134601.2688558-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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

smatch reports
drivers/i3c/master/ast2600-i3c-master.c:121:34: warning: symbol
  'ast2600_i3c_ops' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/i3c/master/ast2600-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/ast2600-i3c-master.c b/drivers/i3c/master/ast2600-i3c-master.c
index b72c12c5168f..09ed19d489e9 100644
--- a/drivers/i3c/master/ast2600-i3c-master.c
+++ b/drivers/i3c/master/ast2600-i3c-master.c
@@ -118,7 +118,7 @@ static void ast2600_i3c_set_dat_ibi(struct dw_i3c_master *i3c,
 	}
 }
 
-const struct dw_i3c_platform_ops ast2600_i3c_ops = {
+static const struct dw_i3c_platform_ops ast2600_i3c_ops = {
 	.init = ast2600_i3c_init,
 	.set_dat_ibi = ast2600_i3c_set_dat_ibi,
 };
-- 
2.27.0

