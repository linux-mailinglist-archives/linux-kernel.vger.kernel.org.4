Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA80D6F4218
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjEBK5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjEBK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:57:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E73C19;
        Tue,  2 May 2023 03:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FI6nqUgysBxLSKu7UtDmdyixaO6lRkglbTerYKPVH/b3jhLWYlbwjM1zjiMUbFuZ1pWESfa59bnM9FDBVQd1FhYVxDMXGyi9gkX+3xoVpKp48ttntnbdgRqH67taSlt6zEkkcT5QdnjC/p0+qWv8LDMGY1bhABnUqXg6/PncvUMIa973e6bwhLI9uAhLZ+PoV2hnagtgQujJ+C+gMnLPyPLfHzfEdFoYm3gCmuFaJD6LgwuTDTIh4fh69W2w9g+xgWJR4pvUvZC7/vaxAxEVtNUetlApT5OQW6RjT0sVI1YizxUQm6AG3zlrexzXVWxc9PPKOHstIFCIQMceHpdANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry+IjZecHCSUkD3bP7lczR9c2MOknPHyey/Q5N9qkCk=;
 b=Ri7rOzGPfQP+Gpxp/xmDaE3LEsz1EEP5C2XhxwShB/DbbgR/qBSEK10za677sDgdr1F14XPuBsZ6i3EHYLeoojR0/JrmhJcj2Hc6eYOT3HZ8oaWa3ss4AU5j2ER35JhHJPJh2X3lecxpQxgXQg9P233efE6ivSH96BKXs5JN45oPA53HJUkddhFdGZRwUG35ZKD7Y3HrLvYEV9mToB/eIpYdslopIhLnIt94vgOvVnScNuHLGLTsFhk0Msw09W2xf44SgG4HrEiGEMs5y1E2Out1JHRBH5kgj4tnx80LK8fV0+FCNnZIpgFWaF9PCCCa8YgSynSLWacBVUllcqifQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry+IjZecHCSUkD3bP7lczR9c2MOknPHyey/Q5N9qkCk=;
 b=AUQiDHzND5/b/c+dFSYzSXKHvKJ+t6mxkgGWgw3BHxLnWeGdZLwa+FjrAG6RI0S3kAbxXUA851OxsxLOLDigatmhIRPRHRlV3keOspYhkMN6xPMrANVaY1sdXcqJTo3wiNsbhA+IUKwXbwRa7/61gjerRYrvOW/fGh/zzKVMFaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW3PR12MB4570.namprd12.prod.outlook.com (2603:10b6:303:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 10:57:40 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 10:57:40 +0000
Message-ID: <39d3e076-94ad-a349-5df6-b6e78714e407@amd.com>
Date:   Tue, 2 May 2023 12:57:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <1682512187-8828-2-git-send-email-manikanta.guntupalli@amd.com>
 <20230427164351.GA3146210-robh@kernel.org>
 <DM4PR12MB6109C2BCDFD616AE37E10B9A8C6F9@DM4PR12MB6109.namprd12.prod.outlook.com>
 <59b9214a-19e6-fd4e-6982-6e8c28c7e4a8@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
In-Reply-To: <59b9214a-19e6-fd4e-6982-6e8c28c7e4a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::12) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW3PR12MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e88966d-0013-4538-63cd-08db4afc0b99
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vLhd/LbT9uyOwk+yjaVzqGt9+InY998fbpAscOt8yU/htO19aKAelU+Y3I1yqrdjewKHFhKxINAU+jbA+J3B5h9DmVkBW4UTfXvoMEsPf3vtpOmU/o6AglpuVbBnEJpPiywfTUEHJIRkytU1brb0yO8j4C+sql82iszdoveUzOH6WxujMzZnr1Z1tC0MpfLMPHdSPEDAoIkOR+lCgv3KEOIpfqkI4MqJQZs8sL5DumPFa9zTHEk39h4bksweXRQTsNnzkOfLdi8QEVRp6sHyIuw8eUuWks0ckw8+O6GC0eP2d/QR5FZuVRj92iklSwHzbJwI3FV+CaRUkN2k7hmaJG+6TdpIuFdTHHW36UXd0KwS3wnvZfim26ABGfHGBH8AuF5K/GHYwlIj1S/KUaV+fTCxXGwoE2NhLd+m9FwI+vTqkfpIHwS75hVp12loF1RE5HxWrZNVLkJyyaOLD1o9tBqjz+XasvzUtquy12KQx6W7Kkth5ecQ4h9MWnf/q78Xkux6MwO5K0OG8SiJph4eT+MLfBjKBFjy7Y5fkjKHNVzLZm9cc7Thnx6riE15cxIii5QzxTj3ums/ijcxvyNvgfJduyauqyucsarLca2toNRBmkq8/ZBb23Hwr2jKMAGuUw8BA37ny18WI8Vnd8euw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(66946007)(66476007)(66556008)(316002)(4326008)(6486002)(478600001)(31696002)(110136005)(54906003)(36756003)(966005)(86362001)(6666004)(186003)(53546011)(6506007)(6512007)(26005)(5660300002)(2616005)(44832011)(31686004)(7416002)(83380400001)(38100700002)(8676002)(8936002)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVlnTzdHTGtlNm1ETy93OWlVa3VHUitMV1gwWVlVc09OYkJJWE5nQXdHQ3dn?=
 =?utf-8?B?MHdZUmxmRTU5U093bC9ycFhYOTFBeU5UdlhPSFRIM1QyRy8rTTJ2dFN6eEVU?=
 =?utf-8?B?MzV5UnJTQjkzTjd2YXFzcnNFSWdVU0E3MDFJNUo4NW5SUmJBSGY2NldUcFNS?=
 =?utf-8?B?QW41azhQT3UxcjJDNmMwTFpIR3pBODNJZFNyd3EyajRwaXRBMEZSY1VnYjB5?=
 =?utf-8?B?bkwyQ2JabFpOS2tDMjd2aElhL2xuc2Uvbnlla21LanZNSGtseTBaSzBiV1Z5?=
 =?utf-8?B?ZEkyNUsxMVVhSlM2TitOQVhxYnRIS1laVkFsV2g5QWFPazlpZkJQSXh2aHhS?=
 =?utf-8?B?OUxBcmhDT3oraGZ3SmR2UVlPNXNqYjZmWEYxRDFLOURvTzRUbWhPcE03a3cy?=
 =?utf-8?B?RmlFd0swczFPcHpZSTRLNm41NWlxbWZUaG54ckswZFBCSnJEUENjL2l1QzZJ?=
 =?utf-8?B?WCt0a2FMaEplbXNSQUtMektMbzhoaTljU1RFMlJhTUJXR3F2YWcxbTBQNEZF?=
 =?utf-8?B?aUJBWmZCeTdtTGxxRVpPY2VscGF6Mnl1VmNHODlkQmNHSzRwQW5lbDVuUG5D?=
 =?utf-8?B?ODlyVllocXJhSUVaMCt0SG1KL216QjVGb1l0T1oyMVAvbVZMay92Rk1lb0hi?=
 =?utf-8?B?dlNLK3c4Mm1IZUIzNzFNUG1POGZQN2x2WTNoUzk5WnlHcHFPZzVQSFJMRVBo?=
 =?utf-8?B?L2FFOTdUUm9ZQUx1R09ocXEvYUR4RkxKb254SzRXK1E1M04rMkNnaUlhU2tq?=
 =?utf-8?B?elZVTUlZeEVZS0RyTUdDNmV2WXVxODFYQTNGcGN0c1djSWhwc1J5cW9oWFNj?=
 =?utf-8?B?WHlpMUFqd2YwZDluT0RETDdVazZMSEhhSmMxTFJoRFF6RGlpNmNtSGpiLzhG?=
 =?utf-8?B?U3M1VUxRNElPS0Exem5CVkRSNGRNUXg3SnhhMXdzQlNHY3JrdHBDNVE0dGNL?=
 =?utf-8?B?aEhqc21RUXBQaHFBbHdWYmovU0dxUXg5cVhNS1EyLzJrK0M0Y2hleGoyQWRo?=
 =?utf-8?B?LzkvdzhhdFdQZHVzeERWa2tSVmlvSDFZbCtod0M1VFhGV2VaNTlkOTQ0VDZJ?=
 =?utf-8?B?Z09Sbllhc0RhUmRUUTA1Z1FMZjJEZ1hyaEEzRmxITXdvTyt4ZXlHeHJRelZE?=
 =?utf-8?B?aVdDV0ZBTmtPT2pBNFRxL09GSVBNOFNRck1kbnJTeUhrQytiSE5NVlJCeWNJ?=
 =?utf-8?B?ampYR1lqZFh0TXJzQytZM1UwZzFkNlhESEZhVzBnQ2gvU1BnS1l5VGdpd0JP?=
 =?utf-8?B?elRnOCt6Y3NERi9xYVh5RVNJYkl6ODZDek5GM3MwRkJreWFXY1FWMEZpNXgx?=
 =?utf-8?B?R1RCN0hlNmtDMEY0eEQ5bUt4UkIxVDhqYS83eDFkYXNLV242SUFOU0dTeko4?=
 =?utf-8?B?TjlPWWxqcWZzeVpxL0VuczJsQy96d2VQaE8wbUpCbjBvdUpnVmw1WFIxNEs3?=
 =?utf-8?B?WFc4K0JWLzlVSUU0MHd1WjdrU1BLbkw1VmRqV01PTEpOTDk4V3B4aEZjYXdj?=
 =?utf-8?B?MzFjd2lFNjR0cHd0QXRXVW1kVVZWd3lZa05nTDFXTzR3Y1NneG4vZjNabWVI?=
 =?utf-8?B?eDZ4cy8wTkJSdEFXNGhwb05VNkxEQUJWbFZQU3cydVYrOUdXU2JkdUZxS25w?=
 =?utf-8?B?ZElNdkh0akJmYUEzek45TnE1UGV3Yk9ieWNqOFUwZHpmU3N3MVFGOHpibkFt?=
 =?utf-8?B?Qkw4bis4MHFDbVo3ZTdYUU1SQ0ZHekx0ZmR1aDk0WEJlVkc3ZlN0QW1oWlRU?=
 =?utf-8?B?Rld1WFQxb3ZrN2dGYlFPLzF4NDEvUWZhWEZtY3FJYUliNEdEa0lTTnFPbURj?=
 =?utf-8?B?ZExpdmQyNDQ1UmNtdmNVZFp2ZGdCbURIaHZWcnNrR29vNWRNb2wzT2t1dUo5?=
 =?utf-8?B?bmV2enVFR0tZd24zSnYzbGRiaFZ6NFFoSHdHYUludXlsK1puaGMrZkI3Yjkz?=
 =?utf-8?B?U0RqUUM2ZWcvQThISkhNOEpHUEZBMXpyczZNdFBtbXJYN3VrdUhUUEFXSmNK?=
 =?utf-8?B?QXAvSGNKYVl3czJSUmJUSHU0QWQ3WmNGUmZkcnBhUlJkNGcxdVpDbGRneTg5?=
 =?utf-8?B?WGcvQ3lRb2I1cDl0TkpMN2dFVDRxaXdydFI1SmdNVGdiQXgvUWw3UENRZ3RO?=
 =?utf-8?Q?7c0hgPPtwwjDEWvacVZCkG1R3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e88966d-0013-4538-63cd-08db4afc0b99
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 10:57:39.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FosNAA6Fc2xck4isxjU3Xy8pr9KYf0Xsgv/t/iztY4dgqhoFwoo9Bq/Mh23bMRb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4570
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 12:19, Krzysztof Kozlowski wrote:
> On 02/05/2023 12:14, Guntupalli, Manikanta wrote:
>> Hi Rob Herring,
>>
>>> -----Original Message-----
>>> From: Rob Herring <robh@kernel.org>
>>> Sent: Thursday, April 27, 2023 10:14 PM
>>> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
>>> Cc: gregkh@linuxfoundation.org; krzysztof.kozlowski+dt@linaro.org;
>>> michal.simek@xilinx.com; linux-serial@vger.kernel.org;
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> jirislaby@kernel.org; linux-arm-kernel@lists.infradead.org; Simek, Michal
>>> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Pandey,
>>> Radhey Shyam <radhey.shyam.pandey@amd.com>; Datta, Shubhrajyoti
>>> <shubhrajyoti.datta@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
>>> manion05gk@gmail.com
>>> Subject: Re: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
>>> node to support rs485
>>>
>>> On Wed, Apr 26, 2023 at 05:59:46PM +0530, Manikanta Guntupalli wrote:
>>>> Add optional gpio property to uartps node and add reference to rs485.yaml
>>>
>>> The diff tells me that already. Why?
>> Please check Figure 11-3 (Page number 37) in the below mentioned data sheet, It shows PMOD (ISOW14x2) devices used in half duplex configuration. Driver outputs Y and Z are shorted to A and B respectively. This reduces overall cabling requirements. Also DE/RE are shorted to each other, and at a time, any node acts as either a driver or a receiver.
>> Using above optional GPIO controlling driver or a receiver. This GPIO is optional because it is not required for uart console node.
>>
>> Here,
>> DE - Driver enable. If pin is floating, driver is disabled (internal pull-down resistor)
>> RE - Receiver enable. If pin is floating, receiver buffer is disabled (internal pull-up resistor)
>>
>> Datasheet:
>> https://www.ti.com/lit/ds/symlink/isow1432.pdf?ts=1682607122706&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FISOW1432%252Fpart-details%252FISOW1432DFMR%253FkeyMatch%253DISOW1432DFMR%2526tisearch%253Dsearch-everything%2526usecase%253DOPN
> 
> Your request for us to get into some datasheet somewhere, to get the
> answer to the basic question, is not reasonable. Commit must justify its
> existence, not some external source.

Not really. Manual itself just shows picture of that connection if you are 
interested.
On schematics it looks like that DE and /RE are just handle via one gpio. That's 
why you need 3 wires instead of 4. Definitely it should be described better.

My concern was more about choosing proper name for this functionality.

Thanks,
Michal



