Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D2B6FF198
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjEKMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjEKMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:33:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7737293F4;
        Thu, 11 May 2023 05:33:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so13019291a12.2;
        Thu, 11 May 2023 05:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683808382; x=1686400382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1HnU7hHqbTpTiFx0D4GmXFi6g1csMfXh2pFRmqf63Q=;
        b=cZOkZddVd06q0IYtPQjNvERik5w+80yb6gfW6TPrOrwznxgHEEZgC4SocVmagWAdxb
         eZdcQwGi4lch1wKUmPdKMv4tAbDXvPO1fFAXO1Xqh2lO3AIUUpUPC70b/eFZQ4vjXC/k
         Z/h1oA/vdZvVYjPlNWRZ7ThNRzdyuqmpPRIr8YmojTn4Qh25tGvkFvrIlhn70W4FoMvW
         KuVuAtDuAKnEltwY4GQ4kbrXIyhHnbybA1iYLv8qsr1dSELGyWWcDauyJOhyD8nKTvE7
         4zzEx2aM53p+TyrAv+9gF6Map+JhEgh55wsTYriqMLmLe20hfp2bG3E3Z06xlrBmwEEr
         j5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683808382; x=1686400382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1HnU7hHqbTpTiFx0D4GmXFi6g1csMfXh2pFRmqf63Q=;
        b=dYf9cQDLjswyRAhn7zD0Qu/SQqHDd6f4/1qE4Lz9PALPZSwnnybROeLCV9JJPJMCcd
         Jf09qHGT/qtFqlV1XFvdoMdZ9dyI2XRwNAAko33a/+o/IlU1lGq9j51CX+FPpCFP6oYA
         /nxLoMIhJR1sW39hB7NX+TAw9nw0H32/Jo1ANu58S/3sqxS6IBZZAbLl+irUrPEUs4cI
         JftQ55deW6sOCnaYh9qi0y4HWp3f8r5Otc1TuEVVEAuYlD6PzPRzKXjnNW0b98CVOPp5
         1i/7wKiVw9K3qrw8nUzD4nKK+KPzdOyV1CAF6jY2Vsl7BGav34VfIPYtKCAebfSbE1Xt
         ZI0w==
X-Gm-Message-State: AC+VfDwOZdXGAJ6xHHRV4NVTK/SEvC1T4R1LJs7blxMoFB5/CFenGMis
        5u1Sd29x0tGCKl5uvuXjuRKmhEyw6VUetw==
X-Google-Smtp-Source: ACHHUZ4RhLm/85qEFAJSfeTkxZQiCvA9R35mMVU82bid3wS2Hw3iIXntAX9PvWGjM5zEmZdBdUqfnA==
X-Received: by 2002:a17:907:1b17:b0:965:6075:d0e1 with SMTP id mp23-20020a1709071b1700b009656075d0e1mr16727032ejc.72.1683808382331;
        Thu, 11 May 2023 05:33:02 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id mz11-20020a1709071b8b00b009603d34cfecsm3908638ejc.164.2023.05.11.05.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:33:02 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security: keys: perform capable check only on privileged operations
Date:   Thu, 11 May 2023 14:32:52 +0200
Message-Id: <20230511123252.723185-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the current task fails the check for the queried capability via
`capable(CAP_SYS_ADMIN)` LSMs like SELinux generate a denial message.
Issuing such denial messages unnecessarily can lead to a policy author
granting more privileges to a subject than needed to silence them.

Reorder CAP_SYS_ADMIN checks after the check whether the operation is
actually privileged.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/keys/keyctl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d54f73c558f7..19be69fa4d05 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -980,14 +980,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	ret = -EACCES;
 	down_write(&key->sem);
 
-	if (!capable(CAP_SYS_ADMIN)) {
+	{
+		bool is_privileged_op = false;
+
 		/* only the sysadmin can chown a key to some other UID */
 		if (user != (uid_t) -1 && !uid_eq(key->uid, uid))
-			goto error_put;
+			is_privileged_op = true;
 
 		/* only the sysadmin can set the key's GID to a group other
 		 * than one of those that the current process subscribes to */
 		if (group != (gid_t) -1 && !gid_eq(gid, key->gid) && !in_group_p(gid))
+			is_privileged_op = true;
+
+		if (is_privileged_op && !capable(CAP_SYS_ADMIN))
 			goto error_put;
 	}
 
@@ -1088,7 +1093,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 	down_write(&key->sem);
 
 	/* if we're not the sysadmin, we can only change a key that we own */
-	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
+	if (uid_eq(key->uid, current_fsuid()) || capable(CAP_SYS_ADMIN)) {
 		key->perm = perm;
 		notify_key(key, NOTIFY_KEY_SETATTR, 0);
 		ret = 0;
-- 
2.40.1

