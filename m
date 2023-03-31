Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541F96D22B8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjCaOdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjCaOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:33:38 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B8C7A8F;
        Fri, 31 Mar 2023 07:33:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqCHKcttHAhL6tXyhoLOz7y6rPObqixZQVwGLz64ptCymnwQLo4LbLasYWXVA++XUFEJEzNueThWXeMcXQWSPBUH1hfzRNcHgPqp1G2n3UMcZ/zqHqRIZDw2Qq0sbd0itS1iNd/7KBcw5XFe7Q9Be0oNi0TdPM/HfCDlm6Mlk9sfnZKHLm/N5cODlDPZ6YaDVs01ewJMIh2AztjMETQaik80kd66w2mU5pHv2V4M1/K9fmOtjfpCeSDMyIy5fQGyXKRr4VRM6Z8rX9mKrx6JORY7RuvhmRiatFWFwBKuMNmFJ7Gf3xrpDmUEokLPChsbGCbFHy70CLLQCBcrEXpMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xr0oBZRFN73j3Bc6FECET/2XJP1tEgX5k+ZH6xmqtDY=;
 b=ZFbXvkpAx8t1U7S8IDmPTggZ2qoX4GkGslsRWBAyNBhEyP+2MfGKhbs2IOJrL2nhGgUYa1D2YX4lKflKaPGJUcxWTyQZVZ/qeGx/7kxKsbPzDopJBMRRXor0eJJeJAbgBB5YL/u1cZT3P6s4CO7f+KEHq1dTbpOIevmy9+KPSTG4Ksm5CReRulmIgnI7qWs6/I2j6rdANs+qaL+657fjSHS5dR2+GpYO0yE0hBlh0cDWSg0s/Z9eIToguvjgh6ZqW5xLT1ImXycHY77igfZ2NiMRVf3JfwVEX8DZj6I2LjXhBHDS5437At4Ys4y46SwtXScY4ajMwtYhjPD/5Lj0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr0oBZRFN73j3Bc6FECET/2XJP1tEgX5k+ZH6xmqtDY=;
 b=pRInXRgXNOedolytuSH5SkPbnHt6uEdqP2XNPcQK7j8ppAX3fNpxjWkJKwVYlhQQ8Or4XaR/7oRStR0NNPfg61wCk5mg7YwjZv2qUkZk3J7UzfKkamj0wtWPje1djJyodisv5+7cDocjAvSEGrzGkdZdeLyJ5KsAaIxeVth3XBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Fri, 31 Mar
 2023 14:27:55 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8511:7da:3d1e:4db0]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8511:7da:3d1e:4db0%6]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 14:27:55 +0000
