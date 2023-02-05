Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6096168AEB0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 08:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBEH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 02:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBEH0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 02:26:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6B23137
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 23:26:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFBa8heJ7Ny45C+7pb1UHhpfPyQ6zltG2bM0Uj3+2UZKP52Bln2vsGwxfY7Ptzxv2osdIIQlcGprczOVrp8Svq8OSAYbf8p7gLI8MP+5osLTfpi75/y7CwXumMOZA1vi2eDrNC1mAVhKLZ3abQMtbmc/+hwjY1DTmP+9+gKawt1kVt0kMMOMeflzLfgqSpcmQhwHie5yFpb29YmMGTgzIoqxzVMYni8Iq8es07s2DsgE03OaoDwgqL5akWAbvGQBcyjogZt+ekCD+optVS1QlzC91J58uKlHtMYwRyN4ELeF003s0LBl7qEzDSz4WHpa99db1pV6t5dY7KGIggpoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFChS5RyYuYl8e/JeakTYFnDeKSj/JGxCuZGT1VaqYw=;
 b=Yw9/Sueou+rtRw46oE7BFzZjTTOtNFDmDhJjWo5hA4vvYcCUUjZ7Ja6mFdV2N2k/3hsiLI0caqMwoPpmtRtERK2MUzYWqKg73kgA43WRK4D7O8FPFSuyPEHXstqco2yxZiJVgeB/QsdhIWarGR56FKv1kMwteCAIUXy9uPTm9VkuvWns2ejfsyzOKLuQZhbNEaP3JzrIWP4tBcbJ/ATzgIhb/F92RzxPQh+1OhsyXZwGocAjN4Rh1f11glaxuqArw1fu+hZowCPuAdwECmke69wuWfkkMDmglla93jBGyJt7grTNMhybeGtYRZqe+5DdnmSDt5hvfS0GUulUXSp7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFChS5RyYuYl8e/JeakTYFnDeKSj/JGxCuZGT1VaqYw=;
 b=uYhS2d3nmYADFAsyUZ9LhJGOruo1YjAyqqq9p2M+US0XlCr2oaJ9LHS/lE8hr1RgYdfXqRh3NQq75LAG2TbzfSlEAnIb33wjzaJT4gQ6KmMVkG8SIjBHw1TxSoTRjyjuHI+ftWxdOd2/Se0e5pHbu8+I/oyXT/VWS82mpwQcnJMYcgArDOK3emuoQKvu4MJVN6PXVoLmfjfaeXu9IyS2Mbej9ATcLe82T5VZUdXt5JGmCetjCdU2J09GnQBBCrP8xQmk/3HdU8XG0pIfJfpSRT7+jTeFfzWsv85hLnAkjpowUYBCmT4sWmQzkPIZvxEUPfOBvPNjsLk/Lo5gOHizwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Sun, 5 Feb
 2023 07:26:27 +0000
Received: from PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::87e4:2a28:53f6:1b89]) by PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::87e4:2a28:53f6:1b89%8]) with mapi id 15.20.6064.032; Sun, 5 Feb 2023
 07:26:27 +0000
