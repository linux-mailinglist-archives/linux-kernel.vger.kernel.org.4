Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC162415F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiKJL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiKJL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:27:31 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44BA70550
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:27:29 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mq/8O/0D/7CMHibiKOkTHbQnGYEN2X4HyUa+KQ7fwm1yuX1djXXKmJjvEiqpiHG32dx+dteeniBHWWZ51+K6Fu0rNIowuAQrJoDfzSUJXtZo5OhkU2LATbRSviITBzpZ5oc1KeND8ijHKB/PseEq0Fh0H9xu8D92C/E/4ndhCyHoe8pqSmVJzaxVtE5S1HDuEEPB2dlrWf9OWmXPlu0cgetidUqH81NwpLQsh356fws02uj46uMEGnOy6WaBBfrHjffQ1ZOsMigygpy9IE6rYWpq3Yz+4g3NZkwpu+FmvG0qc2Ef7Gv2RcCvRMlA4sc7vw7EM+li1w/o9SU+UH7KVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAY6bTKEHy6E0jFBr1GmEPR2eW12htYF2xzXRchbCnE=;
 b=G6QZ6b7HrdFrAW2B37x09seyqwwLw5UJg68J8g9DyJ/Ag29g0QqMG0N6r6zJJoSDIO4dYf+PDxtCZO7CURBjwieQshPV8cd5KbpXGIpmoLfgSTJw/gUGBwyF0SRygZOmpu5WwDY7Abr12tSlHDopcVPTNz0WdmYfhTiftzgoRrrykzcAeM1/3D0D6nAqK+FGcsM6NxSn/4k9K1Tt3FdoqjGVWanGuqAVTdp9A3/j/6NCPqxh3bq3y3rLR8R9egjAvSreBiobXQnFNxqdXQUEcXcy+QGjrdEWJ99Go1VFPGVB7zCalhCtMnsg1VabPnVTjBkoRPzsHGxE3PCETo2vvw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAY6bTKEHy6E0jFBr1GmEPR2eW12htYF2xzXRchbCnE=;
 b=UAY3ohk3rLdPeCOCzrqlh6Xk/13MKQbFuTbQt2YKsn21YqWIadGtmzVtnXTG8oAuqF3AVmNoAolqWY3hcZR16AF1drA/jEFtHVijEoZQY878rp1zC2KF0BP0IlMeNzzU0xGA5OAsdn6qrpqPAN4ImP8IBASXIxuJbWWSrO3TAJs=
