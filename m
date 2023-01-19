Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1DB673E34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjASQFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjASQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:05:01 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407604ED23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSz4XrLrOU/Q0X8dyvT5gsrdo+lHEbTiMfz9tT5sCxE=;
 b=yRWW5KHGdhFUE3VJUOE2HiGYbbFw1X4sIgYpUOFGgi/BaQEQsHpjCSZifJ3pAEsNeCOR4UIya1JTb4Ww64/haAH3Y38ey+dXEZ/DPcHVd4Hyac7TuwzTyuJ4/1aR8pgCU1BEWYeqyGuCKvtVNpB6oC4GRwhD1jdiwtKRNhHsacM=
Received: from AS4P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::8)
 by DU0PR08MB7905.eurprd08.prod.outlook.com (2603:10a6:10:3b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 16:04:36 +0000
Received: from AM7EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:5e1:cafe::a4) by AS4P192CA0019.outlook.office365.com
 (2603:10a6:20b:5e1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 16:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT022.mail.protection.outlook.com (100.127.140.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 16:04:36 +0000
Received: ("Tessian outbound baf1b7a96f25:v132"); Thu, 19 Jan 2023 16:04:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6534bfdff3293073
X-CR-MTA-TID: 64aa7808
Received: from f0b93e1d57fe.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 53D9ED59-5EA8-46CF-AD54-6ABF85BB3334.1;
        Thu, 19 Jan 2023 16:04:05 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f0b93e1d57fe.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 19 Jan 2023 16:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jf2KAhZPJS6i4LP82P7FHExpOvabULfbU+u6Ws11HueHw/CpJgPbmTRUSckfAU03kot+oCJqi+ZQJLS16DlEuCABmD7Qa2varMrOtqnsKI4IiDFPMVa3QYiK4mISR5lJjs9TgPmhufZnPIijTXcOe/qL0It2ukaI8rIhM2/KVcB+ai7WQuZPbgP1mMYkglWXJaHGYJAf9MYnTa/u8TXEax4pLxDL3udmpEGlwGmvVNFJMZiBM5opTt1KMDqYmnxkyes2UBrKiCSuDSrxDkt7rbcTHjXsiF1R8YRVepBPqsLsC+ZFiT/A8nNJoAqwjpzLdXJ3Dj7g6HcB/f6JOBmyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSz4XrLrOU/Q0X8dyvT5gsrdo+lHEbTiMfz9tT5sCxE=;
 b=NULLEK/sFVKxWQ6i1eWNGYB1JH5gQTt8HsD2ylFWcd66mblgM8Nsdb6a9zzH7EuhqKZ6J6cx5PmX7ANaVqEC7FaKis2DdUvluPk2iVAG46vXlGg4wSnj34g24UHlqZ2u2LTEf6zXj41gN+dI2hWqXK8IhcmDKyEMBU8aqNnORSYEYggPelZfNDFJNLqhFjhenYetk4JDICw/DvzJEch4YoT3dzLl9ididRkwMVPB9oeiYErc9ohFPMhV72nTkimG3TcrPeYuOqpsv7CdhacoXXzMwai1qsa7ljo5Yff9M8oRRRf3+lNeMVnYxFl9dkVxCylhauME0UWXReItdesyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSz4XrLrOU/Q0X8dyvT5gsrdo+lHEbTiMfz9tT5sCxE=;
 b=yRWW5KHGdhFUE3VJUOE2HiGYbbFw1X4sIgYpUOFGgi/BaQEQsHpjCSZifJ3pAEsNeCOR4UIya1JTb4Ww64/haAH3Y38ey+dXEZ/DPcHVd4Hyac7TuwzTyuJ4/1aR8pgCU1BEWYeqyGuCKvtVNpB6oC4GRwhD1jdiwtKRNhHsacM=
Received: from AS9PR05CA0315.eurprd05.prod.outlook.com (2603:10a6:20b:491::9)
 by DU0PR08MB9002.eurprd08.prod.outlook.com (2603:10a6:10:467::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 19 Jan
 2023 16:04:00 +0000
Received: from AM7EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:491:cafe::80) by AS9PR05CA0315.outlook.office365.com
 (2603:10a6:20b:491::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 16:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT056.mail.protection.outlook.com (100.127.140.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 16:04:00 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 19 Jan
 2023 16:03:59 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Thu, 19 Jan 2023 16:03:59 +0000
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
Subject: [PATCH v2 0/2] mm: In-kernel support for memory-deny-write-execute (MDWE)
Date:   Thu, 19 Jan 2023 16:03:42 +0000
Message-ID: <20230119160344.54358-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT056:EE_|DU0PR08MB9002:EE_|AM7EUR03FT022:EE_|DU0PR08MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e0c292-8e23-4137-412c-08dafa36dc8b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qWUH5axFNnx0Y830fduFk256PntJHMaRiTJ0Fb4+qrqb4AOqzwdY+eJmeQ1ZDdAU//FnEaolFb/x0fZ8Kdq76E/BC/1Gj7iT2jpiaMNVmc+8AeJM64hmsobEF/Sr05TV3tNbQ9CqIUogofqnFA8QdP6yw3Rb6ZN6+/qJPoaIYxf5rToxUlH/vNckxwcLh2Zby/h6IJsxTp+kWWq/ErR44XrZ/xBapNLsWI6MnygT5W8MHqlrLFsYPCdKsm14k5JLl4sXZNj/1nsazXdr1yWBUVKK8LucqMsBU1/tA00S5aTehp7sNpZSHiDNGawaF/NmUtZ50hbp9L0PX6FJBdcvDNTyd2p+IA/CoteWj37XRWGHpoBxO59Z9cek879UedoonPcToH4r8Bxi1moxUKYn+VRjwLNLoJQIkLO7bBofPgdkJ3hkplG5GstOATzs4/xA7myFFRO0kvTPJHEyEtQ/Jl+KFW6t6DWydaSoCFEXgeBZXTSK1kWM71A/4b+fA1P+td7YBWfqZ3N2TXe1qK0pE6u5N01nhwliofXcLM1uORmdmvpRachd1ebDlD5pQnE+YpKLw+oONH7PmgSBdyZMsS2+JZMejFJfVT1Dd/ZJ+qkriCib+A+18WbOKtAA2npcJY+s/7Ki+j5+Xhyv1JQhS28xyT02mESZbF2kVcpiwbrzrScgbuEU8a+9fVpYUwIMHA+NxNdojYN5ww/VZxP6+XfWDVnht6Z33Xz/Rst8HDmTd5k3AhrKuOrlKzRhxFH0MUnnqxjJef0+obZ4FlHZ68Yyoo0KnA3kNz3ccJX9PojkeaRptmkEAMxlBkmZSKMd
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(7416002)(36756003)(44832011)(41300700001)(82310400005)(83380400001)(36860700001)(2616005)(1076003)(478600001)(4326008)(5660300002)(8676002)(966005)(7696005)(356005)(82740400003)(426003)(8936002)(40480700001)(26005)(81166007)(6666004)(186003)(336012)(47076005)(54906003)(86362001)(40460700003)(70586007)(70206006)(316002)(110136005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9002
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e664ca60-6c8e-4e57-8fcf-08dafa36c778
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roBeyKqhpl2PgdRMiHgBrKMoCXcfBKW8IQbOEzw245Vs5VCu9DgX4ym998Zy7SI2V+MvwyYNEXlFKWxEBnuMoEWpQO0OcVyjsUBjZcFJ91iB0VpckTZevGuIxQt97kTXl8GrrLyEEs+GHygO/Xcs0gFvxZVmQz9uvS6pJTy07htH2hAx6YwzdUbZS26Z88hFgyxYVpWT3GS9x2jmXPZXLhb3vXX2DviCxZ0OTgBQTX65n7bSoe1uzRrTYDAmU0F6CSFz4p04qvX4iyg9wVyJh5vz23XvWpn6eFgmAx+lANCr82vnprFRnBDcmGzlLV2AetvD1G+YV1kN7ZtMRNT698qe/lJ8snpPoO6EGKdTQVa2FaQvjk12B+4snaRr8Oz6VwHw5bcfWvz4VLxQkaVVLfDH1Sq5tTgTblF1lVqQn6YpjJUNvDSO3gQZGEbfwMAiljtsVVHQiLWyok71YJHwuGz5EdSjbgilw+jBNZWD13G6Csgv4FXpO8q0zmgj5Jv2ENqjS7T/RrezCO6YM9Omrz/lD5Wvv0o9kFb+YIb4LPuzAOiuCTBLp9j0vpz0Q6FnzSsxSAoeLNC88EH/j8eTC6DBue5Vh/jkkuRG1yFNMVhWlEdKiN1VO8DKErSFZE+wicFbeGGkYLr9czuxXBjxrPR7W3UgGhZONvK1lkz10ztg3ea8EfGca+9y8lH5tibNAxxXI2ZDPdpJ+xs0w8r36SLyk6FbG+T7VfKnKrZqZ1IEU2VGaoxGlQ0vbMcuuJtiL5nNruSoV4wNqJDPvXiawQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(36860700001)(40460700003)(36756003)(86362001)(26005)(81166007)(8936002)(44832011)(41300700001)(5660300002)(70206006)(4326008)(70586007)(82310400005)(316002)(8676002)(2906002)(336012)(2616005)(426003)(47076005)(1076003)(40480700001)(83380400001)(7696005)(966005)(54906003)(110136005)(186003)(478600001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 16:04:36.1169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e0c292-8e23-4137-412c-08dafa36dc8b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7905
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v2 of the MDWE patchset.

Changes since v1:
	- Rewritten test - thanks Kees!
	- Added comment to `map_deny_write_exec`
	- Moved flag check into mmap_region, should be no functional change
	- Rebased onto v6.2-rc4

The background to this is that systemd has a configuration option called
MemoryDenyWriteExecute [2], implemented as a SECCOMP BPF filter. Its aim
is to prevent a user task from inadvertently creating an executable
mapping that is (or was) writeable. Since such BPF filter is stateless,
it cannot detect mappings that were previously writeable but
subsequently changed to read-only. Therefore the filter simply rejects
any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
support (Branch Target Identification), the dynamic loader cannot change
an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
For libraries, it can resort to unmapping and re-mapping but for the
main executable it does not have a file descriptor. The original bug
report in the Red Hat bugzilla - [3] - and subsequent glibc workaround
for libraries - [4].

This series adds in-kernel support for this feature as a prctl PR_SET_MDWE,
that is inherited on fork(). The prctl denies PROT_WRITE | PROT_EXEC mappings.
Like the systemd BPF filter it also denies adding PROT_EXEC to mappings.
However unlike the BPF filter it only denies it if the mapping didn't previous
have PROT_EXEC. This allows to PROT_EXEC -> PROT_EXEC | PROT_BTI with mprotect(),
which is a problem with the BPF filter.

Thanks,
Joey

[1] https://lore.kernel.org/linux-arm-kernel/20221026150457.36957-1-joey.gouly@arm.com/
[2] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#MemoryDenyWriteExecute=
[3] https://bugzilla.redhat.com/show_bug.cgi?id=1888842
[4] https://sourceware.org/bugzilla/show_bug.cgi?id=26831


Joey Gouly (1):
  mm: Implement memory-deny-write-execute as a prctl

Kees Cook (1):
  kselftest: vm: add tests for memory-deny-write-execute

 include/linux/mman.h                   |  34 +++++
 include/linux/sched/coredump.h         |   6 +-
 include/uapi/linux/prctl.h             |   6 +
 kernel/sys.c                           |  33 +++++
 mm/mmap.c                              |  10 ++
 mm/mprotect.c                          |   5 +
 tools/testing/selftests/vm/Makefile    |   1 +
 tools/testing/selftests/vm/mdwe_test.c | 197 +++++++++++++++++++++++++
 8 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vm/mdwe_test.c

-- 
2.17.1

