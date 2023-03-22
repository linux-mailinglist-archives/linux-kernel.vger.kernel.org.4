Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488ED6C4D26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCVOLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCVOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:11:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C6B60D43
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFCuuXtThxl3sFHJzud4qETz6pVg4Vf0NW+P97nqBXhbAn+z8Pmq1/88ASCIzMzW/PJ4ceNDn+wPm7DM0i8U3b+ZwOlvCoxR7t37jvl1FOA+kCKyY20c30dFkoKxTwCi95bKvZW86ARY/zBiyzG+Ny6fj8lejwGC00DmDGAck/9Z3aAEeqPgZ97UgmkEu59Wy1v6yCxcF5g4Qh5Suw1hINQgDkKAZeVBrZ3wSqZxK0of7K9ijxvLClRAxmpKqvvpIOVp8Otm07FqZaMj4akTN/ZVvgTMrZKsnjaQFU/MYZhgqvnCvAaX+3dITYkm0RXbgDIiSUmYUXJTkbXmYjyGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDqamGLyORmgDG/a2WjtVN91LY0SW9qtLj1Tczg+4Po=;
 b=nUIR8jCjP7rllhX7aYjvmoX7a58uymCwf61Dz0ny/uRPlQtrgLh0n8GfzkqzY2Ryl1DZ1HFcNmjHWraqfgAK7zgAmcjTp1m+zD+y7P3l32UzpVViOsSyOEfeJ2Fyh99YkP/2EH5TXO10Zv8H394X7bCZUjkBHdWmf1EchtIuCYl4mFKfCXRGRk8aWhK9W0nO/1Xcar+WvxSmIAKhDpTxZ79X+aVwmhNTWB7Iz4gOmVumT8PyctngkXFaCgMUJOf+JNFpyYV8T4mGC3Ip0i8lX3FSoIxhTqxipQX+QqEGJY9TqENuK30Lw9B4hXf3w7jKcw+li8+4zsK2ESy3Trhj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDqamGLyORmgDG/a2WjtVN91LY0SW9qtLj1Tczg+4Po=;
 b=Qufk0ccaBr69NtAVqGCVB0G7KXTZL3Mu/sC/RF5L20bXnagzJOfPIeXWJi+Eb6uQaI9yWPd8zG7njMHrolftldDE9h7czThWwEoJl4m6WgsSQauTQDpzfyOykKI62Tq6VlIx4deKYemOvEmWhvoAw34RvS5heKMKHyCJMPhjaRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MW4PR10MB6462.namprd10.prod.outlook.com
 (2603:10b6:303:213::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 14:11:43 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:11:43 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH v1 mfd] mfd: ocelot-spi: fix bulk read
