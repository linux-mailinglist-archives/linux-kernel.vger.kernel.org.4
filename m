Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56E860DE94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiJZKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiJZKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:06:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302426AA0F;
        Wed, 26 Oct 2022 03:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzA9Tk9iYIRK3llkyNZTKSrrt0CbfTt91rv8gf7iUvde4wrAvD518Pn34073NCxIcZD7nwD6dOpj7iObcXyRc8m2+MqtYm6Omt8fx0bf+iftm8foV+ocBPlxWOgIMXPXodzZYtKA8BziRXQlk4X2VE5A8xL9JL+YBdbwi9eyO66ulG7kWVDTkFCrGR0nO8esUk0bV15SFlbsCAwCAwg/JmT3WJ6yZqxPShkpLJRCF2hbjhNLjIkzHAgFR7OyXJjM1XS5F/75ZNeqWU5+kQ9pDevfJ2+XL7OMJaCpX1RVPdlO9lJU75eJNWlJJe1uJFjoDU2jNMPDRgSztHMVC1wXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUpo3YFCqGet4FlrcowjTaQYHlW1xPsxE3r2A2QjukU=;
 b=Sp8oDwXCHi7Mw0OzdkBmk2fjpzYBHykCzJMIDltf/zrpsrr02UnaH7j4u9ZCv65vJrMwmIgePwRYe8aFBPUC9770DkSa3Dk1lri9EpLu4r9qLdjMsaW1V7oK1wuqvQ9cRGEfRJHPHSe1usDV8eC7oAU70Q9gkev8R701jgBaplQBTFpR9EHRwNED1XhWOdhzkEmuT6UfO8syvuHE+yU4wfTlObEh+gQLm1Lle4rtIBP21nrbGCs9voKZUZh8eCuj/KoUrT8iGxLlg7xoRLEiv1Wb0DJBo6WEJ1xxWF62McONHb0AvF/u9q/t3zuugFf7C3ms6RcTMWtnrF+dSThEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUpo3YFCqGet4FlrcowjTaQYHlW1xPsxE3r2A2QjukU=;
 b=ClouhqpxdgAbJPLmx4ldsDLgQIofloKq8gFXKYtj/dzYky3QdVdfVYMETn+iRJYySlgZ0uC8qkyngiU7gO+RgESvgc4jjZhtElxq+E2k9Ae41dHXp9mz+R3BkjW4G8yiKyEvVLi9S41rbhlWLnxj0boB2c+VkU1mG0Pz3wUoi4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 10:06:06 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 10:06:05 +0000
Message-ID: <5bec4620-2e2b-abe0-1e82-528c084d4d16@amd.com>
Date:   Wed, 26 Oct 2022 15:35:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: Perf: BUG: kernel NULL pointer dereference, address:
 0000000000000198
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CA+G9fYtOP-spGS7gYyBB-8wpUDiKxd5e_Nk05J9gzWR_DLBeFA@mail.gmail.com>
 <4429582f-155a-04d2-d139-a834bb325612@amd.com>
 <d577887d-b86b-82be-8081-f7bebacd8067@amd.com>
