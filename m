Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFB668B03
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjAMEtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAMEtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:49:18 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A37D5B149
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:17 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id j9so14200693qvt.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RK7kwtLoTwXiQFYRKLpCqcerUjpCY+ogtPq7BCj8+Hc=;
        b=qIlrOw+9p5xPgPCq1YNGHwqIEgQIf/DgPOyvmzsar4YJ9G5sfVEvxYZKfHNF4TQlXi
         jWiFvLk1mUXDR7jV+h6izxD02BdDrxm3+JykT+7Mhvl6Wo9cwfp1LSd2RkT34oA/GtpR
         IQbRWWBtBLVpDj2uVEac5zh4zg2u2X3i/XBLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RK7kwtLoTwXiQFYRKLpCqcerUjpCY+ogtPq7BCj8+Hc=;
        b=NhZER6dbdClj4RT9FQmcExrRKa2Ysgm2f02lDWel/sgYIX2pjJ8ssWtjl0vXUyfu0r
         JKnmLHE2fB8fOFup2rM+EwFXkG3a33RdMv6b/ND93tO0StzkBkA0J7aom+u7DNutxtNH
         Zpc1dB5+PygBvQxvyMk1Lgho5i5eAYD3C4oUwwRAavxSNImNNNaiE/xdNpG4JHmkx8ke
         b4daCRMnLwa8z1p84gmBF+E+HRrkxifdQWkOCONItbfIRRHMyzQygcYd+ZtPK04J+Xsg
         pZN6AWZl7Vt18FTB7QqBNpcmyrHXXlt34fsNUmXKYlUJ3lUJMNkM9sq+qYXMECiukhIT
         h4NQ==
X-Gm-Message-State: AFqh2krkFMQMq5NRbEdXUsh96Nb9ab2Qf8Ltv0n8GdOoBvIkaHDyH+r2
        5XOoAdGgL1xWJWC8agGZOliBaQ==
X-Google-Smtp-Source: AMrXdXvhcCBymtegmA0hJJTKnIFA4a0V7g7Xo1HJuf4+3ZsSmCtYNvt3OYiufYaE9/3b9c4dUtNBWQ==
X-Received: by 2002:a05:6214:5811:b0:532:2daa:eb0b with SMTP id mk17-20020a056214581100b005322daaeb0bmr24788992qvb.41.1673585356388;
        Thu, 12 Jan 2023 20:49:16 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm12099472qki.73.2023.01.12.20.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:49:16 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Thu, 12 Jan 2023 23:49:09 -0500
Subject: [PATCH 3/4] um: Prevent building modules incompatible with MODVERSIONS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230112-um-v1-3-6bec9e97ad13@pefoley.com>
References: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
In-Reply-To: <20230112-um-v1-0-6bec9e97ad13@pefoley.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673585354; l=1046;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=FK3QdJgb2KG4YuegWgxOs5tSOgx0C0ibecAQpmjyv/4=;
 b=IGNaz9VC2rw8NP2KkkaEAY4fe7KpAqDmWHvDImkLzXWrJl+aSMWsOUVNlSoMzxdCgVnz5Ydz8wb3
 0g4oXSsQAU8n9zrUnEZHnK3Wm14IJuXioSKD8EoQjn0crlRzH+Pu
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manual ld invocation in arch/um/drivers doesn't play nicely with
genksyms. Given the problematic modules are deprecated anyway, just
prevent building them when using MODVERSIONS.

e.g.
MODPOST Module.symvers
arch/um/drivers/.pcap.o.cmd: No such file or directory
---
 arch/um/drivers/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index a4f0a19fbe14..36911b1fddcf 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -261,6 +261,7 @@ config UML_NET_VECTOR
 config UML_NET_VDE
 	bool "VDE transport (obsolete)"
 	depends on UML_NET
+	depends on !MODVERSIONS
 	select MAY_HAVE_RUNTIME_DEPS
 	help
 	  This User-Mode Linux network transport allows one or more running
@@ -309,6 +310,7 @@ config UML_NET_MCAST
 config UML_NET_PCAP
 	bool "pcap transport (obsolete)"
 	depends on UML_NET
+	depends on !MODVERSIONS
 	select MAY_HAVE_RUNTIME_DEPS
 	help
 	  The pcap transport makes a pcap packet stream on the host look

-- 
2.39.0
