Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35166AEC8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCGR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCGRzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:55:46 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2075.outbound.protection.outlook.com [40.107.249.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE379DE29
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA2BdKRtxFuLKAH+1Rt+xP9nZyiBBeVpp9wIReaV2es=;
 b=8ySbq0CYyC/Y74uT2macwobUM0lA3GSm663Xxut9Hm9X6ET3VjehKaCvsMlwEckLqtBALYPyOOjMBygcz7lP+tq36f1WGdomgY72vi9o2Vm1fs8EFd2YAVSMmERQtborugwdxjORqR7C2tvd4B4BUjgca6mysCnpqwsEXscv6Qo=
Received: from FR3P281CA0164.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a2::18)
 by AS2PR08MB10053.eurprd08.prod.outlook.com (2603:10a6:20b:640::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 17:50:24 +0000
Received: from VI1EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:a2:cafe::63) by FR3P281CA0164.outlook.office365.com
 (2603:10a6:d10:a2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16 via Frontend
 Transport; Tue, 7 Mar 2023 17:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT004.mail.protection.outlook.com (100.127.144.92) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29 via Frontend Transport; Tue, 7 Mar 2023 17:50:23 +0000
Received: ("Tessian outbound 2ba0ed2ebb9f:v135"); Tue, 07 Mar 2023 17:50:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0cd8e172fe30c083
X-CR-MTA-TID: 64aa7808
Received: from d02e808f4813.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 58C742F6-0A83-488B-B00F-3ED4CAC14493.1;
        Tue, 07 Mar 2023 17:50:16 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d02e808f4813.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Mar 2023 17:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+gW8IPZptvPQzgfTw/CPOB+ybDYCuIoGlUlgC7x+LthdBM09EDEff1iv5PzNRS0va6yDBSc5okddCRnNp3qcD2he6PSEyUp6+qMigDgowFw2U43M9KoKaBF9oL6F5gJEychxF0MwT2Ebm/oITVXwx+YrAUqme+MhmU1LDBMjq+VSIOTpjoSK0Bk6EpEiI09ASKHAbTQrCx5aYdxRejhKjjZoLA+AlN50L7bPH7pMpS/xBAf4NVP2Mg54PoCdtxf90VWbxS+/RxIVVmtMYIFNGqrZRqmK7F7FP1rqYLNTGP77aVDX8y9CwD9LQvUc++Qnb7oeVpVp+qv+jSwRaSojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA2BdKRtxFuLKAH+1Rt+xP9nZyiBBeVpp9wIReaV2es=;
 b=QMtY94LZPKl99xybbFyzpVXjomPUbEfX7catzfV81bMLMrmdMF1z4E9NhzjUiInx5OM/UWfIjAlwHkoKj6YkghcYAewDXHvWF3ga99K3KNImWH+/a76PxWOnLnLl8UtKufvqqXitVT0E6ES65Cn7j+I9tdwyzrDZhVeS1gQ8qdJEe+6Z5tLBqWNXkFXlU0Qra51DT3gxDcFe5gFQ2lqFM+bQThgjUkjxy2JOW4WhJpJqCbRzlxx8qnsP0+su7u7BU9mEdzf9wlvFPXWGXOK9uFaAK32y6dpF4bZMpFvgfykIYF6sw79V6pWuLYKiw/Hofyo8ETnoUTFCw9ZoWY15zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA2BdKRtxFuLKAH+1Rt+xP9nZyiBBeVpp9wIReaV2es=;
 b=8ySbq0CYyC/Y74uT2macwobUM0lA3GSm663Xxut9Hm9X6ET3VjehKaCvsMlwEckLqtBALYPyOOjMBygcz7lP+tq36f1WGdomgY72vi9o2Vm1fs8EFd2YAVSMmERQtborugwdxjORqR7C2tvd4B4BUjgca6mysCnpqwsEXscv6Qo=
Received: from DB6PR1001CA0007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b7::17)
 by GV2PR08MB9157.eurprd08.prod.outlook.com (2603:10a6:150:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 17:50:14 +0000
Received: from DBAEUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b7:cafe::a) by DB6PR1001CA0007.outlook.office365.com
 (2603:10a6:4:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 17:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT047.mail.protection.outlook.com (100.127.143.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.29 via Frontend Transport; Tue, 7 Mar 2023 17:50:14 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 7 Mar
 2023 17:50:13 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 7 Mar
 2023 17:50:13 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17 via Frontend
 Transport; Tue, 7 Mar 2023 17:50:13 +0000
Date:   Tue, 7 Mar 2023 17:50:12 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nd@arm.com>
Subject: Re: [PATCH] arm64/sysreg: Convert HW[RW]TR_EL2 to automatic
 generation
Message-ID: <20230307175012.GA43061@e124191.cambridge.arm.com>
References: <20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT047:EE_|GV2PR08MB9157:EE_|VI1EUR03FT004:EE_|AS2PR08MB10053:EE_
X-MS-Office365-Filtering-Correlation-Id: fe18e1e9-986f-4b7c-c6f5-08db1f346d1d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5f0utFWG4MH4HqRMcNTUxqiL87mK2EW05qa9HjhJmYVbgnSw4IEmT4M6tOnPtlT7NZZvvbA7Gcae3mKT7lWmRIG0yp6o9wuwxuMFk7GoKsAA/II+2SmZfSqe0ep6RM/rN8zU+TEyRaFgLyxxhWYN/1aIpp5/mQPyFdzXX1fusLGMiTD6VHUoo7ApE3Op0EfsyTm6gqxBqnKxzCtOhgO//sUjVy2CNYJ2Tn39WgeZPq3sXnGI7UA8KUwPG2NWtIZjWuh3GFribwesf36yAiTXPmpOK/k3P08iG2HHB6GiUP/4ybDXOt9sIWBZv2vIEH85yGUH+G1/RQNS658g3LLw/qadhI9tM6Tl4Ksk7MX4kBqiuN05DFeTW+hJRbSt+be/B2Q2OV5+39giUP4GdCzo60XFsa1NPI2uQSDqKkt2XFUe8pPojDC1i05B4Z73dj5Iejo/LHNxSD/9oWXY9KGtgSJ0kKGRUEuytlof57nH9fmTlSe2CFlWUQKRiOmFy+LSOHF+D3YSA/oxzNZshYTL8cfaKjuqybL+WneOkiTHezXKHnF/LOR2bAx/oKrkqLGnVi3/x3ftqKqEIVDKsRiwmG6cVUULTy98IAhHWM3WrbW3YhwklOBQSMr7Z/BwCRr+AEiiBoEe+pSqcn5pzl41wy7zuaf+DZBcaXARvDu74tk6Em7U+Iy1YbPKDz6QtsYBY6C28CIOuK9cOAVH4FIb3w==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(36840700001)(46966006)(2906002)(5660300002)(8936002)(41300700001)(6916009)(8676002)(70206006)(70586007)(4326008)(83380400001)(44832011)(316002)(54906003)(19627235002)(7696005)(33656002)(1076003)(478600001)(40480700001)(426003)(336012)(47076005)(86362001)(55016003)(82310400005)(26005)(81166007)(82740400003)(356005)(186003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9157
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b477adab-8bef-4537-76f3-08db1f346800
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKS89Cad255ACed75IofrHvN2iCJGRIanZuoWifRmMqWi/EHXog9h9dRb9zmFwzN6CMjalQcHr0YMM1rjJdJ7Ldtz6ewvxHp6RZh2mewSacbsY7mNS8bLjzPHRl5+XGtOkb6ImAlygddMqcA7FaWUQtLD4FLAF5KWbmIHLDDvpj34tXFzFyelBnctIOZ80ys9IcZeZMmLzlVn5ItX/eJvTOpIFu0t7Zn66Bh73HJ3nzt/BpuXBXFdZ+tk7ZgFRTr9pK8Gx68jyCJ0qUovu5W50xv5j1YMQEj6V6i3vsChFzhHOFgDSEq6Gq1fHgWH0abDx7tVQ7ZokV9WjK92r49729HyaYEf4N8KQBg0XbNrfG6OwN01PqxyYTjTz04fiROUSZz0E/6rGGy6QQE7rntwgeUjyNbny1L5tUjoE/+QhQDlXCCEiSfWuT8FdfuUh24KiqIpk+pJtb+Mt4p1ToYv5QHPOWZUBl1t+UaYBkvy52cJ6+HCmvK6yUGFm+DvXVw/kkd4KQrdeN3Jcx8G218o79xqjZwBqcgJeTlbr8xoo85H3A2OT4CmnBaHMpSVIYRLANkGLlv+O9cliPNw0M1auMiEW5/+WD8IavlN/mAv6l8CmLeFUMpDr2PL7JLzrCSdWO/jUQxpJRkTZpgOFIEHycYwjHWrrrSoCQuQSDrzVdR18rfJhx5J8z/9wbmp2d1yXbNhPWZtq3WJEF2TZxf5g==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(86362001)(36860700001)(8676002)(7696005)(33656002)(5660300002)(44832011)(2906002)(70206006)(70586007)(4326008)(6862004)(41300700001)(8936002)(40480700001)(82310400005)(40460700003)(186003)(336012)(426003)(47076005)(83380400001)(55016003)(316002)(54906003)(19627235002)(1076003)(26005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 17:50:23.1391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe18e1e9-986f-4b7c-c6f5-08db1f346d1d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10053
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again!

Just noticed there's also a typo in the subject:

    arm64/sysreg: Convert HW[RW]TR_EL2 to automatic generation

Should be `HFG[RW]TR_EL2`.

Thanks,
Joey

On Mon, Mar 06, 2023 at 08:46:18PM +0000, Mark Brown wrote:
> Convert the fine grained traps read and write control registers to
> automatic generation as per DDI0601 2022-12. No functional changes.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
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

[..]
