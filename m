Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C969F7328DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245012AbjFPH3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbjFPH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:29:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F526A1;
        Fri, 16 Jun 2023 00:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1VKfpJa/YQ6k+SDQ29CAXqb3NivSl76ralwE4y8ldSRkblymxlxAH9R/s4qFJZ8rF7UGlFrUgY4n8CT4ivMKkmsS+H+da4kfWydhqgcBDr3Id3aqqYTdkuhEThFw9r1Axz8oU5fJS0ICp1VoddS58KV9xhjOfOuPgu3bzJNoaf6I3+QfaAWHrTwzcp1j4xDWd1F4QdwOgdZBdCSMSh5DNRBa5mluyguE+Taod3aNXW7PEG5NKnwlQUmu7WhCmUP3/59OnWMKij0uomE8RNQ/b/KNZ6U1Hjnk6Uh/uNsPtZO13IjrwErGoM75jddtpHEW7z+bxOqWshX6CsZYqyDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZZ02nBwROclrbIOV+nWq5Qc43lnwrePpPOoP1llooc=;
 b=ASf9RM32lzfCigIqTflnulkrkYa5cAHGl0cKG1axCp5GHU4JB/3Ynhr23eNxbc+sthr7vYP7o6adXSebghHGfq6httzoDcwkkDCuqK2VVLe3KqSNOb3bvulJs72vJjYGk7Jz1YgvR4AkqbzUBOZ0GwKG/R1EDTDGVzxNjzYQPMf3w5OyeBeTO2q7sJhAgW4lCuHgHSSU6U4rVfcSMIzgBLEwWBhFEhoZ50gSWQ5OFTs80e4DzRa2E75x1ndhWW4STvkULJ/ZskmdhS1G8DVkFSthxE/v0tUXq1eZBLKf/JeMgAi+AeUX7UbkG0XcGbfp82HIY9kKGvm5blWC04pPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZZ02nBwROclrbIOV+nWq5Qc43lnwrePpPOoP1llooc=;
 b=b0x0RgWq9mLuOqF+Alfpos22uy8phEjvvvP2WiRcjzFR6zrdrL9j+1R93HrhOE6xUef4LbCbmV0edoIyfSYffFXdaaPG9yO+cVVAGJR2/j72+J+HEOe5v+eOPGo2iMmDvUUzV5q7cnUSLpLbbYgjPbwnYONC4drhVTNqlxaUSD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV1PR08MB9916.eurprd08.prod.outlook.com (2603:10a6:150:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 07:29:09 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 07:29:09 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v3 0/4] Input: support overlay objects on touchscreens
