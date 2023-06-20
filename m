Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4496736CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjFTNNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjFTNM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:12:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50C120;
        Tue, 20 Jun 2023 06:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0iZXRtI4ma9//Ldx+uc+kAVwuqVFCRj+xxjCdzkOwEayYcG3QXTVBVgaqqSvIamvjHpIo+6NFsEiZLVNBv3dO0ArR6k/6JLX3WcvP5Nt/W3PQYEGR4Df6xoShtDOSgNHCm3HXsgCBH0SryqgSQixLlI0V8aRFoCupXLXWbsdIq8PLjO+whRnqYtph3VHiFb61bsdsjE5aysjTTqo3c6iBhEGd8heMB3o9rySE83oNJIeqVbyFDt/4jkCjWKfJSlEwYgs8XluN7OrHQf6lKn9zO9vupJRydhmOVEu4YMBWZncNh1ee5TDqWLMujpbrKnps0CHOlubHKU5Ma/MRNcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcst6nIyQ57zgJxcwu5bE/SOPr6g3bzRQx+zYt4Vn/w=;
 b=l1fZYKHWwyyhzrMx+e7nTrmwMyfpE1R6squ+lio38PqxbadjneO+jbCJp7gS006h849wGGCovxDnnShMzPOVTXTGCVN0Rzala3/c1Z6n1Bgrz8f8+uloPBRWyX+caWDViB9Nci+NfikYSV30TU/aKibiROjxpWBHQnDXieFA+3lUGn1CVaWIJnf1HMlyBEWMMuqKlZd+jSGPf/D3PKTFbIByijMfTUCl8KU5Gc4HJCWNjGZhgtcmqnVtJaBsPs34kQpHY/4i043eQdSYOQo5jfzclSXekhvaYtliuwbtDxRDf3mrOPD5l1UiYCoP4vJHsaBWfKsh24nx/b+xAnPAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcst6nIyQ57zgJxcwu5bE/SOPr6g3bzRQx+zYt4Vn/w=;
 b=R5PUnJdyEtpzI5tJvWz3E1cduybGgzoyA7NMm144y1eZ/yEFpGffpubrZRrq0ldUxiAIvv8PFuh//FWOMpc7WHhY5pXS3pOHay6uKiHma6yJ6Lp0DpQIWC5703gYr7H7NtWko0OIhIAx+qy/pmmJmxQv6TyaIBZyzeQxdYD1poHYKvTls+W+8UiOovyLgyDu2F1mVEspcTidqZURCt+UhLCm4gIM8SsPjuDXY+EiGO3d52F6tz6JD5yW39Z9v+LHIxshgN0FkxEWiBZ9XpvImW475zjTpce8gTXlgOGOFU6ozNuyQaprcEN1q73Vdt0dRu252rPM9ST5JFe+B9OoUw==
Received: from SA1P222CA0139.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::25)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 13:12:53 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::4a) by SA1P222CA0139.outlook.office365.com
 (2603:10b6:806:3c2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 13:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 13:12:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 20 Jun 2023
 06:12:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 20 Jun 2023 06:12:48 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.126.190.182) with
 Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 20 Jun 2023
 06:12:48 -0700
Date:   Tue, 20 Jun 2023 16:12:47 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     <stefank@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joe Perches" <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v5 2/5] mailbox: tegra: add support for Tegra264
Message-ID: <ZJGlz7AoaZ6YB095@44189d9-lcedt>
References: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
 <20230529135044.2746339-3-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230529135044.2746339-3-pdeschrijver@nvidia.com>
X-NVConfidentiality: public
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfeaafc-3889-492f-4db2-08db71900e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XG5OczPuFBoqmK8oIpcLM7bHQaKR0+BoO7IsDaxLVm5We6e2Py/+xZnmGw6QNXqqa0+d8YKtTHfxuD3NQJ9+IztUlESCi7NuBRmGQbwzAf3FDG9Id1yssCBl4cUanedD3CB4Juf9ETBcFWPOB70if56JXQj0fiz/hGiVO/Zc4WdowirvICtqAJBWAFMaFWZqDbMBV2020m6+zna514dX1Q+2/6UnkfSDatqTV/j7JOJ/vY0YWWHbzsAYEEH92ulSZnVmYuQP0OaMhYdEFAmHikD6Y1oChObIi6vGzsnNyS6pwJSsIBQewNpmZ/eFlJjraqwoGTEJGPrAz9kOkF+jlA84QUU8S9si5ch7vj4s5GmVWjFRfdigxySroD1vF21CYHAlqTeOaI1AUegNV2QxH+CM1xbFOGY2Q/JBmbWZqMnxPslSpr6P0sF9Ugt+DNiv0m5Rx7EDikJ//UREqe6UAD4dMPWxU8nT4ad/Gu7v1gugPPJ6JUh1iaJPpb+S6eQVplq+tePtQi6na6GJjGZLljRm7OyngC67BF/eW9hXb9KNoF/DJYFs60NAocCTDAAnSKzIt7jRXsGrJqULpOPWTQbDKqGRgZxJXOJEF4qZ2NPy1gNcN7wM8VdE8nZ2tM05JOKEl9jVVw6pSwN6pZexMXQKWU3/aLNTd1aDrdAMFer6DNpU3+xailpPYbIoj36GCghkqJQ+gyH+C0Xvg48yJdjPFUzVfHGNo2l3YmysHhp8IUaczt7/80rlxhM5Qny/
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(33716001)(40480700001)(47076005)(36860700001)(426003)(336012)(83380400001)(70206006)(9686003)(26005)(70586007)(6636002)(2906002)(107886003)(110136005)(54906003)(186003)(15650500001)(40460700003)(5660300002)(8676002)(86362001)(478600001)(4744005)(4326008)(82740400003)(7636003)(356005)(316002)(41300700001)(8936002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:12:53.2269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfeaafc-3889-492f-4db2-08db71900e63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
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

Ping! Jassi, any objections?


On Mon, May 29, 2023 at 04:50:45PM +0300, Peter De Schrijver wrote:
> From: Stefan Kristiansson <stefank@nvidia.com>
> 
> Tegra264 has a slightly different doorbell register layout than
> previous chips.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/mailbox/tegra-hsp.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 


Thanks,

Peter.