Received: from AS9PR06CA0208.eurprd06.prod.outlook.com (2603:10a6:20b:45d::23)
 by AS2PR08MB9415.eurprd08.prod.outlook.com (2603:10a6:20b:595::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.11; Thu, 10 Nov
 2022 11:27:26 +0000
Received: from AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45d:cafe::90) by AS9PR06CA0208.outlook.office365.com
 (2603:10a6:20b:45d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Thu, 10 Nov 2022 11:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT042.mail.protection.outlook.com (100.127.140.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 11:27:26 +0000
Received: ("Tessian outbound f394866f3f2b:v130"); Thu, 10 Nov 2022 11:27:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 31081a39acac836d
X-CR-MTA-TID: 64aa7808
Received: from 2e37aa3daea7.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D157C998-6C6E-4D49-B8D4-6846751CF33A.1;
        Thu, 10 Nov 2022 11:27:18 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2e37aa3daea7.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 10 Nov 2022 11:27:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1K/wsANYCnoQoBYLM49+4Nz6oJUqMhkcFYIFSWesJNPZ9A/z6BZ8NjQJYv4KoA5W7r7J0ZJonFzbgJXFeBpFw+F7Xo1JzunPNf6MLsEGFtAOYJiaIavrqCHEI85k+z0SBDcpbjTtiApHbK63gtotrEue8OOko2W80NhzJKFuMmTGg76C1HwH8+1EZRU4Ahftzb04o2zdDXsj9BeVe6egKVCChak6Qne/Yg4nv/MrVPcdM4mP3YWHJV9ZFR4sfQ3kQuEF7vIkZQmubOTD1mI8G4/nci2FDphCDKnG7e5cpp2ySh/o1uorngOWBD2ICixc3J7MmeAI45skWkcE4B+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAY6bTKEHy6E0jFBr1GmEPR2eW12htYF2xzXRchbCnE=;
 b=MWJpZYP9yhrKC787GIePpEwET+5BT9nFahz97afGzClX4g+VCVajeM995D8K5sEPx0mdgA+Fh3m7HCGWWbWBkgr1MTsF29zypIVwHmTM1r7sP8aCLP8u6jR92MxwUEQmXvczexRFsmhuUqplnNyVTuYSs1uqSswMhsVdz29oN2XAJVZpLWZXxk6tyivH10lJpR9eJVmN1FxoVQm9y67GN6z0bgcbrPtvlKhLB0Lh8l7KQuzcUBMIamUcrCOLhdi413Egkqny4Z1j5SKhUZdYv/scEfLrZAZoNcrQFzIczdBdtXxPKuq91aB8zogtswydAsCq8lCHKipVrZSncLs8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=chromium.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAY6bTKEHy6E0jFBr1GmEPR2eW12htYF2xzXRchbCnE=;
 b=UAY3ohk3rLdPeCOCzrqlh6Xk/13MKQbFuTbQt2YKsn21YqWIadGtmzVtnXTG8oAuqF3AVmNoAolqWY3hcZR16AF1drA/jEFtHVijEoZQY878rp1zC2KF0BP0IlMeNzzU0xGA5OAsdn6qrpqPAN4ImP8IBASXIxuJbWWSrO3TAJs=
Received: from DB7PR02CA0033.eurprd02.prod.outlook.com (2603:10a6:10:52::46)
 by DB9PR08MB7493.eurprd08.prod.outlook.com (2603:10a6:10:36e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 11:27:16 +0000
Received: from DBAEUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::22) by DB7PR02CA0033.outlook.office365.com
 (2603:10a6:10:52::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Thu, 10 Nov 2022 11:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT024.mail.protection.outlook.com (100.127.142.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 11:27:16 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Thu, 10 Nov
 2022 11:27:16 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Thu, 10 Nov
 2022 11:27:15 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 10 Nov 2022 11:27:15 +0000
Date:   Thu, 10 Nov 2022 11:27:14 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "Topi Miettinen" <toiwoton@gmail.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-abi-devel@lists.sourceforge.net>, <nd@arm.com>,
        <shuah@kernel.org>
Subject: Re: [PATCH v1 1/2] mm: Implement memory-deny-write-execute as a prctl
Message-ID: <20221110112714.GA1201@e124191.cambridge.arm.com>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-2-joey.gouly@arm.com>
 <202210281053.904BE2F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202210281053.904BE2F@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT024:EE_|DB9PR08MB7493:EE_|AM7EUR03FT042:EE_|AS2PR08MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 63427080-ac69-4ff7-0d43-08dac30e8b6a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2YB0KO879c3f20HFE+k/Z/8truzMEZaGio8Zk7GsJKQTN/bKTaf+9bly/dyymZr7e64gxKPxwPSMY5HzNcsbEZHYxxymRxnfR0xYg7b3U9mI1O4U6/zTntkd9JjrKLAOs2Gecmz+ZCIq3nBwrDNW58HMk8bO9u70BTjg8LEzuVd8yIq51NQxXYIi+PBphLZkZPBKj3mrnk+Vp2boZK8Z62Swl1e9syAgSUhxr30226/TLMrla1DGyzmuV3zvl2nrKdG/6uokc1/X4fCglHZI2YN4N74OZp/5GLpEl4VwgTS8DTS1ObEHQfNdqylfUM3ZlHhXPkAs9ZBdQ4npVDH4Y9QnjFvtaL3xvmKrNBZFMJtmci6RxCjmMjnj/Xq81De1EMpNHnFlgNjSfpF6lPnoP/bWXpiwZJN7zhjPAUpsXN0lxDnmoibzwL8nJVtsxny9TEcC55L1TgcnFU3MgEL5vwrU/H90IxiLLwohFn77P+AAqXQSGSzLPE8ouuJdoELf3X4mo3xcCcpokqPXUIXnRFkhgYoQU+i5dveoKlN3NE70FWXeUEaUPJsdQ5B0bOYiS4prz/0fJtFhpnuFxAQDImrJ2ys579XjdKrW0JVNnABP74us3bfKiSYEATUFdMTgeKufy4MNctQaAwaDcKS47oXNJb+pd0zy4qiIcs2IjL4LiUJ2KD5opty7o4nH3RO1BxTL2DbY3BUHqUj0gtC5uZLWwD9yHfcrU7bREAI8BzJXhnpstSNLuqHDLVjCqrWEUcuc7Rbt0M4W8AVvFpJzmaD+XZsBOTu1UwqdTmXAJaU2fP7l5qfc3OTghzqaHKfnO8qumJUHrzXfqqOZukegm9PKpQmWiqx1sxkM/XW8ats=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(82310400005)(82740400003)(966005)(336012)(33656002)(2906002)(36860700001)(41300700001)(40480700001)(6916009)(44832011)(316002)(54906003)(86362001)(356005)(81166007)(7416002)(186003)(7696005)(70586007)(8676002)(70206006)(1076003)(40460700003)(83380400001)(4326008)(26005)(8936002)(47076005)(5660300002)(426003)(55016003)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7493
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9a034a19-abae-4250-3af4-08dac30e85a3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImiDuWWN9HtIUdEV7YdltbwvkRbF3C7t0vpH9rHhA+++8L+BaAa7MytlHXVpgH2oZXhRsH1/0PI+5fHjcMrhdViM/bZTOXLIMCefWRai1hS8fdHMvaQewSBE+42ygfUMoC83Raa+YnPS6Hg7IM8bStQH9XtrHuXxnpBf3eogh2C0pu3Yb9PBGH+XU0aLimKlA8BJMV8+PNqxNdTss68etNrAwfvDln8uZFwrOH+uYvJAM76bOd/uKvfH13NencYcyRRF/PzQEG8cidQmV8NsQfRQTUkIiWWW696R7uEfzLW/F8crv5/Jpjt3Q/Y5+KoZwgIoXZgGnGplNkeTtLlFt9VXp+5GByK0amTgyWS8ufcg2cgYZmpYeVEwTjBbo91GvLOiepwhiPWSOBZzSZyzsT+0w85K+nHkETS5jVgFCmDYOFkHDbnwFfmZMah2oUZ9LjAcoJa/4PZIAyrxjxOuSf93dJSKde0Dx5BLMo70I2YQs+doVbZOcOAonw4XdzMP19lv36dSogDvOqJ6kgvD7AfV+I4tiFbZRTkcC6FB+n5FMbyTwFA2aCg/lQ/svobk1/qccxg1xTEnUlgW1tFB4az7lkO/ntKOSFmhstiEtdq3yKwStHiF7VtamL+ErroJpxvjNVWHfPO8Cpti8DF6671gjtIwO9CFCyejLijo4ettFSFPMJPnjeP5L3w6T6uH9wrbrpougLf/qvzJsGf17YJ9QXj6dAXyUTy8zjHdvtzyAXUHix05HBIZB6as4eBH0gjbRu8OUbEaCrl62UWIiXnKIOY/yIVPpdhIrtmzBq0jW23XQ1qJ26RHqbGZfE8rq/5/W8uRZv014Rg5e023/Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(186003)(26005)(7696005)(1076003)(426003)(54906003)(336012)(40480700001)(47076005)(40460700003)(44832011)(82740400003)(2906002)(36860700001)(5660300002)(82310400005)(966005)(6862004)(4326008)(478600001)(70586007)(8936002)(55016003)(41300700001)(70206006)(316002)(8676002)(33656002)(86362001)(81166007)(17423001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 11:27:26.1506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63427080-ac69-4ff7-0d43-08dac30e8b6a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9415
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

On Fri, Oct 28, 2022 at 11:51:00AM -0700, Kees Cook wrote:
> On Wed, Oct 26, 2022 at 04:04:56PM +0100, Joey Gouly wrote:
> > The aim of such policy is to prevent a user task from creating an
> > executable mapping that is also writeable.
> > 
> > An example of mmap() returning -EACCESS if the policy is enabled:
> > 
> > 	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);
> > 
> > Similarly, mprotect() would return -EACCESS below:
> > 
> > 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> > 	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
> > 
> > The BPF filter that systemd MDWE uses is stateless, and disallows
> > mprotect() with PROT_EXEC completely. This new prctl allows PROT_EXEC to
> > be enabled if it was already PROT_EXEC, which allows the following case:
> > 
> > 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> > 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
> > 
> > where PROT_BTI enables branch tracking identification on arm64.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  include/linux/mman.h           | 15 +++++++++++++++
> >  include/linux/sched/coredump.h |  6 +++++-
> >  include/uapi/linux/prctl.h     |  6 ++++++
> >  kernel/sys.c                   | 18 ++++++++++++++++++
> >  mm/mmap.c                      |  3 +++
> >  mm/mprotect.c                  |  5 +++++
> >  6 files changed, 52 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > index 58b3abd457a3..d84fdeab6b5e 100644
> > --- a/include/linux/mman.h
> > +++ b/include/linux/mman.h
> > @@ -156,4 +156,19 @@ calc_vm_flag_bits(unsigned long flags)
> >  }
> >  
> >  unsigned long vm_commit_limit(void);
> > +
> > +static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
> 
> Traditionally, it is easier to write these in the positive instead of
> needing to parse a double-negative.
> 
> static inline bool allow_write_exec(...)

This doesn't feel like a double negative to me, and I think it would be better
to keep the name of the function similar to the name of the 'feature'.
However I'm not too fussed either way.

> 
> > +{
> > +	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
> > +		return false;
> > +
> > +	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
> > +		return true;
> > +
> > +	if (vma && !(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
> > +		return true;
> > +
> > +	return false;
> > +}
> 
> Since this is implementation "2" from the earlier discussion[1], I think
> some comments in here are good to have. (e.g. to explain to people
> reading this code why there is a vma test, etc.) Perhaps even explicit
> repeat the implementation expectations.
> 
> Restating from that thread:
> 
>   2. "is not already PROT_EXEC":
> 
>      a)	mmap(PROT_READ|PROT_WRITE|PROT_EXEC);	// fails
> 
>      b)	mmap(PROT_READ|PROT_EXEC);
> 	mprotect(PROT_READ|PROT_EXEC|PROT_BTI);	// passes
> 
>      c)	mmap(PROT_READ);
> 	mprotect(PROT_READ|PROT_EXEC);		// fails
> 
>      d)	mmap(PROT_READ|PROT_WRITE);
> 	mprotect(PROT_READ);
> 	mprotect(PROT_READ|PROT_EXEC);		// fails

Good idea, I will add a comment.

> 
> [1] https://lore.kernel.org/linux-arm-kernel/YmGjYYlcSVz38rOe@arm.com/
> 
> >  #endif /* _LINUX_MMAN_H */
> > diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> > index 8270ad7ae14c..0e17ae7fbfd3 100644
> > --- a/include/linux/sched/coredump.h
> > +++ b/include/linux/sched/coredump.h
> > @@ -81,9 +81,13 @@ static inline int get_dumpable(struct mm_struct *mm)
> >   * lifecycle of this mm, just for simplicity.
> >   */
> >  #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
> > +
> > +#define MMF_HAS_MDWE		28
> > +#define MMF_HAS_MDWE_MASK	(1 << MMF_HAS_MDWE)
> > +
> >  #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> >  
> >  #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> > -				 MMF_DISABLE_THP_MASK)
> > +				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
> 
> Good, yes, new "live forever" bit here. Perhaps bikeshedding over the
> name, see below.
> 
> >  
> >  #endif /* _LINUX_SCHED_COREDUMP_H */
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index a5e06dcbba13..ab9db1e86230 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -281,6 +281,12 @@ struct prctl_mm_map {
> >  # define PR_SME_VL_LEN_MASK		0xffff
> >  # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
> >  
> > +/* Memory deny write / execute */
> > +#define PR_SET_MDWE			65
> > +# define PR_MDWE_FLAG_MMAP		1
> > +
> > +#define PR_GET_MDWE			66
> > +
> >  #define PR_SET_VMA		0x53564d41
> >  # define PR_SET_VMA_ANON_NAME		0
> >  
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 5fd54bf0e886..08e1dd6d2533 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -2348,6 +2348,18 @@ static int prctl_set_vma(unsigned long opt, unsigned long start,
> >  }
> >  #endif /* CONFIG_ANON_VMA_NAME */
> >  
> > +static inline int prctl_set_mdwe(void)
> > +{
> > +	set_bit(MMF_HAS_MDWE, &current->mm->flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static inline int prctl_get_mdwe(void)
> > +{
> > +	return test_bit(MMF_HAS_MDWE, &current->mm->flags);
> > +}
> 
> These will need to change -- the aren't constructed for future expansion
> at all. At the very least, all the arguments need to passed to be
> checked that they are zero. e.g.:
> 
> int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
> 		   unsigned long arg4, unsigned long arg5)
> {
> 	if (arg3 || arg4 || arg5)
> 		return -EINVAL;
> 
> 	...
> 
> 	return 0;
> }
> 
> Otherwise, there's no way to add arguments in the future because old
> userspace may have been sending arbitrary junk on the stack, etc.
> 
> And regardless, I think we'll need some explicit flag bits here, since
> we can see there has been a long history of various other desired
> features that may end up living in here. For now, a single bit is fine.
> The intended behavior is the inability to _add_ PROT_EXEC to an existing
> vma, and to deny the creating of a W+X vma to begin with, so perhaps
> this bit can be named MDWE_FLAG_REFUSE_EXEC_GAIN?
> 
> Then the above "..." becomes:
> 
> 	if (bits & ~(MDWE_FLAG_REFUSE_EXEC_GAIN))
> 		return -EINVAL;
> 
> 	if (bits & MDWE_FLAG_REFUSE_EXEC_GAIN)
> 		set_bit(MMF_HAS_MDWE, &current->mm->flags);
> 	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
> 		return -EPERM; /* Cannot unset the flag */
> 
> And prctl_get_mdwe() becomes:
> 
> int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
> 		   unsigned long arg4, unsigned long arg5)
> {
> 	if (arg2 || arg3 || arg4 || arg5)
> 		return -EINVAL;
> 	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
> 		MDWE_FLAG_REFUSE_EXEC_GAIN : 0;
> }

Thanks, makes sense, I have incorporated those changes.

> 
> > +
> >  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> >  		unsigned long, arg4, unsigned long, arg5)
> >  {
> > @@ -2623,6 +2635,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> >  		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
> >  		break;
> >  #endif
> > +	case PR_SET_MDWE:
> > +		error = prctl_set_mdwe();
> > +		break;
> > +	case PR_GET_MDWE:
> > +		error = prctl_get_mdwe();
> > +		break;
> >  	case PR_SET_VMA:
> >  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
> >  		break;
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 099468aee4d8..42eaf6683216 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1409,6 +1409,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >  			vm_flags |= VM_NORESERVE;
> >  	}
> >  
> > +	if (map_deny_write_exec(NULL, vm_flags))
> > +		return -EACCES;
> > +
> 
> This seems like the wrong place to do the check -- that the vma argument
> is a hard-coded "NULL" is evidence that something is wrong. Shouldn't
> it live in mmap_region()? What happens with MAP_FIXED, when there is
> an underlying vma? i.e. an MAP_FIXED will, I think, bypass the intended
> check. For example, we had "c" above:
> 
>      c)	mmap(PROT_READ);
> 	mprotect(PROT_READ|PROT_EXEC);		// fails
> 
> But this would allow another case:
> 
>      e)	addr = mmap(..., PROT_READ, ...);
> 	mmap(addr, ..., PROT_READ | PROT_EXEC, MAP_FIXED, ...);	// passes

