Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41563854D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKYIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiKYIfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:35:47 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9544D31371;
        Fri, 25 Nov 2022 00:35:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gflwdJWoRH304oGhg05fr/G2/WIP0AkJVAUn+bBICNVLj574vnWuDNcxPj9mtq0enq2csiyhyznDBSHh0yI7FiR0c70z9LrOn48TEJJmykkixIPFjZRmyOPX0RLZwiLT5Cu5XP+38s/0ZfgBLvZ9XfZw6jDSBLem84q5mG+trIy7z7yzBzvHS9JIiP0Dx74PODVFwAYaQW6OO5gOKOI1Q+z9u6DvsbyCefB5ySS3g26nGGYggMrfe9+J1B3RosCHNR5bPwvlEW5Hfixqle58ViidNwHS68Asfwx3/uIGZ9pQ8di4TVYIffUA4sHSR6g3ZMIjZIR4xcC/enSBeW4Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHZrtVTVx7BdBWrx8k8G0wo6sQRpsya9kqz08AJ3VSM=;
 b=nTbb5NBih6tq1ybKZ32wRbSrqNmJzZh3DTLyNaqzfnUYeIbWe3LkuCUcqXiinkg7LEsrGLDTV2KN+Ra6SUJZQ2SpEf18wzX+nBJTQK0TlXjib9Mmc0sRXqc+tjuhOQFtMPg17VlV7eDfpIVSbQc9xkAGd57byv+aVFo9BitQROkq9rc9ROS35XSR+wXSeWlvQQKGid008baa7MGIh8cY+j/nrJ9ZOd4EYTHSJHKymFIAWpDeCEp1H7+Q2LJobC42pithXkwf8RaLhJpzvGUA6VYD7Z7RoHyFy655B9ISNb14gTKugWztAxgtFFn6W7VuaFg+qF7+qim5bpqjWGYgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHZrtVTVx7BdBWrx8k8G0wo6sQRpsya9kqz08AJ3VSM=;
 b=csIRdBleuQn5ST8q8EGUQfHnH/8V9qc3WC+l4UNN+oUJtkXDDYlT9Ua0Af0siJDpdocWFAEhRc+zklq9FrTYICiBJ6fW1wSKzT3mLCG+fVBrVACt6FTXi+fiB5AF9DUyF6mJI/Xr4B/6a8jjNodDK3GiZ6M3ZuHKuFYciixPXLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by PAXPR08MB6751.eurprd08.prod.outlook.com (2603:10a6:102:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.5; Fri, 25 Nov
 2022 08:35:43 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 08:35:43 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH v3 1/3] iio: add struct declarations for iio types
