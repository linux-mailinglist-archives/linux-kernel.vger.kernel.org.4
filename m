Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850E45E5411
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiIUT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIUT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:57:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2134.outbound.protection.outlook.com [40.107.92.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC84A2852
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdpRI0wc0DZVizQWxCt+GoxSoKzqn15UKrz1R6tFSsEAzUrNg0rZiDPR4av0+KcKbPFgFx7ehk6KOewIzw7nYlwmNpoICIqKML1REdHYe4U2WdoGhqV3M8p0SeDhWw0Q4j1XGlGOp6CNPjc11ZQgCqYDUjz/qMo+rLfJvHtSLzwMVOfGhSW88JFQp2QZOMnRbUfFTdVbAdIQZedJ7QhPhyzsPoghYzVn868u4Y/RgH1YmlamFvw7xoJLF79pR68VotmiWQoGRyjLS1EULhyOYILE/GYE8G92QbnJqhmzfs8IGMqbfuJS6LH8NtbDVHPX/ugi10UngoPfUC9d3m3IbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4nEbFeTo2vbBK3TSNpjbsrbLJxLn1gxY2/5AA5V08E=;
 b=cT75OyILj3bgfQF0FhqB4vo9SkjxSGf+IBRaVgUafipenBpj/H+Uz/n4WJb/vA88693fsat8k3LlvEqaFeHc/xUbknoQcp+h1ioQ6vHCl5Lr/n/rqu9IUdKuFLLwUaPH6ng//B6w458tkN3lDAsceI8I04N/C8j7neTy5QWM+BPxMQ4pf0tLIrmQOeCuZ17RXYBdaLfC5Z/S4DUeZz0oVJcXfmrf6TCNqMFp485SFKAi7XoB0KGz1z78YQkmlWmitv1uEbyGQojTm+LaLT9D1V4vMYWjTFkEYizi/IdBqRJnefXRojbhaKO8jEE85JuSfiav8mVeXgqQPw3oYFtCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4nEbFeTo2vbBK3TSNpjbsrbLJxLn1gxY2/5AA5V08E=;
 b=ZtvKWGzcgaSDohwohvV6EojmUTv7BpwfRRlqmTdAwLcAWn9fisBOB8qYE2TwAzT1tEtBPAku6vY62pHvfJHDN72n8ezZWhpIMMljbYySvIfg8JJJ3UYwp7UZUcOd2rFA6W6rCLQauTdCMVpBLc/OB0svIbvgXUb0k7SrS/E3d+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM5PR01MB2219.prod.exchangelabs.com (2603:10b6:3:c::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.17; Wed, 21 Sep 2022 19:57:40 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::255d:ca17:cfd8:1838]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::255d:ca17:cfd8:1838%6]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 19:57:39 +0000
Date:   Wed, 21 Sep 2022 12:56:49 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
Subject: Re: [PATCH 1/1] perf/arm-cmn: Add more bits to child node address
 offset field
