Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B8722461
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjFELQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFELQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:16:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2259E130;
        Mon,  5 Jun 2023 04:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5njOdq7vFRgLPnouFD9Jq6KWqWS39vORSa+R5k64822f5qVj/K/TNUkDYOYzFhnrCAYG9pnmPuVSIx0kv1S5zbJwJC3WH+d0c14Wahw9AArQDo7NKU83bYo2qELp39eISMHp1Tg6uXQjL9XlF1/JUaVVS31v4Z9Fri/iIbteLK6fRZ61wt4XG6NPvjgcKCchIrS1ZmjMoMEMwHZJ1E6kdry7r6p2RTZ+G+CVqW+tXuhJSy4X0xhrVhY0rvw3xCpcIKLGp33+OfSYhhAednik4wAP8UAsIPe3uc6C4I2x/4Nmo+/XAGvdovSNNsdRN9wB9A4y3g8xxVZWdTWQsyYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6+qF66W6XyuBWRJD7Xs+r1yXZp/LnT0ska2O3d5lQk=;
 b=mKmQf9u2+tzY8iKEvudeIMHnqMq53hUNxt7R7knmVNiU6l1RBO1vo+Wq7IuTWzHXYIW+YuMRl8k69F2p4K15TkuUkw8CbBgMaEUGdSfRTzmmKbXQLhDz/0+h0pAx6mMWy6NzVsOdf9qXEgjDDY63xOrIIuOtkzXyayl5/BgvmEI4QfIMAAYRCyH6LepxvQDj/Vm8m3foACJ15F4Z/+eADdV1IUjN5JPs5M26dpENIrUaoh8jpZFIZ8HMTey2UO+TH50EfrCaG9awh03aRfGIopfOX7L9B6FIyZ2e3X7Rgz+mC7i4R96qC3/Lmclty9tlQHFi8DjJg3kI7RqNN/BEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6+qF66W6XyuBWRJD7Xs+r1yXZp/LnT0ska2O3d5lQk=;
 b=0acltQIeQydqwM+e9hXJDGqwWWEq6adR7HdV0T3ul0RUtu0uA41Hn5Zki9Es/ZVR/YXT5MH8T8uSYNDxQM6O7FiUFKNFErh64/ow6mz+NnzZ1XNXNI03eeq5KDbeJr0AAirwmbf+suD9xJtDtJxKN/d4onVHRiDVo1+HkBsEAQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 11:16:23 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 11:16:22 +0000
