Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0167054DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjEPRUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEPRUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:20:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A058E7DA9;
        Tue, 16 May 2023 10:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUEU6aXo7/YB7HmCbgh9yxVdxnh0fPO98La3lQa8BYJI9T+SAW/+QNu4cTE0KNUaXXW9cX0WXv8WKWCL4fWNUlNRIDc334KybcquNP5Iq3rCukU68s2n/vWFI6t7v+j/IYRxow01NLKnPfkbzf+kEiK2fNIixyfr0Ec7BARsdCDs3T3Md18MzdI0sJSiawF3CcAR4gl4eyzSMjoNvUHLIpjnd01fhq9dYdrSoYMAaqE8MJ36Jz1sRboJmzq9H4cEV2/YVSVbG21goM3D9lryWzkrvtYT6xPEqRI9N0L8loib0+j3+x5BAyLdmZzjRoDy28vHTTmChl/OMD6+k/TYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KimxtTKD2PIYYgohUPIK+q0n1+H54kN7HTsx5nwnHMY=;
 b=AhFGnZFiVoetWavJi7G9cgNmZjH3ITxXAAFlvWf81OeZnPwiVyDFfUIqbBAac2qySmijZVhtONGpitt51pJvEoF6ARYnPpWVFoMpGOKHDe+i5L9fsEKBbP4IkKRiif5r1LdmeC8n+lD/KOctUS4imhPt6BbJqtVUOFTgH5uIR9ehg1v7fbSOltysizuCREOa8v8AoFUbw+5hsXaanmfb3mPqXFYNBF6oF6zWWIMtJNxpGvQ7M0/VkmI7v7s4u0S+zYqP5AL67nB5XtzD2FV5ACgfvfnZWMSGTPAjPslQXOXsB6JfZkh2U+bktLm+jL+wtnPdM6S7TZ6WHF38HUQc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KimxtTKD2PIYYgohUPIK+q0n1+H54kN7HTsx5nwnHMY=;
 b=I+dnNHezrwh8vyXDT+DM5D+/b7NkUcbYJOlvFb04ZPv0z5RS2Zwu0dbQCuHpb1lkSlD2gtrEyL9lQS0r9wds9dPNcRxlB/3Dgcjwcbmhv+JWDvsFeLxJJ0XEGJvdYul3Ys80gzafMnXfrK7RljpjxlMaegw05riZAPPKLMAruOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 17:20:33 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 17:20:33 +0000
Message-ID: <c03d5e9a-7f04-5a26-8e6f-635c526bc859@amd.com>
Date:   Tue, 16 May 2023 19:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <4c3426077075683b866f144b633cf5218a688c7c.1684244480.git.michal.simek@amd.com>
 <bbb63fb9-69c3-9c86-c5aa-55b4beac0832@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] arm64: zynqmp: Switch to amd.com emails
