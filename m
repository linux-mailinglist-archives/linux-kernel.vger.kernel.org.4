Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F49B6AD47B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCGCNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCGCNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:13:46 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD3037F11;
        Mon,  6 Mar 2023 18:13:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqizdIo9WyQB5GkVemCgOSpNOAlj9fD04ecmVhzlxzk6X3Cjpgk7nk14R2pwLxn1r3efNntHTTffBpOEkaQXeteUrbKOKbm22Ab8PZJq+iGDVkoNdJoPl1eAaMu4o+9v9nfC55Nnz8urAdH43fplcnOzl9nwRGsIldFXxi5VvjUOEu5MsH8gQbaMxf56xEOpR+1b1ZfJGaptZSBSTRgXqNWV/u6CT/vTfVoI/2tRJk/i8eXAcbVCjxEJDD/ZnDc2/Sp4btGw5wvW0XiSf1o3ZEbr8J11i34E+rMKQiSPIr67CM7jEYNexeKtlD7ZrxwDOa+8ohygzp19ci6E/YRiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhACSqdShteYAmPtktMj+6aIE+hFeya/kolO2okn5fE=;
 b=WWsqt9ydBuAYMkWr2v5TxfZnMW3TmEfC8xkz3NYrgzG8tAVwBHVWDCxQWORY823bpOQ8gwEhE9j4zEGKlzhfu6xqo3/p2uahZyAUNIjcSencLJ5yqvaGJYtWznZHmEI2+pCtuOB8Xs43XQPB6i04CVWKaCRvGxuxiZMnk1H8RBeSL6l2yqyPORjhefcGKP6IoulxD//ylvsrQjRIA7VS8phrUBApIe9Bl1KMZoYqX9Q7ZkkKiZDAffMOORfjUz2xIsDY6kgJgu9+wOG8RS7ES+ENsiDiKhTC5m5/6DqmrxJuJz1wgg4Pbwk0DFRUJwtY+sawPC+1UCJLDQ78+GXl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhACSqdShteYAmPtktMj+6aIE+hFeya/kolO2okn5fE=;
 b=q1Ge2X13MomEGNsEZ797vb0naJKD6fSIapL9pyeG0j2tP4t+qQ3yq3EFp6LGUxEWihDxFvIKMYeUT2QUWMgFfkxq2m8lUt1oJ3PfH3M3phJfhvReNNCOoMkI+zVbIgcTcVRyfAFQQ+KHtacYk+7AnRX0ZLnVm7LJGIj9DFqSWd8=
Received: from BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::6)
 by DM8PR12MB5463.namprd12.prod.outlook.com (2603:10b6:8:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 02:13:41 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::c2) by BN9P222CA0001.outlook.office365.com
 (2603:10b6:408:10c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 02:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 02:13:41 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Mar 2023 20:13:38 -0600
From:   Brad Larson <blarson@amd.com>
To:     <krzysztof.kozlowski@linaro.org>
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
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v10 03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Mon, 6 Mar 2023 18:13:30 -0800
Message-ID: <20230307021330.4208-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7dca5cec-5b7b-a3d6-e165-47a5fa26b73a@linaro.org>
References: <7dca5cec-5b7b-a3d6-e165-47a5fa26b73a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|DM8PR12MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 4563f417-e956-425b-a6bc-08db1eb19262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brlI/oNDYTVDYS+2egEY8c7fWuh+X3xjTfidLGt1lfJgvEQoNb3udiMNtac2S+Tt0/MPD/XGOcXOskkupy724mtqY43H4T645IdVyh5bdBEAnn3H6JzVXyvugzbB2ixvluwDJf26WFKhwAJbsVEQzCCeBXE6Xji0MXAwjYP6bx1qNQkJX8HlBowXE6MiXqFDNGo+O03NaBG99DaLBw2+tYUz9PN35LXNFEIFwTdExP+6VUg9VIC5jpxSz59+juiDDWizwKE5l1MLcLtZPkZM9fglZG0Z6rkD0Xa1OAXaABpAvWK8X1tCIF+ZFBzFtMN5xl/Dms9Grn1vObmGLwtpfWkVMhjXl7RkP4NBymOIx7ZkUoaAcTwKd5ljUenzuC6tfgLu8e9GT0Aqtkvz0+zpRnp/YwmXNVOWWqqCLYnySdYhTXNHXEWtbidr9g+SQ3/7qN9yLc00Xs+c2cc43aN4ZIxVZ0vLVN9HvO+TBywHSp1pKsvfgPfi3FJmHTQjVEWgEzf0Ir3gwomXMYLgsPAoR55xlyBss2roQrWz6f9b0lBVQ+2QEbYi8pKFCL9rio/dh9rSMmyHdZ5+lHsnLnXg0pZTL7XQwTsUC3vTarb/ED8V4cUSLrooPaAbNwnXnb6P0vkla8Q/FDEz3aM/hcUvHCE3tUnJnriPNngTAQWYu+h+yd63011rOyyFc5zj+f6rUrqr0yVA73DycOAgHc4HT2F+9F3VKCJtfkWtBbYOiNE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(36860700001)(356005)(81166007)(82740400003)(36756003)(40140700001)(7406005)(2906002)(5660300002)(4326008)(70206006)(70586007)(7416002)(6916009)(40480700001)(41300700001)(8676002)(8936002)(6666004)(82310400005)(47076005)(336012)(186003)(2616005)(26005)(53546011)(16526019)(83380400001)(40460700003)(426003)(54906003)(316002)(478600001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 02:13:41.6259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4563f417-e956-425b-a6bc-08db1eb19262
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 8:29, Krzysztof Kozlowski wrote:
> On 06/03/2023 05:07, Brad Larson wrote:
>> Document the cadence qspi controller compatible for AMD Pensando
>> Elba SoC boards.  The Elba qspi fifo size is 1024.
>> 
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>> 
>> v10 changes:
>> - Fix cdns,fifo-depth, only amd,pensando-elba-qspi is 1024 bytes
>> 
>> v9 changes:
>> - Add 1024 to cdns,fifo-depth property to resolve dtbs_check error
>> 
>> ---
>>  .../bindings/spi/cdns,qspi-nor.yaml           | 30 +++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> index 5c01db128be0..18e4bc04f091 100644
>> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> @@ -20,11 +20,39 @@ allOf:
>>        required:
>>          - power-domains
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - amd,pensando-elba-qspi
>> +    then:
>> +      properties:
>> +        cdns,fifo-depth:
>> +          enum: [ 128, 256, 1024 ]
>> +          default: 1024
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: amd,pensando-elba-qspi
>
> This does not make any sense. You have two ifs for the same.

That's an oops, only this is needed

+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-qspi
+    then:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256, 1024 ]
+          default: 1024
+    else:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256 ]
+          default: 128

Regards,
Brad