Message-ID: <5a91dd1a-30ac-10e0-36f9-68942db408c1@amd.com>
Date:   Mon, 5 Jun 2023 13:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/6] arm64: zynqmp: Set qspi tx-buswidth to 4
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1684767562.git.michal.simek@amd.com>
 <1f1b0028106d83aa06e0777e91862a07df100fa1.1684767562.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <1f1b0028106d83aa06e0777e91862a07df100fa1.1684767562.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 444f61d8-a1c4-4867-dbff-08db65b64b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNL3IIxnM4Oc7xxVaR48vYikz6XKcwYsLzRZ+2tUyGddnT5gnE5H3IW6lT9Y2+kzzibhVKdXpl/FI/uqoOsN6CLLQa++HF5QB3oOLUheQuPAUN9b4CPfk/LxFV7GmCvWzIYi2soovUGlJdSOpF6N7PuhgPsm25B/UmH6fblMFao7ubWyX3bHeox37wTqXupZpK2wOYGz+Pv4nPSpP2KL1a+QxPTpWMLzmXoU2Ydp5F+Obc8x8cL3dWENgZlkUDTnRymupdnF2nvI7kSQynfcJBYH8aHhsjr5UhoIPgn/gWkC3V1V7igSJ2NLj16HqIHZhxdWuEBUkyVvqKLbRvjBrMFNjkKrvMcwKvKM+4Q3fcYltZasP0yGsNYqOne1KkFX4syktfPEjMVKzm+EwJ5tQyvTbdy0dS8uTO00Qi5sRKgiFAaoOAXcE3J6Eip4ZWtaOAHDutUjFV4wpW8SN5l492YeawmvRXhF2i849Oh0ODBcKn/ALvGTSl0o3mAPQqFHgm3cX32bqc6f8E6VYLKI9lRVzLuwpY4cSq/HT7BwWQIvVS0z7WXQd5LOuzK3xPwRJaMhE1hMmTKykkTXo8hn46fZeKySbvPpHRSzknosUQqRzJoGqP0k4QMwUF34CRiLlXzjuGs6U6pBN3g/0WjoeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(54906003)(478600001)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6666004)(6486002)(53546011)(6512007)(26005)(6506007)(31696002)(86362001)(44832011)(5660300002)(7416002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFk3WTcyeVR5dktuaHNvSTk2c0NiWWlOcTk0YWtDamVWMldHMm0weU1kaFhv?=
 =?utf-8?B?R2hpaVZCN0gyckZSMHF2WVQ4bmFXQ2p3d3hka3B1THhDVWR5NXRQa3lveGtF?=
 =?utf-8?B?YmY2aWZyWDZPTkpOZjl6N0dkcWd2T1RrbW8ra2VuRXFBNmNNZUhPTmZIaTJU?=
 =?utf-8?B?Ym1Ucm51YThlb1RRTTk4ZjlreGtxaFRtUEdVZHliR1p1b2p4U3VkVGpBSnVF?=
 =?utf-8?B?eDI0Uy9xOE1EaFlkNWY5elJzUlpNdTYrQXc5dzlicUlFSjNkaVp6YjRkclc3?=
 =?utf-8?B?bmc0bjRZMXl4eENDR2hSMEJTMTRvUE1CS0pJazlkb0ExR3MyWml3TzA1b0Fw?=
 =?utf-8?B?RWNXajNUUnk5TmhBSU1nRTJ0bEtCdVRvaElyWlNsVWYvbkJ5TzkxKzlQdm5T?=
 =?utf-8?B?Y2ZIWElnbzRzUDRSRm1zZVpwZmpobDU1SG9QMEU5ZkJSTU5PQk9ndUFWbnpR?=
 =?utf-8?B?Y094MkFac2l0a3BqVGtJNmdoRkRGZklGUDZYTG5wbUtDVkZ4WHdMWjdianBX?=
 =?utf-8?B?Ymh1cEdLaURIY3NyNWZ1aC91Zm9MSVVGMnk4UnJWcCttTWllQlQ1a09GTHc0?=
 =?utf-8?B?UlR4dzcyelRRUVVUNkxXVE91aTdLQnJDbjdhUDlwVThvSWFnM3RRUTkvczlx?=
 =?utf-8?B?ZGNSaDd3bUlTcTFTWktNSkU1MHFXaEM5SzhLYks2ckRCc3k0VnZnQVhyMEw0?=
 =?utf-8?B?ZHRDMGV1d0EvNCtMSnRCb3ZGREswb2FuY0lLdWEzNGU0MlBxbXJnS0dJSUth?=
 =?utf-8?B?L0FvVE96V1ZMbE9kd0ZYZnVUQm80dGZZbEdhNndOVVpVajg1M2p4dC9pSTBY?=
 =?utf-8?B?a2cyckhGbFRPOHNkS3BNUWk0N0lPQXpkMnVTZXJKYTh3cVZaQ1FlWEtyaU9a?=
 =?utf-8?B?TFZoOFVSbmhHb1o5K3NDVG1qUGdZdWMxMStsSUhJUk5URWpkcWl6WmppUkJo?=
 =?utf-8?B?TWNLRVJzdXRQNE9xdktraVEwY3ZxcGIwOXVFb2JCV2MwZFFVQUxybkFrQ0JJ?=
 =?utf-8?B?R0VOUDhMV3Q2ZHVhSVFiLzFBZ0p5S0pXTmtLNmd3VHVldC92MkVsY29TYkdT?=
 =?utf-8?B?T25LZ2luVllYVTlNZnRxOStZVHZwY2NDckF2OEU5S2pOQzg2TDFORkNGWGZY?=
 =?utf-8?B?b0h6NTBpOU9jdXowY3pnL0JVT3IzNFhjUHpWMUNVOWxXNUJUTURLejdhQlJt?=
 =?utf-8?B?TmdmUEJIQXZsNFZqWWVmSUJReDYzYmxaSE5jNUQ2R0w5Y2VKcXNlYm1ndk04?=
 =?utf-8?B?Rmx4Y3NsQzVrVlhCSDBtWWFSZGFZVlZBL0V6Skh0ZVhab1FneHNoN0FiRmla?=
 =?utf-8?B?OHlMYjNGc1BmUXgzcTMyRHA3Q0lFWWZzWi9uMGpKQnFKd2tRZ1QvRzZDdlVF?=
 =?utf-8?B?a29Nd211OGhrQVRjK0lhUDNmS2pMYXJMVkRlRWF5bVdna0g0aEtzM0EyTEFL?=
 =?utf-8?B?cy9ISjhxY01HTVkwYm9Vd0l4cGlRYVR3UzZpVTVXdUVGNk1vOEUra0NnR3gy?=
 =?utf-8?B?WVJ4RVUycXp0SkxzcG1IWk0xdTZPc1MxZFVmVUc0OTlOSXRxQkhxcmdHK0U4?=
 =?utf-8?B?VkRNVXd3VG9vSHB3NTlTM293U0p0c3QwQnI4MS9kd202U0M2T1puOVlLNERq?=
 =?utf-8?B?blBTS3o0SzdScyt5MW5SU3pFdWVjODRSZ2FjTjlmZlRNTTd6QWswRzVLL2RV?=
 =?utf-8?B?WTlvTFd4RGF0UHpjd1dKR3l0U1N0dDBDUmdPeVJTeWZkOVFZaFByZ1loc2Ew?=
 =?utf-8?B?NWs5NlVBRFVSVDd3cFZrK3NDa21JK0dKMnp4MTVvL0xDK3BJaFJNTEhhcTdk?=
 =?utf-8?B?OFFwaDNaWUdQWUFWV1JVMG5DOFpaNFBtWlAxeHlOTWdIaytxMTV5N0dndU43?=
 =?utf-8?B?S0NJYkFLNVJhdUJMYVYvZmJjb3Nkd0MwdC85NmxBNkYwdzhTZWdDdldhMFZm?=
 =?utf-8?B?dkEyUDg0cGZsam9vTENBNHNvOXBPenJHMDFIZjMrTkZKREdqMmd5bGJDUHNI?=
 =?utf-8?B?SDNlNmFXWS83Y3N4ZjVUc3MyNVpVa2NPQzBsTHdLb2F5WXNkMHplOHdmMTBT?=
 =?utf-8?B?ejRleWtUYUkzbEFvQW0vQjlBSnlLb1JWQnRDOHFoQ1NSLzFINHhHT0tKV2Ji?=
 =?utf-8?Q?2ial2rcqqMbR5ioJw3ivSeufS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444f61d8-a1c4-4867-dbff-08db65b64b6d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 11:16:22.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOQ+kFdAlIdm+6JN05EDN0qnEgNs+YBcYBPMGCkVhjGWEccIjb2FPvreljlQDVjs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 16:59, Michal Simek wrote:
> From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> 
> All ZynqMP boards are setting up tx-buswidth to 1. Due to this the
> framework only issues 1-1-1 write commands to the GQSPI driver. But the
> GQSPI controller is capable of handling 1-4-4 write commands, so updated
> the tx-buswidth to 4.
> Using all 4 lines will increase the tx data transfer rate, as now the
> tx data will be transferred on four lines instead on single line.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Update commit message to skip spi-nor part - reported by Laurent
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts     | 2 +-
>   11 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index c1ab1ab690df..84e18fdce775 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -124,7 +124,7 @@ spi_flash: flash@0 { /* MT25QU512A */
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <40000000>; /* 40MHz */
>   		partition@0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> index 48d6a7202406..04079d1704f1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> @@ -44,7 +44,7 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> index e80484f9b137..3dec57cf18be 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> @@ -45,7 +45,7 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
>   		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index af3331c133ad..d9d1de5f313c 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -355,7 +355,7 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> index 05be71eab722..6636e76545a5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> @@ -173,7 +173,7 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>; /* also DUAL configuration possible */
>   		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index a074d8e2b86d..8767f147cbe3 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -957,7 +957,7 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
>   		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 91c9b77f6b1f..e185709c0d84 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -444,7 +444,7 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 954044d9899f..7fceebd1815c 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -456,7 +456,7 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index ab5e34b43642..27b2416cb6d8 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -964,7 +964,7 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
>   		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index f31365a14f73..6224365826d8 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -794,7 +794,7 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
>   		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
> index e615286b8eff..c406017b0348 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
> @@ -47,7 +47,7 @@ &qspi {
>   	flash@0 {
>   		compatible = "m25p80", "jedec,spi-nor";
>   		reg = <0x0>;
> -		spi-tx-bus-width = <1>;
> +		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <108000000>;
>   	};

Applied.
M
