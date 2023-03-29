Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6993B6CF171
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjC2RvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC2RvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:51:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76488DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfZHP0spqAZ5WZoZjgrEaxmfUXQCRNFM3AoMNTPVFQhLdR53Dh2wcAscdxeZMRLVJqJaaGXOU/vUP+sHAVZ5PruSnDnLSGzPjH6gScGsYGnec87+n1e4ph6G0a0M+wXgCrOHTvBuWwzOH9v/qe0AS7fBftKKjlL6fUcQXBBV6VCHCSvf9spF8EaZ3cW51nidNrZAvgGoN2Ff4AEy4Hy4My24hMmpXrQMk12I0YMcRrxDMqibtssuYKtfwaLscaC5CrZj4xTwCQplObDDLaMwqWKQqr5wCf8cJlDRqpUKOjhbwuZJxsdvWHsDTIK2PRcbAJAvTVnOHDE4ulUU4BQrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RIcJCMjL09N7hEE4WfcabpjeLou2XdCSDAj6+Tj/C8=;
 b=io5o6OmyjsBM8W0MqG7hEeUZUXhsyl5f2+stU0DqWLXThO7YSK0ZFPSiRxPMCPl7MPb3RdC1WoXt1DTxilRR94vm5ELiSTQORcV/F+stSfHepfvuZmyFgRX8DGu9f1GpKIkQToKzpRsqXJiVgewB//b+mGyEaGwzo6wsyuiKIwuVivAhzav7UDnf0wukt7wriAAB7FoAOm0zZOQpCiv7aQxtIowe4q09j3YWTwxxyg561yaF0AuIx9mQ25PXkcx+IBUuIhsldZIRgpdtNUttSmctIQ5fFAuMpQtKSeJZzpsu6yaHqWT9JeG37LvQgC/G403AuhRlRCm8omaG7dYUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RIcJCMjL09N7hEE4WfcabpjeLou2XdCSDAj6+Tj/C8=;
 b=UEWnlTF/nYMRVb4JvQlZoU+G0pBZZsO5CilNiKIgDVnKerxe0Z4XWtOkOWT4GG4YDis0XZQFpNhZ3qY4FK+7aq+MiXvA9T5qohnZWcZyK81t+2lGcF5Nv/mOKVm2RpYjdJWQBoRz6rh/oA8jVcLFhRnYJFkCrlTVUYwjnhYsVVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 17:50:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 17:50:58 +0000
