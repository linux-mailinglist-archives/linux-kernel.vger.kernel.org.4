Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1B72DA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbjFMGv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbjFMGv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:51:56 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2059.outbound.protection.outlook.com [40.107.255.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960FCE79
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GknsSX0WKo1pEwcfOoZUMYK5eULAf1ROY+Figqxyd65FZ1qxC1xr93dvaUKlTS130Ih0AGo35TV/IWqECpyCEPvUZh2lBflqYzbEr1eS1g17y2wYv0Kqn2t5BHWEqSyaSJg/IXq2KYWAOz2NtGbqn3C30/C+0fzrH4jOuHYf5spA1hER7n2MBMMdddegc3KfDwmu+Wo6/aPFmaVkSFLfjDZNTBOcqwHzt1xwdD74zxqO3WF5JQYOWJLRqHBdemG+baiYj14edsUTtfUBeMRd7QIzKlyKetST1lNdke8kwV9HVb9SM365Rjw1d1Q0OC2ECoUPm5uQvUK3zScbGnYpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cnYnUYn+reBDlVyKbG8j7mN7BTU+bYA3WTqU141Sf4=;
 b=IYoHWBmHF2vmdbjjhhJeaDPaLuFcq1Sz4tkQbA0UyHP43a0NLANSw4G7YSswXIrTj7Te5v0EJP6CCzcvzmyY92iA92J4AL0EISRMHa3zE7yzUpzKhBZ20JG+1vBeKrmFtfEZI3RBZyu6pPYXYyR9+Uqlnl1T9QtFKZWpZ6N6SAfKuTuXBd5VLVfeppH0i/TT0e+xBbD6hK7A1aq6jI2TF3yqXS06kIGe5y2O32RuIy5S7HNojknAisU548R52Ew3OYtWMUjAzgPfifsyMAUo1JdH6TmtdYbA000K9HhcFa1kzuPyokRqiV4leG0v7qxozetow2wpnVdsoEvpytulwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cnYnUYn+reBDlVyKbG8j7mN7BTU+bYA3WTqU141Sf4=;
 b=YtIgwEezHu9ui/P5vnafz8eWmVPSDC2rZT66hL/prdqPpvehSIa0bmlMDCS9kShqTcZu571WlLsVBZxTEqBSQuPLTnws4m9epegWyGSXP9fa7lzrfHPIGCM1KsnZpjO9XBR5UecU6rDSLvT+T359VC+Af+iEWZjnF36EWl0UPUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
 by TYZPR02MB4784.apcprd02.prod.outlook.com (2603:1096:400:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.21; Tue, 13 Jun
 2023 06:51:51 +0000
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb]) by TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb%4]) with mapi id 15.20.6500.020; Tue, 13 Jun 2023
 06:51:51 +0000
