Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D3623A23
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiKJDB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiKJDBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:01:54 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D2012AA1;
        Wed,  9 Nov 2022 19:01:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRoHLeIzSBnP+bKDlSD8KrTE/PdKNPYa0uefehjQvV6qfxpscofCElvLP/3voe3MaPhMsgS3z8SVt9gqfpa1+Hw/dt+fHqkkaWASDF9tDUsbynz2UNoYVaSwTm7wieGFBd1656O5a4uelkR3xOWjCBqJUggzLqTqTOb5khQnT2TYK4qklbO8L+FnEyIv8c/hrQRNKZN5uzuFKK1wXP8xWLqX9sEZay+H+pUfsWDb2885jQN34DypA2+kYJup0mNW70TcB+XWOrVp6EQBRAkR/tJcLMhs0WKsGX+0JJLOK3O7kEb245EmLs8fJ3FAZHL3BFFPWBHa+knBpoe7uEF8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjLdy6joXADzRITe/EqgBxx0q2WHxqfQPmm8qFEsKkQ=;
 b=VXg1bdOqKHp4ATJEXLYWcWiIo/YHyK75QNiC9v8iqpbYVJ0XTztNcDiDYbix/mf1/IxZlmsd2eDa4XeEle4O9QuFbbAdR16hJFEveoGXpuq7EYhq95KU+qtBd8Tkhfp1ph50H6+mw1pyJYELU1gfE95v22mlBJ6zY9rPIyl6pfzo17gLMrP/yuNYYJHUC4JZ798ySH83L3ODduBqzBC0eK0YbrEgB0XrVHKMGxFSWNNQSOCJOJWEk03Xk9tfu16UHSfFhD6VnmENeyoyr5kncpVTgXrlgqkGpzrDBFZzeiL196XbEPdhuT3S2s00fp1S9WmE2iDhiTdb9jqykCKlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjLdy6joXADzRITe/EqgBxx0q2WHxqfQPmm8qFEsKkQ=;
 b=RRn2AozqXOc66ezmh08sPXpSqHbfOpbOLrqARJ5Fs2hA+NEHRUVghFrzkQR1wCVfsB5gGbXyoSVsZtlqJD23sh848e5BHMTGLTNQY3ORdiiK7I+AkW/nHXMw/umFWGw5pwO0lhvLYflc+1RyhxUt1L4a9afRFKdsWTswRqg4Dxm0HSEmC4NQdG0juqSCHCDIm5/S4sa45S8yUGhNDVdLywoRxOxAAHfnSdO/3mlSVx6fkSNJyLxICmDebcsIW7Nty1eeRBvz7wHdTHw90M2USNLUAhK/5IOsYME/6eelD49YQgI5Ke/wDlAnOOQtGlW/PiJO55wfnXkvPPC4NEsGHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SI2PR06MB5017.apcprd06.prod.outlook.com (2603:1096:4:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 03:01:46 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::7285:f0e8:3a4a:f312]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::7285:f0e8:3a4a:f312%6]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 03:01:46 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     jasowang@redhat.com, mst@redhat.com, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] virtio_blk: use UINT_MAX instead of -1U