Date:   Fri, 16 Jun 2023 09:28:50 +0200
Message-Id: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADIPjGQC/42PQQ6CMBBFr0K6tqQtUIgr72EMmdap1BhK2lo1h
 LtbcOmG5ZvJf39mJgG9xUCOxUw8JhusGzNUh4LoAcYbUnvNTAQTFWs4owYhPj3SGPpkfXTq3k8
 Q9UBRyLapGQC2NclxBQGp8jDqYRUkWdbUa76uJo/GvrfW8yXzYEN0/rMdkfg63dGXOGW0AWyw4
 0oLWZ9e7mF+H5QjRrKak9hrE9lmZAdSGWyBmT/bsixf+OvRpi4BAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686900549; l=2693;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=nJCmx7+oAnKcJw3blXkcdeozwxmBFkx/bSwLYf7svx4=;
 b=mo73cXEERdQ3eH2i4lT7XpWxtUTiuBvHJ0/QTR1Qqhcfdn0EQawhMY6my1rBj7YNoEfT6tdmg
 Gz+8RsU5NYqAtLVWajZskcIMgg/R225z12irx1LQ76M9MPFeYN1R0H6
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0197.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV1PR08MB9916:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c5d8a1-9c04-41fe-2376-08db6e3b5fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukH8ff34TNoPTgM02naoEVJtmt+RYFLpx6MSEwNUCi/G6883qmyTtGaVrRw8tI+PYViln+qczGAkQ80lWRadGP+SqjCvehDkWkcp7TcxSiW8jEWc5cBdUXZV8kbuvbQT0k6ruhc9C0/F1AQhcmT9/XtrcIaEUn7P2MoDIMwNtI2kGbXq/B/PkeikWkaNbM4EsW9bLCxuTCcmnYTHlCoeKcBmwqmuNMrBC/HqUHfo3IgRlrU0g8GwF8oSsLgPyeLLKRV4nJAfwBdd8208SjirOUVevaZ2G49Vmzag3vF1MHmkfHVogm+nv9eXm2KAMXMWaSHLGnJkewui2VgtyD3xMy8SZwqWebLN0Ukj8KYePbjSFjfjI5IsVNd8ichCZW3GE60Tl2N1PzufSOFJtPegDPdXwbxzeyiV8B0/2+CVSC5d51u7Gz9aB0bg9aEd/zmIfYaPy+6VnKgujg5rG7sLpq4CAAkCyejqhxUzucpsjcj9eayU3l7EAiDAfseNGjanmqcWf5QCMMea+teycf0gzaSVBnpT+0GVubEF/RgbpypdVJDzZTvRGRJSdtI3n6SrAXe6Sh0hLFmrlX95tlzSFO+TbSmlAM5TSAJbYrxaYIfzurgYuXw/teaAJsIIw0rOk/Yo3kVzhLLR+9Pch6YAbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(36756003)(86362001)(2906002)(44832011)(66899021)(83380400001)(6486002)(6666004)(186003)(52116002)(107886003)(6512007)(6506007)(26005)(6636002)(66476007)(966005)(110136005)(316002)(41300700001)(38100700002)(4326008)(66556008)(2616005)(38350700002)(66946007)(5660300002)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dERFb0ZIZUR2VTdpUWJiSi91akVhdTFIdE5zTjQrU2I0azgvOFM2c1ArR0Y3?=
 =?utf-8?B?dTU1cS9zQmovRXN1M01SWDBROXJoTS9rdWtFRWRhYmRrMnFObUM4RGFsVXNJ?=
 =?utf-8?B?TDYwNUVKT2FnVkkxT1REWThzYmhISks4dWJueUxUYklNeUNuYUluMEZBdEZJ?=
 =?utf-8?B?YmIxMW9kcnByNVZiUlR2dytDeVJ5QUk2aUR2VXBCUW83YlFTMC9oUkJCUmg2?=
 =?utf-8?B?NHlza1NjeWNnSHhQN2s1ZGFhaHZzd0tsMmFaUGh1OU9aa2M5bnVvTDM2dmYr?=
 =?utf-8?B?VEV0UEVlc21mcDQzb0psRW9xVEN6YWluckxxNHpFS2JMaXNhMmM2eGwrc2pk?=
 =?utf-8?B?aWlOU1lQeW9NY1AvNDhMTWpsRTl5SGx6dVB1SUJ5WkVXczhaYVBnTE11S3Az?=
 =?utf-8?B?c3dUUm5WSnRnT0hNY2h0Q1ZMTitMRkxoM1M2V2xYZk5CMDh4SWU5Q3lFWlZX?=
 =?utf-8?B?SXBldmJhaVVqSFErYis0bHBndkJJcXdmcEJGN2xWK3d0MUtDbVV6TjI1NXZh?=
 =?utf-8?B?cHBucFlzQzFVQUZmRWp3YmU2OW5MbDAyZWtsQ1lDRk5kZVdjaTB6WkhhUlFh?=
 =?utf-8?B?QzcyUC9id1paYjBOa3pVbmJOYXpqWGZQY0gwWHNrNWc0dlNRYTlMcEhoUVlF?=
 =?utf-8?B?MHBtV3hyaWFSOVU1cENIMG5EWmU1ajAwazkrcGFjWlNMZjBXZldWS00yQlJR?=
 =?utf-8?B?VC9WV0g0dGVhT2I2RE9zQ0RXRmRFYlFVN1RPUm5Dd2lRaFJ4blJFOEhoZklh?=
 =?utf-8?B?UHFHcmE2aDVmQlo1dzNVSnJndmhCZkJFNjBSL25rdDNzR3ZDMDhpWXBDaFcw?=
 =?utf-8?B?bWg3VmtZMXpnZVBCRElibVVjN2poUHdDRmtUUjRXaE1SSklUQzF3WHZWbFRu?=
 =?utf-8?B?VHQzQUVJTzhGV1l6STZoYTR3aFI4K2JXOEtWNlJZcHNnUjBwcmZJcW1kTUc4?=
 =?utf-8?B?Q2RPWnM2VXhWVG9kdUJuVklEd2tqNVVJSm5BOWRTQlFFeG1GL0pjc1hweWo2?=
 =?utf-8?B?ZitEZzNQWm9wMTd4U0c2NHRUbThEdGVsMElRS3MzSjRQVWI1T3RZamdKem1F?=
 =?utf-8?B?aHRqNEtTSTdUM1NOQkUrMVlKUjhiY2s5YmIzdS9zUHQ4dW5zTTNSY3dCajRQ?=
 =?utf-8?B?VURWdVZyYXF2ZThJK0JhMkpab3FSUy9EQ2h6K0RTZ0VaaFpPNW1ZdkpBbFZ5?=
 =?utf-8?B?bWpMMHFoVDZoRHhrNHkxUmRwcFJOcldKSkVOblVnTEZMOUQ5bDBVb2hjdDFt?=
 =?utf-8?B?TFZpM1lrK2l3bHR0b2FwdUZFQURlclpScFY5anVyRmFEVU9jemp5RzZvYklo?=
 =?utf-8?B?UGMrOGI5WVZwUms3LzE1OVowbXpXRUhsdmZVellhUHNKTUE1UjlHV1FBMTZC?=
 =?utf-8?B?NThxTW8vM0FOWnBtL215RENVb0IxYWJTaWhkdnpnUjBKZ0lGWjJDUC9OdFFj?=
 =?utf-8?B?SXFTczJPeUJ1RUNPaTV3OVd6Vy9ZdGtXenkvejlDeGozY3RLZ0FsZmlQdGFT?=
 =?utf-8?B?WmlLK0xhVjdrTzl2MTNzbjZNdzZJa1ZURjU3eE9zbHNVdHUvQXliaUdmanV1?=
 =?utf-8?B?L1VEaWxVVGZJOWFYWUN6Zzk0VnczUnBsMk9FM1FvQ0RxeWZ5WXhoUWpEWXNC?=
 =?utf-8?B?d3l4TDFTbis3ejZvWlZ3cGdwcU1abmJzY0YrTnRCRkJ6QnhIWXYwYzg0TC85?=
 =?utf-8?B?WlcxZFRxMTVlWFJiVnBRbkpLUDB2bHVIbGUxaGZzS1pDRnJQeVFQL3JuejZz?=
 =?utf-8?B?TkVwek1PVDV5YWpGdjNrUVhQMDVvblZYY3V1QmlibmFQYllOMGxiRGtYbzBm?=
 =?utf-8?B?R2ZCYnkzRWRacjdQcDd0MUtrMGd2djNtMW9iMzVtNzBKRDRzVUZhanFVM3c3?=
 =?utf-8?B?eXZWZ0RiWHJsd1BCMmViSEVkQW1JcHhtWStrdU82eUtibmtXTnFNY3JIcG9m?=
 =?utf-8?B?WDNmaWUwbVJJTGZ2SVYraWFPM1AvR1ZGWFZpR1pkaVdyWFl2ZUVkbnorUC9E?=
 =?utf-8?B?WStqWlJKYlQ0SjJaclBTYmh6NGFKc0llVElHSFZacTlqaCt2b3JobExLVHJm?=
 =?utf-8?B?dld4Z0VXMHN4ZUR2THB6U1lubjg2dzZ6b2ZsOWFrdi8rcENqaXdlZ0Y0M3Rq?=
 =?utf-8?B?UzFsaGxkV1V1b1cyY2lBSU5XY3VvcUdla2I3blJ6WGNmQW9BUm4yWGxYZGVI?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c5d8a1-9c04-41fe-2376-08db6e3b5fd0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:29:09.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pAG2fegUuT27JC8plROeHJKfZdlWk9QzU7SOJTwa7h6YNB96x7/KaAqBntlVZyWZ9w//qdCcMpDcj2PRyDXsA2zwyFDoGmahD9TuS5Aeg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB9916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some touchscreens are shipped with a physical layer on top of them where
