Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E070B6180CE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiKCPNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiKCPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E081ADA3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667488345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LWgxR1F68mKVnmdpW8+jJqPrx2L99twB8sOEHi9u21s=;
        b=Qg5VK+kJDV1AvuF4vpvSlthMjyXT6t8cYda16ca+QhjIegqF4P1JXO8oqbjL6o9YZu9K9z
        r3lcs2x2BsV9OA7XMfZUzKLJ/A8QdG4Bjnnzp0j1RFEX4qGijU7Dhn80yzuuxhooEggNql
        va55PwRHbcSwecxNgfOEqcjC/NzJ6kE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-N5Bxsbx3Pdm9R1QKpj6-Gw-1; Thu, 03 Nov 2022 11:12:24 -0400
X-MC-Unique: N5Bxsbx3Pdm9R1QKpj6-Gw-1
Received: by mail-wm1-f71.google.com with SMTP id v191-20020a1cacc8000000b003bdf7b78dccso992368wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWgxR1F68mKVnmdpW8+jJqPrx2L99twB8sOEHi9u21s=;
        b=ITyx+C+OltTtzSicDX7itflxPXhhzAylaCyT0eMk8FhSgH4tF7SnkqiLqC+XbMBytb
         wQWl7tkoNLqauerGbAYPYqoxhkpDELTFYPvgGyzef19DYbyunKDppdcbaCDKHmP0YjXi
         5UXuWSP9lMDp8uCv05Wq0LpzkCQ7l3Fr4OvECJoIEi1X8bWQ4AzZweZVcZeO8nGNpmjO
         khnAOJkogdVEwszaBk69sn+3tirq2I0+nc8oC1aonxBjMrBOulIKFUfKnD63FoVLjVPL
         vlrZy699W5T0Ue883bGZ9SkQ1hDtD1PQ/uZ+MEylBhEND8fYAYJLWuT63Y15l2qlirrP
         7y+g==
X-Gm-Message-State: ACrzQf3tjOKMtHw3IQSC8iXCoJI1HF72gdmgZ5n9NapqdGRaJArbJ6FI
        lxD4c2FDMdUDvouR5AXTmIYVGfLwdvi90LvczTP4S20//w574OtonWp2jLvl4UzaKYkWjgX3aoa
        LBGubD3izbb1eQjBLJAtkrbpM
X-Received: by 2002:a05:600c:3655:b0:3cf:7082:dc18 with SMTP id y21-20020a05600c365500b003cf7082dc18mr15530762wmq.36.1667488327463;
        Thu, 03 Nov 2022 08:12:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ux4jknt5HP+aYQrcIxkNpUyABfRNH3oJZnAwXDcMOJ+KB7r/Wfbv+pV7I7knZb9J+AiUzmQ==
X-Received: by 2002:a05:600c:3655:b0:3cf:7082:dc18 with SMTP id y21-20020a05600c365500b003cf7082dc18mr15530746wmq.36.1667488327247;
        Thu, 03 Nov 2022 08:12:07 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b00235da296623sm1104080wru.31.2022.11.03.08.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:12:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Pitt <mpitt@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2] fs: don't audit the capability check in simple_xattr_list()
Date:   Thu,  3 Nov 2022 16:12:05 +0100
Message-Id: <20221103151205.702826-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check being unconditional may lead to unwanted denials reported by
LSMs when a process has the capability granted by DAC, but denied by an
LSM. In the case of SELinux such denials are a problem, since they can't
be effectively filtered out via the policy and when not silenced, they
produce noise that may hide a true problem or an attack.

Checking for the capability only if any trusted xattr is actually
present wouldn't really address the issue, since calling listxattr(2) on
such node on its own doesn't indicate an explicit attempt to see the
trusted xattrs. Additionally, it could potentially leak the presence of
trusted xattrs to an unprivileged user if they can check for the denials
(e.g. through dmesg).

Therefore, it's best (and simplest) to keep the check unconditional and
instead use ns_capable_noaudit() that will silence any associated LSM
denials.

Fixes: 38f38657444d ("xattr: extract simple_xattr code from tmpfs")
Reported-by: Martin Pitt <mpitt@redhat.com>
Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v1 -> v2: switch to simpler and better solution as suggested by Christian

v1: https://lore.kernel.org/selinux/CAFqZXNuC7c0Ukx_okYZ7rsKycQY5P1zpMPmmq_T5Qyzbg-x7yQ@mail.gmail.com/T/

 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 61107b6bbed2..427b8cea1f96 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1140,7 +1140,7 @@ static int xattr_list_one(char **buffer, ssize_t *remaining_size,
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 			  char *buffer, size_t size)
 {
-	bool trusted = capable(CAP_SYS_ADMIN);
+	bool trusted = ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 	struct simple_xattr *xattr;
 	ssize_t remaining_size = size;
 	int err = 0;
-- 
2.38.1

