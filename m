Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8CC6E4A80
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjDQOBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQOA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:00:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C993F2;
        Mon, 17 Apr 2023 07:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj4KrhtmMcFOFGK1p4088Q2xGl3AGn7y+rpG9rpj4DE/IM0pdQ9HjOSPzNeva8NTrLDqsANV6OMG/CRVXnGid+fVJ8RcHwY4yo/Q2SDQIu9V00BaGg/zrnCHydya89FmtP6J7not1XL8qemBVrRPu91Q/WfgeNv14OaEKvO9kw9+Vz6u2iR/PIg565/3geVnjs1qh6NYmFIzOyonpgbknEPezdTAScHH8a04WVvvWKLEczt4bNGL5sw1fu/DhgAotURD+3+iCDPaURiC2lM9qkyhR2pPGbW08vhTrMJsiCENj4TEe5rmmLy+IfUTBiXHpZJIwOqv2ggDj8pDo+mOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIEpKxtJXb+k18lCByQKgeIXUd647nthREVqrVi2VHM=;
 b=jRzxWZFS8mVKHPtK/y1jdiuaxw+vLea4qPovPeEioiGCyVqFE0daHWt3OMYAXJbnfxvL2GbAdZoPJ4wBnmG3Z6AZ/7lCrVwFRKmQTQW3RNdXBydqfZH2Qy0KBJ3F3nBUnDj4PwZHXq5crdd1qmOy6CEmO8fFtWbMyZk6zSV709VdYn/t5Un1YV9iBuggExfDucqvYwnJVLQmxk/b+JqBsR4FmJtbu+1xhGwAQL2+0y8ewLUxo6XzcRI+oZrEPLK1OmZLkC+eLkR3DU5MPL5U8xNjQcbxJOYZhoKsCJfHWbIj3qf9haXtqLBOCTrQDsxdfGyrj0lzO2yhVSEpIR06YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIEpKxtJXb+k18lCByQKgeIXUd647nthREVqrVi2VHM=;
 b=BljEEQVLhlvtwXDf17R++tX5FrO9/FHEF18UrR3H7XLprCEO2AdHSP8B/WidEycL2+Nsq7tqMysLyggai0shnO3Ql5j1dW2pOktdnwUOmx6RRla0Rv3blme9IOm4WkYZtmYyrK5JK6cjwq1mS22zf/4PoWghBbV0XTbPoQ873e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 14:00:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1%7]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 14:00:05 +0000
Message-ID: <6b712dd2-a884-e0ac-bfa4-3b6f8716ce90@amd.com>
Date:   Mon, 17 Apr 2023 09:00:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] hwmon: (k10temp): Check range scale when CUR_TEMP
 register is read-write
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baski.Kannan@amd.com,
        yannick.hemery@corp.ovh.com
