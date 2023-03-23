Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E236C65D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCWKz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCWKzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:55:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED39019;
        Thu, 23 Mar 2023 03:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTwUDpBrWQCPHOH9isDaxFodTcR6DQ4jy6h7X6G1qeibRaeplH/VNxBupZWIhANb7itYLP9ajPPhl0gyA9S1DcWNnoFSIxJMjP4cW4n2Vaa4rw52K7sxGtM3WAGYygVorH9kkzTf+7VQ4thNE5DC9403o/yRYIiearyrN8TfX1JrJx4NBkJiwz7Dx4H8s4Ih0TzY6gJAyMT0qxXaZprONyuJpc/qmMurAT+8+LJaD0P+pAAin8WYQalaz59afndCGHX8QKCIIiib1/kNrbyhLytmEWPQcfaBWWkdQ89BO4idzfZ1M7K8fNPNnbaQbUQvJx/uMJeESvHnJ36ou520yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpgatUU/fLQgVhPhwitFb1QE64ujZDrOXuVilhVvkNg=;
 b=BGaFz5yAFjngLgtYp8J81FtOCnzU6ccZ82qGSd+LqVYe+dbLBpPn+bARrtE2F069hh5vdVHYV3BuE4KovqPNaAZRBoKKTCksenwdUN/CjR0KriHR2rSYY+YT/ndWSiqKBiMNxhiuNOilx227/mXwdIJF4bO4AR/bRbCOkza9xF6U69h+kDTtdAkLXPJ7pUllxcEGE3h4p2w6vvYiWbHDHIrDs7doNVR7ClO9KDaUC0miZtl+8J03Oy/BfJKmQLD3bbSqpPKUMO7O01olM8Hzr1K0f0aF8PNcO3XnaiMYb3oV+hhJuWGDx3DravgqJxDDz48MJA+DVxuDyn7KasuNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpgatUU/fLQgVhPhwitFb1QE64ujZDrOXuVilhVvkNg=;
 b=cSxQAyCnI8UyIjKN9Dzan3hRRmw2zKcziBVV0mZGprfrOTKDSWuycjpNjsJOWh7gW/QQUS6MDgPLTyMNxSjeLmQ9QVZtFQQso+l+MUMy7ux0GN35j8VB7tyoFKyHBRI0f+NAHFNPM9RT3Z6QRWaZf2vnkiFzgftrX6Ygkd8qo9hj02Q+RBgomQauXgPrd5KKMksiV27Ulyyv54K1S5HPiNz2/05YabeZfzKyKE3a5Aq8MgMYJlFTTeL+8i45tPdQ3OWXkQljxATyUpJP0Xg0Wp6usdpUhnVwec+9gLF+6Iuu1bnNkXVP/kyjMh3DzKB/1WaYNiInBCplKbyisqaATg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBAPR04MB7432.eurprd04.prod.outlook.com (2603:10a6:10:1a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 10:54:31 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6178.038; Thu, 23 Mar 2023 10:54:31 +0000
Message-ID: <73fd29ce-3072-dfce-ebf0-3e197230fa94@suse.com>
Date:   Thu, 23 Mar 2023 11:54:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
 <129aec21-4997-6b8d-5bd2-8e013f575208@gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <129aec21-4997-6b8d-5bd2-8e013f575208@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBAPR04MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: bda37d62-6732-432b-0632-08db2b8cfae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQ5vjWs+RWNcCmjSaSdY9XCWQkjcIeGBYROe9bPF9ftE3BHSGRlMOtjZbEVb/aFe6U/doIJAM1xAMYFK7gT2m0/Z0t4vr06Yr4KBF181TRJPFPGzye+z4Y9xVohAOMy0cgEyyevhug21NebdjsZlE7Wq0+nA2b0zC+N/XBJ8GhLuGeap3B1NXxJp+gZJRCOr4ztgXgoP8LONIutxlwjw8pAWDWyLYJ3CZAAIwRGEdqI1jXDL0aZpAxu1j8eQXZiKWB+QLEi5HhblI+oGaSIP2sPGxNKdIvLHb1RMQ1ZbKMdpScVCVfpRHARIEWWobVMnre5NDoRGM9gs8DyLubKM7RMR4Uiy388oo5Hixtb2uVViqocHNKGDm6r08deNdWWfz6pKw2h/wpF4JT2VDca0ipo1hly8Q7yUqVDqoQXCMg7p/N0ARr81JEyIL603FeG9N4GDNUQU1d6Cj7cn9WaQS2F4sAv6GiTfHgJgNsh0akxFXrhmAUrOYk8Xdb9unaaVeo0Z+33gzHnYcWg5ZsTcuNIBSzBKl1iQIuv/T8B+tZ/QzaMovQotYfVC1TwWHQuTWn87VId+SHW6a4KZzby7VuQrDvCB1vp/cnVCQhC1xe6U7rx2feeL6rAhUG9m8/pAB8D0Edttcc4zPXjb/lMamrh0mX51bZPMFv2AXkb+iY8/mAnj7sTvVcNiwUTZRKvlHLM9oBDztr9UTH8LKnlI04POGbaFIqzlp5MY2YHKtTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39850400004)(346002)(376002)(366004)(451199018)(31686004)(38100700002)(2906002)(478600001)(83380400001)(6486002)(2616005)(186003)(36756003)(31696002)(86362001)(316002)(110136005)(4326008)(8676002)(66476007)(66556008)(66946007)(4744005)(6666004)(53546011)(6512007)(6506007)(8936002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUF0NE8vY09Bd0IwUVpsVEI0U1VVSEcrQkpEMVA4RS9CZDV0MFdKeXpXOUV5?=
 =?utf-8?B?VkY3TEJQSHJJQVd1MHBGUXFtS0ZZcFFMSUxCK1NnSGlmSGhjR0tzZVNmQm1m?=
 =?utf-8?B?N2NlTkN5dG5FRUtCZFBzMWdGWUFJVjV4ZVRyRlR5bVRNY1d0UW1iU0llTmI0?=
 =?utf-8?B?aFd5MmJBcGNRbmRjeFhNMmxReWNpMlcvN1VBNmUvaXBkNm5QR1V6MVJGckRQ?=
 =?utf-8?B?Yzcway80ZVQxQ01OWjFaSm5md3d5NkJuRTNVbVdWWWt2TDV6b2pNWGZSQVp6?=
 =?utf-8?B?ZlFKY0RiSFBIa2VtTHpCdG9KQU54eUIrbFk4ZWNnVEsyeWwxVkFRVS9NRnR4?=
 =?utf-8?B?Mlg4aVo5eUhsVHp2WWlMM3RrMlRyUkVjM1I4bGNBRVB6NHhXOEc1UHRNZThL?=
 =?utf-8?B?S2prM2RPMW1SN2t4ZEMvWVlVVTJMVGxlcDc4b2tWL1ZEZDVrVlBtcGxFQzlF?=
 =?utf-8?B?TzEzN24yaDl2QWZvbWtPN09QNWhoSjNROVpHVHkrdndVTjR4SDlxd2dGZ2J6?=
 =?utf-8?B?dXJDdCtGbllmSGE3endPR3NiaWp4RlpUYk1pR2NQM25rN2YwM0k4UFJPWHZD?=
 =?utf-8?B?by81Tk42UHFqWE8xRUxyNzBTTEJIZnAyQ2hNeHRGQytOcytZSm9rbVlSOWkv?=
 =?utf-8?B?c28yQy9oS2ZpY21OWDJBODMrUld1bElnc0Y5WG53NWlJUWVXSnp4RmF6djBC?=
 =?utf-8?B?WXNocHNReEpybmFrK1B0RG1zUTkvbHpxM2Z2OC9IZHRoQk1hT1BQT1F1SUM0?=
 =?utf-8?B?cCt5a0l5RVJCM3VPQk90ODY5czl3Y0FWSVBxSmtnd1QxNmVscVh5SElXdUZm?=
 =?utf-8?B?aytWT21LUHhZZUJyNmRCMlNOUjlLdTZmQ0FzQ3praU1JWitYZHR3aGQvUm9D?=
 =?utf-8?B?UkxyWVdXOStHNHhjaDFBdVhTS05RL1JiMlhJWlZGWnpFeGd1OVErVy8vZk92?=
 =?utf-8?B?TTBQV3RGNnpNWmdJWXpnNGwvZVl2Kyt6T2o1ak9UbHRReFhqZVdUbHhIOHdU?=
 =?utf-8?B?dFRTckVEeGtvK2FlaHl6K0hXQUpXa0htQjByY1dwVTNDUEZJem8yRm9zMVlh?=
 =?utf-8?B?WXE0L1VhYlFXRGZranJ3NXBSbkF3LzE2YjQzd01GTHNha1BIZlhPZkQ3SVNT?=
 =?utf-8?B?YkV6ekJKRm4zSGNUaXQxL3dVQ1l2U2Y3RGczazgzVlVyRW1hdG80WGdXZlNt?=
 =?utf-8?B?aGU2WGI0aDgzR0JEQTVweENTaDdYVTRvOUFqWmhPZFJGREs1WDJDSVU0eWtT?=
 =?utf-8?B?SGhFWkh2MUc1KzRlVkZKUkNmUWFZMjYxUDNPWGpoZ1RIbEIzTU5Oc1F3WGt0?=
 =?utf-8?B?ZDV6TjArRXl0MVhuNXVlQllRQVZCSThaQ1BTVm5UcW1MVWpySTI3YVpGTjdC?=
 =?utf-8?B?NFVtU1B4UXBZTGs4YmpBdFVUWVNLaEtmaTNSVHZGTFVyVksva0VhQmdtdGlK?=
 =?utf-8?B?UU1UUUl1MTdmMGJabEpJMlFOTk1ta2VnUTRVbWNNeEVRbHdDaDdTK0RXVmZw?=
 =?utf-8?B?czhERWhnWXZ0ZXNiSnVZb3hUL3A2aHNuaUUxLzViT1AzbHFTdVFmdFUwVTJj?=
 =?utf-8?B?K3ZmcWMxL0RZVmxWRlhpWVd2bmFKMUdNR2VDMGpGRVFvVzdaWXVyc0ZyUWgz?=
 =?utf-8?B?VWxLbmYxYjRLcVd0SDFndzVWbnV0SksyM3RRT01wTS83Q3EvTXpIaGc2OWsx?=
 =?utf-8?B?bjJUOVpqbTRNQzFXNDd2NXV1cWcyeThXS2tLWnZPY1VwbmxMbWppcVUzZ0sr?=
 =?utf-8?B?R2h0VlZ4c2RsdUR5Y0o4OXZKUzdVc1pHYmFINGkxcDc5aEVGMmh2Q2U0TndI?=
 =?utf-8?B?alR0NWtvbXc5SjJFeXFOTnNZME96MFRRTjBzTS95dm9sUDNIMkJuVkRVbGM4?=
 =?utf-8?B?azU1T2J4ZEI4WmdnalZpdXFybXpIODNiQVF6SjZsZWNZdExQbmRiVW9DTlY5?=
 =?utf-8?B?K2F2ZExMT282MHZXaVpmaXo0emZyeVUranA0dGE5dFNMVkh6NE9iQXp4YjBp?=
 =?utf-8?B?TVV2bDJYSllzY1l0d1hnTmdGTjBJeWJ3OHRrbytNY3RKaE5lZ2ZxV3JGeUIz?=
 =?utf-8?B?SVN1cFpheWhsVVc1alNCekxvdkNEZXJ6WUU2NGxQT2FpSytuYUNhNnBjK0lV?=
 =?utf-8?B?SlJ5NG9pNVZneXhvY3ZnNjFCOEMydjhyVXdZb2F1L2xKOXhrY3dNSXBRZyta?=
 =?utf-8?Q?QHgGzwTfKkjI8I+sDnu+9midtz554M/DS9qaNFB/aJXV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda37d62-6732-432b-0632-08db2b8cfae3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 10:54:30.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7TVlwAJy4aSfluXHLITvB+Lfo1N4fvNu1R6tRSTAmBo8OJTVXTliMxBUg/UdXO0BVRlgwNAq5Y9hhjtXUIhQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7432
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.03.23 11:29, Sergei Shtylyov wrote:
> On 3/23/23 12:53 PM, Mingxuan Xiang wrote:
> 
>> platform_get_irq() no longer returns 0, so there is no
>> need to check whether the return value is 0.
>>
>> Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
>> ---
>> v1->v2: remove redundant goto
>>   drivers/usb/dwc3/host.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>> index f6f13e7f1ba1..ca1e8294e835 100644
>> --- a/drivers/usb/dwc3/host.c
>> +++ b/drivers/usb/dwc3/host.c
>> @@ -54,12 +54,8 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
>>   	irq = platform_get_irq(dwc3_pdev, 0);
>>   	if (irq > 0) {
>>   		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
>> -		goto out;
>>   	}
> 
>     Now drop {} please. :-)

Well, no, please drop the whole patch.
If platform_get_irq() returns -EPROBE_DEFER you now give that
as a return value.

This tiny bit of optimization is not worth changing semantics.

	Regards
		Oliver

