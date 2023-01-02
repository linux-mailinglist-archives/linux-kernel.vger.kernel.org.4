Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07AD65B01E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjABK4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjABK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:56:27 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C61637D;
        Mon,  2 Jan 2023 02:55:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNsHiFzFBLf9SEmAsVEf7ayuQx7C5oQG4n4PLjxyikU93bmC/yldJd8ORzV916HlMpHeRvKO7m5UkYJu39DSHTNvqZ81lByXJzVyVDZSEV8gecGRIEw3nOT0Aawkhs0P37Fq3QBnfx8VzF2ecIv+tQb8MgV0vooMP4PnsU5hFjy/6eJeGOgunR7mxR2091tRAZ6LdtInPrqEiJQIlTIJx2i0M9wIYCMgHxoDwn+/gZxsbomtoSw4R+Buo1UjW/Oye/6FQPQH8PUqeQVGtcAGujgwOCxFn5pL+kyzdvk8xu2HFyXotJf2thBEzfIzB80msNnhj8cU+lUYSnNP108NxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDhVrzEWdb8H8mxgsnWKpJJkP2MAKt/MlFvG67lP3xk=;
 b=H11IpfTVW8Ec2XUiu9QbVtndad+F71XLkX33evp3Wwtq+YERusBQPZvbmulyeQaSVNVlUWu8rvTl3xQoIMPJ1rBDa9lb/IiCyCyh6916kLyRQlN2pBZ+4stN2JfOtnf7zDXrq1cP/3wYL8W/RooHy2n65uropsRk1hFaTBaUO0ibTvLL4phVPzJym2oT4VYUb1GpQnCUuPZ/TK3mUO40xhkj1H6/E1tsb0cKzisCl0LhuZW4bBVlqVXTJ0g+pC4O2htyQbx0LKPPPwFEveGm01w/kWbsw7UtFsikUW58sHcdQiu1D9CkKITqnahHokiUIAbi7emV8iXShjRjT0B5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDhVrzEWdb8H8mxgsnWKpJJkP2MAKt/MlFvG67lP3xk=;
 b=OOHPINguCfO3yYlGlGlZXD6EzJVPTEmgobIg3uxByDuVeomI9pgs4KEqA1TWAH2/46vZ416Zs0H6XkhOUKKs52BO/IC/jac7QWlrFhaHYok4kTu25QGa43RP7TtGRNs3I3MbC8d64DVRP/NLNFlV0QCgK0DXy3ADKR8xgbnKbHM=
Received: from DM6PR08CA0012.namprd08.prod.outlook.com (2603:10b6:5:80::25) by
 CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 10:54:59 +0000
Received: from CY4PEPF0000C96D.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::f5) by DM6PR08CA0012.outlook.office365.com
 (2603:10b6:5:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Mon, 2 Jan 2023 10:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96D.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Mon, 2 Jan 2023 10:54:59 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 2 Jan
 2023 04:54:55 -0600
Message-ID: <df5fcc0c-c690-f213-6bd4-57806ea6b67e@amd.com>
Date:   Mon, 2 Jan 2023 11:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "Neeli, Srinivas" <srinivas.neeli@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <2b041dc8230a4ed255051bb2d323da8a51a8d0be.1672491445.git.christophe.jaillet@wanadoo.fr>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2] watchdog: of_xilinx_wdt: Use devm_clk_get_enabled()
 helper
