Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BC76071EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJUISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJUISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:18:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEEC1CFC59
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyb5ylcGBOnZH3wNFgxSZn9VqOea4kVudY5y9Q8JaXb1Wwy3XIeyLAmsgT6AqPenuJZRuOy3Bbwvt/RoAl0gBOqqSY9FCRIZatB5SI/bqsAJRVqlThaUtPBq/ITZE+5eAWAwAqK2bIlEcNt1qg6HYkYxZNZCUTNDyLysrMqeJ35++J40j1GDqwjphFTfDDiZsFjcGOwVyiRIqbtvgxBHSUlkSYMEmBSxuPu/AazKFy/2qgTibKsffjyy0R0FspTP12wtvhHNq/r6pexJPtFRjTJJeDiSlC9QCudar/ps+j0DnT8iWmB3TRp8nIuHJ2au3m4tOaJjKVHG0jQgi4VndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkB0SaIYpEfZlGgqtS/pMegojur4xh8uP/+SZifdlho=;
 b=DA433eYMRjf99p5+0j8Q7sbEKT6lytCmPd1cqaINfhU2QSQpu+qPcN4ocMlPdgXzvtfhTM26+vn9/V7v4paK4iAH6GCeuiSQKbybcfazUQIdcWNv7c7HW0szjJBLAdg7wZqWY13z48U09ZbsPf/ldBGgOyAXday6cG/2y/j+hPB2340SJSjbZZbp0dt9UhptlexWPyaG7Nm2OgOahUXrEAXTVvIGz63AuSLxBzib/E8USSvXVISQztExHBMoIiNJ+dUy/cLkrYEOefxQIeBe/GVbpGBa4nPK8qpzHVkGxYWJRSHVzvRVUacJDvdyTD3mWoWHTMRIZa8GYxSgrBNvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkB0SaIYpEfZlGgqtS/pMegojur4xh8uP/+SZifdlho=;
 b=A9e6AlMkSeTumGdcCg7pHzfRSDPWuSYhVoUdqxq9mhvxnlDX+1Lem8NHSuTlNoXZAlElSJcOiphi7frzoWfuFw3nKM3fLy1C7gh7xdJmwRiPL/KVucsDqC/hBafdYpDq8DLcnsZRkUlp1CkNewSl49AvywtvWAWdt7c/2QHJn0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 08:18:31 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:18:31 +0000
