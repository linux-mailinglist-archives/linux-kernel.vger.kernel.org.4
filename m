Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946FD612197
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJ2Itv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJ2Itr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:49:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2109.outbound.protection.outlook.com [40.107.93.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278DCB1C6;
        Sat, 29 Oct 2022 01:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuMq9to0xNaXToZ7k8AGdE+sFRz3Ghz2XbTMKjunrlpcOPZmGcOajCT9sbDYokq9z3U9hY0ZVvdGbZrMUHFIb5mvpa3F/XHqVUOk30P4+aOeN5KuZdMO0StbSoS+XHSdjfDR2ycV6DulFhrsENdF2PtQc06zi3V58J6R8JxTXqeiCOkg0DNzBoxa4gniTnMBkyFnTDhM6pCFzggG4e1ST2PLqVayL1mcEhiTOc+U2xzLLWlONIHBX6NIC8dqDEJnanwlJ5gT1TUH3vR3l7x3vKcLtYi9MgtJAkRpLMUjhZroQJS03zU6riJpEz24e0now3swm7NpXcI9Q3s5IXHfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCkws9yxCz2AM+qRNTulhQPu8tvKG5qSwE7VrU5c5jM=;
 b=JngqXEE7fjH4sbO3rK6CbAQDnx2n2Kq0OePniwLHVnpfQu2nh4uGvriUANfrZTUOUd4TGS3gdW3zZNgHiN+cCaKKaVRdae1a4bJO/7PAJea29uevRHA9LZJZQvkWQKDIPRZjOrEohf8kvLFJ36+zZ3EnHkIyiTPlZ9Vr9O+IZV2V4NTAA9xvWeXQ6FYHAXHmYk/lMwDpHYfhCo39yQhRrWBWCkGu2D5cL8+rUda5OTbsFhFp/LReyDqTYo3T0y6Gc7zV0nRMr/gQ2hz2lIUwgsAATCottooPUoGmM6t3jnx98CxJx3U4Jh9GQDxKhX8uOGMNOqQ6T8mgyB+6l1WvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCkws9yxCz2AM+qRNTulhQPu8tvKG5qSwE7VrU5c5jM=;
 b=lQ6gK0q2+Cw/IbVp5InLBMfVr3Uz9MK1Kr+SvcDGOHm9I6ypka7gtzlVfslvIcsYWlP33zWt5R0rWcfHO9inlkWwCojP1RZKnB3tL4zpAReqCzwbzXBCEwHpS1pYGajOjtj4KA+4vvHCFk7GnW1MH2s1B4uUNCoIiXGnjeUuLyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7455.prod.exchangelabs.com (2603:10b6:806:202::11) by
 SN2PR01MB2208.prod.exchangelabs.com (2603:10b6:804:a::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14; Sat, 29 Oct 2022 08:49:42 +0000
Received: from SN4PR01MB7455.prod.exchangelabs.com ([fe80::44c1:e119:56:cd90])
 by SN4PR01MB7455.prod.exchangelabs.com ([fe80::44c1:e119:56:cd90%7]) with
 mapi id 15.20.5769.015; Sat, 29 Oct 2022 08:49:42 +0000
Message-ID: <0ea97349-afad-e0ab-09c7-f61c782555a0@os.amperecomputing.com>
Date:   Sat, 29 Oct 2022 15:49:24 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH -next v2] hwmon: (smpro-hwmon) Improve switch statments in
 smpro_is_visible()
Content-Language: en-CA
To:     Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
References: <20221027231611.3824800-1-nathan@kernel.org>
 <20221028181430.GA2079477@roeck-us.net>
From:   Quan Nguyen <quan@os.amperecomputing.com>
In-Reply-To: <20221028181430.GA2079477@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To SN4PR01MB7455.prod.exchangelabs.com
 (2603:10b6:806:202::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7455:EE_|SN2PR01MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: cf73794a-ca7a-498a-3cfa-08dab98a8567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dv361zn9yZq9jqSxvohfZxbBMNjkm8dQRmKs2n1M8cl6V7jRrXfd20q9EV1jpQLmPIQKT+j7y25Vr17HxW0zrzzhhMReLw9dx2ef+8UHGpOid52POvuybvvu0pe51MhbDljKcqv/waCHvY8+IBMchQE7kHbrTtwc4VZTGRxiAKjXI3IFkE9EY4To1jDC2yhlgpiX21Ui6olqDoIzAPN30xQ4I6mlHjfraPsIFHagxi96icEE4izNVsvw0/js47ba+Gmi66JdWWoZ4FeIYWwwmBY9ymNDYuydScbm/wq6o3HBdf4ptnrBC6EXQbq8BiTSeKo1YSQVpZiId8b6+yDqucLpegQgFfRPas197NIbmqPkB9Ex/sDcXF/73mlJtdAt/osl6c9b0Nbr95RNYWs0c8+475WLRHDSG5WkGtrcb1yFgwgy9sicGok6MgVN7RnJnpZdU5qy0j74vt7Srsqwj5dhSdtjkDnlpEOEMuCuiA8cvkiRIcSKr/4UE61pP898C4289zH9kK3coxqT74IF6duq5/C84te+VmYD7l0twRTVguycb33YzGxZVQ7UoJ4t2WOoW5rUTkhYC5573c22F9cCBr0X5+7gqBqeDMIpF6I9tkwPs4sW1xGOz0w/pNZHSXL7052X5tZ+DUuwvlgMUb6/gRNd4PBQahym1CR3YxyieSxvmukNtOMYug78Ui6VJrJ6C01Tlxht1B87jMHpZhew8cBm16eVaHje6FzBOyFf9wZ3q7tcwvBSoJuKQZ3P0dI5AN2dPJSGufqmLX+y29vQEXkR7fTJNXn3Wc1otIoPEy7F2qaILi3VQyfeCuooG/9TEfe7Y0mQxA7lp27RAj+9UhZM3BGm5CK7XuDe2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7455.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39850400004)(136003)(376002)(366004)(451199015)(66556008)(66476007)(2616005)(4326008)(8936002)(186003)(8676002)(478600001)(31696002)(86362001)(316002)(41300700001)(54906003)(38350700002)(38100700002)(110136005)(966005)(83380400001)(2906002)(66946007)(52116002)(53546011)(6506007)(6486002)(26005)(6512007)(5660300002)(6666004)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTgvMk1jTXdobkIzZms0WlJzay9pZjBSNVFseGRZSUVpL2tZM0diVWVIUVNk?=
 =?utf-8?B?Uzg4UzZtWEhiQVVPbVlHMjhEa1V0dWRnQk9Ba1FDMHdhc2xXcitvU0hjQXpK?=
 =?utf-8?B?RW14WFI5dWhwQktBNUJUeFRGeVlIaG5FTVNkZWt4cExvOStlOVpYTTVGb1c5?=
 =?utf-8?B?Y0lBRWNjdVRvUWJGclNxbW1wOThzTGJmUzdyUkkwSXFIRzM2MXNXakg2cjUx?=
 =?utf-8?B?RjhFUUc0OGhVRzQyb2JKbm9mSWFpMytRMUFITDdSSFBNZERmTlFGdXVYbzVa?=
 =?utf-8?B?cytnQ2lwNnVlR1ZEYkFmV1JNKzdjdmw4cUR5aHUrbE54cDB4YmFUQ0JyaFR2?=
 =?utf-8?B?MzBaWmcxQzRheVNCZjdQd241MlVMcDJlOTF2US9wajBkSzhxVTJvMHhUNzJ1?=
 =?utf-8?B?RmVmR3kxcW9wMmFUOGFhcnEzaGJVSDA5NFNBWXpnV1JsUFhPNTN1OE5FYmJI?=
 =?utf-8?B?aFdzVDM5bVc5RzhRNEZ1cHdJYlpWaWUxWitvU04rK3BsdUgwWXBpeTY4Y2hr?=
 =?utf-8?B?QzJ2WVp3a1lvV2N5eDR3aEVBRm42VVZWZXRhUFpIN3B5WmtrcmJIVTFLZEd5?=
 =?utf-8?B?bldNUitQUlBRUURUREx4NkUyWHpQNTBjOUFFMXJOb1p3YVpBYndiK2l2QmI2?=
 =?utf-8?B?aWJlTHVCeEdkZHV3NDZFNlVQaHZPN3hRTTFkRWRDVnFjSzdydVJHeEJWQU9G?=
 =?utf-8?B?aGloUUc2WmgyR0lkOVdtUXUwT1RHYk1PNVVwWlpITG1OdFprRk5ETmlVRWVh?=
 =?utf-8?B?UWx3MHQ2aVg5VzgydmlpYmVDUlZaYUpYV1RtQkpJNHlOTVVaWGdEeEdsTmk1?=
 =?utf-8?B?VENRSnhqSlZURllmc21JL2NZS1JxcFhpT29uS0ViRisyTjBoV3Q1QzJvZjFP?=
 =?utf-8?B?aVc4aVFQVjJnQm42SUl1ZDUveXliNHByN0xXSzg3Z3NuOW9jZlQ5aVliVEp1?=
 =?utf-8?B?WWp0cVhXSitHVXEwemttbXRpTnhWUmNhM0hnSzZ0a3pmTmtOMTZzU2NIY1hp?=
 =?utf-8?B?OUhVOUFpYWdKMG9hN1pqQWcvMlRHcnI0bDNCV2hyWVQ3dUxsRk5iMVJPT0dL?=
 =?utf-8?B?OTY1c3YvWHUrL1VMTHZDcmxOckloY2l1M2VrZis3UFFkaDFKRGloUlVKaCtT?=
 =?utf-8?B?Rkgrc2tSZjN3Z0xZdmNqME9rVVNyK2lqODRlSWN6WUxQdE40dUVTNmgvVzU2?=
 =?utf-8?B?Ynh4R04vL2huOWI1UnVYOVpobW5XT2pueklOOFVPRy9UMzBGNEQrM2V4YWVw?=
 =?utf-8?B?bWJOMTk5QXVxWGRUTzl1YTJwa3ZadXJZYkZCSXFlbTBtSFRma1pxaWhOdFZX?=
 =?utf-8?B?K0JuNWovZUFzd3UrUHo1TGF2MlRwS0k4cnJyS1F5YWNnUGFpSE85T00xeFcx?=
 =?utf-8?B?ZVhFVFVxNnVDRmlQUHBQUFIrZHo5dHJkWWhzelN5WDZpeGo5S3ppTlRtemM2?=
 =?utf-8?B?MmdLb25yNnFCSTFoeitkRGh3UXU2NVVrUVFMckhIMWlzZ2wvM3JaNG9sdFBn?=
 =?utf-8?B?S2o1NE14ekN1amZnNHN1RnljRC9uV1JkNUpWV2V0SnVKMXFJdlVFTThJakdS?=
 =?utf-8?B?Ujk2Ujk0bmp1ZktrS2hBWmRWelhhaWp1eThDOWtSSFB1SHFiRmEwNW8zdkNS?=
 =?utf-8?B?Ris4TEZjV3hwUm82bmNVRlA4ZTdDMkpsRUZVbk0xenIxemtSeTZWeXpNSXRE?=
 =?utf-8?B?V1BjV3JyL2NpRXpqOWhKSVpDTmpwYmo0L1FWOGpjSG5EaWdrTW5zSkNmMDR3?=
 =?utf-8?B?UmZ2SERkU2N4T0ViekRxQ2tIMU5IWU9NTGFYNUxtaXR1bDV3dTJkd3dnbHpX?=
 =?utf-8?B?RXBENEJwRDNOTjBEVTZndFNqUUFuUTZZRmNFWjZaK21xNWVVMTRZSXJpTFlN?=
 =?utf-8?B?MGVuSUFFckxYOEdPVk0zbWEzQ1BCakUrbHh6SEQvK0lvN0w4WjdES1hEWWox?=
 =?utf-8?B?T0V2VU9WZTArL0doeTZ5VjVwRkZsWFBrYStuVEkzRWZOeVk0NEwyOUxPQml2?=
 =?utf-8?B?Zms0OHlrVlFiT0doNVg1WEIrbDY0cmFCWTlzd1ZqUzk0dE84a0lnYlRDN1Qw?=
 =?utf-8?B?RGY0WVE5b0xDNkUxeGNoU2NqU0ozY29uM0owYW5XVkp4WkFRN3I4dUkyb21T?=
 =?utf-8?B?aTM0YmUzY0hWNXhrd3pOcm55NlVCdmdUUmVpVm9qbW5RcWllVVJmaEZLNEV4?=
 =?utf-8?Q?Nm7xfzXsmmJXHf4bpg9hpcA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf73794a-ca7a-498a-3cfa-08dab98a8567
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7455.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2022 08:49:42.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQJEOmV5BnFswUZtxDzkMWZrgQ3JsSScHhRSWOXlFMfoVQjU1jZ2cJw6u1eLDXpeDrhWKX4okXW3Z/SUAFgZcdAHkMVR0GZVIpgmffuzQOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR01MB2208
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Nathan for the fix.
- Quan

On 29/10/2022 01:14, Guenter Roeck wrote:
> On Thu, Oct 27, 2022 at 04:16:12PM -0700, Nathan Chancellor wrote:
>> Clang warns:
>>
>>    drivers/hwmon/smpro-hwmon.c:378:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>>            default:
>>            ^
>>    drivers/hwmon/smpro-hwmon.c:378:2: note: insert 'break;' to avoid fall-through
>>            default:
>>            ^
>>            break;
>>    1 error generated.
>>
>> Clang is a little more pedantic than GCC, which does not warn when
>> falling through to a case that is just break or return. Clang's version
>> is more in line with the kernel's own stance in deprecated.rst, which
>> states that all switch/case blocks must end in either break,
>> fallthrough, continue, goto, or return.
>>
>> Add the missing break to silence the warning. Additionally, adjust the
>> indentation of a break and add a default case to the inner switch
>> statement.
>>
>> Fixes: a87456864cbb ("hwmon: Add Ampere's Altra smpro-hwmon driver")
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1751
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Applied.
> 
> Thanks,
> Guenter
> 
>> ---
>>
>> v2:
>>
>>      * Add missing default case to inner switch statement (Guenter)
>>      * Fix indentation of break in inner switch statement (Guenter)
>>      * Reword commit message to include these changes
>>
>> v1: https://lore.kernel.org/20221027195238.1789586-1-nathan@kernel.org/
>>
>>   drivers/hwmon/smpro-hwmon.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>>
>> base-commit: 0ffb687b6508c36a17b99bdaf014b38532404182
>>
>> diff --git a/drivers/hwmon/smpro-hwmon.c b/drivers/hwmon/smpro-hwmon.c
>> index ee54e21c2c12..a76c49dd8438 100644
>> --- a/drivers/hwmon/smpro-hwmon.c
>> +++ b/drivers/hwmon/smpro-hwmon.c
>> @@ -373,8 +373,11 @@ static umode_t smpro_is_visible(const void *data, enum hwmon_sensor_types type,
>>   			ret = regmap_read(hwmon->regmap, temperature[channel].reg, &value);
>>   			if (ret || value == 0xFFFF)
>>   				return 0;
>> -		break;
>> +			break;
>> +		default:
>> +			break;
>>   		}
>> +		break;
>>   	default:
>>   		break;
>>   	}
