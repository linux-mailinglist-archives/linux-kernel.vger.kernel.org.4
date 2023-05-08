Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9316FB14F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjEHNTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjEHNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:19:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B037E39B8B;
        Mon,  8 May 2023 06:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyedogH/UX5qVGDZgvQCfoyiU8WtpfNxfUhrDDWPhzIPprTeqzikSbo9wL/gKrpkTgfkJ/LWvY6T6rg0xXeeRVWLZK+s+G+OgHfuQCJsvxOAYeL8uOfGyZoXxgPmpI/2jzO7+qc6XSYPfXM/piLI1pYT0eXyqszXajvqpJoCMkqx036QyHu/UstHLxz7Mrx4d75IxJN1yA4tS5xelYz6vMzcB/N6/Ck7M3fd0OGo6wWruh/7BqluNFqmOTt618XX1c3b6t0m0VgK8MM7UluRaqabIalNZPnnsP5KcNqBu05SbdUEau81o0E6ajHDTo5ypV+JcTsQemJqSAWzMK0A1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve8uVCO7yTDGr6aID0sOvdTi5YPE9IjrS94brBUROs8=;
 b=g+k/Zra1U9L3fQRQF9NDhL2aLOvfZZ9oL04vuCffm//9PH9nxjbeIpB4V4uB7JHxPRwRLpr4iXmI61OIg8lfBXNX66BiLJG39QEe7lbxUUEhTrGtKszj6S9BKVtnSWZEOstWQBTTXei7Aa5YpVtfLRwhjbQ5OqjCC0BPgymgvV9GzSDJZhGPXQ7pOhLMXu+G7D1vwfzP/ybipvsPJbep1n8nEI9IJu5ytVtKcZypX+j7nFDOdCC6YODqjWQhg+s8K1PkjTVlPkyl4gl9IWCJiR3UT4rLkcRs7OU1ANQL+pdpUWPCthtPxviJjLqwQX256G5AZ5XtO+6Bw+RLDxc65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve8uVCO7yTDGr6aID0sOvdTi5YPE9IjrS94brBUROs8=;
 b=f0szHZngqHy4dfMaAywXU1VaLsmUNhGSdZVmYLBGzAHzJY7PAe4i1PZIf0mbuuupVSu+e5T/QaNp9C/MJEwMxVPh3YQNaTAjuKnQyUu6W5Ydr4KHrV10ZWzQ0TjP1lsVggkYWC655LU8Vmw+KJWBtVTHdfvOHsA3UPkePlqoySw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6892.eurprd04.prod.outlook.com (2603:10a6:10:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 13:18:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bcdd:75c9:176c:39ed%4]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 13:18:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, fushi.peng@nxp.com
