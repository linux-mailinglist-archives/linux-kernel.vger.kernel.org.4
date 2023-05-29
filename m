Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7E7143CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjE2Foz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjE2Fox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:44:53 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF32FA6
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:44:46 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230529054442epoutp01309f0b47d6c6ff404f84b41e42d6dfb2~jhvdmcTJ52123421234epoutp01b
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:44:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230529054442epoutp01309f0b47d6c6ff404f84b41e42d6dfb2~jhvdmcTJ52123421234epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685339082;
        bh=VKGA7JRShMZpv9qQksUeVQx6cayrYtRJ5ilKYNP0jmE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NTyT/sjdXwOKF36GE+jkfCeAiwH+K4Kuu30gYW2CjFH9kJUBMCWhPCIGtMREsV+VA
         mii2WKxOc2VcXwW9IdMeqzthQ5ZZkb4f12JwphMQpquVRKfXqXlqIQzKP6+EluPXMW
         tKY99UVdtTIY4FsXy10t/zSoIQ3ZURNiUmI3OuFA=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230529054442epcas5p174f7f1efb7ecaa25dcb51543f75c5f46~jhvc-Ls2d0107001070epcas5p1E;
        Mon, 29 May 2023 05:44:42 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.1D.16380.9CB34746; Mon, 29 May 2023 14:44:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3~jhhVsx2dC0673106731epcas5p4b;
        Mon, 29 May 2023 05:28:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230529052832epsmtrp1af9353d7aba59de1154e69418a46b28f~jhhVrzAe12525125251epsmtrp1M;
        Mon, 29 May 2023 05:28:32 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-a3-64743bc96d39
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.40.28392.FF734746; Mon, 29 May 2023 14:28:31 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230529052828epsmtip2ec3d5bb5aec6f5fcd83577c21270d0c9~jhhSnoNsd1095910959epsmtip2J;
        Mon, 29 May 2023 05:28:28 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     bcain@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, keescook@chromium.org,
        nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com,
        gary@garyguo.net, ojeda@kernel.org, pmladek@suse.com,
        wedsonaf@google.com
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
Subject: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array size
Date:   Mon, 29 May 2023 10:58:21 +0530
Message-Id: <20230529052821.58175-1-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmlu5J65IUg77/lhZ/Z29nt3i4u4XF
        4s6k5+wWF8+8ZrQ4051r8b5lB5vF5V1z2Cx+f//HanF4fhuLxZaGQ2wWG44GW/x8cYPFYuX8
        5YwWK3o+sFr8f/wVSLw7wmTRsXglo4Ogx+yGiyweX2+eY/JY9LKBxWNJ5y8mj52z7rJ7LNhU
        6rFpVSebx4RFBxg9zs9YyOgxcU+dR9+WVYwe67dcZfH4vEkugDeKyyYlNSezLLVI3y6BK+P3
        om+sBe08FdPP3WBpYOzh6mLk5JAQMJFYdHMhWxcjF4eQwG5GiVlzdjJBOJ8YJVq2XoNyPjNK
        vNozkxmm5fDvn2C2kMAuRonOvhqIoi+MEtfvnwdLsAnoSazatYcFJCEi0MokcePwabAlzAIb
        GSX+7lnFCFIlLOAl8eHrfFYQm0VAVeLi0w52EJtXwEbiyaxGVoh18hIzL32HigtKnJz5hAXE
        ZgaKN2+dzQwyVELgDIdE087pQEM5gBwXiUVzCiB6hSVeHd/CDmFLSbzsb2OHKCmX2DqhHqK1
        hVFi/5wpbBA19hJPLi5kBalhFtCUWL9LHyIsKzH11DomiLV8Er2/nzBBxHkldsyDsVUlWm5u
        gDpZWuLzx48sELaHxKnvq1ghoRUrse/MIuYJjPKzkHwzC8k3sxA2L2BkXsUomVpQnJueWmxa
        YJyXWq5XnJhbXJqXrpecn7uJEZwGtbx3MD568EHvECMTB+MhRgkOZiURXtvE4hQh3pTEyqrU
        ovz4otKc1OJDjNIcLErivOq2J5OFBNITS1KzU1MLUotgskwcnFINTIuFN0aYrT3lPXV7/LeO
        oPZSlULpPvWvjnW9sz/OWTyN99+3M3PObYwLOeLC9jCbuyCPY/lVbv6ZzYZakxcUcPwKcuhL
        NzIy2mqbsuPk1dAjQZ6HujKZ9bb0hTUdmZ2+M75cwuHn/LceSx55iGUofcn0vLOgc/HBx5zq
        EknnZb6uVz9r+eFYzm2xwhelyWXrA2yW5SXvnfPzwLRDYVF6z7TmH89Vec5vxu9o8Olvu4xU
        GsdMrpksTnN2dEzvcp2z6eos6W/64R/vv2ebs/dV1l+15w9zlERnt+5drBMSduPGbW/b3gxL
        Lp8j7//UqPEuvPp37jXhgxwB7qkNUU5ubNuf/XG4cb0oT/GyqbNqqxJLcUaioRZzUXEiAJrs
        hsPyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXve/eUmKwZPrNhZ/Z29nt3i4u4XF
        4s6k5+wWF8+8ZrQ4051r8b5lB5vF5V1z2Cx+f//HanF4fhuLxZaGQ2wWG44GW/x8cYPFYuX8
        5YwWK3o+sFr8f/wVSLw7wmTRsXglo4Ogx+yGiyweX2+eY/JY9LKBxWNJ5y8mj52z7rJ7LNhU
        6rFpVSebx4RFBxg9zs9YyOgxcU+dR9+WVYwe67dcZfH4vEkugDeKyyYlNSezLLVI3y6BK+P3
        om+sBe08FdPP3WBpYOzh6mLk5JAQMJE4/PsncxcjF4eQwA5GiYW7X7FCJKQlfv57zwJhC0us
        /PecHaLoE6PE7tdnwRJsAnoSq3btYQFJiAhMZZKY8vo+G0iCWWAro8SSK/UgtrCAl8SHr/PB
        prIIqEpcfNrBDmLzCthIPJnVCLVNXmLmpe9QcUGJkzOfsEDMkZdo3jqbeQIj3ywkqVlIUgsY
        mVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHlZbWDsY9qz7oHWJk4mA8xCjBwawk
        wmubWJwixJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9Ne
        E2HTExmS6ce+nW786zprzUHdGNPWp0pnYkqu3/6Zf1DZmU/50PHz23T2+Kz0auuaGFRwpHej
        5NyebVI5OlMEpq8UE663XFu8/Pe/WVVLtwhemmzgpeypsLp+Uva8CazrWDuOf5m+9ambMd8h
        zR2F649/FTNjfzJv4Q0hbpn+0g+JonyikVFyNxcUveKNuF8m69lxR3Txl8ArlaUchm/cZyw6
        6FLAaXLMmaWCrVrWJaf3fOyCZRfuCHU+SZMzTNn6Ym5L+oWwC5N5P/qH9lyyr+j0Nym+civu
        FKf9nrjyOcv/fZyTuHuqzsTfadIS7hsslp/buUk5PcVCZMuHX5Osv26zFpTrdk/60fNehV2J
        pTgj0VCLuag4EQDXWk9QGQMAAA==
X-CMS-MailID: 20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3
References: <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
writes on index "KSYM_NAME_LEN - 1".

Thus array size should be KSYM_NAME_LEN.

for powerpc and hexagon it was defined as "128" directly.
and commit '61968dbc2d5d' changed define value to 512,
So both were missed to update with new size.

Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 arch/powerpc/xmon/xmon.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6447763ce5a9..65b30b6ea226 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -82,7 +82,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	const char *name = NULL;
 	unsigned long *newfp;
 	unsigned long low, high;
-	char tmpstr[128];
+	char tmpstr[KSYM_NAME_LEN];
 	char *modname;
 	int i;
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 728d3c257e4a..70c4c59a1a8f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -88,7 +88,7 @@ static unsigned long ndump = 64;
 static unsigned long nidump = 16;
 static unsigned long ncsum = 4096;
 static int termch;
-static char tmpstr[128];
+static char tmpstr[KSYM_NAME_LEN];
 static int tracing_enabled;
 
 static long bus_error_jmp[JMP_BUF_LEN];
-- 
2.17.1

