Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A9D6F16D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbjD1Le6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345899AbjD1Ley (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:34:54 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02hn2226.outbound.protection.outlook.com [52.100.159.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358CC527E;
        Fri, 28 Apr 2023 04:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6nFBmnpI1ZIdRepd++Q6kblusNVgO58mMpvkld861igCDAN3v9qd+SkRXyLV4XfOT1J50uji6FLbJiET0n1sDSrTnHS5b8bf8CFqctTw8IiXKZDQZSAuEe/joFgk1LFJmev80PJ6xSOPGIN7i7fT/IfJfIHL8xGv4jJVHgo5y00uJIs26pT2rqiBklCYHdWZJbuMnp4lKtwJzyBNSh2ZqOJ2kn6hQYPphQDc+5wfz/3c8pLBtq8R9kjmWTav/jSqziJc9w1lmcW5SYczZdp9WvD0JGq5koJdSHNaEdrCNkvlYyxOCekKUS9Y6rRgMHz2zYz7BT/r1Bh4i4Kzb8RAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xbVv2VbX8npSIfd19zIuhI6419HjHm0TKvlkAeOJFA=;
 b=MtaS0RZYe8A/5I1euTgwa/yt8pTR7TJuHyuX3RymwAo3kF/U3MGC04CEEWyBJ0jqZ58IfoUI8QuQswcn6gIkE5oxZn2RVplIDwL/1OHHYfmO32jEASRA81fhb2KTP6CQdF82GEv66KMe2hfyDm/rRAjEkBrs9QN19NsOwkC+6z+S8BT2kdv3+oue9LRM2U+jv/d/LXysHfWhLkVKd4cYPNdHuAE1a/bkgArc/M7rjpi03sy1cBegcPiUMyKAp56Em01jAX5nlB6fVstIrFosbzBmEkGz8goWvKvQR7W8O37bNeRRvsEkctoNpFVyCIhpQoW48RAaDV6feGQFnAFptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xbVv2VbX8npSIfd19zIuhI6419HjHm0TKvlkAeOJFA=;
 b=BQx+kqzc3v0xRZqCxqIInK8AdEPPie3f9h5IFNfgKhsnF/wH+BJREKR1w+joBUzUU9Ttyl84JSRI58c6hoI/I2TkYZJi5WtPRgwT0ccpHt9bLkqgiJpodedf7XVGce5P09nGZUP5WUetdGeNTrsURyjL7wvPiTaiK9IjORZzPFaVy8sWiQ0TpuLDu0eYJBvczuyL1vYAKTUNjQwTpme1xR1IPD11DcCodRw+QMEVeRg7H4jtOlgjIto8YpFtJwMxQ1vh2D9sfCJn0Ke/U5BVkzNb0Xrz883dCQuajs6uewQ+E1MhCe3zugTbo7GR1F5UOjRoe/yoWBm3OeqVT+cwYQ==
Received: from DS0PR17CA0018.namprd17.prod.outlook.com (2603:10b6:8:191::18)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 11:34:51 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:191:cafe::60) by DS0PR17CA0018.outlook.office365.com
 (2603:10b6:8:191::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 11:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.24 via Frontend Transport; Fri, 28 Apr 2023 11:34:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Apr 2023
 04:34:40 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Apr
 2023 04:34:37 -0700
Message-ID: <e16e96a2-cb81-ee1d-c3e9-fade09c59bd5@nvidia.com>
Date:   Fri, 28 Apr 2023 17:04:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cpufreq: tegra194: Fix an error handling path in
 tegra194_cpufreq_probe()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>
References: <30b17e2219abc3a9a137d28bb51e53732bba5103.1682428267.git.christophe.jaillet@wanadoo.fr>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <30b17e2219abc3a9a137d28bb51e53732bba5103.1682428267.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ee6cad-bf97-4289-7cbe-08db47dc9469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mcca9jJMUiZf3la5JKTMe3bBwg7oX0nbVPqpkaPfUnS20eskQxgLnwT06T6Y4UQ41+VswiO8v3+jwM5tAT2AcQjegy4xzihK7sUHyQrIoaqEdU/+FJt6J5cdbFifphNzTejUb76BL85ktuDz2Z1uyR71g0m9nS1hNgtxcagDW4Wc9h20HMrkowXPVJXGjHbPtjYTRdFRj8xmdiG9v3VRgK6Wl500VC21DKILTDHQvOEEpdoFQl8cea2UyUjUn/QXlml8ysDfVAY2CHitVxbS9W8gnQ9jXNmOnfgsg3Tp7XcxXubLnZveJZ7sYyc9r/XYkyqpSWwfxv58L5pWSIO5EmKlGG5S+UVlem1xIV88pvKpI0k7hJKQgBGCFdoRWSpXbsJIOzr/Io1cXbY2mt1Mgrc/EnbLf7iJA6hHYqweA/eN+CNJavHvDPuTlutHLSK0RNubJ+uXrQmuviZ/tPp3E51pVE545Nqy/f8nxEJ42kJDKwFyfLpCA9aV4YTGLj0SNzu/b0V03C9/B2WffVd2dT14G7VuQdJtdq3HvdxGWafGZcBKfSDigs6tHRvLziWYYGiqqvEDdg7LwRYXgjAiiJ2yo+/nvUFydW/9W/vDOvONT37qWYD199ew4ZI7f04MEMyalAFE0azdyjt7mEW1kUjygRKcGttbEHSBNmNFDbZjUVDBSvT1Jud+UJjQQhsHXvVZ9nklHNqPMiKFISEOxK/AKnQXMoBt185236hC7Jii2EycRkgXXhx6/shotNMww5+HPetctjQz2qhBliJ9ESAZMlwUrW+9b7u/RioGpHU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(6666004)(82740400003)(16576012)(31686004)(478600001)(83380400001)(7636003)(356005)(34020700004)(54906003)(110136005)(186003)(16526019)(2616005)(70586007)(70206006)(316002)(36860700001)(82310400005)(4326008)(6636002)(41300700001)(26005)(107886003)(86362001)(53546011)(36756003)(336012)(8676002)(40460700003)(40480700001)(8936002)(31696002)(426003)(47076005)(2906002)(5660300002)(43740500002)(12100799030);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 11:34:50.9969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ee6cad-bf97-4289-7cbe-08db47dc9469
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/23 18:41, Christophe JAILLET wrote:
> External email: Use caution opening links or attachments
> 
> 
> If the probe needs to be deferred, some resources still need to be
> released. So branch to the error handling path instead of returning
> directly.
> 
> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>

> ---
> Compile tested-only
> ---
>   drivers/cpufreq/tegra194-cpufreq.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index c8d03346068a..36dad5ea5947 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -686,8 +686,10 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
> 
>          /* Check for optional OPPv2 and interconnect paths on CPU0 to enable ICC scaling */
>          cpu_dev = get_cpu_device(0);
> -       if (!cpu_dev)
> -               return -EPROBE_DEFER;
> +       if (!cpu_dev) {
> +               err = -EPROBE_DEFER;
> +               goto err_free_res;
> +       }
> 
>          if (dev_pm_opp_of_get_opp_desc_node(cpu_dev)) {
>                  err = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
> --
> 2.34.1
> 
