Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD863DAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiK3Quu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiK3Qus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:50:48 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E016F31DE8;
        Wed, 30 Nov 2022 08:50:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPF+ARlNn6y1/l/21gCTLajeMHxEZcYgTUW0NfA/amScYWXagwz8JQebQedN9kznBYsWkUzvjWK/+CHljSCKA9kKYpdGulu/ZhUKNCr/BJmlHtoXeJ3e1iQKuQsNcS1lnO7MoQ7o7lk4Zg39UHjo9HPZS4JlXQqlW/YZg/3Xt75e7m/9qdvfgMVZm/R54nrGV5yN87uDEwMtRYFCFh//EIAYdZHyM6OgYM5gaKES4iDiUGgBcDYHabX4lhyeoENYrPKX4slq+Gftf7W37exWx3D6L4U/FKP4OEULexyEaFUSe6XL64Npt381zl427XbD2mmb+evdj2teD8skvbWMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaR0D5Lmu182qUMH+wrzGWdkXiMs1XNcVXEUDeHzwPY=;
 b=GI1HOCT4yKgoEvb7lUXsosTlo3UyBY20EMpWiM2QXBewY+3V8gWEViz3G4ZB2Zr4NSRUXP+Nsna7igacnSXuZYRjE9lteX/1+0oYrk7EDBLFBcVmoKk7lhId4I+gEUMu6A//k+IrNOdCO/us0GRBPphOWZHHjb/RA4cIvhWHsMByI6TOJwUn6HPzRdbYUhDc58oFrLSbTkxGdjXTNK+Pclmse/gSpOewPN7bLg+uw6RXk12fhzejqrkxB8EjJhoR/PnKhSC4ciKu1VL2zt/etSAzfJ3GkEP/JKIpXqGodSbaJDtd9Ls13/geo+4bIs6rgWSdmHETwzKg7RVdzVXU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ti.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaR0D5Lmu182qUMH+wrzGWdkXiMs1XNcVXEUDeHzwPY=;
 b=aT9Ry58c8M2p0KkKxs/TdW2P2NjMzjU4kTKIovjMZ27TNwmT8AAsu60/WtCBpLu8BghA1nyBp5XMH3Ld2eqziaeiB1WQt34B71PZr9fOKlsbSSPKh9eAEWPT7p9vhSgmmD0eRAHG+u83fgYlvxa378ei0pw0AvK03QbTnfnDQRU=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.6; Wed, 30 Nov 2022 16:50:45 +0000
Received: from DS1PEPF0000E64C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::8b) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 16:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64C.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 30 Nov 2022 16:50:45 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 10:50:39 -0600
Message-ID: <74ac528d-fbc7-9fbe-d44b-23f5579d54a1@amd.com>
Date:   Wed, 30 Nov 2022 17:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 6/7] arm64: dts: xilinx: Rename DTB overlay source
 files from .dts to .dtso
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221024173434.32518-1-afd@ti.com>
 <20221024173434.32518-7-afd@ti.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20221024173434.32518-7-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64C:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 753e2e19-27c4-4c4d-7c5b-08dad2f306b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5Vtz2XfTdzyzRvPd9gVSXwpY0YDSkHCFRN56NfWmBI0UJE50Yfny+8UGTK4k2xjsgwIBtEvuSbDvKtM7uSbUVhMgSNntlsRLGGQGd23MjtBKTIbzFEGyBJYOg0qZsszNeTaI8OBKMLZq8eqG6BeogH45+QtGGxo2yThc6FJfEHTfPOuR54r4lLx3BNDDVS9H5VwZWareVW2y9x8FY76Rfll2a0nXqxNwQIYQarkTIoZKrWm0hD2Ypuyy/jsnh81iRCyd8nKKfayFsGhwddQZOvi9Y3ZtsIyAbMU9eFiOr86ZGqpy25IDvSUnEnWG8B3SAfG5xfyaD2Z3jvncleIjKVAqQzsO3fblYRzoPvKBJxMxOtcVGMDzwbadXVHhxaeSYjw2l2YdstI7+Kf21SXV6sxsQ20jRT5t9dQDDF0Fz1OcNtnbOIQSh/xZuzmV50VcKwzqscn1RdHyUTBYJouWSycaLiTZTyiPgkUjSoK9Gph6gChAMvRDqnZIUfJtVY0C7b4nPMs7+p/vd5p61CbKXzUKpi8Pe7B7DQzrb40CsP9ApbDn9tSYWSoigFuCqLFujCRexKLJXzlWWxDzT3Fqc589ocXvcxtJVb1tXPYKnceNfxwe3ql0ukAQkRj7MoPYhc9FU76mNrzAJUJM5pb5S2SgxjuWCqY9DxBhU33pOxrTXOc0uRYjhisf1GFCDi6kwXsp6Vm8iHsJ73CgNeiVc0aE+RVvRpl5dn1ZDJ/bZsAk5Y3chJtr4my1SlMEmRvZ8NEVpIO9s2YU6RZb7OYXpJZpuFGCDwgS2Zab0rZsfs4iX5Lm6W2f2subdrKOQZF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(110136005)(44832011)(31686004)(70586007)(8936002)(16576012)(5660300002)(41300700001)(7416002)(70206006)(8676002)(316002)(54906003)(4326008)(82310400005)(36756003)(53546011)(921005)(81166007)(82740400003)(356005)(40480700001)(47076005)(336012)(426003)(16526019)(478600001)(2616005)(26005)(31696002)(186003)(36860700001)(86362001)(40460700003)(83380400001)(142923001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 16:50:45.7073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753e2e19-27c4-4c4d-7c5b-08dad2f306b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/22 19:34, Andrew Davis wrote:
> DTB Overlays (.dtbo) can now be built from source files with the
> extension (.dtso). This makes it clear what is the content of the files
> and differentiates them from base DTB source files.
> 
> Convert the DTB overlay source files in the arm64/xilinx directory.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   .../{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso}       | 0
>   .../{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso}       | 0
>   2 files changed, 0 insertions(+), 0 deletions(-)
>   rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
>   rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> similarity index 100%
> rename from arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
> rename to arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> similarity index 100%
> rename from arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
> rename to arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso

Applied.
M
