Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C50167B962
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjAYScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbjAYSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:31:56 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF6A15569
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:31:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKwQaxmGyK31peGCSuh0n1TKOeK6ezHBEvOIFgefnyERlwYsdOVYMd/H731NZ5b5pJHkUkbeHDCkzJ9VWN+AZlsuOatlIrPTTj8sOZvY2vlC8qEX5WUAHPQPuWszRdhuaymW7SdUXCDIGHnDZ1RHWyIVOYOj1BYrNpzjE4XrbhQsF7ulqbnFDTd3JMwRTU5a8q1448j6dUwwtxWIb1s3Ay5Fo2j7pvBn1H59NOjWczeLUUFGknVZC5FgXplDMAlCE2F/U2PM3VcPFjDx5RtozD3J3trSJ/C90qXFB8Yd12FqBt5/035vx3q51hT/ourJ2bRBHDXh/wOtN7ryL6AIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWnbzm6VP/kPrkd6HykJUKW+ONLzY65xVGniEmXlnLU=;
 b=hJLKQNP+aYmLrbPbXFZn0zZun9d5pvGCvobh6JFI+V5rwZZwdKmaWIZ9c/msIzIp9bpiHvVODeeZe4cLwDWwNgJtm+0MmJEFXXIRYvfb3zd3jE24ubh38MPAqJEcWPdBzlRxdaMftAuyIXlKbkSXbJ4rlR66kB+R4xI+J99oNFL/HuG/wYh6dg6AdHc0lRIa2oNUw1BCvRdDC0RrAmwogu3jmYfj49NodnKOS0POG5AQ+cGMhmkijrpto5rhvTpczcL3mI5q3TBMaT3hh1n74NI22raxmJeLf1jEPaRX3UN0w1fwa7O9/ZyEEfkiA9S+vJ4tN4LfgH0h77eg5y9GJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWnbzm6VP/kPrkd6HykJUKW+ONLzY65xVGniEmXlnLU=;
 b=r2GupwupRQQXl/A2/LryFgJqSfyxX5uPPlbxkaFXkvK0GwVdKH1/Zp5zUIE+vpNpElpSe2cbwACT90JsG4xhi6Ry9Ps9EOU2qilzEOsQYjNRGRn9s1F+NR/aud19pm5YU85IH9k2tdHmkOQgh+CwsyDHb+043gZNnZ2Wwgl9u3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB5472.namprd12.prod.outlook.com (2603:10b6:a03:3bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 18:31:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 18:31:38 +0000
Message-ID: <0be2faed-6b95-0c15-1016-3b4d1a980998@amd.com>
Date:   Wed, 25 Jan 2023 12:31:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v13 1/4] virt/coco/sev-guest: Add throttling awareness
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
References: <20230124211455.2563674-1-dionnaglaze@google.com>
 <20230124211455.2563674-2-dionnaglaze@google.com>
 <724f03d8-91e9-e870-f063-65c2e98b6ee5@amd.com>
 <CAAH4kHbdLe5-hY5raoSyqhXru9Rz4050_RMDsq8EAEBnWZcKRQ@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHbdLe5-hY5raoSyqhXru9Rz4050_RMDsq8EAEBnWZcKRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:208:239::30) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: ee119060-f64a-4830-0fb4-08daff026535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bah/Bzg0JHuvyT0G5eUHgKWNQn8W8X3sISV7YhGTJU5YUF5srAbHELtW5i5/DRiWQCwlqw78BLA1zmjLFADZ7VCQ3NTEi7NlYIkwgdbqzp/xqp44URfE8zPeCy04o5zBBhZjRCPgVliMrHEWUxvfkE+zkXAAW0x5F3CzK/hX6feOe7gnmqEsZm+7XcCiYeE2r9unftxM0/sN7Pzfld/BPRpceOAgvwbAjqkro3CxTCCQvjuOkbs5A8k708uc4VWb4eDJFpEPTZVMSH4PGO6i7tw4UQxhZZxd6Zbeqwcb0X1gVhHK76qh79U0Wg7RE1+mU/sQRJ58yqa304i+kKtroJMWB1KT+x5GP4z2F5DFa5fP+9AhyAp314CrO21Ct27Wlg0zmWSZt6zF38icgdVbaJ2HZrS/8GOT1sqcMFprZ7qsqBsiHSb0kke7P1B2ez9mpHFoXnhGAwMn5DHbj1LIbQ4syEowd9+JrKolT4x/BRf/uqipodtPcVvz9F+T7q7ZjnJFZrcU7wXgJ2jyQ2XgY1sHIdlnJY51q2d1iZ+xvTRZo9ZRrz56msjkkOLhan+kjVvm1Cwc70lDizPZr2seSqVWndtGcCliU9OTHzojXWGktRmv81pPw0bljuJ3WjrnHksb3Ovkkb7hwwESUYRbHydrJ8CAYphOlzRkyX+rfhZCcdP9cCOWHtU93lOk9jx6mywCxMfXxz0fhEGQanKiD3mosFzQ7jDJe6dtuR4JpjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199018)(86362001)(36756003)(2906002)(41300700001)(8936002)(5660300002)(38100700002)(6486002)(186003)(6512007)(26005)(31686004)(6916009)(8676002)(66556008)(54906003)(4744005)(2616005)(6666004)(6506007)(53546011)(83380400001)(66946007)(316002)(7416002)(4326008)(478600001)(66476007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzVST2VjVk12RStRTXFQM3dUQlQ0V2RLa0w2YzBjdUt5a3cvaVpPRDJUUDl1?=
 =?utf-8?B?MWd3S1NaVUlnYmZQM0tuR25vVDlRTVFGUWd0cTFZVWN1L3Z4UWZrbURTejl5?=
 =?utf-8?B?OEZ1VE1zK01wRS9jdmo5MWpSc0t3Zml3ZzVCVGM0YmZQOFFNUW1JdFlZU0Nk?=
 =?utf-8?B?MnpGQmV1dDNCU1dCNyt2cnJpNDVnbTk1cTFub0NVMlRrcnhPNE1NOGNVeDFT?=
 =?utf-8?B?ZWJ1NVdyT3dvY1hMcURQVld2OFF6N0UvRS9VTDJIeHhOaFRCbE1VL29KR2tM?=
 =?utf-8?B?ZjNRbHF3VVhJcHFVUnp2Z3ZrVDBNYkNHTDdyMGtnZ2NHL3UxRTRYb3VPRFdR?=
 =?utf-8?B?YldCeWZPUUlqV015U3pRWXFMdUhTQllmZU8yWTFoOStKa251cmt5b2xoZmVS?=
 =?utf-8?B?RFRyQ0F5bEtreldvanB0UkJERVB3Y3ZCTmNuVGZxbldzTDA3NHVEMUZPV3Vq?=
 =?utf-8?B?WlVVTStyL1N4ZHZQRUlIc205V1JUVGdncTN0WWlRTkhjQmFibk43TVNCSTZK?=
 =?utf-8?B?UGJ0QU5RenZRZSsvM0tSLzR4elBGLy9MSCtSMWlLTDliRW9nclE1UnJKbk5Y?=
 =?utf-8?B?YmxxZ2JOUTAyS2Y3TTQyY0tDcnQrUkRRank3WnRVdS9zMUNEOVhxUnRDMGNr?=
 =?utf-8?B?N1RjeFpNRTY2YlFFUzhWbGhBbTAvaG1CTm9seXlYaUx0Q0FYcnFSY1BVdWk5?=
 =?utf-8?B?ZjFKbzJwQUx3clA3SVZtSGRUOGk4dW96aDJMN3hFcm1IRmdwT2J3Q0RnK2JM?=
 =?utf-8?B?VERCUlhUaW4rVEtlbWJXdklYVXdSaHYrcjFEQWcrc0x3TmlNMjFKK29Ncisx?=
 =?utf-8?B?TERKaGRRZWwrU3lTWkoxL3MwNlZnT0ptYWlIN09ackxRRWdLeE9Sc24zYVpU?=
 =?utf-8?B?bjBkTkVSYW94ay95L2RvcUNITTFGUWZhYWZxWjB2UllodDhTWnRGclJISldZ?=
 =?utf-8?B?ZEhVejl1eUs4Zk9yemZBTE00eTNhemxPajlKNkxoaGoxdVJodGlaWFpWaXRi?=
 =?utf-8?B?cGhCbjVBajV5a1VjSlZic0pSUXFqN3g5YnVOYzdEYXVDdjhYUlFKZnpRaUFW?=
 =?utf-8?B?TG1EVThmZjBkOWRMQjNMb1doY29zem16RHhuZE5vZG1zSzNxNFU1U1B2aWZw?=
 =?utf-8?B?KzJjTVJoU09OZ2t3Y05wRGR1VWtwTFNBM1poVzc0a042ck1TdzlaVDg2VUV2?=
 =?utf-8?B?QmZTYktCMTFXVGJpUzIvaHFiNXlWOVVrRFRGWjJROElyaG85Z3FUajJCT0Z5?=
 =?utf-8?B?YUVwcDJXdXN1YVRPZXFDQVRpeUZ4NnJzaWlSUTJIZFF4eW5jNTUwT1loemdE?=
 =?utf-8?B?cEhhNXMzbW9MS2trVzN1RExWMjNzMkUyR2I3OVJLUUdEcUd2bnUrK3hzV3Nr?=
 =?utf-8?B?MFNVbVRQOWpjN3d4V055dDdSR1oycWliczA4Q0ZDNkViSU1RZUU1a2RuRFNU?=
 =?utf-8?B?bC9TZFpSb0VRcGNQYk1iN1dCNy9XS0J6T3hIamc5eEhMQW4zamJIUDJFNmxS?=
 =?utf-8?B?YjEzVlc3YTg3N282ZHRWTnRmMXJaNGpGYmVPNDd4N2MwcEEzWG80RVF5VjFD?=
 =?utf-8?B?dkhRaGNYdnQ1dlpFNDg2cHFRNEx5U2lGcXRsdWtqblZJVjZSckVxSXV5TU5k?=
 =?utf-8?B?QzNVeDVvczlyMWwyYjZwLy8zUnBFb0VZVDlyam5NT0FubE5raWo1ODJYV2Qx?=
 =?utf-8?B?Mm93R3RUcWZaY2Fmclk3Y2FSSVdiQnFPWVl5K3RtSm4vbXc5TmFWQWdxY3Nr?=
 =?utf-8?B?SUh6V1VpTGYxOHc5RjRucktHeE8rdFFrQ0hqWERUbmNadW5JTk9TNHhicVgv?=
 =?utf-8?B?MDhRZ1dmR2ZqZmQrcTJ5VTZVTnp1QUg5c1VCNmpxY3VDR3lvNHR6a2dISTR1?=
 =?utf-8?B?N1BpZ0dDUkxZaWVnQngxUDhYVDVkWXhld28wdXUwUUUrZ0h6VFFXdmdpaVda?=
 =?utf-8?B?Q1BHNmpicHVNcjZtVXFIQ0F1UExHbUl2dnFPc3ZPU3RwU0VrS2hDcjVlMlZp?=
 =?utf-8?B?K1Z5M0txRHdTR2Fnd2p0MjVLRVNmd1RlcTBIYWsvSDRWK2gzWkd0NDdZNmww?=
 =?utf-8?B?RmhBOEZLN0JQTzVwODJobVBIMmpMUVhEdW9FWlN5MFJiNkpUYklvWWdvSEV5?=
 =?utf-8?Q?czOj7W/rfdp+b+gV/khrdhHMi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee119060-f64a-4830-0fb4-08daff026535
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:31:38.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnqeeOnvlsjVtTvuJ3aP1q+/sO920BfHM5axM6UbR4i/FQLLOSKED5hsy/m+T0SBm38Bc71ERdvbCyy+hnhIAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5472
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 11:48, Dionna Amalie Glaze wrote:
>>
>> So these should really be:
>>
>> #define SNP_GUEST_REQ_INVALID_LEN       (1ULL << 32)
>> #define SNP_GUEST_REQ_ERR_BUSY          (2ULL << 32)
>>
>> Thanks,
>> Tom
>>
> 
> Patch 3/4 cleans them up with just such a shift. They also move from
> arch/x86/include/asm/sev-common.h to include/uapi/linux/sev-guest.h.
> Is it okay to delay that cleanup until after the fix patch?

Yeah, if they're being deleted later and fixed up, I'm ok with that.

Thanks,
Tom

> 
> 
> --
> -Dionna Glaze, PhD (she/her)
