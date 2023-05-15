Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB15B7030D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbjEOPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbjEOPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:01:12 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B359E76;
        Mon, 15 May 2023 08:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSCjf+zsD30erHC9ZRS+Ze7B36dc8K3lISyojWeiVyhJRPiENdjuSZqeIyqGj3e+7hukTM61RQgDMMrxPBue92+xkakYES2N6yNzSe3nr+WNaYeBIZzQ18tzZCiq1nK1ZRXkhvH01liHDtLPOB+uTN1jfQOvZ/swu/8cY+ToIhn1MLA153QNw4/lgtLVt63ZBzj1ws+IXkoiGDHyjVnw1w9rJ+OAE5dr6xNeMc0oMDnIpLKXHyoNDKXWp6FMlX/nF4WJWr9Px/IpqTBHYEXtFEzi3h3YwoCrGfyBMmRHjQxStD9kUPUkg2YCB2iL9AsaiAQeHOtGMfyKFVJop4h0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uXd1f6WLsr4xPGXy95i4lRpgF7jWEYyV9TrkD3/xxE=;
 b=BT+B769dYCdwLiaJcRyZ3sz2tqT2BUYDv9mIqexHetBQ7ovpmsaOutTaUCzH88oTBOsdvedxpVoyj0MQAqBcDF1lMhqgBJpRgOV0Cou71ibhgT9wbySpzMOktS4cxV1f3XpXJO4LzVftgSKTfg6l7d8jpGxAVge2K+8QxL9gScI81ue/ode42KYZFdmqlGESJV3/D3TObbZVyJu8PBrVzJmbZGptT4+6xMIoXh66sHiNKfaxIwKir2uAO2t/f36DVMXMRxNi2MVu0W4P61TLh1ltD7AbYsjplgTdUBDOVfPZuI2OeYKAg/YBqksm3Jhd7TpInOwFS41z8qcNnyvSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uXd1f6WLsr4xPGXy95i4lRpgF7jWEYyV9TrkD3/xxE=;
 b=GMjx/uBT7W9wepjOIvmfUB0o57TnmNM0tuVI8G/WGbkpi0OmzbcL6uyGTbZt5o6if1nqHdm6sJz53NHnBBcqGIpx9saVOpuuvq6V2GfHbjIqcVkGI1ZTZHSUwbiMmW3RudJsQQSCHY0poA+O/w00ANVvt1ZKiBswzg2ip5fWiMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB9982.eurprd08.prod.outlook.com (2603:10a6:800:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 15:01:05 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 15:01:05 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v2 0/4] Input: support virtual objects on touchscreens
