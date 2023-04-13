Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047356E0363
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDMAv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDMAv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:51:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04655768D;
        Wed, 12 Apr 2023 17:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJjmLT4C4c/996swhLDsPKF73MuVXzYDA5TAL58djn/kGYsCLWj/aeNfVS10imqulnuyP0E7pSWZALokI/fopLPkZlmeBxiSYqHfFh9tLrhWgqF+ygTrl7oTKnPuEmb3B+LgQ//X8ZHwsSFJ4iEXoWEAJq3Ja/zX8N7Qh4gr7Swijl9d1YsAzsC0mLWEMc6SIZQPCMpWt/4yHlZfvRX5DlezlTeIbqrDQV4xGsF6HCwf0GKhFHi9mmvarqx/CbqKVdXuNsA9iUyrLRW257HUqC0w/HNA0CjgZgEUUVvkazIFk38gppUhvraZxVrIgDOki2/kBFqlnhWrI89uSyF/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MLusmjcGjP+39M7KJ7m84BNI+8wxd1cRnzSmqWvnhg=;
 b=Kxf4Z+wF+QKroYnybeOk+HECFCvCFMZQwAlPKWTGSybTED0jQrBt5JR1wnJmBag1D+MDfSwUE/adEm/LLKwhovLDTjBFqvbljA7xCUH4D+o59S+MUrb//00rdtoumcBDmuz6gIFpAcku6K7ZV6RShakv/1C/T7+D56g1Q4GWZPO3Kt1R0HTQFIf3O+7fyBy/4QxtFbwoSVfZjFKTRj/tbdENd64U0R/Ntpyh1iHanYqK1pgAOVtkJa8miUTdGaV/rU+/pQTL8E8SNwIizilMITBqaEawrkAVku3WoWn7vKr21QS7uJQ/IWrk169e6d3pvmgZhnpKzx6y3qAOz5M5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MLusmjcGjP+39M7KJ7m84BNI+8wxd1cRnzSmqWvnhg=;
 b=f1cVRKGcDuG/RCuZ1UA8+sBmH2L6q9sBldc2eAsvhvN8y+fvoBBm6K8pC0/O0AI1Qu61JE2/52kHbpfZzcrDrodvikWz2NBt7kcxlpGfzkxvNnITiGedDoRrNpt/rr7UTmiimWD1nVEuozojjEuMfgUJHUOevBnZatC31wTY8gI=
Received: from BN0PR04CA0142.namprd04.prod.outlook.com (2603:10b6:408:ed::27)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 00:51:51 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::33) by BN0PR04CA0142.outlook.office365.com
 (2603:10b6:408:ed::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Thu, 13 Apr 2023 00:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Thu, 13 Apr 2023 00:51:50 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 12 Apr 2023 19:51:47 -0500
From:   Brad Larson <blarson@amd.com>
To:     <robh@kernel.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <samuel@sholland.org>,
        <skhan@linuxfoundation.org>, <suravee.suthikulpanit@amd.com>,
        <thomas.lendacky@amd.com>, <tonyhuang.sunplus@gmail.com>,
        <ulf.hansson@linaro.org>, <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v13 08/15] arm64: dts: Add AMD Pensando Elba SoC support
Date:   Wed, 12 Apr 2023 17:51:41 -0700
Message-ID: <20230413005141.24632-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411135518.GA2952600-robh@kernel.org>
References: <20230411135518.GA2952600-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a00faa-67d1-4710-38b0-08db3bb9447b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUtr4RKa16428CXi34Gxrs+UUBSXBc6rUFTdJKXGFs3GuurKi5+YJ3jqjgNolVIaFlLLNLLjWdWusm9fEdypN0D6JpQsk2xNC920yagdus6hTNdT4l9KKFQA8dz+eGaxuSRnQkPVyobAFoj/8RC7xtftS/zC/2PsWrDW8E4JxZ8OEdKHMVN9p4vPtkKWz3lpRw357Q8WV9pAFl1pTru4lE0my1dFFLFtpZIazXIiHyPxqfeL1nLtD1WtQM4I/QbB/2HOJ+ElKLOjYXn5kNZ5kc9lPcpowW+LJnGCqFrt+lBRFqqLKiSnveJQIdn9n7uUkIyUZbzv1TtmGKIHi7QOW5iIDgFgK+7LXtq5xo/Wou3x79uce4RlBTWu2T/EFPavg/wT2JeSS9xPMBJMnP45pQpjdQDLIMTNMVCE9icP1HpGvpKl3vjIQ0pXdyod6JHZkXsHRRBfw+9mHeWBM6QBaip345hRGfWAjgTH2n7nVKkgmGhHIjJPalkE6tOHpEOaD2H/kaEHFYZog1fanmVfFdTSHRq0UIKixuuZHlNbDcnpKKCfFp0QPYd3zmRtNplwRY7fV0r63SPe4RgUX09Df2b1hw5Psk7j459YdLj7+3mpyC1f2Ml4d2+2NqJVWlOFCtiE+JGCu/G9PL+2LFCK8E328/mnGv2WxCJGjGqr5QADuAvYYTqgtb/xi94+j/68hFhGnZEYo9a9OlhA6UMUUSTPRqtdoEez16AIKydcZZA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(6916009)(316002)(81166007)(26005)(82740400003)(186003)(53546011)(1076003)(6666004)(83380400001)(36860700001)(2616005)(47076005)(426003)(336012)(16526019)(8936002)(82310400005)(7416002)(5660300002)(7406005)(36756003)(2906002)(41300700001)(8676002)(40460700003)(356005)(478600001)(40480700001)(54906003)(70586007)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 00:51:50.6503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a00faa-67d1-4710-38b0-08db3bb9447b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Apr 11, 2023 at 08:55:18, Rob Herring wrote:
> On Mon, Apr 10, 2023 at 11:45:19AM -0700, Brad Larson wrote:
>> Add AMD Pensando common and Elba SoC specific device nodes
>> 
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>> 
>> v11 changes:
>> - Delete reset-names
>> - Fix spi0 compatible to be specific 'amd,pensando-elba-ctrl'
>> 
>> v9 changes:
>> - Single node for spi0 system-controller and squash
>>   the reset-controller child into parent
>
> Have you run this thru 'make dtbs_check'? I see at least one issue that 
> should report.

Yes and no warnings or errors with these checks 

make ARCH=arm64 dtbs_check
make DT_CHECKER_FLAGS=-m dt_binding_check 

but I did find a couple relevant packages have been updated

dtschema Version: 2023.1  ==> 2023.4
yamllint Version: 1.26.3  ==> 1.30.0

and then running again I get below 

$ make ARCH=arm64 dtbs_check 
...
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache0: 'cache-level' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache0: 'cache-level' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache0: 'cache-unified' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache1: 'cache-level' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache1: 'cache-level' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache1: 'cache-unified' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache2: 'cache-level' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache2: 'cache-level' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache2: 'cache-unified' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache3: 'cache-level' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache3: 'cache-level' is a required property
/home/brad/linux.v13/arch/arm64/boot/dts/amd/elba-asic.dtb: l2-cache3: 'cache-unified' is a required property

I'll fix this in the next spin.

Regards,
Brad