In-Reply-To: <bbb63fb9-69c3-9c86-c5aa-55b4beac0832@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0021.eurprd08.prod.outlook.com
 (2603:10a6:803:104::34) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL1PR12MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8e5b73-204c-48af-9bec-08db5631db0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1jDZmzcQ5H5W2DOjeb1PESo7sjpQMTJufOoDCBeVoHuWDE4RDAj873ZlrqAdcQbRH269odup4issStVFhySVyaVmSNeRpPmj62o+LUEn25RpWEs6PcrxliueveIOKqvPikj54+4uq6DLspNmYwazyz/4whWUc+Izlhxic2ThD3yvD91N7PgXRoJ5ryLfM1bHnQ+oSy5mMSmDUUYw4xj8h+fIQ86FKI1OLjhehRZ2Zm6FNYc72gapqfQcDXtdoXVSuQ7hPiFSNzKdF061Cu6IUTxRer7k/vmRO808TbHdQKCQbgr76mGEzuICa2u9bjdr9HmMFwczZTF6aUIQF99rWamRJp+t0QsbyJOcRp9tNo6aidgwTf77xpBar8uuvIx5rw7hib3Lljp6U7kzQcz1OHQBUJPlXvOQwCDGz9Yz+PALJsRJdFsJU9qy9vblUnTj40eXvJyKmwjUQ7X0v1sy+quoQiRha5EpcJAnVLT/2DKTFskHAVD4Qq80J696W18C6tjEuebo7LAtF/lsLBHzw+ZxHJ8LtzDDurgJ6aXjN0CMvEskZDY4tyx0SqSRMzjImi9tM98O56pEwDY3SQUAVSE9YW5mXxfTJLxaR0nuC36pBBUNLwVEsol8TzERywTYbTSnhPEz+SvSiYb06zVyWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(53546011)(6512007)(6506007)(26005)(83380400001)(36756003)(2616005)(38100700002)(86362001)(31696002)(186003)(54906003)(7416002)(44832011)(478600001)(2906002)(316002)(41300700001)(4326008)(5660300002)(8936002)(8676002)(66556008)(31686004)(66946007)(66476007)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alpwRm94YW9yZFhCS3d5azdYSDBTZ0tzaXovallXLzI4UXpjWUtTYkVkOThj?=
 =?utf-8?B?U0NpL0VEUUZpUlFDbVR1ZGxQZEpuTUlCa3cyVVNZeG1qMUFteXlJUXllaDNL?=
 =?utf-8?B?dGZRUDFwb20rci9mREdGVW1zWThvaHFJcExyeFdhVWppRXpZYS8xK0tpb3lU?=
 =?utf-8?B?VGJJZUZLVTVSWmxwR0tZYnRyRkxiVjEyTUJuSnhtb3NiMlhtblhyS0hzUUZ5?=
 =?utf-8?B?eDBTeEUzYVU2dndla0hHNER2d3VkTWMvVU1RRFcwU0pLTFVFd0xIcW1UZXhu?=
 =?utf-8?B?REc1WXRuOGNESkFtYUU1SHZ1VjY5aTBzTTdhazZmZWZjUDhibVFtZStPcjZW?=
 =?utf-8?B?REpmVHFZaWFXZFVPVDRFSXZBd2VUK3RodnFRSW5QbDU5dlYraUtGQUpkRmNs?=
 =?utf-8?B?VXZHVUxrY2NoQkphTjcrQlJCRXA1cnRDU3FiUHQ4M1Y3dmx1TmFuVTF2UzZP?=
 =?utf-8?B?QmpIK29EUXdNYlpmUkExSG1JQ1BxK0xJbWRJWWwzamo1bUp2U1l1eGZpa09L?=
 =?utf-8?B?VWJRMGpqK3Jjb0xJdjBOdGErK01RZTBSSkdRTmJib0tuWVdYaGg4dWtoVjdK?=
 =?utf-8?B?NUZaR3Q0QmZXd0dXRFZ2MlpjVlRnOG5haVljbC9wNlo1dS9ZWklxVUoyVUtK?=
 =?utf-8?B?SHB0dHpRN3pRTGo3SWhNaVZjWmtMczhHWmFmNklmKzVFcnNIZ1RlNG9PQUpU?=
 =?utf-8?B?OFNmRFZnNlF0ZlZNS2JNUWVmSUdkR0VmVUl2UVg3MTFoWWNOWjJOY2JiKzlR?=
 =?utf-8?B?b1B4b0pybktjQlVLbmdlSjBFeFBlenppZW5CZnMwU09zM0tnS0s0SVJEcjFS?=
 =?utf-8?B?Q0xSK0M5RldFdkE0a0ZTYzRZbkFBVlUwbmJzT2NBTU5wSjM0OXovVTJqaCt2?=
 =?utf-8?B?b1lhS3ZubDk0eHdLWU91TzBDTTIrU3lEa3h1WHVCRVVFc2xOMWhrUS81SHZP?=
 =?utf-8?B?NVZTQnJmbWM4OTBoODIvSGI0OTkzTGt5Sy80NkZOdjhyRVNDL1dMZzZWNUdy?=
 =?utf-8?B?cnRiaEFIZE51enhIanhSV2dhbFhFSWFROHBhZkNGb0U0STBFQWNEWCtZRnA3?=
 =?utf-8?B?dU9KRHp3aFpWUXNwL0I2dkh6cXFlSVpaUW5oOEhIUkZUMDhvR3BOaEVjWnNW?=
 =?utf-8?B?L1Z6b2dhaEpyY09wYVFJNE4vbW9CNzNyQnR1OFJncWxMUjhFL09UZy81Ly9X?=
 =?utf-8?B?SnZiWVkrcjV2NEIraVIwb2g5L0Q5cWpkbkJBNHZYcm1XNWRjS1FxcWJlWXFU?=
 =?utf-8?B?ekFUY2N2MkRDQlYzWm1PVUFmOWpsVkEzSUtZa3VoUnVZYkpybzI1eSs0TXlT?=
 =?utf-8?B?UUJjdFkzQTlNVmkzVEgvZmJaRnV2T2NTVGh2OFVkZVFyUkdxSFUrMk1DcHFu?=
 =?utf-8?B?WExMM0dqRlVnWGo1eUtsSW9PL1FxK3Zmc1NKa2l4WEprTGZOVGxWTGZMaVdQ?=
 =?utf-8?B?OTVuRmlLTitsV05vTVJvVzQzWTZ0eWt1eUJCdS9ZZ0Z5TXFWcFJHd0tnNldK?=
 =?utf-8?B?dnlsS0FsaTFVbjc1R3FhS2tOeWM5VzVUTFd0SUE2SUpjOHZwUTVOU2ZtSzRm?=
 =?utf-8?B?Z3A2aHZqSlVqbGkwVXZ6ZkFWU05xa200TVFsRWdXV2U4RllRSmV2MG85T0Mv?=
 =?utf-8?B?NUZObkNGMkVsNm1LUExkelg4dDFHNE5xUjN2VlI4RTU1cnRMQU5DVjY4Z2ta?=
 =?utf-8?B?SEY0UUlVRDhHaDM2SUhxOXBFa2RyRGgrdlFJWmhkb0Fic0o2Y3RuWVl5Q3VM?=
 =?utf-8?B?Z29oeWRyQXVLWFh0OEFzczJGSlZOQmR5d1g3ckJwekZLck1QSXJoMXBlZ3RT?=
 =?utf-8?B?WC9xRklCcDdtNkwxL2QxZGVCbnp5MCtFNVBoUDl0ckxETEhodnN1Qm5GN243?=
 =?utf-8?B?MmN5UXRjVVFXQkdQY3lWa2NWRGYxNURIM2VjdjRjM010dEtsdjV6WXZsWVBL?=
 =?utf-8?B?bnoza0dHSVN2WXNkRFZ5L3krcFp3NzJGcStKNG8wdCtNbS8vUEJoVkI5dFlX?=
 =?utf-8?B?WmpoYU5GNU9jbktNNG1yU1o3YzI1RmhGWTd4SkpLc3d3WmRtSlZsOFZGVHBs?=
 =?utf-8?B?Z2tudUJBN2lIVTVYUkhiS2trdmIvZjZYZ1FwZkUwRjZvb1djYkJKcWRtSThP?=
 =?utf-8?Q?AcLJVaDVRMIRFgi/Z05Cr+DNK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8e5b73-204c-48af-9bec-08db5631db0e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 17:20:33.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5DNG4gz5/3c7F3GMSxBH7pAi4+wuuw9uC4j+agaW+J7t2BC/U/PjQQ0M/k6JfDk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/23 18:05, Krzysztof Kozlowski wrote:
