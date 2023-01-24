Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C1678EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjAXDWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjAXDWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:22:44 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6438B3B3E8;
        Mon, 23 Jan 2023 19:22:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fub0qvcl07Fpct1qUhvMDYQRqREy21BjbohJOb60TuWilIIAs99djixKfX0agkAaRLR6d9PKvgUzVwywplSZ5rSsXsT2so11Gr3Cb3BqZHXbC5NhmSAlD55m6az9rkP8C/tOVv9gMU9lZKAuq87zEzEZy8ZaMmqotPWm4i8KZm41IOhQZ7/NqBqBCkWagwaCs4I0/v5Nz3yfcvjP3EodCpgnhOOxpFNoe/ZuSEwMkPumiPUE0SjpkiMcomkRpjkQqM3t1tUTXrLqLNzce6xBN338DHOwjz1B22UYP0asiEjjNpVIkmFokrZhdvNX93HWqc/b+4yX+L/XuYbZNpmcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcrzxLNvBPs0JTkwQEq6lKJ1fs8XKbeeRfY41vcy4f4=;
 b=hesSPOFFtONbVFC7y7zX6v23kuzyi8CWHaWzQZqFC4JMvGzRE5PNh8TOXmIrennEqbathrJVazz64NV10QNGpn15QAVpKCIIMeYJrlF5M+uKXwJ7AgSTN4WwhN9vOZfUMlLQ2MvB+DCVzLZ/ivtE31C6LL1O1oSIqfTt7Sjq2wKTItDTYrEkpd4KJshNacXrzl0+oJnjRKQ6cGVkZ/D5WFmL27uyNwPNAIwOcpWiQ9T8RxRFESkwkLR2FEw3kav3YvXuZLdlUD6gcgnipi+sclrhZt3UZp0YE2g/pbH/nrBEPZ1fY0+z+9zZKnIcW9jQyOrEZ08yl0fKuLrJ+2pD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcrzxLNvBPs0JTkwQEq6lKJ1fs8XKbeeRfY41vcy4f4=;
 b=pAkhcfGVupj7SdMZysLHp47rBJKUqe5gLwLeguzP8DuPR9uwgarR3CQoFQnkSH07POALgwK21lWcUQpqDaRGXILwOn2VK5TnTDVq2dIrGjVXrnAyNonGVHIONOMxa+yUl4jVZ0yX8FGoaUrFjpoxlPyc+1vA1Q1Jg16nEM7c81M=
Received: from DS7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:3b8::27)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 03:21:43 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::52) by DS7PR03CA0022.outlook.office365.com
 (2603:10b6:5:3b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 03:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 03:21:42 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 23 Jan 2023 21:21:38 -0600
From:   Brad Larson <blarson@amd.com>
To:     <broonie@kernel.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brad@pensando.io>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
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
Subject: Re: [PATCH v9 00/15] Support AMD Pensando Elba SoC
Date:   Mon, 23 Jan 2023 19:21:32 -0800
Message-ID: <20230124032132.44082-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Y8k+SXQ5YtjDbKMG@sirena.org.uk>
References: <Y8k+SXQ5YtjDbKMG@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: a1db1c4e-95e0-4405-9045-08dafdba1d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8z/rji+rwhXnLRzd196W7VauSYNVaPj1MuSoKZAkwLeIDqFDiMarqH9B9mBgia0pGnJ0Z7y2KSJPF5Ug0AOej/LESNnqYGwJXqUWtRIOTI5mmG0bbcanLU6RjGpjb61yPNSKoPCNHDeLnTOSlC4dX5IS53AlqIFJHkcXNVDw2gYnmT1+7g1UwJFQ3M8ylkhmN+UWw2SjRWlhWSyy278BOFJ/lbwUtYozxH4XGwCz3bpCvXMvCEwsnH8OrEXABF2c64fHEltW3wDinDr76pDg29M8eWvew2RC+NxugMPN3vsOaHpO1zC8GXotEI//CuJwIoz/B/Fj3Dd8P8bWw1tTiQLHH4yue8/cXWPtC0khbMFvl3jghq5YO2ja8BVUWcokjkQFYnDJj47OeaIrVtICGocugEhhlF4dart2kwTPbJ4i/nWYwbzYkObyslsGQe3DwrP+ZwvP8d7qhMqaP6svflWAkZ7AL0oMGomiHF+CKdKLOU/hxj4WryWiO52yBE8OxT3ql3gGbLSQStnJH/yrJ1o0GJ1qv+TL0PNIKa9D1EZ1MIcusEfDB08hljYK7t0A6t9jnye+17zraQDIy3F9PVb0x1cJuvrhhBgWPR6BOhURqCgehAW4Ac5tWjqbS2U78M2YJdhV3TAlWBXY3IBcff5mW4PnaINOI/ZcHzByc7IjWsusTnGtsquy2pVylPPpB1KNgGJmUC/utE3bhocsgLo6KggztdVW982VFyU/2E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(1076003)(53546011)(70206006)(6916009)(4326008)(8676002)(70586007)(426003)(2616005)(47076005)(16526019)(6666004)(5660300002)(8936002)(26005)(7416002)(186003)(7406005)(41300700001)(2906002)(36860700001)(82740400003)(81166007)(82310400005)(316002)(54906003)(336012)(478600001)(36756003)(40460700003)(356005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 03:21:42.4832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1db1c4e-95e0-4405-9045-08dafdba1d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 12:57 UTC, Mark Brown wrote:
> On Wed, Jan 18, 2023 at 07:51:21PM -0800, Brad Larson wrote:
> > This series enables support for AMD Pensando Elba SoC based platforms.
>
> > The Elba SoC has the following features:
> > - Sixteen ARM64 A72 cores
> > - Dual DDR 4/5 memory controllers
> > - 32 lanes of PCIe Gen3/4 to the Host
> > - Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
> >   also a single 1GE management port.
> > - Storage/crypto offloads and 144 programmable P4 cores.
> > - QSPI and EMMC for SoC storage
> > - Two SPI interfaces for peripheral management
> > - I2C bus for platform management
>
> Are there any interdependencies between the different leaf
> drivers here?  Generally it's better to make the series doing
> baseline enablement for the SoC as small as possible and submit
> other things separately to simplify issues with dependences.

Only enablement changes are in the patch set to include driver
changes for Designware and Cadence IP integrated into the Elba
SoC.  Said another way the system won't boot without the changes
included in the patch set.

Regards,
Brad