In-Reply-To: <2b041dc8230a4ed255051bb2d323da8a51a8d0be.1672491445.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96D:EE_|CH0PR12MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: cb53298b-01f7-4c05-801a-08daecafcadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h72XQ+RnohZIlh1DZcWiDyRHkdXn2fkx27wIvd2TztB1ZhOhvZYQVzBftEml1/figMyhI4EXQIwBDDlJmQD/2H189qYt1F6g/6qDL5TI1CfdpH4nuVVeeA4reN9vE7451alyXq/CZBmsyWL+ZIjeFrorHa6dR3XPd+w5mw3hRD/klSeIQIyVl1sylNJB+RBrc0xaOxWHaOf4oBeOGS0DBLAyohmzt/mILVVe43WfpFyW2FeL6iR+cEJAMlYhJvgHrLggP+5a51WvnZSWOgfGv1DRxvVfH4CE219P1QFAuusLWH4EEhtqeTYso37C3HekDakCy9C9+PmRTPmB2lrBUf0ewd4r+2gWvKRLMMySYudUeC92QfCjQ4Q2yx5Ajz2Wml6a9esgAcW1bwRDG5VDHFLcITjzBV7bOwKGGoyqMJ+Lnlz/vU2ScERfYyOX6zn+D0UUpF4YZScoX1W6Y6ET3donpcaBYhTHxGt7IMo6yb2xBaM24K1sptS7bxlF4os+gJKKCauQBi6diz+d49qH9PagzPN92N4RiX7Z+Ca7KrdDAZ2BdMc1LIwK6YaBztPNHcwvttMm6hvd3S5soR8SBqP3p/onR1QHedn+AVeGwZ7+Ahj4kV0iL7p7VNbXHEC+bF+NSIiFWtMcPOY2udBHFbyG+qfhu/R3HHFZCfU9GKR8HP7ZlIK12u5mxj9n8h/7tv6UHGr3vMit1x/FsLWPz9Sk50XY/tslAzRrLKajs7QWP7RAkzM7fZ99OvFHJlyNxl5d+7DCMdL2EEZwPIuozjDdRg8YMoDtWO3N+cExnus=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(70586007)(2616005)(70206006)(81166007)(8676002)(40460700003)(4326008)(36756003)(336012)(426003)(47076005)(41300700001)(6636002)(316002)(16576012)(54906003)(110136005)(356005)(2906002)(86362001)(31696002)(36860700001)(82310400005)(5660300002)(82740400003)(8936002)(40480700001)(83380400001)(478600001)(53546011)(44832011)(16526019)(186003)(26005)(6666004)(31686004)(22166006)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 10:54:59.2132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb53298b-01f7-4c05-801a-08daecafcadc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++

On 12/31/22 13:57, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> V2: remove xwdt_clk_disable_unprepare() as-well
> 
> Note that the order of operations is slightly modified by this patch. The
> clk is now prepare_enable()'ed before calling clk_get_rate().
> ---
>   drivers/watchdog/of_xilinx_wdt.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 3318544366b8..2a079ca04aa3 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -154,11 +154,6 @@ static u32 xwdt_selftest(struct xwdt_device *xdev)
>                  return XWT_TIMER_FAILED;
>   }
> 
> -static void xwdt_clk_disable_unprepare(void *data)
> -{
> -       clk_disable_unprepare(data);
> -}
> -
>   static int xwdt_probe(struct platform_device *pdev)
>   {
>          struct device *dev = &pdev->dev;
> @@ -193,7 +188,7 @@ static int xwdt_probe(struct platform_device *pdev)
> 
>          watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
> 
> -       xdev->clk = devm_clk_get(dev, NULL);
> +       xdev->clk = devm_clk_get_enabled(dev, NULL);
>          if (IS_ERR(xdev->clk)) {
>                  if (PTR_ERR(xdev->clk) != -ENOENT)
>                          return PTR_ERR(xdev->clk);
> @@ -211,15 +206,6 @@ static int xwdt_probe(struct platform_device *pdev)
>                                   "The watchdog clock freq cannot be obtained\n");
>          } else {
>                  pfreq = clk_get_rate(xdev->clk);
> -               rc = clk_prepare_enable(xdev->clk);
> -               if (rc) {
> -                       dev_err(dev, "unable to enable clock\n");
> -                       return rc;
> -               }
> -               rc = devm_add_action_or_reset(dev, xwdt_clk_disable_unprepare,
> -                                             xdev->clk);
> -               if (rc)
> -                       return rc;
>          }
> 
>          /*
> --
> 2.34.1
> 

Srinivas: Please retest but it looks good to me.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

