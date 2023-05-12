Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE567006C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbjELL1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240995AbjELL07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:26:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876D926B9;
        Fri, 12 May 2023 04:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zem4C6BghJ+VloQ4Q5eTUo0YMBSYZcolRL8YJGZ92uQlhkhNOuGXZqVFJVG1b7wPxkfBzX61Qicj4pBLt4MCkhGvuGIPsIXYRsMuMKRVoDd9O2vKenK7bU5OpAUSS5CIxzyy1+pFBqevPZ4op5aJ6Wfpe/ZtMVNTaRH36cpOpfkXsamAH3abl6stTHplUBGuEz0fVjYsXvbbbAqFEiOSZz6i3FrhmlJ9xYhL7SNj7wvOx7vVZCrcmoDO5lM6KUcvJNcFHYZzYI/wnyBdAsyq6B6bsuL4W5fQjCd+wjfbSqHXE6IQKFRo9RwqWiN/uvHgIPs86eYjORmn2lL2nHPJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVlTEft/3yVMkV1EvwGS4zqEljrPjKDveMths1O3rC0=;
 b=aAaovDZZsI8usXdo/mcW0q8mmTz3oNiWjWG84fJyzp+9hFqMx9u8Tq7h93BwTeqUaQZEd4W738phAarn2gcORkFUKhT01LTEjnT9gUE1qizTmffbqe0bkWm9f6RNLnm/Gff66Kzs4P6GGL5qwHXnhHkC1ZVGqJW9dGp5l24RK/otKrcJGDJYztfR1iFcw98T7KG803lVrB/OyiihWD/2Q5uE9wqnA4bMlfE4+gn7PJfOksqaPaaJX+NZt9q08+fHcURkMcsRKqay9baSJ1wGVSmfslq2eHF1MciZlAT6ZHgcbXNBeTt/AxTwVfUs1fXGfLBwpW3uj6cWT6+0iJcD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVlTEft/3yVMkV1EvwGS4zqEljrPjKDveMths1O3rC0=;
 b=TeTcIV2IX+yoTNE1clocB30DDHFdhALXZKVQkz8G9HYC2r6DdNvof6dw+bO1Yn0Hh7ehaQYR8LrSP9NCEPPQskxVNUSsotyVm62z2Xzb6RpMTscYow5XNXFbwsya0zkfUz/LwwZNN7gl2r9tllPyZwPcEXEbAkDJKack1E88ZSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA0PR12MB7001.namprd12.prod.outlook.com (2603:10b6:806:2c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 11:26:50 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 11:26:50 +0000
Message-ID: <ad698819-19a7-65eb-d605-d7f307caad2a@amd.com>
Date:   Fri, 12 May 2023 13:26:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] ARM: zynq: dts: Setting default i2c clock frequency to
 400kHz
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4dde5d1eb8e4572dae4295a19a4c83002a58e5da.1683035611.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <4dde5d1eb8e4572dae4295a19a4c83002a58e5da.1683035611.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::8) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA0PR12MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 146aa8b6-e76a-473b-1e17-08db52dbc754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTc1epZGUpsQPyJbSTJAUIYWAAERYFyrb0IKS+u0HMBhqVzUYDlTtuxB9GBYEpi2Hqcp24vSC3zKBuUf8BqLhk9BCl5YXYBtb00QeCaSVmnsOz5jQd3lpt5GalPjfa8kwxWVEVbV59YoKoJHAjT1swVqqXU/oe1d6oTrJHzUOk0XQbVv0bLNkN2ko0McB+N1pFwT5D13Qm04tQDbLo4XY22fi+Mp76aAuL2D1Dz6KDNOYp0bTkgK5LCNGfag0HgwOECCom5qfUHOBFRHPdTWpfjRVX5hMKbkZFgA4hulaUR6xn+OHdR4UvarPCUsXi9kStzZkXja32rt8oK0VzfsgZR4V3zJ+aZy18vzQo77iN6kLVNaWF9NLrNzio6byiGeTfxjzC/gzr6iUhjgPhxp54z43xYifgDM8AJ+ATOwxvJlPaDuxbEsp7X0FordFVVeKWIqjIZlcXJrEtPAY1vWje+0Y6KBmba3bZFWiEuDt0yJHySj3T4JK9MIZEwDLg+I4P6uc1yuEuKvfsTyOxhRW8rMGWKEZCC3r5skP2JqSEHsGvvmjgPo8R4nsmSj+FTABsHnmcGXx+lRQh4BEYGN1LPRIeRE9U/+ua8xBFyg61b2aC8DzD3WRBBDW1w4CjIB7T3vPQfnXkDL3DlC+oHJ4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(31696002)(86362001)(36756003)(54906003)(316002)(66476007)(66946007)(66556008)(4326008)(478600001)(6486002)(41300700001)(5660300002)(8676002)(8936002)(6666004)(2906002)(44832011)(38100700002)(186003)(2616005)(26005)(6512007)(6506007)(53546011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWZMcGhuNk5BZnl6NGxSL0ljM0s3cllhM08reVF4N1BpOWZMOUZmSUJodita?=
 =?utf-8?B?OGx4TlZLZ0pFRitsemh1eFR2bVhGWnlMbGY5OVNLQXg4VTJNSzFEaEF5dnpx?=
 =?utf-8?B?ODY2VjdhTTErSUpKRDBwMThJT3pEU0tRRUo0V1BiT2E3QnpDd25idktYS3pD?=
 =?utf-8?B?a2RSSmtmcGpSSCsvYkN2K3JaZS93amlGUlJRcitMTGVyS3NjYUt2eVhRcWVi?=
 =?utf-8?B?ZUhCTTQ2UHE3RjNxMXN1MkU0WDJQQkRkeUZwYytXekV0NkxTWDlRMXVxSUg2?=
 =?utf-8?B?am9pbThZUUF6VXQxKy90UE1WMjczalRLYjQ1c29LL1c3c3h0eE1sNWdsN3ho?=
 =?utf-8?B?Y3BZcEVnQnVycUNxZ0ZzT0hJaGYrUFRYT3NuWjZTUVhDeCtDU0E5Y25tbVhs?=
 =?utf-8?B?a04xWmxKR3MxMEhMNWc3eWJyUFRxR2pTdVFZaWZkTUtWR2h6TkdrZ2E4RE56?=
 =?utf-8?B?a2RNbUE0cFVySEVjN0pQd1phd2hWbjY4N25vVlI4N1ZyYkJ6c0k3STdXSFRF?=
 =?utf-8?B?R09ISUkzNWs0M014Q3J6TXNQY243czdlOVhGdkxGYitWN3MrMUM5WVpHb1la?=
 =?utf-8?B?VkFyZHR4Yk5EMzJlZGtiVzVNa1d1SEU5OFFBU25WM3F5MFhjRFZwNkJYZURz?=
 =?utf-8?B?bFpURVFVazRIUllmb2dBUVVRZ0FNdzdYNmFVcExtY21oTFhHcUdXbTNFTHVM?=
 =?utf-8?B?bmFwN2VnZTk2Z0luRENBeW5aK3pYL0RraHE1dnJyVm83L1pwUXh3VXhZeFd3?=
 =?utf-8?B?TjAvdzRENkpESFp5bTFXc0VmMmNpQmF6VmFmZmVyMHdScDdmam9iQk5NZUQ1?=
 =?utf-8?B?cW45bFpUUkhzanJDMTJsWFRGUW5teTFzYmZWRnhJK2lnbU0wQXZ1OHpzZ1k5?=
 =?utf-8?B?Nm05NmNCR2pIdWdUMVRCTkZlcjlCQm1XOFNZbzVhb0lJVm9oYmJoYnVVTUNt?=
 =?utf-8?B?VFkwS2NQNG02T1gvVUN5aEZHajdHQW5FVUdEYTdqczUwenZoUk8vdmxpQW96?=
 =?utf-8?B?WjJ4ZmxpR1RNOU9BRmdzZU9nQTV4RWhUNlBBZWVDRUdzMiszSFM3TktOUWgv?=
 =?utf-8?B?M3BKWnZWQUxxMEZieTRBbGZlVDhMRVB0Q1Vub3VYMVJ3TnJSM2F5a0g3cXJM?=
 =?utf-8?B?VXg2anBiTGtNZ0ZKYTM1VTRqZ3RqZ0g5aXA5aUJZKzJncFBidWt5NCtjcWhq?=
 =?utf-8?B?RE1UcFVkUm52S0F6cEZGT1g1dENyYVJ5UUlzRlVadjZBaE5OMDdTZG5JK1J2?=
 =?utf-8?B?YWdvYnVKdmVsbWU5SUFPU3FFczEvSWV6dHVNSGJMYVlTOG1PclRYZktQbUMv?=
 =?utf-8?B?QU54R3EvWFR4WlQrVE1Vbkl4V083bFFucEhrckRZRmIrTFBDZXZoS24rejdv?=
 =?utf-8?B?ZjF0VWV3ZUlyby9saUlzVkdxUWEzcWxINU5CR2dzakxKQmVEelJCdVhnUkhr?=
 =?utf-8?B?MmduL2hOREVJcldCN3VaSU1xbXQ3VG9sZDV4aXM0NDNYRytTYU9LKzVMaEFX?=
 =?utf-8?B?MTFiVmNCMnhGRXRQMG9TajZHZ2FTUnNhclloTVIyL2lJNU9vd05EU3BSdkFQ?=
 =?utf-8?B?WnRuUEM3VlBjcU16UThYRHdzS2RMTnFWWldjRVRMUHNHTW1yZldjK3B2ZjQ0?=
 =?utf-8?B?c29kbXZ2SHNHZG5BenJDeXJ3UUMwVGNCQ2FJTENma0R2NjRjWGRybWllV0dX?=
 =?utf-8?B?SFlJNlBReVBBRmdjTXgydjBsa0pSSERGTzlRZ1FuakgwN2kvM01KclVhaEF5?=
 =?utf-8?B?NXVNd29QSENmMk12OUE4UGNUZlB6eWFzZFhaelpaaVc4cnk3Zm1GclVaMzY5?=
 =?utf-8?B?SUNRdDdXckhUMVZTbDlJUU9kSVhnM0Z6UmtxMU52VHk0c1dTRS9aTk05VHUz?=
 =?utf-8?B?cGlHRlB6SXAyRHRjem5zRlZjRExKWC84VnV6ek8zSkU0RCtERHYxYXJucDBx?=
 =?utf-8?B?aW9WTnJoMEhadjRoZGcxSm9SL01SUktqUk9Xby9XalE0RjIyTmdsMTQzSVNU?=
 =?utf-8?B?TDhNRkQ1UE04cXpaT2l1aDZMcEMzdkZ0ZmxVcTNTZVIvYmU5T2hlR1dvU21y?=
 =?utf-8?B?QlBRY1dhNmZ2bFd3MUMrKzN5dVkrYWw4L25oUnp3QzJOTUFveEtCR3NCQ2pn?=
 =?utf-8?Q?3gsmEcPPri3Lgm3PTaUBrksfJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146aa8b6-e76a-473b-1e17-08db52dbc754
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 11:26:50.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UL4+WUIq2Sks6zIl4SG9SSJHpemhROnbE65nFioooLmvh3BjfiVFSQ1HqeKShZXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7001
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 15:53, Michal Simek wrote:
> From: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
> 
> Setting default i2c clock frequency for Zynq to maximum rate of 400kHz.
> Current default value is 100kHz.
> 
> Signed-off-by: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index cd9931f6bcbd..a7db3f3009f2 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -149,6 +149,7 @@ i2c0: i2c@e0004000 {
>   			clocks = <&clkc 38>;
>   			interrupt-parent = <&intc>;
>   			interrupts = <0 25 4>;
> +			clock-frequency = <400000>;
>   			reg = <0xe0004000 0x1000>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> @@ -160,6 +161,7 @@ i2c1: i2c@e0005000 {
>   			clocks = <&clkc 39>;
>   			interrupt-parent = <&intc>;
>   			interrupts = <0 48 4>;
> +			clock-frequency = <400000>;
>   			reg = <0xe0005000 0x1000>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;

Applied.
M
