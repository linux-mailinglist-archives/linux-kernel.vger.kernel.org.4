Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A318640EC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiLBTtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiLBTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:49:09 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2122.outbound.protection.outlook.com [40.107.7.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFFEF142F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:49:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHTvH+aI/7aXBOxNb5a35/B1Iw7DmTQELVfGWEKVeCQUBOQqOHCK6XVioSZk7x5PT/ZCCc+Mh4xQAl6trRI4JDxwQTztZmT8/YIRZvcKXv2ARf5wM8vvcoYIsMia0Hcv7CWs0Ph67/EHjR4AU1bv9qq5dsC/pxAJSHxeKnccVP24yw2pSm+xHNWa0KBrQT3ugnXPgfW3MDKY96u5+Qx1epZYaekmkAcEIVZIiOw0jbkA3nBHuQMeu7vXamNjoKor2tfPbjMxrmExdWVZPLAobhbgByvbbNpAPl9LFLmuVc9XmImZc0c00kd4JS9I4dBCif9YmRLhVbyQKpuBgrqxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyGMYbEDJbNyvD/a4jN32i/bs5k6AOQsJlurA/JnGVY=;
 b=FdKEDiGCAkQwKVHTqiCi5+PjBXziHvpxObwaneRER8kOmXGkJchlwN8IpUTQf62oGmLm1YQ0UeK4w8ramzvfl1gUyXkMzIOJ5pdvaPbdnB9XRdfr4WuOVMqRZKc7gdj9/PMBnFB2qLD0MZ8chUCcUbicBy+8MrUTanE1SK4IXt3z02CGmIGripiIUbqqTX2rv0pmOx57T8CKZo0VDvuuD9J9xy0+dpxtQueZLi7EmbLM6qLWPV1VTHTZsQTD93pQrAePKSV2bPfK9Xn+L9+ITWerwSJhSa5GsCvPZz21fQch00aXgD0XHz8697kj1loJviP8j6U9mlL4hwobS9jETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyGMYbEDJbNyvD/a4jN32i/bs5k6AOQsJlurA/JnGVY=;
 b=Z3YvPZhELrfBLlPXweqNdpTVCh18ydiiJszX5LicuQ0v2FLPMR7JM1HGCCxmramZrpZwhAwQGrVPHOLAXpINZlSW5f8rA+FJcFrJyybE26trD/InO8wvvS+l3Cz7Xmn+lYI+Q3CNclLNvO8U2FrYadpDw+6I+cf8IXKbU7jC9lyWJPHNl5bYXu54YpjOttd9Q0oQcWGpPHTuNVDNW38jY28Jl9y/Xl+0g3UGsBqYGZfSUco5akZYe3I5Gjx5/8PFqIFKTzT68d2MA3NE45+BELcK2exQVKUdA8elpXgBNWVUr0EkKSGqEIw3k7wINn8NTLoWIwOu2vBT3ESOLG7D2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by PA4PR08MB6286.eurprd08.prod.outlook.com (2603:10a6:102:f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 19:49:04 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::f313:6bb7:8c6b:f8b]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::f313:6bb7:8c6b:f8b%4]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 19:49:04 +0000
Message-ID: <e676694f-6f6e-661d-d776-75d357ba510d@virtuozzo.com>
Date:   Fri, 2 Dec 2022 21:49:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] devtmpfs: move NULLing the thread pointer before
 unregistering fs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org