Message-ID: <e8fd7cdf-b6a5-1c7d-bd08-0d60a1c10495@amd.com>
Date:   Wed, 29 Mar 2023 12:51:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
To:     David R <david@unsolicited.net>, Borislav Petkov <bp@alien8.de>,
        Gabriel David <ultracoolguy@disroot.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kvijayab@amd.com>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
 <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
 <57385475-c289-356f-d696-fc6decce1390@unsolicited.net>
 <20230328171057.GDZCMfobguhGUFiUuh@fat_crate.local>
 <9ed16be4-051d-c20f-0410-b8a973c4c09e@disroot.org>
 <20230329103943.GAZCQVb1n3tKlGOAWI@fat_crate.local>
 <20230329161450.GDZCRj+rz9lTEZFNBz@fat_crate.local>
 <f033acad-593c-a741-8f4f-a9962eb8aab9@unsolicited.net>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <f033acad-593c-a741-8f4f-a9962eb8aab9@unsolicited.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:32b::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 5057826a-c0ad-4b4d-9219-08db307e26f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+FSiddGOvVa9lj3xK3kku+TGINp+aeWeA2Fv6JFGtf8ZAAO7bgqrE8FPtWL8xKDbhdJE4nYhYUdtDNznS2oE5pl8fwSULkawdXt3rethBaRugEkBPxQ5xiEQVnSjoh/Ww3YWra+b7+kPvbfQLFVp21FkZs5mlqm+1/ha7XXGgIPD7ac7Zue8j5lW2Zom9zbx8HqaghBtFYO9dYGcgaUzRNeD9ysrUqU6Y06NtQUYqGPirmwhikVgBFsZMwasJSy2IHQAETMgzpsDr4lkVPqXT1u3mDuMCjXlDseErSkJv/C4ImbBXsCVd8oLX+i6lxeGryq9b9jx5GqRL0vSfplg+JMjzZ4jItNk+EDRexKPol59vlV+lXbtZm4fX+Rqs1SQO+bQ6vCnrmZAxaYNTDR4DjqJP4+DIiU2u6AlKSIPDs4FmlLOLPZ1Xz+HY8mNqTlg5xkm3wGH5rljVHBjX+0iPzHGR9tm3eMY4i6Oy/ne+662qjMkXGHaH0+7Dzy88jIzOq0z4dKIaCXfVOVpqYgu7wjG+qlMJIsPgWvakpLOkOteBZCexf3ps/H+hJUnZzzIAZ1XIv/NGPo1Jv2A3IfFKMSwp1tNqrh6LABHgQrP40wmCRS+loPP6ReHMLXkK9m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(966005)(38100700002)(2906002)(8676002)(6486002)(66946007)(66556008)(5660300002)(41300700001)(4326008)(8936002)(31686004)(66476007)(316002)(110136005)(478600001)(53546011)(54906003)(86362001)(31696002)(6666004)(36756003)(26005)(6506007)(6512007)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJxeHZzN2lybkJRcEUrQWJ4ekV0M09oRFR0OU9BRTUwRkNoNEJKdXFwOHpz?=
 =?utf-8?B?M3RVbndsekIvbEU0V3FGMTRDRFRvbVgxRzhwd0d1U0tEekZkbGFPekxFMjY4?=
 =?utf-8?B?RXFvdUdMb0wxK3JFM2ZFdy9VUURWTVR1dXd3bkY3NldKT3lYVzEwdUo4M093?=
 =?utf-8?B?NFNZOXpNR2wvNlA2aUFiTVRoMFE1K3g5WHJ1ckFQRzkvWFFoZFpab3ROODdX?=
 =?utf-8?B?SUFnV3FaYk0vTUV2RjllSXBXVFJzYkxiMW9TcmNmNE95eWZLdXRZanFuUENm?=
 =?utf-8?B?MWlwRzJRWUxISC9iWkt0N1VLbTNSLzhkWHlFVElEYXhYN050QUVtTFdDd2RO?=
 =?utf-8?B?cEN2MlFxOVdvVHVROVhvbmNUY01wS2JSNTQ0Y1dPTkc1ZmhOTzF3Q2lKdnRo?=
 =?utf-8?B?U1VTeUg4VkZYZ3RHUHFGWm1lbGpqMWFYenFkQStFeDEwVHNWUUcveit4NGpB?=
 =?utf-8?B?RG9zQjJiSG5tbUxVRnJQMmpIK0JRUVdwWTQzZXJlcCt3MjNUWWE5TEhzUDV1?=
 =?utf-8?B?TmN5Q1plYnFiZDlKM0FsVnVoYVdydVBHTXJKbVN1eGlrYTZTRERLMUFtejlI?=
 =?utf-8?B?U2ZQNU0rc0tNVVk4YjcvM2NDdENDcUMrZjJzNzZ0cE5SZ1BlWTI4bDBjWFlq?=
 =?utf-8?B?bndaZHBHNUtxQzRxN2FyeWNNbVZXdEFrQ1JkT2dMaTdFVlhvM1BzbjluK0FL?=
 =?utf-8?B?cHJRa0x1bWlUdFRpZlVqRURQQ01NeWpuTTB5WEFtVHJQR0ZNVnBEZWY0eWxL?=
 =?utf-8?B?S1p4STZYd3dxcXBQaWt3N2lvZDBNVTFoMEMwUUFDYTBSVUQ0MVlHVlcrNHhJ?=
 =?utf-8?B?WTZiVDJxK1NhRXlDR203NHhXTTF0djl5eHlZOVIwVm9JZXdXSVJpZzdTa0Vt?=
 =?utf-8?B?aEJZdFkrWFljY29TZXpZRHd3cVlwU241SFdtdmdhYTQ1bWwxMzZaeEszQ0Zm?=
 =?utf-8?B?N2Y3UTFhTnNKMWVIckdPdmRkSmJCVXhSUXU1VzV3SjcxYTBMQkRTd3BTaGgx?=
 =?utf-8?B?K2hrOWtUd3JtVjBOcEFhU3lQWFFTdWFZWEJ0S0pzbjFTKzc1Y1lXZWRXNTE5?=
 =?utf-8?B?WXNBY2ZCZU0vRGNYSHpCNVdmSCtnanNWSHNGY2xaeEthMW1QdWlraG85aWV2?=
 =?utf-8?B?bUdQZitBSnBJdGNFVUloTnhPcm8xMHFsNDJDZDRXOG13TW9uZEZVWWxZWERB?=
 =?utf-8?B?UGdWZk5wRlBlREZzVktFQjdtODljNzhyRjdzcWdCYjVjakZ4ZHNCOGUzL2tt?=
 =?utf-8?B?SEh4TEJpSksyK1p2ZGNVaWMvMEltSWpVZmdHZVZDZ3RpR01KbTVSdlFCeTl3?=
 =?utf-8?B?ZkJCam54RlBjaUJnOHZoMGtVOUlMbU1mazNWdHFSd3ZBaVI5NVI5U21sZ3cw?=
 =?utf-8?B?T1hNTmxNSkhLL3dPSGdxa2l5Wk9XU29FSWJGSlMvalNEMmI4bC9GekFDbzA0?=
 =?utf-8?B?aVpNUTVXQ1pqRURaWTA0Q3lyRXA5NTBUREFyTGZ3RTZORVJLTWpIMmVJeHlH?=
 =?utf-8?B?NW1rWTRKMG1HQi9OUTQzcHVtenBkZS9EUlphZElFbXViaG5peGVOYmg1VG9t?=
 =?utf-8?B?UlZ1VTFiSzZTanNIRFpoczhkaWFSZzc3Z2RGeGl1c2tIZVRIMmFRc3JpOFNY?=
 =?utf-8?B?K2NxL3hMc3JnWHJuVmF6RS9ibVFqc0dRRHhkYkI1bXc4dk5GSC9PekNGbDhK?=
 =?utf-8?B?UVNmTmp2RGoyWTNxQ3RCazlkOXlHckZBSUpHVVM5T2lrcEJ5aWFyR1ZRV2NM?=
 =?utf-8?B?RTRYVHhIMWp6b1lzdzE5TzV4cE1uTmF5L29oK0pLMlU0bm1ud1I3ak85RWpa?=
 =?utf-8?B?YmxkamI4Q2ozSnRCeDhUWHJhNlJPVzh2ejhMRlJtMzBkS0dPWVZxR3VFVlor?=
 =?utf-8?B?VlkrNzJoalc0RHVEdmVCbVhKbHd1MERwbUNrNXR2elFTdTkzVGlyU1lqNWx4?=
 =?utf-8?B?ZlViTHlReGZEZSt4ZTR5OXhFOVpPME1iL3BNc08xcVdtdWxWeVBya3NiVmw0?=
 =?utf-8?B?MnpDaklhZEx6TlBVeHhWUXROaXZjSWpWWHpyZStEdU1DQ1BoamJYd3RqS1BH?=
 =?utf-8?B?MDlTMFdXQWthYXd5NzA3Q2ZZVHVSNW9FZk1xREFlUTlQaWtIVThIdWNhOFBL?=
 =?utf-8?Q?Bz4eb4eBD0GRY/IKlHsfOlTYn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5057826a-c0ad-4b4d-9219-08db307e26f2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 17:50:58.4044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/i+KlwYeJVfs3ta3KtpH6GMxiyAEqyOxUvLdx0Ji4sEpXBUgSOXcFNMJMuG3EuYX5XXQ9plFzdWAxlhGoL2kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2023 11:20, David R wrote:
