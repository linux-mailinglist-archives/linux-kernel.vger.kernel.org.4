Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63E369A5BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjBQGwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQGws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:52:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0564E5C0;
        Thu, 16 Feb 2023 22:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3MXiOLMWRtJD23oH9F/40s9M46/u8K6XofKqR2bDpsA=; b=00Mnt2kysIg+bzgyhA80LOqscE
        6rjvBbtLzNqEOsmcKtrXf/XDzGnp/Rm96ruVGllpt/hBM2Ih3G7wYUL3NjQgk5TxSIG5oZIwdR+ox
        +uN3sDr1LYymMOvagabaNC85OX3lEchyxChlnFTq+yenXkcjHCHt9YfElQB6F4NTWDRdHVPis65HC
        z68F0y+CvqkFiIPsyooeoTBnJU5McNpEs/ZrBE8K4fAivg/rWYFBPAuLsXM5k27eKgrmE7zsxWu9/
        a9cQ+9WRuXZ7K9CHNMQJzXQGaif23eokcY4tujdAw7Bs62DnOMXq58cxvLTFi9TISk0MfysiUrek7
        qQYLY1RA==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSubv-00Cz1N-1e; Fri, 17 Feb 2023 06:52:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] kconfig: save the KCONFIG_SEED value in the config file
Date:   Thu, 16 Feb 2023 22:52:46 -0800
Message-Id: <20230217065246.31641-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save (print) the randconfig seed value in the kernel .config file.
This enables someone to see easily that the .config file is a
randconfig file.

It also allows the randconfig file to be recreated by using the
KCONFIG_SEED environment variable, as long as KCONFIG_PROBABILITY
was not specified (the default probability values were used) and
as long as the file was not edited.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
---
 scripts/kconfig/conf.c     |    3 +++
 scripts/kconfig/confdata.c |    2 ++
 scripts/kconfig/lkc.h      |    2 ++
 3 files changed, 7 insertions(+)

diff -- a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -83,6 +83,8 @@ static void xfgets(char *str, int size,
 		printf("%s", str);
 }
 
+unsigned int rand_seed;
+
 static void set_randconfig_seed(void)
 {
 	unsigned int seed;
@@ -109,6 +111,7 @@ static void set_randconfig_seed(void)
 		seed = (now.tv_sec + 1) * (now.tv_usec + 1);
 	}
 
+	rand_seed = seed;
 	printf("KCONFIG_SEED=0x%X\n", seed);
 	srand(seed);
 }
diff -- a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -621,6 +621,8 @@ static void conf_write_heading(FILE *fp,
 		cs->decoration);
 
 	fprintf(fp, "%s %s\n", cs->decoration, rootmenu.prompt->text);
+	if (rand_seed)
+		fprintf(fp, "%s KCONFIG_SEED=0x%X\n", cs->decoration, rand_seed);
 
 	fprintf(fp, "%s\n", cs->postfix);
 }
diff -- a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -43,6 +43,8 @@ const char *zconf_curname(void);
 const char *conf_get_configname(void);
 void set_all_choice_values(struct symbol *csym);
 
+extern unsigned int rand_seed;
+
 /* confdata.c and expr.c */
 static inline void xfwrite(const void *str, size_t len, size_t count, FILE *out)
 {
