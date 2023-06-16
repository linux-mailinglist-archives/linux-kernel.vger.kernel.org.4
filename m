Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A612732F25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbjFPKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345524AbjFPKxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:53:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E656A3ABA;
        Fri, 16 Jun 2023 03:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqD+k5VmBXmfRwqZnK8DdIIp2Y823qQnj1OMNAjtJHtuMNmxdLUV6lJm+RyCGiSRL+e6IIiwt7Kl0H6I1gwmjCs/K7ip9lVbWuvT0YTbtFRwhN4/hPr2DLfvNJy8dbY5n79P7wAE1z9nIkulVOTDx5NPlDWq41/39wTm8zKvRcrqQuZ0VWve+R4aMO/9DgR32JJ8L+k54IU+8obhiZA3IMy2+wEyuBWr/6vDjrIWwN0RYdBM2ZFaiy6BFJ1DpQf9zgnGQVOzQSsm47TdQznEidGzn7+/7QUkyhEi0ooAjIl4JIrfRaweqMw0CMCSGrB6pyg7CabP5ndIBavTLxuuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nYZ3WtUhXVgvSDaDByFDceNFBMEu1A8OZIYSQdgTS4=;
 b=M1MgtR15Hxyujnq6yFob5a2VhboAKENNzR1Al+nxE+a6zgPp8GfdM1SjRBZlyb9KHfQZW3pETKmlBOI2fhA9Cw/5CDWHHd8iiUHlECNMi+UND66MUEN8YVmaQkhznXBNM+2tHeekijP97hSVKEOoQ4IPfDz5rvaKdX/8sUjTIH+NDXKSrdo6muLfbpkz/yRdsKgX/pxt15yBBpTxbGco7oDNq+6+TVzLHH3fhSIGN8zH9sufZTov9T74D8Cu3e3xzmODZg3SdMu5saDz+pumc5G+GP1zQMXeudvqU7E25c11hKox67DDuETnvyutpuYSRPFJzRErnUGsa667udKdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nYZ3WtUhXVgvSDaDByFDceNFBMEu1A8OZIYSQdgTS4=;
 b=FrV4ZHaEYcPN/2QgJ25ZHxsNxgFqWqsZcirt3B9QGpBr/brsmMUTNLA6ssYLmXgn9SZpshKSqHO4ohN79R8P19nCX8S6uaGVb3adCYj6wJUtercNi3DoBiYD6pSECXKmWs1rFUCwdjEsrM6QEUiwHd2gT+jhnhIdpv/l9lgdL98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 10:44:40 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 10:44:40 +0000
