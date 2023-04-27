Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D4E6EFE92
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbjD0Ala (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjD0Al2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:41:28 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6510930D3;
        Wed, 26 Apr 2023 17:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktrUXV5pD+GS7rgTmWk9ded1zyGdYhyL6lKYYMEsA1gnUgb3q5AsR/afHx5Hwv9Jkq0jTYvCP3i4L8p8LO7tOskFRjRhReOGwXMS9zgyhDiBsCb3GUjfFuTlMi7bh5G2fv0hBvBJcRWBs05ityE6FUsoPtVU2MZEdg6ljv6Kc2DokQ5ZWyUn11v4W8ZFcMEG0JEf0NFV9IUagR5Q55qRcvF3brxGow37YlKjwhfrmE/p3TjXtHeha4s+XheebGQR57UWQBtr5YAB8mFKuuwIvzySoDUQXcXVwzAhZcDRnFsHSc4TLEumdqT5GbIn1o69dR9PMyOnrzRHqQdY7h2SNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjTM8GH7LdcBQ0j9P4vrCertBZcJ5HnYdRz8KcryHFY=;
 b=j/df6f/V9TJhnHtcLbW13gCtI7O7wtKYey+hlhwYTOdpbE9dCBWqfgK8nA0TyNiTsXV5OhG0faSfGHLzoMNvXo5LULmHBh5AEXIaorChw26xBuyqnC8j/zE/aULZZagGAxX/5Q5nQKjq7UelkY7c+BmW3jEtVH/WfuNTAi3wWDrfkL6YrxROBCzRup7JglEwZPDKdzR1++SiEmMYJLrOpPuOxdalSULd0LKEYEUnaEYwA7rC7z4dyDBJiJv7Z6rNJWSdODWXGoexGjhBQIa9VbDfCvtpyJsJf2DeCvpiy8fEJ7X3TZDJ3EvHkIS9kyJraHRGgpQv2VLdE8EAfuEHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjTM8GH7LdcBQ0j9P4vrCertBZcJ5HnYdRz8KcryHFY=;
 b=Wtq1euZ8QOz1CW/BaXwrbk/9DBA9e8WkuhN36KZtKQApEv21Suokwz+aM9t2cbxTlGKnWir34Rzc16L5yVDk8JF//+Ka7+OcvV5GTjKJ1UBLMQgwuPqS4FFDzFhfv+bPJq/qv6Da9DNdxAhgBt/vckDSFs3+/F90FJw8uiCS+Kk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com (2603:10b6:4:7c::37)
 by PH0PR08MB7796.namprd08.prod.outlook.com (2603:10b6:510:f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 00:41:24 +0000
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::20b4:97da:18df:16dc]) by DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::20b4:97da:18df:16dc%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 00:41:24 +0000
Date:   Wed, 26 Apr 2023 19:41:19 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZEnErxfnSn2JOpvm@nixie71>
References: <ZEf0RYdD5jhE9JEk@nixie71>
 <20230425164903.610455-1-tomas.mudrunka@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425164903.610455-1-tomas.mudrunka@gmail.com>
