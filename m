Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89276F504F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjECGo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 02:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjECGoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 02:44:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9882684
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 23:44:51 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4FE933F447
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683096290;
        bh=CbwPmz2P7xN6zL203S8qJj89Z+3qclxrXH5+1gyHu6M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RP4Hj07Q+h+6qwaOeQjcOHQ9v0gucSGQI4DwhYMtYrYcXieBjmT0ACxu26i5KzM0m
         XgWdHPCateKotvoDWrIUUrBkWiPfhlwN/cUgBA6YUxK8EPS1wGVe9nmaQH+rRzY9+5
         8ZJI3kkB83xTvvW9hwY9grTUY8EMdV6y+3xUviw4/A4LB+BaLiYgRv4lsMn6oo+4fm
         50CDcHOb2TpQnY2vjnUZUW57RjYEIqXCW8HzVQ+dDtzbrAIPZk9jb58+Sm2oYL8hVk
         kR1/O/+AFuiniDJqhY4tSOVscOhSvMgfECud5qJEwrw/4+y64wDrj/JMDVv8wdvDdQ
         ivFNk3oAWjmdA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-95376348868so574665966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 23:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683096290; x=1685688290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbwPmz2P7xN6zL203S8qJj89Z+3qclxrXH5+1gyHu6M=;
        b=PaeMkzs+wfBqCjm+c4MBCVLVzEK+49tE02nvZWOWqu60kQvKKfhOXFSQyYKr/azVSb
         bufeuKxNfTaXqpTLFlJUsgu/DcWk43qJ6UlNuBKlQhhyw4gkN21VdXu8y2zD9vVrVUyW
         ywSuv26Sw0yA+enlQKR7ZYIRAIWGXCLhf7TXytJ3btWZREF63g1TtTw6/klIhihl/N2b
         LZfGL+0wCjJMcYkGpjJCE6xS1qf5VhHrJFyQ0ItFknLrIMe/MLiCrWvWN2B4i/lpZ/dk
         wZO0/Fs0QJi0Krtk+tDByru+QHieOni2HOxqwE3UdPwisiwTuIdHFjijX9yXGhj5rwD3
         SM0Q==
X-Gm-Message-State: AC+VfDzVnVknVXDWVU+3zRfVZeBH3eHsAbzaYc+IRc9uEfA5X9QUc9y7
        /5o3262Scq9OnnmO0D5fXUgBeBn8MNGAqZ6fJuaqKQ1Hgr3mabKERT3qo+0qxq9Be8WpTyOnjm3
        Xyt75KZ8PBAm+Iwjx1s8zlKef9NoIgK1TSfhYQ8LqoyiltApXNulB
X-Received: by 2002:a17:907:6d8a:b0:92b:69cd:34c7 with SMTP id sb10-20020a1709076d8a00b0092b69cd34c7mr2010526ejc.40.1683096289818;
        Tue, 02 May 2023 23:44:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7skTmNTqRCqW6NVDyn9k/KK96LA43+EPzYgWnzw0kkpsf5ycBgKL5hiFmzoK2GwNnHlcUeIA==
X-Received: by 2002:a17:907:6d8a:b0:92b:69cd:34c7 with SMTP id sb10-20020a1709076d8a00b0092b69cd34c7mr2010514ejc.40.1683096289565;
        Tue, 02 May 2023 23:44:49 -0700 (PDT)
Received: from amikhalitsyn.. ([62.168.35.11])
        by smtp.gmail.com with ESMTPSA id e6-20020a1709062c0600b0094ef2003581sm16831270ejh.153.2023.05.02.23.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 23:44:49 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mortonm@chromium.org
Cc:     penguin-kernel@i-love.sakura.ne.jp,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] LSM: SafeSetID: fix UID printed instead of GID
Date:   Wed,  3 May 2023 08:43:44 +0200
Message-Id: <20230503064344.45825-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_warn message clearly says that GID should be printed,
but we have UID there. Let's fix that.

Found accidentaly during the work on isolated user namespaces.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2: __kuid_val -> __kgid_val
---
 security/safesetid/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index e806739f7868..5be5894aa0ea 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -131,7 +131,7 @@ static int safesetid_security_capable(const struct cred *cred,
 		 * set*gid() (e.g. setting up userns gid mappings).
 		 */
 		pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
-			__kuid_val(cred->uid));
+			__kgid_val(cred->gid));
 		return -EPERM;
 	default:
 		/* Error, the only capabilities were checking for is CAP_SETUID/GID */
-- 
2.34.1

