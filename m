Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E86E719D09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjFANLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjFANLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:11:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB858124;
        Thu,  1 Jun 2023 06:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzZ3ZF7+P7vc6sKvzUwQCT+tNevH9+/g/EW9I15KPcwzZNATWgGchwOaL8cNivt1KHJMEJHPzWknYwXgTx5AkmKtDEyzr4tM+yBy+KKDJ8fV5loDOUT9AeGPLk/yIqL5yRhu8ycHT2tcXHqedtPyyMXape0TblvF/RkY5My6x47kdTdgDLcZzer40A6kVr1hBjsCB/WBtlbXk3QRErnfoTORiiHiZj3YJxAI2z5fOJnFTZONjo0Ypc6FvtKDNnCSzqssZV3/QnrW5l/QUlfVnD3L+O1yIDIqaD1ynAULFSScBcGwpREE3ot9eaX1HE1ZxbiCjjofpyxDgaMNioIWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibmkqlQZxQ7Zh/uYYzGwr8c5GTtV+lPG8G/NxOoNm8I=;
 b=SfjiN5AHxh6DpTiMRFmWCbZpS0ynoyYTQJZxWOipA/bHF334tdqw4o/S9DErW9d5KELWsEWZ3mtnhMpj+K7amsAXXdN6yQqE2Xi1zRYbCcTCXtQz9sKVP+sixqHfhgp0lp4XM3vMEJ5qid1H+MOxhRjHILRhbCHjLDdaeHlG2F0qM0oT5avU0K+2OzB8tLh7e88BR9cAo8LytOglk/YMxHUUP4ni8VIyTnp9QNtDTk0opx0a7LNPHEEEUViAbAloOKZeT6Ec4eSgxq+N+DemjtaLvDuZCGMD5vxVfnY8lffRjqfoo7O0bEyTTewhllNJPgs1CxTXnLiIxf5J6eyu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibmkqlQZxQ7Zh/uYYzGwr8c5GTtV+lPG8G/NxOoNm8I=;
 b=hN0b7IYUczFZug8iRZIAN7YZa81y6Mo5U+hsu0GhhibmU6pMNP9xMzaqtOQnazUrHY1E47o0/g8JjlYKHO1DxE/NYdkjbGyBbiBKXztndQM52KeXgtkZBqW/Y4DoCm+Rbu2+LKPBmZTsoXi8Z6gaOufD5qmFGPrVjNG/T58fZ8cE7mrVszKCWkK+HMKAqma3SNV0LICnn5I/EohjhhqcVIHqa3212APtrQWnNlcUlnBN/HXcy5/7jQ7Z5keL9rJ5CjZYSCUn94ZgqW2YMXab2PqxI0lB8xMKR8z18NZlzQTKYflwS4934hW6CWcLntELwdops8Y2dz7t4BEyoikzzg==
Received: from DM6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:5:177::17)
 by SA1PR10MB7756.namprd10.prod.outlook.com (2603:10b6:806:3a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 13:11:31 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::d6) by DM6PR02CA0040.outlook.office365.com
 (2603:10b6:5:177::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 13:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 13:11:31 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 1 Jun 2023 06:11:26 -0700
Received: from sv-smtp-prod3.infinera.com (10.100.98.58) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 1 Jun 2023 06:11:26 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-prod3.infinera.com with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 1 Jun 2023 06:11:25 -0700
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.73])
        by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 0E33E2C06D80;
        Thu,  1 Jun 2023 15:11:25 +0200 (CEST)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
        id 147C2200181B; Thu,  1 Jun 2023 15:11:25 +0200 (CEST)
From:   Joakim Tjernlund <joakim.tjernlund@infinera.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] ALSA: usb-audio: Fix "cannot set freq 48000 to ep 0x3" msgs
Date:   Thu, 1 Jun 2023 15:11:16 +0200
Message-ID: <20230601131116.1014250-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Jun 2023 13:11:26.0234 (UTC) FILETIME=[922387A0:01D9948A]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|SA1PR10MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b0c8af-5434-4d5e-38b7-08db62a1b7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2N2uQaC4Cm4MT4+T4Hz3CK0/NmWYHG78VzfieY4YFCO0K4IE7yjMrKi5MMzT+lxv9ADGFqrqJ0/3wNDixtN5SaT9kqTmoYNzN3txn42zttQvB+EBHO2V5X2ijGIbTr7CkVB6l1xyfUZbLaGC7EEQbNpYUhWZ6DUdcQiB17Lb1j+43SR2Qgb1XPu1hCF9b/VRxliFElb8FJ8nHoMRqmkLAY92XlC4jVdeleuFyGic8XwAeockVFRIrYZTQ1fQ4v0RCtTp9W4IGAnFuRkkjLgE/zdLRWhAo72SxbQEC8aKFfjAV3TEHktH0pZf8MQFiKMCdpSNAK15HkjO20UeYplm8Ed0Nfm1GLb3UoATseubEVjSh9y/E7d7VM+87DNbkPwZ7wJFIZTJYr4rwDeAwh2IfnUOsmwKxzgDjiKbES5RnilosiokTYOEMbzjhDaNmT5qHXLSIQjUSy1nMNcbh3dVSg8Umsm7SsGFWoYkjyCl/taQxgR0xjGOsgTL5CE0biyCv4bLNtcQdF/YemlYBvJuDQwucb8YEz2msSaiVjvHNBCR665w0G/l+1Z3edYZi5lY1NAxjtIMjwV7y73vl9wSHyll4ZBf6tUoXtU6705j4aKzobr7lG3mtICFhO3bUJU+nj51jB4UMKyJuXan4S2Gkott54DFyrpegqFTqKu7/KObHdJ19rq57WJYePcuYdpl8IkYt/CCqGdrVl7ZCc1Qilbo/65J7ZfuaWEkJrRriz/wUS2oIQZE/8SyiZF3EA2
X-Forefront-Antispam-Report: CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(46966006)(36840700001)(42186006)(54906003)(40480700001)(478600001)(110136005)(44832011)(8676002)(5660300002)(8936002)(4744005)(36756003)(82310400005)(86362001)(2906002)(70586007)(70206006)(450100002)(81166007)(4326008)(82740400003)(356005)(316002)(41300700001)(2616005)(6266002)(186003)(1076003)(26005)(36860700001)(47076005)(426003)(6666004)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 13:11:31.5817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b0c8af-5434-4d5e-38b7-08db62a1b7db
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7756
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some USB speaker devices(Jabra/Logitech) we see above error
msg when connecting device to computer and kernel is probing the device.

Moving the snd_usb_init_sample_rate() to after usb_set_interface() makes
the error go away.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: stable@vger.kernel.org
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index f10f4e6d3fb8..d9ac8663a48b 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1226,8 +1226,8 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 		/* try to set the interface... */
 		usb_set_interface(chip->dev, iface_no, 0);
 		snd_usb_init_pitch(chip, fp);
-		snd_usb_init_sample_rate(chip, fp, fp->rate_max);
 		usb_set_interface(chip->dev, iface_no, altno);
+		snd_usb_init_sample_rate(chip, fp, fp->rate_max);
 	}
 	return 0;
 }
-- 
2.39.3