I can move the check into mmap_region() but it won't fix the MAP_FIXED
example that you showed here.

mmap_region() calls do_mas_munmap(..) which will unmap overlapping regions.
However the `vma` for the 'old' region is not kept around, and a new vma will
be allocated later on "vma = vm_area_alloc(mm);", and the vm_flags are just set
to what is passed into mmap_region(), so map_deny_write_exec(vma, vm_flags)
will just be as good as passing NULL.

It's possible to save the vm_flags from the region that is unmapped, but Catalin
suggested it might be better if that is part of a later extension, what do you
think? 

> 
> 
> >  	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
> >  	if (!IS_ERR_VALUE(addr) &&
> >  	    ((vm_flags & VM_LOCKED) ||
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 8d770855b591..af71ef0788fd 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -766,6 +766,11 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> >  			break;
> >  		}
> >  
> > +		if (map_deny_write_exec(vma, newflags)) {
> > +			error = -EACCES;
> > +			goto out;
> > +		}
> > +
> 
> This looks like the right place. Any rationale for why it's before
> arch_validate_flags()?o

No big justification, it's just after the VM_ACCESS_FLAGS check and is more generic
than the architecture specific checks.

> 
> >  		/* Allow architectures to sanity-check the new flags */
> >  		if (!arch_validate_flags(newflags)) {
> >  			error = -EINVAL;
> 
> -Kees

Thanks for the review and for the rewritten test, I have replaced my commit with
the one that you sent.

Joey