Message-ID: <ef7e8e53-4e7b-8384-6518-68657474db24@amd.com>
Date:   Fri, 16 Jun 2023 12:44:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/3=5d_dt-bindings=3a_can=3a_xilinx=5fcan?=
 =?UTF-8?B?OiBBZGQgRUNDIHByb3BlcnR5IOKAmHhsbngsaGFzLWVjY+KAmQ==?=
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "gcnu.goud@gmail.com" <gcnu.goud@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
 <20230613-outskirts-dove-e3e39b096647-mkl@pengutronix.de>
 <PH8PR12MB667577C4800ED8E82C36D57DE15AA@PH8PR12MB6675.namprd12.prod.outlook.com>
 <d12e3d8b-20e8-48bb-84d0-3fe7d3502c83@kernel.org>
 <PH8PR12MB6675D75114C7EE280235BE8CE158A@PH8PR12MB6675.namprd12.prod.outlook.com>
 <8555c686-c663-767e-ce1c-a3b76fdafe05@kernel.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <8555c686-c663-767e-ce1c-a3b76fdafe05@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef77e57-3d47-4168-153d-08db6e56b031
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2asYn43Ml9X5N79ydYPtMoG4qa99My7bCWezf7cDam8VlXKSNukL6fA/spTk1GRHkPJ/8KDVRm3h1N84VA4P5Z80MrgO6HHEh1MRIcwDYypU2O2ZMWorw2ZjOo6/Y77s3stfZ1YEBKvpA9jbA2uyJ4BZ023TQlbVDL+TXXoA6nf6Okr5n1LHzk+9z5UIcEKGnODiwMH+8nLOi2ET8pDRlJQfN6/peVTXi4haHypaoIQcvpfjdmyVV6ukUK5IjdOtXvNoyYpX++GBUnIOsKoMDtXWNITZWVuxsqhQcawRL6IOINgnEHysd07B1CEPUEs9dxoSZY/6ZJHcZH+3cdNqtbFa0QRf2+bTEf6Fyes1CBPTopyCQbRIbkMbU8EXNEeMk/xjjA5xh5xhVIZymDgpSeJbJDcsGJ4zMC/pxr9Lp8tNHkPB4So3RP+KrG5TDb0ZxfGUUbrcxMHKuBa/TvpPDlZLGjmZR5B2DMUmF694QL1ud3R+E6wpyqtS/VbwtoPhvxOKRgGTTzEW+TIOgSxsowC8exTqxMT7Sc3S9EDd+/uP9tKXTIzyPPeJXnwI2s8NHKtnz6jz62QUVjZfgXwEi1q4iah34Vav6tLx8DIxwOcs5lVQd5+ViTLPE01Uoh42RjTpfdobAWGdHhTATwFoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(110136005)(31686004)(54906003)(41300700001)(86362001)(31696002)(66556008)(66946007)(316002)(6486002)(8936002)(6666004)(66476007)(4326008)(36756003)(478600001)(7416002)(6512007)(44832011)(5660300002)(26005)(83380400001)(6506007)(53546011)(2906002)(186003)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnludUtySjk3TlVjNWdZc215TCtOTU1vaHlwVXMrL0p1S1ViMHQxYmZiUUVD?=
 =?utf-8?B?N1k1bWJVdFBSTEQ5c0hXODdoNVI0Qm1uTk9aQ0lhUjFQWHY5NFBUKzBvcmcy?=
 =?utf-8?B?bG1PNG1CRzF2S3Y2RjRML1poRjNCUVY2UGZBMmJvYUJRMmR0NitKRE9EZHZl?=
 =?utf-8?B?cUlWQXFHQ2p3cjVQRXZ0aEVjMmExcU1IU1Rrbm1KSm9kSDhCMG9xQ1FuTE9k?=
 =?utf-8?B?akkxUkhZNVQ1UnFFWUNNZVNOVU8zdy9oRHpJeG9XQ0hJc3RmTmZlcTlBZmdX?=
 =?utf-8?B?SGJTbEdRdlZoanlQODlObmpzb1JwaERkOURreFRDYmlQT0NWd0VMTU5BTDhP?=
 =?utf-8?B?b3NhR2hEY081M1IySURlMS9nUFk1MzFQSUhqUjMwTVVPQkpxLzRjVVVESXNm?=
 =?utf-8?B?ZVRwTDBWU0ZObmhkWnk4Yittbm5aTm5uYkpybjQ0ak54cEo1bFdaOHNHYlI2?=
 =?utf-8?B?eVBUeTlDWHlDU1NzdmtRUE1KQXFKejkxcW94ckN6NlZkK1ErbVRPZkNYaFpG?=
 =?utf-8?B?bHhxRE8raHExL29CckFiMlZIa3I0V2wyM2RMZStYbGp5cGpOTWhEbEhiWERr?=
 =?utf-8?B?TzVoQ2ZpTEZFbGNjTkE4b2p6eGJtNFByRTJWTWhQL2p2WGoxT3NoOUhIZHZ1?=
 =?utf-8?B?ZWZtRnhyS2pLYkNWSFBISUJPUEpZdGJhRitmTEtOTnowT1RMSDl3R0Z0RFJ5?=
 =?utf-8?B?dnZhOUJ5dWR3alpUOFJQVmlDMEFSRFN6dkQvcnh0U0ZlUmdKZld5R0ErR0RJ?=
 =?utf-8?B?aTY0bUI3L013czJxQ1kyUUJ3V0ZvdHd6MnM3M3JQcXZSV04rclM1YmFMaGtW?=
 =?utf-8?B?RTdsNnp3NS9HenhYeW1EbmpJUUQxZFM0M2F3Ry93Z3NmajdZYmhGSDF1SXdv?=
 =?utf-8?B?UlFpaWR2R2QybFhWR011Tk40aDNNbjN2NmZ4dUxwKzFnVVVNSHVPS2VWeXpG?=
 =?utf-8?B?WXZwQnF3bzA5OHd2RXV2QlJ1SjNyZllSL1RJZUsvT25HK0pOK0psV2RjSFNB?=
 =?utf-8?B?bGJlNmpuYzJPc1Flc1ZRdWFtNmtnRW5UNzJSNzh4SGU2bGMrT3I1Nm1tTVJi?=
 =?utf-8?B?aGwwSFNEbTVCUWpOaUd2MndPeE44S21QMGZsWThsMVpjcWdLUzdxZDBhd2gw?=
 =?utf-8?B?U3kyNkRUZnJRdDRuM3VKK2lEaG9IUEowNEhsbTAzYmxDYk9RUUxUeHZEdlJ5?=
 =?utf-8?B?RGgrb3ZPeWlpQ01IOXhjV3RtaXVSQ2ltRE9YMUdJVXAwQlJ1dEhGczBTRlkz?=
 =?utf-8?B?bUppWWR1Mk9ncnVzOUNIV3V5V2J5VmdBTEZuMlN6TUpTWlZ6aE1zTGRJWUY4?=
 =?utf-8?B?SW1pYVRGNjN3NXRHZmlYRjNiMU83Q0tSekFFMGZYODFoek5GeUpFdTlnNlZw?=
 =?utf-8?B?YUJ6a0xPbVlxQ1I0OVd2aHhLVGFrZEZEWGRzWExQVm1LZVI5TTRMbU5tY0JE?=
 =?utf-8?B?Wlk1a3FoNHBMaG9zTElyaElCdTE0Unk4RjNRNzlNOEpSVUdza1BLam9rYURr?=
 =?utf-8?B?VHJycnl1anpyR3dvV2pIS09tZ3c4L2lUbXBaeG50VWY2cmloeDNvb0NvbnBz?=
 =?utf-8?B?UHRsZlprc1QvNWtOMXU4ZEZNRTU4YzExSTk1Mk41U3M4eXF0UzluYUpLRlZs?=
 =?utf-8?B?ZjhCbG52Nk9sM09xa0V0a1cwaDlwWTd6Z0lwZEgxODF2bGtNZzFqZjI5bTM5?=
 =?utf-8?B?eVZPd21Rdk5Bb2xMRTdwSmxkR3AxUnhhMkNpMEE1cXo5ZTN3dFI3R1dHSm9Q?=
 =?utf-8?B?NndhWGVlU1hpNW9sUzRTcmVNRGZvVGVUOEZPbWpvRnk0MGtKcHcwZnhiVHVX?=
 =?utf-8?B?Y3pQRHhLWTBzWDQ2SVNxd0g5dTFNOElPMGpjS09CQUVHazh0V1JlVDc0YVdS?=
 =?utf-8?B?Z0s4emdmZ1VtYnRBZXVhbzZqbHpuYVlpTTlEbDJDQjhWOGx2cmlxS256a2Jp?=
 =?utf-8?B?TGZocGtJUGpHNkJYbDZpTEFuNENDR0JROVVHSmJ1VHlMclpVNEpjTUdzZi9T?=
 =?utf-8?B?YmFGTmxGQ0tCcDhNa0JuZWNJMzZtTGdEQ2R1VXVrd2RmNDduMmc0Vys1NWhv?=
 =?utf-8?B?dXQ5VVNMaFdYaGFrMjZzS1FSQXJBTWF2SnNBT2NNdW5WZU9zOUhxS0tBRGNQ?=
 =?utf-8?Q?lD3m+J9Z6kG/T9RDXajAVIkO5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef77e57-3d47-4168-153d-08db6e56b031
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 10:44:40.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtHBNUbzzdtwXiJX8Nkh/gdDneLuFP6hsTOD3UJpPPqhikPMbDACTXjwaWRrbk3l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/23 12:38, Krzysztof Kozlowski wrote:
> On 16/06/2023 12:13, Goud, Srinivas wrote:
>>>>>> xlnx,has-ecc is optional property and added to Xilinx CAN Controller
>>>>>> node if ECC block enabled in the HW.
>>>>>>
>>>>>> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
>>>>>
>>>>> Is there a way to introspect the IP core to check if this feature is compiled in?
>>>> There is no way(IP registers) to indicate whether ECC feature is enabled or
>>> not.
>>>
>>> Isn't this then deductible from compatible? Your binding claims it is only for
>>> AXI CAN, so xlnx,axi-can-1.00.a, even though you did not restrict it in the
>>> binding.
>> Agree it is only for AXI CAN(xlnx,axi-can-1.00.a) but ECC feature is
>> configurable option to the user.
>> ECC is added as optional configuration(enable/disable) feature
>> to the existing AXI CAN.
> 
> Why boards would like not to have ECC? I understand that someone told
> you "make it configurable in DTS", but that's not really a reason for
> us. Why this is suitable for DTS?

Let me jump to this. This is core for programmable logic where HW designers of 
this IP added couple of feature which can be enabled or disable based on 
customer need. It means it is not SW option if ECC is enable but it is HW choice 
if ECC is present in the HW or not.
Selection if ECC should be used is up to every customer to decide.
We are not able to get information why customers choosing ECC enabled/disabled 
but I can imagine that with ECC disable less fpga resources are used.

Thanks,
Michal



