Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53875F4B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiJDVvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJDVv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:51:29 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78368356C0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:51:27 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9AA9DC020; Tue,  4 Oct 2022 23:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664920285; bh=KbZcmVU0SyvXU0IFRceif+s7w7THicWMuGQjXYt68ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYekjrCENjrsjJgMdK8yfzYjvmCcWuM9g/yacRsGwUtlz4xqGcn/chVJxPnqPRVvp
         Gk5R2MNi43DwMv5Ix99FDu18y5X/70erf5Otdnf1/KlpY1YoNkmOLR1C7WT5P+oZC/
         OzBXauDQnWbxYrnn+rcGC9u/A+y8t3xYwBHuWZ8254R/FzM8q2B6RY19nmzOAtxfmG
         HcGcocHcYBzD0SDmIKLRJim+xtbaPXQhhOFTG3F/Q5G9Qe63auRd+jO6qrLJdghbkl
         4+ZAS48pVe3erAKMwCpjRQBK5G5WYTftaRxy+RfpMye474jrUJVgR58gbrzYSj56sd
         9XRsD05GubEcg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 33E45C01A;
        Tue,  4 Oct 2022 23:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664920284; bh=KbZcmVU0SyvXU0IFRceif+s7w7THicWMuGQjXYt68ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpkGSXyNtvuCKK4WrCAK+p7iJgkGbk6L+lW7DKM9yzJEb6Dh6k1PdcdAefaexoYkD
         PxMF+0qqvR2OO3iu/cPAdEfBpq+aLavtMKRukNU+pM1afN55VsBpY2FzrreOlQGWXT
         x5KFtIyF2qUBO2h5/mVGUcRniLzzpRaYlyi3CS3KPoVK9ufIE93ts26kw4LgRdBdD+
         EmH6UVJj8FaRwTFTM1NR8QzGGDCP6p8MZ3rUu/1L719u8mArVjE0bDYOa8Dc5UJtSQ
         e5ib/PdH4J1jGPiRKWzr7k4ccznq45YKZeoR0tbtmejcBoZKFA2w+RB3kHROYMbNdr
         x98+VCYn74PaQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 9ba42520;
        Tue, 4 Oct 2022 21:51:16 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 2/2] 9p: avoid double put_trans on parse_opt failure
Date:   Wed,  5 Oct 2022 06:51:14 +0900
Message-Id: <20221004215114.1850991-2-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221004215114.1850991-1-asmadeus@codewreck.org>
References: <20221004215114.1850991-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p9_client_destroy will catch that trans and put it when p9_client_create fails

This was brought up when reviewing an alternative implementation of the
previous patch [1]

Link: https://lkml.kernel.org/r/YzVzjR4Yz3Oo3JS+@codewreck.org [1]
Fixes: 3ff51294a055 ("9p: p9_client_create: use p9_client_destroy on failure")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/client.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index cf2d5b60b61b..693e06213a04 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -212,8 +212,6 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 	}
 
 free_and_return:
-	if (ret)
-		v9fs_put_trans(clnt->trans_mod);
 	kfree(tmp_options);
 	return ret;
 }
-- 
2.35.1