In-Reply-To: <b341c342-954d-a261-7ebf-df20573fa2fb@arm.com>
Message-ID: <alpine.DEB.2.22.394.2209211248260.2542@ubuntu200401>
References: <20220808195455.79277-1-ilkka@os.amperecomputing.com> <b341c342-954d-a261-7ebf-df20573fa2fb@arm.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:303:b9::35) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DM5PR01MB2219:EE_
X-MS-Office365-Filtering-Correlation-Id: 88724666-dc21-4d16-3bb3-08da9c0b8935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJIOML9g3xlGpfYQh6TPGwHjcaEFpBtsUzWrXa1yUiIZ4NT1ODYonbXZB8rqwtss8/VTltrK5dpifFivKvglyxAlK3JAbN2WOJhOkURAponSLY7twwnMSoQ+rpG9A9e6QFsjEzs/1+S+ak7/BGhVGBkZF1NDAJTdpt+UaCZXT6m6ggygE9pC3ibZYHJmbFvhPwQABWMl5esNypfgkslIQXcDScYvEEEVY7lZ/xATfDcnRD86BpmAQwBiyhPLG7eBI4ZrPp6cpccsT1H1zeun34Z3O711CaZwlrt8EnNxFF+RZ9mHWDxRSoOrK2XdHieHve0eWYAN59ej5bxw4uNz+COfbXyy4gTTP+AwJxH4wQxJIiBtxFeBDT1/MDpHHcsyoxyE3hEcxcaCLtxJIbxtfONxU/lt2UdVxYwx40SKKkFgXfiSRetrd91KFKxAygIvUdna9qcKgMJrBy2UV4w7H6W1MIs6ayj3VxaQ6qZ9LJO8OLLd50UdpxfVcD46BkwZH40l7BBlBEK4T/d+VNFFBBuIdiwr1DgDmdJzXK/NKu+r1mZ/aYEetsEcUHb5wfaTVVbwPg1Bb/SVCbOKCtyO+wtlVb1pVxQyk+5CM9Vheyb85j43N1dwGHwgG1LXlksHAosVoqLmQI1r3audvY00+iQvvZSlWZkF+5gr0bfvHye6dAiaAxEX2PksL9gMoq6izLJvfp33HAfu8GZPj08/iemr9+TlCLCqcGJHTQy8AhY5dYVxKkmP47q/m9657pyT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(136003)(396003)(376002)(346002)(39850400004)(451199015)(5660300002)(110136005)(66946007)(66476007)(54906003)(86362001)(38100700002)(8676002)(66556008)(316002)(38350700002)(4326008)(83380400001)(53546011)(41300700001)(107886003)(6486002)(6506007)(52116002)(478600001)(186003)(9686003)(6512007)(26005)(8936002)(33716001)(6666004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wuvC+5nC3WUZmYfjolISA76aa8UXSpT+unCg8Xfr/nhtXzJopajtnr3O90lR?=
 =?us-ascii?Q?l9RLohYDq0tpTdLv1BOlDLhngtV++HhQGbYIcCZxw64wdPP8tdzHgsG6RCKr?=
 =?us-ascii?Q?UYLHsiAVvf5m0rkdopQ6uH5Sx96yYCgakfX+qfS6rCYZ9wz9d6BjjK4BpsNM?=
 =?us-ascii?Q?lz1c/POmR/XYyLGYLobzCiawqeLcImHEhqMXDfAiv/aOD4mEUuPZuNZ12+r1?=
 =?us-ascii?Q?NIEV99NmFJ+f01PlpkYh8j3dehd8Uah6gUkobIxjQrwbCA8BX17ID/pyIur4?=
 =?us-ascii?Q?DnPdjrQHSgpt11g5KFBsKJUyPy7Dn8WOGZQVWotsP5zS9WKqB3+xYBRvu0sk?=
 =?us-ascii?Q?/l2KuTIji7oyMFcnda9rr8BWnfkvlmqS/0rrxnZf/sK5BmUQtO3H4GHC6s8X?=
 =?us-ascii?Q?cDmEuylIcBshtxyMwc3sJoqf2Rq2p2qteivKnH5k3xmIoKHwHC6E+LoRs2Ft?=
 =?us-ascii?Q?gFEgK1UV7lD0evkYFGpcA7M9NnPTnJGGTipdDpd6+LXqhCmsOWbTZCY6QONx?=
 =?us-ascii?Q?IER9rnFJjeyN7xS+AO05+fOVBnEmkVqCxzjSUajG87MF1FrTbxPWFg4N56KU?=
 =?us-ascii?Q?nRttI58S702snnhBJjEAew4WSCXpVvozsEZKqYfKZfPI2DwYezbdlC5lNhTW?=
 =?us-ascii?Q?0y70tcz+3H/q3ERoxHIn+eDG8WHcfTm6/u2wljUwcvJVdoIpCqz7N7giug3z?=
 =?us-ascii?Q?Puaz7KWlr3Uw5HoPzvP//LyMP2vQFY/+XC6/r9idWUfYLpn9LEVKx1PtKvpl?=
 =?us-ascii?Q?yr5QcnGLO6hk52aaRqXwIf/pOr2am9Y16PlLzV7Q/3sHAQPUZS62re8HQxjj?=
 =?us-ascii?Q?EuNS1fl5yAXmoaJV+W4v2F/tvadAGKIrWaVWkR/i565dQBXnNtYV+/YJwW2M?=
 =?us-ascii?Q?nbjOJ+I7hCCk1PA0O4+L3fO/cosTQWqOm7E876o6dbMBUMPcdwr2y6hxJGag?=
 =?us-ascii?Q?W3GpHAQEKQ+dOx02oybqAJ8dY4ilE1/zjF9h7lAuqqtbzfM7AD7i6dCVlgRQ?=
 =?us-ascii?Q?dfi3CZl54dAx19/KBQBZFb3fyVWSbaF+HsJ7+Kfa9yQmnuxoUi/MKJIfdoFs?=
 =?us-ascii?Q?WuZrXuZnsscSzYcoft+dNypvpdOb8SmjRwQENWI9f1PDBRM3B8GJuC5kpgA8?=
 =?us-ascii?Q?EQ9BKSpII1LYPunEG26SAh56pkbZbRMEm9kw2KnHdNYiqPIaS0NlkqlEMOQR?=
 =?us-ascii?Q?3JMg0DHPwJu/D5pry6qFt+42bgTrJEAuTEwx4GneujR37f+FufeOcgeK3lUs?=
 =?us-ascii?Q?CdSyp+H8O9VaNuxWvLCP3Cv7TuaqvUU2AsQqw0Q4wR4NTh6omvkXeOcwWYND?=
 =?us-ascii?Q?H8DnXRdhSnAvO8RzCiwy4UHV8umE7CrbRTaRUL83dKEct/7lB3F+oJvTtemW?=
 =?us-ascii?Q?c+YxE6Uv5gCm9GdZheLvOJDv4xe7SrJGYY85C9TbZXHYihoUtmQ1mEyYnNdy?=
 =?us-ascii?Q?iQHAJ1tjGh8CV6n9MhCo0VjhZyYimmOkzJWByG/zBUIFpqgGRYwT3Q5hv32p?=
 =?us-ascii?Q?EePqB+Ka5izgqnbOI4odH6AOo732Plt5vC7Bn0lGVxY2pl2DdDi6a0/gpYLs?=
 =?us-ascii?Q?9dFdq5GplE6uS2J62aNoWkosysxaFloyIzuOtp9N0FzXfhVIsa8KNAs35GQo?=
 =?us-ascii?Q?FnE9ohvfpLG0S1kxLuqY7XU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88724666-dc21-4d16-3bb3-08da9c0b8935
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 19:57:39.1730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZU4LTmSHnGSrSmo4FnDJmBANm6pgV92XjDapE/hCdN3x6TeveeFWeTSlPF+sJi+HIwO5bHX9dK54q8Ekp1+UA0yIrXtr0/h7ML0WrX1yKByw+AY9HU8qBg5iwNvGKRG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2219
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, 21 Sep 2022, Robin Murphy wrote:
> On 08/08/2022 8:54 pm, Ilkka Koskinen wrote:
>> CMN-600 uses bits [27:0] for child node address offset while bits [30:28]
>> are required to be zero.
>> 
>> For CMN-650, the child node address offset field has been increased
>> to include bits [29:0] while leaving only bit 30 set to zero.
>> 
>> Let's include the missing two bits and assume older implementations
>> comply with the spec and set bits [29:28] to 0.
>
> Just to add that other users have run into this as well, so getting it 
> applied as a fix would be just lovely. Technically I think it's:
>
> Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")

Ah, that's true. Should I resend the patch with your reviewed-by and the 
fixes lines?

Cheers, Ilkka


>
> Cheers,
> Robin.
>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>> 
>> I have tested this patch on CMN-600 and CMN-650.
>> 
>> drivers/perf/arm-cmn.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 80d8309652a4..b80a9b74662b 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -36,7 +36,7 @@
>>   #define CMN_CI_CHILD_COUNT		GENMASK_ULL(15, 0)
>>   #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
>>   -#define CMN_CHILD_NODE_ADDR		GENMASK(27, 0)
>> +#define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
>>   #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
>>     #define CMN_MAX_DIMENSION		12
>
