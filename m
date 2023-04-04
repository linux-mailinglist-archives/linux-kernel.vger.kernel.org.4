Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E976D5879
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjDDGMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjDDGMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:12:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB720198A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG4Tq7aEDhT/wGcJIYuEKsrDELGVx9vVwBuk3LPiTe3OENktc58Jr0KtZxkbVUldDP44BiklTuC3Sps9fFub3jObjLLcnZWHSxPy6/YeBC+QHpMLGQTuWlM58aF6ROAqXf9Dc515UIPyNJTZjg77RpG+TkXRzy/8ADkTtd67sChhvVUGylpQ9H8mWIcNlElb/ZmKmvrJiejRukVRfTxhNccISQH1eApgreCpXLJdl/WwAG0S4Y94dxyC1gazwUtbIDEJ4y9UeWJn1T1XN1XUxMNMxXMG8YwH8F2r7Q/Tt73vAFhjFOmJmud6c0yhZFw/Rb05Oas8fiKi3Q5G1kZ3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZoZDWVs5CuQvmzKVMMDP3Dy6+nnCq75HLxjnCrBTQc=;
 b=JFkMk+iGv7Lj6ZEbBXwnkq/kic09VceMmrl8Gg2yNIEFwUx/DkC6wvc6oP9p037Jm4yLnB7m62vPDYdFV3/KZ3F5GIzQrAa5XHvYPvvOUaTDKFa8teC9Bj8RliKqQVyROUx8impLrLY5Aych78ouTrOwnDcY4jA+He5At/otycVpOTW85OEW2xWtwG3ULQTCSc1eo+VeiynrSYaK3AblDDP3SDcT1MGQF/CoXkGOYbUm+7pp9EwwcY6KNteJf5ru/rFglJ2szwEEYjpD7yNXg4JKhT/KYQHqKKxxsBJ12MHwkMKdBGlwDEY+iPIcpe8j8osCYmudX/yBaROeWOoFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZoZDWVs5CuQvmzKVMMDP3Dy6+nnCq75HLxjnCrBTQc=;
 b=WTw3UgW3guXgG+bwiCWJoVY/5oSl6YQUFD0AmGeP+FwN1E5cEl0nr0nlm7485r3NrFS+YOuteBaKSpNvwy8POluiOYu4eq9/bPqRZ7zAbJD3i/F7gEOErVjAJu3I2ae7lVasLtNXus3w0nhm/iv+60i4hmawTo7av6PjfBfQqxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM8PR01MB6965.prod.exchangelabs.com (2603:10b6:8:16::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.27; Tue, 4 Apr 2023 06:12:32 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4ac8:7982:7ee7:cdb2]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4ac8:7982:7ee7:cdb2%4]) with mapi id 15.20.6254.020; Tue, 4 Apr 2023
 06:12:32 +0000