References: <20230413213958.847634-1-babu.moger@amd.com>
 <1afe95f1-cea1-418f-b9a1-23be6817157f@roeck-us.net>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1afe95f1-cea1-418f-b9a1-23be6817157f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:610:51::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf80e7b-29d6-4059-4c61-08db3f4c0bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUO60fTnUyQ7AhN86Lh1PNQPJdCjXuDtkCE6VkiwaEJt5UheoaJowynhTaglt+1FN4yJhREGxCfgibzr/tM7ABw9dujHP6HSpZ/MWGfb+Yt/+DbHQvSm2S0133S1y9bObYUDUtNUiIuK31Ac8lRYIbpT0CU+c4FRMrAanRRr9T9yAUT8Hb0nnBhzIem95Sxni6zJqfENxEfgdYW9srH/sgpRshfMORSDDpL5Ud3KuBMrbFSGjAXFD4yImhn4uvvdOladnIDpf+K0r0mPlYNZF4QAhvRQJP5awWtyMcE384eDa2JzsaHhKtp13G/OixvbNsGwcLG0fvL8FVgIYQG9MIfK6H+PYZs6UOmwl9P/3kf2fKk0P06PqNqZGRbh0H4palE1EK0jGksk81QMYYY/KJpFY1QwufkpJXgJft4U//hD7WAiaYJNDfDMLpVfRis3q9pbk2YWiEoP2N740O1ZxcfHE4q5OZO88fLUi3FCYeRvQOziU5fN0noMJ0/6X0pBTtaBg9P4gaTpnvdFgS54XGdIROpm56iQ7a/zSHe/QVFIQ59ycarcEU8S/Frn69Mr79FGBVW5tIVj2tbEcaCXdW7Czde/ktyJEgv6lrYoTH5III5PSYqDGkFhBHxJUGC581PYi3XUm6hAcvZDE14Pxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(31696002)(38100700002)(2906002)(3450700001)(478600001)(6486002)(6666004)(2616005)(83380400001)(26005)(53546011)(6506007)(6512007)(31686004)(186003)(86362001)(36756003)(41300700001)(316002)(5660300002)(8676002)(8936002)(4326008)(6916009)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3A2d25hOHZPWGM4Ly94ZjJCT2cwSHlRM2dPNlRDNFdmRkE3MXMwWnh4TFNI?=
 =?utf-8?B?dDVKbG1IRlNvazQvNUpvQkFoWFdhdlpsa3hvek1TOEo3UVh4eEp5ZDhieGg3?=
 =?utf-8?B?bnY2RXBmNllodlc2WGNCQy9ZMTFBKzVNa2xlb3ZmTUdacXl5QUZ5U25TM0sx?=
 =?utf-8?B?cFB0djByam43dWdicVRrN2JnYjRqTzE3SVdNZExyZkp6TC9CRGhwcVArWUU2?=
 =?utf-8?B?VVFubWFjdGZ4QW5yOHVjSk85OVVNN2dWVUZlWm4zR1BTazJJUHZiTlZHeWNE?=
 =?utf-8?B?a0oyU0Q0blRhZUoxQ1FQVkdOVnRCZ3VHNFExTWI4d3QxS1dzeWRZUlBaYXdw?=
 =?utf-8?B?SjFBVzR6bFgzbDBqRE9Tdmw2YVlDOFJSVDlDWmhrdU91aTRZQXVudjlaQmFU?=
 =?utf-8?B?d3hwMUF5cHRYQlVHaVJaZkhzenl0blIybitiT2hMOE96SGZHYXo4cnREVmhu?=
 =?utf-8?B?bGxENFJJM2c4cFZDSWxKUG5UdWk1TDZsQnM1WitZUjhlSFVkMmRqQTRIc0lt?=
 =?utf-8?B?RXgvTVNZS28wbVhUU1pySHR2dkNlTTJLMXVqWk5tcHZGV2hqMklUNUhsSmQz?=
 =?utf-8?B?clNDUFRDRGg0MUV4dGpnZnhxRVUzTjJJU010OEdtNDk1NG1FcWorNHdVNGp1?=
 =?utf-8?B?ODl3WEp4NSs4RGE3bnJCNXk1TXBXSVg3a01JbEsycFFSRDZPcTJOVDdUMXE3?=
 =?utf-8?B?Mkl5KzFUS0JzUVVBcGxjL0V6Z2VVaHhOejYwNVpuMlJSVWZyNDRVM2VPWnBL?=
 =?utf-8?B?TndCLzh5dytGYzI1ZWhWSWIvS085emxzR3ZWMnkvTXdzc2tXNDcxUzdoQ3dE?=
 =?utf-8?B?UHlxN0puQ3BEUXN3MkltQkxva2YrYXppaTQ2U2ROdzF3WHl0TmVuY0NMMzBs?=
 =?utf-8?B?S0tmTGxyNkEzdHF4WnJjTlFUM09Pc1M2TDdSeWtzMDhnb2RKbSs5dEFXTVBj?=
 =?utf-8?B?enUzTjR5OFY0LzhMWkJHOFFRemlIWG92WmR4OGJ4QS8rMlF0ODJ6dG83SG5Z?=
 =?utf-8?B?b1VqbWdtSkRtc2FSc1FCaVZiektnQVNkN3NzY2xUR2oxbEdWazd1cFBvMjNy?=
 =?utf-8?B?YVBERURGTDVyMUNuaTFlU3VBVHRveTRHckpTb0luTTZRNXh1T290UHhkdFV1?=
 =?utf-8?B?bDQ5UlVCRStCR0FzekhMSmZENkcvUGVIN0IrM3JiR2ljKzlpZFk0bVZpYlZy?=
 =?utf-8?B?cmE3Sm1oZjhCeHVZd05wNWhWczRFdWM2ZnlPeEJwbmkxSzdtbEw2dEs1UCtp?=
 =?utf-8?B?aWgzcU5VZHBkbXcwRXRiT01RbVlUVldGaWFJSjdTQ0VkRk4wK05ZMmZHZW1C?=
 =?utf-8?B?RjZoTGI5Mm8yYjBSWHpKTDZBSER4dVEyL3JPSnZwaXBPaUw3ZUVFMW04ZGVI?=
 =?utf-8?B?ZXRHTHJweWN4MDdXOTFWcHpBTVlMZlhqQkhwbE1IYmpTRjV3d2xEbmhMOVBN?=
 =?utf-8?B?cGl6RXN5MGRwdHNPVWgrb3EzVFZidG94Wi9oSGExK1Z6bzJ4L1M4YjZJUUN6?=
 =?utf-8?B?RWNHUUFXTFF2R0R5Zk5tQ3lxbkxGWVZnMk41NGg3TWRmODNWN1VGbVU4bW55?=
 =?utf-8?B?czJPYysvMVJGd3pHTUUrZlFxbGlQQWtycncrNkpDYzFkQ2VMRkh2RnVveU13?=
 =?utf-8?B?WXJ0UmVyNmVxaVRFSkNDZ0JKVVlQYXE1OFhaZUQxcjRYWk5MYTJKRG43LzJ5?=
 =?utf-8?B?NW9aVGc4b0Q0dzBMUDl1VmJ4N2tReVJRNWZwRWxCYXNSY2NFNFFweTI1NXQw?=
 =?utf-8?B?WjZUYUZqTDFWclJLTFRGQ003Ym15WjNZQTlpWWtVNHdnS25qanBLM2crRlJK?=
 =?utf-8?B?Qkc1djNCa0ZZbWJkY05TUzJHaFlqR0ZjVjZRRzVlSU5SZHpoQXJkTU55Unlp?=
 =?utf-8?B?L2dEK1FjN1VoMng2VHdUTUJ5Mk9uQ0dlcThERkxHUis4L0ZEaEZTQVh6S0JK?=
 =?utf-8?B?RUt1aytKUTJkeFEyNDArek1PN3hSdFVqZmp2RkJJUUMvOWxRZzZkL01jVU5r?=
 =?utf-8?B?MEJVRC9YMUZsdEgwclZlSTd5SnlJU0NwY0hpQ2ovNzcrZWM0WENDM0xpNmg3?=
 =?utf-8?B?bWF4M2M1Yy95SXVkaWpVYUpGU052dWczSGVFRmpCMGdIUFZpNklUbU83QnV5?=
 =?utf-8?Q?mqBU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf80e7b-29d6-4059-4c61-08db3f4c0bb6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 14:00:05.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1f0NXz9f4IyqOtO4sndrNlIgLgK8JcgpcGK9ET7ZLCtnwXzN7+XHJhhCMToGACr/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/23 09:35, Guenter Roeck wrote:
