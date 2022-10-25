Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02DE60C1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiJYCyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiJYCx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:53:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5491211D9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXABH+xc7pAFvC0238xMgcdn9t/F1UW74ZX5ttHyBMQhcc/kD9jRZYLmDol1HD6d7NkmA+JaSGBIFX9wmC0fI3v/+idQmabED5RphTaf3LSgy7ZTzUgUoRJUF+LAAqK0J6ztEhuSVkFBU39td7DqOD9+izIzss3clh3aUHiM8hIfaugce122rCzZLMoIo4Eff6PNQKFM64BTU1FGX9MeVI4MxbkxJJi3Zq07YNksukyL+PVUNmluEYEJGoJCV/dhYwwYUEyWlraWG9OBS0yfbp8s9yl0H1HlLcK/fxROCeS+fSgwLxhdFwTMiWjR7KuziutjXoBHqEZGhBPNMWDbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7NBY9ipv5YwqEHDXRYBVzed/xLjTDkOqX4rE6JdQyw=;
 b=MT7gvdcye8Wyx2tuawiVJ9UdYfe5LrkX2aejCTjof+7YVaSbpl+EQyck6nZ0hczEdJ1wP1J2zH8tOEflrUri9j2OF10FX5bJ7o5d1KCDMqVtat0qqoSIBTBGovn+UQ1e0tF+jRsrIqAL9G8OBKXI+Utd9JjFQclJqrYeNjinsUuoz8xXAGBRcshYcP6z4JzItP4GTsjYxhOi27tETwTLOwWImBXZDJxZMZkT3Nj1f97AiwVmWl+XooYYava0tAXNUr038jQ9zMA06on31lYA5jjSZ/4HjmuE9zxKL2VkBQChlEvRhQTzJ6EuHGAueSD4n52zcYZ3Z0mEckLbuKZALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7NBY9ipv5YwqEHDXRYBVzed/xLjTDkOqX4rE6JdQyw=;
 b=Se5QShH56qEXMODLTBZgP5G19uOIB5/YHiu21fa6RwGHUbtaX3K63ucU0rndZ4NK/V6S7TxeesfHQ73xn5zsIT6rZ8bHLWzbUoh21oHOr0mj2P+9/zt9XF0ADSL9ZK8Lzxb6HdCBxlY2Zh3VmsAJqbZDbKkBtzIhXHxo6iBeaM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 02:53:54 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5746.026; Tue, 25 Oct 2022
 02:53:54 +0000
Message-ID: <aca964ca-c9de-4d86-0e95-254575db4315@amd.com>
Date:   Mon, 24 Oct 2022 22:53:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] kset: fix memory leak when kset_register() returns
 error
Content-Language: en-CA
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, somlo@cmu.edu,
        mst@redhat.com, jaegeuk@kernel.org, chao@kernel.org,
        hsiangkao@linux.alibaba.com, huangjianan@oppo.com, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        akpm@linux-foundation.org, alexander.deucher@amd.com,
        richard@nod.at, liushixin2@huawei.com
