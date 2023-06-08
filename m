Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8C727EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjFHLWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjFHLWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:22:36 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC01FF3;
        Thu,  8 Jun 2023 04:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL3JXbMuaZ6h4cFz4D2TS6Q2jZfhoS57RkI+9+RUOLRJmC5r4mEit3h2ci7i9aHQnOWvClmBaW/uAFSh6JdC4kK3j0mB1QB/NyN63eG8tijvf4IIZWREyKl2h8ipcd0eOoy7DsVTtAm1Y8g+3R8Tq5ZbA0NoeVud56vP2OTJxpXSEy+JtC0bl4KWITaESpwyATXQfszlfrATSGAAjgHb2TB/03CiFWKeVQKcD/xFzma+aFlsWW9Ugi2MzjscEqNTGtvVjfLf0/qb1k/KESh2+pInWFT8KSa8C2gasQKUKHKUImuvOa4QkzvVnVQ/dKVMLqNjlmA6j8wkjV/Ob/N93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8n9UDIMEMovSU3Fgc0zS7mn9Br48qkGEeu94ZQFNQE=;
 b=lSbiOGvbesLvaK+ewe5DTd1SKW0F+to/7r7aPB7/UPTkMybZYFSdgHnUbOMsjC0fBk+tCvIrldEL0yXPkFsOOWIV0wOAVQBnn/qVxbvzMRqU2gBNprT2V4Y5bLauw2WiaCBBaBHqrYatOFpFAkxLCjM6FkllpuwdUwDJ8kUb4j4L13jybpg4gVnX/+Z64rqG/JxiAsDnN1yP2YN0voAIz20kVzhxwn1SY1Tk4mLcseglVkRda4U6M357nKm5QFkuZeMoztoL2fKyQF+c3l0srOVWiOAZvvVAnYV86YGpwBcuCcQ2KbI36+v4x+9UiKh+QntIHfk5e5diZe5WRPshOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8n9UDIMEMovSU3Fgc0zS7mn9Br48qkGEeu94ZQFNQE=;
 b=URow94IGCikZTlelbzkh3KVBDdwMQTCgKfRFKlG+U7KmPlMs+ghGpApLsoKKbGIcVBZrukmElCnrsX6YLOPVpC8LpcNhWTg9GQ/yrmzERpJ9eCTLwSJnixExZu20hBobdUaCheUWpYXQYk1J18lZWRjXfdJSBDccXHVfwhXCf0q3J3Mn28lor/5G11yHhgIYVbQdKy9VWnntnbCSVdB2cE37mMcs69IQ6oGnUoU9UmKIXm3puIjbYfqkk/Rat5CloiKCyHAch9PbEtT4F6vv8kouXmRMXfBXqYkMN+qTqf7GNs4Wym/Zw8uOq9lglwMtvE0N3hq+hkFxghzhYcLk5Q==
Received: from MW4PR03CA0062.namprd03.prod.outlook.com (2603:10b6:303:b6::7)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 11:22:33 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::4a) by MW4PR03CA0062.outlook.office365.com
 (2603:10b6:303:b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.25 via Frontend
 Transport; Thu, 8 Jun 2023 11:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.25 via Frontend Transport; Thu, 8 Jun 2023 11:22:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 8 Jun 2023
 04:22:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 8 Jun 2023
 04:22:24 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 8 Jun 2023
 04:22:24 -0700
Date:   Thu, 8 Jun 2023 14:22:23 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <sudeep.holla@arm.com>, <talho@nvidia.com>, <robh@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>, <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ
 GSCs
Message-ID: <ZIG571modfPCnl2p@44189d9-lcedt>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-7-pdeschrijver@nvidia.com>
 <ZGNOXO3rRtFx_12R@orome>
 <ZGNS9w+i9Y9gpz6R@44189d9-lcedt>
 <ZICo8wYqM8tmCEob@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZICo8wYqM8tmCEob@orome>
X-NVConfidentiality: public
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fed3349-8bc0-4751-6e4d-08db6812a774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8WwRFPzillpobBpmB0acOrJo83HiDUrx7TZlOdZwkURbDSwkZjdp/kVrZdD2wUyy6Fpo0Zcn072Ko0Jd6GZjS82i1M2zHIxOaLotpB7CSdQFmAIvkShBobx3e2R34unliO2vyJ8tKr71HY8w9+tGrcKJgS/s6qwtJ2JAojpqTEx2WOk6Fxiji35jRVMgFiQcGHak7WzaV2cyHHt60UsdFq6ExbeERSLubjuds5R93hYtbqsl1UrdJ3p+wMR+J74nwZnkKY+0S/ovOLrGG+JGEGxcl6fDe4nbf4tMSIzvLbhulEpN8ipBSGb0Ep0wbftX2BvwM0Y2zN1m4bqVsvEnEU47woI7/7/4wEWNHDYZ82nurrx/aGyduSt18eHUg9PwVd1ndIfV6nBZvJd1487CZW3RpeztO1sDFxgt+p2CP/7tHDqW30oTddmsDxvvHj2BKx3Jpg5hOcfP5o3MJuoeeyGZRL8+KXGWb6vLDQJ/43odFKsQkx3jOqr6kaC5hO4pETmkTUDjlPEPHwveeyPqGga+sI0e0KabDx8lhvzJOG0yUAtzdDs4a7B/7G76qfvK34n5k5EFD84DsZquSc2EaL++XKmWcPz36n13HvJfyr0np3wLjN7koSmj/oAY4J/I7Jv97xeuo8vDnG2A9nyhAtWSJ/sPs9iU80R8WGy6XbGHkkW5odOWaIayv5XofLYMpltw40JVFczRvaIVX4stRm2AoVaHbQxiCuC3VSi9GL/cFy/QpOpKOmbgm+lca8b
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(426003)(336012)(478600001)(8936002)(8676002)(316002)(41300700001)(70586007)(356005)(54906003)(70206006)(86362001)(40460700003)(4326008)(6916009)(5660300002)(7636003)(40480700001)(47076005)(82310400005)(36860700001)(82740400003)(2906002)(26005)(186003)(33716001)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 11:22:32.9620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fed3349-8bc0-4751-6e4d-08db6812a774
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 05:57:39PM +0200, Thierry Reding wrote:
> > No, on the contrary, now it's clear you can either have void __iomem *
> > and struct gen_pool * or void *virt but not both.
> 
> No, it's not clear. You can have one part of your driver write the
> sram.virt field and another read dram.virt and they'll end up pointing
> at the same memory location but with different meaning. That's why you
> need to introduce the enumeration in order to specify which one of the
> two you want to pick.
> 
> And that's exactly where you start introducing the potential for
> inconsistency: now you need to be extra careful that the enumeration and
> the unions are set correctly. You effectively have two sources of truth
> and they don't necessarily match. You can also end up (at least
> theoretically) with the invalid value, so you need an extra check for
> that too.
> 
> You can avoid all of those inconsistencies if you reduce this to one
> source of truth, namely the pointers that you're going to use.
> 

There are 4 possible states for these pointers:
both NULL
both non-NULL
sram pointer NULL, dram pointer non-NULL
dram pointer NULL, sram pointer non-NULL

So how is this one source of truth?

Peter.
