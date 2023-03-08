Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431EE6B1323
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCHUea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCHUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:34:19 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2786C858A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef+k5DTZonhhgQV6vC8zPU61ErSWwzzDqae/EsmPyLLz0TimpSRBhKSZZNwOqkqvty/bIAF8Fa5wOjkgjAUYfL+BwaPAGkYhyHeDBR8UcmCNtn5cMuN7T6JjVtE0s3eQk82+/++S5vufX05J4Hs4OKMOc0XnHPYFFbLl1+MDTRHGgmUNuo4lLUTttWR98a7Dmpdz5N55z/6xXs//XaQmIYF6PH7GjUyIFXgvWh6FsCPITZCb/9S6jQFgNhh6qevnGNyTLeqZM8r5iIo4XS+/oq5zlSOPGpOL190oIcgMQFLoBRdksCay3uq2MkT8Bt/a4Ts2GuUr1dc95qLz1JqfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVSa2uP0V3oRSLqBMapDjmmeEBwna3odfAkQMx9tzgE=;
 b=EjcKHUzsnnoddq2oWublj6GsDLkWb0u3S7GqSzzgj5XviFl6KTCqaWU9It9yM1rH+TK3fbZpAVJABrM1ldOZK02Skf8uBTpoDfXqducp7Uok/0xI1wM5E+jUHchoAKVsMlyTYjjzzfPnePAvQAi07Ism+EstiJJcJZRzgZJcTdxReAZbR4sZCEzjflzE1yOcf620D21ogo7FviREd+4zegol9iHYtLY3RbUUgEafVpKicS4bJI6vGxvjr8hixy2mAbp6SHjJ/lVvl6E9ccDTHCFW1ZuASnIBveddDgqnrj+YtsicqInGdr58Bw/aK5m65WafIRCCrW7RGHrDkTD7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVSa2uP0V3oRSLqBMapDjmmeEBwna3odfAkQMx9tzgE=;
 b=nGyDNvLUYOLl7/E3M3M9PqlWHidDkG09vV0TadQ0/5qxadqNpcC5gCxeioP0qUqd21Y1mv2SQYntju9/2WsnVuXV3AleK8aD8MwSbtOcRh2roGNEb5BJHR+GRTg1JSjvQA88JbuQhL8EqdKoR1jeAvK0hGnKXpJA4uSSw9TN/Rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 20:34:01 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%4]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 20:34:01 +0000
Message-ID: <1643fd48-c055-ebfa-6790-b49d35fa8d54@amd.com>
Date:   Wed, 8 Mar 2023 14:33:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -v3 00/11] SEV: Cleanup sev-guest a bit and add throttling
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>, linux-coco@lists.linux.dev,
        x86@kernel.org
