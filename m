Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3345668CAC3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBFXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFXoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:44:21 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4357730280;
        Mon,  6 Feb 2023 15:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMak550wTBNKxiL9GWTMBKyxHqPUVSvlt8/jgyXTsCz3SBiGTrez8O09uG+pkfzzVXPLSMAqFyM0+39SLYPt2m4AtksA0E1sHgly3IpelFsZPEfEGrMLSjyHGY6Zq/dtlKr4seK05TRJjjLCaSFAtXhrBcH6ADV5EgOaLztwAWbQKQxzILZVRGY6LQdjsop2vS417N2LhOhj5i2tWXqYZ34z3rSlj/oYmmzV2sE9olClSbEWOxK3IPvNFLmuhaflwnpHANSZnYin0e+3549hhPBEN2oJbgfZFj9VhkXGucvMKYn+kjdaV5juvKxg/q64hBmEw/OXwT2woldJsinmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzFdPMRKX9yQjKNTSazPLdoIvWjpOzSgJQ2C5pPmox0=;
 b=by6R4h2MIaxZaurhwI6JwvMof7/n68ufmRWRJvOkVk7i9Cu9woUlEbgwfd3HQRv8UrXvdm17YSQZO/QsatdHuH9s0N9QsdLeUC/LDNH+2mFwomVTVoc8E9YLxhQVIBtBe5btsmjEhVKwC/ScydI3XkDBjVHswzmcn8tUkuanFWJkgQCQgKpI18+znUdgbSck6dSwjEMf29S8mG4QXk6bElbZgAJZE0vwJwuhQt0JVW4zvz7wE5D8dtkLQJ3M0ixWUHLMiDtecVvzAtva0+Ln93UgLQ659xSe8oUPiEvet3tnmSbWOqU68qgJ50iXUFtYeocskBO6ezChbVS956dDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzFdPMRKX9yQjKNTSazPLdoIvWjpOzSgJQ2C5pPmox0=;
 b=u7n19DaddQt1GIDUoZL7kJNquXDS2PofIUZwBiiEEZZ1ZZg7e0wfC1rWmy9ZiyDIID2H7mSCHNV6BKZXheCP74cdgkZF7I4/hLp+vVOBjcwNTr5vvWdu+e0Ag0i0/tNoTynNl8t36wvp3DUAhbzB3hV/Db3FZz68eeAr9T+YcjI=