From:   Yunlei He <heyunlei@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yunlei He <heyunlei@oppo.com>
Subject: [f2fs-dev][PATCH] f2fs: count mmap write io more accurately
Date:   Tue, 13 Jun 2023 14:51:35 +0800
Message-Id: <20230613065135.3517335-1-heyunlei@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR02MB4479:EE_|TYZPR02MB4784:EE_
X-MS-Office365-Filtering-Correlation-Id: 99bb6fd2-28fc-4026-30c7-08db6bdaaa7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/MMbL9dCjddun5vGFDvWdbkb/WAPcq3mH/u7Hn0ScSkwurmgV40vM+P+Oqlp+pp9xbeDYHzsEXcWblZhz4ApmFyKZMBCw4/J9KyfsrdKZ7KDFUP0nBhnrbyzma57CpmDmkjtKfvbgUsSaOFKBVZpnvja2EIGpZ/sNEH7rYxVCNE/xY38dNvTWqwYLwnaSHAXYHsoa6ZCm0uTBq9IhuP1qTWQL0gCUYQDLb0ws/xUy/jBdv/K9jjI0xnts7aGAxobuFISX6FUR8Qlt63r4NtlxXa2oEhFI6WmXTDwltb0eN044+y0HM8J7QTBQiYuyWSrV9yniERP50W2RWJyGf1yb8UtGLh5H2JEToH7os7jB+1UUlEvtuFEXs8NpVsHGEDwtSnkQQo32Wf7s4ZNgMflBuTj7yYBPZpS0JQQHusOQKAnAwCYDsmBA+Dwj8/KJXIuaNT5vr4J5zmH0u+58Q8FajhMEPvBTW1SQgDQz38mmJQSn3t6NBD1U43shKvijIaP1ZuIQRFjNmkn6SYr8TYxK5FQ7uX8WVwYRlch3aQR/CDLS08p256lP1aslij5sZM8ay0wURTFYhcQ5crnAUwzV9BHAmSZEC7SNyyEiBFu+FFglgHUAt2N0QBsNZoRygg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4479.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(4326008)(66556008)(316002)(66476007)(41300700001)(186003)(2906002)(478600001)(8676002)(66946007)(8936002)(5660300002)(6666004)(52116002)(6486002)(107886003)(1076003)(6512007)(6506007)(26005)(83380400001)(36756003)(86362001)(2616005)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EbvZ+ccLhMcVTbM1dBfX+cUqZAgqyW7q21sBU+8ABvfe4vVBxYyL1tcdK4I+?=
 =?us-ascii?Q?AKAd8OzeIyMZJ6OjZppG8rfLI4QYmWNd2PTMwFNO6CY3gIMcyNdxSIsaGpD9?=
 =?us-ascii?Q?J1XyrO79PsTc+KznmBMY3yhn/qja6V3ZdlUaRCUZW4sReUVFuwHwvlYNTTUz?=
 =?us-ascii?Q?7voe4/1TeicX8qEM9X/fO5+4eWTpZqYu/4vF5Vhrc5Fz+CBWjaG8KnVyNcUk?=
 =?us-ascii?Q?dIoAFjSpBfIBxCw+PWcWrHZfU4aN/e7+cnRCUq3bOKUTYDEbPp3ekmKXqRWx?=
 =?us-ascii?Q?PNXe7PbFzTZc+35H9n+018XPQvGD42acl6OSMCYZHzUk3RdcBBvE7UVlfBqQ?=
 =?us-ascii?Q?HCeTTB+X0ZY4D2Bww5X2+aWkEGE8tOKbBQYH3sSpS3GSNUx5Hj4SVmNklJ62?=
 =?us-ascii?Q?UEPFemoTQXA6oXfX6HNmXIhIbqPxVbGwULkOos3KZs/B/BBQNM+Tzm9xS8sb?=
 =?us-ascii?Q?GSYQSpU8JpKDAvtV6P4jswtBB8XY2B7wNi/ye0VrcjTAzSMLT2F2N6xKyAWo?=
 =?us-ascii?Q?K0AHXC3IB6ep4Zhw3hJo/koU0Wnx+YL+MNk/v7rQSvPUtYVW7LEXR6einQmp?=
 =?us-ascii?Q?yP0YN6Q27xBH9Jbt6pFJS/DSxYGWx3iqrqBsxYZpc4TUTWPTSe7E6u8RDa5s?=
 =?us-ascii?Q?DFrUNG5b8qSwtRc6kmGdZ17drFA7KmuF3ItQt8VzeYgkV16wVt96MoZEnMUp?=
 =?us-ascii?Q?RMPsnZTm5T1tnBPnbPCaUOvssEXWd9QE8KD2qXZ0Bp1I080HgrHbeLWhEdHB?=
 =?us-ascii?Q?v/PmoKvSrdevX2WIdu24g+kpnbvuMQe0k7Th+4QNeoKOkQXuEDGQvlfELCE3?=
 =?us-ascii?Q?ZH9QdRSzIuWK9xK0tWhuId485lBTI3Ze4ADZiv23KKboYTH5k0xMqFFO050c?=
 =?us-ascii?Q?ZoHCv8wXn6afx1UVi3nDcFNYbfQeIvSDjdNEA94FGDtpH8oPqbA7GXupW2mb?=
 =?us-ascii?Q?HxxNmz8p0fc25o+rcQB6mdIXsxVjcM6lwh5TDbPIViiH43QWfIFFSXemfV9N?=
 =?us-ascii?Q?fAcz4Z25sKU6xIbc1xpD4zZ9cZKIwgPUtuTfwbooHxUBobN4nWERTxsNwjZi?=
 =?us-ascii?Q?47rYM4omiqbDESK/zxO7PEc8j3lOWBX49ggrutxdfmgWDGfmvhQ2nvKtpRJs?=
 =?us-ascii?Q?nMm3qArrgOxRng/eVJ2YbURPhsA4dwREqooftuADxzFA6VDXidx813HVFKZP?=
 =?us-ascii?Q?kxWaQ+v2YuHFcC6g0p6u4DcbMfyC5dE2Fo5bQMWvhwVeaL+wG8bNTy2Y8Jlz?=
 =?us-ascii?Q?aZdS5D0/BANYMHFWh/D0PihbqiWtZdWNlavLZVCV2Jk6pnkWBkSJOD4/Rrma?=
 =?us-ascii?Q?H91kz8EZp5mg0GGu5G7/3F28uZ94ItMt4Mncb+bh/g4TUWm6HKgOqwyuL56c?=
 =?us-ascii?Q?9lYtkMJlavAahcGLmh4nBQuYkIAx75fuoAtEmEyJ2N1XOhauF4FGoOjzXS3a?=
 =?us-ascii?Q?xqVaJWpFdzEBAjLO22YX30qSOc6d8S3rq1Biw8SotXb7HJ41vznIFN3xO+k/?=
 =?us-ascii?Q?DuJV/2CaMB2OuG5xrVTsiqOjP1OsmhSeTZ0RwlZt1UBp4G7hfZte7Hz/6+xM?=
 =?us-ascii?Q?Cs0PJqHamV0OntHrsmokbpYtSQaOEpBlNw0pGfpL?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bb6fd2-28fc-4026-30c7-08db6bdaaa7a
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4479.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 06:51:51.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QF7qzz2nUheEmVfN+5QFic53PZIlSDBYymAC1YykvHZdeYAwpvxl9sksYH3tbK47UZ1P9mRe3aAVxkSjs1MK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB4784
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch count mmap write io more accurately and remove
redundant PageUptodate judgement in f2fs_vm_page_mkwrite.

