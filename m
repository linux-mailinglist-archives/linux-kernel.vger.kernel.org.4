Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E584F6E7D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjDSOrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjDSOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:47:20 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24ABDA;
        Wed, 19 Apr 2023 07:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izU4P4Maoct6+cNo3r/oiq4aunjx2/s93LzJ63ZO+50s3rVvoDGGpeIx3jxsDCCh+q7mSXIuE1EnCis9YuT+SMPSiqHlnUc2Jw8VAoYoeitOoYh3yLN6l+Iw6z+3mCR7JHH9KPUNeYA9F0JyXovOry1chO1YomIqgw/uIdNx+ER+kddGxlOSFoVnKQMZKbdO2G2NVAnP/Er0JJef42Dj/9RDlPDj5Xnbyuy3TdwdrLJ83OKH+/FZTrobWgUn80HuTjVbw2NXjLPq2LMjGZ6q4sgoq+TLu0fROUPTuR9woNM19zBRjYwdj6YWgbse0sypA2cQq7XcrefTPBBuzLMdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTAbERlShXyCH1Dai2CxeQmuqnEL0pm7vKH1dFAbUIc=;
 b=NPO5X4CFbjmydbvWm0Scrz0xnUfZU4EGqhlh4hxXJakddRhAb9qPrOSJicZGr8TpO7agNbiVB79UYkZX9w0EZ777GIt7JuEde9lws9nf95aaVWBaTpxSKxLDCedG/eXJ7P4k5Tp/d8vfUe50lRarsbd8H7OGqtDfCb08Ih88r3FXMWhF17s759Wv2Avh0Ckwe/BpKVaLD33t7HkdLm8GYvf6scZ1hYmJshnLF4AnXBgaPsUab4N1T7n+XsUBEK44RW86pPvTYa+bnTp0QXJuGswvgstbdRNYL8sxQH+l8XYrONdM5RYM4IMDspbng0sGbALf/AO7ge1x24M0SVp+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTAbERlShXyCH1Dai2CxeQmuqnEL0pm7vKH1dFAbUIc=;
 b=FQofbrf3SIncKyFu/l4/2oDb67VyTsGIgJq11zwvMuhpiolb5QjZnXNvCARHah8SfKuAZStls+cOdSWVuO2hwHdASgaJvfvS34U6XSBw4ehsyFWnadn9K+z0Cqtws9A6NdktB6jcjIBI55VuyJfoIxkuyb2h3IacZYTFO8ZfJXWpsyZomR2BTOLiUMHi+JNOoTiReHOA/ykPiGItDFYYA6VD6wA/UtIPCY1b6gcx42qTmN6pODAGCgjazLQA2Kmbi9xfSQB0Zl7n82mew+exo4mhmflO11zFZa+vyuPxeQYmZrp4JpGU93pTT7mqY90odhN2OhYi/ha/iMdUZh4MOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB8020.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 14:47:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 14:47:16 +0000