Received: from BN9PR03CA0122.namprd03.prod.outlook.com (2603:10b6:408:fe::7)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 23:44:01 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::73) by BN9PR03CA0122.outlook.office365.com
 (2603:10b6:408:fe::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 23:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Mon, 6 Feb 2023 23:44:01 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 17:43:58 -0600
From:   Brad Larson <blarson@amd.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brad@pensando.io>, <brijeshkumar.singh@amd.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <p.yadav@ti.com>, <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh@kernel.org>, <samuel@sholland.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <ulf.hansson@linaro.org>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System Resource chip
Date:   Mon, 6 Feb 2023 15:43:51 -0800
Message-ID: <20230206234351.38278-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <039986bb-a3e0-2482-9853-30532df10ff8@linaro.org>
References: <039986bb-a3e0-2482-9853-30532df10ff8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: c5cd24f8-2620-488a-9d5a-08db089c0604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LURrUlgaeh4y0yaNsShyRArCsmFbc0ddc8T6LAwyf3pOTySHm+n3MlbBkCJZf/A/ztsWCbEY/J50elLeobHhlk0Fcmk0j6J9bjJoDKUr3ZumkeFjwdsdYldYB1ZvxBfakkL4rYBfot4LXI9OzTSgI/KuiLRxm4miTVHCpRFcx/XNeDZP1R8Y6Gh/Dmb87ag5Tb2aDyFfsm9kRKvBO2va9OglQUb6aTtbX1GyhtgmEyJJk3f/MDXqgElZ5ieGsyDCqUGpvPFhfNI0apGgZX+il/YE/c+Us0qgvF6I12jhzZtTyHAApwGNXSX/wNXHiyw5uCCn0ro79Vcn0FwA1CHuqkAkgK73ehTCOw2D1jzZOVoco69LM3336n2EikNlurF0MlPDpiuewAAU5KIoP0DAjz3Hjt6msOu7R27TkQGxTYDPopOQzef9c1Gb+m6YJO9Dtd8NhrrpSTlQNCLGcAfx7RaH2+vbdVUL9wGRePT/45Cw3d5LF2e9YXXHqI8uAuYYzNPy5sWeFZRRkZMHAXymmABGRyeex9ctKWSl/z2g5jvofORofWw/gEmWJNXyUaSe1vpqWQmnQXnAEazDiyYCygraVKCNPFNYYpvESm5i2i3w0fGmuckuq5kNxpMChrsuQjZkVSuMJUAOdKd02fIiaK/Z02V40UU6fe/REwFPdet4FNZRkCogxeP8wVuSRqgyUH6mBkO+6Q9S7JxUkmbEv1rujbHG2Ts6j5ZpTJbTGAHOVsVd0mWUBiGUXdZ2wT0gbTCnLLs3oPkyfJ8nXaNVgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(478600001)(2906002)(54906003)(36756003)(40480700001)(966005)(82740400003)(81166007)(8936002)(82310400005)(356005)(426003)(2616005)(47076005)(53546011)(336012)(4326008)(8676002)(6916009)(6666004)(83380400001)(70586007)(41300700001)(7416002)(5660300002)(316002)(70206006)(16526019)(1076003)(26005)(186003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 23:44:01.1161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cd24f8-2620-488a-9d5a-08db089c0604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 01/02/2023 10:57, Krzysztof Kozlowski wrote:
>On 30/01/2023 20:12, Brad Larson wrote:
...
>> This has been changed to one device and four chip selects. This binding error
>> is occuring for snps,dw-apb-ssi.yaml using reg for the chip selects.  Any
>> guidance on how to fix? 
>> 
>> $ make ARCH=arm64 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>   LINT    Documentation/devicetree/bindings
>>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>>   DTC_CHK arch/arm64/boot/dts/amd/elba-asic.dtb
>> /home/brad/linux.v10/arch/arm64/boot/dts/amd/elba-asic.dtb: spi@2800: system-controller@0:reg: [[0], [1], [2], [3]] is too long
>> 	From schema: /home/brad/linux.v10/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>
> Maybe this would work in snps,dw-apb-ssi for children:
>
> reg:
>   items:
>     minimum: 0
>     maximum: 3

With the above change here in snps,dw-apb-ssi.yaml:

  - if:
      properties:
        compatible:
          contains:
            const: amd,pensando-elba-spi
    then:
      properties:
        reg:
          items:
            minimum: 0
            maximum: 3
      required:
        - amd,pensando-elba-syscon
    else:
      properties:
        amd,pensando-elba-syscon: false

this is the result:

$ make ARCH=arm64 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK arch/arm64/boot/dts/amd/elba-asic.dtb
/home/brad/linux.v10/arch/arm64/boot/dts/amd/elba-asic.dtb: spi@2800: reg:0: [0, 10240, 0, 256] is too long
	From schema: /home/brad/linux.v10/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
/home/brad/linux.v10/arch/arm64/boot/dts/amd/elba-asic.dtb: spi@2800: system-controller@0:reg: [[0], [1], [2], [3]] is too long
	From schema: /home/brad/linux.v10/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

The binding snps,dw-apb-ssi.yaml has patternProperties defined this way:

patternProperties:
  "^.*@[0-9a-f]+$":
    type: object
    properties:
      reg:
        minimum: 0
        maximum: 3

- Removing patternProperties makes the error go away indicating an issue with minimum/maximum regex check
and the number of items in the reg property which shouldn't be related.

- Changing patternProperties to this makes the error go away.
patternProperties:
  "^.*@[0-9a-f]+$":
    type: object
    properties:
      reg:
        maxItems: 4

- Using spmi.yaml as a reference and changing patternProperties to the following:
patternProperties:
  "^.*@[0-9a-f]+$":
    type: object
    properties:
      reg:
        items:
          - maxItems: 4
            items:
              - minimum: 0
              - maximum: 3
    required:
      - reg

results in:

$ make ARCH=arm64 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
arch/arm64/Makefile:36: Detected assembler with broken .inst; disassembly will be unreliable
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
/home/brad/linux.v10/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml: patternProperties:^.*@[0-9a-f]+$:properties:reg:items: 'oneOf' conditional failed, one must be fixed:
	[{'maxItems': 4, 'items': [{'minimum': 0}, {'maximum': 3}]}] is not of type 'object'
	{'maxItems': 4, 'items': [{'minimum': 0}, {'maximum': 3}]} should not be valid under {'required': ['maxItems']}
		hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK arch/arm64/boot/dts/amd/elba-asic.dtb


- With this version for patternProperties, to retain minimum/maximum, the original error occurs:
patternProperties:
  "^.*@[0-9a-f]+$":
    type: object
    properties:
      reg:
        items:
          - minItems: 1
            items:
              - minimum: 0
              - maximum: 3
    required:
      - reg

$ make ARCH=arm64 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
arch/arm64/Makefile:36: Detected assembler with broken .inst; disassembly will be unreliable
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json

  DTC_CHK arch/arm64/boot/dts/amd/elba-asic.dtb
/home/brad/linux.v10/arch/arm64/boot/dts/amd/elba-asic.dtb: spi@2800: system-controller@0:reg: [[0], [1], [2], [3]] is too long
	From schema: /home/brad/linux.v10/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

Regards,
Brad