Date:   Mon, 3 Apr 2023 23:12:27 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: Re: [PATCH] perf/arm-cmn: Fix port detection for CMN-700
In-Reply-To: <d2e7837e-a7b0-6fa6-6eee-9ccf487b4f49@arm.com>
Message-ID: <71ba24b8-8855-ecdb-a5fd-60a5248edf52@os.amperecomputing.com>
References: <68ff05869f6dae06a92c5d320e535d8a2f75a0cd.1680522619.git.robin.murphy@arm.com> <d2e7837e-a7b0-6fa6-6eee-9ccf487b4f49@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:610:50::40) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DM8PR01MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea08ebd-a863-40d1-9b0c-08db34d393ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2Q3Y75c8Sb9dtu6AJOkk//BX+KRi/5+LID1Yq2XTZlMuMui2niBFtDYlE0A2OJA8CI3lLl2QUjO3WC1uINfz5TKP+BZVqZ82i8fQSI59QgWHQrbyyKng/LIGMBGJqcK0ZX0On+xFE7/hOVdz/v5wVWwiGqGeTs1lxTh1Hy1Jh1aq1Zs/Tv3dS1hexcFI0SmWGYYX3maCsmWsLYgfZJjkZ23DZoCSvL9D6BDjq2wmUAAC9LmdpYUGmpWWItfXw6QEiSUoHg/4/QFZNhNJartnPRoIhi1X3qxea8teRkOSY8tlci/O6ibzYzaQRB99glkXleOLDoyQkxiZOSS0Co8R4zXOQQhTtKaInt4m53z6ncM1xvgTvhDSb3RqvckhnoTCvumKYqpQvE7Ww4IIr49kbqBeqvtJZdRpY1F74LBMjK4vhi9OwlpGxv5dwkqfJII3QsgDdduqtZDnOTGtcftewrHd0Swu6Trfnt2yLoFHuroR1NDROGLVQzijipdTxx6afCDX8dmrV0uJDEmf+AV8KUkOq4exsfAO+IjLxd2NDEz/ODNJ9+wXE0Lv/5g25nHuqHVTEindsqvntWShu3mYBwiANZX9URr7W9vDsWZwA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39850400004)(346002)(396003)(376002)(451199021)(31686004)(66899021)(2906002)(38350700002)(38100700002)(5660300002)(66476007)(66556008)(66946007)(8936002)(41300700001)(4326008)(8676002)(6916009)(316002)(2616005)(83380400001)(31696002)(53546011)(966005)(86362001)(186003)(478600001)(6512007)(26005)(6666004)(6506007)(6486002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H6bM7WtkUgC3PuYV1JyElhmpiu1MbZuqL+mW3yXlsfwta4kdH52lOreGR1Rg?=
 =?us-ascii?Q?ENFp9VRfiy2gvTBo4Scm09qTXA2fosdHmPnUM+VikpBcVjWW+vm33giM5zyH?=
 =?us-ascii?Q?rAx4MKhjGmi83ynjK7fGlg4d6oszjVmkIaJcS3CppVrhdvYKeJZCNuF1aNli?=
 =?us-ascii?Q?WTrc0Z33egrAkwOUnJn4ooKK+uHFMW4bxegkSoHdguTMjbWBwEnGqsJYUpw9?=
 =?us-ascii?Q?KE7re2XokB1mLUNmGKF3pS9Mn4rbnkUaCEmXO5hoe8PcJhFmXmEiTO/vc7G6?=
 =?us-ascii?Q?zZP5MB0lgnkNMYUV+oPEC2ZOjpQ6aG5gLI3vb9V1XsjiyxQ9snHrKicRMqqq?=
 =?us-ascii?Q?BuGeG+t8DuWjYG394arjRO37k+AlmOc5Kegs9wjBvoASVAbO1+r3GcoISJ04?=
 =?us-ascii?Q?bCVTXh+z0d40ywTR3JgvJ42J4Ez414kq9LpIRAQl8RcYH6vPJbBPWxdJyNwZ?=
 =?us-ascii?Q?XvZ0XqpvDGMCwmlOHowdpF5RTtdvvUHeu69r1bqT23tTD9vJ/Nz5p9RLKDxG?=
 =?us-ascii?Q?hL57UwggLsjgqNt4DgsOXVf+CoAMA4lLCtXEWtHLNveEKE8HubDDKimmyzNA?=
 =?us-ascii?Q?s7ZPXCB0EKU91mfc7WvEIgPyxvwNl6Pf8grmrIWvHm3Gln/pBFOouUV96Gfc?=
 =?us-ascii?Q?px1AMtOWz1/l4kNpEB9LRuVwP63gauOrx1ygM23UCbFytjuDBkzkZQVHZMC9?=
 =?us-ascii?Q?FTvHC15UZxflaKBMu91Ll6uyjIdX5cpz0IU/2l32pRG0Qt46lbRVdydUhjs5?=
 =?us-ascii?Q?UeafWYpoPT+J65qT6/eygvdFIZaTpQyoVeK25aokIjn2NSr1+loMYCIyaGWj?=
 =?us-ascii?Q?RIV84rMSuzgqXSKY8eaoQgP51litJSDphZAM76YhxVwkei+X4L6y3DcjIuOA?=
 =?us-ascii?Q?fQU94Wb16r7uZNJ94hq/5ji6kfEJDsXFz2E0v7CL6m2ttuO70flE3gF5Q+2t?=
 =?us-ascii?Q?N/Q47wIlRH/R/3YPktmLz3qS3Le+8c4gIm3xA2/ZdKNbxbdD7JvFsc+j5QQH?=
 =?us-ascii?Q?8u4Fr+vpxQjpXFQXV+3yYmiee7cts0PlGso7J3BcBgKdT05klN0CLUZIqwCQ?=
 =?us-ascii?Q?W0DCZul0Y6EMvjyg/90VA1W6oOlRW4qP4BAfDimC8WkZ0pc/pyr9F384H5gQ?=
 =?us-ascii?Q?yl9XP9qnWl3VDcyZ89VQIEXwSicfnKCovuqVaRa5DGXnmZqJlhQI/zbEmvkQ?=
 =?us-ascii?Q?pYA+Hh/Kco5LjVSjMK4bBjMpVzNYZBAavuqf74y/ZTRJwhynV3eCKNojJf9Q?=
 =?us-ascii?Q?YyoGXU7I+X51yzS6vLN+F6BBcSfFaT2aB7O8sC0bEnF8ExJQJ5+rM/s35mFo?=
 =?us-ascii?Q?Mpzger3wmBd59fH8SgnR/tTU+6D+WJ5VpAUzEl1t2SQwM3Y05PP2XCMJvPPo?=
 =?us-ascii?Q?zTrtdlYlM0edXeG42QMHKIEMA0mFvPzVzYBUnTbYfLsyQhalmdY1u+o7CyFi?=
 =?us-ascii?Q?oRmFD+aVm4+Mrs/w6/wkD+1A2pbgzJHYyxsGg+0Gw9Q+Dkd/ep3pIS7QHJW3?=
 =?us-ascii?Q?CgEHJyyGxRBGfkGLDo9uYAcs0B5ufjnulCCKxyKFnbfMiN4KrUv3kFIySXw9?=
 =?us-ascii?Q?PLMeQh7ZnFF+Pyoh0JenGe100ZwdefO+Diw6NRFSY1mesV1CXfnAxatmaE1p?=
 =?us-ascii?Q?B1JnPqIKfi6q5yfCc73uWN4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea08ebd-a863-40d1-9b0c-08db34d393ae
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 06:12:32.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2+CyB0b7M8XUBuHQF+MHKeoxbBpJD2gN3mCS5Er36eXwWlwIxsqDqsHjiTtKyos4uwnZm+e38SLTV/wVF8yNGILwKoVLGj6YEUHWf2n4Xxbzaj7rbcXpjK46w2ticXT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6965
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Robin,