Message-ID: <865298b1-9efb-1c4b-9438-fe0e5649c0d9@siemens.com>
Date:   Wed, 19 Apr 2023 16:47:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 2/5] arm64: dts: ti: k3-am65*: Drop bootargs
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros <rogerq@kernel.org>
References: <20230419141222.383567-1-nm@ti.com>
 <20230419141222.383567-3-nm@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230419141222.383567-3-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: bb42eca0-a3e8-4fd3-d511-08db40e4f854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcO9gfxh4mkTFqXyeRNeChoTm4OALX0HiX0h+VHRThqqxVRMXSV6824IdE3luIlFWWaG95frnX3Kn6HrhouQx1F1d9xTbnqsy5k/sqYYtR0ysdKhMuv1BI8A2i4ofmEvvmfUxg1nDnlpB51h33sK2tBvVvoZfJBzQrrCvOQ83gooDWQ6HMhoKHV2FewhzY3IZ9NibXTUvJA29pKzbvQIiFAHp+hYAkbo1oYgd+dGlU0pMbBgIP4Z1uIrXq51jWXJ9qCi9C70tBkH50rc/jYu/jTI8axazsSXVpYFa5QK3dcQH6xurjxSM97VA7zH6aRGSeAKbs3bp3hr2rh6QaxEH4IEQhtnK8Cf4bqeTowbg9kP315lvV/qdUfY0FC617FXB5pqQAyo7v9fVWv5qnhC6RcFFu2Bp3PKr5wi1KfXm1m8tgtO8w9jxUHTenLggmwCpZYc/mdM+myPvNfbocZy5ftIT/fu+kpqbcGveRwF/6phaJ2hnsc3b+4gH2E7iSblmzz6Y+oGbFmSJOhBzNdkc4F+AMXUMurkC668gbBS1kOtKeD6QC0DVg/bOlyrg8MDcv+2KLjQHuxXB9aOXtatml2PQkFSqnQ5zehFW4tp+gjSCwdJ0G16D2f7J3q7z8szekKsGH4cXmxyeg5yroDeyeoqIC0GeWMmk9RZzI82rh/1wzALEQo60XhpR+EomqWr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(6486002)(8676002)(6666004)(8936002)(38100700002)(44832011)(5660300002)(966005)(7416002)(110136005)(316002)(54906003)(41300700001)(478600001)(66946007)(66556008)(66476007)(36756003)(82960400001)(186003)(4326008)(53546011)(6512007)(26005)(6506007)(86362001)(31686004)(83380400001)(31696002)(2616005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHBLK0tKTVpuUDBUTUVqSi9TMElwZEhhMHNyanRFUDNsV0hkOGEzVUFRdzFi?=
 =?utf-8?B?REltQVFaY2VBUmJXRnFta3dDMktmVnE2ZElSRlJWb3QrNW8rbkxqelNOTDJC?=
 =?utf-8?B?cVlCZHFDMUgvVzB3RDhDcVRhbnY5aC9VVHdTUCtkUWVZaFZWbVRITXR4MXpn?=
 =?utf-8?B?eUFFNUlVVlZnb0kxUVBYZEhhZXpkb1B3NFJ2Nk9yTVRucGh3c0oxUFk2TlBV?=
 =?utf-8?B?Z2MwREVZVUxaZHIyMHZHMGh5dTM1b2lCSTNIK2JNYjBPck1RdFRkb1pBTmxR?=
 =?utf-8?B?RlVzVmhSNnV3cHBNd2gxR25yR3huZSthMTZXREE0am15cSs5WU9rOFpDUEty?=
 =?utf-8?B?V1hKcHYrSkQvYWlLcGE1WnhZN1hXUzlVcFk3eUZmdWVxYyt3T2dXOUwvc1d2?=
 =?utf-8?B?ZEtBazJyUEE1RVVxazkvNGRFVDZNRWx3VEE4REpvQzdjeCsydkFSazZnVnpk?=
 =?utf-8?B?akk5eUdmYTdKVGRVUTUvTDZCTHkxbnpNMnQ2L3doMitvelZEUkFVV3lkekZT?=
 =?utf-8?B?aW1rWHYyaTZPL0RGc2lVdnJRdm9ZdzZIaE15dlRMOHBKdFpGNUxvYXBINFU2?=
 =?utf-8?B?V3JRR2Ewb1loTTFEVnhsWkIrcVhNTWYvMVU1T2JyeS9HSWx5aFRqeFFUZGRn?=
 =?utf-8?B?b3ZwV0o0YUJYOUVOVXp5c2UvT3VXQWdqYXI2SHp2RERIVm14dXNVajlEb3Jj?=
 =?utf-8?B?OERRMDEwcVV2U0s3L2xTSnJTcUFFNUE2cGlyVFBHWWo1WlV3bWM4emhIazk2?=
 =?utf-8?B?RmlOUTZTcmxDanJUZ2lMbWJXNVQwMGFmaDY1RVBoY1hoaitSU0Z5NDRELyt4?=
 =?utf-8?B?OWRLU0VtWXVEZnYwMGRQTmlGNVdPSmN1UURWSk41alpPbWh0bzdlL3RoYWZV?=
 =?utf-8?B?aDBwbjc2MUhIbWtyZ2hTVUh6N1pkYVE4WmxSRHZlTWJSVW1uUVdNZlRDZyt1?=
 =?utf-8?B?TmhXVEx1aHUwRU1hQVVJUUF0c1QzUzNucGdEM1RsQlJCTitCSHlIWmhzWmpw?=
 =?utf-8?B?M2xWVUoxUHJDcVFxdUREU2xiVE9FYVExNmpIS1ZuQ3ZTOTRiWlpaWFpZM043?=
 =?utf-8?B?OUMyeU1Ia3ZLN1Z4M2lkLys5bnpYU3NsY2x4VmNiL1VEK3Q3ZE9KaGJTTDl6?=
 =?utf-8?B?K0toOXI4WEdseUlEYzhibmFoWXNLSFhYRENZQ0U5ckhuN1dyTE9VaFJtNHVM?=
 =?utf-8?B?REhLYlpud201RUF1MmZpbEo5Wk5xQ3VlNE9PNDVxVXFJdXBNY0ZSYWFKTHdu?=
 =?utf-8?B?a3BWY3Npa0xHRXY5S1k5WUw4NkNHWGcvb2dKaTFQS0MxYzJoLzZOOVM3UlF1?=
 =?utf-8?B?c20yajdkcmhzMU9KR3lVVkxXODIxNC9iRmJuNUthVHMxbFU3K3R4YUZIc3VJ?=
 =?utf-8?B?ZTBaQnRtWjJMMTljZ3ROaW9IV1VTQUd6THJnUWxXaUV1eW1CSFFmRWZva3Ar?=
 =?utf-8?B?eXFSYVRpN0E0ckdxZlZkRzBEb3hmZXkrZzhxcWR1dlRyaTdrM3JJR2NxYi93?=
 =?utf-8?B?bEdPNGE5MDlkU1NyOVVYdWlWM2huTFN3dXRXaW04TEZJUUZ0bGFkWGgwMUZQ?=
 =?utf-8?B?N3VUcStnOEVqTU4yUEUxam9GUklmUDZKQURIaFhmTWgzWVE5bm5uNGN1RXJS?=
 =?utf-8?B?MjFrUE1aUEt5a2lGVmVtVVFjT0F4THpHb1lXRG5zZUxjeE9PWGRVU3ltVDFF?=
 =?utf-8?B?MDI4N09zTng0L2hiZm03a3dhOTVhc0FXZStTT0pFNjhhK1lwQ2JBSE1uT3dJ?=
 =?utf-8?B?N1oralZPaGNMSUtra2FLSjZGTVo1c0FjUlZMMEY0SzZRMi9DZEQ1bWt1UU9V?=
 =?utf-8?B?TFZHUFQ3MXFHU3ZJZE9OYVhZeWN6bUFsQnlTNG9DL1dGdDkrM2hsSkJIWndL?=
 =?utf-8?B?aW5mQ09ZSGV1SUc2Z1NlbG1xa2NUelZ2Z00rV21jM3llaDBta3NEM1ZvcHJC?=
 =?utf-8?B?c01jZk9QUWdURGUxa1g5OUtUYkhmUzFlSkVVRTkrUktIT1hSclRzczRxNWY0?=
 =?utf-8?B?dzF0Y1RiSmM5M3plNXdUbHVvOEJ3bXZpaTVENXVKVnBucVBodUZ1cS9LbEpw?=
 =?utf-8?B?akZBVTNhbGRrNU83OTZPYTAyM1Z4ZGdkREg2SElIeDRyVnBvbWROYmFQcm41?=
 =?utf-8?Q?CA49mtpPgiZf6sPobNE3CbLQS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb42eca0-a3e8-4fd3-d511-08db40e4f854
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 14:47:16.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtMurTHS3/InfkSxWlBUzP+mCWXGjUp4mUE9PLFTxrStQKE+BeDAxD0dsu+cAw+Rbuh5m3bLb9om5ZYExQ1Deg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB8020
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.23 16:12, Nishanth Menon wrote:
> Drop bootargs from the dts. earlycon is a debug property that should be
> enabled only when debug is desired and not as default - see referenced
> link on discussion on this topic.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://lore.kernel.org/linux-arm-kernel/81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org/
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Similar discussions can be seen in https://lore.kernel.org/linux-devicetree/?q=Krzysztof+bootargs
> 
> Changes since v1:
> - improved commit message
> - picked up acks and reviews from Roger and Krzysztof
> 
> V1: https://lore.kernel.org/r/20230418165212.1456415-3-nm@ti.com
> 
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 1 -
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 96ac2b476b11..7d256a1638ff 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -21,7 +21,6 @@ aliases {
>  
>  	chosen {
>  		stdout-path = "serial3:115200n8";
> -		bootargs = "earlycon=ns16550a,mmio32,0x02810000";
>  	};
>  
>  	reserved-memory {
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 592ab2b54cb3..0d6fc89eba7a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -15,7 +15,6 @@ / {
>  
>  	chosen {
>  		stdout-path = "serial2:115200n8";
> -		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
>  	};
>  
>  	memory@80000000 {

For the IOT2050:

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

