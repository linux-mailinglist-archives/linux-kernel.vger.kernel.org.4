Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0746569E4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjBUQlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjBUQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:41:46 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545BF2CC47;
        Tue, 21 Feb 2023 08:41:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duxXmZGM+DT1PjWo5B2X5qgYk6m0ODGdfNF+/RlFPUSuQ1wgt3B1L202RWO6lA2SnGeSzAyEb881bziy1phbqnwxIxg3peyhWu65qZv97dmnX30FDKNYNv+8EqrqhIoaj4DG62EGvNTPrmsszPFcniH2T4S5OwB65PDKfVgn0gek8C7P48AOXf79ZjoPGF0XySqsVHltG5VQmJ2XDqztXyZ24l/T7rZijUmYwXrMCE9AsOqLPCExUaqNr1n04NGtIFfegWmVonu3ra3DOJ8RKEx/JwHb2HmpwHYNZCyq3/mm/yUtPR7C18WNhjahlQiqJ0mGBr4cbggHoJQb/XaJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXT3klEoe4zcZZ4GNHH9Z7xZGQdWwzhIhnLb6ZCEMCI=;
 b=TSTmBX4gKeC2yhv/cBRE8l2rPf18lS68qMHnpVqtUBJkPfO3WHKsROgQUy8aKKmEawWwT2r1jzYQoauUPHi/U/JfD51BlqO02IwuZozlIG51QECDhbielhmCkiq/1dsM0dTymk5UFZ6XBS25CgRmp8CstKkrYO4KCw2t7W7bX3HueMEccvtyjIRsv88X2w0F0MNxNtCmaA6GgjBknWLkV7Hho+LFDKmO7+uy3XOE+h6DN+x5nXDWqoaJTYxFjxoLRcCT/dFp5hh+WWRoqH7fwNLpbCKbdjSqpmhyQ6ZcqWCAa88k6e0fl+oNKRNJhN205HtvI+42BTZZo67PH1sZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXT3klEoe4zcZZ4GNHH9Z7xZGQdWwzhIhnLb6ZCEMCI=;
 b=Se1VPNg4ikmEqiRSG4yySOcd1xjP10U2S3yOD7Z/vY1ceOamrCMB2hkEmUuEp5nP4/+OMrn8G6ghb489sF8oRv9N7dS/YnQ0TqG02kgoDvFH58FSaU35r6mNmm2kKQ5yHwcQq9mMybkWNzfkmqapnvPq6KKr0hSLW3qk3ta0Gi6f98Mgv6rYM3kowgRvdkfu5tXX7fZ6J1DTTAPfwofC0e4wU0gAyGOGMaZBKdNmzwkU9W0bVQNkoGSIxRNylz3wz1NMRTL9cxSQTA0wZin/22Md/r6vDQ7rtnlLgFi4yEJFB8edB495oO0zrkUDrUExiZVSnKJq279FxnRGIQYdqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Tue, 21 Feb 2023 16:40:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%7]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 16:40:32 +0000
Message-ID: <40a2a0f3-a396-2a13-b7ce-514015ae3bab@nvidia.com>
Date:   Tue, 21 Feb 2023 16:40:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v4] ucsi_ccg: Refine the UCSI Interrupt handling
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haotien Hsu <haotienh@nvidia.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Wayne Chang <waynec@nvidia.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118061523.1537992-1-haotienh@nvidia.com>
 <Y8k3XB53iHeE0XZF@kroah.com>