Date:   Mon, 15 May 2023 17:00:57 +0200
Message-Id: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAClJYmQC/42PQQ7CIBBFr2JYSwMIrXHlPUzTAE4FY6AZEDVN7
 y6tF3D5ZvL/m5lJAvSQyGk3E4Tik4+hgtjviHU63ID6a2UimDgwxRkdQecnAs1pKB5zNPdh0tk
 6CqLtlGRaQydJjRudgBrUwbq1oLSNpGj5upoQRv/erJe+svMpR/xsRxS+Tv/wFU4ZVRoUHLmxo
 pXnV3yMvw+aAJn0y7J8AeIRKI/gAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684162864; l=2419;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=kDLvW4MNdchFQrzoH6ZWFFnmP+Odi+a9gcFMheCzoMo=;
 b=Ad5Mnvl83skIQmz0scJ2VyMIB2JRJrqtAY0o5qosDG5Jm5wAZbXQDre8/bVIoK1wZReHHUrl3
 ZLWcRsvDUwJB2w1ntZTH9IQp2NAeecx0t5h5Y0Ykq/yYMBpuRkcRYqz
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::28) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB9982:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf8a861-faeb-42b4-4c6c-08db555534c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NL5vBIuE2cdBBX+55gG5zScQ9G1PK6PsJ4LIR4qL1ONz+vGcKhdGFzG7tw5G3lg+whla27JutrgMWXIZTOSLdhu8QE3Xu32xm9kCq6CX5hp2Hz6YYBDtS8taPcY6zY4MQ9gAI84X1C9NiMHC9CmkLlvVaK0Bjkpv0cM1iZALDv0DwUWvYYoge2e242p11Kz/y6jH+hgTxD//skQjnRxrCO65tOvmV4Cl0KmcKfmlqH2CFvczWzUpufsZwdvmi59DXBBMOSti+OFbc2qMeUiqbfDj2ifUQ4Iy9MEkLY3d+xvI4wMt7KyUBLJXe4/+EvgFyKqxomCUbb8ra7ScTPam8P80MFaA+W3sYHethpx62+QM0GqMtS7EekdGfbNfTRDPDa68cw/4bc/xeNqjfvg7mAkGfPJ2UnripRshs7Rs8w0lpoluREpZ4JI0Tss2ZPq8T7ew6/wO+chy29FC/TgAamjBCHuT4Mmj6InNgV5pP6Ow06Up25IDwpNO9nDIJYy0yZevBfv6MKwJtpw68Isme8q/wc8AfpUwmF+UkOOeNPPNbgUCS25idUFIDvkOhTkqGyYYcQ15HEXJGFgT7gtb/A6TqWI19398bl8aEcNUYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39840400004)(451199021)(478600001)(2616005)(86362001)(6486002)(83380400001)(6512007)(6506007)(26005)(186003)(38100700002)(38350700002)(107886003)(36756003)(52116002)(966005)(6666004)(110136005)(2906002)(66946007)(66476007)(66556008)(5660300002)(316002)(6636002)(4326008)(44832011)(8676002)(8936002)(41300700001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1abWl0UmRHMy9Jdkg0ZEtBWGlrM21sY0tvUTJhajF1RHJkUnB5R1BPS0JL?=
 =?utf-8?B?MmxDaE83am1iWWh5elpTREFEd1JhL0RvRUpRMGI0cTEyaFBUWVAzaU8yOFlP?=
 =?utf-8?B?djNibCt3djRVNm50eHdmR05EVkhkSTdUZjBzam55Z0RLUFlncGVrUWN2bkh6?=
 =?utf-8?B?cEQ3VFNrai9KTmE1V2tlTEN6M2F2VXphSHV0ckszbjlWMTF2NjdoYkFqdERl?=
 =?utf-8?B?M2VncnFTbGh2K2JPR1VrZEt1S2xhTERtaklDUWVkYkVFRmRHUVlqNW04c1o1?=
 =?utf-8?B?UVVWeUY3MmxEV0cxaGtQTk9MTER6OWhLNGswbExBd0U3dnlhUFh0YklaZDR0?=
 =?utf-8?B?T2M3cDAyZ21INU1YNDhxL1piRHJycFkzdXFWREFPcHV6SnFWRXhLb09ORElm?=
 =?utf-8?B?TUlsUDBjdEszcWhZaFA5VFZ1ampxNnpJMXJURG9DZ3UrYVRpTnNiVG9hR0Ex?=
 =?utf-8?B?bWVFeldESXFQa2gvQzVnd0lUNEUxZCtoSWZlWXZUTXZHN1JtUkxCT0UxTHF6?=
 =?utf-8?B?RUdHWU85bk84SE1sb242MmxveFRUVGJMU1ZzZU1PWTZaREh2VUZIZmhjV3BC?=
 =?utf-8?B?djBDdThoUHBLWXRwZ1UrdXhFZmlBRTd3TlU5Ky91WGhrUXVRZEJ6MlpGZXFD?=
 =?utf-8?B?WnZuZ0Z6S3E3dGtzS2duaE9JYURUeUhYNDVQTEVDN2RjSjhtTTE0ZmtKbzRO?=
 =?utf-8?B?eGxLYTNYdHdSL1AvLzlETkZzWmVLVFd2RWVnQzIxZmZlcXI3UXhKOEwyaFR5?=
 =?utf-8?B?Kzh5S0YrQlp5cDAxTXlZY0pCSUhSaUk3bGdMTldFeFpvRCtTMkFKQmUyVWNi?=
 =?utf-8?B?aTdTeWxCTWFWQ0RtazdKd1FPMUtJQVczMHVBWTRBWkNhM09CbHVpT0U2V2NH?=
 =?utf-8?B?N2JiWFBrNGFjcVU5S2Z5MEs4aUJhRmNENnAvYjZTaUloVTF2cjZ6YmdIRnNV?=
 =?utf-8?B?NDVUMWJsSEc2V2dSR0RQRjNQSVBvZDh0ZkFxa1hlUDFLZE9STExBQ21TbU90?=
 =?utf-8?B?eUY4cVZ0TW4vUDRwekkrVUUyMTVmb0RFVkZ1dFpVdUJWZ2V2eVhSWFN3dlVP?=
 =?utf-8?B?UTRlVlpJaXVWUGt5UVFROElqUXFqRFRnUVFZVW02S1F6K3RDUWZxRldwQ3cr?=
 =?utf-8?B?S29qRG9zckJzUjFSZ2FiZy9HM1BES2xoV1gwR1p6aE1TWEJBQytKclA2azJm?=
 =?utf-8?B?ZzRKSjg0eDVUV25PLzV4MVVHQ25vUW92eEhXbDRKamgzdzI0WDFwajA2VmtC?=
 =?utf-8?B?UHduL0xCcXMxTGF3UUdKUklMR1N0NmZ0N1FveDJGUnFIWGdmZ1drUDVvcUgv?=
 =?utf-8?B?TDZPVS9UOFBNNE9GeCtDM1dEb0FTdlVuOS9vblQ0OGt6c2l1aE5UaDVvQVVi?=
 =?utf-8?B?aXJROTBNOUM4RWhxaEF2OUozN09OSFhtdzQ5N0M4R3piR2JkZDZBcDhxWFcz?=
 =?utf-8?B?QUxIRy9JY2NNUGF3engyVmE0V1hsdkcrbThRZ0hiV1ZYb3Y5VjZXTTJ6MWJP?=
 =?utf-8?B?NlljckJsSkYwVzlYNkJvVCs4KzUvVWFyN1NOZTlZeWhERklZVXJuSVVEeXNh?=
 =?utf-8?B?WnNxWGYvcjVnakRMSnhZd1lhckpFckJudVh5YU9nWjdISUFqOSsvNUFvSnlQ?=
 =?utf-8?B?KzZTRFdQMVlpM3duQk1aM3YzWDJuQ1M4OG01d0tIV2YxN3ZzNlQ2SlNHQXdX?=
 =?utf-8?B?VW5NK08rNHA1OUdDck9uMDl6OHFhUGpUeHkyT05NYWFTN2NDWll1eC9sZjFj?=
 =?utf-8?B?c1hZS0lnU0VyQWV0TDhGcm8rVitxZHc3U0JJTUJJM1pRajBseHo3SVNucUlQ?=
 =?utf-8?B?K0NjTGZhU1M2ekx4elRzeExiVE40TG80blFKYzdMRDI0RksyRkxJaTdCN0xy?=
 =?utf-8?B?OUZwdTlQZHVTdHhyeDFnNHJ3eForZk5LWVdoVmR2aGxPdWQzS3M5eTRDYVow?=
 =?utf-8?B?WlllSEN0ais4U0xZYXFGSmhSQWNnSVB4UWRMOE1lSEd4cDRzY2dKREQ2Qm9X?=
 =?utf-8?B?RWx5MmZxUkNWV3R6VmdqZFVOZmtzYjh6Z2Y4alRSUXJkbEFrQTFJa3QrZ3pa?=
 =?utf-8?B?NWVJeittNnFKQ1E4djVGOWwwc2UyS3dWaG1sVWV1d0xNZ2h5V3FTb08wQ1kr?=
 =?utf-8?B?RkpZRkV1NDBYVHdWTTNNY2U0SXIycEJ5aCtnYWpwcE9xQUJBUUdEUXQ5aTJT?=
 =?utf-8?Q?aNMRqgZ3CcF6AEQlCSUS4ZY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf8a861-faeb-42b4-4c6c-08db555534c3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 15:01:05.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/+09m+lUo0WfEowSWipv0KEFmnDfBt5TDkov8YFi8aZSBRavzyj0vdwp7lpzm7if4plk26NcHJ6zzub4vBVBew+KPNISWZaAEByp0WujYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB9982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

