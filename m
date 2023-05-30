Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F9C7153B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjE3CeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjE3CeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:34:00 -0400
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4012A;
        Mon, 29 May 2023 19:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=f7uGk/jrwkwU8/HqMyPIvlNpQfEo8ntyNjjClXdR5RA=;
        t=1685414006;x=1685504006; 
        b=ogpc8V+bH3AR5yJBHM22VG9bMJKxDWbVbB5d0sQ3XUCjc/bNl0axOokkl1OOUZqLsPOSGqxnHrWB76IWpkUP8yoV6egOzVu000KfL9d2FbFdExt0tOLhN6UHmHb71nlpceDsjl+u4uOZfD9rUKSYMgdOWsHUhU37Va3PGt+X/zJgXoVM8mK7C4m6+9XprK8x6uQXdTQ+XFahJ7jUO0Eva0TlFEPlUBMtfQQLQ2xkGq8I19k3mnTF08i9XGlfCMZDfxY9mU/WCR/jXA64wJHVU05RsyPUWIi6s0OJGczZK3V6NM6fDy4xyLeHjZ2qNE4UOdZKneCmwWZEMZa6+T/K2Q==;
Received: from [10.12.4.10] (port=53390 helo=smtp34.i.mail.ru)
        by fallback1.i.mail.ru with esmtp (envelope-from <listdansp@mail.ru>)
        id 1q3pAp-007d3e-4z; Tue, 30 May 2023 05:33:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=f7uGk/jrwkwU8/HqMyPIvlNpQfEo8ntyNjjClXdR5RA=;
        t=1685414003;x=1685504003; 
        b=di1z17Nhfh8tTrDut9u4MLY/+sAtgj2Xzg3TohuKQ4KjzxirNmTJ4y4AdJN2WXbb5E7ers8cpMiVZaMg3F9PYwszlli9ZP7mNdFN6r1W71Nfuiz9zXP1p6Ms4SYBzlrwIBYnPlPupu3J0AW2sMqhEbI2trt634H0bYAx7r2PqgH0hssqWJMai6f0trN2uqInPJ48o41ycenuEP2UfwQfAFWwFrSht/ocVkiFSNFrcuQEnGwoyacAV/rqi0xNLZJEtDS6TRKZA6iz2oqFzPcXn7LG85+of2ZPTxyPmij3lPJZbrmEfMXG1fNX1rWXChGNFPv19pvyVoMSln7it9H0iw==;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <listdansp@mail.ru>)
        id 1q3pAb-006P3c-RR; Tue, 30 May 2023 05:33:10 +0300
From:   Danila Chernetsov <listdansp@mail.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Danila Chernetsov <listdansp@mail.ru>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>
Subject: [PATCH 5.10 1/1] ovl: fail on invalid uid/gid mapping at copy up
Date:   Tue, 30 May 2023 02:29:17 +0000
Message-Id: <20230530022917.18574-2-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530022917.18574-1-listdansp@mail.ru>
References: <20230530022917.18574-1-listdansp@mail.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9FA9FE7958A526B7720A7778064FAD46CFFAE4421AB0E3E4100894C459B0CD1B990E3A3C6B72B9C662C45DFFA6B799393C09BBED9A7CA5B313E4D764DDA6573C6
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7364F8074C6DFACE2C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7CF4D16325FBE1EEDEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBABB8A4F48F597468F941C5020E649408320879F7C8C5043D14489FFFB0AA5F4BF1661749BA6B9773581F0255C1FF0F6138941B15DA834481FA18204E546F3947CA816C540FC8EEC30F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637BA2F0AEB80054583389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637992A73A57571FA86D32BA5DBAC0009BE395957E7521B51C20BC6067A898B09E4090A508E0FED6299176DF2183F8FC7C0C67AC315686ED4D3B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B8785BF30A5E9335375ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A554DB9ECB16FEEB824D7E3024AE287B06D55BB9903C8A2C4DF87CCE6106E1FC07E67D4AC08A07B9B062B3BD3CC35DA5889C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF116E5E44DE9100BBEEED3EEBC07AF80B701BB70B6E0BCEC17DE74F1FF7C5EBBAABDA6BB679979B95A0A56A47F2C7DF6400888D98DB0B81F52A17632CF28E0A940CB5B17375C3CAE6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojjC1ARgSIbgSmrw2n2L+x4w==
X-Mailru-Sender: 4CE1109FD677D2770147F6A9E21DCA7BC7F566A1B8E545241CE9570231BFF90BA1B040CCCA3BBC987E3C9C7AF06D9E7B78274A4A9E9E44FD3C3897ABF9FF211DE8284E426C7B2D9A5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4485927362E3B8E42AAA24C10A56A0391FE9080E46380FB35049FFFDB7839CE9EE822F105BA4D6AE1C20245CB103D11777DD0F09F155423BD906FE3E57C7B100F
X-7FA49CB5: 0D63561A33F958A56D8EBE0D8A6A5012998B0ED50B41116C48C8EDEFB6AE55BFCACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdZdU6KX1s6V4J5s4MsURIQw==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit 	4f11ada10d0ad3fd53e2bd67806351de63a4f9c3 upstream. 

If st_uid/st_gid doesn't have a mapping in the mounter's user_ns, then
copy-up should fail, just like it would fail if the mounter task was doing
the copy using "cp -a".

There's a corner case where the "cp -a" would succeed but copy up fail: if
there's a mapping of the invalid uid/gid (65534 by default) in the user
namespace.  This is because stat(2) will return this value if the mapping
doesn't exist in the current user_ns and "cp -a" will in turn be able to
create a file with this uid/gid.

This behavior would be inconsistent with POSIX ACL's, which return -1 for
invalid uid/gid which result in a failed copy.

For consistency and simplicity fail the copy of the st_uid/st_gid are
invalid.

Fixes: 459c7c565ac3 ("ovl: unprivieged mounts")
Cc: <stable@vger.kernel.org> # v5.11
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Seth Forshee <sforshee@kernel.org>
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 fs/overlayfs/copy_up.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e466c58f9ec4..fd33abc0edc0 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -882,6 +882,10 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 	if (err)
 		return err;
 
+	if (!kuid_has_mapping(current_user_ns(), ctx.stat.uid) ||
+	    !kgid_has_mapping(current_user_ns(), ctx.stat.gid))
+		return -EOVERFLOW;
+
 	ctx.metacopy = ovl_need_meta_copy_up(dentry, ctx.stat.mode, flags);
 
 	if (parent) {
-- 
2.25.1

