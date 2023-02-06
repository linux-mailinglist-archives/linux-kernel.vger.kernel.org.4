Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79B668C473
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBFRUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjBFRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:20:20 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1982798D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3Gg3ywx0TT+5BTrqOKkDoA4B8bYFLEJE+8D36ZKd3Z4zR5Z5zaX17fJu+cyND578H2djI9sQM72qGwuYORz9BKifAjlmTVjzEbiA2WrJMcp0pStkd2cqCyDRJuFgsN0//FwdroFqgP0z7aOU8QO+Jkf13QOerFxPd6EljWgOaxo6CPdMYu5S9icLbPoKFooKWI6Q7nhI8msk/pco/s3t/zFFS9v36mzZVGhJ7P53Y9884A6XPgyHuARY9FjWDmnLxT8cMTBB+K3Vkd02axkLujgXz/y2HsYOT9xGeFRagcQbQQ+siEyCCWf2JAQcJ1CAz1MrAWtTTaEfjDMq6jUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU8gviTqw5d9pn5KjdX2hvN3yYQJ/p05QSFnoYnk/Sc=;
 b=SysUC3qb2aGoBimCzSQv17t6Jv3btVz5HErk87ng4ZjltMxyxgNM9swRZiTslaYPNhDhVmz8wfW/KdcjLdH1opJeW9bnQayJYOfO08Is4deRavEHBNMF2V7f8eUUhYQQcuaaqb772Sfb+jt1MBsREx0t/f4LnY2SJABHNI3BdQ7R5wAvFmi3fNmX0v3Xgk7kAc8Lb4G4L3O4yy2ArEyPDkBMWXD+BouaHe1EEs9mYqaUnvqFScJqte/3t01hncXPPfaSgfPQ/s9/9nZezX9ufaPLCLoXQP2uQ7nUA83DfUJfr/+V4Uikz2piC9aX2f4etXO3gQIkBFUnypQQOSttWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU8gviTqw5d9pn5KjdX2hvN3yYQJ/p05QSFnoYnk/Sc=;
 b=r6Iiy1kUFXGmBJdbfEqcJQxts3oiqHfEO+Z3aH3wL4tYy3rrsaEUZ2KsSR9QxyvnQY25ac3HRl5InWegNrCSPA0ixNSWOjFz6iF2dXnReV5MIufEivgVMJuvXR80Neqr0qKyokMM7JeNxEpe6/qfItNy4Vmb9vKZV2m6KcXi44w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 PH7PR01MB7535.prod.exchangelabs.com (2603:10b6:510:1e2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 17:20:09 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d%3]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 17:20:08 +0000
