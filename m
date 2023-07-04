Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D996746830
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGDEBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGDEBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:01:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10FBD;
        Mon,  3 Jul 2023 21:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqCoVCqhXI/mpZrDN94LVkFdy1yuNJBYA2DacL93KtQPGdSZcSfqueJ4HujBEisdUXuusHeF+JMTiv4CFP9Ht03NXWWe8DrTNRy4/XD0yTRHFK4ZKnKcCoCZWj8ySQWoIKMREdAJQBiH9sNnSFe44Igx1YfslUWAzvkJ1QmI7knvx53uEjb4ZFF+6Xv0ZNSVmRHiCqwIkDSh6b+TcXnYgz6+7N8infcNHZmVjJQ8Oj0WKCPLB90vnJAusrB4mYA7iXAhNQAn1W05Yzl4mVfiLvG2acBytdfgXEYeC6KbNRgSraZm05Lw6CXuRLg0n5SlErnndZ2ZBwtoYNDQYMfJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pj/olEsbQcMMhLjC/sOANcpoOYF3GIuvyudyhrik1f0=;
 b=jBNETjzro30IQiVujUtXDdk7UlFYH57BTRwFQSYxKgUQX6zr5zJFmAlBmzXKXYKIhFHo/hCLk2fBw+tU96nwGUzmwrLQptFUxxT98RGHG02zEwNuFbBZmHIH5Tu2PqssO8lbgqkWmK2L5BO9LRUQg8mtGuRGkwzjOnhSobaymDerSVNoe70ktdFFd6OvMeiEFiq52kJRuYtp4TQYOWe4fIh8aBnANrPV36CzS0/7n+omfiaVnMk3Qjj7oaEHK9IJbejxi5cPbZlgfJqmNp6jZGdIndY+XdK3G4iXjX1ftbLbDTUphmYUIYXV1BHeWZcFO/fIRcpMj8DVvLRX0rjHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj/olEsbQcMMhLjC/sOANcpoOYF3GIuvyudyhrik1f0=;
 b=YYAQTa4yyWm48/BOBvkHiIhRspLPSeY44U0asnupbEcAGOWLe1UaXL9QEnWUlSSdHxnsMlcm3qpX5V1loY858kFr6re8HKNkISNgbc2QPfdBiPn7ZShKPPV8VUR931JJl+QqgCesKI9zcM0uGssocqGRb3FX0Gc1BaKUddpgWBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CH3PR03MB7385.namprd03.prod.outlook.com (2603:10b6:610:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 04:01:15 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 04:01:15 +0000
From:   Hsia-Jun Li <randy.li@synaptics.com>
To:     linux-media@vger.kernel.org
Cc:     ayaka@soulik.info, hans.verkuil@cisco.com, tfiga@chromium.org,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        hiroh@chromium.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org, nicolas@ndufresne.ca,
        "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
Subject: [PATCH 0/2] Improve V4L2 M2M job scheduler
Date:   Tue,  4 Jul 2023 12:00:36 +0800
Message-ID: <20230704040044.681850-1-randy.li@synaptics.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18)
 To DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CH3PR03MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 885ec4a1-96b5-4199-09e6-08db7c434bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6cXcfrPeNFLnwzXc2hukfougmjOBXVdPKcKT+ir+W8O4heasf+IGP8+GzGS4W0TQfryet1CFtAIJplIeE7pZtUqE9mMa9q0VXZbchkw/3o3Fb1qanmM3hqI0PfHe2tMRy8I3N6xF0Z9Iq26/6XTLWnOZhLQ9PQ596+O3IXqwS+6Z7e3veldmanwK0Bg76WKBo7mgw7pFDx9pSNwhtZeeH1T0acNCaPJKrhhfUzu2Ggf1nkXEq3HJewqFa3cy+cWsq3jjIYC2MIufq/VA4Xcfxgep8wM6SgCgnnnNAtToO0tbzXkBcpeAr9FCkGhZSzF5s3jUP+sO8ndeqHnG63sTsFpDyCo3au7qESXEHfXHXNV+fMcfck+ZRKQU3SVY6XYsHPgFWnAoSfCg7cwO1baz8il+Gme7dO6f18JH1HRPNANncgW4/4BqkphrNOJEmJ74Z5bYcMCR1tfpbjTf1XXdNGFuF3muNnla1dEil9Lbn6ni/viWcg13XE6/0Bfec5c5+q+FfPMHs6TU2Hte2P5eF23MmnsxcbS4tCACwlMKyjRCexL7vT3SSBxGmbGROObGxVq6Sg0pusPFNdNff7SGUFgGI2xmWXrTkqKn4nu+YsUc/wZqdnxwqhSp0TDI0sOu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(41300700001)(38100700002)(6666004)(38350700002)(52116002)(2616005)(107886003)(83380400001)(6506007)(26005)(186003)(1076003)(6512007)(86362001)(6486002)(478600001)(316002)(2906002)(36756003)(66476007)(4326008)(66556008)(66946007)(8936002)(8676002)(6916009)(7416002)(5660300002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QusyktqzlazVPE+xMKNQ888yEevjygxBfyEtWFvICy7nQf3Inur9iihr1Mi7?=
 =?us-ascii?Q?D/aBXuw0KgZBjsgKjCo2ASngqDc/tq5qdMpE6Bp0Tn/x2SE6837xXrzYaRzT?=
 =?us-ascii?Q?dHrTOw7L19CG7PBQuWFyR4D7bZPTcMErcgzkoXq3PL0vPQE0MDEGRa3y3b7h?=
 =?us-ascii?Q?4h0horG0juy3FS0xfwlRZ5duSny66FKQLifUUMzY3njILvjSiePXYmwySGqq?=
 =?us-ascii?Q?PjNZxdbmaQhqX9Oob812ho9059gfOFa1WO0qMKdCi2ccSwZO69XuaDA1HSjd?=
 =?us-ascii?Q?3r/P2hdcLXWymWI7AcSMkPp9WYWZK26xqxRRtQiq2akMncibSXicKEHcs9Id?=
 =?us-ascii?Q?YMkGUmR8IUa2AmAiV1Oo+S+lD7z7AV391t5YKTGtOIAVDjcCyKLl6d9nbXtD?=
 =?us-ascii?Q?JIXAf1Jz6HpOSCrD86mPOQNYWudS7T5pNCwjarfr4xT01UsM3vfxgI/WO/E8?=
 =?us-ascii?Q?z+SxOuqzUttcTrOWspSdJqseFc9mjkZSRn9Qmbjs7MWbpPjKuUp62x/E2IXL?=
 =?us-ascii?Q?MCAKG+91STm59MTrtv2QLr9UhFcJMMJRoEscrZrvozIKjzhb5HlEQXGM71FC?=
 =?us-ascii?Q?+BIdurTEEWIercrC+/2OGrpvLb+0QAGPqAk4G75DJHObt/QlRFtBsDAhO//s?=
 =?us-ascii?Q?sNne5ucXpC6ax6GqqCc9VmxN1DZzY9nL94G4czE0o3UThX7i645HkvWMD0hm?=
 =?us-ascii?Q?RfqEvbBQsib+SiKKjDuxB6EuEncONJtuvQxKxhpH4T66tc3Hz7H5MT6oZbPt?=
 =?us-ascii?Q?ZXDw+UVDnFeQc9i9Kg0G4DBOKciCgG1ooC594EHQbuwonbYRbIuVlNn7DY9/?=
 =?us-ascii?Q?I1lnVH3k/aAw2XfDZYmwfdXWxrawNpLlqF1kJdOfwpQ/MItU/jEYW7TOFBhV?=
 =?us-ascii?Q?jmKaasQckzWTa8ArESBE4N7z0SYyXpn+nsaUZbX4N50lA5xvp4tofz6v7ncG?=
 =?us-ascii?Q?Z9m1X90M1Isf/SxOyVj57fP+j1n4GX0Dpcoc3uGJd8dJ5ZHNnTU1lb4V5zv4?=
 =?us-ascii?Q?40TcUUJhKxjkRtgymDIaEw5OkAcMCeNZAG8xE0Ej/dtDkjnvi4do01cDqeyn?=
 =?us-ascii?Q?2TRbApbR0usY2nMNk/JvxSmHKuHYJg0u7tbAHrDE8prVIpfnYgRPhQ5rGnA1?=
 =?us-ascii?Q?Gcbs76OOynVlnD/6cBT7ohEv7Aqlpg0eqSQdNDD95ameGWz188+LeDaG97Lv?=
 =?us-ascii?Q?mZ6QOaed59UbWokVc4gWxwhf40hLdV2mO6dJ+Qjyg0qa3aF4/kuJeT4ZZekw?=
 =?us-ascii?Q?qV+cLJm3K5H055bWM9R7mqO3Unw3LMnpgF0s2nQLQd0MnCAkFOktHNnhMIBo?=
 =?us-ascii?Q?uIrBvJdy8UId40GPENcSh1EZv2OtgQwyZTokDBdT02X+RsrgacRlhZavATWQ?=
 =?us-ascii?Q?xtrkduorCGafpl8b6WZ5lFNpdZGtDdl74wYLRmuhoeRrYya392s5x1ZhWYPG?=
 =?us-ascii?Q?epDWvwXyn+RsD+jjcI2OUXY2lX7NrHLOREG6rRntiBFEGrKaWkUJbc+44I1Q?=
 =?us-ascii?Q?PRdCrx+6QFIVsWrZXyrIEYhHiYFAu8ACnZJa5uKJSg08RtcKYXi+dHop9OZK?=
 =?us-ascii?Q?a04+94RQekCTEF3haE8vEEmbqEdL5k0VPCQdvn6C?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885ec4a1-96b5-4199-09e6-08db7c434bf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 04:01:15.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkeuNjL+A5+oLV44XtZ0o15KttgA9W3PZF/hcsd98ITOSL/0mcBH+lBasOhtgUdUM0rEsIaOqjFa+iorcaumKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7385
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>

The first patch is an old patch, I resend it again.
I want to make the work thats parses the bitstream
to extract the sequence information or video resolution
as a part of V4L2 schedule. Such a work would also
consume the device's resources likes remote CPU
time.

Although reuse a flag which no current driver may
not be a good idea. I could add a new flag for that
if people like that.

The second is a patch offering a generic solution
for tracking buffers which have been pushed to
hardware(or firmware). It didn't record which buffer
that hardware(firmware) still holds for future
decoding(likes the reference buffer), while it
has been sent to the user(dequeue). We may need
a flag for this work.

Hsia-Jun(Randy) Li (1):
  media: v4l2-mem2mem: add a list for buf used by hw

Randy Li (1):
  media: v4l2-mem2mem: allow device run without buf

 drivers/media/v4l2-core/v4l2-mem2mem.c | 30 +++++++++++++++++---------
 include/media/v4l2-mem2mem.h           | 10 ++++++++-
 2 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.17.1