> On Thu, Apr 13, 2023 at 04:39:58PM -0500, Babu Moger wrote:
>> From: Babu Moger <Babu.Moger@amd.com>
>>
>> Spec says, when CUR_TEMP_TJ_SEL == 3 and CUR_TEMP_RANGE_SEL == 0,
>> it should use RangeUnadjusted is 0, which is (CurTmp*0.125 -49) C. The
>> CUR_TEMP register is read-write when CUR_TEMP_TJ_SEL == 3 (bit 17-16).
>>
>> Add the check to detect it.
>>
>> Sensors command's output before the patch.
>> $sensors
>>  k10temp-pci-00c3
>>  Adapter: PCI adapter
>>  Tctl:         +76.6°C <- Wrong value
>>  Tccd1:        +26.5°C
>>  Tccd2:        +27.5°C
>>  Tccd3:        +27.2°C
>>  Tccd4:        +27.5°C
>>  Tccd5:        +26.0°C
>>  Tccd6:        +26.2°C
>>  Tccd7:        +25.0°C
>>  Tccd8:        +26.5°C
>>
>> Sensors command's output after the patch.
>> $sensors
>>  k10temp-pci-00c3
>>  Adapter: PCI adapter
>>  Tctl:         +28.8°C <- corrected value
>>  Tccd1:        +27.5°C
>>  Tccd2:        +28.5°C
>>  Tccd3:        +28.5°C
>>  Tccd4:        +28.5°C
>>  Tccd5:        +27.0°C
>>  Tccd6:        +27.5°C
>>  Tccd7:        +27.0°C
>>  Tccd8:        +27.5°C
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> Applied. Please update your e-mail address configuration to avoid the
> following checkpatch message.
Thank you.

> 
> CHECK: From:/Signed-off-by: email comments mismatch: 'From: Babu Moger <Babu.Moger@amd.com>' != 'Signed-off-by: Babu Moger <babu.moger@amd.com>'

Sure. Will update.

> 
> Thanks,
> Guenter

-- 
Thanks
Babu Moger