Signed-off-by: Yunlei He <heyunlei@oppo.com>
---
 fs/f2fs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4dd4e2bd000a..34a6177c64a4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -149,14 +149,12 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_faul=
t *vmf)
                zero_user_segment(page, offset, PAGE_SIZE);
        }
        set_page_dirty(page);
-       if (!PageUptodate(page))
-               SetPageUptodate(page);

+out_sem:
        f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
        f2fs_update_time(sbi, REQ_TIME);

        trace_f2fs_vm_page_mkwrite(page, DATA);
-out_sem:
        filemap_invalidate_unlock_shared(inode->i_mapping);

        sb_end_pagefault(inode->i_sb);
--
2.40.1

________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=88=E5=8C=85=E5=90=
=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=E4=BD=BF=E7=94=A8=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E5=
=88=87=E5=8B=BF=E4=BC=A0=E6=92=AD=E3=80=81=E5=88=86=E5=8F=91=E3=80=81=E5=A4=
=8D=E5=88=B6=E3=80=81=E5=8D=B0=E5=88=B7=E6=88=96=E4=BD=BF=E7=94=A8=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E9=83=A8=E5=88=86=E6=88=96=E5=
=85=B6=E6=89=80=E8=BD=BD=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E5=B9=B6=E8=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=
=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=
=82
=E7=BD=91=E7=BB=9C=E9=80=9A=E8=AE=AF=E5=9B=BA=E6=9C=89=E7=BC=BA=E9=99=B7=E5=
=8F=AF=E8=83=BD=E5=AF=BC=E8=87=B4=E9=82=AE=E4=BB=B6=E8=A2=AB=E6=88=AA=E7=95=
=99=E3=80=81=E4=BF=AE=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E3=80=81=E7=A0=B4=
=E5=9D=8F=E6=88=96=E5=8C=85=E5=90=AB=E8=AE=A1=E7=AE=97=E6=9C=BA=E7=97=85=E6=
=AF=92=E7=AD=89=E4=B8=8D=E5=AE=89=E5=85=A8=E6=83=85=E5=86=B5=EF=BC=8COPPO=
=E5=AF=B9=E6=AD=A4=E7=B1=BB=E9=94=99=E8=AF=AF=E6=88=96=E9=81=97=E6=BC=8F=E8=
=80=8C=E5=BC=95=E8=87=B4=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=8D=9F=E5=A4=B1=E6=A6=
=82=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E5=B9=B6=E4=BF=9D=E7=95=99=
=E4=B8=8E=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9B=B8=E5=85=B3=E4=B9=8B=E4=B8=80=E5=
=88=87=E6=9D=83=E5=88=A9=E3=80=82
=E9=99=A4=E9=9D=9E=E6=98=8E=E7=A1=AE=E8=AF=B4=E6=98=8E=EF=BC=8C=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E6=97=A0=E6=84=8F=E4=BD=
=9C=E4=B8=BA=E5=9C=A8=E4=BB=BB=E4=BD=95=E5=9B=BD=E5=AE=B6=E6=88=96=E5=9C=B0=
=E5=8C=BA=E4=B9=8B=E8=A6=81=E7=BA=A6=E3=80=81=E6=8B=9B=E6=8F=BD=E6=88=96=E6=
=89=BF=E8=AF=BA=EF=BC=8C=E4=BA=A6=E6=97=A0=E6=84=8F=E4=BD=9C=E4=B8=BA=E4=BB=
=BB=E4=BD=95=E4=BA=A4=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=
=E5=BC=8F=E7=A1=AE=E8=AE=A4=E3=80=82 =E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=81=
=E5=85=B6=E6=89=80=E5=B1=9E=E6=9C=BA=E6=9E=84=E6=88=96=E6=89=80=E5=B1=9E=E6=
=9C=BA=E6=9E=84=E4=B9=8B=E5=85=B3=E8=81=94=E6=9C=BA=E6=9E=84=E6=88=96=E4=BB=
=BB=E4=BD=95=E4=B8=8A=E8=BF=B0=E6=9C=BA=E6=9E=84=E4=B9=8B=E8=82=A1=E4=B8=9C=
=E3=80=81=E8=91=A3=E4=BA=8B=E3=80=81=E9=AB=98=E7=BA=A7=E7=AE=A1=E7=90=86=E4=
=BA=BA=E5=91=98=E3=80=81=E5=91=98=E5=B7=A5=E6=88=96=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=EF=BC=88=E4=BB=A5=E4=B8=8B=E7=A7=B0=E2=80=9C=E5=8F=91=
=E4=BB=B6=E4=BA=BA=E2=80=9D=E6=88=96=E2=80=9COPPO=E2=80=9D=EF=BC=89=E4=B8=
=8D=E5=9B=A0=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B9=8B=E8=AF=AF=E9=80=81=E8=80=8C=
=E6=94=BE=E5=BC=83=E5=85=B6=E6=89=80=E4=BA=AB=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=
=9D=83=E5=88=A9=EF=BC=8C=E4=BA=A6=E4=B8=8D=E5=AF=B9=E5=9B=A0=E6=95=85=E6=84=
=8F=E6=88=96=E8=BF=87=E5=A4=B1=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=BF=A1=
=E6=81=AF=E8=80=8C=E5=BC=95=E5=8F=91=E6=88=96=E5=8F=AF=E8=83=BD=E5=BC=95=E5=
=8F=91=E7=9A=84=E6=8D=9F=E5=A4=B1=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=
=A3=E4=BB=BB=E3=80=82
=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E6=8A=AB=E9=9C=B2=EF=BC=9A=E5=9B=A0=E5=
=85=A8=E7=90=83=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=EF=BC=
=8C=E5=8D=95=E7=BA=AF=E4=BB=A5YES\OK=E6=88=96=E5=85=B6=E4=BB=96=E7=AE=80=E5=
=8D=95=E8=AF=8D=E6=B1=87=E7=9A=84=E5=9B=9E=E5=A4=8D=E5=B9=B6=E4=B8=8D=E6=9E=
=84=E6=88=90=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E4=BA=A4=
=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=E5=BC=8F=E7=A1=AE=E8=
=AE=A4=E6=88=96=E6=8E=A5=E5=8F=97=EF=BC=8C=E8=AF=B7=E4=B8=8E=E5=8F=91=E4=BB=
=B6=E4=BA=BA=E5=86=8D=E6=AC=A1=E7=A1=AE=E8=AE=A4=E4=BB=A5=E8=8E=B7=E5=BE=97=
=E6=98=8E=E7=A1=AE=E4=B9=A6=E9=9D=A2=E6=84=8F=E8=A7=81=E3=80=82=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E4=B8=8D=E5=AF=B9=E4=BB=BB=E4=BD=95=E5=8F=97=E6=96=87=E5=8C=
=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=E8=80=8C=E5=AF=BC=E8=87=B4=E6=95=85=
=E6=84=8F=E6=88=96=E9=94=99=E8=AF=AF=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=
=BF=A1=E6=81=AF=E6=89=80=E9=80=A0=E6=88=90=E7=9A=84=E4=BB=BB=E4=BD=95=E7=9B=
=B4=E6=8E=A5=E6=88=96=E9=97=B4=E6=8E=A5=E6=8D=9F=E5=AE=B3=E6=89=BF=E6=8B=85=
=E8=B4=A3=E4=BB=BB=E3=80=82
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.
