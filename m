Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22E60E423
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiJZPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiJZPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:08:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819B12500A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:08:49 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=XazKFHdAN9mHDEr2tQb92OrHN+WI66zRVN+cQDIch8Ik4eu1RbasRupCC/t8OdfchQyQR5hv+gsac6OpvePQGqUGV1IqVrgEenIogiYgR2g37wgQyfQfrBkGxy7RLOKTSasqL+iPIFTStm+dZld0qIA2RnVR7TPFREVkzdbNOWhF5KV/gRpiUihEugLR11kZUAjZoUpkFo03aS8Vt7vmWYoy6IIgXmSb8BElIj6VFUIRD9FwI0Aj+CtGw1K0dtKL2KZtI2QSgMpzBnpsdBHKPK/bFS+1vWRrDTTvcsk19T38hZB9R0rXQbKD2kCbq80bKJygaEAuk/4o/OJS5hJT3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYfPwbM8XKUTWEb22ZoeQws90ygepA223xQAlZWfh0I=;
 b=B87RkYaZnp8WuL08pCNUkAh/NISMhBsz2IV8EkrD8Hp4UIWX/FZNKHdKkdYzb2JSY0pK9yJD6ubOLfBVhM9BzJNmo/3tcUO5Rth1nrU7hzimw7PV9FGgyud9cXfy9cbYOMKxBcN2f9TiVmoU8oytNW6lowihsG1/1/uyOS5mG2bU961+w54YjqO9G404FDdlNApSsSDc5Osw30W7egj6BszabeiR5Ch6is56wE8buYfwKsFMsbmSV6bUeNfxLYQrI7JwN0oHm1ywcwYX9EGcXCufFneq7YIDYZSQssB1kVzZqRsdGHEPTQWZ4oIMFL7lmX2fSd00x7KolriP+Mv1sg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYfPwbM8XKUTWEb22ZoeQws90ygepA223xQAlZWfh0I=;
 b=8vo6DjhPrEOP8p9q+0Ex6MPJ8zr6mwpU2U787IEXFRtLqahPjgbyMomEbXbNdz8qPTxmOQasKbb9l/hmPs8Y1q6o3o+IIn4qpMeJpA6w9DGoUD+J3/nkIJUgFG6fgK48PgYlurKHOLHIDP4coKVWTYGT9//74CO8fbbTY7IxEcY=