> On 16/05/2023 15:41, Michal Simek wrote:
>> Update my and DPs email address to match current setup.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts      | 5 +++--
>>   arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi         | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 5 +++--
>>   arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts     | 5 +++--
>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 5 +++--
>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 7 ++++---
>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 5 +++--
>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 5 +++--
>>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 7 ++++---
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts    | 5 +++--
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts    | 5 +++--
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
>>   arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts     | 7 ++++---
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 | 5 +++--
>>   24 files changed, 51 insertions(+), 39 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
>> index 88aa06fa78a8..1495272e5668 100644
>> --- a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
>> +++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
>> @@ -2,9 +2,10 @@
>>   /*
>>    * dts file for Avnet Ultra96 rev1
>>    *
>> - * (C) Copyright 2018, Xilinx, Inc.
>> + * (C) Copyright 2018 - 2022, Xilinx, Inc.
>> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
> 
> I think these should be split. Your commit suggests only update to email
> but you add copyrights. While email change is trivial, 

ok

> the copyright
> change is not (at least not for everyone and for every legal system).
> 
> What's more, there were no changes to this file after 2018. What
> copyrighted work did you add in 2019, 2020, 2021, 2022 and 2023? For
> this file clear: NAK

All these files are regularly updated in soc vendor tree. I can do stats to 
double check every file but I am quite sure that every year we did touch these 
files at least with single line of change (and not just copyright update).
It means at least it is not big concern from me that we created file in 2018 and 
then touch them this year.
The question is if this is valid argument which could be accepted upstream.
TBH I don't mind too much because primary reason for this patch was updating my 
email address.

> 
> Same concerns for most of other files.

Sure

Thanks,
Michal
