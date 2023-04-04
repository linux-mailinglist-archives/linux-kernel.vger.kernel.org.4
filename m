Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046636D6D37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbjDDTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbjDDTdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:33:08 -0400
X-Greylist: delayed 1552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 12:33:00 PDT
Received: from fallback19.i.mail.ru (fallback19.i.mail.ru [79.137.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10C52713;
        Tue,  4 Apr 2023 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=dKMZm81LcHiP6EBCk3sYRLgVyw8rB2A6lKoRpsJ+gTA=;
        t=1680636780;x=1680726780; 
        b=gyhUyLV8LbW4lgAo+8jtT4qL0fPamUBQzP/Ql1NxgyJDZrthQfmoYYHkx9NWebKI5sDNYKdz74RcjOS+LgH5fOmRhbN+Rkvsya/4hnuPiQqq0oBTQgDBPm6Lj3V+rty2RVMQSmUllp7A56quJBepvwG4NsFyKQ+vFb8NHslO7tR9WPhyOtfp1VAM4/VsHKmCS/fBMv4HtUBSPc/nazQQB5MGGTBjBdcWJkDASa8DHl0UA6kaPJPVS9xhC2mTR4AVQoqjd3mBfvKw7rIj+JT4pksJdCNbybRz3kR2osRyZ4G/7MNiA3HQXtbgrlmhpDw6i1rKPlkH2AQ61hRg7cXSSg==;
Received: from [10.12.4.3] (port=53562 helo=smtp17.i.mail.ru)
        by fallback19.i.mail.ru with esmtp (envelope-from <listdansp@mail.ru>)
        id 1pjlzl-007ioS-GM; Tue, 04 Apr 2023 22:07:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=dKMZm81LcHiP6EBCk3sYRLgVyw8rB2A6lKoRpsJ+gTA=;
        t=1680635225;x=1680725225; 
        b=fLC4vJuAXgkLFLb1XKShV+Wb+FmtxHVn5NjCiKZF/TMJSAZs1u36t3T+vURnRcGsIjR1e2lENeP+QDtgYKUVtd+bGxJxifpI6XZVHuGIIQOcbDO6+dKWrpDx8POfbpLjyycKj1bhyJB/8vbaTNyvCYixYJW7PQI30HAnrpwjrhDiuyujIIeB6A8C3RP6RogksAXgYMY3Ry6NmFeflScSbMHwOe+DQKzCjY2HGKQiVqFRPkcePaoRaRCw13/bnTEa3fO2pKaOx5pCiE12DYVQV+muTugv2lcgUoZ7jKC1Ftq+Ig0AlOna4fsdthFnhuhlckNZQKTLehWkG9OmkV/VcA==;
Received: by smtp17.i.mail.ru with esmtpa (envelope-from <listdansp@mail.ru>)
        id 1pjlzd-000qM6-Ey; Tue, 04 Apr 2023 22:06:57 +0300
From:   Danila Chernetsov <listdansp@mail.ru>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Danila Chernetsov <listdansp@mail.ru>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] apparmor: fix missing error check for rhashtable_insert_fast
Date:   Tue,  4 Apr 2023 19:05:49 +0000
Message-Id: <20230404190549.18257-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9487C1178585EEA1562B1701A890F216C76CC45EB59DA31C9182A05F5380850401C632EE49EDBB8BF8A15A11582A26E8475CF8690F3F7FD4EB2A5FB020275D3CD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7DCDABBCBEAF682B1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D3219148F76DED538638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8440EC792D69FF37D2486F6435A6FE30B6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7A6779F98BF527B7A9FA2833FD35BB23D9E625A9149C048EE902A1BE408319B29618001F51B5FD3F9D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B9C5BD8F4E2319607A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FCB6748121CF5D1ADF3AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F7900637930F67DCF033EC49D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FD2A95C73FD1EFF45A91E23F1B6B78B78B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5F8E95A6F260E20B98084B99C43D30E5DC8E40915B2419E445A4FF58CDAEABE2AA132EA92956906CB697742550EFD07B07E0012C66AE17B00823CB91A9FED034534781492E4B8EEAD831CA35E4C50C31B
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF26627E0B569FD6DE0357DC0226EF9A8E87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF26FCB280AB568EE2BFD61DE8EC32DF547C17237253DAC90F37F3C9000BDCFD99136DDA45E01CE4BED93D275CAE0A69C49B13468CD3F8C481F9E6CF646832CDA3FF926C0F406FFAF7
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojJlgUV9tWvkTPEdJRH8loIg==
X-Mailru-Sender: 4CE1109FD677D2770147F6A9E21DCA7BC94347EFF6D7DBEA0369EBC0B88D7114960CD386AD0F2D317E3C9C7AF06D9E7B78274A4A9E9E44FD3C3897ABF9FF211DE8284E426C7B2D9A5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-174C08C4: 5188C02AEC42908C481ED7ADC579193296BBA28369E3F2D2713F3D5F7D406D31BCF678C7329BA986
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B421986EB18E28D707CC603B1B97CA7101138A1EADC532FE32049FFFDB7839CE9E50A261C4403C6B6106EE0CCD7CAD63BD26B1E944E070CD3EF127895C3F315542
X-7FA49CB5: 0D63561A33F958A562AF04CF706B1AC29417BC0475936FB5C9294CDEC67E8CD0CACD7DF95DA8FC8BD5E8D9A59859A8B60AB5F3D1D7EC82DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdhn9Z/5tnkGSNFiBohEM5tQ==
X-Mailru-MI: C000000000001000
X-Mras: Ok
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 rhashtable_insert_fast() could return err value when memory allocation is
 failed. but unpack_profile() do not check values and this always returns
 success value. This patch just adds error check code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e025be0f26d5 ("apparmor: support querying extended trusted helper extra data")

Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 security/apparmor/policy_unpack.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index cf2ceec40b28..4d8adb21732c 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1046,8 +1046,13 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 				goto fail;
 			}
 
-			rhashtable_insert_fast(profile->data, &data->head,
-					       profile->data->p);
+			if(rhashtable_insert_fast(profile->data, &data->head,
+						profile->data->p)) {
+				kfree_sensitive(data->key);
+				kfree_sensitive(data);
+				info = "failed to insert data to table"; 
+				goto fail;
+			}
 		}
 
 		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL)) {
-- 
2.25.1

