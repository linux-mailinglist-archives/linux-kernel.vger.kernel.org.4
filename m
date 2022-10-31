Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59661365D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiJaM3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJaM3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:29:31 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2122.outbound.protection.outlook.com [40.107.247.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38646EF;
        Mon, 31 Oct 2022 05:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qcn7Ule52jGw9KRj7AbZxCn9S7dK9hGefDm1lAW3gEGsssqBsk5x9BxFIGUtydejeYvQJCfMrBU7PYEzlewMZk5Iuz2w/beZhuOm5GxGgc9aONql7YFQBl2viww3fXKzUWDMsMRx99xl0qnvsh9LCKdPuW6YF9cardtFqwGUNKV07mUn/osMfWJ05fWCmTFZy/FRXZD7RwlPqUgHogkpSDOZzHSw4OYudGQ+3n5LjgVTgCpJ7EiM3wXE3nk21UrKuiYJ66vgY4Ap0WIegvxLAayDdWAAErAibjxHlug8D1hWiV6dVp1FQ/xUeQjVRWbqynQTKz/uIATUchCyhpOyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ze04daiqQCxsubJ19Q+fHryLi0SMgpEphsSMhIlu+Q=;
 b=f+p1g0uH6TfDt+K0QleO8yzURPurxeD8qrVwxpy2sLNp45TkLT/vHrgtByEMSV7PDFGF/gqyV7ooJ3E7ZbibcF9eSIoa2KCwFk0vuE//Y3wlrb7Pa+PQjWmdrX/FZ/Yg+PLzLnNNulF8rVyYQTm6ELSkja06Tu70pd4li1eL5WKANHazCyMm66Kyr4sPK6WsUHLOxdHfqei9yITi9AylmWuqOJBFFkgIU2WhiEfZgh54quKP3rZPW6IBKTFa+Oig6AtGBVl5iceboByQ1CFdQUJ69tpDnPt2PkeJ2K6z4XZnRZ6F190GmiBBVfpCFIKvi+vEFr5D0SBy2neYLLJLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ze04daiqQCxsubJ19Q+fHryLi0SMgpEphsSMhIlu+Q=;
 b=vbOBp/ZqFQRcGRsIV9V0R+i2ACZzHWAhaiB7w5H2uFzLz8J1cbk15Q1ucDtXMGph9bWXytkNPbcjozntHrjEwQVNzMg2cr9ExE4zYqRswnPrhDdnZCoZuEAN9NiQr+KR3S22aXkTRWexEwzpgVvqZEYe2FE9CUyzPLWA7gUYuoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by GV1P190MB1898.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:51::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 12:29:25 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 12:29:23 +0000
Date:   Mon, 31 Oct 2022 14:29:22 +0200
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        =?iso-8859-1?q?Gregory=0A?= Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20221028145049.76db792f@xps-13>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
        <20221026134545.7146-2-vadym.kochan@plvision.eu>
        <33f04b06-dc00-b7ce-6a24-2282608b40dc@linaro.org>
        <VI1P190MB0317C739E2D39427CD2A771D95309@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <10581088-e4ff-76db-3c9b-42a7a9c118ee@linaro.org>
        <20221027151825.166a9255@xps-13>
        <e937b059-4168-3bd4-b294-cbfff0519d1f@linaro.org>
        <20221027155025.7c04774a@xps-13>
        <683dffbc-744f-80cd-2262-b6deb4200ccc@linaro.org>
        <20221028094740.3c11f52b@xps-13>
        <a98f00bd-013a-a1ce-0054-bbceeaefcefa@linaro.org>
        <20221028145049.76db792f@xps-13>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB0317E5C8AD323A8D1A4B5D8195379@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|GV1P190MB1898:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d4075b-fd0e-4938-c40b-08dabb3b8adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipMxeKDB5NowAFO0NrZK3FgkV0/Ji8IhaztogLaqVoemUmhAYbTDZhPElWFZxKCDrFkM4w+A8RsNYEDjSzuBOqm8vKtcihwIEseXNYpkLvJTj6/1lI8eQ80N0C6rQdIqNNUjt/3r9rZmgAJvXOOq9jg04ZOBPMyuipl8pC8qBLrbRI0PXJ9xG12yw9Xn7dAtW1ZrceYxM/SaGrpxWAQyqR+8F+LwIOGMZBsWOKA4QuvlzdVXggVCfLfDkyH7x/llQbehCSekLBBXAQOJYaDf79NCTW/PLtCBpc1gFcp5f0Ins2SAvKsKS7IZVOlG/MpfcSOziax5n/ekN7Ng4nRxKbfNaf9IT3NEMBKPbY2tCecsH39fx3nMdGNZON2+PfHAI5zxcbHa545wQC++qzRS3UpnpISZrW0Kt9WsbzByTPgbbL6ubLFy6QFvQh7mlwoYX2ILCDGGzd2IgDdMwLUhjEb6kFYogvNFX0UVFlONiz67EKNuF04lyh6pidDn+ZFgzzy/6zdtFRA9XIGVX/QppkNFxm7rHuqEhQUOsz3aeDzRLGqJcVtWfE/Pmw+GvIJNxvWkyM9YcmO6LuzCWRM7UkJgdy0K/aodK6MKHZUQEPaJvN/LTVZDfYgRDwyCC2Hoj/mc9iTuIdLJ+jtzuKs1dfELfVKhYrZZZu5CHasSrFOaJfn2Xi3cxgPd7pOResGV98d8YdQEbWKwvIFE9x7FS2DmXmh+r/jP2dCmMYS3MTr/HsNsLvVPtj4mQjAdvodTy/GlirFDiIRLa/paijt1ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39830400003)(136003)(346002)(376002)(396003)(34036004)(451199015)(86362001)(38350700002)(38100700002)(55016003)(33656002)(41320700001)(2906002)(44832011)(4744005)(508600001)(316002)(66946007)(66556008)(8676002)(4326008)(7416002)(8936002)(5660300002)(110136005)(54906003)(52536014)(6506007)(41300700001)(7696005)(66476007)(186003)(9686003)(52116002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lsawMWTOuWM8slR5+jXQmD1iArhtaolC71zV4924O7D9cv2aLV2d+0n5esif?=
 =?us-ascii?Q?/dJNxxhtcjbi5eXUkroTVgAtUhZ+lMIIQfzYv2iZIkcLwYo12v0UUE8eiiAP?=
 =?us-ascii?Q?zxU2EYW/K0kVHIBH7OGFkUtxYyLFNHZywTFnqETJ8fofghucVizJC76hSKdq?=
 =?us-ascii?Q?NLniuQPhyLv/1GeIgFf6IgLwqK21VfM7PODqyg6EphXyVjov6H0uVBpRrlyf?=
 =?us-ascii?Q?VfNWmaRGweQ67FKpgbpaUPuqBZ9xfhTAyonCtVCRrqu0DC7oD4T/GDgdtgBV?=
 =?us-ascii?Q?PR/wQEEQfKkwoBRbbyFrm7laQEexY7b9AGRsLAy2gZ8mUZugAylAEJWp7K8Q?=
 =?us-ascii?Q?fsotE+kRXtQ/4PDbyBpcuynpL0nQhczG9LgLVi88/pmx0NISC6swOLbXFwkw?=
 =?us-ascii?Q?NCVaPEnzpT3QyqtKUSBh9DYx7jou69UrnyB8HmgLQ3ZExnfyGCENtCOmAbYN?=
 =?us-ascii?Q?EOY4emUTYH4yXLcNXpGoM7+I3eLZUUl9x7xuUx8hrEWcGQDjWFjQfblaquQ1?=
 =?us-ascii?Q?ntZbmxikAX+qE2hGiQXd1qgktv1DFT+AcwI2VbJ9pPWsVVhaiTogTWpWiF0L?=
 =?us-ascii?Q?ikvsLs2qa8aXn/uaJ8ubSw2QV7H/ldGyk5lZwuTZsIB7Y6OCmrvr6GbVikiJ?=
 =?us-ascii?Q?WWsPPr5k4wuYtmFA5KTs8yvf6VzYxg0CDk2Nsf3nli69JfDSi+rVb/9iKMB3?=
 =?us-ascii?Q?5OYvZjQRpfGkRJCyh6pDLrns9T88IN6WeuSKC+er2w1/GxqyMmdeZO2gmntF?=
 =?us-ascii?Q?TG9aC6SUS7R+AQ+5hNlGC2kzpnoK3DscvQlYU7S+VvPEnqigQzBY0QVJkqn+?=
 =?us-ascii?Q?pm5j1mSxhoCdCAYbhKnHlf7BVS67C6Z+SgJ7s5KpIVlM4gjA+ZGW4xIudzSh?=
 =?us-ascii?Q?wG2+YtvRWdmmuHhY+yu2KHUSC29rOPq7NfaXEuR8AWy325JSD42Pel9Xgn30?=
 =?us-ascii?Q?Q9l4XmbenDaN3+O2eQNsx+OrUkSbJ0cuUwAyVH89ZP92RzUurwda6OOEDSsB?=
 =?us-ascii?Q?VqF8bGm5rXYoWLF/78jC7+cR0vg4B7GbT49VTaX60Cqxve838KfSKNFBARFk?=
 =?us-ascii?Q?O1SZqL4J/MjFz5eeR1ljTPT701jYgmf0kXTNRB2rJPJGs38pibHc+rXVjaN5?=
 =?us-ascii?Q?P28MNrOXOIQ/cKm9t1yi5bsp10WXHQD+xugPZk5seLDWuSBWOCToVoq/Masb?=
 =?us-ascii?Q?csxZDDKbZ4drsP4h7ZvzwMGZZ4bxmn1U3at/Q9r+iy0xag1STAK2sB4tbqp7?=
 =?us-ascii?Q?ebuX0jdAnq2IXqMAuxaQg1A4WFft01Haf065D/JfUjpxauIKvBpmaTlJFrKS?=
 =?us-ascii?Q?wrufuitZw3gXTjQsfFpC6623FjfJMSD+3+CqhxK5tEGqZIga01IWgFjvVlGy?=
 =?us-ascii?Q?8CVoyO/W6rSfOG2x+0zE02ba2bWAnQ/08rupFUC00uGufdUKkQovsDIu/edN?=
 =?us-ascii?Q?Q+M2zin5v94Sv0/7umgHRaElAFtd5ChGqJPMJgkHREZYtskUb/d1DKkJvLdX?=
 =?us-ascii?Q?ACe6KqbrKaL9t5cYTNOQj79FhKKvYppCejiOML1PCJhlVGnezXgUU23zdPYP?=
 =?us-ascii?Q?JYWZKSq4KGNtWUiOlhmQGzEvJ7eW35iwxrnI4IP8mZYwqgjbvKujj1XjiNBn?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d4075b-fd0e-4938-c40b-08dabb3b8adf
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 12:29:23.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnRjoO6HK9y8UGEM2spAeWT25e2gCFBSy/GeNy++DPAHxAe2MhYLEo71hO2GNQw6aFwAlNHkiZuBhDq/iURxHceL6/hE6kNFdoqDGvdAdVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB1898
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Miquel,

On Fri, 28 Oct 2022 14:50:49 +0200, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Hi Krzysztof,
> 

[snip]

For me it looks like the "label" and "partitions" can be dropped from this series,
so in the future they can be handled by the common mtd-related yaml ?

Regards,
Vadym Kochan
