Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C470973D2F2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFYSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 14:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFYSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 14:21:22 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1D91BD
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 11:21:21 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9B7D43F1A0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687717277;
        bh=wxjGe/lCblUrN68a4XQN1nsTtxNGrWMej+sIZU4igV4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=FUJVrFFluUJSBD3IgKzYODyyNRiYQBFySpg/i5QzgHxDq6WQdoawXWQWOmDk7xoWy
         OiPQzKSO4p5clbMrypuOfc4lCycUzMS6azxOnJW4RzPmhf2HVHt1sjm/ttzvK1wexy
         VysW8XOv4k8Wj6UV9w+vBtzGRFzxgko5XUC+QhAShyjb+xyEXt+V0yR7oTTPvr77Df
         6+Syp94wNP2rAui7cZxBGVGWraRILY9xrrKtBE7pUtyJ0mJG2fJNwQsW9dSpx83hHk
         hDDhcX5JWR2T9sHFiXJJnRWvNghVZn8GEkKmWX9hINl2LgEknWVADlzE3rERqZScV5
         ZjPhVEiOBhC5g==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3129750e403so1631873f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 11:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687717277; x=1690309277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxjGe/lCblUrN68a4XQN1nsTtxNGrWMej+sIZU4igV4=;
        b=GqNJ4pRgg4kBcwOcw+4TUV79kttBagsnxSDfQBsJhGiIusaOHGu5M4oybJD6dT02uh
         WglOQE9Tvpwq8jqQDe98dP2FMBE6gxpR2HRiLFsEv+Z2gyVbNJglDDPfOiVFlJ7FAZF1
         EXr1dlTI+15VFi6kcCPL8pqXr+o3cOKxrdt+RA/JzcdSoACkfqqe/gUr/q0wiHYomH4p
         EhrwQuI6Htm2n5X7iPh3x+4ryQqc1644pqJ3WAxdW8Q4TdTsWqWNPbWbfd72v68Sto/E
         ZFGgSxbLevlxHGqMSBW0B8BaNeE3m99FLTAPxDygAPHfiXV7HUU/cBUf1Pm6zxJYefhs
         iazQ==
X-Gm-Message-State: AC+VfDw2HvqS9qC6eEE5Ta15yv/DtnlvvZZvYJJ8z90YOPPGL4pP6tQX
        aZdS/dwaTrxKZH4FunkeRWGhf9h5TVZ2IroMdWcie7aJogSqFmphMqUqOf8ZgA83l6S4fSaVGXW
        wSTGYH+y8QrY+UhXHHnG9EGK49FGbAaQd5qwKdW5WGQ==
X-Received: by 2002:a05:6000:128b:b0:313:e355:3882 with SMTP id f11-20020a056000128b00b00313e3553882mr3748695wrx.44.1687717277250;
        Sun, 25 Jun 2023 11:21:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6S30lL42ngZfRs+yinpa3JZs4sM3LVRhFsZUquMzyoXVAp6yKc2+J/eKRyo5ftDBg6DZwYnw==
X-Received: by 2002:a05:6000:128b:b0:313:e355:3882 with SMTP id f11-20020a056000128b00b00313e3553882mr3748675wrx.44.1687717276747;
        Sun, 25 Jun 2023 11:21:16 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm5190381wri.73.2023.06.25.11.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 11:21:16 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: filesystems: idmappings: clarify from where idmappings are taken
Date:   Sun, 25 Jun 2023 20:20:47 +0200
Message-Id: <20230625182047.26854-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's clarify from where we take idmapping of each type:
- caller
- filesystem
- mount

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- fixed https://lore.kernel.org/oe-kbuild-all/202306252253.qxHG1txo-lkp@intel.com/
---
 Documentation/filesystems/idmappings.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
index ad6d21640576..f3d168c9f0b9 100644
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -373,6 +373,13 @@ kernel maps the caller's userspace id down into a kernel id according to the
 caller's idmapping and then maps that kernel id up according to the
 filesystem's idmapping.
 
+From the implementation point it's worth mentioning how idmappings are represented.
+All idmappings are taken from the corresponding user namespace.
+
+    - caller's idmapping (usually taken from ``current_user_ns()``)
+    - filesystem's idmapping (``sb->s_user_ns``)
+    - mount's idmapping (``mnt_idmap(vfsmnt)``)
+
 Let's see some examples with caller/filesystem idmapping but without mount
 idmappings. This will exhibit some problems we can hit. After that we will
 revisit/reconsider these examples, this time using mount idmappings, to see how
-- 
2.34.1

