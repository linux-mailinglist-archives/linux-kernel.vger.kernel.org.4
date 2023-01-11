Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7166563B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjAKIhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjAKIhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:37:03 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2136.outbound.protection.outlook.com [40.107.21.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A222BCE17;
        Wed, 11 Jan 2023 00:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXkdp2WJ+Azi+JiEhfCeDQz1kdFYUIVkPe9+R1B3ARxnFUCWpoitH9e6tpdWM8G+2GpHP2w/jb+ktrN3WKVvExjWK+KyzDoEj1roke2A/KRuhFkDDghe5tkkNj7wja/iUJCiTEq0cJywymMNz4SAFwLftY1neKeJ2tsEygDIrXGIMjNDqhpxs8nDiBK2g9JeTcn/o8CPN9dhZHQ8lHXSWC+mnY8PCi3yqHs39U2QeJiPO1EvQOOUZn8u/M7yA7dGSQ9Gk25BFQnaQOa/oV2Jhu7D/XiURE7xwDX8XdxMy37BVh+3tEYbUNKkAn8xMYaknYWc8rlRHu1I7V1nPriW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaRZo3QhoE9vqL8aEINs+suEa0K5UGKPrBHSitFcpsQ=;
 b=YImrGmwBZVzEydq56zQKO/FhhT4tXj1EGbtkKp8/3kx4w55FRpNw8mXcf3pL73cAcCGiphPY6qvgPmrVN7e/MJUfS2E6kDZN2GEHp9hYF7q2YunyXA6k4dAmeY6+PoIy/U0lKNZCaYQ/4dxzU0pxSHZPC8FZKMALc8Xu37E/2ZFKnRzBC+sXCHqRltgtggmhFqEM7xueAzIIvZ4NjXjbPsDOTUXnhwVx7e90R9IdP8Y3Vq0nqY850XTm3NgkRrQeBNgHFcfUl0csIgX12DiGfNODp1FJ+e0FArDAR4Gpu10Q5LWuiiNNFZOsOh9DVRa9VnG5p//TQ6CflynT9PlZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaRZo3QhoE9vqL8aEINs+suEa0K5UGKPrBHSitFcpsQ=;
 b=dWfmiEYDD2o01dtz/gZkanYHVWHX7Osi1w0zbG1T2vQw+FQX2noibAm2MuPT7oph45bmnigGZS7aO9SxGeUf1k0juAqThQ2FyKvaM1ngqoPn356JbLx1Pjb4dV3PG+Lp2NbT4XdxB6cnZ45utaO3oAC3xslDf66mhV5YBvho5SM=
Received: from FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::12)
 by GV2PR07MB9179.eurprd07.prod.outlook.com (2603:10a6:150:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 08:36:57 +0000
Received: from VI1EUR02FT028.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:d10:15:cafe::49) by FR0P281CA0007.outlook.office365.com
 (2603:10a6:d10:15::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Wed, 11 Jan 2023 08:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VI1EUR02FT028.mail.protection.outlook.com (10.13.61.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Wed, 11 Jan 2023 08:36:57 +0000
Received: from n95hx1g2.localnet (10.30.5.13) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 09:36:56 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-rt-users@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: linux-6.1-rt ?
Date:   Wed, 11 Jan 2023 09:36:56 +0100
Message-ID: <12136223.O9o76ZdvQC@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.30.5.13]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR02FT028:EE_|GV2PR07MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: f68298ad-892e-49e0-7cba-08daf3af002d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/DonWKNBgdC3uJV4C0+wO1UzfiIGzB/od6zv2dy+BZojMKLBTIvEsaIeQRQAdQJvgTytW1vYC7SF/qc3k2hsQPOdC+6xUNvUSQpNVByzSmHgiPLPTxt9N/KRM41pRkSLu/aHKIuAN6RcAbinBEwXBW1vklByfEH1KrAI2QmUkZ//QzfxH19YaOc6MJKLRXgRITSQcOcySmX1tKtKuMJZqab25+57EPFGDzMMSAlZuHVDFE4Hs6BSgJoWdwOOYB6POuqoD/MA7BYuL5GfqOuBPyjmv80Xl61Ft2FnrGwYEhzLc6Ek50e5JgW2XA6ZnvsQS/zDbhhXkbpJGE2FNt1tuH+B5NB0r/fcV3blhpvq+S5/StnyeEA1kbIBD7JWH2MfINqHmd3W9TlkcfUAlsHY32F0w7F/I4fNR8T9oHe0Ma/LWaBdSxg14WPAmlsr/k8liOKa33qyCm957FICqoy5Ff7bUIL4Mr2K4gjRd4HFSfTAQT9PmLlhFcEz8BnC48zCQWKc2XpQjEbYdsThUeGG093LOmScFFewwhx1x5EAFG/nAXXX+uyLiwfj1F24H+/JtdmXiNOIf6rIlWl/CRHdu6EMWz5f2S0fl810CuvGE8lKCDAZ8cpaaSxnJlfCDdKTY1C8o4Mt2AP5Sy8+dctVDL6/laCToffBrh6fSMINWXrZgrT2zs0U2YTGXRKWggRMJnbKJmUqU8OJJXftpTQXhAsOXyXjwbLqDoT1hyqp2l2gmB38bZDc4+nEUHfOd+5LBdHDkd6QY+JconPYlTopQ==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(966005)(26005)(186003)(426003)(47076005)(9576002)(8936002)(41300700001)(5660300002)(82310400005)(33716001)(36860700001)(82740400003)(450100002)(316002)(4326008)(356005)(8676002)(6916009)(81166007)(70586007)(336012)(558084003)(9686003)(70206006)(16526019)(478600001)(36916002)(40480700001)(86362001)(2906002)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 08:36:57.2903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f68298ad-892e-49e0-7cba-08daf3af002d
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR02FT028.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9179
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-6.1 seems to be the next LTS kernel [1]

Are there any plans to release a -rt version of linux-6.1?

regards
Christian

[1] https://lore.kernel.org/lkml/Yz%2FZWBeNZvKenEVM@kroah.com/


