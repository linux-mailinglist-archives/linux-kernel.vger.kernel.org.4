Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F383960E425
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiJZPI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiJZPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:08:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD0E122BE1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:08:51 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Ycp3xYjdTUt036PVyj3/YDREHGXVSGXrz7Fodnc9X+pJ1nMkeXjObrEAVgT1VisJLQy2OjjAJkvgeZXyifPcdujpZeQZJkcCkAgkshF0Ac/A7mmCCl8UMUrK8ZTkA3JSlyc5nDMymn31Xov1TWTdt02P2KQq4EJSpaAvVA4Bc29zcZKfvWR4Lay4naoq2sWAgQR1tyTAV6e6h1IwokjiVdpIaMEqX6uOWeBoIeRkIuYAEpQwFzR6sy5f1vY1bjYEMPeTGN4+9QOZSaF1mQwHPRPmf/CmJOK/Rh1IcfX3i76+5r/8WG0JmRD9w0LGkfDlRoVKRx5JHXUgZ9kO+L5bcQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md2eIw/qYyLb6WObHWIWKkMCdMsgVJSwb+YL6Upe9Nw=;
 b=FMzGEPMb+Q825QfwshVnhk3l+e7Ao6C6IJASG3vrpmtGd4464JYj1ymnNMY5eE50YkuWqE9PEZ40HxeT2NXJkRBgAEU9RUH8KNlD4gonG6c20ZVuRz0w21DwtUIu8fiSy+6xi8orAki5ywSPtv9Mbe1ReNzWmQtXq50EXsENNpk577c5HwAURk3F20ReX6MMshMRX8ox0hmxOmYm2Ltj54pHedLgMuHa1NZqVmyB2JhAzLixGi/OEBXN24wINbhiF6nGtBJKbjCw+J8fZ8Pgc4po7ydnz5Vg+DAbstb/G+kqvMRJGwycoqa4cUSXXh/X5GKCI57Rz2CLe/0yq/qKDQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md2eIw/qYyLb6WObHWIWKkMCdMsgVJSwb+YL6Upe9Nw=;
 b=gmO25wVav1/taN5Db1F/nBf1QL4tpJUiaOaPxD/0idMSd0YDbd3bB8pptW63IRr9TmThEjPOg+7+F/WuLZPbw5NyJWzWON/GVMinv8kM7dmnqApCzSkfwNnzWWZZ4hIRYGsSOgpMzvFsly4hXOofPvmBF3moV9zTAEAa8/moU9g=
