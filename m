Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4E72CF06
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFLTJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjFLTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:09:16 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAC4C0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:09:15 -0700 (PDT)
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CDrYpc017335;
        Mon, 12 Jun 2023 14:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS11062020;
 bh=OdDYe5OruTNQ1MQZlCsHtQkIsjOxigqW6lCesx9EN2c=;
 b=ZtX1v8HNxOqB72WyofhEaQipwfU6fSHNKeyLD3fXpOdjniRMEqPugg9vEO1rJyrNR0ad
 yOtKyqWB1TSghgz0xGqNcwo/9XFHP8+5Q/x+n1JzJvvvBG8iGipSwgDSuPfPfrqWoKDX
 20M0P/9p/2k0a3JW6pbTAN0ra4SXXT5QUxSX96TgjowjMRi7DsPyF6GgDBZlJXItGYDy
 b76dLefqyB/INQOugfY80yEbFF5JA0wwh1Npu8IxxZJnLiO4/1uoDCsY5g2aCkketu/B
 klqnk0TDQZpXER289CdMhvqXITiWOTiVQayFuR6SkYA7uS14WBSeQwOTVAKBcDPFqypk vw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3r4q04ayj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 14:09:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMG6hhyiMXCCZQYbQL3ac5UBRxi4sn0YD4jGcmeWcuX7YvpAqlo76Wvj/iyuTCmdYjFe1F7NG1rEJHsUpuwX3IEDE/QFSbCA8gL5bEZmxhxbwtbJnxmsLIAHtH4LeRHtPLAOU+jpeK3ZSJIZCHXsOPJXEDFKZ69BD3BnfrvCRG0B9dBGkpx2XRvzpHKJVrvPm9f3k3PtEPKMFJUUwJ+seEagg8XKLBuLQWO32zaDF5BUNuzgyphPH78MUlI1jde500p+fkaq4v+NeNdT5UQotUvZDKNkcl4ZD548rhmw/s9fNfsOnB+z/r0AvSEGhES50EOhF4CCEBrFqthUiHr2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdDYe5OruTNQ1MQZlCsHtQkIsjOxigqW6lCesx9EN2c=;
 b=cJQpmwq+V4a5O3DcK/qtru0YW/rIy3Kn8ye9Z0PYT6bAZjR/sbBntldxmtGfoMBxJiWS05/isN26FFhsU1zHz9EeTtwsLfDpMNSX1KqP+2A49R5F8arq3pIAWIedqKoT/B37x8FE7d+XVEaiaa6wZtQQGLoq9ZFitRTnoC7Wyaar965LrjxQX42wb515sORoUarQuO8bVy5NVPaI5szVk2yDAdIxrYyyPdZRW4ZS64hQQt5AiOhJwnfK3TqeKTCOztoaNyd5ddwwsHNsBb+B5I7nX3r6y7c/03DevDbIMXSX+yVwiOod8VGWGIubZLeb9exCOaaSfsrxZdW6LReuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdDYe5OruTNQ1MQZlCsHtQkIsjOxigqW6lCesx9EN2c=;
 b=Q9Y1GWiRoEdmeTklOEm09AEujsxj7SPOHKqcPES0hl76gi3vH5ky74PwYTvwQQ7kPD5zGG4G2yDDK4Su8xqSJtG66nWge7WnG6jEEp9qcRMx/izb92Ha1lx4zrG4yh0DUUhhdHYCIg+xDeV2NkFPo/G87+kYK2R9U2opFt39Ec8=
Received: from SN6PR04MB4879.namprd04.prod.outlook.com (2603:10b6:805:9b::29)
 by MW4PR04MB7265.namprd04.prod.outlook.com (2603:10b6:303:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 19:09:10 +0000
Received: from SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0]) by SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::f64d:f407:7c9c:4af0%5]) with mapi id 15.20.6455.037; Mon, 12 Jun 2023
 19:09:09 +0000
From:   Charlie Johnston <charlie.johnston@ni.com>
To:     giometti@enneenne.com
Cc:     brenda.streiff@ni.com, linux-kernel@vger.kernel.org,
        Charlie Johnston <charlie.johnston@ni.com>