Content-Language: en-US
In-Reply-To: <Y8k3XB53iHeE0XZF@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0413.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA0PR12MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6d10d4-4191-485a-ed61-08db142a5908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVTBdbgi/2Gtnas312zvjazppyuLdwK8HM3WhIk+agO1J6UxiFTzm+fbLHK1ExqSr+3+zZXGdiRZx6QTCjqnPrV/ZjLM0KJB1wK2iEhs44ZIQGVjeiWNFB0xa6Dbo8RKQWi4t2Vm8GC60Htn36QayK0UJ12s63cCJlYz1efff8djfAxIk3nMQvAHKASkESIdIC/XzH5jx1V2RGM0ZfQqTux53z3RPB7dHLlE2B9sdt6pBV/k3GTtOCK05eqAdwdJ2hHSltHwNQKfjdSfTPEKQLKOIdnRINZxpwWacawvg3wBy2OWkQO9xaonEcklXJfZ1IrqrM/uziWu3V+Cx2DKLICmYJgK+cYfmmcEOV57Se8h6EXN01Ycou+HyV9whfRUqIczXoC/y917oi7r8eJCoFfx8/0QmLgAhV4EAwVcmpdgXu2BuX8LmBstX+wuadwb3oiRvwL56JnjHI5pBltnS+m+O9wuS1adJ1piBf1Tsjv5arwiKNvrUfo5FZfsF23XHbSqPJr64YUYKaeSLg1vTIQK5V4mIxoPYLrhJTuT8WczUIu4NLDAoHlh0syXUVRXCu+1pFRBNLBar1dPQM+xCX1otxIAyg824snYXXVgKaJfwVIl20TaXiLd8yCZtVp7FFBMI35exZNdQwvTBmDoCJaCYT9mvU/jKpv9Yo6Oel9nvltuSlGMdcNBprDSrUzUG5TK0Lc8ajpiXjdTuoj5kDuCnOXamoOpFbRUZ1xVtv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199018)(31686004)(36756003)(8936002)(6506007)(86362001)(31696002)(5660300002)(478600001)(6486002)(4326008)(2906002)(83380400001)(186003)(41300700001)(66476007)(6636002)(110136005)(54906003)(316002)(66946007)(66556008)(6512007)(6666004)(8676002)(53546011)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1FpWVpVajF6L1ZleXh0NmZ6LzRUb05WaUVYcUpzaVMybGN2NVVHM09OS09Y?=
 =?utf-8?B?d1pGQ3JVM282NXEvbjh1dUFUcUFwb2FXQnhIR2JFQVhJR2xpakUwQzJqSjZI?=
 =?utf-8?B?K2p5ZG1DUnNDMXJJT2Zza1pGdFBPQXNXd04wTUZsSlk2cW5mZk9yMlhhckt6?=
 =?utf-8?B?cHphQmVlSXhtRG5Ja21pNTlxN1FlR3JQNVhKNWhEK0pUVXFOcjF6NW9naWFP?=
 =?utf-8?B?bFhQbldJNjFNZ2pvT3NkMFdGS3puZGhUWi82YlVpaU9qdzE4d05vTTdIZUdQ?=
 =?utf-8?B?VHFrQzd1ck1HNTVnS2xhMHFIOS9GV0xyMXFyVTMyVXRWZFpyL0hYaDQwcmVo?=
 =?utf-8?B?OTQ4UGpsM3cwaVd5RS9Xc0kyTzF4N0QzaFdxVW92azlDZVZDbUpjaUZBdHVr?=
 =?utf-8?B?aVlvOXd4WGIzZXZyMk5tcXZUcHQrRTRNSHl6cGRwY2dtQm1EMDNka1A4RGlN?=
 =?utf-8?B?Z0dLVmJ6RE1GbmdnRFdBeVNSL0QwNCt0d2hBZndneUkyZWpkaXk1RFArV0c4?=
 =?utf-8?B?and4aS93MWlSZHBnNUdyc2NsemFPb0tOOTVVbnJaK05wbVRhY29JaExGTU16?=
 =?utf-8?B?Y1J1NzZISE1vd3R3bUY0WDJRNzM2S056ZHRvTWYzYjZTQ2Q4aHBSZmRSME1U?=
 =?utf-8?B?K2dSemc2WElSQ0l4ZGVucmdnQUxvQTFibnUrSnVrakhLU1JEU3g3WE5DazhF?=
 =?utf-8?B?NVFYQkRyOXZSR1ZOU3o4Q2VlRWRNRWxvbU1HNjNIUjJQUGVLYmZGcUs5ZmpD?=
 =?utf-8?B?dFdsV01nTHp1MFQ3a1dXbUh4SGJyVDNvamQ3WkpDNTZsVWl4OE8xN205cDlp?=
 =?utf-8?B?RTdGYlkxSTZwM25iMTZDSExqTW9KOXlGd0xtbXRjOWtnT1pOVGpiVHBheDlB?=
 =?utf-8?B?Z3p1TkxhdFNrcGU3T0VVUVVLV0p2MnNyTXBSb2JEQXQwbk1vdmxHZGl0emVz?=
 =?utf-8?B?b0tyeERjV1Q1WERXQTErV1l5SElqMy9OaUoveHVHSlZGVjlHTUorc1pRMzds?=
 =?utf-8?B?TExKNkI1R0s1NkNabXFkS2J0KzA1dDN1RzdYZ2kzSHhuS2RTMzVhUTlzazFJ?=
 =?utf-8?B?dmlPeFZRMGVqaWtGZnBXOWhOOXFVRUFIM1g3OXRuZEdiWEs2MGlnaCtEYlln?=
 =?utf-8?B?ZUxpQjVuR3poOEFibmVIMHlxZ2FvZHo3dng3enB4amdvZEdaWXo5YnphT1hw?=
 =?utf-8?B?QTlzeWYyWEhXemZqVnpCNkpacVhnN0JQbjZpVS9DdVQ1blA4VFNoWjYyQlAr?=
 =?utf-8?B?a2I3MEtza1lPMFVIR0diS0dVVWFqaFQ1UzZMWDdvUDhXVVJmOGZyd29XaGUw?=
 =?utf-8?B?Y3hLLzBTYnVLTTJ2V0Rzb3FyV1crdER0VE5MQm45SE5QOGUvNE5GRHVzUGt3?=
 =?utf-8?B?T3R2MHkvdEhhVDg4SjVwR1RGeXJrcXkzSFduWXZPeDhSck8rajJ6U1lnN1RJ?=
 =?utf-8?B?S0psSlNOREdkNzVSTkFzcFFFbVYxeDl5RFNqTC8zVFNnbHVveEdnOVlieWRF?=
 =?utf-8?B?SVJybk5nTkN1Z0NwbzlRMkRReFRYeWV1cXFSa1JpeGZvOW1HMXJRVzJUSnAv?=
 =?utf-8?B?TWtKUWZhTUV1dHRqaUVTT3pZRTJNNUtRSWN0QmxPcTEwWno1V2h5SlhiSWxr?=
 =?utf-8?B?cjRibDBrWUtTWmFnUTdSY3pUOTVZUUVGMWRjLytoOWdkcnVEV0FjeHhrWFhU?=
 =?utf-8?B?SDI1QXBTMUJOMHlHbVZHUHdkSURpREhpN2pHUC9VaEZkL1R1b3U0VkRmR3BP?=
 =?utf-8?B?c3RJejZMblBKbXBaL0FKMW5iS2g3SGlhZG93Z0puclJZVk55TmxnNGExTU1D?=
 =?utf-8?B?Mjl0WWRNVkI1ZVJjRkNOVU53aWVGU0I1VXJNc2dNMmI0TFRaMWUrTVdueDNw?=
 =?utf-8?B?WkRvdmFvT2h3Q0QzbHpkZThDOHhDY3N5V2lzdks2cEFwWTFhaCtRTVNMZDRs?=
 =?utf-8?B?d3RxQ0RLTGhYSUZkeEZINVZINE9VNG81THJXTGk1NlBoR2RxK3hnd0VqNzBS?=
 =?utf-8?B?UjhDdS9USEJYNmVrbFBoQUoxZFdTQ1l6Vy9HeFFsbFRHT1FZd21PbWtCU2sr?=
 =?utf-8?B?NTdhV250UklBeklralJ5T1ppVWFzWGFoRmJKekhRWmNFSkgwbzRZcjRUYlRl?=
 =?utf-8?B?TWh5RGQyWC9LZURlcGdmVXJTemZWT3gwakhMbTFNL2RScmFST25TaWR1WUdI?=
 =?utf-8?B?OVBjZ082dDBycXE0eEFPRDhnYXlRQ0trZkk4Z2xIYnRsZm1wRTRZS1JxYnhM?=
 =?utf-8?B?eEtYWWg4WklqV1NjcEsrQWtiSjRBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6d10d4-4191-485a-ed61-08db142a5908
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 16:40:32.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae6w09JQz9O87Wm2Q2YBkheVhj7N5kbUTa2OtQlGBphXvl1IPeSGPMfwgYVe++sAd/a9qk4BM00lubkSe8UnZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 19/01/2023 12:28, Greg Kroah-Hartman wrote:
> On Wed, Jan 18, 2023 at 02:15:23PM +0800, Haotien Hsu wrote:
>> From: Sing-Han Chen <singhanc@nvidia.com>
>>
>> For the CCGx, when the OPM field in the INTR_REG is cleared, then the
>> CCI data in the PPM is reset.
>>
>> To align with the CCGx UCSI interface guide, this patch updates the
>> driver to copy CCI and MESSAGE_IN before clearing UCSI interrupt.
>> When a new command is sent, the driver will clear the old CCI and
>> MESSAGE_IN copy.
>>
>> Finally, clear UCSI_READ_INT before calling complete() to ensure that
>> the ucsi_ccg_sync_write() would wait for the interrupt handling to
>> complete.
>> It prevents the driver from resetting CCI prematurely.
>>
>> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
>> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
>> ---
>> V1->V2
>> - Fix uninitialized symbol 'cci'
>> v2->v3
>> - Remove misusing Reported-by tags
>> v3->v4
>> - Add comments for op_lock
>> ---
>>   drivers/usb/typec/ucsi/ucsi_ccg.c | 90 ++++++++++++++++++++++++++++---
>>   1 file changed, 83 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
>> index eab3012e1b01..532813a32cc1 100644
>> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
>> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
>> @@ -192,6 +192,12 @@ struct ucsi_ccg_altmode {
>>   	bool checked;
>>   } __packed;
>>   
>> +#define CCGX_MESSAGE_IN_MAX 4
>> +struct op_region {
>> +	u32 cci;
> 
> This is coming from hardware so you have to specify the endian-ness of
> it, right?

The current driver reads the 'cci' state in the ccg_irq_handler and here 
we just pass a variable of type u32 for storing the state. We are just 
adding variable of the same type to save the state. This value is 
returned to the ucsi layer which does not specify the endian-ness 
either. I guess this driver like many assume little endian. What is the 
guidance here? Should we be adding __le32 here even if the upper layers 
don't?

>> +	u32 message_in[CCGX_MESSAGE_IN_MAX];
> 
> Same here.
> 
>> +};
>> +
>>   struct ucsi_ccg {
>>   	struct device *dev;
>>   	struct ucsi *ucsi;
>> @@ -222,6 +228,13 @@ struct ucsi_ccg {
>>   	bool has_multiple_dp;
>>   	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
>>   	struct ucsi_ccg_altmode updated[UCSI_MAX_ALTMODES];
>> +
>> +	/*
>> +	 * This spinlock protects op_data which includes CCI and MESSAGE_IN that
>> +	 * will be updated in ISR
>> +	 */
>> +	spinlock_t op_lock;
>> +	struct op_region op_data;
>>   };
>>   
>>   static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
>> @@ -305,12 +318,57 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
>>   	return 0;
>>   }
>>   
>> +static void ccg_op_region_read(struct ucsi_ccg *uc, unsigned int offset,
>> +		void *val, size_t val_len)
>> +{
>> +	struct op_region *data = &uc->op_data;
>> +
>> +	spin_lock(&uc->op_lock);
>> +	if (offset == UCSI_CCI)
>> +		memcpy(val, &data->cci, val_len);
>> +	else if (offset == UCSI_MESSAGE_IN)
>> +		memcpy(val, &data->message_in, val_len);
> 
> What happens if the offset is neither of these?

Looking at where this is called, currently only these offsets are passed 
to this function. However, I am wondering if we really need this 
function and if we just don't collapse this into ucsi_ccg_read() so we 
have ...

        if (offset == UCSI_CCI) {
                spin_lock(&uc->op_lock);
                memcpy(val, &uc->op_data.cci, val_len);
                spin_unlock(&uc->op_lock);
        } else if (offset == UCSI_MESSAGE_IN) {
                spin_lock(&uc->op_lock);
                memcpy(val, &uc->op_data.message_in, val_len);
                spin_unlock(&uc->op_lock);
        } else {
                ret = ccg_read(uc, reg, val, val_len);
        }

> You seem to be only calling this if that value is set correctly, but
> this seems very fragile.  You are also only calling this in one place,
> so why is this a function at all?  Just do the copy under the lock as
> needed in the calling location instead.
> 
>> +	spin_unlock(&uc->op_lock);
>> +}
>> +
>> +static void ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
>> +{
>> +	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_IN);
>> +	struct op_region *data = &uc->op_data;
>> +	u32 message_in[CCGX_MESSAGE_IN_MAX];
> 
> Are you sure you can put this big of a buffer on the stack?

