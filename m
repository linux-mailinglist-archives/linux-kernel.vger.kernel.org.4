Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6A6FF18A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjEKMcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbjEKMcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:32:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192973C39;
        Thu, 11 May 2023 05:32:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9659e9bbff5so1559402766b.1;
        Thu, 11 May 2023 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683808320; x=1686400320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Uu5ruPXtdkWJNm3pGozn9KwxFsClD+TD7ca8ZM3nX8=;
        b=c1rX78gOZvD1P9gtxXqsDNlehTS5/8+DamhUELsnNLUBsEGR9IkcilNrWgO5kWlYjk
         Qi3hQ9Jo1bEuVWJx2NlNXFaCDFdl7lARcAMJl8UyJCA9+ITcEKnXxs5NdQ71wiQTALQH
         GLW153SdrHnTs9vC6rvts+/tlufwdLvhWo/n2+4kPxKUVDdhrd8JGQzadWadrzcztVBn
         I2i8vCQDoqZ8Ehry1PxmyNxJuiLUofesP8lxJxv/lVsb7i6X1wbGk3p3aB2oI5W8zsTO
         Snx7RrhreYN6b/2WH6pbi+UqK68il8VKQCBpYlN20kL1z35Uz9VO/Q/RQetDGU3/GkS2
         SDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683808320; x=1686400320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Uu5ruPXtdkWJNm3pGozn9KwxFsClD+TD7ca8ZM3nX8=;
        b=ShznfxdvsPA6TjmB2SHrgb5ogLTkc4d6WomZhHbOdx5xQKquOcYx5DWgqNKdpYDZaV
         9B2Jash8sGcS8FBklKEXB5VzIZZUb5womJddxKPwv2M4ybpZN+W0QuY24YP3PmaBRHt8
         IAh5MmAH//GugaidEsoMoxU8FAZvzotwe5MADoNpCjqlgu2kmabc3I3DJdPcKUxS6BwO
         SygQXcUM/D+8OdsALqTXzukFul6kY/2R9gMQdbZnwS/JKN8TRlayw4ylfET4aS238ChL
         /2IgMQwaZuK8eveOFKIu6TY15ZtmFiO+HMjWjXukUatV2Mx6g0Ti6yK8lFUGZlRUF1sk
         Cb0g==
X-Gm-Message-State: AC+VfDxtmi0oqVUXRRsRCpsXfsKi+7ENBUndlKeDjm98s5MBUZd1oBNN
        vM2df9wyLLu3VlrORvit6V/pcDjksAY=
X-Google-Smtp-Source: ACHHUZ6dWAPt3PgilphgQSXnuTStCAkA/S5A9fBEvtvSV1jvugKMyugmHNJrYt/NHox86F8uWN/VBw==
X-Received: by 2002:a17:906:4fd1:b0:96a:57fe:3bfb with SMTP id i17-20020a1709064fd100b0096a57fe3bfbmr2346619ejw.26.1683808320278;
        Thu, 11 May 2023 05:32:00 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709060f4800b009600ce4fb53sm3906639ejj.37.2023.05.11.05.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:31:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: keep context struct members in sync
Date:   Thu, 11 May 2023 14:31:47 +0200
Message-Id: <20230511123148.722343-1-cgzones@googlemail.com>
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

Commit 53f3517ae087 ("selinux: do not leave dangling pointer behind")
reset the `str` field of the `context` struct in an OOM error branch.
In this struct the fields `str` and `len` are coupled and should be kept
in sync.  Set the length to zero according to the string be set to NULL.

Fixes: 53f3517ae087 ("selinux: do not leave dangling pointer behind")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 44179977f434..aed704b8c642 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -168,6 +168,7 @@ static inline int context_cpy(struct context *dst, const struct context *src)
 	if (rc) {
 		kfree(dst->str);
 		dst->str = NULL;
+		dst->len = 0;
 		return rc;
 	}
 	return 0;
-- 
2.40.1

