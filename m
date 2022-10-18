Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE8602D15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiJRNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiJRNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:34:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897DECBFCB;
        Tue, 18 Oct 2022 06:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPtJb6V8+M9tZg2CMmr2ejva2+GRgW96SPJD68BqEtmLt0mvc3Nk/HkWC1HJkEhR9Rt75lH6ksd2bWzb9rbV5GN7ZUSbXNANetjjrf1HLYw+O8V/pAOiHWCkXuFwY2/um62ccZ2I2Klg162bbDoQ1G3aEL0wEHzl3kxZ6EABWzneitkvU/tBZ0atwlp1IBuxYVnRw8un/gMD0eAteGTme/qNzBO9s0KFzi7rVTGYiPM38yfGC3gmfzwu6Fu9QvRPVIGLF/QAciKPpOmSlj1dKBiNIRXJNq+w0jEXZNUff3joqt4JRzz28Ug4BNxc6pieK8b7HXfwAPGOlFuVQdvW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b13eC+2KuXTPBicsCxSvHT38HKHkd11rtdW3WHLqQaM=;
 b=JAFgI5ZW0/L1VchlB14STPgXaOwBMxbLiVhPgsrKo1iL0iyRByf8K/fiMQpHa6mU+fDPX4rhh19UOK0q8H3hjUlag547SVAIXvUF7t7AO76LCddUxxkKYv9lSG74pAirudecTDGjV4HFJKk6qO3PgJ3cB1CZM1Mj0IjqqFdLHTCGj+biGToQCvxaYAb21BNxjf0Mv2dEmcFEvNWVXZ4vbGs4nF9eL2OrnR2NbrHVyn0WRq7f20PG9ld4ON7p4d1FP3hRTWGkftV2i9JzLRpn2xXW7zwJzwsqQehd0fezosTudmtVrCUof03NAqoMPI0Bzd2W/HzPXgSDI8LzgMu3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b13eC+2KuXTPBicsCxSvHT38HKHkd11rtdW3WHLqQaM=;
 b=Q5CqBucuyaGarkLaNLWoB4LE0WFbyF5QihLJzcA19kL8n/gJnqKuF+suDuKIA/3f8EnnIja6DLyqC0jeO6spbQzrf+zV+J2J2sUUSjjZCpdjIbjKRke+9GSf+Ft2ONhoYRnd6X1Prewe9TkS1si7zf+Lv41WaaRS2MzyzT8RrB76W/mpbeo1rGY/PL6u5sFGgsbgAVEHX8C6QlzmLWGKAqX4MKiqfHcbB+aS385fG8le08Wcz4c7GE3pOxQkjXY9WsJVjydytfdntE/yzT334hNJlrOuMVSxaNYqRyEGEanC7mBrcipHC3lyhxeztGY9g7Sd1oa2wyDRMbP+sGTq+A==
Received: from BN0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:408:141::24)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 13:34:09 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::42) by BN0PR07CA0007.outlook.office365.com
 (2603:10b6:408:141::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 13:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:34:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 06:33:46 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 06:33:46 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 18 Oct 2022 06:33:42 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <jonathanh@nvidia.com>
CC:     <akhilrajeev@nvidia.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <kkartik@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <swarren@nvidia.com>, <thierry.reding@gmail.com>
Subject: Re: [PATCH] serial: tegra: read DMA status before terminating
Date:   Tue, 18 Oct 2022 19:03:41 +0530
Message-ID: <1666100021-16513-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <5935afbd-ec39-21f8-1585-57a932261271@nvidia.com>
References: <5935afbd-ec39-21f8-1585-57a932261271@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 042f4f41-da87-4902-eea1-08dab10d6f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WawO6g9uoU0ZU1GBxpuK0OmYj5/4pL31YFNrHi4o1iKpug5xcYAbaD9HJLhYDuqVgE/pymVJ0NQN8MsyRVJcVJtnyyZNHg4j9LNWVb8y/6TnsB2ZCG1HkYnqtTaXxZKil/mQPgJl1/0nvImglXOHMW2+uh3u85ufnZhcvAlie+IBigJZcHOdrci95H6UI0zkK0hVNlOAoEm8WNXWd3z9S2qkPgtlPvZEU6LYwsmde8E/iy2rJtL0pAUj2lFAAiz1dB7PL993XPZNJMkAUrEWYdlihfCJlKsaX5fKFLW4Ub8+2SjiPWEx5R92EX5UKD8mqx12qq8YzwM1YyUCjPrtyR26nn0S78ktKBpKClyOaTeIS4uzoN/FComE+ZMGEIX1c2rOHTFmskcDsc/GnMtaVL0J1Rv+zO+DASJhxQ+wpBxbN10BF8B6UllC6VqfThpmXZ9bsS5HnXQopCh2BclgVTQfgMPFXDHBzR3km3i2mDYNxKRoxpSuJCsTkm1BAWr8ClFlIff58EJai2+gdOnsBwmhYghCysYOgz1S2/aIhb4d+Ts2C2tRhRj8xXyfydUQuc4WXdk6UdoIR/i92qlZP0nPlqZj3YLM6cDFh8Sg/NJ+Itjb+xLw0CthgNW0TG3XLnZq4sSDLlyjWR4jwGMslFrcwtXCwDqaJQC5UMJLbNAhwXkMBoOxqM0UyatXk08WTVRwz5t2c0JPPbS5xt3K6v4xe0NGawT3SgD3t9mFdhfJfv31bG3MMqDEdk7ThVspTIU1hL0MZeco4T1Msa5I4A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(47076005)(2616005)(426003)(186003)(356005)(7636003)(86362001)(336012)(82740400003)(4744005)(2906002)(5660300002)(37006003)(4326008)(41300700001)(6862004)(36860700001)(40480700001)(8676002)(40460700003)(8936002)(478600001)(26005)(7696005)(316002)(6636002)(70206006)(70586007)(54906003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:34:08.6824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 042f4f41-da87-4902-eea1-08dab10d6f77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The change looks fine to me, but on further review of other similar 
> drivers I see that they pause first ...
> 
>   dmaengine_pause(tup->tx_dma_chan);
>   dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
>   dmaengine_terminate_all(tup->tx_dma_chan);
> 
> This makes sense so that when we calculate the amount of the data 
> transferred we get the exact amount. Can we add a pause while we are at it?
> 
> Thanks!
> Jon

I agree.. I will include this in v2.

Regards,
Kartik
