Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C8C67C296
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjAZBvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAZBvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:51:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D515C0CB;
        Wed, 25 Jan 2023 17:50:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgUUBCGE1Jdv+MsPA60yml7yXbGajIY9chIlRnc1I4fmz/U/Bx1LiYnMgKnfEZlSHlqyDnOKd23Q8xbRk/zvlrXmPTIQ0w4lUdXse3J0UFrdlV8utM6I9BjbYWfZFSEI0TnIfrNW+zB//PZQWjZT5tnM2Klw5f5zStm4Rmon0r3lL7Nu8KrAoOmZps4Kd2nWRijHQSPd+vYWol9CeRybmhZqdErd0Rp/wY63LlUpzEufzHS6QBY02Pya70j1TqfRmNivC5K0MFNhBojOn6GG2OOjGJau4RLC6p13K9jNF6LW829WtY5mtFi1im5umljBOJmseQ+WhBLbeH7xBoComg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HHii1jiTxVCJrop2+n1Wyqo1dHJndGfjI6we75TPEU=;
 b=NyCwzm6LkebLLq8OsX7bVhmAGYkQorjyXA//I00q/x6QPZBB5Tqr8fYkb8XCmZ3LO0dQhQIztab//z13EZCchBeFsgEplGqsIDCoVK0U9eUJSa/Xy6J1uLTZd/NZYnQmYjQ4HAWhOCrRP9GJe3w19eDv5lIjSQO3wyX2ami2AeItlhTtlKBU2AGaFMdQ9CZ2kCU49YFQCzI2Lu68YPdQ8xk4QFZa3v1NuGwojAVJctWVf48RvW69db9QXloDXEmJE5JIyuk+3VedoiO18lyvBivvdd/vK9mzFeRGTYZH2Q4r9c81CHVB29Rq5/vL0NVJUoUoAmyzLxKtK+hauJkMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HHii1jiTxVCJrop2+n1Wyqo1dHJndGfjI6we75TPEU=;
 b=vlzlQjRYxq3nimGfEL6KcC1QCNDArfsYV7KojdhbzISfBr93SWjDTuut9Pb3OjIl675cUWG8YN92vjBuHC1WZXQkGByCJQFv33uaf8v/kGzXaNu5Bqd/GK7y7nmxFXz/+wm6UAkeUpcdSh2bLbxoiR7d6I8eeBgkiS+nrx/khU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB7190.namprd08.prod.outlook.com
 (2603:10b6:303:f7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Thu, 26 Jan
 2023 01:50:57 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%6]) with mapi id 15.20.6002.033; Thu, 26 Jan 2023
 01:50:57 +0000
