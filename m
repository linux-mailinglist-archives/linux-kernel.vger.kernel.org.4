Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92923738F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjFUTF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjFUTFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:05:54 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2122.outbound.protection.outlook.com [40.107.100.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1F4F1;
        Wed, 21 Jun 2023 12:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTY5MZ2hsOF5DErRmgBIuxCmvjM6ft61yJs6XZi0s0DjWHWW0HRDmE/vkt9rqFMyLCwQSf9ucA+of5uoPJNeChC34ACNPVEWPGHFX34Eh8c9gNefOQmGU8pSeZBPrP5JojEJH58vDOx+uUgeBf4UjkBl9LWnqlr4H8FAtpEob9cJV4oPCwMeebMSRuxigVm7cwwDTmi7baIsPfKNCM1XZqn3eptJVGsqZfoBLsLOIe3Xo84g56ye+yL7rZ10ICZbWH0jjJeDWQ2c8dtzQNTpaLsbdNBp0Fw4Yv9EITqGpCHNLpf922XwaAUhiFmG8HCB8axhtOCPK9bwjQ5cgUUsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEouJ7SZ1QSFSA6HULe212d8Bwpr4vMRalccfp19HSw=;
 b=EKdo6SYxxdTuSPlQUfSUP2qgKguN/6It8qaC8HNnljnKPkDWIK8DX4YsnXTBPj2I+WBGuJWkj3oXu48bs2Ab0O844AU4zKmpTAcjlddedv4fxz+WUVrXRBTbfRXI+4n4iFmn/xceRSMOluwaBSDaaF9h656eV4IfxYDkV9o+AqDmgEOeW2ahp0b19W7VTWr4CQWK4SbIHAWRcz5qw/x2pFKI62ToOLjk1v4ANNcSn8kGWA6HwznrYrryaIPYogRrVhk4A+5q+pYlcd6rFcyRefsdniNuHenujvV7jy/Iy7Bh6Tw8xWuc5iAOnmIzN9QMoQv5MyMQ2k0rcnmWTsTtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEouJ7SZ1QSFSA6HULe212d8Bwpr4vMRalccfp19HSw=;
 b=jOe5WAnJBWwBoau4GE8sE4yRpyoDkq3Hyy8Y/7xK6D5c8DaeVkteBf7uRqHCdQZE6tyi0F3xf/Leh9djd0RKObL+obPX73/Z/+jWF2Q8d3lE/pDC+vGfxuTkFJEZNfmUhVU1TIRLcUHx9uXcyT9bnU2TqV6RT4httOBK0kBn1nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BN0PR01MB7150.prod.exchangelabs.com (2603:10b6:408:155::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Wed, 21 Jun 2023 19:05:50 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 19:05:50 +0000
Date:   Wed, 21 Jun 2023 12:05:26 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit
 writes
In-Reply-To: <SJ0PR12MB567659A4B500A2E3FD004452A05CA@SJ0PR12MB5676.namprd12.prod.outlook.com>
Message-ID: <903ad734-461-c181-9633-3ff29715cc0@os.amperecomputing.com>
References: <20230607083139.3498788-1-ilkka@os.amperecomputing.com> <20230607083139.3498788-2-ilkka@os.amperecomputing.com> <SJ0PR12MB567659A4B500A2E3FD004452A05CA@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:610:5b::39) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BN0PR01MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fdc531-807d-4e4e-291e-08db728a870a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRok34fQYvHWmJQzVPrE+VHjfmvbOoxGt2HDczhIKOMQHi5x+xG4SOJSD+yQmtjqUFWp1UPL9HUMZ+ronkshScTcufZg51eTPSY5eUhk6SW9HwfusWfz9AC4rizMFLiopPnzvZAsUDskkBHcrYkNXGOEbmm77gOeYrtsJHSjIn05XIsxOCzxRxP4JZMhyBghIhjdZFqLndgK9p1rPv/1fE6+XTZb9/nP8GtD+OiRKYq+KtBHSdjHzRVOMIzFXakVwH6fgVTihzMsDqYkOrmZFo5RRzC6+tu5v2vx8PEztitdfgNt2z1xmoDJ81ufRHPrWFZGPaIsT4OdaMp2sA//C4BswFbkb0gaUBJAgdxRV0uAjj1kW+pKmOO2RkHUiL/7oaBk2O4UWSRzBGPAScKCGIDbzMaGFPRrMJE/iw2MPLP5jhfZqFE3lg0+PeabEI/JKlXwqHJrVorhBiAZl0dH6E51qUzOrdyWqx5+VIfoMiYHaGs9FvDMuLTU0FUHuvh0iCILpBH7F/qvZtXscLuc+QZpT7mi2MpoY7afljQUWNe6x56Hxv6xbRkbvVSv/TY41fBQDPBJPuolsoTIFZ9j39nw4UEypreEHF8BPKcVz0Z2ILJRBHBUAGi+b529jqtc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39850400004)(136003)(366004)(396003)(451199021)(83380400001)(2906002)(316002)(186003)(66556008)(6666004)(66476007)(6512007)(6916009)(66946007)(4326008)(54906003)(2616005)(26005)(478600001)(6506007)(8936002)(5660300002)(6486002)(41300700001)(8676002)(53546011)(38350700002)(38100700002)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SfSvI044t2a4fnzl3h27z/DpWgl/Z9+xy4HoQwKEilxwKE1BvJbyTe99rH+i?=
 =?us-ascii?Q?VFv9tR9k79WSeDZx5nddXJNNj7kg4+aah+Au3YHpowdO5ndWBuunklz9EZ7A?=
 =?us-ascii?Q?6Fw874dqfFh7Dr/68MXOmj1LVOhdoysJwf5CNk8J+G5G67zzX2zX44heaRrD?=
 =?us-ascii?Q?KHW993KHD1xtZZ29Ec6zoYFclyp494WsYsqS0dl83RzZlyFQgYhYAsOIIuHP?=
 =?us-ascii?Q?pPIshsaDh9KY/sf0N+TCESnsmKdHv2pzmqucsP+KWF7jbMw2zG8WE603jzhh?=
 =?us-ascii?Q?LqdQbWt9HIyZX7x8PwdC6yp00Vqyu+XAtWgRidxKyNqwQJRGfajg80h0XbPZ?=
 =?us-ascii?Q?FdglTKn3CSVbIu5zWHfBowms5mmL11PagwXMTSGMrb/RibwxE+S2Ig/IuabW?=
 =?us-ascii?Q?S6YrGnpq85HzP6XRNx+870X5pRgZcoPVhB9afY3dYo2xs6UqoqO+4aYTdvb3?=
 =?us-ascii?Q?s16pgOLIYn4Jm3ApqVuhQMNT49idLuvY88jBLzAn1xXp7x4NosxJPOi56FBX?=
 =?us-ascii?Q?ssOEpMUEwWauCkuVIKtdgpJqXTs3oPkQsPCSBogFCwx6kMeauN0CQg5syJ1b?=
 =?us-ascii?Q?yB7NEd33cSQGxX7cZG2/xx4Uw+O0PDWf+5YHhphVvFVNdXxjWrk+x0UWSNqq?=
 =?us-ascii?Q?kadRH5ZOgte9oFI2Bc6HTHUcDl2B4kinVxhPsB5RCo/1b7HfqfvcxqZSGZnl?=
 =?us-ascii?Q?xWpcLiKP8D7+gCXdB48+6VTHNLcAH4uNMDdNvQXOfaRf5Tcv9vZgNUNuE5NR?=
 =?us-ascii?Q?qTRpDoQK5CFJIqBTOQgvB99FjoecGD/GPCoXs02VjnAXYMXtuLfCH6qeOmf9?=
 =?us-ascii?Q?Hr9K1PVHrAec+6Bjg/ZkFWps6IEQ4IQn5T06FzSs+Ua/IWJONISWWGLdjcRc?=
 =?us-ascii?Q?4hw3W1jHjMos66F9ftoonK3k5E0BJjHh7jJsO0y0bAYTKJkjhkBLc/phG7Fu?=
 =?us-ascii?Q?Z2BnJPucfn+ZLZ/dhDXczqQk6o+so9RYK+SJ8FXhi09oid6R/Da5C7X51Zrd?=
 =?us-ascii?Q?XwQ8PxDZPRddlhA/Qa6NsHk9QD+lrsaVF/RwZHKK/z4KcjYwsqQKIvt/w7Id?=
 =?us-ascii?Q?oH/QyuPzQkrQnkGZ3Z/HWsIte9czEoPyLQG7iTcvztQimV8QjwaLTv1VXmxC?=
 =?us-ascii?Q?RvK5B8HrrQrQChklmKw6CVsQ5nHXjbfoAF036Mfeup2hhGSSI/tfesepclGQ?=
 =?us-ascii?Q?UceNnhs9Fiwn8BcYu/jMlpwXARTeVVgzMl7iJKFUcKsC/Ggfp/gdCJpr9Fds?=
 =?us-ascii?Q?Rox34S7Yr0PwgEgnUS9Fe1u29GCkc15Ze8OwZhANaEDUvbAoajJNUn5qBd06?=
 =?us-ascii?Q?CkuPBLpC8tqzm7hcl9+JmzctoPiIiEb9OOi3OvHiJXcdzbtZqFcS2jbWfp00?=
 =?us-ascii?Q?0UL9Z5ddWYl2oYkT86BBHbeDPMSrIko3srTzNI+PJtf0PuXg0NjNK2BUtNJc?=
 =?us-ascii?Q?N2WZUDGaZ3uKmtU7SvIVgWuFebMmUVEhdiF5g5xKaG5sg2NJyeQrEJ4Vzn/f?=
 =?us-ascii?Q?Xgyppf7yriybkqkwFETYAu0VtuoTiioV91p8rVI6k6Jd3B2A2rORUXdVv1Nd?=
 =?us-ascii?Q?AUHkw3ESAAI8YixWEMfFlPodRDlZF5LnDhzTYvVcj2IvLe6iao3VNBL99fnI?=
 =?us-ascii?Q?TmGYJj+oN9Fbgxs7O2sszIM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fdc531-807d-4e4e-291e-08db728a870a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:05:50.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qAZSbu0wfs7LuZnSbfIX23uj+OY4iK4NDnvvW30/yNBzZe4EQoRgBUkBD9w2lC92KPvPeWRSzSymgngZaKzMy2xfF5n2NgP0oQXvnFBifcK1z58dMzusjSV9LbNf97b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7150
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Besar,

On Tue, 20 Jun 2023, Besar Wicaksono wrote:
>> -----Original Message-----
>> From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Sent: Wednesday, June 7, 2023 3:32 PM
>> To: Jonathan Corbet <corbet@lwn.net>; Will Deacon <will@kernel.org>; Mark
>> Rutland <mark.rutland@arm.com>; Besar Wicaksono
>> <bwicaksono@nvidia.com>; Suzuki K Poulose <suzuki.poulose@arm.com>;
>> Robin Murphy <robin.murphy@arm.com>
>> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Subject: [PATCH v3 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Split the 64-bit register accesses if 64-bit access is not supported
>> by the PMU.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  drivers/perf/arm_cspmu/arm_cspmu.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index a3f1c410b417..f8b4a149eb88 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -702,7 +702,10 @@ static void arm_cspmu_write_counter(struct
>> perf_event *event, u64 val)
>>         if (use_64b_counter_reg(cspmu)) {
>>                 offset = counter_offset(sizeof(u64), event->hw.idx);
>>
>> -               writeq(val, cspmu->base1 + offset);
>> +               if (supports_64bit_atomics(cspmu))
>
> Looks good to me, but this function was recently replaced by
> arm_cspmu::has_atomic_dword. Please rebase the patch.

Sure, I do that.

Cheers, Ilkka

>
> Thanks,
> Besar
>
>> +                       writeq(val, cspmu->base1 + offset);
>> +               else
>> +                       lo_hi_writeq(val, cspmu->base1 + offset);
>>         } else {
>>                 offset = counter_offset(sizeof(u32), event->hw.idx);
>>
>> --
>> 2.40.1
>
>