> On 29/03/2023 17:14, Borislav Petkov wrote:
>> Gabriel and David,
>>
>> can you both pls do:
>>
>> # acpidump -n MADT
>>
>> as root and dump the output here?
>>
>> Thx.
>>
> APIC @ 0x0000000000000000
>      0000: 41 50 49 43 DE 00 00 00 03 AC 41 4C 41 53 4B 41 APIC......ALASKA
>      0010: 41 20 4D 20 49 20 00 00 09 20 07 01 41 4D 49 20  A M I ... ..AMI
>      0020: 13 00 01 00 00 00 E0 FE 01 00 00 00 00 08 01 00 ................
>      0030: 01 00 00 00 00 08 02 01 01 00 00 00 00 08 03 02 ................
>      0040: 01 00 00 00 00 08 04 03 01 00 00 00 00 08 05 08 ................
>      0050: 01 00 00 00 00 08 06 09 01 00 00 00 00 08 07 0A ................
>      0060: 01 00 00 00 00 08 08 0B 01 00 00 00 00 08 09 00 ................
>      0070: 00 00 00 00 00 08 0A 00 00 00 00 00 00 08 0B 00 ................
>      0080: 00 00 00 00 00 08 0C 00 00 00 00 00 00 08 0D 00 ................
>      0090: 00 00 00 00 00 08 0E 00 00 00 00 00 00 08 0F 00 ................
>      00A0: 00 00 00 00 00 08 10 00 00 00 00 00 04 06 FF 05 ................
>      00B0: 00 01 01 0C 09 00 00 00 C0 FE 00 00 00 00 01 0C ................
>      00C0: 0A 00 00 10 C0 FE 18 00 00 00 02 0A 00 00 02 00 ................
>      00D0: 00 00 00 00 02 0A 00 09 09 00 00 00 0F 00 ..............
> 
> 
> Cheers
> David
> 

Can you guys have a try with this patch to see if it helps the situation?

https://lore.kernel.org/linux-pm/20230329174536.6931-1-mario.limonciello@amd.com/T/#u

Thanks,
