Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C836260B966
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiJXUKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiJXUJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:09:16 -0400
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D322DEFE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:29:03 -0700 (PDT)
Received: from 104.47.12.52_.trendmicro.com (unknown [172.21.19.58])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id E32911004F124;
        Mon, 24 Oct 2022 13:42:06 +0000 (UTC)
Received: from 104.47.12.52_.trendmicro.com (unknown [172.21.183.236])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 8488C10000BA7;
        Mon, 24 Oct 2022 13:41:06 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1666618861.342000
X-TM-MAIL-UUID: 9e157397-6108-4e9a-a759-eb7011619f73
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.52])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 53D311000031C;
        Mon, 24 Oct 2022 13:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLNcJSiMspqVVpOrI6lzd4KwWo4QmoCRa+Zh1Y6owt7HKsKDC22Bx+t9FMMOmDJMBqweCvpXTxPBzmzdUihzldJNxWI6ri0lHI5P16fXP4Kn5r61ZOqT132n6dK61tcJCX006EWJM5qQ1Qvn6QDGjmR5XHGjHNz9fFtZWAM9+xiqEjIUZA7FO46KcU0G03lAHOqtcmuRNEJvwcE8c3w4NAwxG95LCA5WFovrvpb4nSpUQfHzYCwPyRupO2W039X0eNCzWM/TxALGGD1DQy28C8PcdKTEpES/JmsaruMpvvfm/4hAMdbqYM5cEAmUxisBssBldgvzr0qmaWsrztDRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUCWsYwSa4f8pb0D6lRzIM8Sfo43/oagQfT7nF480BU=;
 b=ei13Jny8wdZ78PS5poVUjNrYik/orMK8sN6fnhrUep1A6qidlMWmTatInt4U7omhy5WTLVFW0WjQQa2GoaxQewROjY+G8rXvLmAsuA4kv0yryRx8sBV5ddiCQr7b2NwfrwI3PWm06SbNLcqLb3I/5z4sG/gxo6lUfGuPpjhco/seb94NwKiDiATjwuwhoWo2VMuCjV/ZGcrM5sJAQ5ihUpRaWCpg4PnFngKBL9QHmxJkgSNgCrqJrrpRLo84PK9PhXGM5fyM77dKSWSzj/JpR64p5ZqqQ3OMoKCChxR/RqS/L+gApj3dw+00eao57AeMlN6SMDO9LoDjW165pBu8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=opensynergy.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Igor Skalkin <Igor.Skalkin@opensynergy.com>
To:     virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
        mst@redhat.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>