References: <20221202124502.217462-1-alexander.atanasov@virtuozzo.com>
 <Y4ogFSOaQtZ+5Xqy@kroah.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <Y4ogFSOaQtZ+5Xqy@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0302CA0024.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::34) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|PA4PR08MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: a3db7642-0e09-4818-5542-08dad49e4466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xA7htoYjnpxV6NDTiTx411A4kryDOAhDahZvjhcFUAhsMga1+fgZ2iybri7H4vNMgXK+wZaRP0NMhsfCvJ94zMQQSJN77Xj2AuY0TH+T9Ty5www6rVftzmX022wChgXgvMgtUH89mx1Sun5Sr3/CunjFDwXhHuG+BnmqFM5kN09XszQfyRrzML2WVMywN0vyTUr95IWQtxbDvLmyPFylb4MnKMAV/GEfAxUJlHcezbNu7VvQNpfCIyrX7UCKlM5hDgQ/gUdJpz5bmtJmN6bnFFAowkUENBCZq7H8e1K85MzTCpm302YppPmb3lzZG+7sKq9wh6jykgO5TOgX8sigrrtt3sl3JBEri/0BfM3jQvoiaZQLxjdScIFEVx0Gj7/M7sGUZxzxeEilG7nnh7P40WyBn9WWwzgKgMYPgITxwl2slS74zKqaMkD0nW4CJwm6GoFN5nBzxjDlNZaY/Upp34Vy2uAuYKoX+Ykx/+FKOfwsny2cuNHW8ge0ZwNDbnHM+6Zr4qY1DaNbxfkjVAwFg6FifMfIoXwEu8TdapHnvJuO4zhcrT0N/oOa2M/XrETLpS9pcU+NZBsw4dgtSPXP69DheGNTQQF4u9HbRzlk/YxVEgziBq7x1LD2C1OGvVhFQV8ziQvRMabIEo5i7JHDk71/ptoGgxgwcjwjeQyEt0SIi8Fr10fsv1d289aq1b8vWEgMyRYF9ywHfW7+ZXfeAO0bmL8zwVTvy7ExHM8Uo3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(346002)(396003)(376002)(366004)(136003)(451199015)(31686004)(36756003)(6916009)(86362001)(31696002)(41300700001)(4326008)(8676002)(316002)(66946007)(66476007)(66556008)(83380400001)(478600001)(26005)(38100700002)(5660300002)(8936002)(2906002)(44832011)(186003)(6512007)(6506007)(53546011)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFR3bm9aYi9rL2J0K1FYeWZzRlhXckhXMXBuWnFHR0NGaVU5aUhGSjZ2eldZ?=
 =?utf-8?B?ZGxzejE3M2ZaOW5JdFdhc2FKVVlka0toRjVlUHR4NjByOGlnc1pScTN0SnZ3?=
 =?utf-8?B?b1Nzb0ZiaXRNU2p0aHBGeTFaUlZKN1F2Tm51VkR2cS9Ud3hLangzQzlNbVkz?=
 =?utf-8?B?Q1NlS05RWEdrNFhpZUtub29RTTJ3TkZRVzFxR1dBSnh6T3VpVlI1amxtRlh3?=
 =?utf-8?B?d040aWZYQWhEWHdWYVVnZGlvRGkrT3BUOHErVHptKy9qQzdzb016UjQ0U2Yy?=
 =?utf-8?B?WTR4eWhQL1ZOWGNWZ2MwZlNDbW10VEF1SENYNWd6YXEvTGl0eHZtVk1TdFNz?=
 =?utf-8?B?K1VLVS9wb3I5cC9qNWtjc1lYMnZxd3Q0cS9GbjdMVjdiNzlPdW9VdGppRWxz?=
 =?utf-8?B?NndYRFFJTkZLUTdHb2Y0aFJqbzFLL1JvaWVaWU4reGltSjFwNGp5dE1RdUZi?=
 =?utf-8?B?dVpFUENkN1RScFE5Rk1mTThWeVJtTzNlV2tCTU5VWU84ZEUzQzJ6VW95UWxM?=
 =?utf-8?B?S3FxUEdiUGZTTGtnM1lxajFmVnJHaFBtS2VNM2JZV2FkMnNhb2JpRk5yMFVu?=
 =?utf-8?B?eXVWZExXRi9ZUUhGZDlnSmdMQXpHS3hVclh0WXFQL0d2VU1YMWxHdnJ0TXlm?=
 =?utf-8?B?bWtZSlJEa2dKa0R3bmhMd3hmUk9LM3VZRlZidXRsbHVuTU12d3lZWnVOU3VE?=
 =?utf-8?B?TlVlTnFPVVFTRkNNNFJ3aUJoK2tNeFZRWWtwK0s4S05QcFdhUnlSSFcvOEVI?=
 =?utf-8?B?a0c2YnBLUXo3dWxYeCs5MVdCTGQrZzRXd3pxTXA0aFZjdHVleFliUkxRbWNQ?=
 =?utf-8?B?aldQTDdkS3cwTjFKSDY3L0gyNU9XMXVqNXRVTGZML2ZSMENWZ1JicGZiSHN5?=
 =?utf-8?B?aTVNMkV4cTJGUVE2UmhkakF2VERmV2FkYkJ5OUdhZ21CWDE1OTNpb0JZb1ps?=
 =?utf-8?B?Q3ZubUJ4VUlyVzlRdE1DK2tPSWl6SEZkUFMyenkwQ1hJOTBQaS8wZjFPd2hR?=
 =?utf-8?B?QUxmWTJJd2MwY2Y3bk0rb0RLMTM5V0dVenZjYy85QWh3VUM3cTdNcldBZHY5?=
 =?utf-8?B?c21yYXdXc3dId0NzSHBLS1pSbEZsVDJvRm81NmVXMmQvZC9nYnRXMUJvaHZh?=
 =?utf-8?B?QmFDNUdPOVI1RGVuNllOS1dGK0g4c2dHcmEwKytOSG84aUgwaFkvRGJxVUJ3?=
 =?utf-8?B?VkZ3MnJZRkxacnp6SUt0L0lJQnE5bm9wdzVyeUJCMGY5clFRZ3g1YlpWbThL?=
 =?utf-8?B?UlB6Vk5ZLzREYmNOVzhZY01ZaDNkeGZTOUl0YUoxR0hQcnBZRWQyMnVQaldt?=
 =?utf-8?B?TGh3dHVpeTZDWTF0Zk5RbXBadnBBYmZha0JtNHRuYzF3dHdrYnVRVHMrMnVP?=
 =?utf-8?B?Q3hIb1EwUE1pd0QyelR3QUpCdThOK3JZZUVlenFuNHdRRElRWlUxNUNwNHFK?=
 =?utf-8?B?U2J4LzJUUnNwNW1ucmxRb2hQQ2QxR1M2RlFVdWZJSFpYNXZEQkJFaE5XTktq?=
 =?utf-8?B?MlUzamZBQzdscnlpV2RTQ05pTlJsbG8vOHVVb1NRT252d1U2cko2SUxRcFhF?=
 =?utf-8?B?dXJzdWlyMmEzK3M5RkUyMG9LU2oyeUtTVkxwUmNvU2ZRbXNmY3k4L3NBcXAr?=
 =?utf-8?B?UnlIOWhWcGZSQ1puVE42dHduM21CWWRDRGgzMUoxTEZ1cTdDMFV4THRDRU9w?=
 =?utf-8?B?S3Y1RXQxN3FpK2RrU2x1ZFpuOUhDWTdyK1pFSWxuaEtkelp4UHVsZDZRcktp?=
 =?utf-8?B?N0ZtQmdTOWRIaWNVNWVDRzB5VTYwT0tVSzJudTdsN2VPTHR2czF3MFBnaHJ1?=
 =?utf-8?B?TVJTMkxIa3pMV01ZUFBjQmJldlcxTFVKeFZTS3dmbld2U1hUb1k4c2FZRElP?=
 =?utf-8?B?eklDR2o3NVJ3cUNvU2d0YU1KRGw0TE5BU1BTenQ4SWlabnFxSGNPenpqMDVt?=
 =?utf-8?B?TDExSm1OT0k0WDVwc3RTTy9pRUpmbkRpemVXY2dsYmV6ODVhcE9MSSt4N0t5?=
 =?utf-8?B?ZEMwd0JmRmlOL3lyemZwR0VWV0h3QjM4dTk0b01nanFYaWR5MEF4WVhxR0li?=
 =?utf-8?B?UGxyZXpJN1U3WkZwZTdaVUpacmxHWWFzaWduMGh4K1lscUVkYjdyZmtjakV4?=
 =?utf-8?B?MDJRMnpRejlTdG5vbndYZzNsSys3V01VSHh2ZkZnVU9sYTVBNnBoYUZlbU9w?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3db7642-0e09-4818-5542-08dad49e4466
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 19:49:04.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUlqvNWknWmPa92xjMiJWwAjaOmtLPkVMWrezKpUuLCzBqB0J86gcd2Y6iB9t037IPe6bDl/scDD+9EdHCtnJ/Q/03FeE2N2x8YTMXreVBr0lnJCtjyrvSx87qLodevG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6286
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.12.22 17:56, Greg Kroah-Hartman wrote:
> On Fri, Dec 02, 2022 at 02:45:01PM +0200, Alexander Atanasov wrote:
>> In commit
>> 31c779f293b3 ("devtmpfs: fix the dangling pointer of global devtmpfsd thread")
>> a dangling pointer on an error condition was fixed. But the fix
>> left the dangling pointer during unregister_filesystem and printk calls.
> 
> And how could it be used there?

