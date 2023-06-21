Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF8A73835B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjFUMHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFUMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:06:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1772120;
        Wed, 21 Jun 2023 05:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH+0YgOGSt34gIbbl+ofDPCXAG2BrMLNNexSj2+srJy88GyWoKWNHqvHxDNtK54yNN7hG5BFoq/yFE18B9pWTPtCtgdzapF22eBWOJ1zE/Z9+3nzqJX+Q6o3P4w1xRzviMAxYp0fgIISo16NSSVz74fYbYrOa+88pj3kK8k5v2dSCcbAlD5Pmn/FQNPIa3GtYoaZbPkGRCXsLYD0vtcrARBowq7hU72/TdXNKgLFn2DmWjXfrKFl1etYjgr+M/m8F5z05sRXM/sFajKzgg55sDAwu2T8ynGdOBpVKG4CE7l31dkUCbcmDGdohb9j0WLbHoPNThm1sVFvLL3u6IlGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QeI7ERQXbaEiriHDWMa7hYWQK+bpmZ1tT8BwU6JHMY=;
 b=UyR3ylsAIr1AANCvHdxKxMeud9GlPMJ0AeKzfvC/yyknLumI3X1a02p3U5EAf+bfITmV+epR/YQTfE0QD5SGtgByAvkZ9dPz2uJUffznMU01b4lpYtEEI6kXxHVabV6IR1e0g9BVbjyEyDebEAlPFtXb/fXEGt+W+W4DpMgKFFvmVLgRMVoqnO7WMuqTTyWv/AkqWQPSiftMBuR6oug3HBYtgSIcfV2udejvAAZV0plohuIouxRjdGIB2SS94sB3TruwYaDI/utk3ZnaZeSjdsp4P8GxLDc8anadTZ+sfL9327Zq3ujLIQ/91uriJcVF/nD7a9yf1yCeLX46SKhbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QeI7ERQXbaEiriHDWMa7hYWQK+bpmZ1tT8BwU6JHMY=;
 b=t1EupvCh/PvTjTEXZScneiEbvT2RS4oY0VKKoVWaajDYSM2rdYyb2lZPKtRctGsOn69FKzUiaa1gyrvjd4MVxZD8dulTSMDDSYguwQu6p9ptZNVbtKi22abdBkzyRC6XhAFNoQGIoCdu0ouRRxxxXQzWLYQvz4qSMclX7Jecs+pAqf3E3wZfBdwhcAbxqL6ugN92hTFAETwTHazcSfAzDtVlvwkkhwEf8WunMD19PCENwgzrOL6TMH8MafrZYX01+7iPwFp86kv29Xw5Bc5ndn08NXJymFBHs1JcH+1CLnD8qTGHTvKDH4AmU/O7Do8nUyVUGwj5gVzVlHv9ZQNRkA==
Received: from CY5PR15CA0093.namprd15.prod.outlook.com (2603:10b6:930:7::21)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 12:06:53 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::ba) by CY5PR15CA0093.outlook.office365.com
 (2603:10b6:930:7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 12:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 12:06:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 05:06:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 05:06:42 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun 2023
 05:06:41 -0700
Date:   Wed, 21 Jun 2023 15:06:41 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <stefank@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v5 2/5] mailbox: tegra: add support for Tegra264
Message-ID: <ZJLn0fkIi78jO9K6@44189d9-lcedt>
References: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
 <20230529135044.2746339-3-pdeschrijver@nvidia.com>
 <ZJGlz7AoaZ6YB095@44189d9-lcedt>
 <CABb+yY0nTx8SQs1==rD3hdBJAvLjHW1R3_Yw40f4-oLNweXw4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABb+yY0nTx8SQs1==rD3hdBJAvLjHW1R3_Yw40f4-oLNweXw4g@mail.gmail.com>
X-NVConfidentiality: public
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: dece18cc-5940-4960-c8b6-08db7250003f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1JsQQSBeVrZ3gDbdjwRoX4QDU2cdDqUBKjCv/+OenjfnC/5y+RI7Fo3o2a1G090GZ8yqNKcYi4dyYSrlbrChxoKNApVrNwFDYNsVQ6fdogLkMFbfKoM3YHc4cchVHzXJJ260zbUqSewUy6Fd31zH/fI0rKRzBs194VzxHTaK1iVUImtaxO9eFYuZVJ40PGxftgi6nOtKdwTfsoQRTb1i3vQdV5oi1GzBMsMLu4IawgEOpbFiVc2mFyvPai5l29ZQcjfwujpejFO9FKVsrUEGmC94+z8LidpeMrPobphW7c0BflaFG9hRDFyrLRmMkQ7zto9wFI1oXfqfiWjq+yvxzr2lonxAMLfd3PgFzLgfn7gqMzlrtcYljwvkDB8zPO/KaVeVCmuVPEdAcjWY4461yUv4K+NYjSkn+6rgE7ur+x5tKf8RteQdtxeH8rpiDzaN/iHLvlfO1t16/xLc37eC4AgB+JxmoQ3MGIacNAuDNSRTKm+srLQWsgn1nk+zGNGTUZfCEphK1WRPq/pIe731zwKKRhkcrftN+/58hV90Lk42YZF9SRKA/ALv7d4mU7j7oexW6y7/2ZcvNcS/4EZTT1yCP+QcQNZOc15lYHFQT3Sh7ExffGzwD4SawA/0VByIGD0sDXAcNTpMZnp276evZjMv15DXCAWZwNcysYVHlPMyRQ3qH2/ea9exNYCuIyFO2cGkTnYkGexb7+uipZ7qLSRwqBYzknFbj6UhaxkcE9Ys2JrNEFDSXej2stNsFYT
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(33716001)(40460700003)(8676002)(82310400005)(54906003)(2906002)(426003)(86362001)(186003)(53546011)(336012)(26005)(9686003)(47076005)(478600001)(41300700001)(107886003)(8936002)(83380400001)(558084003)(82740400003)(4326008)(356005)(7636003)(70206006)(70586007)(6916009)(316002)(5660300002)(36860700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:06:52.8781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dece18cc-5940-4960-c8b6-08db7250003f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:08:47AM -0500, Jassi Brar wrote:
> On Tue, Jun 20, 2023 at 8:12 AM Peter De Schrijver
> <pdeschrijver@nvidia.com> wrote:
> >
> > Ping! Jassi, any objections?
> >
> None. It will be picked before I send the pull request.
> 

Ok. Thank you!

Peter.