Subject: [PATCH v3 0/1] virtio_bt: Fix alignment in configuration struct
Date:   Mon, 24 Oct 2022 15:40:32 +0200
Message-Id: <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT010:EE_|AS8PR04MB8770:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 11bd2c82-b347-487c-ed2a-08dab5c56289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNotQ68KdvfvC3Gu3/kouHfOkBn65H/tdz4+7vbkZsIU8qXgpojMbmGmVj6EJCweEHacTEQocSWV9OwPWOkG+jRy8UIxdI1u96piPiFhXBjpGv5H3mvcq3RbxP2D2/NqlE1GUs/8ZRjgUiji6BvsvpuCaAGUgkY1t6obwE2J4TXqyq2iGNodjCw79MGOea0SlU1rt+LfKF7XkmuLWX3Z+dGUYa1MxPIzAM6R018atxD6Lx4nOEypDnACOsVWfb+7UK0eMpsNwbCmqqWlxCrY9ecyeLNWSXKb595KVEvt8IvlveKS3IYRagT4XCKAKv21UJNvKjWmvjEjpIje0T+zf75JhhEp+PIkJe0+lvPsoPzpW5bBryPLUSl+UQMXtI3qtbnAMYbul9C7htfDcV6FhBQgyDnOmmIR0Zo3IvCQwqIxcJyxpONswWn+so6F+MUA8fPTB4XP/T57qxMdQf5TOyEy+Dvnac05+Hk7VbtobsLTm0qSnhq33TeqKwJJRSTGEvcmrN9iBKUgecuTQ6r7/uGhGrtzQy/PV7tAoeH/fPvbFkCl/AqUJDj0BlTSWgxCvNyXG8ChJW8OLd8UUmGsuDYHxfH/bT+KMaainBzlym4fdAtT1rNYi2oVNoW17g7I+D5WcoU6TDP0WjPB0NwFJvvIawgmGJHuDN5VLrKvUOtrDhdcWU013PbfsEp+d8iq8UPZNSJgBbzpZmKVRhp8UaO/WWWgO2yvC3Igi1NGFGsFL400/lCjzUhx76tMTpVuEi3nGByFudOdfbd/1I9/J7hrZ6im/F0a5Lm1ARras0A=
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(376002)(136003)(39830400003)(396003)(346002)(451199015)(36840700001)(46966006)(42186006)(83380400001)(316002)(86362001)(41300700001)(4326008)(36860700001)(336012)(40480700001)(26005)(2616005)(186003)(1076003)(8936002)(2906002)(8676002)(5660300002)(107886003)(70206006)(70586007)(82310400005)(47076005)(36756003)(66899015)(966005)(478600001)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 13:40:59.1956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bd2c82-b347-487c-ed2a-08dab5c56289
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT010.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8770
X-TM-AS-ERS: 104.47.12.52-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27220.007
X-TMASE-Result: 10-1.841600-4.000000
X-TMASE-MatchedRID: k/56TffKUsg4vjIDbvA3OMVUBXy8OM3/M9EkAUzyluGAI7Mvq/sL57ek
        d2LX0DpINaAGdu5Ot0eXJbVmtnHrxnI0shGAc7FenVTWWiNp+v+wQ8dOma+kqrwxqSK0GSPRjFK
        /NcS7G4llfaF/BQ/tikrFr2FVZxb3hYCiPfz7etn3dt27LH8hnKxAhf/GPomfeGHkpR2WBaL6Pq
        wEmsq4onoKNsImo9ohuXFEQJaCEz7+OhQWBlKflRRFJJyf5BJenOXVXbtyRcZUMLUJu4leYyq2r
        l3dzGQ11VrbCslo1IPzdrwMaU6LTMVEUeIHhCKcPpsnApkCOkM22y3gb14N8g==
X-TMASE-XGENCLOUD: 41de61e5-7a29-48f4-ad5f-068e5c6e9b47-0-0-200-0
X-TM-Deliver-Signature: CE0A99EB907CC0AE3CBC5D1BBF2D5FA8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1666618866;
        bh=LiTSONCq/pWfBg/3qES81Hhk0fxoeYLdcH3ISspf2kQ=; l=1320;
        h=From:To:Date;
        b=oVZJ+pBoTFsa4Xd/jB8f0DpuLtbmjpVUqITQOthmUe3ttiqtGp7eFEOBBHR4nn5Bg
         Q7GHFoorleOe9bsYeysXYonMdvOMF1AZQh2JjZS7DkCTGRHgk7MR9NuG3hl4tTZgko
         lt+5Zfforpes8Y4MdOKiSnhrCiV/iT9vKgUNa4T9jQjIwaJQMemHvR1zuK6YZpgp9V
         h6BvFqmCG6UPUWYhYErcQIkgGdEdwEmPWR+UY9pOjOFCG5LNEO8jnRR4Ii94JoUtjH
         0WRMafcZ4Q4yFUfeTlzl35sANppmraAlwnCIvSB/ktqEKNTD21vThX006VDQWpJxiN
         8cARgnxGIE6nQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to specification [1], "For the device-specific configuration
space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
and aligned accesses for 32 and 64 bit wide fields.".

Current version of the configuration structure has non-aligned 16bit
fields.

This patch adds a second, aligned  version of the configuration structure
and a new feature bit indicating that this version is being used.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf

Changes in v4:
  v3 was corrupted by our smtp server.
Changes in v3:
  v2 had been sent from the wrong address, fixed.
Changes in v2:
  The first version of this patch just changed the configuration
  structure in uapi/linux/virtio_bt.h
  This can not be done, because it will break the userspace, so the
  second version offers a less radical approach - it introduces a new
  feature bit and a new configuration structure that both the device
  and the driver will use if this bit is negotiated.

Igor Skalkin (1):
  virtio_bt: Fix alignment in configuration struct

 drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
 include/uapi/linux/virtio_bt.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.37.2