Received: from FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a1::18)
 by AS2PR08MB10155.eurprd08.prod.outlook.com (2603:10a6:20b:62d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 15:08:40 +0000
Received: from VI1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:a1:cafe::1) by FR3P281CA0100.outlook.office365.com
 (2603:10a6:d10:a1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.13 via Frontend
 Transport; Wed, 26 Oct 2022 15:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT005.mail.protection.outlook.com (100.127.144.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.19 via Frontend Transport; Wed, 26 Oct 2022 15:08:40 +0000
Received: ("Tessian outbound 58faf9791229:v130"); Wed, 26 Oct 2022 15:08:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3c1f7f1f4a1c5bad
X-CR-MTA-TID: 64aa7808
Received: from 503de7c18d26.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DD19D9F3-A868-4ACE-8C01-F4F83DCAD6FD.1;
        Wed, 26 Oct 2022 15:05:28 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 503de7c18d26.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 26 Oct 2022 15:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuvYlbolZrzter9locKaKlk5HWuddnzWAreNvF3uFVQvpNCp6oDwdBmjkFYcmoUk0f77cgz3Lp23AG45Uvw0evRK5HkSkBpOzFFfXOpgLj6wb1s3JDhrRo9gZNt0AakozRKujoKHuQlQBkub13dDdjOe7BQSA7Gy2rPNCQPzTvr9fZBTzqPyVFr45V4L9cqTriq0hw80B5oJZW22i7tlAlMajHUGlBSzCGCnmxZsa5K4hyk2FdSRRO0Qf9tFw3tUVAoMge20Jmk+fkojTHv81Oc8KJL5jirWtg4jybUS44/Iy8TooV0hijpQfdZIJMk6c3hi0qSqwwixxTc5DyOJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYfPwbM8XKUTWEb22ZoeQws90ygepA223xQAlZWfh0I=;
 b=XvayGapnsyXJV+qahfdyV0cLAPnP4q67AxvY3QGK+2sN5w1w7FEAZ435DQV2iWuaqVvQx/NTqd9s2YH+/iwBSuj2KMwP9YLjiUZusuTbXRpatoNnz+HhjuSTAcRy5iaOkbSb82U52mBO9zU+vJsjlwM5acSUW/0Dv+zOKssp0PRysp0q327pm0+rcU7u22XkVyqiERhUf50rRHwlOqKHNFPVdOmrlrV2uwOBo4egK3ELUNrNwxs3MhxJVNF/0LQiiThI69XCB5AQJjpz16d0FBt9bqUKBut8UkXvuFwF4/BkQ/iPPKzlcA7jHjs9f7EK2yc4xyK8PSqj6VU3MZQzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYfPwbM8XKUTWEb22ZoeQws90ygepA223xQAlZWfh0I=;
 b=8vo6DjhPrEOP8p9q+0Ex6MPJ8zr6mwpU2U787IEXFRtLqahPjgbyMomEbXbNdz8qPTxmOQasKbb9l/hmPs8Y1q6o3o+IIn4qpMeJpA6w9DGoUD+J3/nkIJUgFG6fgK48PgYlurKHOLHIDP4coKVWTYGT9//74CO8fbbTY7IxEcY=
Received: from DB6PR0601CA0020.eurprd06.prod.outlook.com (2603:10a6:4:7b::30)
 by AM9PR08MB6692.eurprd08.prod.outlook.com (2603:10a6:20b:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 15:05:19 +0000
Received: from DBAEUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::57) by DB6PR0601CA0020.outlook.office365.com
 (2603:10a6:4:7b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Wed, 26 Oct 2022 15:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT057.mail.protection.outlook.com (100.127.142.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Wed, 26 Oct 2022 15:05:17 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Wed, 26 Oct
 2022 15:05:15 +0000
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
Subject: [PATCH v1 1/2] mm: Implement memory-deny-write-execute as a prctl
Date:   Wed, 26 Oct 2022 16:04:56 +0100
Message-ID: <20221026150457.36957-2-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221026150457.36957-1-joey.gouly@arm.com>
References: <20221026150457.36957-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT057:EE_|AM9PR08MB6692:EE_|VI1EUR03FT005:EE_|AS2PR08MB10155:EE_
X-MS-Office365-Filtering-Correlation-Id: a76c9443-07e5-4d0f-6251-08dab763f722
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: btyGyqO+L1lYyZ63EFHnfmsUpYkQFORqj+fnatsRahQfYHpNsVStiU2NmU6yuQdmwPqyQhKzemnNZtyMuvEiYA4UdL3KF0eq3286wUOnDoPJvPznBMFJ8Y7B5r3euggfzbSqo4hOds46tkU2UQSC9ZCNcLFUecjNmflV5Gi30VR6Tsc2byCXFOzrMwrNlsoAMl6dQSUOyMXPj9VfEy69+JpjupOBF5TDESjH4U9XmotDSDCQn/aOkyrGcDK8WK36dfPjLQRV9d/CBvbGR3g8xCvly+52qkLyr2+90bFM1fiOd7NYN02kkw2UKIVX7pNPUHVMmBg48YJvYoCgtygFThXBs9Is5JDFKmYORfoeMjYkUzfiF5UK4VDwfhqjreiKt+aLVO7gELrfJlY9vkd0Sx1lO7uy10kPilprG4j1YlKVkbBVlvhh+LnWnsAdh4NfEhOBtyl/qSm4cnvUaZ/bZJj6NCGhzVbBq4Vd+Acj4n82xNw91V4/p3Xug0MgBDiGayrR0CH3U+5yJdk8hLGgNLVuAcJgaozP9hsap00etNXmkBkG04o8WJOuMKCvidcW5rhUlTKYOhUUpIaQZqmcCnCNT2P78l2lGgIa00xtfNcEnS0TTHIYECVGTVqdqwRDofczncd8mDNd3uCBnTMHbxRnbO1DfcSPwsY443WOKjaLr7TeFA7EnoXstTce7qrO/Oqovg2B6+/Z8b/4KaUc9KI2KuO/spGMpU2ciqgFYNjMvkkXVuVSF5maS+FDa0/C6qcqiprSa/FVRQrMWuTnH7n+TIesgmeKqq6mV1TlgFiAjkyV8mVPsHtpclIWdwZQUanpIMEp2dzg6LHrSUfjtw==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(356005)(81166007)(82740400003)(44832011)(40460700003)(40480700001)(2906002)(2616005)(6666004)(36860700001)(83380400001)(7696005)(1076003)(26005)(336012)(478600001)(47076005)(186003)(110136005)(54906003)(426003)(82310400005)(41300700001)(316002)(70206006)(4326008)(8676002)(7416002)(5660300002)(8936002)(70586007)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6692
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 84b34e25-0825-4a8f-ca1c-08dab7637e26
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51KCiw6n1Mzxet6b4wyyahNFovWAztKMcwodk9FKBVvgOQGdLNAIeEtP1fGqvB7u89Xqc2lOM/FKu5csw6hCXTFzijb0sDVX6twPKdV5j3czeuikE4E/0cIqYPBskvtpOsDUxvSKIlhsii4auXtVgK134twO+Sn01PDZrhpRic28vkzogysZWfNfCqt604tKpSeaWEb+pmmohYx8r0UesK+BkGbUM/kB1liC83iak6TzXuX9S4xkegt/+yZ78w7xIL8MmrUm/+yT5Y4ByTx/ezhviAoY0MRLGmfZfjZdZl80sYE3B+ReuJLYLSdne0RaXOApTUFsukYUyUxo8JM67oVNtV/zmR6eT3B6wgqa6OIXc+swHV/jXZSwweJfJqgKSWz9aHwVx6AIRWbMDqYA8m+rXJ/9UXAFq3y9fEiq0uATDYxMFygRfafv/5XXV2BQWL4moQksV8oaYSy043YNVa6DMjkG9vkhh3Wu7cN/kVy7srTIqFfNhQWp1lN+4GFb4RgZ8tS5iRneU6lDF+kK2azGr3WpeFQtinqzOCrWM5ihYj41vTyYhBzWI4caUS5gkyPK0dbK3b8vRNZbk5CNzFX1ltDOqGyTi2pC58vlWW9Qdi7eA8vp+fMYOSSi+yzkILTWnNwglDuL8/Z7Pc+523KvKSJG/xlg3GCBQf+4oXGi67bw3XDdo8o8h3/wMiFgWhrSpGL6zfh3v+faSy16UPt7rdKu2fJnjaaLo8QSGOay0DgvUoD7e3OJO330rO/uRVSfwqK+lCngktwzWhnPKcDW2RTskFvYqP0lk/9xoyA=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(316002)(36756003)(40480700001)(8936002)(41300700001)(44832011)(47076005)(81166007)(5660300002)(70586007)(82740400003)(8676002)(70206006)(40460700003)(110136005)(54906003)(86362001)(4326008)(83380400001)(336012)(1076003)(426003)(478600001)(186003)(2616005)(82310400005)(36860700001)(26005)(7696005)(6666004)(17423001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 15:08:40.1123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76c9443-07e5-4d0f-6251-08dab763f722
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10155
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of such policy is to prevent a user task from creating an
executable mapping that is also writeable.

An example of mmap() returning -EACCESS if the policy is enabled:

	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);

Similarly, mprotect() would return -EACCESS below:

	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);

The BPF filter that systemd MDWE uses is stateless, and disallows
mprotect() with PROT_EXEC completely. This new prctl allows PROT_EXEC to
be enabled if it was already PROT_EXEC, which allows the following case:

	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);

where PROT_BTI enables branch tracking identification on arm64.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mman.h           | 15 +++++++++++++++
 include/linux/sched/coredump.h |  6 +++++-
 include/uapi/linux/prctl.h     |  6 ++++++
 kernel/sys.c                   | 18 ++++++++++++++++++
 mm/mmap.c                      |  3 +++
 mm/mprotect.c                  |  5 +++++
 6 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 58b3abd457a3..d84fdeab6b5e 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -156,4 +156,19 @@ calc_vm_flag_bits(unsigned long flags)
 }
 
 unsigned long vm_commit_limit(void);
+
+static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
+{
+	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
+		return false;
+
+	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
+		return true;
+
+	if (vma && !(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
+		return true;
+
+	return false;
+}
+
 #endif /* _LINUX_MMAN_H */
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 8270ad7ae14c..0e17ae7fbfd3 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -81,9 +81,13 @@ static inline int get_dumpable(struct mm_struct *mm)
  * lifecycle of this mm, just for simplicity.
  */
 #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
+
+#define MMF_HAS_MDWE		28
+#define MMF_HAS_MDWE_MASK	(1 << MMF_HAS_MDWE)
+
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..ab9db1e86230 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -281,6 +281,12 @@ struct prctl_mm_map {
 # define PR_SME_VL_LEN_MASK		0xffff
 # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Memory deny write / execute */
+#define PR_SET_MDWE			65
+# define PR_MDWE_FLAG_MMAP		1
+
+#define PR_GET_MDWE			66
+
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 5fd54bf0e886..08e1dd6d2533 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2348,6 +2348,18 @@ static int prctl_set_vma(unsigned long opt, unsigned long start,
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 
+static inline int prctl_set_mdwe(void)
+{
+	set_bit(MMF_HAS_MDWE, &current->mm->flags);
+
+	return 0;
+}
+
+static inline int prctl_get_mdwe(void)
+{
+	return test_bit(MMF_HAS_MDWE, &current->mm->flags);
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2623,6 +2635,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
 #endif
+	case PR_SET_MDWE:
+		error = prctl_set_mdwe();
+		break;
+	case PR_GET_MDWE:
+		error = prctl_get_mdwe();
+		break;
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
diff --git a/mm/mmap.c b/mm/mmap.c
index 099468aee4d8..42eaf6683216 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1409,6 +1409,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
+	if (map_deny_write_exec(NULL, vm_flags))
+		return -EACCES;
+
 	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 8d770855b591..af71ef0788fd 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -766,6 +766,11 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}
 
+		if (map_deny_write_exec(vma, newflags)) {
+			error = -EACCES;
+			goto out;
+		}
+
 		/* Allow architectures to sanity-check the new flags */
 		if (!arch_validate_flags(newflags)) {
 			error = -EINVAL;
-- 
2.17.1

