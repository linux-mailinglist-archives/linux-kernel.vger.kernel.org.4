Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0A74D2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjGJKJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjGJKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:09:39 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B063ABA;
        Mon, 10 Jul 2023 03:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAnn0vfRQwcH+MU1cD6wbhkVuYf0rGRPTEtVUJaKy/hK0bedT3ZOTs2ANekM/SIypIT7oFOv/LFrHnMBXAMN1tzhn3CWKlOgxgqQqizaPXxwrAXQDIL55pXtfxX8IZ38lAfIX8coFmiuNFXEAsjy3xqSzwBM8RiEk/oRD34ThwSx5POhiAXLTbpT+DeMXveDj1uaZRNVeMBY+N9HLiSbl6xxlMkU9GwOqNmA1d86YVTsByD6vLZMRMX+NDWuNbOMZS4sjU9wDZ7l7D+HNhWsfr1rXtE9PXjc5rcOIvlT68WUsnpq0YTjUztTdiphM/Ds9CoyWC0JTjKgw0dpT9KWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inaLox/lXD7RlyKREQRi3XKXQBKCv7rB7vzQvzCD58g=;
 b=FY/kH1Qd/LQnDaI8/zEVt0qzawcMrtY2HKnNowm8j6pXl5qByIME8HI0sigDV5nrLQOs8pFwJVAwJmOckMB90wu+2Q4nEwWclInf/2EIKJLXrPxd52P7/1HtWHjW28GNMoDs7ViYUS2hrKF4yLLtBriWvcPkbwDcO8QZ6LDuXJg51ptVnmApws4ItzBYRBs8Z+LD651ih1bBW3BQwIhUZiDjM9d9WWZ1GeXyU6HGnGMrBgJp0R0pMudSEU4Z4S1Q/P8LsYSPttfAwkuxJfy4HkW3McDi0KKSNP8dVhabQNB4a4hgPUZ5hCM6EH6NOs6Ed9F01NKrZ9DlodmpFwW8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inaLox/lXD7RlyKREQRi3XKXQBKCv7rB7vzQvzCD58g=;
 b=jDs8YScvOdNL/bxIUeUpAE7JI/P3ytfb9xS29c31DI8mxHagaJkVKF/jwZj8bVtByDTjk+jvD5Nz+1eJY2eygVKHWSfTL4BacwPU/J54hhrgbdAETr4pBMAAVPKnqj+oq9AMRKbNAJiOuYih3NCelemdv2JLuLGtXJ0nisyg7GM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 10:05:55 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::bb94:8eb4:943:d955%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:05:55 +0000