a number of buttons and a resized touchscreen surface might be available.

In order to generate proper key events by overlay buttons and adjust the
touch events to a clipped surface, these patches offer a documented,
device-tree-based solution by means of helper functions.
An implementation for a specific touchscreen driver is also included.

The functions in ts-overlay provide a simple workflow to acquire
physical objects from the device tree, map them into the device driver
structures as overlay objects and generate events according to
the object descriptions.

This feature has been tested with a JT240MHQS-E3 display, which consists
of an st1624 as the base touchscreen and an overlay with two buttons and
a frame that clips its effective surface mounted on it.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v3:
- General: rename "virtobj" and "virtual" to "overlay"
- PATCH 1/4: Make feature bool instead of tristate (selected by
  supported touchscreens)
- Link to v2: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net

Changes in v2:
- PATCH 1/4: remove preprocessor directives (the module is selected by
  the drivers that support the feature). Typo in the commit message.
- PATCH 2/4: more detailed documentation. Images and examples were added.
- PATCH 3/4: select ts-virtobj automatically.
- Link to v1: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net

---
Javier Carrasco (4):
      Input: ts-overlay - Add touchscreen overlay object handling
      dt-bindings: touchscreen: add overlay-touchscreen and overlay-buttons properties
      Input: st1232 - add overlay touchscreen and buttons handling
      dt-bindings: input: touchscreen: st1232: add example with ts-overlay

 .../input/touchscreen/sitronix,st1232.yaml         |  40 +++
 .../bindings/input/touchscreen/touchscreen.yaml    | 139 ++++++++
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/st1232.c                 |  87 +++--
 drivers/input/touchscreen/ts-overlay.c             | 356 +++++++++++++++++++++
 include/linux/input/ts-overlay.h                   |  43 +++
 8 files changed, 665 insertions(+), 18 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230510-feature-ts_virtobj_patch-e267540aae74

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

