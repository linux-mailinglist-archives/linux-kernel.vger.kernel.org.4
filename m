Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904646EFAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbjDZTVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbjDZTVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:21:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E64EE8;
        Wed, 26 Apr 2023 12:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WELEMHFVJ/bcdUrk0YSIdaVLvQ2N5nKvchsYt/Orm4CPZ4us9IwPi8P81ABPRGlrFstnWYzYdiU16KuVF5dYDQroRa0yk0Mvu7wReb73TMRxY4oAuxMG4UQW6i2eIsJwQ9++myH8wN8jri4umXghjHEwgagvCW908kgaze/95H1HFTlF2jJiM8jPyZGjCr+ODXhD1iT6tmIXQ28umXCbtsFnprymCsLf0R5GBSAi5K3NCJ3zcDkytiCzfTmtHX0S764EZMZOWfI85PvVXYwiIoyiVRKJ/9K2rYI508sSnO33DLWggs2Al35x5sPnnV51GVn0QTi+/NbKodCSJ+b5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ni1zKN4gkkhr9hhuvqlZDIqJmtI90m/n2C0/Ot2LFE=;
 b=nu5iSJ0v2oXVoofmB5aKihvVgHIUHFbsu+K8+MeXfrTUx0dygGXPcSSXuZ53JB6GFw57ctqQcssxFKSrT/N/Oqpg+/+wL7bJp3puCRssxuXCxiJvMMa/P488zajpovEGzYgpw+SnNx7eIwoabF1a5Jus3je5epchVOtXL0KBpclAOaEUH5MarbJk6OiVdBUbxSS/Wy9EUBQ9+Gp1nluEaDLPXPPqpx9aHB+KiN9jHnpqMSs8U+gcskeMuZ7co8AEt1f9rdpd8xgkgnr9TnrIBKIDPa1BZTtiJi1Ygeb67CbKq32kuTVeEmNb6VQH+jPvpbGOU+mdN98Np8Wj8TT2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ni1zKN4gkkhr9hhuvqlZDIqJmtI90m/n2C0/Ot2LFE=;
 b=Fpl3gxk1mnVH9+5VD0mO2AWDrXsDBtx9CcYUj/Einx2DqyBb7KkDo5wgwcDvL/7J3d3jQixih3ONyFqmHUrQk8JwPMG8CDvUfI7U+wzhMU/ADilfjK8faZ9EAfQZWZWNVlOsw2FR/TJlPf527m9pRvj3ciZAd7jzjAM3zbEbGgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 19:21:10 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::fcfe:62dd:e938:3a84%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 19:21:10 +0000