I don't said it can be used there - they might trigger events that get 
back to it.

> 
>> Improve the fix to clear the pointer before unregistration to close
>> the window  where the dangling pointer can be potentially used.
> 
> Again, how can that happen?  And you have an extra ' ' in that line :(

Sorry for the extra ' ' i will check where it came from.

> 
>> Make it clear the pointer at only one place in the function.
>>
>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>> ---
>>   drivers/base/devtmpfs.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
>> index e4bffeabf344..773e66ef5642 100644
>> --- a/drivers/base/devtmpfs.c
>> +++ b/drivers/base/devtmpfs.c
>> @@ -472,17 +472,15 @@ int __init devtmpfs_init(void)
>>   	}
>>   
>>   	thread = kthread_run(devtmpfsd, &err, "kdevtmpfs");
>> -	if (!IS_ERR(thread)) {
>> +	if (!IS_ERR(thread))
>>   		wait_for_completion(&setup_done);
>> -	} else {
>> +	else
>>   		err = PTR_ERR(thread);
>> -		thread = NULL;
>> -	}
>>   
>>   	if (err) {
>> +		thread = NULL;
>>   		printk(KERN_ERR "devtmpfs: unable to create devtmpfs %i\n", err);
>>   		unregister_filesystem(&dev_fs_type);
>> -		thread = NULL;
>>   		return err;
>>   	}
> 
> This all feels wrong and way too complex to have to clean up from a call
> to kthread_run().  Are you sure this is the correct way to do this?

