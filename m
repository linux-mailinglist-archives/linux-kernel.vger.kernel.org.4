Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A939F74FF05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGLGHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:07:51 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A26B0;
        Tue, 11 Jul 2023 23:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZBzR8f6bfBYn5hgri6Ftb9E3YPyYFJ/b72eydcFRqDT8FXg5Pmp5BV/gPoPEFLHA2bbBnzPSrfwHNjTSleT7eYW2DXPyxZXSva6J3p/30zN/iJFX4JFbqi8Q3Gq3iEU/UpG+eAXXPfwSbOV4c0SCHv2WI9D/Gx+3MmE+Nru+MYEK6wlBaZjmw3F1C9otOSaVtHXQNZO7ISEY5oECP5H5PwJ+EGs17j8hsgOAXzlvKSehMdlR2Ynv26A3Dr5b1KdsU5arbPeaBafoUEKObCX5rCwntVb0/FVbJebwg2BiPaTeklY8v9RszK8paxzXDajiDE3Um1gKZq5CsQ+JD1hcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcKi9gNgyMAdxOHCDNDy5HYHgaPQZN/5zT8iPysfUWk=;
 b=SBxpugB49exRqKbqKI6cG+cCOTgwJnt7+NPGwFh9FyOr8m1NDYsUGd4X8tIvNP2QIg0FH8HsbGBGCbr6PZYU092P+J71UyqDww93kbaX0SHEKbXjB4NCIqoztpCjfqVh4znKzbdjK9l1wBn9Dq66qEYOOjY8pVRMdW11eW89Mw07eF0BlnNTeFm7cpd4fcohWgjcQllO1mfcMgS2g/KvmObARDlqVEfRT1Ur93EY97sU7tMo9pP2VsrUAl0yo6tIq9qYNZZkhPzu+l5fAW0MVLZhE1cqNcHh0XgzEUW0DMPXHPLvsRIsIwJRGkfxodfV/w/Z4XuGXQraEdq4cHaj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcKi9gNgyMAdxOHCDNDy5HYHgaPQZN/5zT8iPysfUWk=;
 b=TmcwagYpEYiM86UuvPHjxmWtfsWd7LdOceNtPTdt9484A1ljNo2KOoXkdfwnnwzJXxTIFwkLFao6Qz3d5ncVPCC6KL/G4dr2cHy3lz8656U9l008/rxAtXITXZrk8xNo0Mo2uFCYVqKR4u0TwQ2CSk4S59VRDnR0WU8CFsuoDVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM8PR04MB8018.eurprd04.prod.outlook.com (2603:10a6:20b:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:07:47 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 06:07:47 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 0/2] Add power management support in CAAM driver 
