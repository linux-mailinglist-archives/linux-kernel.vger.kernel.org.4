Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E482651984
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiLTDVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLTDVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:21:43 -0500
X-Greylist: delayed 1868 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Dec 2022 19:21:38 PST
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78AF39FFB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 19:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=v+uox
        zo0+29UuLtC1mkaXe+YIjbQhfRgr40Tuh7bbUI=; b=VhJD04v3LNMw/RvdAov3p
        /Gdbd9LvwBBQgzQpYEKOXkGv9TMjcTh5/PpGR/fGT/H7CGoT+ROGTx5T0HoLTs8y
        J67ZXo48lssMDoCTr5SsNaNgFkcr9g+z6jSCrsiKMXKWDG3UGRbPZlFqtTIzVGfY
        RP1CI+mXz75ru4u6VHrhzU=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wBHESurIqFjWX0LAA--.19708S2;
        Tue, 20 Dec 2022 10:49:15 +0800 (CST)
From:   lingfuyi <lingfuyi@126.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        lingfuyi <lingfuyi@kylinos.cn>
Subject: [PATCH] fs: fix compile error
Date:   Tue, 20 Dec 2022 10:49:11 +0800
Message-Id: <20221220024911.4051020-1-lingfuyi@126.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHESurIqFjWX0LAA--.19708S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrGr43Ar4UWr4fGFyxZw4Utwb_yoWxWFX_Wa
        n2q3y0kr4UXr4rK343Za98trWFvFW8Gr98uFs8tayDXa4Uta1DG34DZrnxJFyDWr1Yyry3
        JFnrZrykAF1xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRsqXtUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: polqwwxx1lqiyswou0bp/1tbiJATZR1pEGeYV6gABsh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lingfuyi <lingfuyi@kylinos.cn>

fix compile error like this:
fs/afs/dir.c:52:1: error: no return statement in function returning non-void
[-Werror=return-type]
Signed-off-by: lingfuyi <lingfuyi@kylinos.cn>
---
 fs/afs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 104df2964225..d4ea307dc312 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -49,6 +49,7 @@ static bool afs_dir_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
 	BUG(); /* This should never happen. */
+	return true;
 }
 
 const struct file_operations afs_dir_file_operations = {
-- 
2.20.1