Subject: [PATCH v1] pps: Increase PPS_MAX_SOURCES value.
Date:   Mon, 12 Jun 2023 14:08:28 -0500
Message-ID: <20230612190900.2334464-1-charlie.johnston@ni.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:806:20::25) To SN6PR04MB4879.namprd04.prod.outlook.com
 (2603:10b6:805:9b::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4879:EE_|MW4PR04MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cedfcbb-1e4f-4b9c-1d15-08db6b78802f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6PYAi24QKoL94xxjRW9Dj0CM7NvHYNVNVLhp3v1R08umAOfM28eUBehQeXtxvh5fKwyO4oTTT/koo9qqFGxA4/l6bWeNUzge3k5iJrrKoepLDcNiLeJjKr+kLE6nr7z4TWMirMnzQCKw1DujE5kmHVUs16uMclOl8l6KEOq2ZlZLhxlkFD8d9pheNhmqlgnCNAb+OnVsKtCq5gmwU2ogMshxEv16sUcZ295xaWbAoI324/Jco5TSFk+txTjzJW5JNXVB4v1o0AAuRMIvtdhnUVqnct8HQgqWBiDX2CouGJS+JPSYiYm1EP1Ij9kkh4dkpildboqbODSDlx0q2OrcZOqRLy4ON1/coAdw/N7mSekHXeDCWUcvgBpMR3hOn3q8NTL1XqDP/2dpeD+IHd5v87MGCjS2i51rq+JJp0Ho19eMVu/0NKuby8bcMXvbELz0a2UiWs4v58uiBGsSwxO4kP37x6VBZGrOQicqQN4DAiH3elubmX9QQH/yJw0Bg1ttRIrH+7gxCYfHiKfE6GEKJfjQJWGgFOIKptKtd+BvDDmU33k36lw+51FOxMYw29E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4879.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(2616005)(83380400001)(38100700002)(86362001)(36756003)(478600001)(4326008)(44832011)(6486002)(6666004)(8936002)(8676002)(2906002)(5660300002)(66556008)(66946007)(66476007)(6916009)(41300700001)(316002)(186003)(6506007)(6512007)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rHRqcEU3k+KTVrUvVTxjPgjDRx/SDG7fJpiPjaH+ir3cr9dYy9Q3JKUhDLd7?=
 =?us-ascii?Q?X8edR3GTNE19Jy4q2SsPFTc3/QGTNV3J4nwO+xzOA67GR64mDXNYcKnxfE9y?=
 =?us-ascii?Q?7zggXtgAV2+YFZrib+nEgvwoibsYwViUVqfX5i/LHWwxf12t77vmXH6m1/LV?=
 =?us-ascii?Q?kTLpo1YhIvrQlS3KzfE+lFaLa075o84S44oj5s3s+GJLgeZmu570LnPdaPA9?=
 =?us-ascii?Q?IpMMZkYDBfMwwvLlaFFXEkkYmpV3gfpkz82I+cMdnqaEPqdqzlHY3XLehpQ1?=
 =?us-ascii?Q?xds+kjwavWlIcUOCBEqw8NL8ecREVX6DQT5uDvgEzoFszuthd4ROwY51J998?=
 =?us-ascii?Q?Dxczw4yYHbfS/IiWywybtQu7mnnBkEPf1sQ8gdXyYBbbqBqYZndECoBe0I7c?=
 =?us-ascii?Q?HsMjQe+6mTbNAWIoJ3U3+jQ5Esc2XwA1YaXetkmX/FJUPH4jnWahAv43RbGZ?=
 =?us-ascii?Q?qNToiExa1GlRFsYjeLGGYzrMb4BQqKSSyn3p5d3G/aYSFHIpknJ5D/P5HBHI?=
 =?us-ascii?Q?OZMLpitZRs6gZ1jfG8hYosB2eNRJhOmtB8aMY0R8wpqqipj57x1qY2r47yTx?=
 =?us-ascii?Q?llDTPADGuBCTH78DQVNg/nqpG3woqrmf+sOBpv/SnWG7CJRzHahcgoCcJdHX?=
 =?us-ascii?Q?T+7GP06C54HlxQQ2JAwTBqxhnh1Uf0zL7WU4H5prtxLPL3cV9F7F1RRGAn0a?=
 =?us-ascii?Q?zx9s0Kmo2jix+YWyOZZvFtYBaUuNdJ8zTe/5TFQ/1Q3npQ4t7rzdoE1qk4LQ?=
 =?us-ascii?Q?55dA93RTjn5JF8I8z5fUtZb6l934e4vsTw4eXBzf6oGRIJx+I7i+Mxs8gTPb?=
 =?us-ascii?Q?E5HXCT9LcKmGY7MsyTbwc+oJw0gUy8vVQ05HfXybNz2/7DDf458yW3Wvs486?=
 =?us-ascii?Q?fgICWtMJhJjQdQhMBNfQ56c0V6rSasKBvya2LsR4LuK9+dHrVvd9itoLPYQQ?=
 =?us-ascii?Q?QLhlzQq39Na/yWfdCtrWAvVlMPiloJXpyPBckROG6kYhOXLE++IgzY5JYMWi?=
 =?us-ascii?Q?F5Pl1COE4F/FAAJ9ma8Ves/5IS0PuCqr/tSPTJr4obE608nca/UeWiSmN1Rh?=
 =?us-ascii?Q?sUY+ptOyBdbE29NfkXHLCSb9tgvPaXfhl4TnmGEq5msDV2T1ruTtVFSW7ON1?=
 =?us-ascii?Q?9Mk4CkS2YL+4CYTzuEUnictobylJ7CSiSRlHm8JjKsnlsUodvza0X4AIS9tn?=
 =?us-ascii?Q?1ZMf7kKSe9rmjXBj8vi9JMntt+1ampSVb07Newj6aEpV/iF5ONtBYUWW23fK?=
 =?us-ascii?Q?Pl6FGkD/smNu7Y3YkYxzi3Npr0BWz2LlfZ3V0wIfRyWhuyMHJ92toiEgchtG?=
 =?us-ascii?Q?st/7DCo0ND2EP5aZaiYKT5r3RLqvui7Xh98y/DZJ8G2R0VS9oNrziFPb7JEx?=
 =?us-ascii?Q?dDpnr9i8MqeMAxz9xa9dFsZQw42nKhUl09+7Q4VfWksDAa2ycpa8kV1vl5wW?=
 =?us-ascii?Q?iobAB8LGEwwNOjYa3bo2FjJH7snVAlic5lP8C2VyJ2bpJx7zhkMd3jNPRuQO?=
 =?us-ascii?Q?TOLdiqC+26BaaluR6V6lRyzJogCL8DqKw9BbSFqapJWsxYdLBamj5ZFbcWA1?=
 =?us-ascii?Q?YZbpON0x8CzTi2vK0X0cORLuiyeLX/rSia9tCZO3jCm/KUqOGTjOrDps1+BT?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cedfcbb-1e4f-4b9c-1d15-08db6b78802f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4879.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 19:09:09.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJ6yMbEqPvX8fOKj9JCu+2VkxIwIis3GYNoEvxBARkAUy1nu7OrGBOVvuwd/KJmegc/RJH/XBMKIW6K9GoXEOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7265
X-Proofpoint-ORIG-GUID: Do8RagPHiMnAdxAU16frw8c6S7W8gW8_
X-Proofpoint-GUID: Do8RagPHiMnAdxAU16frw8c6S7W8gW8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=324 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency with what others use for minors, this
change sets PPS_MAX_SOURCES to MINORMASK.

The PPS_MAX_SOURCES value is currently set to 16. In
some cases this was not sufficient for a system. For
example, a system with multiple (4+) PCIe cards each
with 4 PTP-capable ethernet interfaces could run out
of the available PPS major:minors if each interface
registers a PPS source.

Signed-off-by: Charlie Johnston <charlie.johnston@ni.com>
---
 include/uapi/linux/pps.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
index 009ebcd8ced5..0712c2e5a472 100644
--- a/include/uapi/linux/pps.h
+++ b/include/uapi/linux/pps.h
@@ -25,8 +25,8 @@
 
 #include <linux/types.h>
 
-#define PPS_VERSION		"5.3.6"
-#define PPS_MAX_SOURCES		16		/* should be enough... */
+#define PPS_VERSION			"5.3.6"
+#define PPS_MAX_SOURCES		MINORMASK
 
 /* Implementation note: the logical states ``assert'' and ``clear''
  * are implemented in terms of the chip register, i.e. ``assert''
-- 
2.41.0