The functions in ts-virtobj provide a simple workflow to acquire
physical objects from the device tree, map them into the device driver
structures as virtual objects and generate events according to
the object descriptions.

This feature has been tested with a JT240MHQS-E3 display, which consists
of an st1624 as the base touchscreen and an overlay with two buttons and
a frame that clips its effective surface mounted on it.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v2:
- PATCH 1/4: remove preprocessor directives (the module is selected by
  the drivers that support the feature). Typo in the commit message.
- PATCH 2/4: more detailed documentation. Images and examples were added.
- PATCH 3/4: select ts-virtobj automatically.
- Link to v1: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net

---
Javier Carrasco (4):
      Input: ts-virtobj - Add touchscreen virtual object handling
      dt-bindings: touchscreen: add virtual-touchscreen and virtual-buttons properties
      Input: st1232 - add virtual touchscreen and buttons handling
      dt-bindings: input: touchscreen: st1232: add example with ts-virtobj

 .../input/touchscreen/sitronix,st1232.yaml         |  40 +++
 .../bindings/input/touchscreen/touchscreen.yaml    | 139 ++++++++
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/st1232.c                 |  87 +++--
 drivers/input/touchscreen/ts-virtobj.c             | 356 +++++++++++++++++++++
 include/linux/input/ts-virtobj.h                   |  43 +++
 8 files changed, 665 insertions(+), 18 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230510-feature-ts_virtobj_patch-e267540aae74

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

