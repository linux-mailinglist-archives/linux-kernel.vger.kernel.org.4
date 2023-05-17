Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56123706598
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEQKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEQKvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:51:22 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC3E1FE5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684320681;
  x=1715856681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8IxFuOTl1IzeGpO2sgrUYPcmMezYRx6s7Pm/O5xOeI8=;
  b=LeqWgPipbCkKBcJBbkV5YUkB1+QBXgLPOuaaSPEPtvyHLQNXBI/eBj7t
   a16mmETDvDdMfFbagKgJe+0JRa9hLgdZ5yMYuv2Us8Q3J+2Sn6tNbJ18v
   pf/QoA+ClEspciT5sNZVSO2zW9gekd8FkhBbhT6/3igf9Vu459637wlLK
   L1QAtSGMqn1+DWm3Mz09BSxDK9A+H/sINcHXHdMlCBy3+4ijlD/iq9k8c
   WN40p2WmeQV5yXdiRvx3QyG6pov8yFSeMU1T2dX1pld5VeE0LLERpwmkk
   6eBMhb98Hf3kL+/cTgyxAE/fU+cvnM+8dr2rFjGR0gCRteOxCp47atqTP
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ia86gWC5H5jNAUvmGrSdaAsbpzMdip14q2GbvbdIzKpi99vs4tniu0IO3oFGvrkoAgr0Z2n2+9TFgJ9gPy6lRCHPYx8TaWLAygrA9XiEOPgzd1I48It7rbGFFamTWgF+4Ey/JWY6uejhP4/Y36XhQLFNDo5ZGSvfS94fJKXCwgfuXVLhFWFVXfO4cVlFLWKvsNIUzwVLOn4Nn56rk5A2Gm5qD6Rc2jb6Z6g2TWl81PB4U+DcdsYv6EdqYesMtk2VTCqyaoAJ+ZuqH58tyDsUcxyxlrpF5mZd61VhvBzOIfBYpgChtu6CAKpbwS5NwLDw+lHqVx0OQ5VoRhgJutT7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IxFuOTl1IzeGpO2sgrUYPcmMezYRx6s7Pm/O5xOeI8=;
 b=naN8v9NXFqwic5WAhM3KYqZeeDxMfSd/KFBShtgB8U1x80Vb8JmyWPzGOAtRSVH+33KvHQCFcdlamCbF9zri9jMrE15NIAhDMBUhP5SaLjZyccuJ4CvT+oUeaNCINTxh9JbguYXNTVG2LiZb0ONLQht1EXpmqkQHYsm1MBH0YsgpS2L6dQ9TW7Weg9gvSnVCen5EZqm+YgI9BaSPVne16hB9fybQPHN3mfPED4eEEhcQuxxvJKZurK//679RxNVvGjgySv1mDkx/F1OuXXcWV35zwQEs10+sxNatcbK8YhRf6+YyQCSYd67BVoZh1TWgZiVrYbydvENfNJmf/z50IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IxFuOTl1IzeGpO2sgrUYPcmMezYRx6s7Pm/O5xOeI8=;
 b=rAsONHM/KUPlXHYbhfVQ/TEpYd0q3/crVDTYfUZgEnALtvJ0Wg+b3k6B8If749PTV/MJDYoMVhF1qvEAuHELAw3YYz+UfkhI5FgkPYQT0rge6vZFL6Qpji7W7pV8DJ21+cLUlpYyD5SpqeFs/DJqnr/MkaATYaVzjwdKHJJVNf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <7dbcd394-8cba-10be-5041-77d74010e7a6@axis.com>
