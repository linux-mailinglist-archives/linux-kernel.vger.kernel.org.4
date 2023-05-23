Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875470DDC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbjEWNnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbjEWNnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:43:13 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA70E56;
        Tue, 23 May 2023 06:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHS9++whAFG5ByM4guRDspHDTLSYYsO9/onUfYjc2p6oZ6ve6Xla3FefDKep8WEPteUFs/fq22EsaIGKTHMRyfoD4at8b8dOo6Rej1iSb8lzRtfFpktVNkN5YSfRaVmvuS9ZwBeM7+g3gyoYgJ8yOrLmSTF0NouD+f2RuwMWwU+cJeFGVKZd4ysXfE6Uhatj8bDRQAqKakAkLRQFe9I6QtQEJxnPmsqiUE5onbXz5KLL6W3tzk2ZBew3ney5O0TlekXTJpWfcambmv5rv7AZN8tRnoEYbvd+rEBQLfaKbaCebNMJT8v3Q0jMKqqqsiCenfQXLPcVwQPuyE6zOTZYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLKbO+iTqLuU/IwxJrCCK1Tr5hf1ao1eJ3XA92l1sj8=;
 b=P5DLbQgHBVuvGepHOJkYb2cpbxb6cPxIPuy9+DWBq9vk1XjQm6LmNKMRGHrqv9WZUTsT5C281bw7PgHciqh/HfPRN1EveeePPOyMvyy7XCpsQwszANMSkr0FIMnpHla3Og3c2o6XRNNcYFLW3QUYp0UfL8aKiYpLGzP1gOChd7bcGfkq5c7v5i51vlnMVM18yDpm6nLcsQzEAbbAdh+Q3oNVcbg0ejtKmuGqIxD42YN2J0bfCg8rzHUxaIFS9/trg9KbL1NGDSFtiQ229VS+2zeQjWN0hvWSzzrdIgXPlZY7ybLdaaXDspYPJe6HYmSXRvDD9a7+7207HNPVa6sXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLKbO+iTqLuU/IwxJrCCK1Tr5hf1ao1eJ3XA92l1sj8=;
 b=MddUo4I+y5s11zyK61V5kOWHLeekVYqFMuR4amoPsWkP2fdKVXZGSMlG8qhPPGNpDvHaUKtCUQmk6oTxWvMy2d4Pxn/VjOszobbocZbfP/1Ly9cV2GA6FVBxAr22GwnN6gsS9yk5AneofI78YKUHzuXDIPvhnueGnIFxp43rfMTSc0SJVt2Rs3VrOPjGpR1H63rdQ3O4S8mw4SpuVU5Mzf3oSMFBjd2NZFd8pqtEc9Qb9fU9i+/x+rDf6giRBfmaDbVp4pBxhqxlYNiy3YJvDKaUJrtTAo2lyLdBEwau+FCVmdVhbLdgKzkRTFvVJ0stlINxkJflYy4Zr5qBMj6QbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:43:00 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 13:43:00 +0000
