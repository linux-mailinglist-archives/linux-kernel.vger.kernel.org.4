Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAF86B7292
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCMJa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCMJaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:30:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E421E9F2;
        Mon, 13 Mar 2023 02:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgiL+tgYqh3U3VHhetbqStecdv8uvqSD+2gueF8BaG7tNYZwP9NXmfPKaW9ZHBKjwR38B2u4sQF1sgNon9wyY35jpbRvH7WkMw0/S0/hMaidjAUhEWzQbb+nWTY/WR1aqi8pUMg9kcoi1yHTbsLXOErIrzTTuW4lPfYgzEY+UGUe6mgTEuj2B+qVGFPErRhYFhBWqCrcFSVrBPRYbnY9+1yFwJDW5oCXKtJaX21+csMymf7flD2fsiATdUWO27x3L0RP7Xcevp1azgkHhdI1RzgY0pKeuso3aOP9KC+9LXnycB3sK8DSPYMktELxogNfce0HBNsKWC2s+UvoShoXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqZG5Lt1igTWa5Wu6x/eggIjzcczBx80xiwpVjYMRas=;
 b=TSmfZnO8cJCE1VB+8IWlzFiHlM+OAywnw7S7OSkVeAGEzhyInLPfg9S3jk/dyTGmf2H+Vnt7jPyfqjtZodP9xyuLxE6Eu3+f27Tb1bZX8hWFFyAxeny13R9A7JMAHsd0c7L1pcgYbzca5PnLiDTk4i7ERYbfQrK0STd2EW6OX2Kz77wizwqGAdgZnwzf6KHfJue6dOhxpN67SQO6Y9OB8nzYLJoO583ls6d9GCzeBySydiZotSq6SFgKMT+Q5ldP9FRaTPcin+H4ThMVRrqRn+mtuTuWXxxq124L1fo6OFh1uubHrti6aZBpzTbbbQp/kZAXYehKXRfot9FGSUribg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqZG5Lt1igTWa5Wu6x/eggIjzcczBx80xiwpVjYMRas=;
 b=z/Vs6oexNbg8p3d2/MdQ2cVXJXCMhigsu8tO3akfW2aPGOgssaBjN7dcSqQJkCUTRDwBr8OXxYnDAFDaxnNsWjCnzQk34g5zmIik6anxxLaKv6J5XOrzz9knmFaG/nscWvxnslMdwsaE54HZ/KnawHWdRILQVsFB1QU3kuLvj/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:30:52 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:30:52 +0000
