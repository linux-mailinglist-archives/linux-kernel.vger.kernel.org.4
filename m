Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD864621AC0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiKHRdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiKHRdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:33:33 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC9E034
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:33:29 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=WWUHVNlN2Jx1Vun8dcxAb2jkOCvCZmV2Tu7D5SP72+CBbPnmEsEcBShDbK5rLfvWrdBNIquflqLHGxV04CSmXZe2OCiqrar3aPoWNrUYxqlf8b3lM7liQ3UwBloyf3YzalfeTH5wSOBC8TZCPp/N6k49w2skzF4taoUP//34RQVIc69UsO3e9gRc9gF+KZt/daGeRZbTvZMmZJD43FO82k595yBJ/Kb/h7fyzy8VDGxMS/5ZQcqI+DEjW5bHT3W0NEu22k3v/qgAduocejZ+kxWushuhyzD+SxT9OHGrMlJ5jRam1ewUYjR8ULnkM4ypSarbCD1LwzLJ3TWm2t+EeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPJiZy9XZ9EM7S3THpQEF25ezDVwjrZjqI2EjmTUTzQ=;
 b=hrC5naNYyO45aoHaThkk+eVuVsHSCTZY3kNgvbqEvi++QVKesHaJGle9dXuZJqvXPfeo0c3fmmY9Ra/Pj9zykAFNrIRcTcDbPRVxQ6Y5+tohu02rrWB+vmcDqdIgB+hP58QeIVxF72iHwlHB5qGudh9wXhwVT0YOv8UpgaZkKZs0QkYbCMc9Sv5UZOeGTMv58b82aHtWGV+VKWmquzy0wnxq/HSg7gMsWC8i8txQsc608RMZn2+76ToesTL0o9xaKFpU2mZ941+olnHKVJJtrntOFp3rUKIB8QrbDImaZxUUPoDI3l8nZa9dOxRMJqlRMBtz4d9RZZYcUDG2ghtwIw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPJiZy9XZ9EM7S3THpQEF25ezDVwjrZjqI2EjmTUTzQ=;
 b=Mvk0O6I/2CtdJRxq3fb3V0b+sxp4gvuwATw23V90K3NJz/qAn0Z20hb+yJ2qDBTSBI/XYrtLG4UWYsOfdP/JMNVb/MLam0XMhkhYGEZLRu8ngceFebdtt+A5/1WKUcSbpJjL9hSzMWnWtd6JsX37bLe9u4YT/tCkwxtjBwnSokA=
