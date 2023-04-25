Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80E96EE4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjDYPk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjDYPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:40:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1A513C01;
        Tue, 25 Apr 2023 08:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+hZPoeaOqwiq50XC8ggKH3IAwC5yoYssOf0/KvI15bBoEfcb7bqpl2PJR6eqdwnBlyC89Fx2Xhyxy625kyVit+2H4lcs6qSqOubx7xzdWpOo6nwPTlNY0NS7xXiK02GsTkEgGCPCZIrP+TawX7l9SeIBRgRhPTIcc/93jIPryTMDzds3dm2RyDCXO30vC1j3Oke5cTbLVQes1AtVhoIj43ragekPViaG3NPWFdmCOQPwwPhmnD3wGrSWrTeLdf9pBXibEY0t3sasWDyH8WKbgA5lu4kgFv69/BiQfORKhGC4/U/2ZhmyHEzLTJ8/ipKrEeJ3gloSlbXmsSmSLxF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GLhOQJlxMLqzil7DdxbMDijaG2eWYC6PVW3aG0ObTs=;
 b=iSE6PRYkaeTagQiSPjKJ8vX0QY0rLEtHfqwBoMv9txmYY5JLDQrRCGE8byMfstcBr+CmRDuiO8Mwm/Afyo+N5+nxE3DCHj5EG99WcMWUzV6hnceriaLP/UDnF6GYbqSMWTy2q87bGKR8D2AjC0RidivjCLJ8MOcIccEc5qRCW8yLTX9DTmaKKVh7twOd2iL3jEwaoyXewW5NEZXvtn7S9d6H6xU3734exIdPK+BPgBi5kudf9yFrvN9gFRq70OPmIU43ruSTxkk7Hl2t4Rx53PiBVcYWDCi9UWHpWw7je2zi/ERvfb29MDtBR2lNK30O9tVrs3mw8G2RTODgFijeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GLhOQJlxMLqzil7DdxbMDijaG2eWYC6PVW3aG0ObTs=;
 b=dSuxtVi0NYxwZ9jSDSwmsZ5iGgUlW8jbNWouF9UmzIlmvKAJf4kV/uoVceyRJIzsI/Qc7cEHUEKLWzEfz3uRLsVyrYUSltjtYggbQ8TNtocCc0LDKlgsjmH5X8bWxFuVEUwSNFf1rjnez3SFon+8VOKsh3EFjeRDhom9bQ2YtME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BY5PR08MB6294.namprd08.prod.outlook.com
 (2603:10b6:a03:1eb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 15:39:52 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 15:39:52 +0000
Date:   Tue, 25 Apr 2023 10:39:49 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZEf0RYdD5jhE9JEk@nixie71>
References: <20230425130054.591007-1-tomas.mudrunka@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425130054.591007-1-tomas.mudrunka@gmail.com>
X-ClientProxiedBy: DM6PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:5:100::18) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BY5PR08MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: f13d5803-cc8a-4837-fdf6-08db45a34f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiGMswnNM0KSrjSc60w80VlQM0pqdaSuEEQUrA+JEH3QKxDG+uFw9IKryQ63/U8onQKJo+FJFeCuZR4kprPiUkO9QMRCO0/XrFFlJ+O+aauMxTfrMJ9EjKxhjQGvsJZWy1+GUfkT0y/nMX6aP2sNlgeUz9fUPCcbD+i1RG0Qj3XNopCEuGsSgCHmE1w9WgO2R2DXz4COs5lnliD/qt0nhUXWF62Yp99vcidScQZ7AQx7txUP1c+1+67ej7T0wu1Ib8mIssDzPfF26rs9DnHn1wpibbU0qejhAeW0PG3CRAmsp7JEz1ezVcQ8RfOaY17GMaFjkgzjdqCDzfyND1WTJKZmQnvmzYV8L0c37BS63xRcorPfRmS83EqTF5/8ABmtKFLcGcCuA3AAq7T6Uv8YLIrq9KO5e7Dr6xVQhMACrZcB5jdaGb6TBX71eEeOKl7vN3i+0jzetGJYOJ2PtJUxbQg8upRA3lcKEV3+aw34SZ9d5UZDTPI7uCLoJhUau1V9nBE2aw6s+HKbRXCZFxSSQYWG6/K1ONKCf1xuwLkY/epDfArlRXQV4Ib2lSLfcmqu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(346002)(136003)(396003)(376002)(366004)(451199021)(66556008)(86362001)(83380400001)(26005)(186003)(6506007)(6512007)(9686003)(38100700002)(4326008)(6916009)(5660300002)(316002)(8936002)(41300700001)(8676002)(6486002)(6666004)(66476007)(66946007)(478600001)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a8cEX3O1U8I3KY5ylFO/bIQQMMb1owRm2ovw+oLcGap6N71Z4mkZy8wlguJT?=
 =?us-ascii?Q?7yqG4tawGcJ68dfCgcP9eTDC9wN9Zas5jO1F74SgftP0exLbkXGHOZzjAgWd?=
 =?us-ascii?Q?2+4wAksffCEAtFO5zaPi4qgvvRAoVLJZs79wKCV4N0IFgfjRPVrlAe5mWW90?=
 =?us-ascii?Q?nEFtyfqerPc+V6UxF+TtonoLtm585kVObfdB/JW6C/iRgxVC4b0QY5O/uCnr?=
 =?us-ascii?Q?DJ0A/tLniWY6NmdieGfXRN6V7ASrksoBTKgDTTqjStBODy9sx4MT7TBPqP5c?=
 =?us-ascii?Q?Xo5XZQtHABTy90TyEkWUErDdiIo6/lmQHqmgDsserqpB0lN3gEHDWyg83yFY?=
 =?us-ascii?Q?uZ7JpyGUBxk5swphYSqFtrqc6/nVZ7zReRf8m+698BygEJykW3RF8UHJNRAd?=
 =?us-ascii?Q?Xi1Bg3pDtx+dzIh7V7X9c8FLmguesVh9ZHTp3tB50n5Ja3M3QiIZjpeozMAm?=
 =?us-ascii?Q?zIevwAK+n2X696EB5Y0EyTeXOk4cg0EqGaXg1ww1gJbTKc6QEt4LOsllnCLv?=
 =?us-ascii?Q?pbHI3pjEAEY9uc5K71HDCRwyneQj5GUPTmasjE2laeIg7nS2JnVCDHyYDvd0?=
 =?us-ascii?Q?l5zDMAVXXi+D5suM1PCXnuK6ShtyMqB+3ITR9S23woJdiRvlRWU7CKIMKp8n?=
 =?us-ascii?Q?GNbbXTd5x3gpkREJIQeZPt2dykSdHbMJZorTzRlIpbA6/aqjt4BOyvAbbrCH?=
 =?us-ascii?Q?gjRTnUJKyOyt8hUMrpcUUtNmN8Gf5FJXgUKXMJ8RgfZfRq/iJ64URzw6qM7v?=
 =?us-ascii?Q?SvZ8pvkfiNHhoNb7gjgEQ9Iffna1ZJbQMin08Z88rNpQEeOTGVD1WRxpPfs+?=
 =?us-ascii?Q?QdE1IgW4Z1/rvfy0kuDQE1l0loKPrFqKwlhgxWYwYTF0FWue+J91yglP4nF5?=
 =?us-ascii?Q?Tj4qoRykKdtIEZz2czDspNrmySYMs7oVjig5bayr3rJsDcdEUuFurGpYMuiX?=
 =?us-ascii?Q?pQ5xMQ4H1A552t83vTcBnj1tl2+OHeJDjMUjF1pp2KCdt/TWzAPfRzjVSOAY?=
 =?us-ascii?Q?wZz53iXEMxJuAEcoVPQ4sL3zamYmWfGDkXz4BiIUsGcYicqQ26yGJmYAvuFb?=
 =?us-ascii?Q?Tr9pZQAzgF9eqsP8Md0fShrJ3yQkHIP+6rXfx1HskWBE76qVwhkEeCBfKeb0?=
 =?us-ascii?Q?BeOfdEPfvzNDGtfV2q+Skh5aiy8p+d3Nir1Tcw5V6JQm+4qwy8VFRTC4kqKD?=
 =?us-ascii?Q?Lu6vUhWcSIK2Z5U0YWbaSAOJmZFkyNbdQSanYybiit4T2jBRXxfOy8DsQV/5?=
 =?us-ascii?Q?h3ub1PTQV/TO0d4I8uwtv3iH7fQSLjiQvx528jxWLunEuPWT9VQ/05NMWapr?=
 =?us-ascii?Q?RaTA2voazJz/AQmtVDOMdVURakr8fvWB3SiQNjKrYH249CKcH9SvAp6Wi4dq?=
 =?us-ascii?Q?gdVMn2A45kIUhBwY+gw3vFhrpvnbSJR9STG9AWbonxP/KX8mtllJhAs+szVF?=
 =?us-ascii?Q?39ft6x1ekmz0A3huTAxZpoPd9uA4E19hDD4ZJr853G2HegAJeoS/sevzWdxm?=
 =?us-ascii?Q?x13JC51bo0fqbj77RUkVZ9V7E18u/NQApOalSwNbZcxqxJGyv2dbAnz36dXT?=
 =?us-ascii?Q?I8lFdD9wWuKukEvvdCj6Petpla1Uwzm3OntMlX5G?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13d5803-cc8a-4837-fdf6-08db45a34f82
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 15:39:52.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8SwqkyVYQJOfutUj8rsKIilXvW9ho8H4+z9o63SNn+oyyS1bgZFldD++u6XXRqspr2n082/E/n05aOFWJw+2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR08MB6294
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On Tue, Apr 25, 2023 at 03:00:53PM +0200, Tomas Mudrunka wrote:
> LM8333 uses gpio interrupt line which is active-low.
> When interrupt is set to FALLING edge and button is pressed
> before driver loads, driver will miss the edge and never respond.
> To fix this we handle ONESHOT LOW interrupt rather than edge.
> 
> Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> ---
>  drivers/input/keyboard/lm8333.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> index 7457c3220..c5770ebb2 100644
> --- a/drivers/input/keyboard/lm8333.c
> +++ b/drivers/input/keyboard/lm8333.c
> @@ -179,7 +179,7 @@ static int lm8333_probe(struct i2c_client *client)
>  	}
>  
>  	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
> -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  				   "lm8333", lm8333);
>  	if (err)
>  		goto free_mem;

Thanks for the patch, but this is a NAK in my opinion.

First of all, we should not be hard-coding interrupt polarity in the
first place; that is an existing piece of technical debt in this driver.

Second, changing from edge-triggered to level-triggered interrupts runs
the risk of creating an interrupt storm depending on the time it takes
the device to deassert the irq following the I2C read and the point at
which the threaded handler returns. Have you measured this?

Can we not simply read the interrupt status registers once at start-up
to clear any pending status? This is essentially what your change does
anyway, albeit indirectly.

> -- 
> 2.40.0
> 

Kind regards,
Jeff LaBundy