Message-ID: <50c21d8d-bb25-ac94-8386-36b62243b625@amd.com>
Date:   Mon, 13 Mar 2023 10:30:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/5] mailbox: zynqmp: fix counts of child nodes
To:     Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, jaswinder.singh@linaro.org,
        ben.levinsky@amd.com, shubhrajyoti.datta@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230311012407.1292118-1-tanmay.shah@amd.com>
 <20230311012407.1292118-2-tanmay.shah@amd.com>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230311012407.1292118-2-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0053.eurprd02.prod.outlook.com
 (2603:10a6:802:14::24) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 415f66c9-e150-462c-b53f-08db23a5a2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9pmhJgV/Z2owqo6taLx1sbFfKdGesko9H0aFgPfMKzWTS9+5YX7frUNU8FJheN8ViihFeD1vPA1gaO0sk0B9C8dgF/EF7YnBbbcxgNR16+ks/SEeuK3SZrzDSPAZZ/jk4doUFeKhxBWjs2nDBCnZkKsikWx7Q+XmLQsRpCP9So1fDdjKaVC8NNpvIn8NsaKoVAYnkVF1pLbAEg1MS9ZQa3135QpR0ZPBZsQNPEwaHGVN5l6GrF4vNOl8BLcraWNBQvHuO2VF2KYgBF1Q9H7ZB5ihe1JGdDfpzxBebqUC+0ohPLmuPPwkZRXBPeR2JYUdlg3iQNTYLr4AirNHqO1uHUgh215GXF7InNavVPvwkzgbYTzzERWt7m7+pJb+2/hCAjoM762djxMOGep6YQHE2FLIO9Dnuk9voJMFPDnyOkc4My1fE6RV5mMEcZQTfBAqt6tCH4JBk4L7ar4LQEyCyuhavaT+ZDWvflsETA+qavB+8FYpWvq+ncFTXlJTNk08F5kCT3yr6GHS8z2lqwbJuGiCZ57Um15vISrZrocsdweyDmU12XHTbYCK1VAmRS6GC8R/wNbetGH7mljul/UITT6VNXLLw9evtWudhKCQy5fTJdRVg1Up5ixoxV3UmZG0dLbcPMEj+F5PKx720Zbu3wMmqEUT3vBDgOZ0Q92vmm+HVfC98QAwvi3HfGIxL0txbiOl3oKrdv7Q1FmmFnvr5Qzs0lz7XQR/SfsDf8DNuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199018)(2906002)(15650500001)(31686004)(83380400001)(44832011)(5660300002)(36756003)(6636002)(66946007)(41300700001)(8936002)(8676002)(66556008)(66476007)(4326008)(38100700002)(316002)(86362001)(31696002)(478600001)(186003)(2616005)(53546011)(6512007)(26005)(6666004)(6486002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VJQWVOMzQwTHR0L29NUEE4NksvUEZjWFg0SWdxSEg5QXNCbWNNYXlpU0dV?=
 =?utf-8?B?VGpFM0ZRWFJrNWJDdnFpMWxmVklyczJaOTBvNE1vdHV0MU9ldnE1MXRvWXZP?=
 =?utf-8?B?aTVGMlVTMkRaM09iVmxSUm1TSU9PSGlzcjJ2c1k2VjlGK3Z1dWh1K0xreUtC?=
 =?utf-8?B?S0tYT2VMbWJ1OWN6dTJYS1hlVWk5TkE5TjV0ZWlJbDljTVByY3BNbnN5ZXZx?=
 =?utf-8?B?VS9Xd3kvUlZqTE0vNmkzODgxcHlFWmZ5SXFFUWtQSXFlcjMyeEI2dVNSelNp?=
 =?utf-8?B?M3JQUDk4em00TDFwR0ZsemI3RXBBcmlvbkEzemlqam9ueXlXbzNVd2RCa1hu?=
 =?utf-8?B?MDB5YVU5SFFhbkd1WUwvRy9wNFZhSnlWOWJsTis4WFdoMUtyeVRrNkFqWDZ2?=
 =?utf-8?B?NXp3MTh3dFBFemVkQlFYMTNuRmVQay9jNkl0am8rcmRzNy92L2k2cHRzZVRy?=
 =?utf-8?B?b2VoMVlLR3lRSGhDZEkrUmZleEhEMmFSSFR5RnU0S2ZaK1NzYzh5Rk53N3hZ?=
 =?utf-8?B?dkk3UGlWWVJ6YlE2dU9DZFlER0oreGxTOUFoeUYzNmI0SU5BZXRzZGNkUTFt?=
 =?utf-8?B?UUtZaEVnNFU4dFdac0trdTFBVDBSMEkrem5mZ0RPeW1VTXJ4OXE5SjRKbFk4?=
 =?utf-8?B?b1ZuUVpwU25pRjlzNXY1TUx6aUlPMkluTnVIZjlzK0FPOVZKN3RHY3pKb1hj?=
 =?utf-8?B?bUVmdVVzWlFXYnRHRURYeDF6ZDhmRDJnZnpEWWlGOG5iM1lhRmZobTYzSHNk?=
 =?utf-8?B?VURaa2JBRTZwZFlMa1NBNVBDd3RHS0ZRajRrODhMTFU4WEJ2Z2V0ZVlPVFB5?=
 =?utf-8?B?TVpwblpqcHhsMjVPSHJrbHc4QW55NTJtay9GSll3dGlSUjZYcHVBVGJvR0NE?=
 =?utf-8?B?UHlKZjJaZnZPZWcvU2VIMHNERVUxU3ZYamxzNUZtUXZsNFgxQUo5dzJ1cmFZ?=
 =?utf-8?B?TWg3UmxiR3BLTm13WXgrRFVxempHMkpZdjdHQ1NhM3NxUVhkTU5TbXFDRTQx?=
 =?utf-8?B?NmJtN0MzMkM0UUZtR3RjVTcwN2N1TlNvcUM3STRTVzlvUmJiT1NqOTdoRk5y?=
 =?utf-8?B?UmNIcHliZ212cXFhVkx2RUpxWGJFcGcrL1MxU1BzZFQ4eGpnQi9mQjROZi92?=
 =?utf-8?B?aGFndzY5SkpPdHFyUlFuRG9ONmlWWWsxaFNoamR1OTFVWk9MbHZ1V3Y4OWMz?=
 =?utf-8?B?TTRlZklQenhvd3cwY3lVdDZONHAzQ0haZ0NEc3BDenRaNEE5WXNrcXlCS1hU?=
 =?utf-8?B?aDZCWWhVYUtaZE1wdXJ2V3hpZHhLM2kwZlMvU2EzNStkcWdsOXFCRGVDSmlo?=
 =?utf-8?B?Nm1vMnkwS0pxUkQrWDc0Uk04VVVXczIzN0NoN3hJSksvcVQvcXM0Y2wzK3Z1?=
 =?utf-8?B?VUljU3FjWS9zVTcvbVQrS1dkQlN1MnFNVDJmRlRFSEhSNjExMVZPVFRtamJz?=
 =?utf-8?B?TjZRcXUrdGZsOVFkaXRHK01RNWdvT3J0UUhLOWRzUHBCMFJiSkNraDhPSnVY?=
 =?utf-8?B?cWE4dG5QSENndmFPYXNvVkN4ZXhFeUwxYXVWYk9pYzhEdHlqY294QW1lQXBk?=
 =?utf-8?B?dFRHZUlLQXJjZkZ2c0wxYWFhcVJBaHRHQzJPL01GZm15SU1XK0RDU3JTV3A0?=
 =?utf-8?B?cVVnc1lQRXB1bGZYRUF1NTZFTy9WV0JHa203cmJwb3NpMDdwdjNBbFpkNmpS?=
 =?utf-8?B?U1FXT1c5RmROaXg3UVppeERGSHRONzJyajRmdzBIUW5KSEtoc2xUSWdJNitI?=
 =?utf-8?B?OS9CQjdGK01HYmw5NW1CMXI4S0c2ZXNWSXJrRWdTS0ltQXBydkdEMjA2Nlky?=
 =?utf-8?B?TGNtYyswcmJxU2dlb3BhM0RrWTY4Q09yVmtva1BuNGpsRVBmR05YeklFSHBk?=
 =?utf-8?B?Nmt3dlhCNGFXalo4MnR0eS9vRDVQdEVDcG1McWZHSndiRk5VeU5iRlJhck9G?=
 =?utf-8?B?cTJkc1dWVGRJUW1wNGlLR2xwL28zT3grb2hRQ3YrUndraDNkKzhvZTljWlg3?=
 =?utf-8?B?QVdMWVdPY1lRam43dm9zV3lXQnZiemQrNTdYR0FtckUrMUoxMkRnbXEvRkxM?=
 =?utf-8?B?Zy9xeVY1NzlZUG1NZjFnVXpQREhJUVNIZ0dOTWRzSzcwM3EwNGg3aDJ1Z0RL?=
 =?utf-8?Q?F9wQwsNorg80jGOglie/pyQ6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415f66c9-e150-462c-b53f-08db23a5a2e6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:30:51.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VyrA5UkrPQ1qBi4d2ifRoBUQNh+hhZo6t+Zp5ac+IMI/OghbyNGOkNRJqUfqatm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/23 02:24, Tanmay Shah wrote:
> If child mailbox node status is disabled it causes
> crash in interrupt handler. Fix this by assigning
> only available child node during driver probe.
> 
> Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v5:
>    - mailbox node count should not be 0 for driver to probe
> 
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index a4c8d23c76e2..ae47fbac38d2 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -634,7 +634,12 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>   	struct zynqmp_ipi_mbox *mbox;
>   	int num_mboxes, ret = -EINVAL;
>   
> -	num_mboxes = of_get_child_count(np);
> +	num_mboxes = of_get_available_child_count(np);
> +	if (num_mboxes == 0) {
> +		dev_err(dev, "mailbox nodes not available\n");
> +		return -EINVAL;
> +	}
> +
>   	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
>   			     GFP_KERNEL);
>   	if (!pdata)

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