Agree on this but this is the code as it is.

> And how was this "issue" found?  How does the call to kthread_run() ever
> fail for you?

I was after something else and this stuck into my eye:
....
         thread = kthread_run(devtmpfsd, &err, "kdevtmpfs");
         if (!IS_ERR(thread)) {
                 wait_for_completion(&setup_done);
         } else {
                 err = PTR_ERR(thread);
                 thread = NULL;
         }

         if (err) {
                 printk(KERN_ERR "devtmpfs: unable to create devtmpfs 
%i\n", err);
                 unregister_filesystem(&dev_fs_type);
                 thread = NULL;
                 return err;
         }
....

Why do we do thread = NULL twice ? One time before unregistration, one 
time after unregistration.

So if it is going to handle the error the same way as the kthread_run 
error (original) then when the thread completes with error we must do 
the same. And do it one time.

...
         thread = kthread_run(devtmpfsd, &err, "kdevtmpfs");
         if (!IS_ERR(thread))
                 wait_for_completion(&setup_done);
         else
                 err = PTR_ERR(thread);

         if (err) {
                 thread = NULL;
                 printk(KERN_ERR "devtmpfs: unable to create devtmpfs 
%i\n", err);
                 unregister_filesystem(&dev_fs_type);
                 return err;
         }
...

Which is more readable ?

I guess  I should have put this as the commit message.

-- 
Regards,
Alexander Atanasov