Date:   Fri, 25 Nov 2022 09:35:24 +0100
Message-Id: <20221125083526.2422900-2-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0501CA0011.eurprd05.prod.outlook.com
 (2603:10a6:800:92::21) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|PAXPR08MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9d7e45-6df8-4d93-799a-08dacec00a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bhu+6pxahRRmp7YhQTKMJXuk0i4Qd7zwTsS09iYufI7lnTwQy3ZPJsuERcNQaEILiScSkBd58CQAC6nkixEOgg7Bh/vJlKGviWG79ciOQwbFIPPHLpdtHQEkUs/U3xFTsLXJyEXlfg9A08J/sUrwkXHCJEdOviQxLzBbmVwQeRGwmj5t4aDPsUq8HdWa+HT0fdyc7b1DaLJzPVHB/o348wnjJxv5iUpIxBT4wMtXgyT6iEHqHhUq3HyGily6nqo+fDSkXI6o9RU0d00kUzOLzygufLKk8BgsUnfcNL+uEMzVaWuC5Kh19HIdLOGgUEwf2i4zNdJrLdBN4FKyp3d5/4Ly1Lr0NysJ5H5XvaSYUHZrJkFWdixIxMfHFyoxg2lGfXZKhKGSCCOA8lwaHSaibeydqVrmDoHSjGGtTlsVCnf+UbOOFbyzmyakBCByUTew5r6BU8bFGEZveWRyBx4RPMdznb2yKXQsBIo1Uw/upAN6BubqiCe0tSGQMPOqDEuYdt1lJCWYI726C56oun8Fqc+hlbsc35wFtxOLTcRqz1P0VoKIA35Q2Je16tHcpw/0okVa46nSbFAMUO9+NRMlXbL/fmL/Wk1GYrh0+5WhQqBG1e6kAX7Vm7MINriddZFFWDGNSJuzBDDmEm5IOKYHKrQOQI26v1XYMEFTHf7OrWH4yISXmQnSEJbsGYTdJWRLMbE6zPGJPwIYvITBeWHy2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39840400004)(451199015)(478600001)(6486002)(186003)(44832011)(4744005)(7416002)(41300700001)(2616005)(1076003)(316002)(54906003)(38100700002)(38350700002)(36756003)(6506007)(6666004)(107886003)(52116002)(26005)(6512007)(86362001)(4326008)(66946007)(66556008)(8676002)(66476007)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sOgAZSXJNO3hV/W4yGDjgfMPrO7H9ax+xipPaFxiJ2Vj8d2KaZXduUVX19B+?=
 =?us-ascii?Q?kl+xSmfegejRTw95ck/fPi3YYSGZAsSfpSgrlmNQE5ekTqcPTfdAEYLSjIMh?=
 =?us-ascii?Q?gQoowoEufLYpEp9PxhuIqIhZ7NNF4/M+NoB36U4VZZ/jVLnzAx+JOzPe6O4D?=
 =?us-ascii?Q?GfHPp6kOkNQj/PJeRsmOG4dLtJ65HNjcQ5+HqYpRpITUkzLU1BjEyIDk8IWe?=
 =?us-ascii?Q?6TkXu7aQNH1+5gLN+86qXTGjybykWHdatM/z1K5/x1MzREFQ/C64nDgMz6yw?=
 =?us-ascii?Q?++bIv9cddxYdT7AAMhV6kObkYusrRaDqgSqTsTGe47DLeukp21AfL6eqGzw8?=
 =?us-ascii?Q?FKg67YdUCw+x55MbuRjKKazMXdK2Tv8+IlG0sXJ7WObAbnKXteWxsJTyvOoK?=
 =?us-ascii?Q?rM6ZWZheINfwKYiuqu+8DisL8Lzu0mttaegoWNCCLLtfbWwlREcbF0Ntwzsh?=
 =?us-ascii?Q?c2F1SRl6mWSiDaPf4rCEzuWkL3sAYiHraJMrQRmMINpc60R6xfsskvu7W8BG?=
 =?us-ascii?Q?kCZunaeONdy+DE3Ka0iOdpFYmWP/DyvPzOakRYZKWb/l49eJoo9WBUAZjnRO?=
 =?us-ascii?Q?nn3DvgWUTCm2KYunaffmiv1+q1JdwBAHVavdIDHHmsgYV5u27IE5BH25c2Ny?=
 =?us-ascii?Q?19iPyOrlXBWp8uqPvZF4oSZTq5jhmqy4GNwjf5LL7hK4bae0EJm0SMxdBo/o?=
 =?us-ascii?Q?BMnu8QxK197xKp+KMy6YRhpkMiWJZXoJCVZ30F0dfIuaqi1bQzo0+spdPi5F?=
 =?us-ascii?Q?pKfMeKPv1pHMTheQNmULeCCW8qpbXXuvGnUsBNBCOQ1WzrwpGR1idr9VaNJ4?=
 =?us-ascii?Q?3esWDyhwz+v5ExK2uMIA7R5ciID2+Yo3Bmhiys0MSwl/LrHfuifIOdPV2rwL?=
 =?us-ascii?Q?dvuM2B6X9UXAQOVLTMm/sN+rNp28G9wLHmC+ogi2qeC6PU8eF9leuG2gyP40?=
 =?us-ascii?Q?CMk+4ngonAHTRGjFS4B192tLgD8hBLa67gwKS3fHXJXejWYUC28C+VG4tur3?=
 =?us-ascii?Q?jCxbvCJ4TLhGS5YFtZgIA6YgZR8lRge/EaKdU2vVvK75pn1veL9QDQKxFe0Z?=
 =?us-ascii?Q?TbzSMMMkpG1uqBi10M4MVyEBiSdhvkOTWHMytBrN8fQ2HxZK8o3WlXEtlDDp?=
 =?us-ascii?Q?f0g8gz1jxYBvixi73guMC1M1z+pU+bLTMSlil8uIV+Jb8bqljyKDMKrARXSW?=
 =?us-ascii?Q?3OAvE15qIxmmCs7f3l3FEUwuVufYExLaL73KNAqWCoWEcC4RlKjg/dKAmegm?=
 =?us-ascii?Q?OxVu752PiHWa+DPao4FIBVsdUxxpWMKZ0RThLmmh4JKwA45+j4Ik7/22KQdv?=
 =?us-ascii?Q?A9qxvkBQy+MORVaDsNDoFYLsrOLt+++0J4eZlEapf/XybER2GT2FnEsSu5VG?=
 =?us-ascii?Q?11vhtzIfV8iQxS2gCnQmBwRguRLGsvxFvpzScIir99L9v/ALyMt2OMUCcp2H?=
 =?us-ascii?Q?uXLddtlf4gPln+SzqYEE4lmCmOE4C6tjZ3jvIPR5r06PeU5RSRlcjfKixu/W?=
 =?us-ascii?Q?sOSjaVSYzhkZQ04ze3gZAuJRmbEe3liP4Z0AiRi540xchZ3QixBs9c7PRrkZ?=
 =?us-ascii?Q?UUAW1qgk5Y+zox+nWsqtmhgTSvpbP+kSy0neC0ks5p1dNffAy+vvjNwiycqs?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9d7e45-6df8-4d93-799a-08dacec00a6a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 08:35:43.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dakzInhTz8qaX0SHT/a2clmAV0hqVgMAvndML8q9jSSP0ocKNroDPp86KxQNF4Zm2y66O48HX0pWgZ94LB5EP5pNblhYksf5HT3jFSXRefM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6751
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add structs for iio type arrays such as IIO_AVAIL_LIST which can be used
instead of int arrays.

Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
---
 include/linux/iio/iio.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f0ec8a5e5a7a..eaf6727445a6 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -383,6 +383,21 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev);
 
 struct iio_trigger; /* forward declaration */
 
+struct iio_val_int_plus_micro {
+	int val_int;
+	int val_micro;
+};
+
+struct iio_val_int_plus_nano {
+	int val_int;
+	int val_nano;
+};
+
+struct iio_val_int_plus_micro_db {
+	int val_int;
+	int val_micro_db;
+};
+
 /**
  * struct iio_info - constant information about device
  * @event_attrs:	event control attributes
-- 
2.37.2