Message-ID: <6df8844d-7f0c-17ac-96a4-beb981f2267c@amd.com>
Date:   Fri, 21 Oct 2022 04:18:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 01/11] kset: fix documentation for kset_register()
Content-Language: en-CA
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org,
        gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, somlo@cmu.edu, mst@redhat.com,
        jaegeuk@kernel.org, chao@kernel.org, hsiangkao@linux.alibaba.com,
        huangjianan@oppo.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, akpm@linux-foundation.org,
        alexander.deucher@amd.com, richard@nod.at, liushixin2@huawei.com
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <20221021022102.2231464-2-yangyingliang@huawei.com>
 <eb0f1459-7980-4a7b-58f9-652eeccc357e@amd.com>
 <10d887c4-7db0-8958-f661-bd52e6c8b4af@huawei.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <10d887c4-7db0-8958-f661-bd52e6c8b4af@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::14) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7b54cb-d425-45e8-ab5f-08dab33cd6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD3KQODHBHgFP5XuIWflS4PseeV+NArxVUgRBtNqBKDkMcGfve50kesBkyq8ZfyNhUUS30QzTIt652iUCYgwW9R6vFbcQrSuCdvWt10UjJdyaOIcB1b2KurUUk4+yITaFmMA6/L73mkhkk4S9HfO8Q12YvOcij6prmU08PhssYH0f5lEoT7ltjX41zWxsq3r6q1gbvMvbvlqLm/ZgkrJ98XLEsdVNZRPzLsgRdHT/EOdPnHG4H3H6e/v798qe9SZvNu45utYhZaPpJx44BWUXvpS8Juppo+rz9Zb7nM59u4UwPpF3XESTa739/bg4ngZuUA5cM4cKOsL9QvkQAujsPhSbtf3ww5VPMfxgkDzBgAiCoNzcfb9ig6dZp5YyFuas2Pm4bnsNKQxILUy9zfxmwi9BTaNRTUb3mjxGenEqV6agTNLbdG4yG9bt6i85XALUFtkTL0DUqLSsjiDQQkBlOYAkoPSCNEy5c1n6gD1UuJ5tnf4LMDVJzFATsxUCvuz3ZtDRLRldBECj6vKnUDJ76fTv06MGC3KoTse9SuqrfVNAyWLjno9eWSCo449n9RPvhNPofltCAUSQ2w/z/jFqybtwZBLcweabL0NdSoV8KYYlJcDL00Bnr4gZpZF70BZUxe9qWw/Uw7m0XUJZTZIuvBDNDIjTVMNPC0QKB3hu2T/bmK6uLFUQkSiAes1HE4qejq6FxVI8+NBMIDsFW7m5iXGz2ajKciCIrFbNVUQ4iYVZwd7u/cEY9Rtk7758PxarpmgVWnkv+dysK6rmOXRCfGPxWYIh80GedYZa4vyDcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(6486002)(31686004)(478600001)(316002)(6512007)(44832011)(38100700002)(31696002)(7416002)(66556008)(86362001)(4326008)(66946007)(66476007)(6666004)(8676002)(26005)(186003)(6506007)(2616005)(36756003)(5660300002)(8936002)(2906002)(4001150100001)(53546011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjhVd3dPVlZRdnVSSHRXSzZWWEV5ajFpTm54ZkNQVHRiUWhzQ3RpOHM0dTMx?=
 =?utf-8?B?b2xNYU03UlNHbkFjc3RoR1JuNnJHc01EWWxOQXJOd0Q1d2RydzFkUWRHd0Vo?=
 =?utf-8?B?ZTNzU0dHcE5sN2tVWWxmOFhDaFdjNWhZU3E4VjNvSkcydGhSOWtFVENZZXhE?=
 =?utf-8?B?TXF1SWFXZGZHWHZYZi9jcDRwSmZ0K2VZQ3l3eVEyQlNwekFpanI1ODA3RW53?=
 =?utf-8?B?OGJWU0ZvM3JIZWZ4aElsU01DKzhMVENwUjI1bWY5czNoQm5nSytqMHlOaEdO?=
 =?utf-8?B?RWFseWljK3owZUhEc0xJUjB0cVJYdmx2SVEwNnUzbTl3RzhZM0toWFFIWi9S?=
 =?utf-8?B?aEtqR2lOVGtROW92U3kwVkdtSk1oN3R6NzAvVzdFWUZrTjVHMjk4aktJcU5R?=
 =?utf-8?B?dUJsMWVrYXZGRVdWQVF6UjVLaEp1RExMZy9IMy9SUHBuZTVaTXdmMXNDZ1ht?=
 =?utf-8?B?RFBhU0pYYlU4NG1hYnhXMHZucVduZVNjNmJFNUlJRHN0R1RBbDc0RStmR0dy?=
 =?utf-8?B?MFoxb3dkL0g5YlVDOHZkMW1HMFFhN1MrMnpmdU1qTmdkRlVDRXhKWEJZb3Jr?=
 =?utf-8?B?cjRKMlNJMWFLc09hZjFxdnFib3pFODU2OG9KQTJWa3dRNUlLcytpOC9FU2hu?=
 =?utf-8?B?Z2pxQTNyUExuTUZWOFhGc1hyMS9Ec2xRZDJwOW8wZ1dhc3U5clQ2K0xtd2Vj?=
 =?utf-8?B?cFQ4aml0ejFESmtIWjd4cHphcWFOeEJpYld3NDFtVzliSUw0MzR0cS90RmFC?=
 =?utf-8?B?Mm1qcU94V1JaNGc3bG1aK3ZjUlBkalhRMUQ1SW4yN2xZUTk5ODM0eWRrbkpR?=
 =?utf-8?B?aGNjbHJKNDg3VXZHZThsaTF6cUJ1UURlWktobGRCV0h4L05WZ2xHcGxHZGJC?=
 =?utf-8?B?Skdad0JmVVlrTFBCOXZnVHR4WHpaRktXLzFiYVRNaUVIWFJZMlo5Q1hhQWRN?=
 =?utf-8?B?aTNUNTFrcFo4czNMN3lML0VNbmxxQmFjRndpdVc0NXFkU240eU9nNUtVeklx?=
 =?utf-8?B?bGhQTUJkSStIcTdBU1c3ZU4wR3ZwdlA3aGsraXJFRWtTS3h3NDVMUHhYdW1S?=
 =?utf-8?B?UkNpbmZHYWgwMjdOQ3JJU0hoMmdkUmJ3bkdLSng1QnMyRU8zZ0N2WWhRcktL?=
 =?utf-8?B?RzBMcldXYVNEdWh4N2NUMmhTc0s5N1FiN255Y2xMZTYwcDZCejduaHBvZzVn?=
 =?utf-8?B?Y2d3c2lNbE9kdlR4V21LOWpCMS91OC8xcHdNYTMzbHp6STJGZy80T3Jzd3di?=
 =?utf-8?B?U2lKcEZTSGo3anNlY25Jb05HK2lIdzR1WGttZ3FqdnFMamN4c0pmTTlRaWJi?=
 =?utf-8?B?RktwUVdqaGMweThoL2dQYWRBMG1DSVRUMUJQRkdvelRkSEhNQTluZEJWR3FH?=
 =?utf-8?B?LzNoaTF2OTd4QjIxYy9BdDQrL2pxT3MzTjBXYTJic0pZa2tKRTdHdk5lMEdM?=
 =?utf-8?B?R3NkcHFNSlFneXVjQ0lVeGh4SnJvU0w0VlV1NTFNd0xBd1dZWExEbStYb3VU?=
 =?utf-8?B?WFVyTUhJWTVaaDcrcmJKRS8welNwYVBoSTQ5cUV6OXBCZHNiQlB1L2UyV0dP?=
 =?utf-8?B?b2ZQLzk2WStaREVDOE1ZbU5QZnBCZUswT2RVYjZwYzdPS0ZJVXYyVE1UTTR0?=
 =?utf-8?B?dE9pZGNwNkxPVHZoMzNrRXByNm5pN0NTM3ZJT0YvYjdSVDhTVWJLSUJFdUVo?=
 =?utf-8?B?WmwwclZxUE5Eem0wcWszVEdLOWlVVnI5eUhxc3lzbGtSMGNWTWRQdWJMYTNF?=
 =?utf-8?B?SDVuem5yMXd3TDk2MTltQ1Y0U1dIQ284RTRycjZCL3VTeEdvNEgrcm5FcHRG?=
 =?utf-8?B?TkNsNjc1eW5nMW1KM0kzOVNSb2lrSjBXN1FFMFVyMDZqYnpxZnZNZysyWG1m?=
 =?utf-8?B?WGd4VHpLNnZmemJrdWdnU2grY29FWlpOQnRwbEdPeHJHbE85Rml1Y2xFTUxk?=
 =?utf-8?B?SFhHTFlkSTZPanV3MGtTVVFuS1Q1enBCa0ZMa3czSktKVk9yN21ONUdWbi9h?=
 =?utf-8?B?aXpzUXAwSmFFSElNVUdPc200U3d5bkl3ZWh5NlFFdjk5UnkxZlBkczBoVklY?=
 =?utf-8?B?YVRVcmhvQlgyS0orN2IzUW1yY1pSN3EralVsa0dkcCtmTUhSV0hlR3p6M0l5?=
 =?utf-8?Q?aX0sKoisM1HyhTe6XUw6h0ay7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7b54cb-d425-45e8-ab5f-08dab33cd6d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 08:18:31.3717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0uiX/Ae9F9KwkgoreHoI+KihDJnNSA8ByabpG4+sZmBGt91ozKLSLVLoz39X7xL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-21 04:05, Yang Yingliang wrote:
> 
> On 2022/10/21 13:34, Luben Tuikov wrote:
>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>> kset_register() is currently used in some places without calling
>>> kset_put() in error path, because the callers think it should be
>>> kset internal thing to do, but the driver core can not know what
>>> caller doing with that memory at times. The memory could be freed
>>> both in kset_put() and error path of caller, if it is called in
>>> kset_register().
>>>
>>> So make the function documentation more explicit about calling
>>> kset_put() in the error path of caller.
>>>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>>   lib/kobject.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/lib/kobject.c b/lib/kobject.c
>>> index a0b2dbfcfa23..6da04353d974 100644
>>> --- a/lib/kobject.c
>>> +++ b/lib/kobject.c
>>> @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
>>>   /**
>>>    * kset_register() - Initialize and add a kset.
>>>    * @k: kset.
>>> + *
>>> + * If this function returns an error, kset_put() must be called to
>>> + * properly clean up the memory associated with the object.
>>>    */
>> And I'd continue the sentence, with " ... with the object,
>> for instance the memory for the kset.kobj.name when kobj_set_name(&kset.kobj, format, ...)
>> was called before calling kset_register()."
> kobject_cleanup() not only frees name, but aslo calls ->release() to 
> free another resources.

Yes, it does. For this reason I said "for instance..." I didn't want to include
this in case in the future if the code changes, the comment would be wrong. IOW,
I wanted to add the minimalist comment possible.

>>
>> This makes it clear what we want to make sure is freed, in case of an early error
>> from kset_register().
> 
> How about like this:
> 
> If this function returns an error, kset_put() must be called to clean up the name of
> kset object and other memory associated with the object.

It's bit too wordy and redundant with what else it does--this can be gleaned
from the code. I'd say:

	On error, kset_put() should be called to clean up at least kset.kobj.name allocated
	by kobj_set_name(&kset.kobj, format, ...).

This tells the reader the symmetry of the calls: kobj_set_name() --> kset_register() --> kset_put();
Because if the code evolves to use other means of allocation, or if the the user allocates a name
by different means, then they'll understand what to watch out for.

Regards,
Luben

> 
>>
>> Regards,
>> Luben
>>
>>>   int kset_register(struct kset *k)
>>>   {
>> .