Content-Language: en-US
In-Reply-To: <d577887d-b86b-82be-8081-f7bebacd8067@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::26) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: bc165a78-4c5a-4862-4350-08dab739b21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/hxKXSA3nQTbkL81Zx9jECX+BTqGRXI+jMNzDuKy3Y1lgFRvGrpFJkMjmQ9+plWuaopNIuseo57m4MMYKY0CfWLW7LHbRECDB6LQLh+Wy0/3Hwd9P+gZtfJ+w6Hh8QOYB0EUmyd6n0yfAhi3HYN082pQp8ZbFvAQlheaVUO8bW5fixsWprb3+QcpUZlxGh0E/KLoa4LsZaSHBTUvoicNif56PvvnEyGWesl2gnGx7yEOd4Z/Wb8sI1L2fWY1PMUo7XUk6DWn3pGsBrC30JJxa/52K3Ll4hLpRqrfazYl+QwQ5yKR3dhesfg5VX4CayCqYXM2jyqmdGl4ttvSTpjuJJSS3T7Sko2rCV+KvTxtorR+Frd4i6N478LwhRlmtZ1nhyhRDWs0i82E/lsTUhDpTEdMJ7fa6KZFyGf9zUQcfF1Q3zfF83VOq3FTjiCXhv7XQiR/ynW1rdBQYbEazcb2M+i5gtquJ4NN3oWEB2+j6qgCHwfrhq25xnhUtVgpmiHewiciN6W35ERbGeEbz1nU36XiJ6c//s74CxjVbJFXYnRZe/mFeI5tPjFaxtfNT2Vp555EyzWGt8nTtWu1gDLc7i7E1Fw+Fa5UxQlgSIl3Dcq8DtxdNtBBtLwptBQ+GEnyGVdnr1ZouNYoGo/Mg4uUDb94OYYWvG6ZyOazy4VhqIstiUcICOlQQjs3KwUmVAVXsDqsAFckmpln6PvnD4xaLsgftTweLqUnWOj2YsnF4dnSQ0rz17nkD5HLFXRTZbUnYdRQcE+ab7qh5Ox4SfzBJAdMoK85X2e/ZGdwMpSyrYuU0ItxbnISiuknOW0sPfvw+b9ZHHvPbGpXsogN7jrqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(44832011)(6506007)(6666004)(4744005)(53546011)(66946007)(6512007)(66476007)(26005)(36756003)(2906002)(66556008)(4326008)(8676002)(31696002)(41300700001)(86362001)(316002)(83380400001)(6916009)(8936002)(5660300002)(966005)(54906003)(6486002)(478600001)(38100700002)(2616005)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC9KNnM0M3dLVUFFZnZ5NWhuY1IvMUFMYTBHclhoWjh0TmVoWGlSWTRmUTRC?=
 =?utf-8?B?RTZWZ3drZVp5YW01Rm9vRnJnd0kyV0VFd1ZCemVncHArcEpxLzBaUlpDNzdU?=
 =?utf-8?B?d2U0aktyTk1qWDAvdHJOVmk5eTZtSW1rSyttM1NhaTRJdXgzcVJ6V3h3WmRM?=
 =?utf-8?B?YkxpMEJ5VDR5YlNXUnFYWjVuNzNUeUx0bU53VTZkYUJLMUlOV0ljYXVnNUpJ?=
 =?utf-8?B?NnRlMjJjbFBrb2tlTXVlNTJ2TmJmYSs0UGNrTFlWRWFpa2JxVUhUSll5YTB6?=
 =?utf-8?B?SVBBcGRVS3hwdjB2T0ptUTQyd2orcFNXbzNEay9LSXA5TnlCeVB2bWRYUkg5?=
 =?utf-8?B?VVVhVFBObzh5b215VmVudVozOCttZ2xnRWVtdFl2cXdTL1l5aEp6eE5yREVh?=
 =?utf-8?B?SWIwUFp4TmdqVVI5blRDTHlCaWg2dTZhMEpZS3ByVEptTnQ5SE91cHFvc2JL?=
 =?utf-8?B?TjR5eFFXb08rNTFGNC9JbjVsdml0SXBUSllVdUxWTUZKMGozazhpakZ4SlNN?=
 =?utf-8?B?UXpoaG5MRXRWM1lLYlYrQmh0bkR5enNIUDhaNDRCcTExYUNWMGx5T1pnQ2RT?=
 =?utf-8?B?Uk9CMXh4WVdzVld4ZkJ3VFYyRTlsSUV4UFJmczliQVI5SW5xdy9OUGowNjFJ?=
 =?utf-8?B?bXpqQklQK0ZzencvRnozdklrUTBrSW12UWJxUnN5c3ZiMnRqSFNSUENpYmZu?=
 =?utf-8?B?aGVXRWJ1WndXRHplcXF1WDJ3eVJURnBHdDFOU2hNdEJjamRvUHJROVhWai8z?=
 =?utf-8?B?SUZNak1FRWRpOFZSWG1qQ21zMFYvV3FCaExyNHFDZklSOTNKeG5Cc0lDNmxV?=
 =?utf-8?B?RmRoU3BnTzBQSFVWeGc0VlFZQnBWV3UwR0tLbXFCMXZkOVhZMEV4K1JzWTgv?=
 =?utf-8?B?bHk3dTVWa2FZdWpPU3drS250UGdzVnZPd1AzM3dtbEhUTnMySGx2UVhiN0hV?=
 =?utf-8?B?VUh1dU44YzE3Rko4Rys1UU8waVN5NmU1NkJlQmJNbUpSY3MxMkk4SEdtRHQz?=
 =?utf-8?B?dmNsb093cVNWQUJDbHZNVDhHRGF0Q0lkb3RRK3kvSzF4c3k3Sko1S205eHdp?=
 =?utf-8?B?Ty9wbHZ0VW9IZWMzVDg5OUp6R0dxOE9SR0E2YnV0TUhCaUxTN0hTQ3pVcUlN?=
 =?utf-8?B?UlR1WlF5aUdnY041K215NGx1NkVEb0N5aEoreGtPbDdNNm9hUzV5dnFTaG5P?=
 =?utf-8?B?VjV0R2dmQ1g5OHYvYk5lNS9OVGRUMlhCRGx0SHdMSExpcitlcXR4L2tKM2NE?=
 =?utf-8?B?OWk2R0VaT0hBdjJYbW10T0hYTThaVFdzZ2Jjc2Q5RVN4SmR2Z0dSNlZoVkJ5?=
 =?utf-8?B?dlM5UlFSQ3pUUTFQVnB3NEdSZSs4RUYrdXl6b1BvNFIwVWZ2VGVFTEluVmpI?=
 =?utf-8?B?ZDNjZUN5L3ptWncrc0I2K0VuU1RVblZiWklOeGRWVVR1czByTFhkQ0VTM0VV?=
 =?utf-8?B?Z1VoTnFiV2lNZy94T2I2NXZTN0FqSENxV2ZqM09vWFZzVGYydnhyWTAwVGdu?=
 =?utf-8?B?UjRDdzFpQVBwN2RncGxPTjFKNTdEZFNhbUFNRGx1YXZtL2dlN1NyWEgyRS83?=
 =?utf-8?B?QVR5WCtjQzdHRmxWMisrNFdEM09XUExkVWtXRGI3dkFUeGpEQityVE1sOGRO?=
 =?utf-8?B?RlltdGdLUjB0dllGUEF2K2FGZ09lZmRtVkp5ZVdKTHV1eXFmVFB2eHllUENq?=
 =?utf-8?B?cE55dDFQdEZ5ZFVuSFdCdWZnMkx5dURtSWwxSEFPV3pmcTRDVHViMWUweXRr?=
 =?utf-8?B?WEs3SGJtcFo4YjRBMGZVVHU4THBSQWdXcUtJQ1hDUXM0ZnpmYjluUGdtWGlm?=
 =?utf-8?B?YVlWZjZta3RwSHhvZlJ1dGJURGFNK0g2NzdCSDZjV3M2clJiK055b1hGUzI0?=
 =?utf-8?B?SDd1SVByUFFDMDNyUldOVyt5bkVaNFkxa2w5QVd0aGFGL000VHpMYUVROTFt?=
 =?utf-8?B?anZoQXZ5a2dPZHpvbUFZOHJ3elVVdUFhWUw3ajVYSWx5ejRPUjlVSVdoSXlB?=
 =?utf-8?B?aDRCM1crWGNCRktLMnhHZFQwdmU2OUpiL2NiTlZ0ZklacmU0Mk1aR3hGTTdh?=
 =?utf-8?B?SUM2VDJ6d0M4YjlaVElMZkI4MWxyZ0RXdmU2aVJiTW12ZUdjdnhJR1hIZjBY?=
 =?utf-8?Q?3N0zi5WMBjyjJeUS6fPfvOcV/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc165a78-4c5a-4862-4350-08dab739b21e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 10:06:05.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olNOUBiFtXg3KT8d/mDdg9SHdNupPfSMcr6Zzrk+5Wz8J6sl+b4d9/mTtqzTEr0tZghPZIXDJnZSmIsaB6mS0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-Oct-22 6:36 PM, Ravi Bangoria wrote:
> On 25-Oct-22 9:59 AM, Ravi Bangoria wrote:
>> On 20-Oct-22 12:24 PM, Naresh Kamboju wrote:
>>> Following kernel BUG noticed while running perf testing on qemu-x86-64.
>>
>> Thanks Naresh. I'm aware of the crash[1] but haven't got a chance to
>> root cause it. Let me try to spend some time on it.
> 
> I tried to mimic https://lkft.validation.linaro.org/scheduler/job/5708609.
> However, I don't see a way to download lava-guest.qcow2. So I just used
> rootfs and kernel:
> 
>   /usr/bin/qemu-system-x86_64 -cpu host -enable-kvm -nographic -net nic,model=virtio,macaddr=DE:AD:BE:EF:66:20 -net user -m 1024 -monitor none -kernel bzImage --append "root=/dev/sda  rootwait console=ttyS0,115200" -hda lkft-console-image-intel-corei7-64-20221019172733.rootfs.ext4 -m 4096 -smp 4 -nographic
> 
> And I ran perf test inside the guest, which ran fine.

Running perf test in a loop reproduced the issue after some iterations.

Thanks,
Ravi