Message-ID: <d7a4460a-3f26-ae30-3eaa-cc72ae0a51e7@amd.com>
Date:   Fri, 31 Mar 2023 09:27:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] docs/sp_SP: Add translation of process/adding-syscalls
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mauriciofb@gmail.com
References: <20230315143526.1213813-1-carlos.bilbao@amd.com>
 <87wn2ziin4.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87wn2ziin4.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:806:a7::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4750a3-8d0c-4ee3-b9f5-08db31f41e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40txgLAYlbnysYgHYXB6hiXYY0t5jT/gGaOqagU37ih85eKU5KGHcoHqhmTaEPmFrMQKY3gS+XyBwZQpJBs3o+Kg4jCbO8JY+XfNITxgOCs+l3nh7L0+DPGHsJeZmb96qQmqVLxqhK1PxxPlgUE+lxs1w/Sw2jTe288LCYfdudtSjORAWsk1iNPuHcUGnSRzHnnSpHsCT6jAGFNkLN6OM+x3uq64fk0vAINS8RjJUlVQAOs3EFYxG7zES39DKPYcTroFRB7gyBpp0XKaABLv3ddQ/beYNE3//1Fh13JQtbWXP9kGZ03Ia4SHRrNq+xTEk9YiA27rEd5uiPQMsH5eYSXj343lRnurBn+oI7boiTWz7x5o3QHhdwMcKbbqXylud29iL9ST0JKmBF6e+XLLjx3v+AvSs4ZejgRhvIo5FUQ2Einjy3FTCL0jBsTuhjnz4374YdoNoZAoROh7oHB3MLB+cd20MTdhJfZ47G6ddHE0xDegew5dJJqKmN96Zmq6292pddS8Pij7SZmN912h2lzGZlRGN0f2ggu3pp/3BJBc8sCsZOd/BjwHHeKi+eCVHb/Uh7+Ch1saWd+snb+gxpR7jXl3qQAMITvKhl0czdwzdfyDWMOw5ANubYDoBLNTv7mgClfu7mL8651r7VIOCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(31686004)(44832011)(2906002)(66556008)(6506007)(8936002)(86362001)(66476007)(66946007)(41300700001)(6916009)(4326008)(8676002)(478600001)(53546011)(36756003)(316002)(6666004)(6486002)(6512007)(5660300002)(38100700002)(31696002)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODVWZmQrTFl5bkpXcyt6OWo2Q2J1RXhRd05JM2ZBVGN6Mm9Dc3NaUGlrcC9O?=
 =?utf-8?B?ZkRNK2xhbnBYNkhONHU4NGRHM2RYUDBObHY5U1Btb0V1WWI4ZENDYUR4WG8z?=
 =?utf-8?B?TUkvVWlHNEV6S3Bmd1B0a3JGd2FUMU5MZzFiZXZYcTlxWmFjaDNJbnBJcTM3?=
 =?utf-8?B?c2U2aEM5UmVaUTlnS1F1enptVXl5a2pVclFNbVIreWlEelhUS1dtWjNYNnZp?=
 =?utf-8?B?L2phcHNPYi9PM0V0VkhKczcrS0dKNkFqdks3Q3VDUFhzczdhRWNxbnFodWd3?=
 =?utf-8?B?U0hYN0NyVzg2WGNpT04rQlNteCtKSXZWci93V3lmQWhnTGRqbFd4Tk5BVzE0?=
 =?utf-8?B?MkdwSVkrcFBGN090QTg0Z05QMWxWbk5TVlFTSW5TZldIN0x0cWlsL1RmVHQ2?=
 =?utf-8?B?WlhzQys4OUJkZkFTTXFIay80V3UxK2gySmY0aDh6aUxkWEtTM3lWMWFzRG5P?=
 =?utf-8?B?RjZSekhib1N6eDdZVFQxODBzWmprR0JJWjBrNzYzNU5VOWpmbWhJQnV3Vzg5?=
 =?utf-8?B?THVMYXJ5dEE0alhscmk2NWFjcElWSGVwanVZdkhHeGpKRHU2VUw1ZXJPZGNR?=
 =?utf-8?B?cTVhYjJpRmhVb2lxWUpnUG9vWnl4dWdhaHgrSExUTytlK3dvcUxDQ01HL2po?=
 =?utf-8?B?c05jQTkrWUtVeUtsN0paNnBGTUdVZnVCa1I1UmJyMTFhdjRJTDVTTGx5Szhx?=
 =?utf-8?B?M0pNb3BpUlNBWlpwbTdtUFJyRm1CRXUvZG9Wd3JuL3FUOXNmeWZ4aTNWSldv?=
 =?utf-8?B?TzBjektYaS80TTl0a0NtN25mdk5iQyt5YUFac011YmFrcHQrMzdTREpuTjZn?=
 =?utf-8?B?N0dkL1FXMGNMWEErVTc0aVJuWW1YK0NRbXBTNjgxZks1R0kwWitwd0Juc2dE?=
 =?utf-8?B?RWZ1VHp5M1lYaWh6KzBRUDJmcTV4OGNDNk1oY3h1SmVPUmNCN2hvdGdINFFO?=
 =?utf-8?B?MHNtR0ZNMUNEL3lnRDRycFUxRUdxcGtpTHhQYjF5dmV0Mng4aXE3ai96VFBj?=
 =?utf-8?B?NTdmL3VNL0JNK2tha0QyTmlJNGpxZEs2Y0QxMS8vc2wwVlc3dVN2a09GdWh5?=
 =?utf-8?B?TENWTlR6U3BmRXVSQ3Z3NHVMaXY1czd2YnhBaHJLeHVpK0JKTTlkVmkzd3Ew?=
 =?utf-8?B?YmVLZ3RyeFZ2ZE5TaXN2K3NnTTcxWm1YMFQ4ck5MYUpGRy93NFF1WGhQVWJ0?=
 =?utf-8?B?cXZoKzR6dDNvclM4S2h0WkRPQnFiS1Q0QVVqdi92QW9zNDZPLzdwN2R2Mnpw?=
 =?utf-8?B?RWJEbzB5R3JBYjdqcVJOZVVxU0tHdHJydHpCbTdPVHkwbHg3bHBZeWRRRUZB?=
 =?utf-8?B?cWRXN0ZDbyt0MytFYk1Ka3B5Mm1nNTcxSVp5T2NXZzFVUC9wL1FrT1VNS1N5?=
 =?utf-8?B?QVJUSU1zY2Z3TjdZQWJHNE9GaU0zMjR6enQ5SUlHWjhDNUtScm1qNCtTbWhF?=
 =?utf-8?B?VGJXMnRYWW1raTlIdEI1YUxSOERUVlExZW9ZVHowdkZIZmpPeU5wN3Q0STFO?=
 =?utf-8?B?akNpODlCck05eTNSVkFHQytJZ0V1S1kzdGtiVFpXVk4ybEFWbi9iQk5LQzJF?=
 =?utf-8?B?eGRpamRsNUhnK3A3eUpCMm50WFpBeEdEOURLMERLNGtET3cyeWlWTjdIbGxJ?=
 =?utf-8?B?ZFpFV2loQWVBSUVaLzVKM2JobEEwcDUxY1k2QzhLTG5hS1ViY3BSekVvcysz?=
 =?utf-8?B?MytnZXZDbzFmVDNnSUhkV29QZEp0L2JxR0dmcXhmWUdtMjljQTRFcVRjZVhv?=
 =?utf-8?B?a2c3V1M3TTQyaVdxR0lmU2dtTnErUFNhU1Z2Ym94bGdtdjF0ZG1Xd3dLd2FF?=
 =?utf-8?B?YVNtYko0N2FDTXdXTktCOGNSejlkdk9ORjBRbDlldzRlUmdveDRBT0ptTnhD?=
 =?utf-8?B?SlBqdWtHK0p6U2JaTktrNjZyZlNUZVRFdWtTQzVxODBKQm1Oc1pLWnRoM09r?=
 =?utf-8?B?eTdKbVh6enhoSUlRRkdoYUtZWUZtU0JCRjU3NDlZaWV4RGdmZlNQUk9JVGdV?=
 =?utf-8?B?b3QyelhqWlk0MmM3YSs5U3NBcEppT25FdmxqMW9aZUNCUFFCWThFUFJiVy9F?=
 =?utf-8?B?dEM0WitSOGJ2RkJ0Uk16ek5GWlFmSXNyWVJDNVpJRHVGK21laWZXb0VXUHB5?=
 =?utf-8?B?a0l2L21qM2U1SWoxZWJxMXBwdVpjaXVteHUvR2ZOWWhNZlZLbW5ReVNHaUlT?=
 =?utf-8?Q?0snIVvCZ9cW/gsJqbuSm8o9p1PBrt9eolMxf0tKs+8XM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4750a3-8d0c-4ee3-b9f5-08db31f41e66
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 14:27:55.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DBFZtN8dy6w5ZbxMe6eUKgzjJ0xNx2y3gFGr/a7jmcPiBtkXrya8BS5DXwr1sm4L6pQtFs0nA/mgkKsn4CTzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 12:15 PM, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> Translate Documentation/process/adding-syscalls.rst into Spanish.
>>
>> Co-developed-by: Mauricio Fuentes <mauriciofb@gmail.com>
>> Signed-off-by: Mauricio Fuentes <mauriciofb@gmail.com>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  .../sp_SP/process/adding-syscalls.rst         | 632 ++++++++++++++++++
>>  .../translations/sp_SP/process/index.rst      |   1 +
>>  2 files changed, 633 insertions(+)
>>  create mode 100644 Documentation/translations/sp_SP/process/adding-syscalls.rst
> 
> So for whatever reason, I can't get this to apply to docs-next; care to
> respin and resend?

I checked the latest version of docs-next:

c3806d572040af7270ddb2bead501e5589cd75c8 ("docs: move nios2 documentation
under Documentation/arch/")

and the patch applied successfully. Could you please tell me what error or
warning are you getting?

> 
> While you're at it ...
> 
>> + - un puntero a un struc conteniendo un puntero (por ejemplo
>> +   ``struct iovec __user *``)
> 
> You might want to fix that "struc" typo :)

Oh, will do, thanks.

> 
> Thanks,
> 
> jon

Thanks,
Carlos