Date:   Wed, 22 Mar 2023 07:11:30 -0700
Message-Id: <20230322141130.2531256-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::31) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a7a36c-3c43-411c-d466-08db2adf5d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+QFSscGYAioI4p4QtxxHaJFBiOHTJU4KEMrOFVWH/j/HyNYmuORB6c0RkO15N50uJNZAjgMMy9wg8Jcp/ffb3OP0qFfehioAb/RbtYjuPGvWoLQTzUzORZERLOIZjTtNwdsMxatueqXXrzCGMC8EE2sRE43zboEzvr37FrwKY/mgTaDxCZPRPSJi7kpJwuKEhSrxk6K9m9SXXod6hMO0AFpC6WV7VR7g5IPmYoBDjI4Mh7Ik0UoPKrke0QcquJC4IIZoCCidxqiBNnb3X01UK375+nxcS3MtLUABPEPV/HiUUP7T2DgRGgLaZk1oVkFWsyNt1puMUiJJ8ub6cjNlnH8r7IigjMjZaQF46mgKq06J1QlDAOqisOPpZtwXx30Mp4o/IB+ZTNskYTGhztLu5wy4yMtKaX8Eo+fM1CTf0S1F7ogklFAylIfYhcmERA4s7NB8ul/HNfxn5QQPxNg1gtk8Dj5X9y4V1nbK1MGA+pKmrYd5xljvMPGVWc/taLsIJ8WpWm+sFL5gs5I00pVTJ0KLoyioeyScZYZK+vGwwMc1fdQ3RFqCPgUYxaCANl6UMng1JuSwWGD8Bv7mo2vtpL2T1v4jplS+aRJrrZyjVAyDjDTOcaiL2RjlG58HT4kDodiguzrvl95u4QdDPwbRjPZopjKwH+48rpx1XHBW3d1QGRJq6NJGpwuJNHqeUh9Ef/YNfTm3LaxGVxDD2nhBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39840400004)(346002)(136003)(396003)(376002)(451199018)(86362001)(36756003)(52116002)(66556008)(83380400001)(4326008)(66946007)(478600001)(8676002)(54906003)(66476007)(316002)(6512007)(2616005)(1076003)(6486002)(186003)(6666004)(6506007)(26005)(6916009)(38350700002)(38100700002)(5660300002)(2906002)(8936002)(44832011)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8IgH7P5BwE2oPx2XqfO+sO76Os4fO3o1EmrxnOTVh9mx2RhPpM2Ta8XLTJj?=
 =?us-ascii?Q?wIXVNKfpTX9OB8CWVPHzoAcxPWaBi9HLpC483yBamuoaxx6d7JOjuyNmVXMm?=
 =?us-ascii?Q?gxadznOwNvl0cCUubAF9YBbSgdAoqHIOycqakJH7KVPa+7FFmy25vx1DniYT?=
 =?us-ascii?Q?OHxg2AWGioQ6BlOiU+lOKgFhI4V2nkQF1DMewgzjp7kMTquGVuUxYq0XKMRk?=
 =?us-ascii?Q?v4yvcJqvXTUGNhcfUyHYQOxjZq0AXpFVTBg6A862RPWfjPSmV0vP/u/8Slr5?=
 =?us-ascii?Q?GQ8EPnm+hBcmgprNkjiC6bU0pFSDTW+VxLmSrqETyk/jyng8rSQ0Nh6T8Iai?=
 =?us-ascii?Q?gV5JDys5H53CHA4UolDSHbhHvlBkn8y+lUlGEembqIAA0b9LCwrmLykIPZ/V?=
 =?us-ascii?Q?/nctt/S4ijkQuLdVlCEMlhDu2TWEPlvs5Ie10a1U3vH77rjuqhoy6r/oa2/n?=
 =?us-ascii?Q?/fGnryOE8wdZzDf+LArOIJb5fhC+hTEl++SW2FHNTBQFi79Js+ZgyQ0raTRW?=
 =?us-ascii?Q?R+wZOVW9tv0uxVdGcYylRYtBO3F8We4Awn5r8oCP3Vo3Ug9n8EgeNxZ69NIl?=
 =?us-ascii?Q?YmsWtNahZPL/B3jm0rXV+hZfCa/bTh4NJdG5rQ1G0njEcxR121jqyd2ovaVG?=
 =?us-ascii?Q?YontjDJEWPF1W9iSZQlpoX39bXshKQlLKdJarRPOEpYQMgWyECenNHhBmG06?=
 =?us-ascii?Q?9YjisFtO3e0lSQK0Yw+s9DMfxyDXoELpEFWKg29zIvfRQjWG49DrINCfVWGd?=
 =?us-ascii?Q?D2Gn2WZl55V9RZGOGvQ9wjAo65L5cEspHHKI9XjSIyrtXdKmPyk1nwB9JFtx?=
 =?us-ascii?Q?JTj4k/qaP40lff0Tkt+rn9fD+RghT3XC6evirE5MKJ7VqGWrM2Fct4sSxcvf?=
 =?us-ascii?Q?BOyy/WINNiizI0Ukm1kvKILe1CJjMB3W2255PwLihFNyW7iq4uiL9DqFLQ+u?=
 =?us-ascii?Q?HDJJSbGwBtngN/EQXothbWabZHVD8gHxSVyXPDAMhwDojjUYPO1BJzW0ACik?=
 =?us-ascii?Q?TVIhdI9nzy8ErUEOuhLEO8MOYOdSWbbf5FuP492oaF7guhaAdNG52zMXzPz0?=
 =?us-ascii?Q?KeLmTiKmreXZsYc/DqzaGLwh/b12EQl9/yDG065oyGfMnaPWn7QNu7rGI0iJ?=
 =?us-ascii?Q?Z7+1+iRZHMVMrbJkBIv5sDLmyB3WDhHw0mM5OBgmpqmNLxt+mA+/fPI/6VnX?=
 =?us-ascii?Q?gr7c2rwP4QYFdtXwZp/z9dYNX7wwnpjkk1f0t/iEnWKsc51zXwhkDhOeAgiD?=
 =?us-ascii?Q?pENZedWr0Ncn0kkrOl3p0MvfZg/t4SJWT4QzYR+4H5ie49m/YNxdNr/KttoZ?=
 =?us-ascii?Q?HzYJIah2nfgceSM5cBh/o9UIoQPyEpAyz94mR9NMii86xt8pAB2nXT9Fv4ZF?=
 =?us-ascii?Q?iyMy/EmbItFVb2A9Skfb6iS09A+Y7qZjplAn+x8loGNkm2+3Ao73FN8udUXw?=
 =?us-ascii?Q?NwiuZ85ijQrJqqNzpndqr12S4b7gBy/3wNQ/H3foz61WUyt8F9zJ9fFQAad/?=
 =?us-ascii?Q?l0yGdz/o2WiMHTUyVMFvGmdM+ZllDE5W+J2H/aw3le0hnu/+oq3xF++GhVjI?=
 =?us-ascii?Q?wZ1EoR0DFst/sBlQHOcGQa9OpjMY1x5RR3KkIzpnKdY+QJQPsLo9j2uayV2b?=
 =?us-ascii?Q?OuoBHZnJ5HWRBckL6wHLB7E=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a7a36c-3c43-411c-d466-08db2adf5d03
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 14:11:43.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvZBX+EKS0YBsbZfvlDrJSncB5rYhESCkacQIFKO3aaOkyjSLWHQLxbhObOZSuXCoGgkvb1oVyc68LwPUkAXLlgmWm0/YKG8QjdvDtKuJdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ocelot chips (VSC7511, VSC7512, VSC7513, VSC7514) don't support bulk read
operations over SPI.