References: <20221024121910.1169801-1-yangyingliang@huawei.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221024121910.1169801-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::22) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BL1PR12MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: ba67d978-a8bf-4431-21c8-08dab634277c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rg4JmRzCyskyoj1/Jgb4MVeT306WDkjZEU5luFQJ/CcvIjAAOUZ06o8RM++2KlL+nD9MfIslBcJrlydoa812RLwLq/NA78q9cqKRqAuQ2tAsgn03CZe89sIC0AZnnZ9DinmaYsnAlRx+N01lbHOAnpc85l/QO6SBiTY1UYVnTXywu/spP9YkMr9PCp8gBvDLlMiYmvoXqqQkWcVsdMBbpOOoGnIyVxyC8A7spI6pRSFMehcWSprM8VnG7n2odLQSVGfd1z0zcJh4PYgJqTflH0PmDit6+HyvlZpnLPzIf7YTNleP+Z/tJsYIG5nlmTtpOhlxMaAYZds4Om0pmaDgoTicmy23v3+V0XKD98r0WG1Hchp/aSPrWWuk54KZx4PI2zeK2M21BqY1rGGFvRB8J4E9JPANSADouL63T+jo+roexHvF0Pn1cTawi/pY+sNtxvfta8toCkIcT1S51CJBHD6yat+IwDP8KBsmpkCOz3QxWiw+DYGw1PFHrabpeVIJ6JWTFny0sFscRmHtgQPk+EdOgrhCzh/y5Qf5BOSwJksHBSsyAHqzlSlTi5zMXKF38rP4Wu+7fEqUkYwqbQSxzzYznBx6YoSHN9mN4HJ6KdOds2AfLv3lyAysdJ56wdRvRKn7gyLPexSBXV62300Z+LTJhr785LNaZiwlPvYjbb8iRFBoqBWIGe954rmnsqfZ2xA1EHjJZJxXBlxJWsZI3KZSuGaywO69Ch/jwxY7QAu6x/++JA0HGVsEC/4ISMWU54F/4u7qZUlTfigpPyv6/up4+nZMYAi98U4qe2haOyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(6666004)(66556008)(6506007)(66476007)(4326008)(66946007)(7416002)(6512007)(8936002)(36756003)(53546011)(5660300002)(26005)(8676002)(41300700001)(316002)(86362001)(83380400001)(4001150100001)(31696002)(2906002)(38100700002)(44832011)(186003)(2616005)(478600001)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDAzZG5lYy9hdVNvVmpSQk1xQmdtK0dDTFl4Y25wS1QydUh1aHZFalZwRVZ4?=
 =?utf-8?B?ZEJ0U0gvV2ZWanhDUFlPVDF1TDRzd01XVVNCd0tQeUQ4d21FbWpJWmx3WlMx?=
 =?utf-8?B?elhGN3lNR2JNUkdYUlJ2Y0ZjN3FENkJaSXRMMlgvVVlJNTRBTllFd1FSS2hD?=
 =?utf-8?B?VnBScnNSR0xHbVdmTVVKcGNwV1pQQXk4aWRFQTZkN0FuRTRmdmw4bXRaNXJl?=
 =?utf-8?B?azZRRFUxd0hXSlQvOTVRbHZWMlBhVnVSZGZmTWFGNTkzVXFLbmtIM0F6MzE0?=
 =?utf-8?B?djlNZ2RhRzVrVDBDMEtHTGVaOHJ5S1JZU0VIMytjQTVkaWljcWVBcmNGc0Nw?=
 =?utf-8?B?VEhqT3Z5VmVpTkdyTlN4d3YxL25iSnJxYVNLM1ZPbWpvVGFxVktDaUFZcmJn?=
 =?utf-8?B?Qno5bmtwUlR4MjlIQjNWOTJZdjBqZmFmODdCaERKeXpNZEdTaDBteGIvNmNt?=
 =?utf-8?B?V3QvQUtLUmVhV3p6OFBXNWVTTUEzNTBIa2FRdVpZSlEwdVAxZlJJMDJQbmNq?=
 =?utf-8?B?djgya1FQbHNTNkUvQTJaVGxnanU4ak1ZN1NjZENvWlBwaFdJZVFnODRCN3By?=
 =?utf-8?B?SlJLVmNzNStKcFBwSjQrZjlybWJCTzVRWmFxc25YL0lwa2xEYTB5aFZjK21w?=
 =?utf-8?B?dWlvMG9nSENhM2xjSTh5SEtTeFhrbUxRNEg2cndmUDhjeGZ3VmlNc3p3Rk1Z?=
 =?utf-8?B?ckJyZnR3K2gzUUx2QzJtZGd4U0xqaHAyaEhQRGVvSU5UaUlldXNGMlovTVJW?=
 =?utf-8?B?RGY0UGpIcmMvMnNNMWJNZkg4RGN3dnJwMHkvb0c0cWJ4cFBtS3Jkd29JYXla?=
 =?utf-8?B?aEloOEM5N01jSm9HeFZHV3NKMEFSOEN2ZDcyNDdFT3JLano3UlpSaGZBcnIr?=
 =?utf-8?B?V3JDQlpkZ0IyN28rMnliUUZURzFubXUxc2sycFhkbVZqYVVHUFNkTTA0VmRQ?=
 =?utf-8?B?b2pUWWFYVnRuTnJXcEJlQ0xNVUJmSk41blBnU0RkRCtFWGJ1RjhPaXJBZCs0?=
 =?utf-8?B?NzdFd3ZGZHVEVk1TTFNLVDlFYUk0anlRSitnSjRVcVFJaUlGY2RaMitEanda?=
 =?utf-8?B?aVNBOTdlcVRvR2JPMFFoTkZJRnRtWmdKeXNoV3lTYzFLZ1ltZ01nb2dyRUJm?=
 =?utf-8?B?WDIzSE9CVnJSZ25PMEtLNFk2cXc4Wlp0d0FaZlByWCtHVlE5YmdnUFFVakhE?=
 =?utf-8?B?dzhyNkRMZnJkZ0VFeG5wenNEaVpaUUxZTUs5WFZUdGFUTlM0bThUZ2MrcmNG?=
 =?utf-8?B?RXNiRzRxT0NPQkRkYWkveTJ6RjQwU1Z4TkptYnoyRy9YUWxwTUVraUoxeXFv?=
 =?utf-8?B?bWxpYjE3eXpMOFV5OCs5ai9OQzZ1WEF1RGNwejlkTHFzOWEzNmJOaC9oWEl6?=
 =?utf-8?B?MS9BRFNNRjRmUFZKd0k0cUl5TVJNTW5oR2t5VVNoUVNteVlMak9ITkZWb0tN?=
 =?utf-8?B?cGlINDVQTU1uT3MrZE4rQ0xld00rb2tkaUtHUTN6d1hCNHJjTnRraTVzb0xp?=
 =?utf-8?B?ZEtkTmRDVTF3NWxLZDhDQnpsME1rM0M3MktzdjNkODBiOGozaXRzWUZtS3F4?=
 =?utf-8?B?ejF2ajNBL3ZKZzUrdVo2NFp2YzBlVVJ5Sll3WDZuay9qS2pDRldqSWlCby9V?=
 =?utf-8?B?elZQSjZxOTBxVTZBSDJmNkJRSXAwNWlGM2swRnFhRSsycElCYjF5L1A5V1hF?=
 =?utf-8?B?Z0dpcFNDYUF0alI1Zk42L2FlZWhneDFLditidGpPWm05Z20zTWp5MzFLZmtS?=
 =?utf-8?B?UHNLclhMMGdVOEVrR3ZJNkNqanV3cmRreHFMUzlFdVRPMDZxOVRrOEdKQUF4?=
 =?utf-8?B?bDBRZEMwNEJHazVUdkZVVEQwaGhrN1g0cVBFcXJTQXVnR293cmhLU1hwV3hm?=
 =?utf-8?B?YlgvSzVWQXFrWHlzNW9oUTZCck5SYnJiOWFOYmlBaHUvYXlnMmVRc3p0NXFO?=
 =?utf-8?B?OGc2S2JhSnh6UFFnM3JhKytpWktyeTF1ZUoxOHRhY2dqUWg2d3E1UTdiUitj?=
 =?utf-8?B?dktSQ05HMGJnNDdwMWhWTGNLL0duVVB0WVhhWVdjQVlHc0tTNnF2UnR0elRC?=
 =?utf-8?B?Q0tIcWt2SUlJZnhMZlNjZ0w2V1Q5REJrNTUzdzZ6RVZzQ2lQc2syQmFDTzNi?=
 =?utf-8?Q?yMu762TROlWcMlxBwPUQkPCz6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba67d978-a8bf-4431-21c8-08dab634277c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 02:53:54.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udfwo2j2L0kUkGGo78kdRh16ERRTKwA6ahabLxoGBnT90KiWFGofDioJlAkMsb63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-24 08:19, Yang Yingliang wrote:
