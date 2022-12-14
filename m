Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB08664C2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbiLNDh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiLNDh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:37:56 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2097.outbound.protection.outlook.com [40.107.96.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA333233A8;
        Tue, 13 Dec 2022 19:37:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpSq9IKP4RPTpWYYRy6d+vPAwT7fGAhmpQA2sBUK729HL8MbFEybXwcBiQy0fX2CSd/a6ynFntJO5PPFTn++VgRVRr9NldrZJUH8f0PAj4wwnevorj1SBGmV8j9SPgGzkcJ44afv2K0D8SYgVWYO/61Lug4hQo683hZALtZKUutvkVkouRckuS7z2hS3sjCAsv296wEe64Pv7pPBz1U9A0kGddwukhlwf4iD/3vf0Wh/GwfAchpEJqDTBy5OE1mqfOic9qx0dPODKQmAIwJBFMnzJpZaD8RK4l+MHTQduFdXh38yWYArGcfF4NV4ROMH0mfmlyYwHXSSEkUMIl+6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSMAZ0zQtGYgHXqx94peQ5Xo9r+BqIVjllUScTUO/n4=;
 b=GW0EGvkBKBV0p2yGq+pIPwoJjXuqhOoNTHtlMmB+F++tbz2Fh9X0SijUWOQ9avamOeTz6M0YmyebsYuPJCGd0ACwxfU06Oq8/LwmOQjRe4EuTeS3qA8muNfuevMnMi67eXYMpxDYZBIGciJfqx7wNJw+vYmOyWV67VoYvQKza8+6Y9UZJoSyEMBu5BxOmclAfhJdWUmL6VAyhbDC47WFgWPGPRhNrQbhEtQ2jOiaUFd5BtzZseMtwGdwkY1lfKCbbhYObQOGyrOZ9yOY903875dBfACR0Vp2aRdAL5DF1RLw6avdoTXSAqdGPA2zwzm5w1ZR/nkqSdpZk5WxXizjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSMAZ0zQtGYgHXqx94peQ5Xo9r+BqIVjllUScTUO/n4=;
 b=Tdu9C8Z/1s6iEYDGHDXlT/OvZTEECXu7IZjrWaqgJiEs7PLzHZ9ChemBIPKw4O8lr6T7FvGmHfOdtMQ4GU3nLBsf/F1vFIeJErrGmUw94/bdzZ/+cAHhUy2JdVdROwbo86q1mlLabjAuYVzpkx+8EY4RLFIQFZPTHBtH8SsJ0j4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SN6PR01MB4973.prod.exchangelabs.com (2603:10b6:805:c4::13) by
 DM6PR01MB4778.prod.exchangelabs.com (2603:10b6:5:6d::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Wed, 14 Dec 2022 03:37:50 +0000
Received: from SN6PR01MB4973.prod.exchangelabs.com
 ([fe80::1e67:38ac:ed37:be1c]) by SN6PR01MB4973.prod.exchangelabs.com
 ([fe80::1e67:38ac:ed37:be1c%3]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:37:49 +0000
Message-ID: <f1bb6995-6901-3def-3ff0-a7438339625a@amperemail.onmicrosoft.com>
Date:   Wed, 14 Dec 2022 10:37:39 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/1] usb: gadget: Assign an unique name for each
 configfs driver
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Frank Li <Frank.Li@nxp.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linhaoguo86@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        Chanh Nguyen <chanh@os.amperecomputing.com>
References: <20221213220354.628013-1-Frank.Li@nxp.com>
 <67878b69-89af-6a0c-24c6-ff111dae6ce6@wanadoo.fr>
From:   Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
In-Reply-To: <67878b69-89af-6a0c-24c6-ff111dae6ce6@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To SN6PR01MB4973.prod.exchangelabs.com
 (2603:10b6:805:c4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4973:EE_|DM6PR01MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: f85ca89e-a7ff-47d5-868f-08dadd849287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHOV9MKLqLBUUv4X1m+yF4s4LcBzB0TuIFXuEhcB1YnoHQnn3WeSYcV+lhRpbsCnjzKKwCxlQleocWC4w7ST1MjFj7/avKPOxBmsYooNKg27l2dO6rTwXr8X2bgONETxybuM2aUnjv11pUIM/UTgBo5AvqT3eZmmXXUDAtJvczIWPxrroe+kQaorOjuTIgzNxisBHIOTKthYZm2QXsDfp6r/UWkNqKW1xo2a806LauUAxVljzW8gcExbK2Pt5hmkwRzCfwiu0hWBIiZgg8eaN7Dab17KeSyq09Wul4QieC/SJ+i2MFOTdVVwrVh12+vc/ueQsDVtzekyuw+3GxlpWw/TIsrzRXiH4FnEiLSgFlG3o4e6IhYK4G3HYxgPRD9HSREOe3/N33e6wkvshnnY22Px2kJ5ZaLYCdmYmV59TmEdvuIJuieX0nHAFPGCA2IXPkQVYhQPX/sz5JARTSpFa+zkjoziSDU7Cu2ZX5sHuAUP1lkfNEEpIvhHPppgERCL9qfW2eCbOPjG1EYleaxOy0dNdcQqwoG4YQ6QNObLIM4odaIZ82xhGD+mPzbM8/0CRS85od91uBEcfEHIoF/HpT9RPiyXOb17+755P+4/WnPlKWF+dbmvgBJUOQMgcJi3l4walxXUux3GsoQiirDsC24clKNH/YJsfmIJhR3RnwQy6e85P5a9D9R8XvcWvqEZ7ME51C5SenWM6ioRFz3T/LzNW8NRpEg8qtkML6If2PurtTs/EXaWYUuAVGQa5/z6UDMogyAm7QGOLkUPEn/F1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4973.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(396003)(366004)(376002)(346002)(136003)(451199015)(41300700001)(2616005)(110136005)(31696002)(42882007)(478600001)(6512007)(83380400001)(53546011)(6486002)(186003)(6666004)(4326008)(107886003)(6506007)(966005)(26005)(38100700002)(83170400001)(5660300002)(66476007)(8676002)(316002)(66946007)(8936002)(31686004)(66556008)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHFkUlJWSjg2RmNYVkJaTXJjKzkzYXhFdUU5WGtPOGpBam1zRU1IL3NBR1Z5?=
 =?utf-8?B?TldYN2ZJSzRtN2xGSk0wZjF3Z3dEOTNXZWo5MU5HWUwyditrbG92OUE5aWRz?=
 =?utf-8?B?eUEzb2RETmtzbUVlSFMwdzUxU0dEYWtpRXBWbno4N1I3ZC9oRTRKbDI2ZWN5?=
 =?utf-8?B?eG1VMU5paXFQMmwzWXI0ekJ3a0xJZlh0a2NEaXMvQnZSZU5UWExnRTNUVGR6?=
 =?utf-8?B?MGprMzNCYldrZHdRL0RVWFVWQ3VTUUJqNkgvRmZadUNCVkFtOUZPd0N3dTJi?=
 =?utf-8?B?N25RTmV4bzNaZVlJQnB1YWVucWhhQ05VcUIrOTVlVWowWEw3ZUtjejU4WFQx?=
 =?utf-8?B?L1oyNTdZbzZxRnpsdGkxdzVCVEN3WlFFUDY4ZDJhYnZwZWhYTHQ2KzRpVGNQ?=
 =?utf-8?B?SXFlZlE3Y21xS2t6NGtXWGRBMXRxVE9QclRkYWRHcW90Z0x6TG9meHJnazh1?=
 =?utf-8?B?ZThaak1MeUNia1RVbitOOXFiNEVETW5TckFPR2prNnphakRTczdadzF5MStm?=
 =?utf-8?B?REJ0WSt5ZSs5U2hPNFhzclVlVEc0ZmZnOEhKcFR0dVRZcE12UmNqdlNRY0l2?=
 =?utf-8?B?S1RaSjR1Um1oSnpjSFFRM0pQcmZhTitBVDhPdTJLSWlCeWZiQ0tGMy81NDVi?=
 =?utf-8?B?bzBKbEg3RTVWdlJVb1hubU1pKzM2KzJPY3ZVQzQvSlpIWjAzRThaV0c2b3Iz?=
 =?utf-8?B?OEVvNzU5QUNNVTJWTGpobEY0U3ZNUFBiSlE3OVNISVduSHVuOUJxWUhucTZH?=
 =?utf-8?B?d1FOMTdycSsvMk1KTWc1WVZFVzRBbTA3Vkg2VVN4cHMxa0d0Vk90cmJDMUZZ?=
 =?utf-8?B?R0FxQnVEZTVjMlJuakpuVDkzck9oMzJ5RUJhSnZhYzdDZWc2bGVReGpGK250?=
 =?utf-8?B?L2pid2ZORjFBa2t2T3hJNlJFQ0xsZ3RDWlZ4c0t1UWgxZC8zQXgrV3hDMDRF?=
 =?utf-8?B?WVVJWWd2WTZNclN4elNSNFlpVWtsZWhkaE0rQkpnQUN4U3RBZUprWStKNE5S?=
 =?utf-8?B?ZUJZQ2hmYUp5T3JqbGpKUWNVZ3dxbWh5M2ltTXp5clUvUDBDWmloVElFY0FZ?=
 =?utf-8?B?UjFYdEVhMGdLeTFXNzZwbTVyYzFWZkw1TFRzSys0N0hVbUprRnZzQ2hKajk0?=
 =?utf-8?B?R3oyeE5IUHZNbjloZkErUTJPd0wvUG83WEZ5RU9LZitZcENERkJ6bTMxR0Jj?=
 =?utf-8?B?TzVPRVlRZGlQSW9sSzVSRnJ0WUNyZHFPbUZRMFVJK05nOWp3RnpJUEpXSGho?=
 =?utf-8?B?SlhXZzhRQVNRdFpkeWdPeWk0cFluYVQ4OXQ0d1dSa1NjMDlieVRHd2Z6d2FI?=
 =?utf-8?B?TEVZUmg2R1J2L0lockdwbmtNQVdlYi9iZUlkZ3R0cDZuenc0ZndQM0hjNFdF?=
 =?utf-8?B?M25CajZyS3BIVHY0SHN3Z2FEMExUUW4xaDExbStHeFJ6RGVjdGJTSmdTYWFa?=
 =?utf-8?B?UnJSNzNPSVhMRnRBSDREYjJySGpEbytlbkZKNmpDTjhZbmUvZ3BVb0E1NlF5?=
 =?utf-8?B?Ni81VFN0bjlMZ1QzOEtGazEwTXF1aXdVa3YwNDBnSW8zZjQ5ejNxQS9kdXBZ?=
 =?utf-8?B?enpxZmo2SXJvKzd1K0dMUXFyaTJtMzZFVTNFM3l0OTI4K1VLOGNpbTgzLzB1?=
 =?utf-8?B?TzMrOWg3dFpNY0o5TXhuZDNIMHJRWGpHa2w4Uk85TDE2bW1VY25TS1NGSEVR?=
 =?utf-8?B?T1hsU2Z5MWNTNXNuUi9TVHBaRVNxbmxObVJQU2ZxR1FoVUM0WFJ2WjBvcnNr?=
 =?utf-8?B?UjFBankyUzlEazRMM1BmS0hZOTZwT0diajdmZVQxYzdGYkE4RGl1Nk95UktU?=
 =?utf-8?B?MFp1NFh0WkFkTGNXdFQvMXgyaFMxbkQ4YjJBTW9saDVnZlIrK0tnbU9jbXBk?=
 =?utf-8?B?enpQbEtwZURMQ3VZNEV6MjZKaFY2cnN6VWVvaGQ1RFZjd3pJZEYraklvVHlE?=
 =?utf-8?B?WExoRHh3cWtFcHpZNzlFK00rRGdDb0l6OXBEN29pWmxkWldGVFFFTGpKZk5j?=
 =?utf-8?B?RDVmQ0FHaXI0TFhoRHNyb2dFb2lFWDh1bHNjUFN3STVKUWk1WEV0UEJqSmt4?=
 =?utf-8?B?NHlNZGd4SE44bjFDTXcwL0xwcHZhTDFtZDlIZW16NE1FaFdsdUQ5VmkzcVVP?=
 =?utf-8?B?d1gxaGV3Y20rWm04ZW5tQUlmTnVaN1RzNUJEdXkwM1hucEhnK3dNUW56UHdK?=
 =?utf-8?Q?qkN+U08WNLu+5Lkzs1aaui4=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85ca89e-a7ff-47d5-868f-08dadd849287
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4973.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:37:49.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiuSmRIXTKXA0GU1ipbyBQYWcMCPbic0roOvaQbKTra3oDKCvmh9px0aHud47JUNZA9n4r9d1s7s6GIIAOQFNBs+UVrXmwVxEOsmn750srdQwtA4MV83TxzDEMU7S/Y4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4778
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/12/2022 05:20, Christophe JAILLET wrote:
> Le 13/12/2022 à 23:03, Frank Li a écrit :
>> From: Rondreis <linhaoguo86@gmail.com>
>>
>> When use configfs to attach more than one gadget.
>>
>> Error: Driver 'configfs-gadget' is already registered, aborting...
>>
>>     UDC core: g1: driver registration failed: -16
>>
>> The problem is that when creating multiple gadgets with configfs and
>> binding them to different UDCs, the UDC drivers have the same name
>> "configfs-gadget". Because of the addition of the "gadget" bus, naming
>> conflicts will occur when more than one UDC drivers registered to the
>> bus.
>>
>> It's not an isolated case, this patch refers to the commit f2d8c2606825
>> ("usb: gadget: Fix non-unique driver names in raw-gadget driver").
>> Each configfs-gadget driver will be assigned a unique name
>> "configfs-gadget.N", with a different value of N for each driver
>> instance.
>>
>> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
>>
>> Signed-off-by: Rondreis <linhaoguo86@gmail.com>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>
>> This patch is based on 
>> https://lore.kernel.org/lkml/20220907112210.11949-1-linhaoguo86@gmail.com/
>> fixed the all greg's comments.
>>
>> I met the same issue.  Look likes Rodrieis have not continue to work this
>> patch since Sep, 2022.
>>
>> I don't know full name of Rondreis.
> 
> Hi,
> 
> Also, out of curiosity, any link with this patch:
> 
> https://lore.kernel.org/all/20221213041203.21080-1-chanh@os.amperecomputing.com/
> ?
> 
> Not exactly the same, but not very different.
> 
> (adding Chanh Nguyen in cc)
> 

What a coincident :-)

I did not aware there are some similar attempts to fix the same issue 
and see both patches posted same time.

We start to see the issue when OpenBMC started to adopt kernel 6.0 and 
try to fix the issue since then (beginning of Oct 2022)

We then could be able to identify the issue and try to fix it follow the 
commit f2d8c2606825317b77db1f9ba0fc26ef26160b30

Going forward, as we have both Frank and Rondreis interested in the 
patch, we are really happy if you both could review and share the 
comment. I'd really appreciate if you could help with that part.

FYI, we have reviewed and made some changes based on CJ's comment in my 
last patch (v1) yesterday. We are trying to test it as much as possible. 
If it looks good we will re-post it as v2 shortly for further comment.

Thanks a lot for interesting in the patch.
- Chanh

> 
>>
>>   drivers/usb/gadget/configfs.c | 30 ++++++++++++++++++++++++++----
>>   1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/configfs.c 
>> b/drivers/usb/gadget/configfs.c
>> index 3a6b4926193e..785be6aea720 100644
>> --- a/drivers/usb/gadget/configfs.c
>> +++ b/drivers/usb/gadget/configfs.c
>> @@ -4,12 +4,17 @@
>>   #include <linux/slab.h>
>>   #include <linux/device.h>
>>   #include <linux/nls.h>
>> +#include <linux/idr.h>
>>   #include <linux/usb/composite.h>
>>   #include <linux/usb/gadget_configfs.h>
>>   #include "configfs.h"
>>   #include "u_f.h"
>>   #include "u_os_desc.h"
>> +#define DRIVER_NAME "configfs-gadget"
>> +
>> +static DEFINE_IDA(driver_id_numbers);
>> +
>>   int check_user_usb_string(const char *name,
>>           struct usb_gadget_strings *stringtab_dev)
>>   {
>> @@ -46,6 +51,7 @@ struct gadget_info {
>>       struct usb_composite_driver composite;
>>       struct usb_composite_dev cdev;
>> +    int driver_id_number;
>>       bool use_os_desc;
>>       char b_vendor_code;
>>       char qw_sign[OS_STRING_QW_SIGN_LEN];
>> @@ -392,6 +398,8 @@ static void gadget_info_attr_release(struct 
>> config_item *item)
>>       WARN_ON(!list_empty(&gi->string_list));
>>       WARN_ON(!list_empty(&gi->available_func));
>>       kfree(gi->composite.gadget_driver.function);
>> +    kfree(gi->composite.gadget_driver.driver.name);
>> +    ida_free(&driver_id_numbers, gi->driver_id_number);
>>       kfree(gi);
>>   }
>> @@ -1571,7 +1579,6 @@ static const struct usb_gadget_driver 
>> configfs_driver_template = {
>>       .max_speed    = USB_SPEED_SUPER_PLUS,
>>       .driver = {
>>           .owner          = THIS_MODULE,
>> -        .name        = "configfs-gadget",
>>       },
>>       .match_existing_only = 1,
>>   };
>> @@ -1581,6 +1588,7 @@ static struct config_group *gadgets_make(
>>           const char *name)
>>   {
>>       struct gadget_info *gi;
>> +    int ret = 0;
>>       gi = kzalloc(sizeof(*gi), GFP_KERNEL);
>>       if (!gi)
>> @@ -1622,16 +1630,30 @@ static struct config_group *gadgets_make(
>>       gi->composite.gadget_driver = configfs_driver_template;
>> +    ret = ida_alloc(&driver_id_numbers, GFP_KERNEL);
>> +    if (ret < 0)
>> +        goto err;
>> +    gi->driver_id_number = ret;
>> +
>> +    gi->composite.gadget_driver.driver.name =
>> +        kasprintf(GFP_KERNEL, DRIVER_NAME ".%d", gi->driver_id_number);
>> +
>>       gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>>       gi->composite.name = gi->composite.gadget_driver.function;
>> -    if (!gi->composite.gadget_driver.function)
>> -        goto err;
>> +    if (!gi->composite.gadget_driver.function) {
>> +        ret = -ENOMEM;
>> +        goto err_func;
>> +    }
>>       return &gi->group;
>> +
>> +err_func:
>> +    kfree(gi->composite.gadget_driver.driver.name);
>> +    ida_free(&driver_id_numbers, gi->driver_id_number);
>>   err:
>>       kfree(gi);
>> -    return ERR_PTR(-ENOMEM);
>> +    return ERR_PTR(ret);
>>   }
>>   static void gadgets_drop(struct config_group *group, struct 
>> config_item *item)
> 
