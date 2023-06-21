Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0173796E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjFUDBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjFUDBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:01:14 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717A19B6;
        Tue, 20 Jun 2023 20:01:07 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-340bba768acso26378875ab.2;
        Tue, 20 Jun 2023 20:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687316466; x=1689908466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i3TwOUjrba6y/sZ16lkUZi/PKa7z6zduQ0cJPwPLqg=;
        b=KzJ4T/HpsfXuydpnH5TcpZW3RZy68kv09P93asfMP/FwSRCRDaCrwxIyh/j24Dfq0+
         xAnYbxEhSYfYilQOdTz6isg3cTnormzf2gSO8/Py5wuEmTOZ9lx6B977xnnpcI0VW67j
         gvPsQNS/NEu1LKWiPN/K/ZLNEJlSSh/VjHcdsZyKHMhQnbbScUTcjgosvYccUrfeS3S2
         QRQoEumHUPnUBYHzTboO5XL3qgQOh8O6I5/hzQJpmatN9lgYSYcMAQH4PeRicSzkvWnY
         MGLTNQZrLXr7SHhMREY3cWf30rUzrYahIBq8xx9yHp5jbHIalORjY5K+5LMkCAoJ1a9S
         0KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687316466; x=1689908466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i3TwOUjrba6y/sZ16lkUZi/PKa7z6zduQ0cJPwPLqg=;
        b=h9w6jt9sNLM69dHENyihm+HPO4innwu/3QAUBsrEhuPHVpb0tfCw5Qn1dY9PpBdCsc
         UU7LsFn9A8oH6p7DZJDKliP6HAZQYNWSYC2Jv9hkn42twwO7OSjZukIJs+1j4Lfj72Eo
         gfELBT5CFbxzeZfermXxQUaUN8OZfznJd/mQsfSqeuRA1g3JTPo3ZvMYOZyKDAkckI2i
         pZlHjJPZt3/j1QRglnngjPVCtwlc7zV7MFNQrEQfsXW5Mn+WYVHHP2cSBctc9ZKs9gsf
         uamfl3DSXhkp5K8yPMe7NvcVJCjkzI5KsH+NoNZ6svy4jqxLS8ZDhHwMjvZ2lXp1C+Rt
         jHPg==
X-Gm-Message-State: AC+VfDwvG62KTF9Nwtbh2Tn4rpbuS74V9545Ul6lKHvroJxfiKHHjmIS
        O+00GXDsxYI3WymELjtPX+A=
X-Google-Smtp-Source: ACHHUZ6E5Oy77f4SmFCfxx6uJ93Rl7pB5cRGyN/JxOBjfA5Zzy6rp+P+wBjfWtNWsJItDkJQwX41xQ==
X-Received: by 2002:a92:d4c4:0:b0:332:e5aa:f9b8 with SMTP id o4-20020a92d4c4000000b00332e5aaf9b8mr592276ilm.13.1687316466620;
        Tue, 20 Jun 2023 20:01:06 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id x6-20020a029706000000b0042682dd951dsm1035008jai.87.2023.06.20.20.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 20:01:06 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bodo Stroesser <bostroesser@gmail.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scsi: Replace strlcpy with strscpy
Date:   Wed, 21 Jun 2023 03:00:32 +0000
Message-ID: <20230621030033.3800351-2-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
References: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/scsi/ncr53c8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 4458449c960b..35869b4f9329 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -4555,7 +4555,7 @@ static void ncr_detach(struct ncb *np)
 	char inst_name[16];
 
 	/* Local copy so we don't access np after freeing it! */
-	strlcpy(inst_name, ncr_name(np), sizeof(inst_name));
+	strscpy(inst_name, ncr_name(np), sizeof(inst_name));
 
 	printk("%s: releasing host resources\n", ncr_name(np));
 
-- 
2.41.0.162.gfafddb0af9-goog