On Mon, 3 Apr 2023, Robin Murphy wrote:
> On 2023-04-03 12:50, Robin Murphy wrote:
>> When the "extra device ports" configuration was first added, the
>> additional mxp_device_port_connect_info registers were added around the
>> existing mxp_mesh_port_connect_info registers. What I missed about
>> CMN-700 is that it shuffled them around to remove this discontinuity.
>> As such, tweak the definitions and factor out a helper for reading these
>> registers so we can deal with this discrepancy easily, which does at
>> least allow nicely tidying up the callsites. With this we can then also
>> do the nice thing and skip accesses completely rather than relying on
>> RES0 behaviour where we know the extra registers aren't defined.
>> 
>> Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
>> Reported-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/perf/arm-cmn.c | 55 ++++++++++++++++++++++--------------------
>>   1 file changed, 29 insertions(+), 26 deletions(-)
>> 
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index c9689861be3f..367d41c5d983 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -57,14 +57,12 @@
>>   #define CMN_INFO_REQ_VC_NUM		GENMASK_ULL(1, 0)
>>     /* XPs also have some local topology info which has uses too */
>> -#define CMN_MXP__CONNECT_INFO_P0	0x0008
>> -#define CMN_MXP__CONNECT_INFO_P1	0x0010
>> -#define CMN_MXP__CONNECT_INFO_P2	0x0028
>> -#define CMN_MXP__CONNECT_INFO_P3	0x0030
>> -#define CMN_MXP__CONNECT_INFO_P4	0x0038
>> -#define CMN_MXP__CONNECT_INFO_P5	0x0040
>> +#define CMN_MXP__CONNECT_INFO(p)	(0x0008 + 8 * (p))
>>   #define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(4, 0)
>>   +#define CMN_MAX_PORTS			6
>> +#define CI700_CONNECT_INFO_P2_5_OFFSET	0x20
>
> ...which of course should be 0x10 for the way the code below ended up, sigh. 
> I'll wait for any further review before resending.
>
> Cheers,
> Robin.

