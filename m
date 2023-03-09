Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01796B20FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCIKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCIKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:12:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1FE5028
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ruLH8zSQZZsfGivo1K273yjfxWzlrugF7EZpk3NzY0=;
 b=BrWmehbvvdPFzwefJH7TnEIe/t4+gRcfBcTEIuxMoBWVrgtJO/hmAf7GgYLNB/EdKYHX4FniiUxjnHZcSMPkREgEUKeyoUN6fHuUSD0cNmNpwP2ihRgemiLjZ+OuoNANOGPH8OyX01CwYn2rSoa+EI9yceLBdYGaQGSV+SIkuv0=
Received: from ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::10)
 by DB9PR08MB8737.eurprd08.prod.outlook.com (2603:10a6:10:3d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 10:12:37 +0000
Received: from VI1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:910:1c:cafe::ed) by ZR0P278CA0023.outlook.office365.com
 (2603:10a6:910:1c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT046.mail.protection.outlook.com (100.127.144.113) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Thu, 9 Mar 2023 10:12:37 +0000
Received: ("Tessian outbound b29c0599cbc9:v135"); Thu, 09 Mar 2023 10:12:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 443fe380d5f3e66d
X-CR-MTA-TID: 64aa7808
Received: from 5c42e967e915.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A00D02C6-2E2D-4BCD-8B19-D08D03D532A3.1;
        Thu, 09 Mar 2023 10:12:29 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5c42e967e915.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 09 Mar 2023 10:12:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAGU1lr1UMe109gCd4V2Mn+eIGjL0nmQsDlSJ2DkTkT3vIFAdAtL17K8XMS61VxmiCIeMQ33v1fXfZDbnzZD7B1GuwcRmtxqkXwAgQ71yASP3TZDfmsNNR5KMmqALlJ6o0+rrQg6jVFdSw5J6zl78RpQTFmKOA7qIWz+0easzw05tbwdJsQv1EFER0CFbUe8HWh/3Q4w/H1NmIGwRQEDIuIF4c3wQJM6KbCQgxyU5Hhq3x/6/Kz0gUeqcbMm06Hjkbz2RlEekRBjUfU+2RT4ubXDr0oH9WDDgRX1oKacLBMy4rd6K9CEytjHmezWvN16oVt+O0EJpLG9LozghTGbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ruLH8zSQZZsfGivo1K273yjfxWzlrugF7EZpk3NzY0=;
 b=jg6EiYApRsIMYiulefR+a5daSLRdMAO3wxck6TVXOC8g7bAAxjzdjS0pu18W93l3QiRH7R865IfEsUTyK5WGw5yWEzS+9OzC9JpgbnhhT/PxVp7P3ux+OLyA2GmhRojwJPEx2f80mrRL6NiUPd8o8kv7CC0D22n5h+pZHAxN7Cp9vpPS8/rPsFFEXtrX3AJ0FXVZIc9oRa3QdnE4FYA2Dilp+n72kXgtxR3oxjZWYu8HCWquwec/PKutj7Kjzo4swmbXF/sLIt68MRItpM6BmgSDSus2kDr146j79fidlZmS/UbFpJh38V41uMj20IS+jo1Dc7m08VDDoeN61aEcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ruLH8zSQZZsfGivo1K273yjfxWzlrugF7EZpk3NzY0=;
 b=BrWmehbvvdPFzwefJH7TnEIe/t4+gRcfBcTEIuxMoBWVrgtJO/hmAf7GgYLNB/EdKYHX4FniiUxjnHZcSMPkREgEUKeyoUN6fHuUSD0cNmNpwP2ihRgemiLjZ+OuoNANOGPH8OyX01CwYn2rSoa+EI9yceLBdYGaQGSV+SIkuv0=
Received: from AM6PR04CA0045.eurprd04.prod.outlook.com (2603:10a6:20b:f0::22)
 by DB4PR08MB8031.eurprd08.prod.outlook.com (2603:10a6:10:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 10:12:27 +0000
Received: from VI1EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::7a) by AM6PR04CA0045.outlook.office365.com
 (2603:10a6:20b:f0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 VI1EUR03FT042.mail.protection.outlook.com (100.127.144.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Thu, 9 Mar 2023 10:12:26 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Mar
 2023 10:12:25 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17 via Frontend
 Transport; Thu, 9 Mar 2023 10:12:25 +0000
Date:   Thu, 9 Mar 2023 10:12:24 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nd@arm.com>
Subject: Re: [PATCH v2] arm64/sysreg: Convert HFG[RW]TR_EL2 to automatic
 generation
Message-ID: <20230309101224.GA54799@e124191.cambridge.arm.com>
References: <20230306-arm64-fgt-reg-gen-v2-1-7e166c5b3b42@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230306-arm64-fgt-reg-gen-v2-1-7e166c5b3b42@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: VI1EUR03FT042:EE_|DB4PR08MB8031:EE_|VI1EUR03FT046:EE_|DB9PR08MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: c5123a7c-03c1-4003-3e3a-08db2086cefe
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: l61anGm4rqmPnAeE66GBGVl2GDdlFj+ojiJ7JTIxRBkkCCGlZtGcbKCvIQNT+ZSuuB9vF1K68xACxMkS7QZsAfIz6ZXbEfsnmcl/WvqS4EPHad53sM4sGawxoRnWMPrph6NMb2FrY8n6U3LbEd0gK+JqgiG3V+NWhWlYNxfCjXegGGQluIEvh/scXDxWptevWnuJ1tqPmubS6EuxIu8yBPxPr4VCHb9IYouUtOcKI2Yx/8aueITRL5MjN3XSZIQw5JX3kaZaflyIRvNf66iBaHgjqdxr61os7EUARC2O9IpxPMc2Lug/PgJQJ+XDPX2KkROlLALLzelXD/auPwxcOSNlWRc/2FiwwYNY/JTk3I6ZMvrGe5lFoUTa0CWgN1h9M2jULv4YqJdMnMeBuIWZZ50uOQm2t5NzHv7CmSVxqbfWTsLp/1gtNNRMqzuRkHX+EldDKmSvUtVog673ZowcBqd/20dVHFWTZwwlvLHXKE0GHAUsqSuPSkFD+hXiQtY6UjRpRoRgniRO0Cc59fDNSBPUEXFNYy/xJ+i20IYxXIL85+mmTTGOzmUKG5UdhM07OiGUiUEfizUEIb3DCePGiQ/khRf1khlBPgMGz5RIS+EK3oCzvgsA7Vvp2QlQb3g7fU5uSwOS8Ck0ng82dkF/g9XefJblmqyPmnxdLupP31UhQBjNHVJVgNbK5TYPaC9T
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(36840700001)(46966006)(33656002)(54906003)(478600001)(966005)(7696005)(316002)(5660300002)(41300700001)(19627235002)(2906002)(8936002)(8676002)(70206006)(44832011)(70586007)(6916009)(4326008)(82740400003)(81166007)(36860700001)(55016003)(356005)(40480700001)(86362001)(1076003)(186003)(26005)(83380400001)(82310400005)(336012)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8031
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e0a0f14-e88d-4070-7069-08db2086c8a8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HN2gsypxSz2PmQiwWf0xXVfLyS9pEz6WhXnOJVYn4VFyKhz5Z7kL2PRFJo6iAybji3sMXs+06xOzLvcnE3Lsi3NnJKA1HDJyo8G4WMVDTwSNWwdtQxKFnpppkqak8aEbAmKfWCGRQL1RygivTZqzcVgrhcKdF13cz1afGOx6UdSoX3xRifwnUbWEJKyufkUr+JlLHlotO+03Q4NXtGVnuFIBjbSLl3GaTNdw35KL7G+lmobl4FsK4r9JyqP2afalO0xEuFh2XgXZwkQR7msWI4G/5N1tN9VwiwLmyYzZTPIwh0glmfTZQmfuIqf3HCqx+UOKq7dAsSP6c0Dz2nJ2DqmOq1aBvYt5gA4V1PERyXUvIiwBIDweiF4mcb8PnK0naeJc9IClC1tQkl2ERqfX7DxKmM064JbJonIe4EpwuUCAjxFIcJoJ8p4GONb5a7T+FQVnOMgjlJoj3sUy80sjoijUpB3Mvv2mOYSskW0lIIx/bpCoKEFPzz1SDDj0OCvO7abUQ2BPsHgSi3WqmXnN7MXwi+p693JaVCQNvIkRr6teyxYldNFO5R/CkLQEOHucn534Q7wSSU0LzJvc5woM9b6wtFik8+iXegXL3NfsLWM6nQkRLqbtYY2m951xIPhSRzNA1nijWHcXuPEsFVcAOlQ08IJ1vog3CJ6RR0hYgDHF5gPg5Bngpq50712GVf9S
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(33656002)(54906003)(7696005)(966005)(5660300002)(316002)(8936002)(70586007)(2906002)(19627235002)(8676002)(6862004)(70206006)(4326008)(41300700001)(44832011)(82740400003)(186003)(36860700001)(86362001)(81166007)(478600001)(55016003)(40480700001)(26005)(1076003)(83380400001)(82310400005)(336012)(47076005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:12:37.2438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5123a7c-03c1-4003-3e3a-08db2086cefe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8737
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Mar 07, 2023 at 07:11:09PM +0000, Mark Brown wrote:
> Convert the fine grained traps read and write control registers to
> automatic generation as per DDI0601 2022-12. No functional changes.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Correct naming of nPIRE0_EL1.
> - Link to v1: https://lore.kernel.org/r/20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org
> ---
>  arch/arm64/include/asm/sysreg.h |  8 -----
>  arch/arm64/tools/sysreg         | 75 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 9e3ecba3c4e6..e5ca9ece1606 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -419,8 +419,6 @@
>  #define SYS_MDCR_EL2			sys_reg(3, 4, 1, 1, 1)
>  #define SYS_CPTR_EL2			sys_reg(3, 4, 1, 1, 2)
>  #define SYS_HSTR_EL2			sys_reg(3, 4, 1, 1, 3)
> -#define SYS_HFGRTR_EL2			sys_reg(3, 4, 1, 1, 4)
> -#define SYS_HFGWTR_EL2			sys_reg(3, 4, 1, 1, 5)
>  #define SYS_HFGITR_EL2			sys_reg(3, 4, 1, 1, 6)
>  #define SYS_HACR_EL2			sys_reg(3, 4, 1, 1, 7)
>  
> @@ -758,12 +756,6 @@
>  #define ICH_VTR_TDS_SHIFT	19
>  #define ICH_VTR_TDS_MASK	(1 << ICH_VTR_TDS_SHIFT)
>  
> -/* HFG[WR]TR_EL2 bit definitions */
> -#define HFGxTR_EL2_nTPIDR2_EL0_SHIFT	55
> -#define HFGxTR_EL2_nTPIDR2_EL0_MASK	BIT_MASK(HFGxTR_EL2_nTPIDR2_EL0_SHIFT)
> -#define HFGxTR_EL2_nSMPRI_EL1_SHIFT	54
> -#define HFGxTR_EL2_nSMPRI_EL1_MASK	BIT_MASK(HFGxTR_EL2_nSMPRI_EL1_SHIFT)
> -
>  #define ARM64_FEATURE_FIELD_BITS	4
>  
>  /* Defined for compatibility only, do not add new users. */
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index dd5a9c7e310f..60829a9409f0 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1866,6 +1866,81 @@ Field	1	ZA
>  Field	0	SM
>  EndSysreg
>  
> +SysregFields	HFGxTR_EL2
> +Field	63	nAMIAIR2_EL1
> +Field	62	nMAIR2_EL1
> +Field	61	nS2POR_EL1
> +Field	60	nPOR_EL1
> +Field	59	nPOR_EL0
> +Field	58	nPIR_EL1
> +Field	57	nPIRE0_EL1
> +Field	56	nRCWMASK_EL1
> +Field	55	nTPIDR2_EL0
> +Field	54	nSMPRI_EL1
> +Field	53	nGCS_EL1
> +Field	52	nGCS_EL0
> +Res0	51
> +Field	50	nACCDATA_EL1
> +Field	49	ERXADDR_EL1
> +Field	48	EXRPFGCDN_EL1
> +Field	47	EXPFGCTL_EL1
> +Field	46	EXPFGF_EL1
> +Field	45	ERXMISCn_EL1
> +Field	44	ERXSTATUS_EL1
> +Field	43	ERXCTLR_EL1
> +Field	42	ERXFR_EL1
> +Field	41	ERRSELR_EL1
> +Field	40	ERRIDR_EL1
> +Field	39	ICC_IGRPENn_EL1
> +Field	38	VBAR_EL1
> +Field	37	TTBR1_EL1
> +Field	36	TTBR0_EL1
> +Field	35	TPIDR_EL0
> +Field	34	TPIDRRO_EL0
> +Field	33	TPIDR_EL1
> +Field	32	TCR_EL1
> +Field	31	SCTXNUM_EL0
> +Field	30	SCTXNUM_EL1
> +Field	29	SCTLR_EL1
> +Field	28	REVIDR_EL1
> +Field	27	PAR_EL1
> +Field	26	MPIDR_EL1
> +Field	25	MIDR_EL1
> +Field	24	MAIR_EL1
> +Field	23	LORSA_EL1
> +Field	22	LORN_EL1
> +Field	21	LORID_EL1
> +Field	20	LOREA_EL1
> +Field	19	LORC_EL1
> +Field	18	ISR_EL1
> +Field	17	FAR_EL1
> +Field	16	ESR_EL1
> +Field	15	DCZID_EL0
> +Field	14	CTR_EL0
> +Field	13	CSSELR_EL1
> +Field	12	CPACR_EL1
> +Field	11	CONTEXTIDR_EL1
> +Field	10	CLIDR_EL1
> +Field	9	CCSIDR_EL1
> +Field	8	APIBKey
> +Field	7	APIAKey
> +Field	6	APGAKey
> +Field	5	APDBKey
> +Field	4	APDAKey
> +Field	3	AMAIR_EL1
> +Field	2	AIDR_EL1
> +Field	1	AFSR1_EL1
> +Field	0	AFSR0_EL1
> +EndSysregFields
> +
> +Sysreg HFGRTR_EL2	3	4	1	1	4
> +Fields	HFGxTR_EL2
> +EndSysreg
> +
> +Sysreg HFGWTR_EL2	3	4	1	1	5
> +Fields	HFGxTR_EL2
> +EndSysreg
> +
>  Sysreg	ZCR_EL2	3	4	1	2	0
>  Fields	ZCR_ELx
>  EndSysreg
> 

Reviewed-by: Joey Gouly <joey.gouly@arm.com>
