Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A8160B09F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiJXQGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiJXQEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:04:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA62B26A;
        Mon, 24 Oct 2022 07:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjAI6F/0AfbSEfrnseMKEMsfSX1/mrYID3DxmYjDlMb2mj91w87fsiTOfs72s/McL5iXrol6Agid+8GlH3uKvggFXejXKYPtbuTRiozGnhOZeCWHCPqkRKDgI/e9R44P7+vzPkWApF7l6rDyLWlpO9dfjzbZiQcAW+KfcyvyyPx8wVmpOlB/khW8350b4dTqMHHBT+7s2i5G14OQkfJKNKPR2qILM6ErRRnUbSbMO68ZVK+/euFQvCya+BaIlzxIQrdyJhdIKu64WDJ9UMnxneLH51JUtrQ+Iwvk87VPsAjsvnuNM3LOmZta70gb53dTHFWj95bAP1LGBneHkzVnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioittwS6gWcR7E4dED06JPZpwbkV9n4ItMsNPU0tgYE=;
 b=Er10R5cNuhSCvVakX4wVINY8EOBVsRLjVd8T4p8IGN/BlIGAhGDwP2MKI4GblUxiCAZWYLdZSw71gcZgZoE4Vg8tb9JVR7pP9vozz9BFJqUIof2iNkqZFt6xA4qF3TdjhvTpMEh6usZ2pG7qytGHTQjMbHpzrFVB6aqrucVZrlZh3oeWsQS8M4ZlvY4SobUz9HPXqHDgHuEKFXF1sL6RNdM8ZRxIiGPPu3xrA8gjQhxoAwmtyhE3crNYyImVHvb0N/2xdnPAY8uVtCEWQ1b0zTbhCeqKCW9lflM7miBSAHXh7+0RqTwLMW4S2bsJLek+FFhQ+7ggHrf+viQrE9WuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioittwS6gWcR7E4dED06JPZpwbkV9n4ItMsNPU0tgYE=;
 b=qZNc7l0nVGolGi2KcCUjYC0tiodH4XP7f05m7CoFr27MOlu40pb2mM8bWYX123ESqN5ilfAS3yld087xpatY8Kqapko1oXPS38YrYmTJ/Fd/rf3F9JM7WVG5SWaf0f+eSZW+SWIunzm19uEwDY5nNiDQCMUFbhbd3na8VX7CiB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 14:53:42 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 14:53:42 +0000