I quickly checked cmn650, cmn700, ci700 TRMs and the change looks good to 
me. I also tested the patch briefly on cmn650 and it was working fine just 
like I expected.

Cheers, Ilkka

>> +
>>   /* PMU registers occupy the 3rd 4KB page of each node's region */
>>   #define CMN_PMU_OFFSET			0x2000
>>   @@ -396,6 +394,25 @@ static struct arm_cmn_node *arm_cmn_node(const 
>> struct arm_cmn *cmn,
>>   	return NULL;
>>   }
>>   +static u32 arm_cmn_device_connect_info(const struct arm_cmn *cmn,
>> +				       const struct arm_cmn_node *xp, int 
>> port)
>> +{
>> +	int offset = CMN_MXP__CONNECT_INFO(port);
>> +
>> +	if (port >= 2) {
>> +		if (cmn->model & (CMN600 | CMN650))
>> +			return 0;
>> +		/*
>> +		 * CI-700 may have extra ports, but still has the
>> +		 * mesh_port_connect_info registers in the way.
>> +		 */
>> +		if (cmn->model == CI700)
>> +			offset += CI700_CONNECT_INFO_P2_5_OFFSET;
>> +	}
>> +
>> +	return readl_relaxed(xp->pmu_base - CMN_PMU_OFFSET + offset);
>> +}
>> +
>>   static struct dentry *arm_cmn_debugfs;
>>     #ifdef CONFIG_DEBUG_FS
>> @@ -469,7 +486,7 @@ static int arm_cmn_map_show(struct seq_file *s, void 
>> *data)
>>   	y = cmn->mesh_y;
>>   	while (y--) {
>>   		int xp_base = cmn->mesh_x * y;
>> -		u8 port[6][CMN_MAX_DIMENSION];
>> +		u8 port[CMN_MAX_PORTS][CMN_MAX_DIMENSION];
>>     		for (x = 0; x < cmn->mesh_x; x++)
>>   			seq_puts(s, "--------+");
>> @@ -477,14 +494,9 @@ static int arm_cmn_map_show(struct seq_file *s, void 
>> *data)
>>   		seq_printf(s, "\n%d    |", y);
>>   		for (x = 0; x < cmn->mesh_x; x++) {
>>   			struct arm_cmn_node *xp = cmn->xps + xp_base + x;
>> -			void __iomem *base = xp->pmu_base - CMN_PMU_OFFSET;
>>   -			port[0][x] = readl_relaxed(base + 
>> CMN_MXP__CONNECT_INFO_P0);
>> -			port[1][x] = readl_relaxed(base + 
>> CMN_MXP__CONNECT_INFO_P1);
>> -			port[2][x] = readl_relaxed(base + 
>> CMN_MXP__CONNECT_INFO_P2);
>> -			port[3][x] = readl_relaxed(base + 
>> CMN_MXP__CONNECT_INFO_P3);
>> -			port[4][x] = readl_relaxed(base + 
>> CMN_MXP__CONNECT_INFO_P4);
>> -			port[5][x] = readl_relaxed(base + 
>> CMN_MXP__CONNECT_INFO_P5);
>> +			for (p = 0; p < CMN_MAX_PORTS; p++)
>> +				port[p][x] = arm_cmn_device_connect_info(cmn, 
>> xp, p);
>>   			seq_printf(s, " XP #%-2d |", xp_base + x);
>>   		}
>>   @@ -2083,18 +2095,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, 
>> unsigned int rgn_offset)
>>   		 * from this, since in that case we will see at least one XP
>>   		 * with port 2 connected, for the HN-D.
>>   		 */
>> -		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P0))
>> -			xp_ports |= BIT(0);
>> -		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P1))
>> -			xp_ports |= BIT(1);
>> -		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P2))
>> -			xp_ports |= BIT(2);
>> -		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P3))
>> -			xp_ports |= BIT(3);
>> -		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P4))
>> -			xp_ports |= BIT(4);
>> -		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P5))
>> -			xp_ports |= BIT(5);
>> +		for (int p = 0; p < CMN_MAX_PORTS; p++)
>> +			if (arm_cmn_device_connect_info(cmn, xp, p))
>> +				xp_ports |= BIT(p);
>>     		if (cmn->multi_dtm && (xp_ports & 0xc))
>>   			arm_cmn_init_dtm(dtm++, xp, 1);
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