Message-ID: <9021d861-cde6-a51a-7d8c-b3f67eaa01d8@amd.com>
Date:   Wed, 26 Apr 2023 14:21:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Dylan Reid <dylan@rivosinc.com>,
        Ravi Sahita <ravi@rivosinc.com>
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
 <DM8PR11MB575046B6DAA17B41FFED8080E7659@DM8PR11MB5750.namprd11.prod.outlook.com>
 <9fa5ce43-584d-878d-227a-fb458254c00a@amd.com> <ZElIjw7Ca6N2mYHe@google.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <ZElIjw7Ca6N2mYHe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0161.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::9) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a0d78c-1516-415c-c09f-08db468b6473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qt4r0QTgGaUfNfSgxhy071f75+fJS4pBzTuWqJdar0IPDpfrMk6VJzMJg6XiwCYmsw6WwwFdlpzoAwKT/MJApdb85DvuU0S/JYZef7SY91OptzOFxTJNJHUN/CIi78IoBUtgNt8qAtJRJltooxSD2pKFzpPP5p04Nr98wrinumrUAxd56LBIxGgjLIzibyOsqfigYe+1qK/Oi2rGDUKLmgIJGzoIw3fu5kkqa7LvzXK3o5x/iDpNsYQmxSrgEM/eSv5/hSBp4umKasUJKdKUrPGSCuYIpvTYjgtwxH3GFK04De7rS1Y1DAwfKVg6sZZwb8nGseTrNbXo5zEMgMf2MlfAqfOKb6kDOMQo3fxoEpOk0csp56JqrBTbNShOjBI95WORBBTP89vSQxXti2BzcT3scn1OQb1LI72Yk99BbbUdoEKKkl22tJSU8S9+uC43Y3GvOi1xPmmR1fBjbzE8nHknQCxm9I2d09rHPqsKk8PxsFSM7YbjgNA2GRFhiOO/YogXScEhDtwTuqYmyXwqkQekqgFd8w5uYYnDlYa7bMOdgIIoBs+Kv//JdgMYAsTaXvNvbtWBCkhQ/ALNeDgEgVEgblS0ls5c3s5HoG1Z6ktQjaH39jJVrE4nWVRFCKReqGQw2A1f+XGrvf8AcX7gnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(54906003)(478600001)(83380400001)(6506007)(36756003)(2616005)(6512007)(186003)(53546011)(38100700002)(31696002)(86362001)(6666004)(6486002)(66556008)(6916009)(66476007)(5660300002)(66946007)(316002)(15650500001)(4326008)(7406005)(7416002)(31686004)(41300700001)(8936002)(8676002)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2xhNno0SityOTEzSWthdVFNNUVJNkRKd2VUMUhaMGNXOEk3Q2JLS3RCRWNW?=
 =?utf-8?B?L0dsN002eU5WbWJBcWdPQ21sMUdJalRZU2UwWXk1cEQvR3RkVHlkV3JralZK?=
 =?utf-8?B?YjJOU1dOYTRMTFoweCt6enNXdGJIdHdXdVJBWGM0d0ZhYTF1VDZxdDhpZnI0?=
 =?utf-8?B?WkRzN3BKUWZ4UUtUTXRmMlE3YlZySXRqUzlFd0QyNDBZa0FYdkJxdFpkcEJD?=
 =?utf-8?B?UUd4djhBb01vemVYL285eUZmelNxMzBUU2xQRmdtcE9YVTh2YzY0T0Z6QUJv?=
 =?utf-8?B?SlBNOGRKTmZkSFlXUmg3enZyZWM1SGFkTzZuekNHUUZRQ2RoZ2plS0pNNE9k?=
 =?utf-8?B?d0g3Y25aR1NKQi9uMTNjVTJYNFNwKzE0ajFxcmwyN3ZkL1ArcDAvKzdmUW14?=
 =?utf-8?B?WVU0cUxVc3c1VDgzOFZpRlRvY0M5aDVvSlFzQlluMU5jWlBFeXpPakxzaVI0?=
 =?utf-8?B?bnBhVHhVUHFoa3NNZ3U3S3F2ekRHdzkxL1hCQnM3dUUxUnYwc3FZMW9CdDJx?=
 =?utf-8?B?QmVUUm9odVVsTDZpeUxMZm55LzN5ZHRrYnVvYzFEdklpVXZPY2drQkMyZFp2?=
 =?utf-8?B?bzBsazUvU3VNUVViQXN3b3UzSmFFQjNpVDcyeC93RmhDOGc2U1NJMnIrNGhn?=
 =?utf-8?B?QlhabzExeHJjdUlKMlZDY2NqM3JvbmhlV0NsQ2p4K2J4c1IwT282NlZ1Y2pP?=
 =?utf-8?B?eGNpVUs2WGxYMnpURWkrSEUwUXpjUU05WmVvQldYU25vc015TEl3ejY3bnBm?=
 =?utf-8?B?WDM3YXdmbmgwWFBtOWdzdUtwa2x0TnRNN3Vlb0lvSlJpVnd4REZPaVdPcWJH?=
 =?utf-8?B?R2FBVm9PUnlNVmdJMFQvQll1cVZDZU84bm1oYWJOc0d1Z1RscUVUQ2xQWEFp?=
 =?utf-8?B?WEgyUDgyYVFYVHlXbXNPSFFIcVRZaWY2Q1hPNzZDYU5lSlJKcEcxSWdOU2dJ?=
 =?utf-8?B?ZllVaVlPTXU5SXpUdXRsZUpHc3BacHhYNHRhRmNXY1ZJaktzcVJLeXZtMjFM?=
 =?utf-8?B?TUVQQTV6clhmQVJBTkxUR25lU2dhQlFUYXZzSFo3MGJZYjlvZkJpRWJFSEh5?=
 =?utf-8?B?a3Z1RjQ4b0VJWHVHWTJOS2IxMzdnNHNWQlkzTUoyd1Ywcng5MXNsTzU3Wm13?=
 =?utf-8?B?TGZhQ0FYQ1dZbzJQemx5UFFIOFNXdjhrWUthQmhaU1NoYVJ2MElvcmo1Q2Ns?=
 =?utf-8?B?YUZxdmJmVzNMcFluVmVZY0lKQk5LK3RJeGJSdE5CYVp4ZDFIMjQ4emtnLzk2?=
 =?utf-8?B?UlZRRE5ySXhVcFU3OElqWUZza0FsdDQxZlljUFhsMnVuVFhnK1h3ZFd2THNP?=
 =?utf-8?B?QnF2SVk5Y09rMndaTEJVMHhnZDNZeEw5dHZkUzhiWVRCRkdHM0JoZXBVeWdk?=
 =?utf-8?B?U01wcWJVNzlZalVvS04xOG1acmZ1Q3M1QU1xZTEvYWVMZFAxd1hNd0tiSG9l?=
 =?utf-8?B?SGRMdjlDRE1IT3lMYmNsZkRhS3dyQVUwNmxpVm5sWEV6VFRFek1MOHNzRk1o?=
 =?utf-8?B?U21uamhHRklPcit2K09Ieks3ckd3SkJlaDlCUjlrd3RkUVhDTU9pb0lmSzJR?=
 =?utf-8?B?Q3RwSDcrMi8waDJ1ZW1HRVFOTWQxZ2hzRzNwWWd4MmI3QThQVmtVOFNWZkdz?=
 =?utf-8?B?YXJVdElHUTFqeXB5eXR5QXlDY1Q0NVU2TWNUd1NydXgyMWZUS0pBMUNxT1F5?=
 =?utf-8?B?Um5ra3Awdm43ZldqTU51RjdlNGM4RWJPWWN0Rm1YYVV3U2RENDFtbnFRdkpn?=
 =?utf-8?B?R0NLZHViYk51L09Vd2JPWmFnaUxrdWtxSS9samwxUWJJb2xyYjRHcWZnNWhI?=
 =?utf-8?B?b0MrTGRlZ0FXeWVWU0ZSTHF3dWdMWTBvekZEK1duM0puSVVWZW5kN2hQcDRM?=
 =?utf-8?B?ejZJbThrVjU5Nm05bFpLUWpvU1d2Ui9SYldXYTYyRW1sOWg3MkpiQ0NtREx3?=
 =?utf-8?B?dUhkc0xoVjdCeFVVaTlvVTBlclRYSmtXVlMvaGJpV3JHdVNaSXRqTm82QW9p?=
 =?utf-8?B?M0tWc2Y0cldSeFMvY1d5OGNtbWxpcjNJYU40Z2d5dXVteURJWjBaMWtoWjJi?=
 =?utf-8?B?NXJCWkVIeHd3RFlhb3RNSmxrOWFqYzM0aVlMdzNaNVRNVjhhaXc2Tng3cGN6?=
 =?utf-8?B?R3BTSmJJWnVBK0hWZWVUc2piODVJOW81S1pzQnVObHlHZFpvaldnaWZ1YzAy?=
 =?utf-8?Q?HKbRYQfwVj4DvEE9GdPV1vT3Gt1P5nOYJ5mY23Pwhj17?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a0d78c-1516-415c-c09f-08db468b6473
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 19:21:10.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KdZgpO6ZVipJFrXfNiZNEar5SF37UiUS0WNkrOKu5Nd2sp2iOt4pZe0sNY1bmzyW835RxzHKtRAjFY9GA9NQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 10:51 AM, Sean Christopherson wrote:
> On Wed, Apr 26, 2023, Carlos Bilbao wrote:
>> Hello Sean,
>>
>> On 4/26/23 8:32 AM, Reshetova, Elena wrote:
>>>  Hi Sean, 
>>>
>>> Thank you for your review! Please see my comments inline. 
>>>
>>>> On Mon, Mar 27, 2023, Carlos Bilbao wrote:
> 
> ...
> 
>>>>> More details on the x86-specific solutions can be
>>>>> +found in
>>>>> +:doc:`Intel Trust Domain Extensions (TDX) </x86/tdx>` and
>>>>> +:doc:`AMD Memory Encryption </x86/amd-memory-encryption>`.
>>>>
>>>> So by the above definition, vanilla SEV and SEV-ES can't be considered CoCo.  SEV
>>>> doesn't provide anything besides increased confidentiality of guest memory, and
>>>> SEV-ES doesn't provide integrity or validation of physical page assignment.
>>>>
>>>
>>> Same
>>>
>>
>> Personally, I think it's reasonable to mention SEV/SEV-ES in the context of
>> confidential computing and acknowledge their relevance in this area.
>>
>> But there is no mention to SEV or SEV-ES in this draft. And the document we
>> reference there covers AMD-SNP, which provides integrity.
> 
> ...
> 
>>>>> +While the traditional hypervisor has unlimited access to guest data and
>>>>> +can leverage this access to attack the guest, the CoCo systems mitigate
>>>>> +such attacks by adding security features like guest data confidentiality
>>>>> +and integrity protection. This threat model assumes that those features
>>>>> +are available and intact.
>>>>
>>>> Again, if you're claiming integrity is a key tenant, then SEV and SEV-ES can't be
>>>> considered CoCo.
>>
>> Again, nobody mentioned SEV/SEV-ES here.
> 
> Yes, somebody did.  Unless your dictionary has a wildly different definition for
> "all".
> 
>  : +Overview and terminology
>  : +========================
>  : +
>  : +Confidential Cloud Computing (CoCo) refers to a set of HW and SW
>  : +virtualization technologies that allow Cloud Service Providers (CSPs) to
>  : +provide stronger security guarantees to their clients (usually referred to
>  : +as tenants) by excluding all the CSP's infrastructure and SW out of the
>  : +tenant's Trusted Computing Base (TCB).
>  : +
>  : +While the concrete implementation details differ between technologies, all
>                                                                            ^^^
>  : +of these mechanisms provide increased confidentiality and integrity of CoCo
>  : +guest memory and execution state (vCPU registers), more tightly controlled
>  : +guest interrupt injection, as well as some additional mechanisms to control
>  : +guest-host page mapping. More details on the x86-specific solutions can be
>  : +found in
> 
> This document is named confidential-computing.rst, not tdx-and-snp.rst.  Not
> explicitly mentioning SEV doesn't magically warp reality to make descriptions like
> this one from security/secrets/coco.rst disappear:
> 
>   Introduction                                                                    
>   ============                                                                    
>                                                                                 
>   Confidential Computing (coco) hardware such as AMD SEV (Secure Encrypted        
>   Virtualization) allows guest owners to inject secrets into the VMs              
>   memory without the host/hypervisor being able to read them.
> 
> My complaint about this document being too Intel/AMD centric isn't that it doesn't
> mention other implementations, it's that the doc describes CoCo purely from the
> narrow viewpoint of Intel TDX and AMD SNP, and to be blunt, reads like a press
> release and not an objective overview of CoCo.

Be specific about the parts of the document that you feel are too
AMD/Intel centric, and we will correct them.

Thanks,
Carlos
