Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8B70E1AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbjEWQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbjEWQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:19:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D496518D;
        Tue, 23 May 2023 09:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7cMykCpe6d1U4ijR7wo+ZdbbsnIv4tBCKySorNu6vpLRGo315wXbRY2PpJe0EauFr9Ok0G9N3Rra964BY/WnWD/VoFWteSltmfTYhBcQ7d20i/4kAKK945EQcwGhrNiqIr2UdpYzzSwCQvJlME/m5t8QQUHwcX2JJGIJSimZvSSptnHuoQOPQOIbo1ZFCT3yjL7FhPDxJ8Mc38re0QmS2kn3Q4BHf1Y/zshLjIqg+oeO+wtLfsCBsddCuvIh5igseLfJc5BGVLBTgcTNxGYh926wu8ZjE1eaOyHTOE3QrBtRQ/XvyNvjYdZZUesjT3L6peuEeLFJn7+Xgjvpd30vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyl0ERCDU/+Tn1KkfWVKp0nmoTdIQGLAKV6LcUxqOYE=;
 b=JM0lCEZP7RjVKTONLLEYh018S2ReXbhOYdMc+PEYPGh2onBuxSFpadq/YLHg0oeNr7IWcbQx5KGECMXyf+JTPzkTdk6c+SOo+aBSjb/it+/XOmNpJPoCYPhAktpuZWHtehHTlrtuAgtRWzhPsYOfROp1ZZyaG6T1tvUSGykzgg8etkXP9jhesQ4DPgzax29lCdVZm7hlWubQxM6kczszPVh1KXfRPKZfdbZsiHL6QGWI+a9tadCDs/uAgNk94R54ITI2QO9NvMOofiTHASj1MTpn728ty10kojSchrmEPIIn+vpTmKn/v3t/PhPgyMb9EG0SLcwQaz8jw+4lKF2LnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyl0ERCDU/+Tn1KkfWVKp0nmoTdIQGLAKV6LcUxqOYE=;
 b=ZqFfaYxIiita868FcIHORvyyOvU9cVTQsVkLkUDVRrUNbaH2raPUIW5lgk0NxzHmgd7s+FzrPZYIVcBqfyAjmsKrg9RqjaKAgeYe0JotUuFECvFcUASEyUfsdgM1MpDcv1+ofqUHqxpYy/gugfmgyFAlK3OQqGytEDayvfqD5xw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by OS3PR01MB6040.jpnprd01.prod.outlook.com (2603:1096:604:d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 16:18:54 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157%6]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 16:18:54 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     conor+dt@kernel.org, broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH 2/3] ASoC: dt-bindings: da7219: Add jack-ins-det-pty property
