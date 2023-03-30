Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6440E6D0321
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjC3L2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjC3L2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9A0128
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680175674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mP3bbqGIQpGVaDAwKG9q83wIQ8xRswQTNXCbZ2Tr0P4=;
        b=NGohBcH7pB14hVr263NkZNMDWUo08DP+AqtRhxN//1d9ADtRLY/567Aj1Vpm0YOKZluHVa
        qBwXoxkW1mK4oLVWNEzar70TlGHhsrlfPGtxEfN1Yaesjx1XuHoyHZObXQlWonLfgYbB/K
        rBka/51KnSWbqQfIvpCmHbL7sJh7yZ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-KWPtlg4SOuOgJLMXBjm2UQ-1; Thu, 30 Mar 2023 07:27:53 -0400
X-MC-Unique: KWPtlg4SOuOgJLMXBjm2UQ-1
Received: by mail-wm1-f72.google.com with SMTP id iv10-20020a05600c548a00b003ee112e6df1so9660926wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mP3bbqGIQpGVaDAwKG9q83wIQ8xRswQTNXCbZ2Tr0P4=;
        b=sKgjCg9W7QzlzssIu2s2zo+AZ9Ycw3eEdfIEhlMmG01eKhFQAufFstJvTzmqbaNAwD
         6yfXwja8IJvtj2UxqsS/J9We14dgD+lylvYT8o1vyM35nA6m1kfguMLwVnha4L+J/zY8
         nF3UNZBTrbVbzTVdCX/9cLqVC+wyA8S0uJytbrpqvSvbZwuldi7qJVMhJx5gp0OHu336
         rY1qW7FdFucsYe3YoImDSsajz1RBXeBJ7ksqrzr0onmpUEypxyyQjItm/b6G6KZRHpB+
         yQiARPoGB5v7IIOJyvmaTxk8vNga4Em+Hjirx3l8242bpCdCKOnCP/4+hopx6+1anXkJ
         nAmQ==
X-Gm-Message-State: AO0yUKVLaOlyQMOMAmLDCNVp/nGbos+ljb6odlNXcROlBoKShCfgiebh
        +AIRB0eRqN9AJccP7dgnPWoPgYlzUYGTOTiCg00cgut/C6Z2WA6LgeLiwsHPqj87uEEvcxqNpMl
        QHo8i/W1oiIELFjCBBbVDzHASFfprhMTyp/pmqxvQ+L1OCcDZzbsE64td6UcvxwxcYDYgotI1ao
        awHP2Ubok=
X-Received: by 2002:a1c:7714:0:b0:3ee:3f7:35aa with SMTP id t20-20020a1c7714000000b003ee03f735aamr19451872wmi.19.1680175672369;
        Thu, 30 Mar 2023 04:27:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set+jEH09nINjs+jtTwMM7aUYIujL4lWIxtVBADGTYrhVrSQ7/64CBx3dKj/4yxcO08CjwA5IMA==
X-Received: by 2002:a1c:7714:0:b0:3ee:3f7:35aa with SMTP id t20-20020a1c7714000000b003ee03f735aamr19451843wmi.19.1680175671968;
        Thu, 30 Mar 2023 04:27:51 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f18-20020a1c6a12000000b003ed2276cd0dsm5510940wmc.38.2023.03.30.04.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:27:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        kunit-dev@googlegroups.com, Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH] .gitignore: Exclude KUnit config dot-files
Date:   Thu, 30 Mar 2023 13:27:42 +0200
Message-Id: <20230330112743.2331141-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a rule to ignore all the dot-files (.*) but we want to exclude the
config files used by KUnit (.kunitconfig) since those are usually added to
allow executing test suites without having to enable custom config symbols.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 70ec6037fa7a..7f86e0837909 100644
--- a/.gitignore
+++ b/.gitignore
@@ -103,6 +103,7 @@ modules.order
 !.get_maintainer.ignore
 !.gitattributes
 !.gitignore
+!.kunitconfig
 !.mailmap
 !.rustfmt.toml
 

base-commit: ffe78bbd512166e0ef1cc4858010b128c510ed7d
-- 
2.40.0

