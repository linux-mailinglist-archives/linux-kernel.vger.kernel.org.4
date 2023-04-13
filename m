Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76CE6E10C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjDMPOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjDMPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:14:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F3C1BC9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7QUw/4PJbcrezL6+dKCld9eZD+vDL1BssrUt+QMoA4yVZPgDd6MxTTCfcbbdpptrx744/UuNEagZPucpG9HWRmNeLFgnjU2I6oCqfu7IHgEZLyUuFcFH0FHzITj22QyYDW3vSaxYreV9pyJ2esDiu4DdPwfeR3TcMWV29pPxaVbrLa2xdOewqdiyFmRQqdR1qrqU+s0JGsMIvWru35efzc7KkcJ+5xyJcUkMINNLwzh7fHvtY53DWXFyBdweW7nLTb6zdPSFrYjbEzjJTTaIOnhK6LLp3Ot28pQQnX84uLzcBGWu0djkjlX8qy1aXj5l+fU4yohSUdrfaUVgbjm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I79xeeh3XOzmejbNVrSAP9znICKbpyU8CDPpMrovmPI=;
 b=AZ2GLt2L9V7JOzXcRbrdjI8VskOLwhQd7VdXBn7L6acnqpZFKFxq0qzl/AFf07I8iGhjdEDXkNqEudYfvyCeA37jBrj6PzL4n3uEWds+7bD4wfSg67G8LPXJaI93YNVwplkJlr++hpvNSWpNCSFExVx+HpVWTY2yrUFCNEly0+a4M/N4Ceh+L7gkyDO6c67bTsysCTfB1X27lkW9BV5/x+5pzDC0wrufDtnl+hV5GkNbAiXdtRfUFLr55h4gvC/PGUI9ribx7kVv5PDFfrSWHi2qzoZphzZya+tkoJTBCgMbIHnHtac/3kNMIVTW0r8QYdnUJrQzPotbfKWmgBC6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I79xeeh3XOzmejbNVrSAP9znICKbpyU8CDPpMrovmPI=;
 b=AKCyzRxPfyb865IToD0AdpxoKLe1EbxfvjVmG6DnpnVZaQFUlaxy/xB47yWxMW69Byg5mlFMSn943XhcuYubZCEWfg+7UAi6HeevirRwVsPM6RdoRFjOTrBHXKnIohARhgiBEaWQI4bivd7cQD1+ftKDx39xl8svyKXg1Qz7Vz0+jMLzLgZHzr5idFvxdjhl4+aQzxzrbO6aSyhZuNYwxh6G2TbTsFJHSW0F/+2bknKJwhBxOckDhDFBApjBTZnEpITRMMqe6icL8FPidqy7gLaZFS3FN64JAoyw2h0DbFg3Goz3yXgh3sEr0FcDdfFgMpYQItG80zs+FutwaGcbUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5419.apcprd06.prod.outlook.com (2603:1096:400:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 15:14:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 15:14:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jan Kara <jack@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] quota: update Kconfig comment
