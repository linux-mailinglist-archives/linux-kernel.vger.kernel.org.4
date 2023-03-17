Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB4F6BF0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCQSiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCQSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:38:11 -0400
X-Greylist: delayed 2724 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Mar 2023 11:38:01 PDT
Received: from fallback22.i.mail.ru (fallback22.i.mail.ru [79.137.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5576521C5;
        Fri, 17 Mar 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=o+1mU1q4gkL434JQCvQOjbVkDZrRwY9QYosc0X3le7g=;
        t=1679078281;x=1679168281; 
        b=drdjJJhub69D0KMZ28C9BChx3AaunuDptySW03cQKCcEpxL1GzqnJrKKldPiurjvgSLp+pv+ejw/DoELEjs4n5aTK3a4qlSr5H6OpAG0GEhaEjwJMsma2E/O+YcPYqFF8lDXpp4BK/8fqfGSqZwAP2imvHV2fh/FXauHSKBuhIIbYnNsbN2hGObsFQ1uEOB3kr8OlaYJ08XTh/swpfQBZxCuZuKj1G9ZUdsyjVZtG1X8WJGasVqLLHjtT4k+ApZf5lIu4rOmZfYgWIF7gf0sQ+WJddvYAesYNyKd8iGERZdZ2WQL0XfWa+xh37M1YmII8WmG8zcK+7at5ANmvpQ9Ig==;
Received: from [10.12.4.13] (port=47206 helo=smtp38.i.mail.ru)
        by fallback22.i.mail.ru with esmtp (envelope-from <listdansp@mail.ru>)
        id 1pdEFl-002KB7-RX; Fri, 17 Mar 2023 20:52:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=o+1mU1q4gkL434JQCvQOjbVkDZrRwY9QYosc0X3le7g=;
        t=1679075553;x=1679165553; 
        b=0Q52CoOVpZ1MPUZ8eia0aAgcrzz47B0qqx3/6W93Q5ml7OyBOfGb5TAMQnDpgpBKXm/bmwN4abYof6dPpGxMYZA2L9lSo1dJxu3ossPn9Awq830rtvUJ3ODtlq/51lunuOjIuk/mVnGiAvsJHVMrH0P1bToLdODHUTFrj+zEF946bMRmjkEjqJmh8iy7TZkaN7JriGaKBIn5fLbxKu6tQEdr7FVlbYN9FYr3D0GHty3ZlCoKRsG/EvtUNONTI1WeBjS40PCaBuzI50wlsaLU5aqjgxQaxvwoSP376zOUPt+CXH6JyrJwnVciTdVEwu0vnv74GJL9TWzczs/ge/KV3w==;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <listdansp@mail.ru>)
        id 1pdEFV-00FTFd-Ve; Fri, 17 Mar 2023 20:52:18 +0300
From:   Danila Chernetsov <listdansp@mail.ru>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Danila Chernetsov <listdansp@mail.ru>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] megaraid: fix mega_cmd_done CMDID_INT_CMDS
Date:   Fri, 17 Mar 2023 17:51:09 +0000
Message-Id: <20230317175109.18585-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9303C7CA6F8B0D1AB3FDF257D500913EAB79CDFBE95766163182A05F5380850409F5C60878D86A282A9A3AF9403D21D97063C3F2E1D9CF7229FB7F584D1CE28B8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE71EEA4C46C73542F4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637BFD6B3F1638522B88638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D82644E96FABFBF3F94CD7AD57DCCBC6D06F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7E5E8FA3E51EEB5BC9FA2833FD35BB23D9E625A9149C048EE599709FD55CB46A6618001F51B5FD3F9D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B6D77D8F98F67F34EA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FCAB6F2D16C1B8CE9D3AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F7900637E63F877465845756D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FD2A95C73FD1EFF45156CCFE7AF13BCA4B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5DD427AD2E4A9B1EA8AD849504D580BEB522FF0690FA735744EAF44D9B582CE87C8A4C02DF684249C2E763F503762DF505830FD47C92F6C63
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D348BE83DFD8AFB1CACEE02C8844339E1B4B202B0E0389BB5CAFABF101A5320A17EAB48BA705C6417941D7E09C32AA3244C8BCCE5772FEC1F5022DE84C2D1552F52A995755A1445935EED98077840A144B9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojBy9lRm6Il0sKqTyfoFU+Yg==
X-Mailru-Sender: 4CE1109FD677D2770147F6A9E21DCA7B8F327498E8707629B1ACCDDC98EF4007976AF1CB91E6EA817E3C9C7AF06D9E7B78274A4A9E9E44FD3C3897ABF9FF211DE8284E426C7B2D9A5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4754CEC505B6CD4089D2F09A1EB72CE4461CD78E14AA687EE049FFFDB7839CE9ED70DE35110CB393164F4B33B2FB038503FD78B7ED81EAB6C178A9E8AB591FB15
X-7FA49CB5: 0D63561A33F958A59159B04F0CE15162DFB909C8CD758DBF3117ABA9CF772B58CACD7DF95DA8FC8BD5E8D9A59859A8B6B324FA1BA8AFA530
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdx+85qy1Cr/QrN2mfjh5Ieg==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cmdid == CMDID_INT_CMDS, the 'cmds' pointer is NULL but is dereferenced below. 

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f2bb84d2a68 ("[SCSI] megaraid: simplify internal command handling")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 drivers/scsi/megaraid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index bf491af9f0d6..16e2cf848c6e 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1441,6 +1441,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 		 */
 		if (cmdid == CMDID_INT_CMDS) {
 			scb = &adapter->int_scb;
+			cmd = scb->cmd;
 
 			list_del_init(&scb->list);
 			scb->state = SCB_FREE;
-- 
2.25.1

