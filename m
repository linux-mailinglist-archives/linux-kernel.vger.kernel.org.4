Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97138718061
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbjEaMxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbjEaMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:53:40 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C4618F;
        Wed, 31 May 2023 05:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0ciAkZD/R7mLSnU1UgrMIvgTXDnECbZGKe20iMEuQXFAEY5juNgfdkLWd/u8LxhKDSaYv5FqxDbPBf8pyEzFt0nvS7kX5qvZ+G7cMLbBu261vwLXjfLGBgv7nJ03LlDCiwzZu9RtaxqwvvciAxmq/B6OMC0Jb64+k8TMX01YDA0FBF3+XoAs4YsjqNW1DLECvTJ7MVRBt99uaf0mjSFVlE0e1kXI8ee8jTIWF2ib7N6l9v1stb20yljOvN7aCQtx/NSfm//gc7+S3CxwAAvxeJMLNfAlRGeTVm8cPqHqJjfwalHoPiNx1A+ypYJz7FOP2kslLJXWWauyVWMdRanMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koU6nLiaAfJbBM43sH2p12iYxZrKONWFIjtcx17l61c=;
 b=QacLD8OvkfNXd20xf4fUQC9cmGCg1YVf2XF2Kw2sy8GrhvZiYAoJ1kIP+0GMtq/4Ps+0TfH6dkY5EjMxWNayVEUrJiy3jEzzukaL11qQVsFu1MMGpGwObl0tVy8t1xMdscLwyo2THEeZQD8QemMy7x+3w1Cevm2bZPdosrJLT9XBk2KTZNPOVZVM4ajEyjYgNXz9xZozYfCtVfMGVYlt94E3vBxi2btsEA4U/khNyAUWIeBX4qLQ881rfh+iI0x2ybbbxx75D5Q5EnZguVR/2zVWOA8Xd0LOEUiRGw6DJYKqkuiFbUHZB4d83gUZBD4C5PyEU5ht1HjLxSf64zDgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koU6nLiaAfJbBM43sH2p12iYxZrKONWFIjtcx17l61c=;
 b=cfTreNKz6+4n3icnWLxbu7/5ZTOT4yBKTs2NgFrN2+tcVDn0Wzbq/Fo9PTk73p2gpyhvzhCXqwRGUYau6fRdJtKwb3hkTSv/U6LwTNYTnE8pqySV01HIL67olmGai+qL5ZLFHas8ArJZK5fXEdItCLPUZK9YMUkVBBsD8V0bmaBQ9ECjOJ4GoTFIcmEPe0DQD9oizCboZHaqzneNgqHUF24S/qslNoGX/CVypsWk5qoEfAH8n92rvhQL7lZDeOyqia44CLZYy2fQiQlaZHesmha8JblYUgsBzUW/1VqUu6GbqH3a/iXvxCoQblCDpFPzsjgxvEmMkACgUfvaxPJL+A==
Received: from MW4PR03CA0111.namprd03.prod.outlook.com (2603:10b6:303:b7::26)
 by IA1PR10MB7537.namprd10.prod.outlook.com (2603:10b6:208:457::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 12:51:54 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::4d) by MW4PR03CA0111.outlook.office365.com
 (2603:10b6:303:b7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 12:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 12:51:54 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 31 May 2023 05:51:53 -0700
Received: from sv-smtp-prod3.infinera.com (10.100.98.58) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 31 May 2023 05:51:53 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-prod3.infinera.com with Microsoft SMTPSVC(8.5.9600.16384);
         Wed, 31 May 2023 05:51:53 -0700
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.73])
        by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 66D7B2C06D80;
        Wed, 31 May 2023 14:51:52 +0200 (CEST)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
        id 606F120062E8; Wed, 31 May 2023 14:51:52 +0200 (CEST)
From:   Joakim Tjernlund <joakim.tjernlund@infinera.com>
To:     <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] ALSA: usb-audio: Logitech P710e: Add quirk to fix setting sample rate.
Date:   Wed, 31 May 2023 14:51:48 +0200
Message-ID: <20230531125148.892100-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 May 2023 12:51:53.0524 (UTC) FILETIME=[ACBC6F40:01D993BE]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|IA1PR10MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e173674-6799-4914-5be5-08db61d5cf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00VQuRD5EGI0H97oSUkK9bslqWMs3nkmTWtkbcGMSSH2IBrwy6BJLtSv7Mc6XpmqDWAFn9CXzFCszWpSRZfnaUURKHJ4QBeIQ6R072F90PCQHP7l3uWRtKOYUdUoupLbLm2zj7uS/Mly3JWMLtkMf2qQDEkXvRAg+P65LV0kZxKyZZqs6o5c6VjL6BA90RN2UO3X5FO1tahoVFL7Lk9Sr2rwmOO++YeW2Erznjgy4/2zG6PX9XPNB01lw/mtq6AFPAXOD5/Kp2EtIycble6c8IHSI36jBYPi+PTGwc+Y2ZEwaV4PYB9GKJWXXJaTsuTxTi69cG4nEDNjT3x6jRUrs4FH6HQReB5b9a6Dz1jDLR/Pz3PzBQ/ZmRxYJAHYo3xv5W5I3c2OEo85q3hUjzoUD2PiRhP4aGJFxTXimOa9C2cYjk4oSr4cNnf8L7kU7RJ3ulB0ZIWRhKU2t37AwpKC59ZSgKq2/aU/HOtVTYSraKgvbj0jk6fuXZOGEsqUobrFZrz5d7AHSLyMtZNE6c35SzesLU8rpuGBxtbKRssHC8mKHGtZBZpJeubkMY+wsXdGtBmQ7X6MWBZdZCAcCjCco95ym8BhYCOZKEa4866JexN65kKh/+wT/dYyYoRtWp06LJ8AACYbHH2NyLpRjW/6DHkO3FtMTQ5MI1ysFYaNbwYNlrJ7ceV5VhV5DutVYO3naOHhLwOcksN0ZLJVFyr6+Igyi26t7r3UaLbpKWh880Y=
X-Forefront-Antispam-Report: CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(356005)(82310400005)(81166007)(82740400003)(36860700001)(47076005)(2616005)(83380400001)(450100002)(70206006)(336012)(426003)(54906003)(70586007)(4326008)(86362001)(110136005)(42186006)(478600001)(2906002)(4744005)(316002)(186003)(6266002)(26005)(1076003)(36756003)(41300700001)(44832011)(5660300002)(6666004)(8676002)(8936002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 12:51:54.1229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e173674-6799-4914-5be5-08db61d5cf98
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P710e, will throw an "cannot set freq 48000 to ep 0x3" error, no
matter adding mdelays around setting sample rate.

Only way to avoid it I can find is to avoid setting it at all.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: stable@vger.kernel.org
---

 I also tried QUIRK_FLAG_FIXED_RATE quirk but that didnt have any effect.
 sound/usb/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3ecd1ba7fd4b..8277bfd3deec 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1952,7 +1952,8 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 {
 	switch (chip->usb_id) {
 	case USB_ID(0x0a92, 0x0053): /* AudioTrak Optoplay */
-		/* Optoplay sets the sample rate attribute although
+	case USB_ID(0x046d, 0x0a4e): /* Logitech P710e */
+		/* Optoplay/P710e sets the sample rate attribute although
 		 * it seems not supporting it in fact.
 		 */
 		fp->attributes &= ~UAC_EP_CS_ATTR_SAMPLE_RATE;
-- 
2.39.3

