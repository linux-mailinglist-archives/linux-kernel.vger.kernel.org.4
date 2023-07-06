Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C774C749D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjGFNYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjGFNYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:24:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED51FE0;
        Thu,  6 Jul 2023 06:24:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so2924807a12.1;
        Thu, 06 Jul 2023 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649840; x=1691241840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttKtREu8xCq0EEFV7iCGq+Ud9sFqF7ByOvZXs9yYx/w=;
        b=On9VzKHpPKxOaYVKo8Z80brFWSUTyh4J/bIK3E0JRK833IHVGebZHK0CVm4fvKEk21
         hwtqCP6yMGVWBvuWOjDO9SRG0T6lA/cSA6g/3inNBWoZ0jqjgVJrlhX6TKPqui7xUzDp
         AZ3VfUagGhjPE12LKqSM2axddRsr5kcsaYvNKUGPR2VQdjR4bSYenKyFvAqv0nF2TVK/
         zUueeDxqKoiPDzTVjdv2gAvpFjHyEi20zubsYzZYUTM/JwvcbyEJRFbt4OnIXGeJhMzA
         OCiN+7FTH571xyJg0V5jAmeIBMmQza1O5BO+LH2E2GraA+lK5GNlAJ9mF9X633r/Glsg
         42SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649840; x=1691241840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttKtREu8xCq0EEFV7iCGq+Ud9sFqF7ByOvZXs9yYx/w=;
        b=jo8XwlWEwaIkHscWybB1jNk+ZClYT6BcWl25ws+Pg9e6mL3lobeBRoiN0Vj0PFqbMm
         lkz/YYZlNtOSfK8MBpwIU+LfbBVabBU2oeXq0FiR8wwekur/m73TumnD7dJp3qcoW1b4
         ZmdTI0GOh6bHpC75Opu7UJTtiMh3vTm0oROBV6UdIOJlI0J0sM3tU+1bCR4M8LFJcqOE
         EarvDu1XS33+53N0DFydrIQ98tSZXjquwL/2fG2NEZuoqefaaQfbxZwq/vVtm+OuKzsq
         PiT6oLO7tb7uR6ZUUySwpp8hksVxUo7COhhj1Qj3JbEgJF0W6dp+kZOZDM0U7W3OWN7b
         qq1Q==
X-Gm-Message-State: ABy/qLY1y8eU/HRDXjznbEA3SIGZNUDDmm0Ou7q/RunEhf6jX8deT36U
        08yocGAtWeS4On6BF+WWTQPDIJpgvRJRI1ny
X-Google-Smtp-Source: APBJJlFwnSU5ETFSc8+eBv7cUgVbWkIZg4Hg0j7MfYkdB8+36ZdpdbYMmOlllK4BXcg3a7yaK9FBKw==
X-Received: by 2002:a17:906:4fc7:b0:98d:f2c9:a1eb with SMTP id i7-20020a1709064fc700b0098df2c9a1ebmr4961722ejw.24.1688649840250;
        Thu, 06 Jul 2023 06:24:00 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:24:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 16/20] selinux: symtab: implicit conversion
Date:   Thu,  6 Jul 2023 15:23:31 +0200
Message-Id: <20230706132337.15924-16-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
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

hashtab_init() takes an u32 as size parameter type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/symtab.c | 2 +-
 security/selinux/ss/symtab.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index c42a6648a07d..7a77571fb275 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -37,7 +37,7 @@ static const struct hashtab_key_params symtab_key_params = {
 	.cmp = symcmp,
 };
 
-int symtab_init(struct symtab *s, unsigned int size)
+int symtab_init(struct symtab *s, u32 size)
 {
 	s->nprim = 0;
 	return hashtab_init(&s->table, size);
diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index f2614138d0cd..3033c4db6cb6 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -17,7 +17,7 @@ struct symtab {
 	u32 nprim;		/* number of primary names in table */
 };
 
-int symtab_init(struct symtab *s, unsigned int size);
+int symtab_init(struct symtab *s, u32 size);
 
 int symtab_insert(struct symtab *s, char *name, void *datum);
 void *symtab_search(struct symtab *s, const char *name);
-- 
2.40.1