Message-ID: <fb62288d-82b5-cde1-8fd2-a2cdd14d61f6@amd.com>
Date:   Mon, 10 Jul 2023 12:05:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: zynqmp: Setting default i2c clock frequency to
 400kHz
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <3034ec006c8b11e025904d4cc2524255523636f6.1686227766.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <3034ec006c8b11e025904d4cc2524255523636f6.1686227766.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: d897ed66-4e4e-49b4-f017-08db812d405b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8Q1jgD4kOpodv4LtZF04x/oeIdZyxGpQEXL79Iu/RVNd4bGCK78uKDQkklMH8n72JVCi49aUEuCzk8byFfI0LyB1SbNFdBl0oTSWzazaEALDn6HzR5vO0ODapMdghkafj4C7dkHvCBmNVNFFt5RvasPgEqefGgUxf3TMT91cJtlpdPK0z2s87PEQMoGHCcEIlij0dbRDRzjuFPLuQm8f4p/f9I0ZVetNB6im/0+OfUZf8vw9NIh/xkrTdCMFKn4XIR2ULwpZrp+uxyq5+IzjnT+vKHyLNb2mTuYBbaKactkoDEKvRtpOYPl/G8j3jaGLspIasaadU3u9UWNEPDZ0Icy/KsSK/vYTQfLy7nOqfikBN+6dVzeabo9/BIbZ3AP8zf9tE0OJ0R+tL0ygB6jo4LLb6EhUJ02Ep3KtH1RD03bDEbwz8BlPzgdFO799+cqElz3ShK2hoEuabWOy+Ud76xjZErgBOb86DO2PSrAxEgsee1S5SNB7L5eBnf54yqriiJnxd7ohalFrh7SGrXHhaECsWuhMz2lledwtOvHybl2PmfL363Ck9BdekXB7NED5T5njQeJOmU8vLDd2TihIfbLFFcR7ee8Slr/RDbGv24Vr6SRZV3V+Ed6ZVoy0skr7ttpzPstiD/cn7LKwfocpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(44832011)(7416002)(5660300002)(8676002)(8936002)(316002)(66946007)(66556008)(66476007)(31686004)(41300700001)(2906002)(4326008)(54906003)(6666004)(6486002)(6512007)(6506007)(53546011)(26005)(186003)(83380400001)(2616005)(38100700002)(478600001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXNIUWhUOFZkYzdJSUlzNlJLWTJSWkRRaUR6ZWwvcUlaOFVLZURoSWd4ZDd3?=
 =?utf-8?B?ZUExalVXcTNOUWZpa1FnKy9aa08rMXUwZ1Fla2V2YmRnc2VXU21DVnEzZ3pt?=
 =?utf-8?B?R0h1OXltUDVFbHFkSmNuSXcraDZQR0VSakwwcGJsWGhrTWF3RWY1cmROWXBa?=
 =?utf-8?B?Tm11WEFKUFRQNUNwNEFqUU82MWRXMU5lS2l1K1ZYOFQvUEhFNitLMVNiL0Zz?=
 =?utf-8?B?Y3dDRkk3NTdtZ3VUY1Z6WnhsdktIZThFcHNuNFNXNVh0WGRJM045Zjl4QVZl?=
 =?utf-8?B?djNBeTBSeGNVcENVOGpjZkpESWlBdGlBNUw5dUNOaUxIUVRsRDd3SFJyUHNN?=
 =?utf-8?B?SzFVaW5yTDBsWjFrN1oreVNFdjdVc1pYdmVpTkdYOEVWRStsMGNJQXpCOEtX?=
 =?utf-8?B?UUJQOXZLVUVFRDZUU2JybDFJRm9GajAyZ0RmUWJNVVRySGV3MnZDMUJlY3Ru?=
 =?utf-8?B?VElJcis4R1RUa3VGOVE2NjIvVXo1Q3dRZWxseEp6UGlRWUg2TlZ0YlcxV3U2?=
 =?utf-8?B?dUZybDgxOHVUNkRveEFSUHlWbDFpeXZNM09zT3BsYWRPWVdmOTU5dDlVaHpx?=
 =?utf-8?B?NlFNYmU5K01SSVJzeks1SDhTY3l4eGhMSFJpQ21LUkJQU0RkQWhEais3aW91?=
 =?utf-8?B?OGtLcE9aWVR3dGNhK0s4U25tNXU3RTVDdUtkd09OQzB3TkVUM21CUThGL2RL?=
 =?utf-8?B?REl5VkovZmp5M29CQlJoWUVKMWs0ekdQT2IrdWh2RVJsYnc0ZE5tUmJHRjNs?=
 =?utf-8?B?YWtBRzZicmU2SUlGVi80Ym5lbFdBNjl2TkdVYjFrdlEyemI1NHVUWmk3RjVS?=
 =?utf-8?B?NW54VEZvdkRxbmlZNDlNNUpuOVhSRXFaM092REhJdGdVMmNLNkpVTHFScnRY?=
 =?utf-8?B?czBMRVZ0K3hUKzdpZytla05pUE5ETTBiQmh1Y29sZnppUTQrdkdDUFRIdDlq?=
 =?utf-8?B?Z0tFS0ZVS3N3UmdtZ2R1eGNFUTdRZUl4YUFPeC9DS0tKWVZuT2RuTUVuYzZG?=
 =?utf-8?B?SExnRXBFZWpuMW9HeDE4L3doRW1qQVNxN0RETEJrN1JQNityTmpmckg0dTBG?=
 =?utf-8?B?L25yOWxzU241RUd5Ymp4alpoYzNvQmludFlHbE5UNjR5OGkzQm5TMGIzOHRH?=
 =?utf-8?B?M2lNdUk1U3B1Y3dQajREV3hUcjVZSlJETWlQS0RNRGMyRjc3MExXaCt2K1Zi?=
 =?utf-8?B?ZGcrUjlNYjhwaGhlRWFDMVdXRHg4dVQ0S0szR2hJK1BORG9yUFMzWCt2TGt0?=
 =?utf-8?B?NVJUMWMwMGFWLzQ0cVE2WjBQOTZGMS9xOFB0Qk5Vb01iVDdWamh0ZFp6am9s?=
 =?utf-8?B?bkZIcXF3VGN2S2VUaHp1Q3ViODhnTGNBWUcrZGJ4MkY0VnphQSsyaGg4eWRv?=
 =?utf-8?B?MTNyNXJIY2JmTU84VVM5cnJNWTlBMm9LemJGWGNOWHNVdGZTelVpZXYwUGVI?=
 =?utf-8?B?Um5EUEFNMzhDaHhldHdYT0dNNjFPTHgxWTg1YWFhdk5IMno5aXAxd3hncnVL?=
 =?utf-8?B?dkttRnQ1TWgvYTdQeUlRc3RxQ0t2eUdKVHNCSURIOVRPR1Jya1JsNUtmOFFq?=
 =?utf-8?B?ZGVXMzJ0OTNUSnFNUmVOUzRzdjBuSEJBd1BadjlMUHNTSElGdkV0VTlsMDJu?=
 =?utf-8?B?bTJpTmxjaC95TzA3S2ROM1djUWdmWjlXR2hub1Qzd2NuWUx2YlFQdmxOZzM4?=
 =?utf-8?B?ZGNaNms1YzhlQThBRFh5bmJCSjF0SWNLamgrS3FUeG80SlZHc1lSN2o5UW5Z?=
 =?utf-8?B?N3ErTEJHd0gvZWhNa0p3RlhVQndMb3JwY2M3MTJ5ZFUyUVJvSGtObVZXTXhs?=
 =?utf-8?B?N2lVR1lnaWlyQkdCMGp1K29QdUIrcGhiejVFMkdUTUc3bm4vR3BBZ3EvQkYx?=
 =?utf-8?B?WUlOYlludGV5emRPL05YeFA3eDVKMi9rcWl2R3FZNXFmRVRBNzM3dk5ZNjA2?=
 =?utf-8?B?QlpPSXMxMDA3aDkzZ2hmMDRwa0wrRDBtQ1lCdHhOQjVxMHVNNjZvdTJYZ1ZT?=
 =?utf-8?B?OVB2WDFyU0FUZ3JYZVNITkxjSFJ0UXJkaEhMY1hxVUl0cUhNbDRzSmdOWWNE?=
 =?utf-8?B?ckNQNWV3eUNKZE93bFJTYVRlU3NqY3JlbUxQdU5xclNsKytFZi9iMGVFWThx?=
 =?utf-8?Q?2XAayGwmHUHFN+/aaSr75xP+g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d897ed66-4e4e-49b4-f017-08db812d405b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:05:55.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGuY4ihL1bz/UkEk0lng3BxvnxpGxOgChb5z/MJAUT6PrMODJvPldDTdfX2QtRiB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/23 14:36, Michal Simek wrote:
> From: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
> 
> Setting default i2c clock frequency for ZynqMP to maximum rate of 400kHz.
> Current default value is 100kHz.
> 
> Signed-off-by: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 394db49ac6cb..675b88190845 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -648,6 +648,7 @@ i2c0: i2c@ff020000 {
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 17 4>;
> +			clock-frequency = <400000>;
>   			reg = <0x0 0xff020000 0x0 0x1000>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> @@ -659,6 +660,7 @@ i2c1: i2c@ff030000 {
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
>   			interrupts = <0 18 4>;
> +			clock-frequency = <400000>;
>   			reg = <0x0 0xff030000 0x0 0x1000>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;

Applied.
M