References: <20230307192449.24732-1-bp@alien8.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230307192449.24732-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:610:e5::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 26784bb9-db4e-405e-9082-08db2014739e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TN8XdzvHTefyF/ZXnCUEav6GVBvC0/3EoFbT0LVzlOpIAhq7ErTq3+L9hy4nfbK7zAMrbKNLBefNS8WhUUbD4aveKnlNlY4G5QS8O1+pt9vAXxF8ga72UIyYxGkO5zsSl8p3ymyt4nMFPEZ8AfZmtwt7u5SBn9B6lrvJ/LwHVP/hvXgOAsIEYka1C4bIVedR1P9evGuOafjbMViNlBTpbOSX8oE8EyWepQcZekeT8vRn3x5kRxEDiLn5RfTsL4p0CU7yQYlA5fjmXB7DinLwYJsyehZMDHtPab6CpcX2aHVpsTCPXhvkI4fxT/C5SduUoccnfWLR8czyRzfJ6Z8M/K2eA66D/MUhW1Uu8M+bY83H6En1+QE1nU3huNg+nja7kYurg57Xq4/YfGiQ5/o1OIKeHGUZD1nsdmS8MqQHL5dgfxgNveKJDYC0J65qV5r5U5IV/JXmfiReIKsrmTHKBxoi2/iWKNvOVePcz91i2OMuV+4v81TAQWTScb/hdda4JB4+bwFbh+6tZDwSmia+1qCuAFXaE2ALNB8Kwe5LevpGK6r2mAqgOZlNFzj0gW9b0ob5CqqJ9vT+CLtEamlNoNMN5WsIUvPhIOC21vwamhZxy1OO1R65r4fHTtWO/hPYjzyCOWf74ZU7tdE8HQFAtzZvBuFUN6527CFoPnxF4LBnTcemRufdCWgdz2IGqReK+PqDu4sc82V+aQsmfSJOsjYInj01qxeRhOrajviN0KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199018)(31686004)(2906002)(5660300002)(8936002)(41300700001)(4326008)(66556008)(8676002)(66476007)(66946007)(83380400001)(6486002)(6666004)(110136005)(478600001)(54906003)(316002)(53546011)(26005)(6506007)(6512007)(2616005)(31696002)(86362001)(186003)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVBNncvMjZaZVdhdlZzOFp5cTRvT3FkaWd1MnBIQlZtSW9JQ3FrMmJ3VVN3?=
 =?utf-8?B?ZWVyYm5kaklxZm1YYmdhY1dUYlowR2FhcjVLUzNsVXJDWi85NUtOcUtCbWo3?=
 =?utf-8?B?VWsrUTJoMEtZT3JSUkNNdi9aTis5ZHJISzFRK2NZQnJTYm5rVCsrS2dmRXRW?=
 =?utf-8?B?MWI2OVc5VTJSUnBIVEI1c2NiQ2FUN0JoNUZUUWxsNEw0d3FnbFlWRWlXT0hC?=
 =?utf-8?B?K1dPeDFVcHQ0N1Ryd0kzUmFoQStPQmFtcURMVHRsOEcyM0VtZ0E5NHR4OTY4?=
 =?utf-8?B?WWtFOHdtZi8vc1o4QzhJbXNoS2x0Q3FoRUdWU3pZbGlHNllyNG9NSjVMVjB4?=
 =?utf-8?B?R1dEVVB6dnlsd1RmaXNwQ3Nmci96dGxRdkdoeElTSmpFT0x6T3BHY1JaRXRa?=
 =?utf-8?B?R1ZrbGZyK29MVFljVU9KbDBnaGE5UTBIY0xIOUVWdStKOXRadU5MQUFNZlFs?=
 =?utf-8?B?Qmw3TnMraC9BTnhldEpYK0hVbkphZTZjbUwxQ1RBekF2ZnZrNHRJQ3JHZTZQ?=
 =?utf-8?B?eHNydzBGcjRsV1JPZi96d1d6YTZmcXlLamxBODNKN3I0OGdZeklTYzhrNTZI?=
 =?utf-8?B?SythLzVWMk1Rb1hEK1cyWE50aGpjVmUzSVRuRExub3E1S0hLM0xBbjFVV3A3?=
 =?utf-8?B?SVdvb0NXbnJoZDZWaXdoV05zOU8zUmFuMWRmQjd4M050T0x5NFVXbnRRL2xi?=
 =?utf-8?B?ZHlFSXVrZHJpUjBwQTBBVEExWEZzNzJITjQ5SCt2cmN2Z0kyMWRwcDJkUUVs?=
 =?utf-8?B?VDU3cnRkMTlPWDYrR1JxQksvTjV1ZmtFY1A2NXVCMU8wWDhiTnpWb05WTEVK?=
 =?utf-8?B?N0U1dENZMVY4TEVaM2dMRVZ3M28wOEdSdEg1MlJtcHpyTEJkVHd2TjdISTZB?=
 =?utf-8?B?VzZ4OXV6aGlOQTlGa3NBZ3JwLzRaOHJCMkpaM0FWNklsOWNMSllCWnZxZTBl?=
 =?utf-8?B?cTBFQnNkaXR4ZzVJbnNSelplaUJUTW5mNktiY0pybnJ5UUdjZUl3VmlMTmkz?=
 =?utf-8?B?RnlpMUJaSlVCMU5iMGlQd0hqTURodzY2ZTRmaVhub2VrU0hGRVNKM1ZoaGxJ?=
 =?utf-8?B?cWdkTzNWMy9laytNSXBkeEdpZ0dhaWdtbVJiU0ZDd2VPem1DZDBJV0hlejdV?=
 =?utf-8?B?VUk0bTcwNG9WZWNlSmpjUlpIR0IxYVVvUmpTeDM4SjhyUzk4NW4wU2NmWmkz?=
 =?utf-8?B?bHEwRFZ0UWFYTTdPaS9FL0VsSExYOTM2V0w0aGJrZTBjOHc1OFc1b2VTa3JL?=
 =?utf-8?B?MHlNVFVZZnNNUmFtbm1RQ1dmVkVGTlNSRUZlM3BlTmRnN1R5TlBPWEMycXpJ?=
 =?utf-8?B?eDFXakFHbHF0RCtUdzRVSEVvaERDY3JpTmxBK1c1emN5OWxDdGt4SU51MDN1?=
 =?utf-8?B?My9PZGEveVpHYk0zaXZ1Z3VHRDZXbnh0S3VVN2xLOHR0Yit1NDVoenJBSDlZ?=
 =?utf-8?B?SHVWOWhReFRTNW1jVzcxNVJFMmJHU3pIZ0hEN3F1VlJ3dnNocVNDZFZvdDFM?=
 =?utf-8?B?a045dVFaZlYwcVJkbXYyUURzS09JUGdhRlpVM3FnVnl3SFB4QnhmMVQrM1lY?=
 =?utf-8?B?NnZSWjJBRjFRNzIycm10U2hITmQrMW5td3J5SkpUNStxdHpPLzRNQTluc29y?=
 =?utf-8?B?ei9BYmFZa21NNC9pdmk3dlcrT1hFSTN5UWl3NUZqVS9BSnA2RFVobjA4ZHVr?=
 =?utf-8?B?QjhuZFRiMjFpem9PYUkzNXB2NlV4am56VUNEOS9NK3kvRGpBd1JFZUJIczAv?=
 =?utf-8?B?c2tFbFRjR3RxUFl2aXY4MWVrK3dicXJBR2lXKzZzeVVXN2NNV25GUVFtMjJx?=
 =?utf-8?B?S0ppbGR1U0JubmI0MkxnSzB2Q29veXcwNkNJbkJwOTZVeGx1ZmMzMDhkS1BR?=
 =?utf-8?B?dHBJeG91aEd2NCthRlVaZ0FxYWU0b2UyWHF5UDdLOXdwQ0dlYW9JdGMrc1Vo?=
 =?utf-8?B?VkNRalh1eWQxZU8wUExzeTQvMElBYUNzeTg1ZTQ1UmRTRXR0QzV4eExramIv?=
 =?utf-8?B?UmFRMEhsT1owTUNiUC9rRWZCL3V1TEJKb0h5V0crOVNKeStOOVl2cU11Mkw5?=
 =?utf-8?B?eWlNOUxYQ05pWWk4S3g1S08vYXNwMUNXNnBmKytKbjdrUmpHS0ZGVmY0eFVX?=
 =?utf-8?Q?C26Cl846kLDQCbRrC1tOmQnMp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26784bb9-db4e-405e-9082-08db2014739e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 20:34:01.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kE+CSqopx0P7iSoI5pfx9ZrAA0waLCsqMr6JcLK3z0Ytz1db79rN+fmJ59xT2htZ4vFbMkD4UaMB9frFN2iQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 13:24, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Hi,