Date:   Thu, 10 Nov 2022 11:01:23 +0800
Message-Id: <20221110030124.1986-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|SI2PR06MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: 7217310f-7193-4787-3fc7-08dac2c7e73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWyNTnz0kB4Xu+endfEPhuZZxQkJiKMxCwDGsxlhUGeEFonNjWBsNpuN7aiJEpBBmYyWBW/eFC1ikd8DfGKHPkfFzngGir0OUCJQY3ST2iZm84vGg4H0wEACf5LCh2PTsU98UAai1iJvj2EWA2d9ECI0ASiSs/jFrjF2KrScs5EK8B1WOvWXo3RCHiAn6FNt2RW7n9JyhZSRuL62SFh29kaJ8WeLWdJyiTan7RhxHkZw+X+DN3uCXTq5D0BW2BavZTGR+384SCl95Qx191bXLGy5YhVrM65S9CDP7Jjn2mQLX6md60ligCkyN2VYIC0GlBMUfIULQ+jHpNG/qBMUfD//ja/Dce68UWa8g70cwKF8prj2GZ4afX/uoMIc03SzKgbmHIzREqeW2Q+MkdeOaG7ixMZq+Zhwm+B5S7l6cxbjf4v2h87y9RDHfPQn+4f4GMHv1xtOmjVE55F2KQRmKyFjGRaB07Royq89lwbaQMgRQTHrLoF2rbVB0WGrfgRhOHqEdMRYwvz9w9T9GBhr4XX2cZKU6Mqbe/rtASAAzKpb//t3PDTgPn5PN/nFETXrhNWnw8vbSFLj+prMeF9S330EuJP8hp1Scf3laqtrQuQigQh4tR4+ZTJxu2et+t4gCYzdFvY4bNbPU8HLjQ7696iQmQFzY3i4KxIbkNz1tXWaSPB1IUbQ9yoMEWssGCCAQEhh3ZGfpAvjDGhYUeYb4fgo4ni5UKpLeVaGbcTvNEDABviecQfOFryP3QOEoRbbmesUwyn+XnNxa+7ZSfz4fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39840400004)(376002)(366004)(136003)(451199015)(41300700001)(8936002)(316002)(66556008)(36756003)(1076003)(186003)(2616005)(83380400001)(8676002)(66476007)(66946007)(4326008)(4744005)(38100700002)(38350700002)(44832011)(2906002)(5660300002)(6506007)(52116002)(107886003)(6666004)(86362001)(478600001)(6486002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hdZPSQB2csNj20/FrkJk+tsJiLNIwugIy8Y1gzUUxAwzcGilgTbqQqhiu0YO?=
 =?us-ascii?Q?ycTUOiUdpW1RxdnMqe2EtgbTB+jG9vY8ilcf44FHYOJ1nCvOVZdoskfVHDGm?=
 =?us-ascii?Q?/anOuXHpy6NYxao5MWjdiHNVjCTqQH5bsvaVxUH1eWPgTf6cxXvXD5M4E4As?=
 =?us-ascii?Q?GdWKEZUTdN1kQ69vlANLfCbp6Ly9mJT9IvZwNB5Rf/bEwpbfvWslrgJnadip?=
 =?us-ascii?Q?WeilTI667FYMxI2n7viEsyQ2UgOY9LgyLptZiam6vgQ23ugovK/5XMlH32jm?=
 =?us-ascii?Q?0sWU/9T3ROGLMp2Y4j7Wl3YGdCZ8NjXw7dCbmPHpWbephTLWCqKN29zZXj4C?=
 =?us-ascii?Q?s2207fvkZyRCiD3ZpSTcNXzBdbjz7NiRRPUf5tFq+5cY6MkWa5H16ozDQ0kz?=
 =?us-ascii?Q?JPeXGAXitpjMsw56iewgydESbF+w6cqmCAOorun9Lvbf4ckBGGWnUyY+sKU7?=
 =?us-ascii?Q?ISGbb0brG7Oyv4mx2mTvAMz5WtMqV6VWGMI1F6LQNLHCrf6+Hv4zFbIJUdtv?=
 =?us-ascii?Q?n+3+D9drjzVVWk8ypE0hP1LZQLpZ77weBweIoK+YdWWJNg1UZgWHdWyfyMO0?=
 =?us-ascii?Q?opbOi5z1Li/n4OYQAV43izeFXyUYOWKxifr2zPDEQUeUKqpvMb+GaKEpe79l?=
 =?us-ascii?Q?CULBLpQHl1DEZjxWcYSMzGh+pm1LhgbxBkX1s1poN/M9wrKHJf9LkUmp58e+?=
 =?us-ascii?Q?fW++RBKCHICwau6Z4hKByezz4WlkGzBFKhwS0N+yjXpyEpgEOdDGX0yKtVQc?=
 =?us-ascii?Q?1Q3lWsWuOOGYd3BzChUgOgaHKjuCP+zKJLolPy9p/z26SSBGUFm738r2AoWM?=
 =?us-ascii?Q?MzqXn9iPe62G3NMm3tyDhgN8D0dQyMtiTPLYk01UTj7OqBpQDtMYMN19POHj?=
 =?us-ascii?Q?h+UZeT3oo/ozoHfJRzB+Hd/UquYjH/FcK4SVcQ+MqyS/L31W8nfHWJwYDEkY?=
 =?us-ascii?Q?QVJoqKRI0jNuexYsz1QfpuZYj/BQXZM+8VbhWcpmW6115jo+p2BvJp/m4qfr?=
 =?us-ascii?Q?QHa1uN8tZ/hD0vwG2NWshKD/0RmZ+K6uSbqUDHqQtZ5CsspfzAeFwkEJdK+9?=
 =?us-ascii?Q?9DXAv5+4e9vVNCrz4iYtB7aa4YlcxHV9wBkyTorh5aiDh6JA0gclZBOsp8k8?=
 =?us-ascii?Q?Sizhzaj+XWmuD5lZVaLmlwEpC6e7OSvzJMa8LTOQNj+Au2PzARGQsGHDyOJw?=
 =?us-ascii?Q?miEkXsC7fdgh2EbnYUDplbLE7HXfUL3XJPEH91rwfFK061Eg+l3QsZW4xS+5?=
 =?us-ascii?Q?TJc7koy3gG6snbqgtb+4RLpUcToSRY/6kLhQSL42+dIF2fJdYF9mXCU7VsOi?=
 =?us-ascii?Q?6PbLivymFJ2wHVj8sDxxAkrfjtl65wJRhWtIuE1DWUArvBL4cMxEX6jdZHxT?=
 =?us-ascii?Q?Yunh7Qewu5sRDrPal3rNE2gMV5i1QEpT353F2D09j57sFROnYqmrWBfxVlHA?=
 =?us-ascii?Q?pjvOzimyejC5J6mRghWoWLqtQ0SkqDdoYl4Y2ApBP+snoFn5xYnYGJyBgJcQ?=
 =?us-ascii?Q?AHK1yj//cZlMRpZH4lTWB/9Nm/s3eBJuDyBwqEDesTb+lS9v2TWVT0m3EW8D?=
 =?us-ascii?Q?KBI8fNNXGcTylhSZTVV2PwgIGywdgj5x3CujtS+ItC1sYG3qSPkW8By2DhDC?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7217310f-7193-4787-3fc7-08dac2c7e73e
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 03:01:46.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQAxYhudgTMIaYhpiE/Zj/2c0/Qn1QV84UunKZD4k6KTy2FuWS/1P5OX2Nkq2FrzvzUXgks/PaZGqhxqZb3wg/ldg1mk3SGKnBZ4IH+Lz2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use UINT_MAX to limit max_discard_sectors in virtblk_probe,
we can use UINT_MAX to limit max_hw_sectors for consistencies.

No functional change intended.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 19da5defd734..02d3027dd32d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -991,7 +991,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	blk_queue_max_segments(q, sg_elems);
 
 	/* No real sector limit. */
-	blk_queue_max_hw_sectors(q, -1U);
+	blk_queue_max_hw_sectors(q, UINT_MAX);
 
 	max_size = virtio_max_dma_size(vdev);
 
-- 
2.25.1