Subject: [PATCH v2 2/2] dt-bindings: phy: cdns,salvo: add property usb2-disconnect-threshold-microvolt
Date:   Mon,  8 May 2023 09:17:47 -0400
Message-Id: <20230508131747.1933886-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508131747.1933886-1-Frank.Li@nxp.com>
References: <20230508131747.1933886-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c85937-997b-4aff-1b50-08db4fc6ad47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eD2O0TCm93ZMbGQ1llWJcZSKSNE8P2rofXNXaA3o0U4q9AST8B/41yobOkj7QQY2eAg29g/7kyAgjm7D0Zo0ZEnY8KsJfVHogfmDlRjIF+inHeGbfbsxOdGHd0u5soI5l17JT6cSi9b35stGORXxleQyKlj0E8+dbAbAVtg2QinKi0ekxMzc6IMGOWUDf6UPbE14rnyi2CNjHuIebApQKtyeYU2fMeze4/GxfjA8Lx6LNj1uaDba530PxEMOqWFueklc3wn4MBVXEvv3bT4CYa6fok4KrbiAiC5DMg4/PSkBKUGDlHoRMLRSAzu/xgWvLst6q9La1oMra14vHeFma5+V98ns+ZumZvgSyZZXK/LZvt4S0pX2VvgDEYRjV3G4X4Nv9ILlUjD2P+yCkTFrxgDbolvk2zQta+x/jWnqHm/LJplVtdcjWk7Q+wmA6oX2fIIPDCg5XC3BXKgu7uK6gnzyxL8Bkg/ALFO2Q3wQRWPs5pasbV0DrynO+y/rmYxQF0pWiEx1o0Boy8PnaWLUO28A8TuB7LXYU1pg/3cWYSMuCkk0+9XU7bYUyEdgzeE8QJryrp6Hrv2AcRPottPp9QuXDmkO5jhR1Ny2YG4GhSCZ1rwhjWAXFRgYAyuKcc1fYGIsqEx7bl77Pv9QHpOWiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(52116002)(66556008)(6636002)(66946007)(316002)(478600001)(6486002)(86362001)(66476007)(36756003)(83380400001)(2616005)(6506007)(26005)(6512007)(1076003)(6666004)(5660300002)(41300700001)(7416002)(8936002)(8676002)(2906002)(4744005)(921005)(38100700002)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bZC0gQb294U1vaLoFVoJ7LunbhesDUfkpcIMKDDGuja5Jp83VaRZfmoaF6k7?=
 =?us-ascii?Q?I+BqiEkIWqdQ6wHlBYEhyAjSCUd/zsNZXB9TvP4FVxPIE2eV76PwljRFGZa/?=
 =?us-ascii?Q?MjFIw8roWdequwgZoAyQX3i12rckscHlcsvMhG8t3Hkk6dlI4j3bCX5dQYew?=
 =?us-ascii?Q?2pJyLRJ3DYgHfjQLg2pJ2UxLvNiH8zosu49iS5D2rIZkQQDxeWZ1pj8wXcWZ?=
 =?us-ascii?Q?Bl3aYhrwVgf8Q1ne0NvLjpCgt9iv4etk/mDfTEj5GIHLwxKCKCLojpmgBrIJ?=
 =?us-ascii?Q?WhYKm+4tYd4DKAkfXrsWveB3CQ0GFBrQTTIevRxklSA2TeZIu9znWMPUjmBH?=
 =?us-ascii?Q?LQOLRAML1bm8jmvdJqMfcjAbw0dKAyAblLDS7e50t0yfkBrfZ2F8Re3OkmuV?=
 =?us-ascii?Q?icmUgwnBEUI8g7E6cmqozAqC3BHjohDXfX7ZZqGNNtIMKJ66kjjCu/y0pk4N?=
 =?us-ascii?Q?r1hRZyI5UFVB8YjAw5C527GvtTQrmt+N7z+R9E8JsxqpoFqfrmDpNid0J/3+?=
 =?us-ascii?Q?gags6ShD+BcFdstmQ7+wXR7GMJIAUuGE8Up2y3+nkfWuth9gL+9Fxn6BakqL?=
 =?us-ascii?Q?VyMRIL64BWRhCv4MsFcmGBfrCCWmdEz0ECAF9E58fB3F485JNGZ8A5mOsdp5?=
 =?us-ascii?Q?mlbsUVnpapYvdqLk7CjiGqLvPGxZ05GHZHrIlcVGyRYR1pqoVeMoJd2WYWZO?=
 =?us-ascii?Q?9grEwakpUHCtkQ2dR637MUo29TvpRqnpD8BXOcSW6sd/+uOsmLNaTn6lCsWm?=
 =?us-ascii?Q?fovSnT4GXzT+5TzL2aXW/Qem2k3eMnUtvHNZooB36F010467x3SNj6sS5EZI?=
 =?us-ascii?Q?/Z9OeZRmyDVu9xp4Dz00RB1vsDWaeEZRD7IApIw5JZuOFvu2ZpfQsz/T/sm9?=
 =?us-ascii?Q?wHID5xHAKotM9UydHD0iuby4mtAZzRy0o9hLapyPT7gZVzLzlvGuXrLhqlng?=
 =?us-ascii?Q?tYnCVlT107u8MTxmvNbqCirplPpQzxAICdzdf5Yz722mD6eBmbnL2BCQBSap?=
 =?us-ascii?Q?80BDoDGzT2J8mJiNH46oqJzJi2SyBLZ/kXHvxKXPxl1yEG/qXbSCOuzo5eWj?=
 =?us-ascii?Q?S4qXN4Z+d/oyjsKW4usWGB/IgI1zwAc4H+DwKiFLlvrdPMwlxbjC+AQQpuao?=
 =?us-ascii?Q?Tmjf2D5gHJ6tYYxqLCI48YicMYN7IdSwziUHMlKKwIFeglnZyH7p6n84vkyd?=
 =?us-ascii?Q?Bsvcs4DQ1Ru8k0R5QFyEc3kG87AV22M0EA+gAf3o4aRiY9HblLHpX97NLK6Z?=
 =?us-ascii?Q?8VuDHVO6ZTytHFP7nHBKFSI9awOqDcFLWkXVOOheALW6mtpUV12tv0u4Ebov?=
 =?us-ascii?Q?Zudz5r8hKEcEf8zoksDX3Y7FMUxrbxrGMRMGhq76o8oQJys8fazgrSv/NXig?=
 =?us-ascii?Q?u5J4FnrmTa0PqbwAyZ58mE5GTuoJ/Pu2xQKuB+7dzTRCdd0I6lg+A+FvchQr?=
 =?us-ascii?Q?RYELCwajwI7DkexnbL0akTB+9otJGmaRqhliL+/n8ttc3oYuXHf9uimVSJfx?=
 =?us-ascii?Q?fYyFJ64+yWE6LlB8twAN16OWP9p3ZRCjVL0btMPEgkk3aGfFziF1hiob/deL?=
 =?us-ascii?Q?4PQFsHrFGImd0yvMiUmL1uMofbIMfRWOvoK4va4o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c85937-997b-4aff-1b50-08db4fc6ad47
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 13:18:13.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzYYpnWnTLC+kE2hrzxt0WIhlUWMYpYLOeSHjDWEe+bxE1RjNl+2rCZOCy41RAEYeuUlHCepGgP+aoYmMQhw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6892
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb2-disconnect-threshold-microvolt property to address fake USB
disconnection issue during enumeration or suspend state for difference
platform.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to V2:
- fixed subject
- fixed dt-binding-check warning

 Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
index 3a07285b5470..be415b0a6d8b 100644
--- a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
@@ -31,6 +31,12 @@ properties:
   "#phy-cells":
     const: 0
 
+  usb2-disconnect-threshold-microvolt:
+    description: The microvolt threshold value utilized for detecting
+      USB disconnection event.
+    enum: [575, 610, 645]
+    default: 575
+
 required:
   - compatible
   - reg
-- 
2.34.1