Received: from DB6P193CA0003.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::13) by
 DU2PR08MB10303.eurprd08.prod.outlook.com (2603:10a6:10:491::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 15:08:34 +0000
Received: from DBAEUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:29:cafe::be) by DB6P193CA0003.outlook.office365.com
 (2603:10a6:6:29::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 15:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT028.mail.protection.outlook.com (100.127.142.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Wed, 26 Oct 2022 15:08:34 +0000
Received: ("Tessian outbound 2ff13c8f2c05:v130"); Wed, 26 Oct 2022 15:08:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b53391cd8ab55964
X-CR-MTA-TID: 64aa7808
Received: from cbae66d2aa36.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B8046C14-437F-41FF-8087-0946A0586D4C.1;
        Wed, 26 Oct 2022 15:05:22 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cbae66d2aa36.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 26 Oct 2022 15:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkX9V87TVMr6BEvHgsJ7bMISzqAtEQBdCxCP1BRKLY5FRfL/fLcdbUzACSwaMV8X4rn9FRJu/zfAgskCHs7JcUa6gaBcMa0OdCpFVmWpRx5zusMCy0HG+DhcTZDIg6aIX/LZ/5CZindckNuxaZFTfXIFk6DwFsay2axLp0hU+8oDPeajMWSTkOVCfe7kc9OvbkeexIw3v8aiALwlcQVkiw5aZvGHVqfEBbTygDfr+7NMizHvBbFoAjeaa0TozWY0znqzTaVOjgHoGGOss4CsXwogqDrxN4OeQdjcMpbkghUPU6RS6F7X+5Yo4/F+fBmwNqpjJvTOHPj1lJjEi8acuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md2eIw/qYyLb6WObHWIWKkMCdMsgVJSwb+YL6Upe9Nw=;
 b=fmw5/kMPoZb9v+vG9Ed+S5AYvRzQsE6Dsmm1EogIwR8r2WDEymazlwsoY4apwd8MPixWW1TJrh1Oorh3Jpn3ZQ9JTl1Nwx8MLiZh3ttd98a00N5psJMi77BnbQdzEb/ZooORcq1+YTFWc59MDOLyh3oCuk11KRtEqwFjQu7B2yLf0QRypIHg/NneRXEO3FdDCFJe3njkmF+psQfXjwSefVtVV2Zp5LtZKB7W3xf9PikCdyVZWjNJTqTa1JrnMJuXDdSorXbhJzpMyqnAhRPgdHqJDOkN7XIrXOxmykA75bjD5rFdEL/AdjcgQVR6WzDiulQnX8CgQeh8Vg9qnZSbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md2eIw/qYyLb6WObHWIWKkMCdMsgVJSwb+YL6Upe9Nw=;
 b=gmO25wVav1/taN5Db1F/nBf1QL4tpJUiaOaPxD/0idMSd0YDbd3bB8pptW63IRr9TmThEjPOg+7+F/WuLZPbw5NyJWzWON/GVMinv8kM7dmnqApCzSkfwNnzWWZZ4hIRYGsSOgpMzvFsly4hXOofPvmBF3moV9zTAEAa8/moU9g=
Received: from DB6PR0601CA0002.eurprd06.prod.outlook.com (2603:10a6:4:7b::12)
 by AS8PR08MB6552.eurprd08.prod.outlook.com (2603:10a6:20b:31c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 15:05:19 +0000
Received: from DBAEUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::91) by DB6PR0601CA0002.outlook.office365.com
 (2603:10a6:4:7b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Wed, 26 Oct 2022 15:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT057.mail.protection.outlook.com (100.127.142.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 26 Oct 2022 15:05:19 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Wed, 26 Oct
 2022 15:05:16 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Wed, 26 Oct
 2022 15:05:16 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Wed, 26 Oct 2022 15:05:15 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-abi-devel@lists.sourceforge.net>, <nd@arm.com>,
        <joey.gouly@arm.com>, <shuah@kernel.org>
Subject: [PATCH v1 2/2] kselftest: vm: add tests for memory-deny-write-execute
Date:   Wed, 26 Oct 2022 16:04:57 +0100
Message-ID: <20221026150457.36957-3-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221026150457.36957-1-joey.gouly@arm.com>
References: <20221026150457.36957-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT057:EE_|AS8PR08MB6552:EE_|DBAEUR03FT028:EE_|DU2PR08MB10303:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3c2767-3218-400f-35da-08dab763f3d1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QwUsFmYxus8FCwgw7iqHDmsu585q6R/EEuS7Le6LjGD7MNIY0l77EukW35nVVetZuhWc8+MgFHZFBkAzAAJTx+LVTxPU8dmbv1UCtNjmQvF9NUZTbR6w9YpjHMB8qUS/xhTeyWns1Piq5cIx91spkFwo8wOI9uPc5NnWHQ+Qt24CzoX1qtD3RvOLSHkdyyFOTnp6VIggOsvA39VgsLFdpP8XCH6S+VZr0IGjz8Hi1rQ84z/jVN6mUpPVzD0jlleX0+rXvsSd+zkJgPQuvyM5tWKpmaPhovioliQaxSAh6HJAl4jNDCm6A9Qy2qhuXfCtF51WSSNIU4TR7JRpf1OcXkYgqc3ShTcR0ZDX+QlhL6PY/CpO51k7hKXkcCHsRvCk0/5IJCY0AHoTjNJJKZCk8LfNFE/KJyxeg+qiIMLxCx0QSGP9kuLPpqrV1Q33Mliz7A/YqpWeRejvWSW/X7MQUqZLF8KLbxkKei/zL1asOi2pznH0q+ozOWU11iJzhWaS4Owfv29YtTQXYQBg3iR+xaJkIQ5vOTcD0r0KsuclpDCnbd/inz7xPgEMm2Jc7eGnB8lQQSg7SQyQLTZUM9ZUdUcyWsdS5NRV6tSDUsY6qpGiINP0dg4LYvygQ9WgMmVKqSWHC82NM3hqZDQhliso4sR71ylNfjpc4fW04g7eBDj51aFZP9Afdc/2Wzj0YVIO7vNCEqPecuogXf0y6WAujPDVZugBTci019ySZHa7zh2FuZZDQo7/OUfIIVP3ZYUqHKIuiudTrckDbnoMOEpRydS5WgmFXq4aA3fCduH7o+V9MyxLvRR+JE9io3g+NZcT
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(36860700001)(86362001)(81166007)(356005)(110136005)(54906003)(316002)(40480700001)(83380400001)(47076005)(70586007)(2906002)(70206006)(5660300002)(478600001)(8936002)(8676002)(44832011)(426003)(41300700001)(4326008)(7416002)(186003)(6666004)(336012)(1076003)(7696005)(40460700003)(2616005)(26005)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6552
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bb267f41-e2a6-415a-b2af-08dab7637f9a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htz8CXt+O2fm2bwC6EB3mkho0ZgMyWeTEGbXvfX3/uPmwdk48jJ1e5C17FaiPJq7ARTALk75lnfVBvCReNkD/OIEn+PJHMCgSR7y54MFgmh4BKL/kSaUp3Kfg62BWFltzbuqQw0QCA/updi8XUGNjp+BqRKbYmBbQLpVTI3VyJdqXJG7pwmLhlGCy0SnxKRvsw7rOH0L4/JeWhr4jjbvLJf2iHmYk2/UBr7FfLBwCwCq04euTVDrubS+yCFjDWUBk9wjvGE6Y7Ap2bNySeVibHGv3kqTpDgJrJSxqSGWzuMb4Zp7ivIAOPZ1OFZYgNVw5cSv4YPlhWMG1Tn+w3WkrT0M5Ulq+M8j4aOzhUwpfo6btlFejJPEAqMiCDp13lf0AmVAlAN1BD10GJEqKrqVIcXEaBRs9tCe48IfkEFonGo2C/ahZ9KavT5hf6UTEDQrBsU5G8Iq0Dflj0vLK7swlG9chWecDD3AdNxjGzi8kvEJsXYm+v2NX82y2fI+FNVNjzDERCja2eAKrGEmi2TEUthmeU1LdAny1rHyBmtQXDc4sncmv2hDQF5RwyFe9QXFAcWiOHtAsyUpcghx8pniFEn2468aGwNIPEuVG2hThxWMc8vFj0PD64O8hillCqKdSj7+EpYhaLKTTaWUzgXDBf6ImIjFCEe9K6UPauQqa9WiZGaLpGrf2+IpKxDm9b1VaoTDLC9PnOsGyLgfZ3BVLiCzUc2kS8Gbgm/SnXC2SJTUYa0JyFVxrN6rruLXn3D9ZEwmEHHseiehhkdlNU3Jrg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(70206006)(54906003)(5660300002)(36756003)(110136005)(44832011)(4326008)(86362001)(8676002)(41300700001)(26005)(70586007)(316002)(8936002)(2906002)(40460700003)(47076005)(36860700001)(83380400001)(426003)(81166007)(186003)(40480700001)(2616005)(336012)(1076003)(6666004)(82310400005)(478600001)(82740400003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 15:08:34.6566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3c2767-3218-400f-35da-08dab763f3d1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10303
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some tests to cover the new PR_SET_MDWE prctl.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/vm/mdwe_test.c | 194 +++++++++++++++++++++++++
 1 file changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mdwe_test.c

diff --git a/tools/testing/selftests/vm/mdwe_test.c b/tools/testing/selftests/vm/mdwe_test.c
new file mode 100644
index 000000000000..67f3fc06d069
--- /dev/null
+++ b/tools/testing/selftests/vm/mdwe_test.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/hwcap.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/prctl.h>
+
+#include "../kselftest.h"
+
+#define PR_SET_MDWE                     65
+# define PR_MDWE_FLAG_MMAP              1
+
+#define PR_GET_MDWE                     66
+
+#ifdef __aarch64__
+#define PROT_BTI      0x10            /* BTI guarded page */
+#endif
+
+#define TEST1 "mmap(PROT_WRITE | PROT_EXEC)\n"
+#define TEST2 "mmap(PROT_WRITE); mprotect(PROT_EXEC)\n"
+#define TEST3 "mmap(PROT_EXEC); mprotect(PROT_EXEC | PROT_READ)\n"
+#define TEST4 "mmap(PROT_EXEC); mprotect(PROT_EXEC | PROT_BTI)\n"
+
+int fork_test(int (*func)(int))
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	if (pid < 0) {
+		printf("fork failed\n");
+		return KSFT_FAIL;
+	}
+
+	if (pid == 0)
+		exit(func(1));
+
+	waitpid(pid, &status, 0);
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 0;
+}
+
+static inline void test_result(int err, const char *msg)
+{
+	switch (err) {
+	case KSFT_PASS:
+		ksft_test_result_pass(msg);
+		break;
+	case KSFT_FAIL:
+		ksft_test_result_fail(msg);
+		break;
+	case KSFT_SKIP:
+		ksft_test_result_skip(msg);
+		break;
+	default:
+		ksft_test_result_error("Unknown return code %d from %s",
+				       err, msg);
+		break;
+	}
+}
+
+int test1(int mdwe_enabled)
+{
+	void *p;
+
+	int size = getpagesize();
+	int mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
+
+	p = mmap(0, size, PROT_WRITE | PROT_EXEC, mmap_flags, 0, 0);
+
+	if (mdwe_enabled)
+		return p == MAP_FAILED ? KSFT_PASS : KSFT_FAIL;
+	else
+		return p != MAP_FAILED ? KSFT_PASS : KSFT_FAIL;
+}
+
+int test2(int mdwe_enabled)
+{
+	void *p;
+	int ret;
+
+	int size = getpagesize();
+	int mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
+
+	p = mmap(0, size, PROT_WRITE, mmap_flags, 0, 0);
+	if (p == MAP_FAILED)
+		return 0;
+	ret = mprotect(p, size, PROT_EXEC);
+
+	if (mdwe_enabled)
+		return ret < 0 ? KSFT_PASS : KSFT_FAIL;
+	else
+		return ret == 0 ? KSFT_PASS : KSFT_FAIL;
+}
+
+int test3(int mdwe_enabled)
+{
+	void *p;
+	int ret;
+
+	int size = getpagesize();
+	int mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
+
+	p = mmap(0, size, PROT_EXEC, mmap_flags, 0, 0);
+	if (p == MAP_FAILED)
+		return 0;
+
+	ret = mprotect(p, size, PROT_EXEC | PROT_READ);
+
+	return ret == 0 ? KSFT_PASS : KSFT_FAIL;
+}
+
+#ifdef __aarch64__
+int test4(int mdwe_enabled)
+{
+	void *p;
+	int ret;
+
+	int size = getpagesize();
+	int mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
+
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_BTI))
+		return KSFT_SKIP;
+
+	p = mmap(0, size, PROT_EXEC, mmap_flags, 0, 0);
+	if (p == MAP_FAILED)
+		return KSFT_FAIL;
+
+	ret = mprotect(p, size, PROT_EXEC | PROT_BTI);
+
+	return ret == 0 ? KSFT_PASS : KSFT_FAIL;
+}
+#endif
+
+int main(void)
+{
+	int ret;
+
+	ksft_print_header();
+#ifdef __aarch64__
+	ksft_set_plan(12);
+#else
+	ksft_set_plan(9);
+#endif
+
+	// First run the tests without MDWE
+	test_result(test1(0), TEST1);
+	test_result(test2(0), TEST2);
+	test_result(test3(0), TEST3);
+#ifdef __aarch64__
+	test_result(test4(0), TEST4);
+#endif
+
+	// Enable MDWE and then run the tests again.
+	ret = prctl(PR_SET_MDWE, PR_MDWE_FLAG_MMAP, 0, 0, 0);
+	if (ret < 0) {
+		ksft_print_msg("PR_SET_MDWE failed or unsupported!\n");
+		goto exit;
+	}
+
+	ret = prctl(PR_GET_MDWE, PR_MDWE_FLAG_MMAP, 0, 0, 0);
+	if (ret == 0)
+		ksft_exit_fail_msg("PR_GET_MDWE failed!");
+
+	test_result(test1(1), "MDWE: " TEST1);
+	test_result(test2(1), "MDWE: " TEST2);
+	test_result(test3(1), "MDWE: " TEST3);
+#ifdef __aarch64__
+	test_result(test4(1), "MDWE: " TEST4);
+#endif
+
+	// Verify the MDWE setting is transferred when fork()ing
+	test_result(fork_test(test1), "MDWE+fork: " TEST1);
+	test_result(fork_test(test2), "MDWE+fork: " TEST2);
+	test_result(fork_test(test3), "MDWE+fork: " TEST3);
+#ifdef __aarch64__
+	test_result(fork_test(test4), "MDWE+fork: " TEST4);
+#endif
+
+exit:
+	ksft_finished();
+
+	return 0;
+}
+
-- 
2.17.1