Message-ID: <a3d7c16f-fe87-9c04-5f92-42f10597df6d@nvidia.com>
Date:   Tue, 23 May 2023 14:42:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] gpio: tegra186: Check GPIO pin permission before
 access.
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Prathamesh Shete <pshete@nvidia.com>, thierry.reding@gmail.com,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
References: <Yz62XmiH8YG3Dtsf@orome> <20221007055936.5446-1-pshete@nvidia.com>
 <CACRpkdYkJdZ67kyTnDg3xFzO8MJhC0nHK98O+KJwCLBqV_5f-Q@mail.gmail.com>
 <1de5b7fb-a39e-183a-1407-7d6489f706b4@nvidia.com>
 <CAMRc=MdCiieaYR3BeATm+2o8UDz+9D5vs=dTNDAavi19BmKZ8w@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CAMRc=MdCiieaYR3BeATm+2o8UDz+9D5vs=dTNDAavi19BmKZ8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0422.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ0PR12MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: fba45945-7a39-4e09-ba5c-08db5b939fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xqd7VO+J+UTE6VxfG5RWGSROcqCRHESvzNk1MA+RpLMOcIiEF8eFMTWLDCytgFKf79Nx1ZF3FRevM3bLihgVtDuhP41MDw0/N3BNrPQ9zE80n2rfDe6aGXhD7tC//W4dRdDm7/OmIbaW5YSDgUjXrmAqeLpT/VOcLu4LGfuVBpc52zqH1e8yiuz4B9EBd3GNA78NVPekZE8tlPyTjTXdyyMewtf4c0wxoAGGxP7jbDojZFO3EMseOQLVd6J5WNYWgVajf3e+SN2bFhbdvxl8pjn/It8TfqwuX/4fwMAv9FpzzrdvWHUTxpoMUf9TPjZDy70lDcuybI28r8fd8A65pi4LDmxZ2ppcOwo64nOjtllrCthYIj15aiI2Yk3Q4W69B4LW8KenQrqHW0fIpPL0b62RArYDF0om1SmYSL+GXhHroJZY4EWmmHT0o/+X9A9rrXzWUoJMkejM21jpkrCtZBTWJijlm3SSTL0btMep8T/cX5YIpX5Hh425I8hDGIwDG5NCixJnEHjZA9kM9TjXbXz2umU9LDgmBAwPqFAtpTDKbJt0SNw+PAv22EXrkXiAaoA1cEO283e6CfaPD4pZt3BCS2sTv8IW49PmYP39Q4QYmICE5w0rZxzSkjRxmeLJ/0pfU/+tohbPZkVp8LFsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(53546011)(83380400001)(6512007)(38100700002)(36756003)(6506007)(107886003)(2616005)(186003)(2906002)(478600001)(316002)(66556008)(66946007)(6916009)(4326008)(66476007)(6666004)(6486002)(86362001)(41300700001)(5660300002)(31686004)(31696002)(8676002)(8936002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R09FNGZiTTZqRzlwaHh4cStOZDRuOTVyQlM5SE84b1RuWEpEQklIQTI2R2tR?=
 =?utf-8?B?ai9HMlpoU3JXQlJ3UkNqbnBFYUdncytEanVWYlhhbjNnclFYUWE5TlltYUVX?=
 =?utf-8?B?NjVkQ1hDNmRndjMxeXk1YldMNUpZNUhnNGsxakQrdW1WczNjTzFDZmxtazM3?=
 =?utf-8?B?Wmc1MERFOXIrT2tQbzZUZ0o4aVJ1N25FU3NCUXJBVHdGWXJDZHNEVzd3dHYz?=
 =?utf-8?B?bmU5SWFUYmk5bmNKOE9CY01URWdPRUNNcEMwMzJ1UmRZK1U5aHk3YnJiNGl5?=
 =?utf-8?B?NkpIeTdlcnEyU3BWZ29KTStmalcvU2RVOFliMXJJcnZVZmo3WmdqTE9qbXN0?=
 =?utf-8?B?a3R1cS8zUVd4SXJta2hTc3FGNElrSWxhbXNJcW41aGxqSksvK2llR3VCQ3hr?=
 =?utf-8?B?elg3TGFBZmxnUm1NN0E3RnlCcG5xY29pMVpidUZVdUdRVVhwN1NEbHZicGcv?=
 =?utf-8?B?KzJJYU96Y2Vjdm5IMWR3NjRKYURKOFZ5aitta09BNE5wQUNCaVJHU1R6VjI0?=
 =?utf-8?B?N1lKSXZjRC9rU3ZhcGNhYjBmSXpLcndYL1krNzVPNmZWUnErRTZDb2NqSk53?=
 =?utf-8?B?VVlHdU5wYm9vQVVwemxQRFNFb3prTmt1WVpIMThKZ1JUd2EvcGViOUhIYW84?=
 =?utf-8?B?SGpVWlg2MndST1RqeW9pNWp2SUl0SXE2TEx4RG1sdFpXeTRHWHd1MS9oRksy?=
 =?utf-8?B?aVJabnYrSkY4anFWTm1seG90VmZkd0xUMTZ6Z0xWK2VBcWRueG56eDlBWTVq?=
 =?utf-8?B?QU0zUW9RVHEzT0d6alMyVlNlbjY2TUpSY3B0THNrbFczVVhUdDkybGwvVzZF?=
 =?utf-8?B?OFRNTjA0MmJiZm43UnBEWlRqRW1qNXBTWUVSS1plTW90RkVKT2tEMFMxSGJ0?=
 =?utf-8?B?UG90WFVOSjNMUFZnVFJrL3o0UWVoZ2JiNldXRHNMME9RSzdtWFFHdDdVZ25u?=
 =?utf-8?B?Nm1MVzc2NHN0Mkh0OUZpS3NRUFJZcjJXWjMwc2dCNG84YmtLRGo2MXVpVjV6?=
 =?utf-8?B?bGhDWEV4VnFlYzdaS3NVZUI3WFluOXFFYnAvTkw1aUMySzFXMHNsNHhQS3lD?=
 =?utf-8?B?dzBkZTlMQzBaMXE2TXhPWEtPOTNpS28rZ0txNDlmcm8zZ090UHQrK0pmUmdJ?=
 =?utf-8?B?WFFyWXRFc2tuNnkxUlB4Wm0xUDVsMHA3QkxBT0dsQWcwbmlLR1ZYaWhncTNB?=
 =?utf-8?B?cHNxdGZkWE1YTXg4RXFPMStKT1dNL1dRT01yNUxPZ0hhTENhTXh3N21aUmM5?=
 =?utf-8?B?aE9YM3JsNDJvd3IvcUJoN1FTODhmcU1aUUkxajczVW8wSXg2S2hDMzFQMjVR?=
 =?utf-8?B?MUVMNzlseStJQlhGTUREVFpKUVMwWXhObjVCS1dTbEdYS29BSVFWT3lwWU1Z?=
 =?utf-8?B?aUxqZkxaK0ZrTjJqMjBTb2hmNldvaHpoUDNvbS9XZ1E5V3NoTEY1K0c5REww?=
 =?utf-8?B?dG9ZQlZxUEZqVnRJZVM4VnNMYWhJVXZXbWtMWG8xYXBCWWgvWWVwMnd3cjZX?=
 =?utf-8?B?M1o1WDd4NzFXTElWQ2ZpK29XcHVjdDkwZW9udVlKb3ZxejFjTEI1S2NSb0JX?=
 =?utf-8?B?djBLaWdVRlhYV3poRUF2cy8yYUsxVndWSUJ1REVQTWYyYkhoQlFqUURCYzdB?=
 =?utf-8?B?ZTNkMUVBdVdDWEZTN2N2OVRCaXcyb2kwKytNZkh0SFYxT3FKWmVsbFp2SDJI?=
 =?utf-8?B?SWx1SFN2ZnVJUGtxaWhMVVR2dkFCb2VhVlRyQk81am5LcVU4RmpTNEhRY2JQ?=
 =?utf-8?B?SkkrZjNVcjlqUlpQM0VpdjV3eEpGMExNUFFmcVZVdG1mOUhGNGZyVEF0MXFI?=
 =?utf-8?B?blFuYm1UUVhsRCs3YXBOaVFURCt6M1V6cVNObWFrRHBXVzNtc2kyUXFBcWRL?=
 =?utf-8?B?R2R6cVJScS9HWlAwTU94UkpaQXozS3V2dGd3d1dNcitQOFhOV05tWXFHY1Qr?=
 =?utf-8?B?ZHhWU0ttL1R4aURRMjZHRmkzUktxY2p2NzZ1cUtkdjFjY3UvZWUvRnNwUCtQ?=
 =?utf-8?B?Vlg2bXdNTGczdFhSdFZ1NkF6cFZTcWZWTyt1b3FuNzlNK29CL1BVVGFUYjUw?=
 =?utf-8?B?YXdidmtQdFY2bzRjOXBBODNsR0o4dmh6eXdkT1Zkb3NnNFJQeUsxVlE2Nzc2?=
 =?utf-8?B?d2VadlB4czZtVE9vbis3VlJjMm42Q2hKUkxsdGxDdThuZHJRNXkxT2VvMTdK?=
 =?utf-8?B?SDRpcFdBdGVyREZqMnZWL1l0UEtodkJRRnN6YnlEKzRCKzJHSXhwQ0U1MHg5?=
 =?utf-8?B?QU44NEJVNkI1cTJEdys4U3ZEa2FBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba45945-7a39-4e09-ba5c-08db5b939fb3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:43:00.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qk0a2dDSn9JV69gWhE1KESIa+B8WE8tDkWGJCHycWcuNo78VAeIONO+Nuc+0+xszwNiLm56YGMAjllu5G9q3Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/05/2023 10:17, Bartosz Golaszewski wrote:
> On Tue, May 23, 2023 at 8:22 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 17/10/2022 10:31, Linus Walleij wrote:
>>> On Fri, Oct 7, 2022 at 7:59 AM Prathamesh Shete <pshete@nvidia.com> wrote:
>>>
>>>> This change checks if we have the necessary permission to
>>>> access the GPIO. For devices that have support for virtualisation
>>>> we need to check both the TEGRA186_GPIO_VM_REG and the
>>>> TEGRA186_GPIO_SCR_REG registers. For device that do not have
>>>> virtualisation support for GPIOs we only need to check the
>>>> TEGRA186_GPIO_SCR_REG register.
>>>>
>>>> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
>>>> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
>>>
>>> Very nice patch!
>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>>
>> I did not see this anywhere in the mainline/next. However, I also
>> noticed that we don't have the correct email address for Bartosz (again).
>>
> 
> I have only ever changed my address in MAINTAINERS once, so "again" is
> not really the right term. And scripts/get_maintainer.pl should be
> used anyway every time when submitting patches.

Sorry I meant that WE did not send to the correct email AGAIN and not 
that you updated your email address :-)

Thanks
Jon

-- 
nvpublic