X-ClientProxiedBy: SA1PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::10) To DM5PR0801MB3767.namprd08.prod.outlook.com
 (2603:10b6:4:7c::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0801MB3767:EE_|PH0PR08MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 6104b42f-4a1a-4525-43e5-08db46b820be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZL1vxaO5ojBFE83i1jVPMC5T3YnfNNZLH7dt/YfWhu+BdPiS+mS0MbsSmb5ZYaVXLTNHNpPqqXli483wUFLScvC96xtxUCVbzdoq+18mCv/we9zfCqXnBMwwqwStWc2n9TVJj2qt9kchAsFu6alZ19q1AB4Cti8HzUP3jiac8X0AvftbFB54vRzrcx+FDcjVEhmIlEjjz1TU/6/O8lk5mEhOdO/DMEXBLXywWKG23z01l0h4WeDomAm/SOmDglAh9eoUc1K9pQKmJrfl+20vP7SD0IZqPJa2GxQtJ1Q1Xj1sCnBPsAw8rv6YISTDrQb5ngMqnBp1PKPHgaNWjG21cFdieA+LNtumWpvDrmP35UJQc1ehs6VHPAEgCrkdVUwbL7NNHs1NoIuaRs/N9zCFIQCJRQCLgN4Zxteg4aVW1eQr2l2WoUfGRFQ/gHJ1GlXa8741yG9qvcmQCs1QE2jsUi7XWVAQVeJsY9iWkSyiuHGXFiY2aiHTePZsxZKhSZDQLQJ0CLchrk2QH5Llotw/3nLHRc/p5MQTQV1kU7XGGaLIc0vcjpwnOhOEj7NzCGJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0801MB3767.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(136003)(39830400003)(376002)(396003)(451199021)(41300700001)(5660300002)(316002)(66946007)(6916009)(66476007)(66556008)(4326008)(8676002)(8936002)(2906002)(83380400001)(478600001)(6666004)(6486002)(9686003)(6512007)(186003)(6506007)(26005)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7OhlZJYEZM6IscKEuWdjjCiUBlP9yiKCMSwjkjm2bXJ5Xh4U3W5ZDv6Ya7t?=
 =?us-ascii?Q?KaFqwwih41ApnNrFD5DWvaAgCExcU2AicZpk7YB6KvvXXveePen71YtvGl7p?=
 =?us-ascii?Q?2UJ+8gIOAyR2oWZ07aNlnaR+qzbdFbuTLgQFTB5Z4ngGstImsMIBZx9ZffJ5?=
 =?us-ascii?Q?k9YHY+czrnPWt9BEW/NtS79+BJfgS8quvnzKtQNnEN3SOGCsIVRHTACh5QA3?=
 =?us-ascii?Q?V+Yck4MJHe6MwMzLqs9AyupxMMOKKuLAzj8+kHrLvaHApRzMCzw54bSvw4h5?=
 =?us-ascii?Q?09eGMIyy63lOT2vSUGijb3iwbjjl39pdowVsHW1QNJfEmYUNnwn8tK0YVfa4?=
 =?us-ascii?Q?cBzlZsfeeysfk9ai4nwG4ctPLLGw8xZn++ftxNYtxVrvJJuzzNV+OdXERkDi?=
 =?us-ascii?Q?i+HXHbQPre8XCKler+jEAOEzFBsq2e33ce9B/trOAVWMSDaYIWXy8VPKiTI4?=
 =?us-ascii?Q?5awD/QZ4GeAGRw01KaWDHWtJ7djlnQV2WwRmwHkCNgPGhCYBTqrsWHA7fPd6?=
 =?us-ascii?Q?KzkG3VmRKhUZfqTzFfvKnQC5iciEFvRm2Naq00a+qRzY5qWg5ZKmNIA0irjB?=
 =?us-ascii?Q?19xqV6BkRkt/xyvaMhZIJ27sXWyeQCysdQDyMS0lvVy79w6jawLqrAlNbvjm?=
 =?us-ascii?Q?jGETkgTqaKSDM7SHhXkvINoMZOE5ltwZhuib8n+vgVAoyx95CRdS4wAZEw/2?=
 =?us-ascii?Q?RHVN+gfadV9zRDkpZjvBVNS9jgykJb7wfp5VqSBr87/cuamHhHWqpVLB7deK?=
 =?us-ascii?Q?MFm+1Co1l6x5tlcK3hK7rg7zFmRZM63ksXHarvpOjPqLm5g2OwiaklRsQmkT?=
 =?us-ascii?Q?ERAGZgBvQumg+7FzHjbcozpEZjT0yXMmsMZ09d4FGSblBbptD+YeLDUYJOct?=
 =?us-ascii?Q?2D5ASvBauM79MXfb/tSAfNsVrzPudPzdNabz+6B4Q1AG67DktYL16u8sksPV?=
 =?us-ascii?Q?kznhRK8hFW7shK6Wji/Hlr6fRJQ9u3VlY2zc5V7Y8095MYo1uBgIGyE3RLiJ?=
 =?us-ascii?Q?ue0YSlJ8ardXPa+KCvKpw3JG9BHbtytm6LyjcDa9m8W7w3+rEaviKOw4deci?=
 =?us-ascii?Q?jKTb7fvYwbsx5GHMMStSQVOssb58gsOs81Dzz9DiJmyqW3CpXGYXe6H1jdyu?=
 =?us-ascii?Q?wF1hgprxg79Nlba+I+m6B1AFyn5ks25a6GHklSXH9U/1T9Ylo83xFsdVlwxC?=
 =?us-ascii?Q?/RftbtYXkN/zlksJEOyiuAIkkXeADs9tptqKkQtd9i8tJaqQeUWaZPcxwpXu?=
 =?us-ascii?Q?CHeleFG9W/1V5b7rfIeeTEaoghNGUkslYHq5KoRNaYHOIHGjNXJAdUnfoJPR?=
 =?us-ascii?Q?h08/y+jqkRrwMdDVl3MIUF/gcc3XrrV4d1GYy7gfFbmKItctmdaSVVw3n6hP?=
 =?us-ascii?Q?ezkkaTmmrq9gMPBPqk8jFWR/8NZDqlAilOv+CfcBLZ6eASmM447h5SefRWbx?=
 =?us-ascii?Q?O6JLYGpeCGdfNkPkz1RQfkV1ZvJDnL8hyOx6K+33QdpGl/1T8iaTPtN/q41f?=
 =?us-ascii?Q?xfl0Q8wAIsjGI6kyDlk/sV5uHKOWSqPsoNqDiFQcsKni7qYHhj39coyCHn6d?=
 =?us-ascii?Q?n9ZHWsNmedbwFghvx9vtc9F4yrJhl9N3e7f5f1/l?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6104b42f-4a1a-4525-43e5-08db46b820be
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0801MB3767.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 00:41:24.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WseIDI1iU116pb2u64bnS2oZsrFuLAUjiUdP5vVZ634NbO5Rq8vWEvot2j/wDBL+zzgUv+pH4GAPe8Npv37jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7796
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On Tue, Apr 25, 2023 at 06:49:03PM +0200, Tomas Mudrunka wrote:
> LM8333 uses gpio interrupt line which is activated by falling edge.
> When button is pressed before driver is loaded,
> driver will miss the edge and never respond again.
> To fix this we clear the interrupt via i2c after registering IRQ.
> 
> Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> ---
>  drivers/input/keyboard/lm8333.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> index 7457c3220..9a810ca00 100644
> --- a/drivers/input/keyboard/lm8333.c
> +++ b/drivers/input/keyboard/lm8333.c
> @@ -184,6 +184,8 @@ static int lm8333_probe(struct i2c_client *client)
>  	if (err)
>  		goto free_mem;
>  
> +	lm8333_read8(lm8333, LM8333_READ_INT);
> +

This is the right idea. I am sort of splitting hairs here, however I
think it makes sense to place this read before the IRQ is requested
and not after.

As written, there is room for an ever-so-tiny race condition wherein
the IRQ is asserted just after it is requested. Before the threaded
handler has run however, the new read in probe swallows the IRQ status
before the threaded handler can read it and react to errors.

Also, I think you should at least capture and evaluate lm8333_read8()'s
return value as is already done for the calls to lm8333_write8().

>  	err = input_register_device(input);
>  	if (err)
>  		goto free_irq;
> -- 
> 2.40.0

Kind regards,
Jeff LaBundy