Message-ID: <3a681b82-d840-6ef1-40dd-358f34c8be9c@os.amperecomputing.com>
Date:   Mon, 6 Feb 2023 22:50:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
        joro@8bytes.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
 <Y9z3UG+wEBn4i3G2@myrica>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <Y9z3UG+wEBn4i3G2@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:610:119::20) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|PH7PR01MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd6a98b-6cc0-4e8c-feab-08db0866651b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYH0r44fawqI2QUtSin59tov9ysCEmDTaPHhsBY/aWSCVPUycebvcMARPqKQNKh80O2BP5wx3+atKpLPeh8aDVJKGj+kEX0bc2iVu/TH7kF9nScyN9EIzmjgwUMbROfkU+vEjJiTZMHwZmMkH5R8AG9ThVkZjvJoiKyUot7gp++qgRe6qVAGc8aU5Xtwmey5kWblVDCAnMrc2OnuuAFUODE5pSOzdCRibiPC0zJpyVwqVKwqXjTLTJcK/7Fdy6f6h0a1S3t4HqpRuZ2q4owkYyjZPRHtFPiJFN9KTWIER6ytW7tg8fYPMiPitcCfIbiE3esilpimKrZGRz/hte5a1/Ztnz8O259FtNonLrZrq+7yEWNPB+xapxkvHx7cb6dxpHdZZaibB0n9GauPuJn50ZlUdxdwjFhVt0ijQfI2uZpn3o4LYl5YmmjksfVsdQDEGx1UIeiPHInKGSw0fxLKoemVCFjGA+zVmpRk1Q5jK6eOQK5DGxOPP7IxkW/BqMajG1yUJgjB05wwFtteVeG9AgQI8lvnV6uuOpoCKt6aukhpZ8yDb2NOoEgQ8n3JRaTG6VHI2wLhYQngddzLr9brlHTi7Dxk7RCa1nCZmjZw1QKKDGsljXcI7vILyfDCSAWyV63dvS7as/w5iY902iwUwADQu0kLVyHC3ZEMcPID2lGFBF55GdW3vxINPwclS6NwEHSkkV0wAdkLO8wNrcGUTDonv70s1EbhfythXPYlae8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39850400004)(396003)(376002)(136003)(451199018)(31686004)(6486002)(478600001)(966005)(316002)(2906002)(38100700002)(86362001)(31696002)(53546011)(66476007)(2616005)(6666004)(66556008)(6916009)(83380400001)(8676002)(4326008)(107886003)(8936002)(41300700001)(5660300002)(66946007)(6506007)(26005)(186003)(6512007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1paTGttN05neFpIR1lwcjlsNkVTekhPbjZUSzFLVlJ6RE1KNGxVOTQ3aHdF?=
 =?utf-8?B?V1E2UEl5QWZ2OFh1TTVxQjB3ajZYdVNXaWdkVWwrdGRtSFcvZFlZejhFMkg0?=
 =?utf-8?B?L0NhRFdScWJXZHkvLzZQYmxaWUJWd2lRd3AyUHd4M2JLbWNsMnluT0FlQS9s?=
 =?utf-8?B?NllEU01jWUNrVHZQMUJhSkE2T1NicDNRc2ZWeHFuSWJZakxvQzMvVi9LUTJ3?=
 =?utf-8?B?YnV6NzNRZGo0SWM4VVN2cVhQcVlIK2FqR3pKM3JFaVBuS2dtN1Nwemg3K09Z?=
 =?utf-8?B?cTRtc2F2QW9sTi9Zd3NBUmFFSzNVS09iVHJjb0IvSDdvL1pxU3ByQThreWdv?=
 =?utf-8?B?dmZadC8vNjZGNUJRVkV3WEJGOHJIOStLTG1QRDh3NEtMV0ppNElxYk5ORjVt?=
 =?utf-8?B?Rld1eUs3a2lqeS9NZnp5cVJPdjFFTU04QVlIQnVLZzRvUGZ0anozcjZYKzNG?=
 =?utf-8?B?K2d5VXV4UzNDaGxWYlFPVVplMEQ2NUwzbEp2YWVxY05odlhGMFN1b2ZuU3dV?=
 =?utf-8?B?T3hpcmdVT2xLRklyQXBXa3Rmb1ZtN1l2QXRzSDBoamxVdzk1VXBPWVF5ejlF?=
 =?utf-8?B?UmcvU0xIYkY2dzZuSVNycXJyL3gvWTVMMEVrN0drOWFCelBVdForSDNGZWho?=
 =?utf-8?B?cXlqbm9xWGdEcGZzSUR5TE83YkdnMTVkQVlwQ29UM21pZzgwU29VbW5HNzB6?=
 =?utf-8?B?Z1FST01ldVZsclMxbEE5SHcrWE1aeU92Rldvbm1TaVdQbzdteVlOay9DMStk?=
 =?utf-8?B?SXhzOXQreEc2NzJNUUhySUthWWEzZWJqTFVUaGd3eTJrdnZIK2htckxIaFNo?=
 =?utf-8?B?R2VEeSt4N01IZXFPT1JCczd4SjdJR0pKajdzNWR3aERINHYxR0ZvL2lIQnlz?=
 =?utf-8?B?ejRwRGU4T0JBU2JnRFF3dm9VbWNGK0hWcUJvRVNoZzJNc29YVVV5L0ZrY09l?=
 =?utf-8?B?cnd4WVU3SFBRYXcxY3BTb2Fzb0pWM0hJTWZVNlJ0dzNNNTdiM2wwdk9VVjF5?=
 =?utf-8?B?V0FGSXd5S2hTUEg1bExqZmhOVFhIVnlNaFBwQmR2dkZkNUFEK1p0QU9mMTFB?=
 =?utf-8?B?MWN6d0dFQUZManM4Zk9nZ2lQR25pKzZrWWJrL0Z0eTRLNFVua1ZCSGR2cHRH?=
 =?utf-8?B?cHVYU2ZheXFmSElWcHdVY1dvaU93Y0crQk9mTHlrQ0hhOC9MNTlRRXZBbU5o?=
 =?utf-8?B?K2w0U3g5bndmeWhWdHVHLzJ5UGJrQXR6OFc5SVBJWTA5TWNzWldVNTcrQThs?=
 =?utf-8?B?dERyWXVnMmthb3ZqbG5Cd2xhYlRBZFVlZlRHRUxuNThWN3FyMURoU1grWUts?=
 =?utf-8?B?UW92NEtQWnRSMlpYSW1pc1lXTlBkYjJKRVJJR0pkNE5zMjU5MW5DeUFGT081?=
 =?utf-8?B?V21xZ3ZlUDRvdWx3cmZVSUNHbi9JbHNnM3k5cnNWeGVwQmJkMXJGMDB0SXVv?=
 =?utf-8?B?WCsvdWlsWFhwb2RLSldBeGx5VkRIYktObGVHWXpUL3VXbmtZUWU1Zm9tTTdp?=
 =?utf-8?B?bWtEdFQ2dGZrZ3pPb05QMmoxY2Z6cFJFRXc2RlZ2dVRQdmdFbVdWYit6Yitu?=
 =?utf-8?B?bTVpK1JSVm5xMklMUFdENEFpbk5jUnphWWRyd0RiQnFHQmg4VEpQSElWZmdO?=
 =?utf-8?B?VXJic2dIUGVZcUFHK2V3VGVBTDY0aE5JQkZDRm1IUmtFcXdLVTI4NFlwVng2?=
 =?utf-8?B?UW9FSFVGdzNYcERrcENUYkhyWHFkUyt5dWM0YjZSSXdNdXlibWdvcFFqMElo?=
 =?utf-8?B?aGdTWERhRnJiS3crdXB3aUJvT001c0xsN2hwQWZaRHZnNWNRL2lKaTFiSFZ3?=
 =?utf-8?B?VkVBcUtCYzFOVWIvUXVnWVIyYkhzOXBoOVo0b2NPcFpST015ZTdzVFQxdVVZ?=
 =?utf-8?B?UWlzNmRHcnpzRXBpRWdZZlhBR1NuUWMyQ2h4RnJ1Q2xyRHRFdktKdFpwT0xR?=
 =?utf-8?B?NzBST0QzSWNsSGFRUzZLTGZCVUt5aWFpYVlwTG13T2hid1dHZkFOSFYrc1VO?=
 =?utf-8?B?VCtsa1RiVGNyQWd6bUVTOWtGNDFmSW5qSWtYckk3VWJJZXdENU0yajdCbGJM?=
 =?utf-8?B?WkU4Uk51Uy9PTUR6R3lKTWUyc2xud0tXTWJoQzJ5eHN1MjR0enNOeEtaVFVj?=
 =?utf-8?B?VTBkUlhwL0Y4VzUvOWxCUHpRNmtyaUtaVnMyRnZ4R2VwVmJLV2t1eFRYNHM5?=
 =?utf-8?Q?Hn1e/eavdQRUVw+FchQ9Y104MpLAKUIuXTheafq2xB3v?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd6a98b-6cc0-4e8c-feab-08db0866651b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:20:08.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+cBC5CwSuRMjl2E+RCxySElpfdqKOy0+tV6pFGNJ42vLY+486RAqTaAnSh4w4y/cU+8NHZPMwLvHZvcnHUeMd6kjizLeXVXyhMdmYyGnTmJ29RMuR0PMVmULFS72YBB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7535
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03-02-2023 05:30 pm, Jean-Philippe Brucker wrote:
> On Thu, Feb 02, 2023 at 04:40:53AM -0800, Ganapatrao Kulkarni wrote:
>> The current smmu-v3 driver does not enable PCI ATS for physical functions
>> of ATS capable End Points when booted in smmu bypass mode
>> (iommu.passthrough=1). This will not allow virtual functions to enable
>> ATS(even though EP supports it) while they are attached to a VM using
>> VFIO driver.
>>
>> This patch adds changes to enable ATS support for physical functions
>> in passthrough/bypass mode as well.
> [...]
>> @@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>   
>>   	master->domain = smmu_domain;
>>   
>> -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>> -		master->ats_enabled = arm_smmu_ats_supported(master);
>> +	master->ats_enabled = arm_smmu_ats_supported(master);
> 
> I should have added a comment for this. Only found the reason in an old
> cover letter [1]:
> 
> "When no translation stages are enabled (0b100), ATS Translation Requests
> (and Translated traffic, if SMMU_CR0.ATSCHK == 1) are denied as though
> EATS == 0b00; the actual value of the EATS field is IGNORED. Such a
> Translation Request causes F_BAD_ATS_TREQ and Translated traffic causes
> F_TRANSL_FORBIDDEN."
> 
> (See 3.9.1.1 "Responses to ATS Translation Requests and Translated
> transactions" and 5.2 "Stream Table Entry")
> 
> So I don't think we can enable ATS for bypass domains :/ The PF needs to
> be in translated mode in that case.

Are you intending to say smmu-v3 driver/spec will not support ATS to a 
VF, if it's PF is in bypass?

> 
> I can send a patch adding the comment next cycle.

I am more keen to know, how we enable ATS to a VF of ATS capable EP when 
it's PF is in bypass?
or it is mandatory to have a PF also translated? then that should be 
captured somewhere in documentation.


> 
> Thanks,
> Jean
> 
> [1] https://lore.kernel.org/linux-iommu/20190409165245.26500-1-jean-philippe.brucker@arm.com/
> 

Thanks,
Ganapat