It is 16 bytes total and so we did not think it was too big.

>> +
>> +	if (UCSI_CCI_LENGTH(cci))
>> +		if (ccg_read(uc, reg, (void *)&message_in,
>> +					sizeof(message_in))) {
> 
> Are you allowed to copy in into stack memory?  This ends up being an i2c
> message, right?  Can that be transferred into non-dma-able memory?

Yes the existing callers of ccg_read() are also using buffers on the 
stack for reading the data into.

>> +			dev_err(uc->dev, "failed to read MESSAGE_IN\n");
> 
> Why can you not fail this function?  You are throwing away the error
> here, that's not good.

Agree. We can take a look at this.

>> +			return;
>> +		}
>> +
>> +	spin_lock(&uc->op_lock);
>> +	memcpy(&data->cci, &cci, sizeof(cci));
> 
> Perhaps just:
> 	data->cci = cci;
> as this is only a 32bit value.

Agree.

>> +	if (UCSI_CCI_LENGTH(cci))
>> +		memcpy(&data->message_in, &message_in, sizeof(message_in));
>> +	spin_unlock(&uc->op_lock);
>> +}
>> +
>> +static void ccg_op_region_clean(struct ucsi_ccg *uc)
>> +{
>> +	struct op_region *data = &uc->op_data;
>> +
>> +	spin_lock(&uc->op_lock);
>> +	memset(&data->cci, 0, sizeof(data->cci));
> 
> 	data->cci = 0;
> 
>> +	memset(&data->message_in, 0, sizeof(data->message_in));
> 
> Or better yet, do it all at once:
> 	memset(&data, 0, sizeof(*data));
> 
>> +	spin_unlock(&uc->op_lock);
> 
> But why do you need to do this at all?  Why "clean" the whole buffer
> out, why not just set cci to 0 and be done with it?
> 
> Or why even clean this out at all, what happens if you do not?


I have been taking a look at this. If we don't clean the variable and 
buffer, then the previous state could be incorrectly read again after 
the next command has been sent.

Without this fix we occasionally see timeout errors such as ...

    ucsi_ccg 2-0008: error -ETIMEDOUT: PPM init failed (-110)


I tried not doing this at all, but then we see these timeout issues are 
still seen.

>> +}
>> +
>>   static int ucsi_ccg_init(struct ucsi_ccg *uc)
>>   {
>>   	unsigned int count = 10;
>>   	u8 data;
>>   	int status;
>>   
>> +	spin_lock_init(&uc->op_lock);
>> +
>>   	data = CCGX_RAB_UCSI_CONTROL_STOP;
>>   	status = ccg_write(uc, CCGX_RAB_UCSI_CONTROL, &data, sizeof(data));
>>   	if (status < 0)
>> @@ -520,9 +578,13 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
>>   	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
>>   	struct ucsi_capability *cap;
>>   	struct ucsi_altmode *alt;
>> -	int ret;
>> +	int ret = 0;
>> +
>> +	if ((offset == UCSI_CCI) || (offset == UCSI_MESSAGE_IN))
>> +		ccg_op_region_read(uc, offset, val, val_len);
>> +	else
>> +		ret = ccg_read(uc, reg, val, val_len);
>>   
>> -	ret = ccg_read(uc, reg, val, val_len);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -559,9 +621,13 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
>>   static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
>>   				const void *val, size_t val_len)
>>   {
>> +	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
>>   	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
>>   
>> -	return ccg_write(ucsi_get_drvdata(ucsi), reg, val, val_len);
>> +	if (offset == UCSI_CONTROL)
>> +		ccg_op_region_clean(uc);
> 
> Why is this needed?  You have not documented it the need for this.

When we send a new command we need to clear out the previous state, if 
we don't we are seeing those timeouts. When we issue the next control 
command we are expecting a new state and so it does make sense to clear 
it here.

In general, I think we can improve this patch and add some more 
comments. I will work with Haotien and Sing-Han on this.

Cheers
Jon

-- 
nvpublic
