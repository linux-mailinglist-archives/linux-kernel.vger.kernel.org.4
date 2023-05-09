Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03DD6FC8B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjEIOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjEIOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:19:10 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AB34EFC
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8m9s7vGCQSYuUacNFKmLGJnEF0JTsOqgo/RLT7Ujpk=;
 b=ELB5OiDzONDzt1j9bnowxEuDTjdFS6fPvTpHqk5Bd2gNbDI40K6SbOGwlF7xxVaVVesYAW92GqYgQQV7uVr04iKCZx/niUT19VycLBZGwYZ7v6Pu7mCIVrUhNNjEr/0qUBXZjTlVJTPebjecdFoxJAKoVz9Pwl5GPmNFO5qoxLk=
Received: from AM6P193CA0106.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::47)
 by GV2PR08MB9422.eurprd08.prod.outlook.com (2603:10a6:150:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:19:01 +0000
Received: from AM7EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::60) by AM6P193CA0106.outlook.office365.com
 (2603:10a6:209:88::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 14:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT035.mail.protection.outlook.com (100.127.141.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 14:19:01 +0000
Received: ("Tessian outbound 99a3040377ca:v136"); Tue, 09 May 2023 14:19:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dca54dd69b08ac3b
X-CR-MTA-TID: 64aa7808
Received: from cd9bd5d5adec.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 00B6E072-5939-4694-9CE6-A74B779A837D.1;
        Tue, 09 May 2023 14:18:54 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cd9bd5d5adec.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 09 May 2023 14:18:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzsALikN2BCDKGrA9ul5sB4lgK6UebxO/iCfpIqJ2SLUbliMu9UAbxxCLs30/n7RHAg0ZNKI/9P7Z8jGSnhN3OuRcjXCaHM7BXJudgM1L03Ndf5ziBBXZdWHTg7Zsk2ln3ITGRbQmj+/lvsQ3b4QUk+uJrg1+7it2HEeuZzYj4LIFkzG3zSGhjKboVvjz6sMbCClCuWuCzwkmPD6BEVmMfIrUuWlMYMcVgcvj+jDuBoch17yeMu2J/lV8xMIyPXKkAvhj45KYBm72rJmsi7hB8gaMZ2x4fy+7QuvB+qdNaXd1Y3uEBEhnUdu8i1InS6bydug50UwwfBQfVp3XhFknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8m9s7vGCQSYuUacNFKmLGJnEF0JTsOqgo/RLT7Ujpk=;
 b=Vb+za1o3ETL9pF1DgJTUKEMZFRKMwBfTmdSUpKn3aIOjTYfYh3xuBf6DfMSWtuPV5Z5to5dyhF5p912ZlUDX/sBflHK56S3RzG6qX5/GBxg6GbthlpWrFI4N5J+UtTPLzbUMPWL8UdrKC/tLp2fjUYMeG9KR88bfhRJdFmJXRxLEeDUxyTuNtT4yaHKsNMmNtypqT7iqnPcrgny8nN0ZDSvB8Ig7jcBANFny0xNEptJekh043d1WYYCHTrWREZrzX0UQp9RDmWRWDg7i8xoGUDYSYZSysbtO2Flx5a8aHOPlkbmPIeSe5GAPAL8AGVzCrJ+30BTjXhQ/e1xlxqeMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8m9s7vGCQSYuUacNFKmLGJnEF0JTsOqgo/RLT7Ujpk=;
 b=ELB5OiDzONDzt1j9bnowxEuDTjdFS6fPvTpHqk5Bd2gNbDI40K6SbOGwlF7xxVaVVesYAW92GqYgQQV7uVr04iKCZx/niUT19VycLBZGwYZ7v6Pu7mCIVrUhNNjEr/0qUBXZjTlVJTPebjecdFoxJAKoVz9Pwl5GPmNFO5qoxLk=
Received: from AM5PR0402CA0017.eurprd04.prod.outlook.com
 (2603:10a6:203:90::27) by DU0PR08MB8881.eurprd08.prod.outlook.com
 (2603:10a6:10:47c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:18:52 +0000
Received: from AM7EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::e) by AM5PR0402CA0017.outlook.office365.com
 (2603:10a6:203:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 14:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT028.mail.protection.outlook.com (100.127.140.192) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 14:18:52 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 9 May
 2023 14:18:51 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Tue, 9 May 2023 14:18:51 +0000
Date:   Tue, 9 May 2023 15:18:50 +0100
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nd@arm.com>
Subject: Re: [PATCH 2/2] arm64/esr: Add decode of ISS2 to data abort reporting
Message-ID: <20230509141850.GA2894321@e124191.cambridge.arm.com>
References: <20230417-arm64-iss2-dabt-decode-v1-0-2138b5668777@kernel.org>
 <20230417-arm64-iss2-dabt-decode-v1-2-2138b5668777@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230417-arm64-iss2-dabt-decode-v1-2-2138b5668777@kernel.org>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT028:EE_|DU0PR08MB8881:EE_|AM7EUR03FT035:EE_|GV2PR08MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: d15627c4-2ecc-46a8-fb41-08db50985660
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: OFvEofvKkNDpy60OBJh9Dkq76v3s1jxRslH+8b2FBmBXHfBGD8lTK4idMdp4jveoiXAbMjWPtBxcvvfYF3d07JNnN+MEICRBV0MnbYxkhZeJTqQpKXI6hAJw/ihxJRWezhAIHJnvo4gOfiiMcgacckhncJNUkG6MJt2HYwCx0DnGzKPhb4BVhWDW5knHzX3BsHR7W4a7sWt9hFiF5DpIPow+hPDQY2KbpG+/69KpuAcpb8GP/IBn/VVhiIpfSXCEJ6hyo79+hmyZpTz2vpNjuN0ER9W2KGAonOPinKfhpumdDLrh2yqh6/UX/meJV1r4hFbrWTbK3pOuNDGOqPIxEknv7ODWATK+/pWNqH3bfIzvFU2D6ajDYS/+5G6QCQIzIP0FjLSt4P0pqdKp+VmwoXmngLEIh6bqN0nYG5vvTl9BGNxDPVNqXmfbQR6eYm2/eTyySpdIpqi11MSN+yIes1aNpfodUsxQWThNjI1XhvO1iq2tVZOje/2AhgWomMsKQBWozL3IF7dyHrfwEQPq7Kk97obuF1SwPr1ykQI8kxUmeAYngAITsThsWgtbW8UPg/+isfhiBqEqskVoMT2JRn5XXzYSmPYcPpKqCW+ojo23GP1GSF7iFsl0T2M4RO7Ka73C6h4jzu+IOBR6dfvwZhQEhB2ZcsyZqFNaLim9sU6OirIxlA/H+9iUqKHlSey61X2vj3rODCkmF+BqRcZKqg==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(33656002)(1076003)(26005)(2906002)(86362001)(186003)(82310400005)(40480700001)(55016003)(83380400001)(47076005)(426003)(336012)(82740400003)(356005)(81166007)(36860700001)(316002)(41300700001)(8936002)(54906003)(8676002)(478600001)(70206006)(6916009)(4326008)(70586007)(7696005)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8881
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c1464d09-3395-454a-3f7f-08db50985116
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f19mi7JnISGi8/NDYbS7uwSYKcj90nlAr2IxvQdBGOq/9VxJSb3XacGUJtuZKJ4kPMM9GaUZ0DD6kEYBHxFEYiyxLjl9pubwe2Cb4yl0dodJmRqc1tcirX/e37fky/0PhJAP8BK+URxVI+CB+ySHokQ1vomrJ+KXOC/4a4X2NbEnZmDuVFxibqsc9RApRuaXUXTut7/o56Osfg2BF5TCXknXf+TJmfBH9WLxCiniVtlxzjuEOBJ2bDZ/Q47DnXBei22TewPg4li2s+CZ26rxQYN+GWmZHo+0pB2CP0IbHrABoXV388CorDkyNRDgy9Hdh6RRlYjOwvEG/XYcEzIEjMwgcNV0/bGfeKnwhVUnZDRK4l93OutH/MzxM8wMGtvZHf9GswEwALJg0ESo9+TZBWOLdl+2gptaieSvfWcfw49+bHjB95j4p9hgeERzXEk/D5LSrW9SfZawY1ZRf+PNHo3CG7QfCmq2iDgNFlwOXZg1H2TnK6uk/eGOZcgG/Anpj8682rDf+V+YCHNKrjL3q3UbXh/yvnbUyPnJW5ym1qipRHSkogWY+mJfF5cYkJ5LxXu0Tqfzmg6fa0AekXwX60xL73wyP01c5dBZDZ9nIVqWQL4FD8Rc1eFG8BSs0dgLf9IAZla9UBXbap0/gEUzzU8RcOO4TeoaOCVJYzbGJw+tll4vL66krH5z+/km6HYyv/Cuzv+Vi8iZpfJQxqjriQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(86362001)(83380400001)(186003)(4326008)(82740400003)(41300700001)(70586007)(70206006)(26005)(1076003)(47076005)(336012)(36860700001)(426003)(33656002)(5660300002)(40460700003)(7696005)(82310400005)(44832011)(55016003)(316002)(40480700001)(81166007)(6862004)(8936002)(8676002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:19:01.6879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d15627c4-2ecc-46a8-fb41-08db50985660
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9422
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Apr 18, 2023 at 02:57:32PM +0100, Mark Brown wrote:
> The architecture has added more information about faults to ISS2 within
> ESR. Add decode of this to our data abort fault decode to aid diagnostics.
> Features that are not currently enabled are included here for completeness.
> 
> Since the architecture specifies the values of bits within ISS2 in terms
> of ISS2 rather than in terms of the register as a whole we do so for our
> definitions as well, this makes it easier to review bitfield definitions.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/esr.h | 17 +++++++++++++++++
>  arch/arm64/mm/fault.c        | 14 ++++++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 0bd879007168..17bc6536ffea 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -77,6 +77,9 @@
>  #define ESR_ELx_IL		(UL(1) << ESR_ELx_IL_SHIFT)
>  #define ESR_ELx_ISS_MASK	(GENMASK(24, 0))
>  #define ESR_ELx_ISS(esr)	((esr) & ESR_ELx_ISS_MASK)
> +#define ESR_ELx_ISS2_SHIFT	(32)
> +#define ESR_ELx_ISS2_MASK	(GENMASK_ULL(55, 32))
> +#define ESR_ELx_ISS2(esr)	((esr) & ESR_ELx_ISS_MASK)

Typo here, should be ESR_ELx_ISS2_MASK.

>  
>  /* ISS field definitions shared by different classes */
>  #define ESR_ELx_WNR_SHIFT	(6)
> @@ -140,6 +143,20 @@
>  #define ESR_ELx_CM_SHIFT	(8)
>  #define ESR_ELx_CM 		(UL(1) << ESR_ELx_CM_SHIFT)
>  
> +/* ISS2 field definitions for Data Aborts */
> +#define ESR_ELx_TnD_SHIFT	(10)
> +#define ESR_ELx_TnD 		(UL(1) << ESR_ELx_TnD_SHIFT)
> +#define ESR_ELx_TagAccess_SHIFT	(9)
> +#define ESR_ELx_TagAccess	(UL(1) << ESR_ELx_TagAccess_SHIFT)
> +#define ESR_ELx_GCS_SHIFT	(8)
> +#define ESR_ELx_GCS 		(UL(1) << ESR_ELx_GCS_SHIFT)
> +#define ESR_ELx_Overlay_SHIFT	(6)
> +#define ESR_ELx_Overlay		(UL(1) << ESR_ELx_Overlay_SHIFT)
> +#define ESR_ELx_DirtyBit_SHIFT	(5)
> +#define ESR_ELx_DirtyBit	(UL(1) << ESR_ELx_DirtyBit_SHIFT)
> +#define ESR_ELx_Xs_SHIFT	(0)
> +#define ESR_ELx_Xs_MASK		(GENMASK_ULL(4, 0))
> +
>  /* ISS field definitions for exceptions taken in to Hyp */
>  #define ESR_ELx_CV		(UL(1) << 24)
>  #define ESR_ELx_COND_SHIFT	(20)
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index f4cb0f85ccf4..2e76dc613c86 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -66,6 +66,8 @@ static inline const struct fault_info *esr_to_debug_fault_info(unsigned long esr
>  
>  static void data_abort_decode(unsigned long esr)
>  {
> +	u64 iss2 = ESR_ELx_ISS2(esr);
> +
>  	pr_alert("Data abort info:\n");
>  
>  	if (esr & ESR_ELx_ISV) {
> @@ -81,9 +83,17 @@ static void data_abort_decode(unsigned long esr)
>  		pr_alert("  ISV = 0, ISS = 0x%08lx\n", esr & ESR_ELx_ISS_MASK);
>  	}
>  
> -	pr_alert("  CM = %lu, WnR = %lu\n",
> +	pr_alert("  CM = %lu, WnR = %lu, TnD = %llu, TagAccess = %lld\n",
>  		 (esr & ESR_ELx_CM) >> ESR_ELx_CM_SHIFT,
> -		 (esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT);
> +		 (esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT,
> +		 (iss2 & ESR_ELx_TnD) >> ESR_ELx_TnD_SHIFT,
> +		 (iss2 & ESR_ELx_TagAccess) >> ESR_ELx_TagAccess_SHIFT);
> +
> +	pr_alert("  GCS = %lld, Overlay = %llu, DirtyBit = %llu, Xs = %llu\n",
> +		 (iss2 & ESR_ELx_GCS) >> ESR_ELx_GCS_SHIFT,
> +		 (iss2 & ESR_ELx_Overlay) >> ESR_ELx_Overlay_SHIFT,
> +		 (iss2 & ESR_ELx_DirtyBit) >> ESR_ELx_DirtyBit_SHIFT,
> +		 (iss2 & ESR_ELx_Xs_MASK) >> ESR_ELx_Xs_SHIFT);
>  }
>  
>  static void mem_abort_decode(unsigned long esr)

Thanks,
Joey