Many SPI buses have hardware that can optimize consecutive reads.
Essentially an address is written to the chip, and if the SPI controller
continues to toggle the clock, subsequent register values are reported.
This can lead to significant optimizations, because the time between
"address is written to the chip" and "chip starts to report data" can often
take a fixed amount of time.

When support for Ocelot chips were added in commit f3e893626abe ("mfd:
ocelot: Add support for the vsc7512 chip via spi") it was believed that
this optimization was supported. However it is not.

Most register transactions with the Ocelot chips are not done in bulk, so
this bug could go unnoticed. The one scenario where bulk register
operations _are_ performed is when polling port statistics counters, which
was added in commit d87b1c08f38a ("net: mscc: ocelot: use bulk reads for
stats").

Things get slightly more complicated here...

A bug was introduced in commit d4c367650704 ("net: mscc: ocelot: keep
ocelot_stat_layout by reg address, not offset") that broke the optimization
of bulk reads. This means that when Ethernet support for the VSC7512 chip
was added in commit 3d7316ac81ac ("net: dsa: ocelot: add external ocelot
switch control") things were actually working "as expected".

The bulk read opmtimization was discovered, and fixed in commit
6acc72a43eac ("net: mscc: ocelot: fix stats region batching") and the
timing optimizations for SPI were noticed. A bulk read went from ~14ms to
~2ms. But this timing improvement came at the cost of every register
reading zero due the fact that bulk reads don't work.

The read timings increase back to 13-14ms, but that's a price worth paying
in order to receive valid data. This is verified in a DSA setup (cpsw-new
switch tied to port 0 on the VSC7512, after having been running overnight)

     Rx Octets: 16222055 # Counters from CPSW switch
     Tx Octets: 12034702
     Net Octets: 28256757
     p00_rx_octets: 12034702 # Counters from Ocelot switch
     p00_rx_frames_below_65_octets: 0
     p00_rx_frames_65_to_127_octets: 88188
     p00_rx_frames_128_to_255_octets: 13
     p00_rx_frames_256_to_511_octets: 0
     p00_rx_frames_512_to_1023_octets: 0
     p00_rx_frames_over_1526_octets: 3306
     p00_tx_octets: 16222055

Fixes: f3e893626abe ("mfd: ocelot: Add support for the vsc7512 chip via spi")
Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---
 drivers/mfd/ocelot-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ocelot-spi.c b/drivers/mfd/ocelot-spi.c
index 2ecd271de2fb..85021f94e587 100644
--- a/drivers/mfd/ocelot-spi.c
+++ b/drivers/mfd/ocelot-spi.c
@@ -130,6 +130,7 @@ static const struct regmap_config ocelot_spi_regmap_config = {
 
 	.write_flag_mask = 0x80,
 
+	.use_single_read = true,
 	.use_single_write = true,
 	.can_multi_write = false,
 
-- 
2.25.1