Date:   Wed, 25 Jan 2023 19:50:51 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: azoteq: Fix differing types
Message-ID: <Y9Hce2OqJOB/uiyM@nixie71>
References: <20230125221416.3058051-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125221416.3058051-1-robh@kernel.org>
X-ClientProxiedBy: SA0PR11CA0035.namprd11.prod.outlook.com
 (2603:10b6:806:d0::10) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: a80fcf24-39bd-43f8-8185-08daff3fc44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDpeRIpixTDXZrHY4X5vJRgarNoXch4VVNSEuEKQ52InCgN8VXT1qPoWohE/+1MAXkBirM2cE+IP7rU8HpT76xdEC7lPNEegUxnVAnNYwI6V1Cy2VhujC5cQTfFSL9uUvqnms3xO084sr/000S9Vw1C4FrS7+WMqrsqGkYZacFSLqxE+DDAWmBVGvzUW00CKjcSgxiTSOBxt+8EeDMmQTv89dnMdsyR6ltXu3lqFWPag/xvUOvSTC8idWw60dXNcrx3rVcxJ5J6gPp3jL7dc+cjh25OO5PblRP74hqerdo6GBuDT7phQvZCFVcvx4uVXDTgsCFNtRThcIbggSpfQ5ZucDC5p429tuxo8veuzOT32fk4sQQslzqOneL7FAd3VXz1ssyePlazi8qCTlaDpGtHbaPPCt4cCDlXR1HbjUJXaVCncSFmOzlnM46dkp5d0zRJp1jg3Xz6bovq2ZBO3m2Aqn0p5bV/IUjKnW5H7FtUwSCeTB9uzedJFKeSqDfNn+kNFe1owNlhts+ttxYtmPrxpjvVruT3KuAn+6LNJaOv9H+29oUiQaw7PLQGUOpB4rnoEvPtCpkGJSJKan3XnElPrk2DURV/UIXIvXR2lsLVDJyMtV6CG2q+ek2cBIR7gnfNc2glLAwMwmoJEjSjAEvfjGX3PkStRRL6rW2d0j9R8TRZvwxq+rcRSWAUTCgBC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(346002)(376002)(39830400003)(136003)(396003)(451199018)(8676002)(316002)(33716001)(6486002)(6666004)(5660300002)(2906002)(6916009)(66476007)(4326008)(66946007)(6506007)(8936002)(66556008)(41300700001)(966005)(478600001)(38100700002)(6512007)(86362001)(83380400001)(26005)(9686003)(54906003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h0bGBnAgiIOQd7mkZ+FdEDzY7RA7yY6xksvgb/otK++yqexTnKLl1LlQn7G3?=
 =?us-ascii?Q?qpmIwcnqV2tdcvrPdA+nCwpRVr3k//S94mGz5cJkvLNtzTUztjP8lCN9RPfs?=
 =?us-ascii?Q?ziwXkhaA8/CdkkQoWFwffmRMRJy9kj+hndqxcKFd7h1csiICy0zNs8NicPlV?=
 =?us-ascii?Q?CFJC9LlbyiRztrLCjDXGwYWTQ9CPPWuggQBh3ypIztsfMEaJvyBjiJToUiBs?=
 =?us-ascii?Q?YvCWLzR/XJODKlCnII0SziEGH5HgnfCMgVwRhFH3LcZylfpDnoFdJS0EpbNv?=
 =?us-ascii?Q?w4xNJYTXdGvAzrYenA7XADfxPYjd3gA6gYiNjBigKeJeuQwOHfhE5t6NpLXN?=
 =?us-ascii?Q?jBgg0WnUsUYPCqPTOqdTOPzPh3c+s70CXm/5cnKA2h7Jjo2H+mAB2xIo/R3q?=
 =?us-ascii?Q?IEFMTC/bPjAG8r5PFSdaB935Ay8GU4x2AWsQ9E1tFMWLE3e6Jtejci+XJKcT?=
 =?us-ascii?Q?fP/LdIL6trTr8TKg6ZHAZd1BKv14onjhnWuhHqclRg1uhKMBns5LG5sxq6Mu?=
 =?us-ascii?Q?77YCRUjHr4nOh2ZdTaN2dd3JsW6klwj3XqRXyr5fN9B+BIaBH9U+vnYi7NZZ?=
 =?us-ascii?Q?FROInaGJ3brmpApGmSFRxLkjyYMMiKoB+UFJCfrB9yF1bdRjAPkpRbVL95Li?=
 =?us-ascii?Q?NQYKis9WHmGB3zdwHE5Fe3h+vR3E0mRkluzUjffGsfOYRgiYtaC6FtfV4RsR?=
 =?us-ascii?Q?LMZpHwVmS6MvNbgl1AgbbrAqXZL2HgUJVNWxdDhn3cZL6qgMeQMnG065eLRn?=
 =?us-ascii?Q?x3RZG+8dtkQgdQWVcuCl7uQofzQd3yArduWTOo7M2N8ksKy+7ne62qLoiDGN?=
 =?us-ascii?Q?0DTLB7dZaUVHmLixy8nFDsnHNZpVzJJ/Xf01X4yB16C3d3MGRY6OEMIQQxT5?=
 =?us-ascii?Q?YZHx0J4fAT67bj8JKDdadOgV12VYx4h/OJCqd+bS+CqNoCR68J1MVXOQG1iJ?=
 =?us-ascii?Q?h8CDncBaYodMqOB+smXlbz58P0ZE6dDZ3eLSpQqt/3e6QQwldOSte+AtAlvU?=
 =?us-ascii?Q?8H1dLqJww6vSijdmgdg6vVJzJyvtZxbawepivqPvlTheL4NdrHL4cymdh9KQ?=
 =?us-ascii?Q?5pMWvNoSaOtTpABm8zXLvknt/Ap4bll/N3MVyZkmL6D+U4mbVTLiCkPQtNTB?=
 =?us-ascii?Q?TwnlyyUxZ2mwZkc7+KBY5rgBko3LMS5uhe57C0UfJ+QYxlHTYRUNYUliGVT9?=
 =?us-ascii?Q?bg9LnZM/Ye9Wh/H0pDDP1mDuwHsOxB9c/J3wo0BBwjzch9gJs3HZ+fM/MRD+?=
 =?us-ascii?Q?ug1VzTXYb7cafyNeYqBqnfkwD96vTSrGTg/GkFQm2RJc8ZmndoJ6wlceMgpp?=
 =?us-ascii?Q?gs8Rpwhx4AoXrVl7HagDRhNGHqpTBBU8EU9QBjc8av0KjL7abEjXhfrp6bCq?=
 =?us-ascii?Q?HB2r176JYV9Leud/JUuHAqUu17wNaBnmnCQm+VdletyDSGzBoJUZ343686y2?=
 =?us-ascii?Q?rvTuvQUhKAPaQ+U9hWsM/p82Mid1raCfZbgDHDw8DWV0/7tDotYytwJuCVja?=
 =?us-ascii?Q?UmaWpg1hHskoj6c7MO6LJDnmcFzvyExdaydLfVeNRrI3smdUZ4Tp/zaoQDUe?=
 =?us-ascii?Q?P5r69u5qJCwUFgfmb8yeaQa3hsY2VFJ/vaXLiLHb?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80fcf24-39bd-43f8-8185-08daff3fc44d
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 01:50:57.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPNpHQdACUIVFN6VetSCrwIk8NE1GZDh8MnfS5tnVrd2ht5eh0i8glBjpu8ZVCvOvayJ3U0Q7r4lfUop0loXyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7190
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jan 25, 2023 at 04:14:16PM -0600, Rob Herring wrote:
> 'azoteq,ati-base' and 'azoteq,thresh' properties are defined in multiple
> bindings, but have differing types defined. Both 'uint32' and
> 'uint32-array' are used. Unify these to use 'uint32-array' everywhere.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Thank you for the patch. While this is a step forward in moving toward
a common binding for this vendor like we have discussed in the past, I
do not agree with this approach and will instead propose an alternative
that accomplishes the same goal.

For all of these devices, a single sensing channel takes a base and a
threshold property. IQS626A is unique in that a fixed number of channels
form a trackpad, and I decided at the time to simply define the base and
target properties for all channels as a uint32-array.

For all other existing drivers, as well as others coming down the pipe,
base and threshold are uint32s. I find it confusing to redefine all of
those as single-element arrays, especially on account of one device.

In hindsight, a better design would have been to define a child node
for each channel under the trackpad node, with each child node accepting
a uint32 base and threshold. That would follow other devices, be more
representative of the actual hardware, and keep the definitions the same
across each binding.

So, that's what I propose to do here instead. I happen to have a fix in
review [1] that addresses a bug related to this parsing code, and would
be happy to build this solution on top assuming it can wait until the
next cycle. Does this compromise sound OK?

[1] https://patchwork.kernel.org/patch/https://patchwork.kernel.org/patch/13087768/

> ---
>  .../bindings/input/azoteq,iqs7222.yaml        | 12 ++++---
>  .../devicetree/bindings/input/iqs269a.yaml    | 34 +++++++++++--------
>  .../devicetree/bindings/input/iqs626a.yaml    | 12 ++++---
>  3 files changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
> index 9ddba7f2e7aa..f2382a56884d 100644
> --- a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
> +++ b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
> @@ -354,10 +354,11 @@ patternProperties:
>          description: Specifies the channel's ATI target.
>  
>        azoteq,ati-base:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        multipleOf: 16
> -        minimum: 0
> -        maximum: 496
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          - multipleOf: 16
> +            minimum: 0
> +            maximum: 496
>          description: Specifies the channel's ATI base.
>  
>        azoteq,ati-mode:
> @@ -440,7 +441,8 @@ patternProperties:
>                slider gesture).
>  
>            azoteq,thresh:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            maxItems: 1
>              description:
>                Specifies the threshold for the event. Valid entries range from
>                0-127 and 0-255 for proximity and touch events, respectively.
> diff --git a/Documentation/devicetree/bindings/input/iqs269a.yaml b/Documentation/devicetree/bindings/input/iqs269a.yaml
> index 3c430d38594f..4fa20f0f6847 100644
> --- a/Documentation/devicetree/bindings/input/iqs269a.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs269a.yaml
> @@ -334,9 +334,10 @@ patternProperties:
>            3: Full
>  
>        azoteq,ati-base:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [75, 100, 150, 200]
> -        default: 100
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          - enum: [75, 100, 150, 200]
> +            default: 100
>          description: Specifies the channel's ATI base.
>  
>        azoteq,ati-target:
> @@ -391,10 +392,11 @@ patternProperties:
>  
>          properties:
>            azoteq,thresh:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            minimum: 0
> -            maximum: 255
> -            default: 10
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            items:
> +              - minimum: 0
> +                maximum: 255
> +                default: 10
>              description: Specifies the threshold for the event.
>  
>            linux,code: true
> @@ -408,10 +410,11 @@ patternProperties:
>  
>          properties:
>            azoteq,thresh:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            minimum: 0
> -            maximum: 255
> -            default: 8
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            items:
> +              - minimum: 0
> +                maximum: 255
> +                default: 8
>              description: Specifies the threshold for the event.
>  
>            azoteq,hyst:
> @@ -432,10 +435,11 @@ patternProperties:
>  
>          properties:
>            azoteq,thresh:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            minimum: 0
> -            maximum: 255
> -            default: 26
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            items:
> +              - minimum: 0
> +                maximum: 255
> +                default: 26
>              description: Specifies the threshold for the event.
>  
>            azoteq,hyst:
> diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
> index 7a27502095f3..dbd63d48605c 100644
> --- a/Documentation/devicetree/bindings/input/iqs626a.yaml
> +++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
> @@ -234,8 +234,9 @@ patternProperties:
>            about the available RUI options.
>  
>        azoteq,ati-base:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        enum: [75, 100, 150, 200]
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        items:
> +          - enum: [75, 100, 150, 200]
>          description:
>            Specifies the channel's ATI base. The default value is a function
>            of the channel and the device's RUI.
> @@ -475,9 +476,10 @@ patternProperties:
>  
>          properties:
>            azoteq,thresh:
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            minimum: 0
> -            maximum: 255
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            items:
> +              - minimum: 0
> +                maximum: 255
>              description: Specifies the threshold for the event.
>  
>            azoteq,hyst:
> -- 
> 2.39.0
> 

Kind regards,
Jeff LaBundy
