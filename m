Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B85716324
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjE3OHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjE3OHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:07:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D4B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG9jYYA9tuyUQ6UoF7+8jmZbS88U84GU9X/bcXgjj0Eka3QF8M6sh647PdjXBDKXPAhd/X7I1fwTm3IQXQpq1QM5tFPhRei/WNy5Ir/Z+/8BMtBfgzeGMQaAx/tvVS9ZeSlXSTD9Y6MOW/gdGj5WFWP8qVMuEmdhEgBEVM9+dxu/2/TNC0K0V19Ea2EpdmVADQEan4y6Y7ScFde2jLVgH4dOkZhyEnPuRZQvOojgTCUcXuGgD+eX79vWkSwWqJkXyf1+Or4WXxy6YH1I0SDfCuWFjwhKb4BAtIXQGgk9MxkxniOly8vSvQ7gwFyiFPZo6RHMeJ+WBow+/Wl2FetzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlFpg+FfbJlTAJGzhYqVisiB8Udx5E8bOP8mUFfyD1s=;
 b=XTjq8Kap2gwaYTmFLj93+6BUCAcnGpEjAMyHRU3YyAvvp87T2FD03zjW0SZ01VesSYH4BHSnILEshSJMMfucTuVsGxUVGhxs6Vs2rwBKoND2UW7vZ81vPuUsW8LGw17D6kbVV3kdofKqZaTIVDYMN0hiEgiRuL59eS41+L1kwP3D2QTYT+yM+LqmyWR1qSTLlKQ+LOnVYkvN7zSx/t22f7as4FURXuAuAgHNOKg+J16ghfMQ5ThsN7bgKht/oj0XMVvEj+veE5FYXSavldQ21v1ukTwGYK2mS0jSHgAvtTLCFp1ifF80jwlXVS9fYkkYXrzX35X2GDEdNXN6HHyv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlFpg+FfbJlTAJGzhYqVisiB8Udx5E8bOP8mUFfyD1s=;
 b=qINasptNov6dlcF8xsGKikTrJ/VS9ZlOD1k68iJInj/RT3K4EGgQKgVaLRfnphaq/2VvAUicjjng6faXR+2Fh5XbsJ7lmNDQXifPJHGAdZsYgdhX09dc9lpEJiS6hL36FSfF//uZP6xb4PoydQZOgtFH1wyTehXhwpCXyQtcG6F+ufpdlxdNoS8bdw+Wb/g/xclIpgECv5NsVvOlpPyOUD26ps9BBSR8H1fHEodJtAovtx428nJrl0ZEaFNkXG0DFcy5TLpUxaHR92K90GLAEuPVgQqfC0v7jh3aFHvJ8/XCkRj0/gKkJmoGHLV2VfTJAwVrGDncVjoscs/Ib/c1Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 14:07:27 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 14:07:26 +0000