Message-ID: <14bbde0d-6f4c-9615-0fff-ca68e81c073c@nvidia.com>
Date:   Sun, 5 Feb 2023 09:26:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] vdpa/mlx5: Directly assign memory key
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, si-wei.liu@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230202125718.1013961-1-elic@nvidia.com>
 <20230202123132-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <20230202123132-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To PH0PR12MB5401.namprd12.prod.outlook.com
 (2603:10b6:510:d4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5401:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbd4bd5-ce18-42dc-339e-08db074a4ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6zFzH2Y+dMvckqzK350HW7zRJwIF1EhsiF+gIbxWsEzm1WARWmZLErpdNexHxoM061DRIP/bzHm9+zvtPv4auMcemG/9Qx5iJGOHJtOhuT/oEuDKRpNXcbf8A33fNh+Kdq/1HtDSwQjM3r5JFaG4dQoSh7VTjH+I4vKoYZF5rpTBP90MpCQxHBbMjftUtorybmuiUIXIj4CVN20dGUeVfoT9+bIHvBej5xuFPU3esyU8AGHdRuzzTdbwDvCoQAMpT1ibWTj5uhWvW2psOFqQj9S4i7J84PeBN2Gh7KGA01wY1/b8ozkNSlXhUqxJBZmY3MQRK+kHhcDP1jlgfPVEzv5yr+OaX239kdCJG44HnezYLUomSCyYAA8DtBJfmausvC+vRCfWZR5MAWnx571yhw7Q0r9ItoJqI7OE4HSoMPYhKr2F5IuTC1gH9hU4+dItzTQyLat8wpEwzjuxX6vHt2zzZrYCLQ06JhxCskTODUm+oD7qxCJ5LNeXH+ifp1qlb57v8L2Ismpu6mdXK+ZHqttZ0iIcPb6nwtlovNxTCIzV/yN6XPROKsCspnNYwNTOeTVWCYBVEFg9bCz3Ke/gyy8kfUX1IsxFpA/IIVomKziqMSoLVYuwphTpAgtZ3JYaZFUUlakEtPdXAGP5Jw4PgE2jjh/CnjaXKOnlugfBh+dhaZ/WNROh+BrLnJC8EKg7fiEi70Usg5uogbtx2gK0V6Kggc57eUGZbHTdvMTqjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199018)(36756003)(186003)(6512007)(26005)(4326008)(83380400001)(2616005)(8676002)(5660300002)(6486002)(41300700001)(478600001)(31686004)(86362001)(2906002)(8936002)(31696002)(6916009)(66556008)(66476007)(66946007)(53546011)(6506007)(316002)(6666004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9odDJSNzVPNXU3dVRIRXZFQW1TanJ2SGhZbUVrR2JENmNYdmwrU04rZjFl?=
 =?utf-8?B?VUUydVFUaFFSN3AxcHB1NUVwVXdWendIZ0FWbVRhSkJpNTE1RTVlanNrM053?=
 =?utf-8?B?T2pFSk1kOGozTHgwRGx3ZlFWdVM0RVgzd0dXdzY1cEdWaTR0YzZ2bjRLcVB3?=
 =?utf-8?B?alYzZURtcnc2NUtjRGl6N044a1JiMGVvZG81WjNGQjN5cE16UkM0dWRKVzR3?=
 =?utf-8?B?TTA1aHZ3NVduYlJNeHpFMG1oa3JjQnNDYlhRZzZjK2dMM3dPOW5HQUZXem1j?=
 =?utf-8?B?Slc3QVdYZFp4OGFKdmt3S1c1Qk1lRkY2L3RjaWo1YlgyTm9rZ3U3WUJxelV0?=
 =?utf-8?B?RTExbGVmKzNsVEhEc2JqaWhsWkNCUDZ4SWs0dG16RlA4dVduRnZ3cjJ6RUhQ?=
 =?utf-8?B?d1RoY2swN3VOMGJDZHdyZU5zM0pRVHo5cmk3b0pEOWVML1dmbHVTdkFOVndz?=
 =?utf-8?B?K1FTSHhjZStZOHcrTmlOekVKaGNmNk9IUVRvUjZlSTV6eGNPOHdXQXNuWUc2?=
 =?utf-8?B?OFVOMnJCdWs2aFNjdHN1b2xkcHYzSXBTUEtYM0NiNVNzMzZCSzFsL2c2RlJq?=
 =?utf-8?B?NGtqcCtvRmhweCtmY0huZEhaSHFJeVV3NEMzSUNKOW5qcjl1T2h6TWUvK1hl?=
 =?utf-8?B?bEY0YnhFb0N5eWRnd042ZCsvREtmWW50T3hnSUZiVTRLQ200azlnOXRCcWNV?=
 =?utf-8?B?ekJ5NjB3Z1BGdk5qWlFSK3kwbzFEWEZUWVpFbU9NM1lRT2V5NitvK2FkZjA3?=
 =?utf-8?B?Sm1oWHlLVzFtaTQ2a09qcVFzSDlhSDdWRDZpR0R0cXdMaG9JUzhLcnU0ODMz?=
 =?utf-8?B?QWZtL0tjdWpOUzNjVGJtVyt2U0kydXVaSUVkQzhjM3M0NTZzc0t5bFR3SGlI?=
 =?utf-8?B?L2k2SWo2b0h2YnkyWFVVU1ZhWTJYS0xhMVhUTTR1SmtlblE0SEVDbWhLM3Aw?=
 =?utf-8?B?QkNnOUFzQ2QzSlhseXIxcmg2N1MyRlJIaTRYcWRWVkV6Wmo0TUk2THN3Rzlj?=
 =?utf-8?B?NHI5VWZCQ3J3WndQYnBZNXJRcThTNEZ3VjBCdzE0SFNMZCt2aExjNzM2UXha?=
 =?utf-8?B?bXFOWEo5T2Q1R0U5bTdjYUh6YnBneFdDcUpBTDVLbXNjaCtZL1c5STRwUSs2?=
 =?utf-8?B?Q0pCZzJLU3FrQXBWa1Z2MXNsdmp1aDNQc0x3Z29SQkhYc0tqb29CTFZoaVFQ?=
 =?utf-8?B?Nkp3NUZSSWh5YmpaWEgvQ25aMUNaWGNSbTh1dkRjaG4rWG5ub0hIQzlkL3Nk?=
 =?utf-8?B?R0NmNFIvTkJiYnNsSDFwaW1aL01YdU9aRFYzejBDQXV0bGZzL0JFUmZBWDN5?=
 =?utf-8?B?QzQxOHd3SVkvNGp5V2RYTDRXTTVGUUluUmZuZlFUM0pob0EwUWt2bG9yODBB?=
 =?utf-8?B?UUFLTU9ucFhSUkU3MC93VG03SnJFNys1NnNtTUhvMHQzdXFOYkhRSWVvTmlU?=
 =?utf-8?B?RXpRV1JlcjdNZW1NdTY0emtPN3IzOHZ5WGdwSFdyaFBuWVhxZXVibFd2SVhp?=
 =?utf-8?B?OHhxYXJnaGFuRzQ0aFh6VFF5YUZnRzI3SWxqR3VJTTJmT0xuSTVyTVp4VTND?=
 =?utf-8?B?Mk1pNzBjckF1T3A5ZHVxOWZDclBPWGhOZUQwdlNzajVEdDF0bU1RYklFUEFI?=
 =?utf-8?B?RGlmOVREZlJnYXVDUXo4RVF1SjRNazQ1K2hUejNDSEpwV3ludTV4TWVJTm5W?=
 =?utf-8?B?Q3FybDdwZFBkMWFIRUhBQ0ZJZ1phaWJlRW1tSDk5Mm0xT1JhMWNLWTdGeENz?=
 =?utf-8?B?SVFBUTZhVHZDZVRlN1J1OFFTSVMrRG9sT2lUclozQVJCbHFQbllqaGNaaHI1?=
 =?utf-8?B?ckpCVVRUTFM1NUJkelRmM01obHJNM0ZIeTNlaHo4S1JxOVZnMzJJMTJFRytr?=
 =?utf-8?B?S0w1RmhMZEExa1pJZjJ4cUpQVkxoSkh1SGxLSDZ6aldocWF2bmpCSndtMDAz?=
 =?utf-8?B?N055RmQ4ditCV01LelM2MTBid21TUU9PRUl5ODdBZGFYcld0Wlk0ZnlSVG83?=
 =?utf-8?B?dmhFQnJSQmJTdEVNZnNnVTM1YWNTQUtOSDduQlpoc1crZ0xRQ1VlUUJjWXhh?=
 =?utf-8?B?QXdiRi81QTY3Rm1ta3VuNXNYZmZEMjd6SHpURkl2RVNoaFpKYjUwMWRJR2tO?=
 =?utf-8?Q?DJDRk/nPoQdbMDtmtUzF/ukuN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbd4bd5-ce18-42dc-339e-08db074a4ae7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2023 07:26:27.2771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8an3dxh1QD/cnCWarC3u1Jrzs6TEZaIPLTD0IUpizTqjDOiLkyMcv5ridr9DcyL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/02/2023 19:32, Michael S. Tsirkin wrote:
> On Thu, Feb 02, 2023 at 02:57:18PM +0200, Eli Cohen wrote:
>> When creating a memory key, the key value should be assigned to the
>> passed pointer and not or'ed to.
>>
>> This fix has is required but had no real impact so far.
> I don't get what this sentence says. Both grammar and general meaning
> elude me.

And I can't blame you for that.

Re-sending...

>
>> Fixes: 29064bfdabd5 ("vdpa/mlx5: Add support library for mlx5 VDPA implementation")
>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>> ---
>>   drivers/vdpa/mlx5/core/resources.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
>> index 9800f9bec225..45ad41287a31 100644
>> --- a/drivers/vdpa/mlx5/core/resources.c
>> +++ b/drivers/vdpa/mlx5/core/resources.c
>> @@ -213,7 +213,7 @@ int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, u32 *mkey, u32 *in,
>>   		return err;
>>   
>>   	mkey_index = MLX5_GET(create_mkey_out, lout, mkey_index);
>> -	*mkey |= mlx5_idx_to_mkey(mkey_index);
>> +	*mkey = mlx5_idx_to_mkey(mkey_index);
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.38.1