Date:   Wed, 17 May 2023 12:51:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] regulator: tps6287x: Fix missing .n_voltages setting
Content-Language: en-US
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20230516082333.466429-1-axel.lin@ingics.com>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <20230516082333.466429-1-axel.lin@ingics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0078.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::13) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AM0PR02MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffed140-a657-49c9-d1f6-08db56c4a35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzCw3kwIRZDX2XCheuRl7TgNdpA1cW/zzX5cjYj9GHoWgf0A6yo5nOelXieC6S3ZeS2/cUJHuZ30o2tFXh1LMapKk42VURZndGUiO40S4NuvnSdpjsuwnpauQ6+wktKBpMS1kHGpAhxEg4zy06pSHMmlaFIyXKoWgsa6NEpvwnAYYYruwGxzqqYjVKS8R5yCCQC0IcuY4GUCe/ov+vK2L1aQKQKn48QbJubHeX2UAUn361c4RYQ63e8bI/zQ82+F1ObKzoHYd/ayZY9xyScmgabeLpOSrZLlILJRSX5G6LfOre9oHjYKfj7aRdeUg7My+BzMVqTU5BSRtZJOhG6l7bUnpd27wXeLqOS3NYhZIchLoKPO80gXOh3/NVO438zJr1YXkKFlr0Ar/ZX+yg5GoV4ijm9sAi/H9MXiGVICbbXOo7qgbaaPrWu4cqXHSwcrrViosC0EROZxhUlhddFKRYT0s1mGTItdMskpGvw/kdoekkalOH2z3woUOK8Gu+1RM2BqHFwtbrZzT5PuEae77rVm/Gr7wEA3CW6uAYkYUyb3GJGhcT24RKYMc3dao88mPVmVbzDBPek99ulnFZI+w4tM8SBS4wfTgAsc29jRfc355v0nH9xuwC3QSN4Ts1c+6kliwk9puvO4VY9+LN5Mct1F7xZPPJ92X8QtpL57ESvA7dH07dt8JJ4htdurRD8F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199021)(31686004)(2906002)(110136005)(54906003)(4744005)(5660300002)(8676002)(8936002)(41300700001)(316002)(66476007)(66556008)(66946007)(478600001)(36756003)(4326008)(6486002)(6512007)(26005)(2616005)(31696002)(53546011)(6506007)(186003)(38100700002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk1iak5OMndiNFFEL0J4UVhjTFJRbnJpRUZHVi8rNEZmWGZKTTA4L2hCcmM5?=
 =?utf-8?B?Z25ycnNYK3FzUGhQYjIyNjZWTjNkZmxTV0RaMTNCV3NsMlhvOWZDRWVBTkZz?=
 =?utf-8?B?VVlLVVlEYmdjcmkxQTVTZ2R4Z2h6VVZ2U1psQUMxalJyU1Z6NGZ0ckE2WnNE?=
 =?utf-8?B?RWlFREF0MTEzNnE5VjlUVzV4SUc2ZVVkNkJzMTNCNzFQYVllUGpqUlFnM2FI?=
 =?utf-8?B?RUMyaDI2dlg0d25tTzd0ZFhiTFRaR1pQR3NCV2x3dDk3cDdOcU8yemJQYjVB?=
 =?utf-8?B?SHZ0VkhMUFhmV1oxN3Jnem1INXZDeVVqbE1aYzVkd2p3Q2lyWHhjdTVEK0t3?=
 =?utf-8?B?SGVwYXM5Y0MzVHVMMDJSVEk3c2JQNGgzMHNKdThVNnFsUkpJaWRxTm1WT3Rh?=
 =?utf-8?B?ZnB6SlJ5ZHZ4QWJoNElTMDlMbVlzVFBOUVE2b2FvbzlIU2M3ZzJIdHVRSTd1?=
 =?utf-8?B?dktXSmY5U1dDUWp5T2RQZjduZ0o0MXhKYithRVpodWRPeGUvNi9MVG5IQXhO?=
 =?utf-8?B?YUx4QytSazN3dW0xWTd4ODRhd0s4VkRrMys5WEFwalVhekVabVFIRGtHeTBn?=
 =?utf-8?B?cnRSaTE3eUUxS2RVNVM5TklJTHloanU3VkRkMlVzVURERFNCRlArV045NGh3?=
 =?utf-8?B?dUVBT0dsNTBlYWlCRThuZmlURkI2RVJBUDFTeTNZWDNvZ0ZaNnI2M2c4am1o?=
 =?utf-8?B?VFFlWnhJc1V1WisxZUNZZnFreDlob1FldjZRbXJkNVJzVEdYQzZJSW9xUXdl?=
 =?utf-8?B?OGJUWUpkSTVaYVVGcjhaa1FVUXR1VE9wcFZqd2w5c3Zrb1F4WXZoVDFVSW1a?=
 =?utf-8?B?UmhvZUV5aytBdU9QdWFSNEs2Yk1VZ1BNUGVuRWEvQWJhaTRueVcvTDFZck1i?=
 =?utf-8?B?TUkwZDhzRXc1QUlZdFVtMmorZ1Y5WDRFWmMxQ0FRVGFhOUhVd3d2WVlrQ3pR?=
 =?utf-8?B?eHFZd0xPNlg5SmxESGhkWXV3QjRjOFg0b2hmNXpHajlTS2tOREoyT0t1V2p4?=
 =?utf-8?B?ZFpiT3VUNGlkV293UGRZRlhFeCtyMFJYWFZReU51cC9pVEF2T0xvUXdpWVNy?=
 =?utf-8?B?UmFIVkd1YjJ6ejN2MzNGQ1pHcUNZTlFRTkJzR2pBdnNGaTk1bGVnMVYwM1JI?=
 =?utf-8?B?RWVpVjZwR2lzbXhPc1IrVlB1VEVIdXN1TTdHdlJIYW1WLzE2ZkI2clV1R0hV?=
 =?utf-8?B?b2U5bFBFNmtMVDFMQXl2ZFNFZDdQSmxzOTNQbkpTaWFKYXJJRFl6eStheUlX?=
 =?utf-8?B?Tys3RHcydkY2YlZ5OHI2Tmd0amhOeGl4RkdVamY0NnlIN1FERDVrazhQWTZN?=
 =?utf-8?B?Z2hHdnBCTzNjcmdEYnV6b0FkUndOOUpBak9rQVUrUVVIYUhzcVFDd2lHTk92?=
 =?utf-8?B?TDE5eXRjbHFLemx4K2NZUGF0dFVpeHBrYzA4N1pMbGJZYkM1cTZNL3V3YVB5?=
 =?utf-8?B?bjJLL0NSbzZYYkZiekc1RkEydXZnL2NtakFuZnZIeDlmblZQeEpLdVJqYy9S?=
 =?utf-8?B?SFBCSHlNOTZZYmVHMG9pRC9HNmJPU2dMZzNWdlpEaUlCYzUzaW9aY2dISzlv?=
 =?utf-8?B?ZEhWa3Zrdmw4R0VZRGpLeCtPRG03VXNpbjlLaC9aakxsMDRGd3NSL2hFd3M4?=
 =?utf-8?B?RTFzK0RWbzNXZW5JRjNEWDhkdVVWcGdkT3cyMXBxbEo3bXVuN3pPR0ZkRmJo?=
 =?utf-8?B?YW5LQkN1Mzg0MXpJVDlpeE8zNktDM29oTXdEaTBHcmxzdGU3eWhmbytpdzBY?=
 =?utf-8?B?RzNMSW9rcSt4aFhnNzRTQ1N5cWJhTjlXdnF3U21IY2JWWHBjaUcwSkJQMVRF?=
 =?utf-8?B?bS9LMkZBQXBDUzFSajFHd21mSyt5QmNZTXNNa0JYbVd6aHZPUGFvakhXMVBz?=
 =?utf-8?B?TVUwbUFCNi9SbXUxSkcreTFqamVtT1RQdGdoaitZbWJ5NWhrS0hxQmhXd05j?=
 =?utf-8?B?T0tCSEU3UlRXS3pHZExnTWF5c213TjZvby94c0ltbSs0dTFueUhFSzlEL29B?=
 =?utf-8?B?b045enhYUlFHckFPL21IcVV2Yk1NcXFQZXd0SHhkQ3E1WXF0T3ZlQjg1cXRT?=
 =?utf-8?B?R2dkUEc2cGxqMHJKYjQraVZtOFo2dGJEQ1RRa3c3ODJIeFNCcE5FQnk5Z3RW?=
 =?utf-8?Q?XI8ajyF8ZrGGcucUTYcVgQS1+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffed140-a657-49c9-d1f6-08db56c4a35d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 10:51:15.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpEb3P4cv6DHO17C+CGnTojREvHBji/jwlBaG8l4JxqOB3GHra06LyJaZgituK5LUCQHFqDiHMWOqFSnayxZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5876
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mårten Lindahl <marten.lindahl@axis.com>

On 5/16/23 10:23, Axel Lin wrote:
> Otherwise, regulator_list_voltage() will return -EINVAL.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/regulator/tps6287x-regulator.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
> index d7fc82175493..870e63ce3ff2 100644
> --- a/drivers/regulator/tps6287x-regulator.c
> +++ b/drivers/regulator/tps6287x-regulator.c
> @@ -119,6 +119,7 @@ static struct regulator_desc tps6287x_reg = {
>   	.ramp_mask = TPS6287X_CTRL1_VRAMP,
>   	.ramp_delay_table = tps6287x_ramp_table,
>   	.n_ramp_values = ARRAY_SIZE(tps6287x_ramp_table),
> +	.n_voltages = 256,
>   	.linear_ranges = tps6287x_voltage_ranges,
>   	.n_linear_ranges = ARRAY_SIZE(tps6287x_voltage_ranges),
>   	.linear_range_selectors = tps6287x_voltage_range_sel,