Message-ID: <7be10c0d-4006-639c-0fc9-5537b2390714@amd.com>
Date:   Mon, 24 Oct 2022 09:53:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] Documentation: Start Spanish translation and
 include HOWTO
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221014142454.871196-1-carlos.bilbao@amd.com> <Y0ork19pGMhZq8qn@debian.me>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <Y0ork19pGMhZq8qn@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:610:57::28) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea0938f-ce04-401d-3439-08dab5cf8b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFtU2XYkH/R9dD3uiVXbDl+6PtVbS0JOWQ44b1kSjzHRj4vrc9v/a9v+lr3x7ddXA2cWEEIpfV2Ji/yeV2d8AKQ+tGYf+OveCvC1MFxJyUhA0rabftDqfkxX4pPS/YCHCyWn41vYl2k2lPP6MA9WQTQKrlYe5PDQYcvyXwkw1fUmZ0NrHzWvKddtHE5QwZVrfFVWAhT1tYvm2qNcnQc32bwI6yxTdGvxqexCmD9fxnYqu+flmLdCWLpqeT+bA3Vm99ayWHTPUCc9EWjGAK8SDNh1/tDNxYnjtsL20xVy+gbYSLRYOO61JIyVXdjnBiWWMmGbQ8jP7i9u/8ABIZa4cBR39JcMFt6fPgDjxyk4fQMGltoQPxWkojr1RVc/4UFVB9dd6rk0QqwlTivzaHPq3VBZtstSQB8yA7if63Jj3mXzXVWLljJ01KQaX7hOd/E2J9mO3/MtWzYP4JdrS1abdkipPh4JOmuiyNlAtWiTQSBDzgZ4pz4W9BwQT96UxyQrdcClKI3LHFNjmwKnhACBEMOtRx17BHoGz6XZ7H9aYJJ2bQACHgAH+fx7M+Nq1gfE/8ExMrxfHQZ4B4RhFKmPSK2Cgyrr30aASxlpcPr07pGFW06HGXefeuUooecOddaGfrclPGo37jBU5LEhSw4/cTSxTpPH4X4bw1t3UhkwJQtpKfT/Geczvr0F03JDE2jQ6R76GpjVrp9pXzcrGglDFNSCj1LKSkpK8h/DTc+Xex6c1vIDoCEPvJhOs2ylxW9HkkeyjznZRjhA7c2yPOAdpQ8pgt7MRZOCSVT7Ybe7D50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(31686004)(2906002)(41300700001)(4744005)(2616005)(8936002)(186003)(6506007)(36756003)(53546011)(4326008)(31696002)(44832011)(86362001)(5660300002)(26005)(6512007)(66476007)(66556008)(8676002)(66946007)(6916009)(38100700002)(478600001)(316002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WExZS1lyYm40MDZZZ2MxYkM0ZEhPY25FcEJKKzYzamFVaGk1c0RoQk1SMWlO?=
 =?utf-8?B?V2lwUnBJazJTV0xoSXQrN2ZjWmN2Q3M0Rmt0Vk0xUnMvbW9KV2t6UzJGWjA5?=
 =?utf-8?B?V3k0Y2g1OUFIMEhzTDFKODVBaEVMWVVVcTN5SStXL0tBLzlSQUJQSDlETW9U?=
 =?utf-8?B?QlVIb2dKT2pqK1NjbGZhbUVOdjVLUmMyOWZDcS81SDMwelFsaUVNN1ZYaVVm?=
 =?utf-8?B?VlN2ajFKUi9wNVlUY0VwOUl4Z1lGcHF0ZWpxNktmd1hwT0U5N2JnMWpZcmpv?=
 =?utf-8?B?NXhsZkQwN0ZnRkxpbHlraWxpTjg0ZWl1SnFUVStCbFhSWFhsdU9Yb0Nwem9R?=
 =?utf-8?B?amVpcUpDRmEwMWZTMmprYSs0Z3FBQjRhSkgzQWdZUnRNRE5tRlNUOVk2QUM4?=
 =?utf-8?B?NGVsbzgvczFwQTNPZ1Vxa0gyMlRnSUsrUHlYZExoMDFCUWsyc2xaNW9mVmZW?=
 =?utf-8?B?UTU2NDljRytGaVRxUFVOWm13YW0xSUFjczlzMVIzWERkTWlFdmJvZzdvYmNx?=
 =?utf-8?B?MWNXVlpKaXF5cFJCamxMaXhsVFlIR2lxWksreitCNUtOOThEcDZlM1Jtd0po?=
 =?utf-8?B?OXhlUEdGSVlIaDVQWVlLMUd0dUV1azFvRGhmVDNtY0syV1MrTllMTjZwUkx1?=
 =?utf-8?B?dmVxVWQ1NWFxZjJaWjJ0WEs4ZnRtV3k2c0NleVdPNmJBdDl2UWVrUEtsVmMr?=
 =?utf-8?B?NCt6MkRZWHNzWE9CRitQaVZnN0JxV1dHSmZKU3B0ZVR4QjhlTkM1c1d6UE1W?=
 =?utf-8?B?Rzd0ekV4azRwRHptQ0ltYVRsMlVsWDVqYjBGOFFPKzViRFVwenpYdUMvOFU3?=
 =?utf-8?B?RVFzaTZaY2JlNU9kSll4VkF5Wm81VXJaNmFNdGNTcjlrVGM4bzR0QVByR0Nn?=
 =?utf-8?B?cjF2OGJhSmZzQTZ3dEM5cEw1L3pRdnJpTXliSWVKUzd2dThKR25Ka09yOUVH?=
 =?utf-8?B?dEpqbkcxM25FTG8xMzFBd1V6YzJnTVRWSTlaZklrS3pEQzM4M3RHUHNieTlZ?=
 =?utf-8?B?YnNBSXNyNEFxSGt1WmQzeFdEMDZLbW9lWC8xUlZGNUJyQ0tPRis5aExYMzEy?=
 =?utf-8?B?cG9VM2JURXBlNlFXYlZKcnNid1kzcERxbWJDVGFQbjEyS1FrYkJWNi8rREpj?=
 =?utf-8?B?SGVtZnBDbStRMEptL3JZTnJYNHE1OHhsODBNL1JlUmtiWktSZ0dscit2VTdK?=
 =?utf-8?B?eXlveCtwelhpWmtTblc0L2NnVXJGelJGMjZ6MFhBeFdSMlEzaFVramNraitk?=
 =?utf-8?B?L0Z6WWxwUGZRZ0tWMGNSbTgxOU5ZWGgzRDhmbXB2Y1daS3pIckx3a2p1K2I3?=
 =?utf-8?B?U2Rsc0Vubkx3dFYxQTlNaEFla1NobHBoaTJKeFVzeUp6WEt4alhtQXNkMzZU?=
 =?utf-8?B?YVdCbU0waTk0bm0yQ1RCNzB5NURxSFEyRERTTWJzYXdMTUZlb0FTb2hrb001?=
 =?utf-8?B?b29FWDRPa0NuTVdIMXhFZWpoL3JleW1BNTJuY1dZVU1LcEMrU095SUZudWNq?=
 =?utf-8?B?dVFpeTlOUklMcUxwWjBzWUc2RDkyZTJsb25CVWNtM1gvSVlJRXFLV2pVeURh?=
 =?utf-8?B?UHRSSStuWlMyV0FpUWdFQ0xXbEgrZSsrUERMdEp6aXdhTUxRaWFFU2FEVGdy?=
 =?utf-8?B?TXRQMEJmU2pkMU0wYi95SEgwUDdQTDZqaDQxZy9iTHFYcFpUblFla1R4RmYx?=
 =?utf-8?B?N1djY282M3REcllIeWlQVFhjaXlHa0w3WG1JY1I5VTM3VlZkUHhuN1V4RHNT?=
 =?utf-8?B?aE1UUTJzZGlKNkN5TlZrc3dkbUtyOUdaUGc0RVdpaWNmTldiTUNHUGZGRWJn?=
 =?utf-8?B?K0dBNVo3NEw4Rzc4V1FrUktDekcvampyc3ZnanJRODBuOGdlY01DaDVhSDVu?=
 =?utf-8?B?TUZJY1dURnlYVlEwOHBjeUt4UXhZVXIrMGw3ODNTL0VPWmtxT1dTWEVXY0tD?=
 =?utf-8?B?d2JVL0ViUFpFN0x0dFpxR3I4L25aWFRRSkVNaGZmbGpjRDdBdUVoUmUvZnYw?=
 =?utf-8?B?N3FmOTFhMlU4bENNZWhtT0NKOGswREZBanZ0UFNBeGhTMUJUbmhkZkk2L3lr?=
 =?utf-8?B?bi91SkJFbVlZRUV3TDZ4aVV6Q0NKRXNYTTh5VVRJNFcyRkM4L093cWFTcDRT?=
 =?utf-8?Q?Z6htWARQVSjzX0E0UnNRqFwuu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea0938f-ce04-401d-3439-08dab5cf8b14
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 14:53:42.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcFrXHqc4kYm+4nxUpV79/5r1HSTpa9vEtbamKZQw1MfnwteisL2tRpbVcRrEkgm3LrmCS6zH1Hm9JpRGzk7Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 22:40, Bagas Sanjaya wrote:

> On Fri, Oct 14, 2022 at 09:24:52AM -0500, Carlos Bilbao wrote:
>>    Documentation/translations/index.rst          |   1 +
>>    .../translations/sp_SP/disclaimer-sp.rst      |   6 +
>>    Documentation/translations/sp_SP/howto.rst    | 617 ++++++++++++++++++
>>    Documentation/translations/sp_SP/index.rst    |  80 +++
>>    MAINTAINERS                                   |   5 +
>>    5 files changed, 709 insertions(+)
>>    create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
>>    create mode 100644 Documentation/translations/sp_SP/howto.rst
>>    create mode 100644 Documentation/translations/sp_SP/index.rst
> Why not es_ES locale slug instead?

Just answered to this in different thread within patch set :)

Cheers,

Carlos