Received: from AS8PR04CA0157.eurprd04.prod.outlook.com (2603:10a6:20b:331::12)
 by AS4PR08MB7454.eurprd08.prod.outlook.com (2603:10a6:20b:4e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.11; Tue, 8 Nov
 2022 17:33:18 +0000
Received: from VI1EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:331:cafe::4d) by AS8PR04CA0157.outlook.office365.com
 (2603:10a6:20b:331::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.21 via Frontend
 Transport; Tue, 8 Nov 2022 17:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT027.mail.protection.outlook.com (100.127.144.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Tue, 8 Nov 2022 17:33:17 +0000
Received: ("Tessian outbound 0800d254cb3b:v130"); Tue, 08 Nov 2022 17:33:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 67f083d39a647330
X-CR-MTA-TID: 64aa7808
Received: from bcc23d4f2371.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F8DAA156-120E-4C27-99D2-545C67CA1C42.1;
        Tue, 08 Nov 2022 17:33:11 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bcc23d4f2371.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Nov 2022 17:33:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm3HWUXY5Pu46Ew/dz76qYHRKrxRH7vQRjoPptCqiNmEcX7oS6zlZGh6/zX8hj9AstLeH3P9D8jGQy8ePjKn/c8PnecYKt/gz7py4ToEz/kIFzli9RLOy0tKbM3/JEAZtCNwK/748oIxgQvFjFTvNg6xbc1giBUeTGPhE7hope8kP/+r0v9Sr9shRXNeY1pa64ZMJNBZ06YGWEaoLsVwDZ9rYTbC3zfNZs8+uFJyRBlcaFbx4Sux5zaw0DBbkEoK/kZa1GXpQLv1SKlpj4gTdDFeJk4pRdFqT+zCpWxMuQDepnxlB3tKIZ35Fc7iRDXjYkcr77Ngel5J3oPe3Z8+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPJiZy9XZ9EM7S3THpQEF25ezDVwjrZjqI2EjmTUTzQ=;
 b=TIMP5oUdyheul+vxWsXzKgesIvPmcDZVmythWpRtrSpujZrwdry8YkqrHyNRRyC8FAyVHxP0qJaVkFw5QtYYVb6hO2x5rtvLZmicCWNOzkd6mmVO8viv/jmo6c9/FMkvKYvSe4apRf6TgumX2I/z5iUSN9Can+1ZnHWRq3jMBpoXrEmSTTilDsZKiCBdy8gEbxiEeve4Q3JQ5lQ+50bv8rEk7PTxrzJsjw1n/wkalcpuLfF137etJMfY740iFASBhkURwgTS6g6/xd+xUA1nAxWUvAbFyIpTRCl67fVxeZYQALYL900+8UnTyqb2WWrt9dKiGsj+t38zvzfPhbo/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPJiZy9XZ9EM7S3THpQEF25ezDVwjrZjqI2EjmTUTzQ=;
 b=Mvk0O6I/2CtdJRxq3fb3V0b+sxp4gvuwATw23V90K3NJz/qAn0Z20hb+yJ2qDBTSBI/XYrtLG4UWYsOfdP/JMNVb/MLam0XMhkhYGEZLRu8ngceFebdtt+A5/1WKUcSbpJjL9hSzMWnWtd6JsX37bLe9u4YT/tCkwxtjBwnSokA=
Received: from AS8P250CA0025.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::30)
 by AM9PR08MB5938.eurprd08.prod.outlook.com (2603:10a6:20b:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Tue, 8 Nov
 2022 17:33:07 +0000
Received: from AM7EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:330:cafe::59) by AS8P250CA0025.outlook.office365.com
 (2603:10a6:20b:330::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Tue, 8 Nov 2022 17:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT014.mail.protection.outlook.com (100.127.140.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 17:33:07 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Tue, 8 Nov
 2022 17:33:05 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 8 Nov 2022 17:33:04 +0000
Date:   Tue, 8 Nov 2022 17:33:03 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Szabolcs Nagy" <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "Topi Miettinen" <toiwoton@gmail.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-abi-devel@lists.sourceforge.net>, <nd@arm.com>,
        <shuah@kernel.org>
Subject: Re: [PATCH v1 2/2] kselftest: vm: add tests for
 memory-deny-write-execute
Message-ID: <20221108173303.GA53007@e124191.cambridge.arm.com>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-3-joey.gouly@arm.com>
 <Y1wLVsg8VN26xI7j@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1wLVsg8VN26xI7j@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT014:EE_|AM9PR08MB5938:EE_|VI1EUR03FT027:EE_|AS4PR08MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: c96da9d4-aa1b-4b2e-73bf-08dac1af52d5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: iRTz7SitbSfkRovoK2RKHIO6hT+METaTkMIcSRHC/FXYneBlo/XAN3Ah2AL74/gL4S72PBVQKSNNYLCdjjgxNNh/B9F8XNBaTrvpdaFD9RhSptrQYT4ytrR1Nrc9+46RfAMKxpNGKFo0dRmY6PtDfCF3sssT6ffnkYMcNrrW2uyy/NdPsQ35DyN4rRXwHq9w/hfXUf/JXLU5YnnlJFdqt9Nq0DSrB7u7nHv5vf4/ufDIlg/hTM+putUnnQ+xv0TbryGawabNVrKJUmg1mq85st+LG4D9ig2DdBAXe+f1X2reKHrkmoMl7ELWRJ7vofIj7sLxsUtc4i2Djli/qxfrqF+qE43v6repGYik9dN5Gc4lnxiG9klas1DSYtmOJXapetD6sxdgLya5bbVXWks22kN5g+Ld3bcjL+tCO536hneF8ElPNCatjvVB5hL/5p/8d5H3S8ASvBLqswu7A8DmK6u7pHTyWfB1vVHfor1qj4nNM06vm1P/Brw4keqFC2XP4/UvIEA54QHuBhjdhOsjj8iPCKHwXNSLvdiUtt7hogdgNEIr/zJxTtVlO6M8ZVgmHznydwfsDXDCJXE/K8rKft9nBcPJYGZ8gGk0ThZ4RISg5KXzmCg5QslTzwOZbL929bYvpgNXshJx6jqkMZcaotjGwRR3/Rv35PDjg+lcDJnSm+IxD3/1t/hRh6jaJvEFfIIpQB6bjw5NajZbtfdSPYceKeiVD5Ypb/eaFm6FW2FmzdNfWgPSDDJYzNzKp94P3vIXxv+AbgQMWHRs8/uz8Dl3rxNv37+pKJtrOk2dot1lVhAJMZosAwtaZVYEz6Fu7169rcmTLqGcIixAIWmDYg==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(356005)(82310400005)(82740400003)(81166007)(36860700001)(54906003)(6916009)(316002)(83380400001)(55016003)(40480700001)(2906002)(41300700001)(33656002)(966005)(336012)(86362001)(8676002)(4326008)(186003)(70586007)(70206006)(1076003)(8936002)(40460700003)(7696005)(26005)(7416002)(5660300002)(426003)(478600001)(47076005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5938
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3fe6a9bc-3580-47d3-f226-08dac1af4c7f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8DPizZRkCYHxc4JpsPK9FYpRKLTS+RJfh9xxlms/yVRySeF2lWhGW1/82HZ7O0KNqG4edRiI/PP8CXxEVyPhYRFiU0O74f9rh4aVJO0jJ/0LtT+PQwW2fjiQRXRMJk55/STGlykz0z0s4EU1slhIqiBtMVDeTypWKQx2WK56BzhjPimq7MZx9ZykzKQj8GfN0POXFyOmzAcFq2g2kORtnr8+oZQWnJJBwPRRGd3imVI67kSphKCzqrwn1dO7gNiEtYrkp2wHFlsnMhTF8+eKKbntPX8/eVRxEpWvxo3hYuFUNUxcA0uJUbl+kzBKfAqE46yYSBd+wfo7PfqIbeCivJnkfuoiDOTVwCMOvC8VFVkKfD6Z8T/+MbL+4zoG1uEQtIGudEbmVGEix8Tl/3lv6JeInWaF21J7DKPgNppAeIex1HhuXN7PneVfq+7mevkv3RNhc3/3BmFC4vz3W1hKhj2bGJO1M3j6mKEX75LN6evCwAJ/dCLQluo3irPhCLT9r7ykuJPmfmvyUMIvikhHIjjxkg2HGpwZ++yX4VJuXvfp9dOYQgkqHtnngtW8ro6qfMKyrMhmpJR8rfsB5ocoP0declAhtVIMN1Z3cNbvtjX1LUxk4uBeLKkP2fl3mXhGp3aIjpnL/byHEyKKzD3cTKGVMJv94poWjX3+KeacwY0+27seEFHrSUuagvenb6ursvJtxXj6e+4XvQHY+FMXCehwVzpEnDo6qMqTZRYZBy058tdOd9Od88UEGO5UipJOfcmSALnJGPqCjZxb+VZoFAlwe3UXV9DjK3LlvQkJSPciSvgPCmjZmGIAKSIJU7a
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(336012)(2906002)(8936002)(4326008)(6862004)(316002)(44832011)(8676002)(478600001)(70586007)(70206006)(81166007)(966005)(83380400001)(40480700001)(33656002)(41300700001)(5660300002)(186003)(36860700001)(55016003)(7696005)(82740400003)(86362001)(47076005)(426003)(40460700003)(1076003)(26005)(54906003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:33:17.8410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96da9d4-aa1b-4b2e-73bf-08dac1af52d5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7454
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 28, 2022 at 06:03:18PM +0100, Mark Brown wrote:
> On Wed, Oct 26, 2022 at 04:04:57PM +0100, Joey Gouly wrote:
> 
> > Add some tests to cover the new PR_SET_MDWE prctl.
> 
> Some comments below but they're all stylistic and let's not make perfect
> be the enemy of the good here so
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks for the review, however I won't keep your R-b tag because I'm going to
move forward with Kees' approach from:

https://lore.kernel.org/linux-arm-kernel/202210281314.C5D3414722@keescook/T/#m45ac9de6c205b560d072a65e4e67e2a7ee363588

Thanks to Kees for rewriting that.

> 
> and we can iterate later rather than blocking anything on the testcase.
> 
> > +#ifdef __aarch64__
> > +#define PROT_BTI      0x10            /* BTI guarded page */
> > +#endif
> 
> We should get this from the kernel headers shouldn't we?  We generally
> rely on things getting pulled in from there rather than locally
> defining.

I believe the mman.h included is from the toolchain, not the kernel's uapi headers.
The toolchain I was using didn't have PROT_BTI defined in its mman.h

> 
> > +#define TEST1 "mmap(PROT_WRITE | PROT_EXEC)\n"
> > +#define TEST2 "mmap(PROT_WRITE); mprotect(PROT_EXEC)\n"
> > +#define TEST3 "mmap(PROT_EXEC); mprotect(PROT_EXEC | PROT_READ)\n"
> > +#define TEST4 "mmap(PROT_EXEC); mprotect(PROT_EXEC | PROT_BTI)\n"
> 
> > +int test1(int mdwe_enabled)
> > +{
> 
> It feels like we could usefully make an array of
> 
> 	struct test {
> 		int (*run)(bool mdwe_enabled);
> 		char *name;
> 	}
> 
> then we'd need fewer ifdefs, things could be more usefully named and
> it'd be a bit easier to add new cases.
> 
> > +#ifdef __aarch64__
> > +	ksft_set_plan(12);
> > +#else
> > +	ksft_set_plan(9);
> > +#endif
> 
> That'd just be ksft_test_plan(3 * ARRAY_SIZE(tests).
> 
> > +	// First run the tests without MDWE
> > +	test_result(test1(0), TEST1);
> > +	test_result(test2(0), TEST2);
> > +	test_result(test3(0), TEST3);
> > +#ifdef __aarch64__
> > +	test_result(test4(0), TEST4);
> > +#endif
> 
> and these calls to the tests would all be iterating over the array.

These comments are solved by the kselftest_harness approach that Kees suggested.

Thanks,
Joey
