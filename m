Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68367051AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjEPPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjEPPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:07:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF52D5E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVMpSiG0Pr/kBjf0ICUEpQGBqCWYFPaUEOb2tZKn3CR4u9394egiu4Oi+oYSZ+oD0gLFTOzTmKWlx5/C8WJWnZ8Od1AxDn54p99WyH3z89qa8Y/VkE0LuWVP2kMnt5SkBDAXZYrKjqQ6ZNpYxtG9No3jDFYL7Pm2UpILACt0/hK2Z0Ykd2lS0jiMdOQgp7izsgVgRZSGEy1R4s4jvgMz60DbgP4+NKluqEyXNy3II+wM7tT18CqPotb+Fyez8d29roXiYEs5oURGsng2+vDMu4+bDUwyaNUtWk1H4N388CAb4vxU3dFEI6F7+p8R6qfVkv8TIbFe2mKKKPVNLGgezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLKnHG5qKOFQR+VTpm2/xK6/5CxMnR3K8JR61byofY0=;
 b=PXcjv2UMWHK+Imo6Vro27l9KrC6cmBsin6j91lf9pHoIkDvXrDMcS7GBh5jZ4DZSfopzuEQBNVcWO5A2RS0/awRYTngJ2CNeOeY21kydUogu341XPUVTP6LKzj/QT6kCwGFjoTF/Dx7nzqgY7Nrjymdz1TCKYIGAFyXPAgSn3sklYHFCcPR/TmUkNNYIY74j4hVUnQf4pyV1LsvSvI1bCZipJqk1Nn8N3+gF+vm/beNzaKd8+2N/AkP17gK2dK5TNhAuFPHV/KxV4yQJPtA29+z7a8az1G7QVQRBgjxLElkBafVhKHGiEvAcEJkzJi3fK2/XIzgT6Tx7JR2t0pELhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLKnHG5qKOFQR+VTpm2/xK6/5CxMnR3K8JR61byofY0=;
 b=4dkhUkf2jR65iujoqTTGmod002DLn7rV7vdfX/RtlcZ2f4PaM02fXXbflYrpdnQOvI9M1E3rfhFFHqU0HPebqQQGvOMN7wQ54a1qrnkUA/4QO/7JNLxvtrOeZornikmuooP23KztSDN4Sfiyrm5JNCf0jUMbQspyTSVNvrgDkCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:07:16 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 15:07:16 +0000
