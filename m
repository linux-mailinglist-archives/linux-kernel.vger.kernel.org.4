Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715DC6DB45B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjDGTpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDGTpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:45:30 -0400
Received: from smtp43.i.mail.ru (smtp43.i.mail.ru [95.163.41.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD147EFD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=NvYJpet7Fk6/w25JYr9mm2ZP1diC0czwTd9vh5lKJnQ=;
        t=1680896728;x=1680986728; 
        b=MgQMh+OJJR9r8M4+0CaGIVi3IU4gZ0bO3/5ZdaG7TKUncjpLgzpmlrNj+OomV79l3FEsEMOQwhiL+crw3kPh/qYqAK+RXaSwq3S8WuTOF5hjUFU0WUVJVzOEnb+bnjGkZp0sAjRzbkjB/oh+C8fPd9iO6DyCkjmsmqag/9ehT2DeHU+Yu12MOsYPcQs2aIy082wH8kBmrZGiWWuF+2v4VHV4ncyz9DTkx0xeAkQdtNH4RCWyuotRy+0LIku85l1WGqZtujofCJgq5zXiJDLgsprM5jCDiIXyXNErVMJeN2TR1ZSEyXeieTNx+c6wQdCJ6LxUA67bURGOij6T71Xs5Q==;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <listdansp@mail.ru>)
        id 1pks1V-00CGCi-1Q; Fri, 07 Apr 2023 22:45:25 +0300
From:   Danila Chernetsov <listdansp@mail.ru>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     Danila Chernetsov <listdansp@mail.ru>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] ntfs: do not dereference a null ctx on error
Date:   Fri,  7 Apr 2023 19:44:33 +0000
Message-Id: <20230407194433.25659-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp43.i.mail.ru; auth=pass smtp.auth=listdansp@mail.ru smtp.mailfrom=listdansp@mail.ru
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9449D4C173EDB398B4AA6E69619C9422F44ED2AFF838F185A182A05F538085040C0DA476FB704B9569735B1C01C3A62D1CB9CAF18D7D13784DEDF32025193304E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F40AD8E56E74C9F0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FC0948D7756001208638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D81E452AB8AF3C7FED94C2B32222F1C0B06F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE70F3DDF2BBF19B93A9FA2833FD35BB23D9E625A9149C048EEC24E1E72F37C03A0E5D25F19253116ADD2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B89C3E995CBB71A93A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC9E2F778EF6F0A36DD32BA5DBAC0009BE395957E7521B51C20BC6067A898B09E4090A508E0FED6299176DF2183F8FC7C087AD95B3029C73CDCD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6505CD8581A3881E7089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A590898012DBD482B4DD14AECE8D852593E1025A028F061139F87CCE6106E1FC07E67D4AC08A07B9B0DB8A315C1FF4794DC79554A2A72441328621D336A7BC284946AD531847A6065AE478A468B35FE767BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFC4CF59485F2AB47ECC0711F0FFCF371D29651C91DAA9063A8299A5B00B997108FD9AF20B71F72F3ACB30CE9436786760E53C96DE51FC12FF0D411CE0F74BB7AE06EEC8038AF5C160
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojAd8K2eZV+gGkrO1olIpd7w==
X-Mailru-Sender: 4CE1109FD677D2770147F6A9E21DCA7B8348D1E700BC3200A1A3209C00ACCF242E10D788B03576C67E3C9C7AF06D9E7B78274A4A9E9E44FD3C3897ABF9FF211DE8284E426C7B2D9A5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ntfs_mft_data_extend_allocation_nolock(), if an error condition occurs
prior to 'ctx' being set to a non-NULL value, avoid dereferencing the NULL
'ctx' pointer in error handling.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 fs/ntfs/mft.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 48030899dc6e..e1126ce6f8ec 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1955,36 +1955,40 @@ static int ntfs_mft_data_extend_allocation_nolock(ntfs_volume *vol)
 				"attribute.%s", es);
 		NVolSetErrors(vol);
 	}
-	a = ctx->attr;
+	
 	if (ntfs_rl_truncate_nolock(vol, &mft_ni->runlist, old_last_vcn)) {
 		ntfs_error(vol->sb, "Failed to truncate mft data attribute "
 				"runlist.%s", es);
 		NVolSetErrors(vol);
 	}
-	if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
-		if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
+	if (ctx) {
+		a = ctx->attr;
+		if (mp_rebuilt && !IS_ERR(ctx->mrec)) {
+			if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
 				a->data.non_resident.mapping_pairs_offset),
 				old_alen - le16_to_cpu(
-				a->data.non_resident.mapping_pairs_offset),
+					a->data.non_resident.mapping_pairs_offset),
 				rl2, ll, -1, NULL)) {
-			ntfs_error(vol->sb, "Failed to restore mapping pairs "
+				ntfs_error(vol->sb, "Failed to restore mapping pairs "
 					"array.%s", es);
-			NVolSetErrors(vol);
-		}
-		if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
-			ntfs_error(vol->sb, "Failed to restore attribute "
+				NVolSetErrors(vol);
+			}
+			if (ntfs_attr_record_resize(ctx->mrec, a, old_alen)) {
+				ntfs_error(vol->sb, "Failed to restore attribute "
 					"record.%s", es);
-			NVolSetErrors(vol);
+				NVolSetErrors(vol);
+			}
+			flush_dcache_mft_record_page(ctx->ntfs_ino);
+			mark_mft_record_dirty(ctx->ntfs_ino);
 		}
-		flush_dcache_mft_record_page(ctx->ntfs_ino);
-		mark_mft_record_dirty(ctx->ntfs_ino);
-	} else if (IS_ERR(ctx->mrec)) {
-		ntfs_error(vol->sb, "Failed to restore attribute search "
+		else if (IS_ERR(ctx->mrec)) {
+			ntfs_error(vol->sb, "Failed to restore attribute search "
 				"context.%s", es);
-		NVolSetErrors(vol);
+			NVolSetErrors(vol);
+		}
+		if (ctx)
+			ntfs_attr_put_search_ctx(ctx);
 	}
-	if (ctx)
-		ntfs_attr_put_search_ctx(ctx);
 	if (!IS_ERR(mrec))
 		unmap_mft_record(mft_ni);
 	up_write(&mft_ni->runlist.lock);
-- 
2.25.1