> Inject fault while loading module, kset_register() may fail.
> If it fails, the name allocated by kobject_set_name() which
> is called before kset_register() is leaked, because refcount
> of kobject is hold in kset_init().
> 
> As a kset may be embedded in a larger structure which needs
> be freed in release() function or error path in callers, we
> can not call kset_put() in kset_register(), or it will cause
> double free, so just call kfree_const() to free the name and
> set it to NULL.
> 
> With this fix, the callers don't need to care about the name
> freeing and call an extra kset_put() if kset_register() fails.
> 
> Suggested-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>   Free name inside of kset_register() instead of calling kset_put()
>   in drivers.
> ---
>  lib/kobject.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index a0b2dbfcfa23..3409a89c81e5 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -834,6 +834,9 @@ EXPORT_SYMBOL_GPL(kobj_sysfs_ops);
>  /**
>   * kset_register() - Initialize and add a kset.
>   * @k: kset.
> + *
> + * NOTE: On error, the kset.kobj.name allocated by() kobj_set_name()
> + * which is called before kset_register() in caller need be freed.
>   */

The "need be freed" is confusing here because it is not clear if the user
needs to do this or if it is done by the code. Since it is the latter,
it should read "_is_ freed". Like this (no "NOTE"):

"On error, the kset.kobj.name allocated by kobj_set_name(),
 which must be called before kset_register() is called, is freed
 by this function."

Regards,
Luben

>  int kset_register(struct kset *k)
>  {
> @@ -844,8 +847,11 @@ int kset_register(struct kset *k)
>  
>  	kset_init(k);
>  	err = kobject_add_internal(&k->kobj);
> -	if (err)
> +	if (err) {
> +		kfree_const(k->kobj.name);
> +		k->kobj.name = NULL;
>  		return err;
> +	}
>  	kobject_uevent(&k->kobj, KOBJ_ADD);
>  	return 0;
>  }