Message-ID: <9d183df9-7047-0eee-b6d4-b0f9b8d21036@nvidia.com>
Date:   Tue, 30 May 2023 10:07:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Improve code style for including header
 files
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jiri Pirko <jiri@nvidia.com>
References: <20230529181729.15745-1-feliu@nvidia.com>
 <20230530072642-mutt-send-email-mst@kernel.org>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <20230530072642-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:806:6f::9) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3d1ce8-c76e-43ee-68f4-08db611732cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADvUgFJxjNCDUL3Ea6Lnb7rtHa19DiOV3FgzaxTNg728NVKX2Q6J/YWv7Ip2RBcG5rfNCIlAjcTQywlJGn+V4D0VSLDOlBTSrHEdTLYI7SWI33LwDCSQfXwjCQa9KkfV0aG6lKpn3y9rvtlspyPzvieSY7rjb6yQGmeuNsozTfkPzonYpfpNTeTe32rb3QsAoFf+QaY3WLB8PZfVp0avxujrm2i1mECQ52dAJLVdfHQB8W3ZziO/RmaFktC4dbyx1pu0rv0a80FHuPFQbZmJNMhcXlnf9MI9o7VNu3hYuE2p+YdI8DvYpxg6Fi6rIp+LUjintDOjhaezk27maB7k+oaCksu+d+YoP6XEtYs2NCrEvMnxvttABZZLXNQdAeTQQiAtPNPUwcAjbtqCiIxolFRYXt+o9ERtFq8ax4BClBzF0ODYS+rPwJ0CrPCG2uq+8gIdUq2vVYxKw0UHT3PCFkSQX3TIorXt8N0YMmLrehU7fLgwjkp2OwJx2n0bODMDlN26C1CRv9d5Auk9pN2r6bFZQk3II4wxcHhPawnTMClAPRs+ESeXZAb+qiqTQJDZOr8AdJxI8Eci2ENyDZdZZemq/DiNXtxMBP1LRiYmXqFX1yjUniyhSdL7H0d06xvictA8Lh2J+Pg5p6a0WGpLfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(31686004)(38100700002)(478600001)(86362001)(66946007)(2616005)(66556008)(66476007)(83380400001)(54906003)(6916009)(31696002)(4326008)(2906002)(6666004)(6486002)(6512007)(186003)(26005)(316002)(6506007)(41300700001)(107886003)(5660300002)(8936002)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldrMlhDaGtKYis2dnZTcGk1YVkvOEpkK1VDUGJSMEJOaTZaVHpSVjc0cWlp?=
 =?utf-8?B?MUpJQlRWKzZlMEFSOWdpQzgxN3h2azdsdmhvVTh3Vll2TkpMc0JsbXliRWdp?=
 =?utf-8?B?cFd4bUFKa3haQkdIZzZFU2lwNys5bUdBeXY1QWdhWDdVYVkvYzl0YWlBeGpx?=
 =?utf-8?B?TVBncUdmdE1YcE1FejF2eFh5N0JQbTdsdm1SMGtQYUIwMTQvWXhEam1mQ1hK?=
 =?utf-8?B?cmVCRlRJZnVEOTQyUXlXN2RxRDM2NzNDNlo2ejFpaGk5UUhsb3JOYVVnSHBY?=
 =?utf-8?B?dEFmMzhBeU1BRFVuU1VBL3dBbDR5NnlaQWtNRWp4bldDQmNiRDcxWUYwZlJ1?=
 =?utf-8?B?WE1TODZwQm5EUFVkVHhidWlpZXV6bEdQZnlaZVJ1NWl2YUc4RElCL1c0emxZ?=
 =?utf-8?B?R0p2K3RwTkF5US9oSENxeXNnRXhPWkgwcnhUeWcrTHlXZGhqQWoyazNVTXFr?=
 =?utf-8?B?aHhGaE5SL3JPU3NSelY0NHZzbHlOVXc1L3ZncWVwWUVNV1hDVGJXbHJrNVZj?=
 =?utf-8?B?MFpUWVU1VWNBaXdTSzBwdURWMDVkOXBlWUJSbGlGV0Z3SGRST21lRHVpbDBN?=
 =?utf-8?B?SGNkY0lvQXdQMU1lSGY5U1VXMVZPbHdvdGtMdi9LLzJIa1IxMXRkbFRmbE9u?=
 =?utf-8?B?WEQwMXIwZXc0YjdVaVNhTDd1YUFXMVdKVU9PMktSWGY3MllRaEthbW1qRXcz?=
 =?utf-8?B?em5yTFBMYnZJQ2RtQWlvTkpNdllXcFRxQ0ZINE1UQUsxME1KMEVLTnJSdW44?=
 =?utf-8?B?Qlcweng0VENFakpobThyU3lKVXM5ZWY3aHRnRmNiWEZBS0RSdE9TcFM4bWtP?=
 =?utf-8?B?a1J1MGpGL0M3TjlFdWVvazFMdi9MZkpuRnRBSUJKNkR0UmhhZTBwTUVQdGNn?=
 =?utf-8?B?KzJqd2txWTJ4QUVuZUVjeW1QaGxQRElsbThyNWpZVndKbmtUakxPTndHcm1S?=
 =?utf-8?B?TTdHdENhdzExWW5LQVJZQjN0VVg1ZmlzbE53dzJNWjg3MEFRYVdGN1FDVTFF?=
 =?utf-8?B?Qm9zVkI1Q2x6QlJ4Rll4eFZtcWZpOHdyQ0dRQzh2WEhYL2J0dkxUblBGUlNF?=
 =?utf-8?B?SWRyVC9sdXdYcFpheWRYOERrMzhCUEt4YXk5QmkxUTg5Sm9Ha0E1SkVRVWlt?=
 =?utf-8?B?ZUhOVVRMTFVMbCtHWDlVb285Vm1lWUpneWZLTmRNOEhYU0ZzMFpsSEJEcXA5?=
 =?utf-8?B?U3NUWm03bFdTcll3NlorcUhHRWhRTkNNT3ZDZ2NoV2x4Y2lWWnoxNFJtVk42?=
 =?utf-8?B?RVlzOWpnd3o3MUVpRVJEcTFiclRISUZ4WXVRYWtiOGdEeWpwS3R5UVV3WGVF?=
 =?utf-8?B?ZlVJS2ZPU09oTnJ1UUwyY0RkRXVIL2dQcEw5Uy9tVWlrT0c1alIvcVVvelB5?=
 =?utf-8?B?c0FXL2tqSnlLeUdKQkJtcVJGZEZzeDQ5Z3VJdW10dzhMZ0pQMStQTVRoRU9s?=
 =?utf-8?B?QTQzQUt0MFdVL2RweUs1c2dMRzJHQXRSVlNYaW1RbWlIZk95bUpEenRuZ0Q4?=
 =?utf-8?B?eEw0MGdtY2h4cmdCMElEZ1pJaE4vdmRXdjRPTWJkQjlVaUVLNEdBSFMxeXVS?=
 =?utf-8?B?ZzZWMlA4NUt0dlFad0w3MytmdWtIWWRlR3ViRVcrVGhINW1qazI1YTRhL2Fv?=
 =?utf-8?B?RVZKUmJvQ3U3cE55bktKbjhNKzB2UWREZGdKcnZ6TG1aeHF5NGtIYzN5bFZX?=
 =?utf-8?B?ZDd0WWNEQklOUUN4aEdkeSs5ekpxY2xZcWRvYi9tWnNuSkRIVHZJdWxrMktw?=
 =?utf-8?B?RXVqMEZXVCtpTXd2UmtsS2ltMXljWHI5S3dJbFl3aFRYOExhOW02akpyZkVT?=
 =?utf-8?B?YW53Um5CSmxYMnpGdGkyZjNWMmpWekNuc0J0UFUwWk9LZVJtZko3aUZMU0Nk?=
 =?utf-8?B?a25KNlAzenlTQld4RkxJRXorWm8wSWpnajYvYlRKekthaDc3UzBBYXVNekRU?=
 =?utf-8?B?S0ZHY1ZoR2g1K3pVeTIyTEM3QnFJYTk0VHdHZDl3ODBrdXpYWTBITDFwTm0y?=
 =?utf-8?B?OFk2QjBlRG40c01VMXpPZnZ4bTI4UldFcThEanlKb0UyZTAwTTBaVDhXV1B5?=
 =?utf-8?B?SURwL2RhNG5kUUdaTkhxZnN1NG9ZRTlkSjY1WWFxSDJNa3R3d1Y2ZDg2VGY5?=
 =?utf-8?Q?lEL69iDjqg0jDsw/rlFczsCsc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3d1ce8-c76e-43ee-68f4-08db611732cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:07:26.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FwGWcV3z4K9IAnUhukQ7Ij4RpOpbCPie50V44LIrPucZZfIgGLI4Q6lAZ91F2dxxY+oAPlgp5tl+AQpqtdqZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-30 a.m.7:27, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, May 29, 2023 at 02:17:29PM -0400, Feng Liu wrote:
>> Fix code style related to including header file. Include header files
>> before declaring macro definitions to avoid conflicts.
>>
>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 
> Which conflicts? These macros are there precisely to change
> how the header behaves.
> 

Hi Michael
     I think including the header files should be placed before the 
macro definition.
     If VIRTIO_PCI_NO_LEGACY and VIRTIO_RING_NO_LEGACY are needed for 
control header file, we should put them at the beginning of 
virtio_pci_common.h.

What do you think?

>> ---
>>   drivers/virtio/virtio_pci_modern.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>> index d6bb68ba84e5..b21a489e0086 100644
>> --- a/drivers/virtio/virtio_pci_modern.c
>> +++ b/drivers/virtio/virtio_pci_modern.c
>> @@ -15,9 +15,10 @@
>>    */
>>
>>   #include <linux/delay.h>
>> +#include "virtio_pci_common.h"
>> +
>>   #define VIRTIO_PCI_NO_LEGACY
>>   #define VIRTIO_RING_NO_LEGACY
>> -#include "virtio_pci_common.h"
>>
>>   static u64 vp_get_features(struct virtio_device *vdev)
>>   {
>> --
>> 2.37.1 (Apple Git-137.1)
> 