Date:   Wed, 12 Jul 2023 08:07:26 +0200
Message-Id: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AM8PR04MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 91299352-dadf-4f9e-1ae6-08db829e508a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9S7EcVHgYcqB4fN0FpU/0v+oG9m7LL6wWd8Ry++L6O+j607owukTE0GrqFjd+4tgRuQOeMcY/k1bsf1/HCRIXoxkW0ndjspUQrNPegLJTO4wea4TVoMiAYGTl05/YfM2Oub7BfMRDz4RYNo2D3RCpOHf8LixKCzjep3sEyLoGBp3nhqLift0PImep0wFycC90zVNQvDH38W/q+tA2kHhTrk6sD28OfPKGZtFgZBlCtVGzAAy05vsDu5zcpXZD2Psy1+Le8JLRbE9J9zUKoYT7qRE3le2GuKIis5G89Mtg+slCBEQVZIJnD4r4ta6EPozvtzZjJSc7lh1eA9YDDrJIjlFsUQiK8GuQq6AFzV2ib9xS/cqoMiHChmKJuQSJ0kmWnmHjEfoF2dDU523Nxw6QWgP6aDB7X8PH+nCC5AsVnEPJ+vcXojjdqd/fg2HL3UKi2pxBxfaGUb+hgQ01ET03/HS86yD27nns2aguSI/IH8NUfXLOLYQFEpWYxjWbaas1Xbi6lh63/prEbLikwQmiWiqPawWO8ltMg4rqhaYAaLnid55QIT6/4HhRGhzwpjZDCSOwjaUs4lvA3P5P+q64IrAagMXDKFHLsBxEqiDru+HkHr++SSvELfu4xOiGUP9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(83380400001)(4744005)(2906002)(2616005)(36756003)(86362001)(38350700002)(38100700002)(41300700001)(52116002)(4326008)(6486002)(6512007)(316002)(5660300002)(8936002)(8676002)(478600001)(66476007)(66946007)(66556008)(6666004)(26005)(186003)(4743002)(6506007)(1076003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE0xaVl5STlPUnNucTBJRGF4UHVrMWpaTisxdC9uVytHTWZldVhxTlRMR1dE?=
 =?utf-8?B?amFkWHpsSDdaUzBWdDBCeDJQUmFOcWd5NiswRlp3VkgxZy9JeGtxd3F1MDdO?=
 =?utf-8?B?Q3N6ZTZ0RVJneVpHZVhEOU9WQVp2bTRNL3pPMG1jeVAzaVFWVzRJTXNGWlZK?=
 =?utf-8?B?TFpCbHN3YUxDZEZBNCtPUlNmdThsUVJZUFl5U2k1NVZTNDVORm1nUHhTVUVq?=
 =?utf-8?B?VkNqZkUvd01sTER5SVFUalJodkVHN1dRYjAxMDRwQjYvYVZzWDlmVVFnMUtl?=
 =?utf-8?B?ZEVIY2ovYUROdER2OFNRQ3hHVm83SDB6R20zb3JSWkYvWkQ1LzVmak5MK0E1?=
 =?utf-8?B?d2tYVGQyWU0wem9RYjBUOHpaUnM1ZFVaUGVXTVJ1WTk1ZlV0MGRFTjJjL2cv?=
 =?utf-8?B?aGZhQ3JFSGhkQXI3TDc2VWNwc1Jpc1YzNCtqOW0zNjRFbzhTdXVINkZZTkZx?=
 =?utf-8?B?YXMzZitOZGxGeldkTktTallxTm9WT3FyYjl5QUYyYVlqRnQ3Yno2emN5OTQz?=
 =?utf-8?B?N015U0RWUmJiVFB2Zk9rK25hTUgwa2ZxU09uWTNURklGT0t0dkZONkNRdjUz?=
 =?utf-8?B?emxjQVV3MW51NXZEZ3RWTGdaTkVteFRpNGF6Z2s2TXQrSlV1RThGT0ZvSHRH?=
 =?utf-8?B?a25QSGlOR0ZVK1MxWUlXaWNSakNidTVONDFpZW5kd3JuTVZKSHFlUGxneEZt?=
 =?utf-8?B?andMYSsvT0FEY3VoTFhKaVNPSmJ4YkZhVkVyWjRWcXB6K3pTcG9ZZHhEaU1P?=
 =?utf-8?B?akdERWZTR1pZOTJWajVWeWhQdkRiSi9KVjZ2SDVUT0hpd3hpOXd0VnFpanFB?=
 =?utf-8?B?d3BMQk5Wa0s3NFpESi80aTZ3QVgrVDRlUkk2UUN0aDFwanFHTjVQbDgveVIv?=
 =?utf-8?B?K0JUYmM3OWs5SXIrWEptd014ck0vdVprUXFHWVVjaTJlTEdvdldSQTlqMHlu?=
 =?utf-8?B?akxITVBpZ200ZWF5Vk45NnRpRXl5MWtyRXV3RWRGeVVtWFB4c3F1UktlTU5r?=
 =?utf-8?B?MmNyclVLTjBrVmlnQUVaejl5Z3lWbjV5SEtjeWNPa0VKN1o3V1lDcjR5bHN2?=
 =?utf-8?B?QTU2WFg4NXRlZnJIdEYyTW1YeC9qQzNzRTdiaDk0RkVtQjRHNm1WTHhhYlBk?=
 =?utf-8?B?UFN5T1p5OWVRV2hieW1jY1ZlblJwa1VTaVNUZFRLeklvRXRNbExvbWY3QW9L?=
 =?utf-8?B?U0JPeTRZUDMzRFpxd05YNzRTZnYvdDM2RXlyTDczTkwzZEdFdEFRZ0hxMER1?=
 =?utf-8?B?a3EwNDk1NWZraWdTQ1lOSnFiTTh1d3ZUaG1tUCtjcllNYkozYUpnaWZFU29y?=
 =?utf-8?B?QzZyMXpPYXppREtON3dGbTBza1pNWVppYXQrc2swT3VTV1RocHlBZ2k1WWEy?=
 =?utf-8?B?RHZ6ZU5CMHh3dTlKVWNrdmI1MFR4S2NoVlR3aXNvNnhlWDgreWl2MFpnOEFw?=
 =?utf-8?B?WUVOTGhraTJBN3FacFRZcFBtL3lNOEdLRjFLcHQvWHdFYnR0Z1UwWVdCZFZv?=
 =?utf-8?B?UlJ1bURmWHZJZlhvY1dvb1JuRXozc01tR0JRUVFPa3Q0SWpyMXl2dlNoQklS?=
 =?utf-8?B?RGxoZW1mdnYxanlkOTA4NjVHcWpsUmwzL0RCMmVWVC9pSlVYVmN4cVgraWZO?=
 =?utf-8?B?RHdRdEs5V2JqbVBpYXhRQVAwK0g4NXlwMWQ0YVNRdGY2Uk16U21JbTlaSnhD?=
 =?utf-8?B?b2Q3SnROYkwvL3Z4bEozVEJBVExENXZ0ZG9KdzF3SmFycG92L0F3aCtzalpQ?=
 =?utf-8?B?L3dUUkxob0ZzaHNlY2NGOWhNdDVHNGM0d3RDMzJ5K3RaaFp0RzRiNDdhS0pG?=
 =?utf-8?B?UlVJQTNNT3NxMkVGYmVMQjR5WGJXV1M4eVFJWDdwV1ZUdzdnNHRFQTZkYS9x?=
 =?utf-8?B?RzI5Y3djVmNkRWpqbVZRQjQ4dXZhOTFnbFVJWnIwdERzYmg3d3dLQitTK3oz?=
 =?utf-8?B?djlvSm5aczhRNWpzYWk0S08vVjRnWmlsNFY1eVl5a0F2cUVoWmllVm5MVVVB?=
 =?utf-8?B?VVRhTURwT3hQRTZyUCtmdUxRSXdnN2NLNHRQZlJKNmFzL3hxVU15NmtPcEI4?=
 =?utf-8?B?ZHUzWmY0VFhMVUwyY284SHNGby9TTlFoR2NqM1UwOVRVUzVjSS9wQzFoYVhK?=
 =?utf-8?B?RExyOW9rekF2OG42Yk00cFBmZ1ZKWmoyTGFjQlpSaEFFeGhvbTBCT3BlQ04r?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91299352-dadf-4f9e-1ae6-08db829e508a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:07:47.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6+OCXYQuH+nyHatHUBH3LqxiwpbNtLhzewl5BwictWN1k9koFI7ABL2Vnzx7q7Ivq2CG47J084KQKD0EyaQu8w6206DXbCis+NFBAUHKG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

This patch set add support of Power Management in CAAM driver

We are saving the state of the CAAM:
 - JRs MID
 - Address of input and output rings
in suspend function and getting same state in resume function
on platforms where power of CAAM is turned off.

Franck LENORMAND (1):
  crypto: caam - Change structure type representing DECO MID

Horia Geanta (1):
  crypto: caam - add power management support

 drivers/crypto/caam/ctrl.c   | 114 ++++++++++++++++++++
 drivers/crypto/caam/intern.h |  33 +++++-
 drivers/crypto/caam/jr.c     | 199 +++++++++++++++++++++++++++++++----
 drivers/crypto/caam/regs.h   |   9 +-
 4 files changed, 328 insertions(+), 27 deletions(-)

-- 
2.25.1