Date:   Tue, 23 May 2023 16:18:20 +0000
Message-Id: <20230523161821.4260-3-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
References: <20230523161821.4260-1-David.Rau.opensource@dm.renesas.com>
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|OS3PR01MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe9e3b6-d1dc-4836-7c62-08db5ba96787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7JyvkuXU0KMV1wLSXMADQM8e0cW0t0U1udHeKLCpZAWiGb6r5eyBGX98KrutirrfXGpR7olHYbyO/vb/oQ2a45MzR8yBCqruapt2inTdaC6+vX/58vIMInoTBDKMhr1RBAn1rqc/Wp+igae/BsB4Nziz9cfzXNCz2ZJEqs+Yiwuaaq+nG9qDPWvZhC7T1BvU6R2WHG1yN+4Azr4CFCHgMjYY5fVVfQBbBI3g1LlyMI9fvL90JdWPL9+xSWJ0sIEe8CZR6FsxhrjHy1885QBPpkNvyGMZ/rrYrZOsR1rfIt/1PhH9rJLbUzL/lNL/G1rn2ytLvxvXA9WQLDe2geToYTLCyTVyYSaPQvrBMY8Abivn7c5Ody+H2SpiR2xBt3qdQyFIklT3L8ZqWUxunKnPSwII8S23LirCGo7bpdAqU//VYMCoX7Ci88DwtHJgu8nMZdNzRIMU/5Pd7DD6LV5lGKrGW1efmVbyJD0zVRfhttN8J9mGgRB2RN3r1TS+5iEs2gw2INLYnkdFmGP+vjcKdeHL6RFsKamcVoQ4gqyitTboZ6/6xaoKOT2RSvBFGKeHJ5UNXXKB121oM96oC+Qj28JDhfRD56Jp22kv0ucJvRch+fU1goU8ejGNBRhMq2y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(107886003)(6512007)(8676002)(7416002)(8936002)(83380400001)(103116003)(38100700002)(38350700002)(86362001)(6506007)(2616005)(2906002)(52116002)(41300700001)(66476007)(66946007)(66556008)(4326008)(316002)(6666004)(6486002)(5660300002)(186003)(1076003)(26005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E5BBZD5qQ+rQxFy1+DaU4yUzmp9tD+xlCQv+aJBKQGaQr86jDOD2FsagqrVq?=
 =?us-ascii?Q?SfnWo8jqfFrxyPWCUfZdMyr/5/zjq7tjdcoLn7Ry5KHhNsZtRhbRY///GZIN?=
 =?us-ascii?Q?9m7ip3jLZz5Zf82NW8TIT+SU0gMQfKrRLiKTgMnA6YA8XQMd+JjqUUIkLe+m?=
 =?us-ascii?Q?srWaNXOrx3g0JF758U5wToYa9R0i1mdXZmnwc8xbt9+L3SHnCAsGLFfc6tLh?=
 =?us-ascii?Q?pFy/vqHMCadSLzCRhXrzePTv3YWKnLQqnLuDdzb13C7OKSBYvZlGa5v5XMQG?=
 =?us-ascii?Q?0kJDPfwg1uuHS6gEQoQVTM7icTchGkRJQBugtQaatHDElkjwNto+2UksSzuU?=
 =?us-ascii?Q?lZHb/2Nx9mzjwEXVLkzOzDgk/G/AY043bmI8EGTI9snBADRISR61UsTDsdyW?=
 =?us-ascii?Q?g4BVNRNP2T0DivuanjAHO6e9dQfb/tOujDzxbJYNEqa9fUCIbcCjAttp7Epb?=
 =?us-ascii?Q?4lYP0ReNPtVhHxfxTjN7Jls62kkDvbkFnI9i1y2+yrTgG4NQ8YGTqsHOlKwv?=
 =?us-ascii?Q?UB6ZxOuX51x4V+1zCL5i2E/d2/Z2NtrDraogwMPWeflbbFsL/DDOH90E73U/?=
 =?us-ascii?Q?ZnTO+AnX0MclQXX+G91Ux4fzpMq2wfUCsBPtlYJeQwgv03+Cc2/pMGK0CSHw?=
 =?us-ascii?Q?y/aQaS3g1bvL8hIVGk0d+48sbylwwcM/3TALFzCVyKM8gYOJdac3/1FoEScq?=
 =?us-ascii?Q?Kxm2p7qOEPff+e7NKaAv1kK3WNe5fi4rGHr621YJ4fI/3UA79LUDeLi81seh?=
 =?us-ascii?Q?EK5+Fvv7fNO1TCfO9+gJcx2mLKVsJc3Y2I3Z0wJZv4Z8UYGlcO+fXS3FDVpv?=
 =?us-ascii?Q?e8fMbN5DDF8IwgPZ5MgvZEcR09J67z1vbCFTafHV1t62F0ckEnNE2frpnM9J?=
 =?us-ascii?Q?NbKZV1uvI8R/8x74gmWVoAzQ6jysKWN4fvnT3ttNs/AifbijpKw2/IAv+xjT?=
 =?us-ascii?Q?N6r4zClCdLZDSBst/+c7uT9BPScYbm4AVbiJrxMlbwAKo+DYmi9ZUrp5rcxm?=
 =?us-ascii?Q?TWtnjWmr2FQIA+o8UhUBqoKpL27WWAbQhzzdy2ONBoHzqrxfYR/rf4/N7A3r?=
 =?us-ascii?Q?FyHo/cUoRUiSvMH/Y3nhyMH4+aqe55ak4tmooSQH1I3dyxpOBV6U4Y70gLpb?=
 =?us-ascii?Q?80/XHhDL+0VJHlOXW3PKciy4dIHloRFfm86WKD8GgY2NBvbqErcqw0/u78xs?=
 =?us-ascii?Q?Ad9T5HLrCVRsDwoU+qUz8D2e7F33bbS8xRhwGI123OJUHJzIqjxbkluExTwa?=
 =?us-ascii?Q?M5vmpip9pn4az7rco+YAgtW8dEb3HKC950X5xJKE5c6b2MCdGDYpdodEbjam?=
 =?us-ascii?Q?05+f6opjKUBCou7v/+8ax20zUA1dFWq+2iT0SgaE5OJdqmPsCUzVAYFTxZT6?=
 =?us-ascii?Q?Z/0KgNweVb4o2MpmG1RGLd3/OMGbApo1LqGzaRm4c6ypiag3nfL6VIr5dc+v?=
 =?us-ascii?Q?W8V3RK6+aoQoToNLxHEPCDBTUYju4RRKS1TTVaEJHEnN0xl3R0m57mZTvJq6?=
 =?us-ascii?Q?ZS3J94j8ViRFPPXBCtpZ1uGrC8I0p6crEODCrrpwpRfIl7//L777RoK+bczJ?=
 =?us-ascii?Q?4jGFUduJvXywwoBPILNQqvWZurHBwQW0CG/sDBjSuEypbJYW13xaQLFCQXF1?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe9e3b6-d1dc-4836-7c62-08db5ba96787
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:18:54.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2A4vhQYzJZ0pllYw8rECoc+813b25GFAHt+rqj2BZDFxNqT6uXTAQxW3MILFdpLKEtAzHPaWiF4c+YGSBzJ0M9zlmSudO0DNwXcVOdBP/Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add `dlg,jack-ins-det-pty` property for Jack insertion detection
polarity selection.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 Documentation/devicetree/bindings/sound/dialog,da7219.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/dialog,da7219.yaml b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
index 9160f68696dd..bb5af48ab1e1 100644
--- a/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
+++ b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
@@ -122,6 +122,12 @@ properties:
           Debounce time for jack insertion (ms).
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      dlg,jack-ins-det-pty:
+        enum: ["low", "high"]
+        description:
+          Polarity for jack insertion detection.
+        $ref: /schemas/types.yaml#/definitions/string
+
       dlg,jack-det-rate:
         enum: ["32_64", "64_128", "128_256", "256_512"]
         description:
@@ -215,6 +221,7 @@ examples:
               dlg,btn-cfg = <50>;
               dlg,mic-det-thr = <500>;
               dlg,jack-ins-deb = <20>;
+              dlg,jack-ins-det-pty = "low";
               dlg,jack-det-rate = "32_64";
               dlg,jack-rem-deb = <1>;
 
-- 
2.17.1