Message-ID: <c2ca465c-6fa1-7852-26f0-6489fde52226@amd.com>
Date:   Tue, 16 May 2023 17:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] MAINTAINERS: Remove Hyun and Anurag from maintainer list
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org
References: <18700dda117076510baf87a090acbb29cb3ba3ba.1684244832.git.michal.simek@amd.com>
 <20230516144516.GC30231@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230516144516.GC30231@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0102.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::28) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf142dd-b0d3-4d52-7ec1-08db561f3c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlpzjtoId2ia5iNniZ+qPenBrteNhuuxfTVlA8c36eS2q3DPRd68Vkg+iFVrJgwZu+bXC5n/9mX/E6pEoFJU2ytuL+w+4l4A97G3jN+2OxPFwrzL0L8erFtzmn1Tp3Xwy1ufey1qVsLQhsIWb5l3WR2rXacYk42Pg9lra3YjWmguGvwZSHvjj5fH7nRwzViIDnObL+kxF0OshS3aSzECIzh5i2+2nxBZy8qjpUjW/nwkLoo/cNC9i9ICSp23gxJaIwj8bpH1+8qWcT4LqalqX79Q4LeENpieN2eImzDJ8Qzo9sMT8RQz/E9s/DLVGP3eCGEN6obqNaSmK9wwuYlMT8j6ishwkLcoWURqxJef+rqK1DVCnGROI9AI8cKkQQ9CPTpd93TJavbyT/umDPaoEfI4Grspu5KObgOta4E4iRVdPFAGhse7bdO+BbClW+4kyUplfq7/rFpetIrk2T2UHROuW3EXgdjxc4iehLeL1511DXX8jS75LnM1iEdemS0uXWO+mpTZE7gg21EVmu25wXcZMxUVL22efTgJp7kfbmk7dVXJ2UtJbiZMiXT7TPPE4lgaWZHHR5zmQUFj7n5f0t+U1w3r5GJG5nESD/yHQRnlUaLikpLWSKPM1Xc8ZrzthECtBgxL4K+1Ix1vPXYPvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(66476007)(66946007)(2616005)(26005)(6486002)(478600001)(66556008)(44832011)(6666004)(186003)(5660300002)(86362001)(31696002)(4744005)(8676002)(8936002)(6512007)(316002)(2906002)(6916009)(41300700001)(53546011)(6506007)(36756003)(4326008)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVJZ2doR2VZZDBvT0NLNWFhM1R6N1lpMWpWdGdFeDVVa1N1ZUpZYVhqZnhZ?=
 =?utf-8?B?TXc4L3B3QnMwa3RtM01lakRIdWxyY3ZvRVhpdEN1WmlVZnB4aHZ6NW05QXp4?=
 =?utf-8?B?VmdnWC93bHdVVlNTVHZQMm9tWmt0SElmZWhwdEZiZVdxRTR1cFR3Y0NBVFZr?=
 =?utf-8?B?ejhzUHNreTJjamROaUVtY0VHT3hsU1JMUDhDVnBhMmdHSXUzNmF3cVlTdy8x?=
 =?utf-8?B?WXhSaWxMbTRQaldOVjRXU1Fua1M0eVYvZzJuWFpLMEhwOGtLblNrM1VQUXly?=
 =?utf-8?B?SjRwQ25PKzV0OHY3Z1dOQkFkVHEwejU0Mmt1THpDSVliYUlsMlduZVhhODBC?=
 =?utf-8?B?U3VHV21XbUhNbC9wZFNrQ0l1RGh3OHpiSi9yMkt1dWZYeFVqZGJWVnpSQ1ZG?=
 =?utf-8?B?L2tGc3p3bDlNV0xhOERKTjRZMVVMbWdKSXJjTGxETmJlN2REblBncVRuaU9i?=
 =?utf-8?B?dW1YcDhNcUVRUEY1azBVRWI1MjhPcGRKWCtnbno3dk1CeUdvRG44S0dRd0ZI?=
 =?utf-8?B?R2thVnU2djd2dDgzK0ZyMUZIb3E1Y0tZNk5pSW9Nd1pqb3huTjRYZ2VZU3Jn?=
 =?utf-8?B?R1NraE15cDkydU1YbjQ3eTF1clY1OGsrYlY2d3k5Y2pScm1BUmsxZzNjN3dP?=
 =?utf-8?B?WVJZckNqSkJoejBKZXA0Q3NHQ1RsckxvOStXekpybmtsaFRMVVkzMUFLdGVn?=
 =?utf-8?B?NGowaU9DbnpRVDlQTzF5c1VVWndzOTdaUklqcGdGeVo3QXpldE0wUjNzSnhO?=
 =?utf-8?B?amxIN2tDanVUU0pBakdaVDJnZU9KNlVWdUtrcVlGYzRtSURiYk1GNnBPc0t4?=
 =?utf-8?B?alFPbU5aQ28rTjh3S20xUVhFUVFmTWtmZHNhM0hscExnSmpBYW13U0dkdXhG?=
 =?utf-8?B?T1BoSm9pbS8yT3o2VVlVQWh1d2RQS0Q1anFTVDVjZlVzZVpLMmVUbVNQaUtl?=
 =?utf-8?B?UXNxc0NRMVFHNm8yeGFldUc2Z3RnS05YV0FMUVFSc3hveFRhbUhZVHkvQlR4?=
 =?utf-8?B?Njl1and0S0s1ZCs5bjhxVGpnblJjUGFOeHlPZUZlUFFaM3piWnRXaHJUT1h0?=
 =?utf-8?B?LytEUmZxWGZtci9WbDN2bUxQMlNIem1GSk5KTzM2eWZBUWV4VXJOd0k3bVQx?=
 =?utf-8?B?dXM2MEFZOUVxRTNxWFZGVGNUNUMwVDN3RjdPU1ZJNjJiVlFYR1pQSCsvN1l6?=
 =?utf-8?B?dFphNWtJMmptU1k3QThRQXhjVnRrV2h6RVRsUG9nUDA2SVBjY2VPWmx1ODVK?=
 =?utf-8?B?TG4xQmRURVA2ODhCOUdrRkJGRzFEaDBJQU1OS0hXSThXTHlRbXZxTVNjeVMw?=
 =?utf-8?B?YmNQMzBQSVIzZGkweS9rT25oazdPM3pXUXNLZ015ZXZLOWc5MVNMZHVqUnZR?=
 =?utf-8?B?a3d6clJxdk9RSFN5U1RaYWlRYUdEN1QwenIwWTZLQlhBYmNQS091QjBJNzN0?=
 =?utf-8?B?b3Z2Snl2NUFSWWgyUWRRYmFvYnZ3QnJ5Wks4bVJFb25vajVDbmJJMnBpRWJ1?=
 =?utf-8?B?ZlNMZnRIejFkcGJqSG1SVWRoazhyUnB3SmNwV1p6cTNLR1hPUG9xQ0hjcmNk?=
 =?utf-8?B?SzRKQkg1Tjd5LzdSNytWc3F4NlprYzZLVjJTdVJDMFZkWHRyR2N5S1BkNEFi?=
 =?utf-8?B?dS9VL1VFY240QmFhMjgyS2ZlVWhPTGJIVXNLWTFLV3UxYU1lL0YwY3IzV2Rj?=
 =?utf-8?B?TFJ1Nm9ZcERPeVF3K3VLNmVkaHhmdUtmNWt4ZUIxcTgxZ2dWdFJXWkNNb2xX?=
 =?utf-8?B?TGlPRU1PK2VoOGxvTS9rK2tWek1CUXhVNERzbmcyNmlQRmIzcGtkaHRoRnZp?=
 =?utf-8?B?blVoTjBBR1ZWN3RIZ2N6YTIwZm9UREhWWDV3Z2QvdHZqd0Vwdnk0WXZjTmNz?=
 =?utf-8?B?OFhBWmJjK25DM2NuNW9ldHhUSkx0Wk1GK3dqSzZlMUJ3YzNvZVRMRkY5dGdr?=
 =?utf-8?B?U3pqTy9HckxWVU5MUk1oS1pjdlAybWRXYit1TmJsTVpqSURXZXhScVEyNVpq?=
 =?utf-8?B?QThnMk0ya01iNzVEWGNlMXpRK3diak1SME1mYnZiMDJyUnZ4YUwzRnFuNG1x?=
 =?utf-8?B?SU1XaHFjSXRkRU04bFkxd215Y0ZkelpPcW9PRVZCak9RZHBxZ0t2VTJONVJp?=
 =?utf-8?Q?cwijHgWxNhhPV+/OietKAQVDj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf142dd-b0d3-4d52-7ec1-08db561f3c68
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:07:16.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WU9RKp/5CvPtsAmF3BONwmlZ97cJwLeXibCxp7c/Oj29He0tCTPzQauJTFyoiaQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 5/16/23 16:45, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Tue, May 16, 2023 at 03:47:15PM +0200, Michal Simek wrote:
>> There is no activity from them for these drivers. All of them have Laurent
>> as active maintainer and their emails no longer works that's why remove
>> them from the list.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Will you merge this yourself ?

That wasn't my intention. Feel free to take it via your tree.

Thanks,
Michal