> 
> ok, here's v3, rebased ontop of -rc1 and hopefully with all the stuff
> addressed. There's always room for improvement but that should come
> later and ontop.
> 
> Thx.

For the series:
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

One thing I noticed is that patch #3 fixes an issue where the fw_err field 
returns uninitialized stack data when success (0) is returned by the 
ioctl(). There's no Fixes: tag on that commit. But I guess the later 
Fixes: tag on patch #9 would cause #3 to be pulled, too, right?

Thanks,
Tom

> 
> Changelog:
> ----------
> 
> v2:
> 
> ok, here's v2 with the pending stuff fixed.
> 
> Thx.
> 
> v1:
> ---
> so I've been looking at Dionna's patches adding the SEV guest throttling
> and that request issuing spaghetti was getting on my nerves. And it
> would've become even worse with more stuff piling ontop so here's
> a first round of cleanups before adding more stuff and making it an
> unmaintainable mess.
> 
> The final result is a lot easier to read with proper separation of
> functionality between functions. I want to get rid of more input/output
> params being passed back'n'forth and use a struct instead and Nikunj's
> patches have stuff which goes in that direction but first things first.
> 
> After the cleanup, the new stuff being added is a lot less code and
> almost trivial. But I've been staring at this for a while now so it
> could be only me who thinks it is trivial now. But we'll see.
> 
> Initial smoke testing seems to work ok but I might've introduced some
> funky bugs, ofc.
> 
> Comments and suggestions are appreciated, as always.
> 
> Thanks and thanks, Tom, for the help!
> 
> 
> Borislav Petkov (AMD) (7):
>    virt/coco/sev-guest: Check SEV_SNP attribute at probe time
>    virt/coco/sev-guest: Simplify extended guest request handling
>    virt/coco/sev-guest: Remove the disable_vmpck label in
>      handle_guest_request()
>    virt/coco/sev-guest: Carve out the request issuing logic into a helper
>    virt/coco/sev-guest: Do some code style cleanups
>    virt/coco/sev-guest: Convert the sw_exit_info_2 checking to a
>      switch-case
>    crypto: ccp: Get rid of __sev_platform_init_locked()'s local function
>      pointer
> 
> Dionna Glaze (3):
>    virt/coco/sev-guest: Add throttling awareness
>    virt/coco/sev-guest: Double-buffer messages
>    x86/sev: Change snp_guest_issue_request()'s fw_err argument
> 
> Peter Gonda (1):
>    crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
> 
>   Documentation/virt/coco/sev-guest.rst   |  20 ++-
>   arch/x86/include/asm/sev-common.h       |   3 -
>   arch/x86/include/asm/sev.h              |  10 +-
>   arch/x86/kernel/sev.c                   |  33 ++--
>   drivers/crypto/ccp/sev-dev.c            |  22 ++-
>   drivers/virt/coco/sev-guest/sev-guest.c | 190 +++++++++++++++---------
>   include/uapi/linux/psp-sev.h            |   7 +
>   include/uapi/linux/sev-guest.h          |  18 ++-
>   8 files changed, 199 insertions(+), 104 deletions(-)
> 