Date:   Thu, 13 Apr 2023 23:14:12 +0800
Message-Id: <20230413151412.30059-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: d6046deb-18d8-485b-f8d9-08db3c31c567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aV97BcDrPv18FQC9vCHz48bnNvu9R2VL5BFodqijgrcGfhBMOd6bVAn5KAYSxOMuenf+SxUokF/YOOOHoGREAkgc/dcRDeTtqkhUewwpNxbCRHiVWKFEexicwM4Iz/0SlyFhtVH9YlmAcSI0AmiagVjIHPESIwLTkn6svwIdCFcrAq5wd1yl856yORHu1/gYzll/WvUx/l0akvHNYgwoVGcrSx4H8AgORYOOesCn2yVRgDUmEaXUda7lOCSV/81qkfn2DQ5Ke81DZRFXqVHAg3TdH2tgNDq1YApBEKNGOd9HBg/gAcDGQ5zBUCfD/nNIuXaktMjczt6N0vNg5GKELSwUCklq+eC/tCKwl38aOfu3S69ruFgf7IdTFbcNZNb/5G6Lt4vFmNRzGLeevonvAC6iEQGZz//czrNlZ2i2h/aKMXsl8icbFXzTBPDRdlfkiivyrlqCORmEiFclHd0F2/1yyuLKrjhS3cGGKa0ov8zivxHYIls7QjW0RjYy1KpMV7QFDdihKsWwTKqPWafJsyAnZEo8lMp+UtteU9GeGFiVhFod+I2iDB5ec3MkQ4CxbIr0EEQgN+iBKx4RF/xkAujhM6+w0tYFiqh3LfkqBZRBQ3Udw9ApS9GAsrE4AVuZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(8676002)(8936002)(41300700001)(5660300002)(15650500001)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(2906002)(4744005)(478600001)(86362001)(6486002)(38350700002)(38100700002)(52116002)(6666004)(186003)(1076003)(6512007)(6506007)(83380400001)(26005)(2616005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qQ/sz0oMXdlUXmLcswo16mXuux1P65PRfv24w2JSUWWhp8m0tFgq5orvTf5?=
 =?us-ascii?Q?FvgZzqBFoHlmI5+Z/H/GYsHUbW/vdFUhFfaCzjM/7N5aFL9t8nm2hUC9uDCp?=
 =?us-ascii?Q?h/xJyZX/jwNtKkr897BN7T+AuMUqoGhqLX5m1r/P2lIqHjfVRLjC/8+h0rY0?=
 =?us-ascii?Q?GwAc8favTXj1vvlbEm9+twJtDAcj7GUeCbbdDaN/ElY4hnDacO7OSvKDwow7?=
 =?us-ascii?Q?m10BYIoYqJSk8fA/K3JvUfyyX27BDCHw+z26etEd/0L61as/gEaZFQG+S+dZ?=
 =?us-ascii?Q?LXJ7P+doy6151aR24uV1TN5yk+pjRjschDv89QaTtubEaqHLYQph/ql/1Wyf?=
 =?us-ascii?Q?VibQaFoUU8zHyW/1QqgjDuhqqTSOZpPZlCvhAJKcvKGrskShbdOrp4tEmNsw?=
 =?us-ascii?Q?bvGoBVPDxzW/KPMoRqnk0VyuXEYf5RCY3i318eTczuSe/XD/IfNoWLcVtiyZ?=
 =?us-ascii?Q?X841tlkvR8cidbt6M+AAAO7eSt3IR5goRrHFPmpsEoH9QGS0mqC6Evv2vioz?=
 =?us-ascii?Q?LRwSElp5vT0o55EwPSiWk5q33SWTF15cDTcGtZwb09gw89j+KPe4UDOVuyfI?=
 =?us-ascii?Q?o6cogNM2LipKQVUeF6CwgmJqxpQxy/FtV9KGU5+pYuyAViGYCVFMsIsHEFA/?=
 =?us-ascii?Q?hrgyBkRlplzCnxebLwNYwU4hDNDP6kPamCpxhh7WomJpEzbmHhnIDgnt5sx4?=
 =?us-ascii?Q?YRlaj8fK1G2d32ZzPlP7Sojdl7mYIzarsaFOHIoqaWIXlqbE3kHDgxQuninY?=
 =?us-ascii?Q?9PnQ4XtT2kVoGzLUpmECndCfso/vu5bxCDbEloE6V/gv6XZ2KgZggUSBQwY5?=
 =?us-ascii?Q?CGa3BGNHsYthwrXblHXklMncxuKlNXbmyj0BqypKbigBFq0QhZxX591AFSal?=
 =?us-ascii?Q?PQlzvg/bEwciX67jNQCkjQqiqjPgTCSNnciI/K2oQjzsGAZE1BDpggm6wSC3?=
 =?us-ascii?Q?Typ0Cjq8PpKJIGa9x+k9waOgy7GEm9bwHTYhFSJGhIVl0zx2uqrKpanhhKZX?=
 =?us-ascii?Q?yHwaZXDy8WQbEdyDGRizzOXknFw0FJx43EoCYRLxdyEkAu8OCnUcXbmngF5v?=
 =?us-ascii?Q?Tdjd7/fC7TTZpXqO69/Y4YXHf46YygUw/vLG/nPEAEZEnO6g+Zin4yh6seMd?=
 =?us-ascii?Q?ICv9OBYUGxkXfJSmKQ0jcwkuAfhuLtW/vkk+1uXd27uTxY90BhiivqYAz+S3?=
 =?us-ascii?Q?/ygq6mb8sgc8ufI8K5MRW4Ephl8XwzGDIMuVkg/itD3/E8cVvZObJ1ua5w4U?=
 =?us-ascii?Q?R+7t4FcPGL7lTiDCWBgdI4V5abtJyPDZT/LTnMQ4+LzKlXyplKh18piPy6lY?=
 =?us-ascii?Q?VTewxeFG3yU9ZIzDhuPrtWCYV7PABSaR/nudHuQ37cwASyTFEf1qIA6zaFWW?=
 =?us-ascii?Q?8YA/ctmTYQxntE1x0R0Yy6Q+5LL2wv9/oZWiY4t33I0Z9xPv+W7U4hHOhoTb?=
 =?us-ascii?Q?xlxa5dtGZ2ckw/6kcc1YRAR2y5Ry2j0nmv4nJaIj7cTUX0JDBfaaIU6sVMv2?=
 =?us-ascii?Q?mrIovPShDpDhJsM4jrBTYtqI2SxLt7QpW+A9O0Y2f24ZAoLoz1Vfulaz39hH?=
 =?us-ascii?Q?daxD8WR/Sk/zno3aB59rqHq/CjSU3aVAZwokHX6V?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6046deb-18d8-485b-f8d9-08db3c31c567
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 15:14:26.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwjF2iprvjvLpYGkNzAiEp2ZgzcrWFCFhi2lFt0w4ggzJrDGNGJvxbCWoZFkuMb9kNoHkRcGiVL7ujKNgUiRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5419
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs support quota since commit 0abd675e97e6 ("f2fs: support plain
user/group quota"), let's document it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
index 1b3bc0a99515..9286037e1dbd 100644
--- a/fs/quota/Kconfig
+++ b/fs/quota/Kconfig
@@ -9,7 +9,7 @@ config QUOTA
 	help
 	  If you say Y here, you will be able to set per user limits for disk
 	  usage (also called disk quotas). Currently, it works for the
-	  ext2, ext3, ext4, jfs, ocfs2 and reiserfs file systems.
+	  ext2, ext3, ext4, f2fs, jfs, ocfs2 and reiserfs file systems.
 	  Note that gfs2 and xfs use their own quota system.
 	  Ext3, ext4 and reiserfs also support journaled quotas for which
 	  you don't need to run quotacheck(8) after an unclean shutdown.
-- 
2.35.1

