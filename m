Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4B9736C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjFTMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjFTMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:49:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB7E10F1;
        Tue, 20 Jun 2023 05:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+pmNaE46MW9AR602AWwFOo7ovLtgtTA6lg75GeM9TCqWz/aR8rSf3B50J9Ybr+TCLK1qRxPpLrGzTZCGqhZbANw/sQaGcYmOwsfLiVRZHlCyfA9LToUyIAzWIqmQHFW+u7mlDt3kdMPCvwAKktOUdhl9O28482so2zvmYOh0Ln0Whb1ywpX2UXthccMRpf/X7l1/fMyLVVFREHiuVXdR7wJgs00XO1gU+2WSqVrXY++oDM3mUcjjEZHm52QyC63janBxzpnxo0eXcC/8vV0PX4yFkFjAaQgT4YVIBvgUX4QRidpQer1ouM4EplhmPpPI4ZVLYtBb9e8AeN8GYqR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDD77sYFstjSeWmeoYQeR+dbN1Lac4TLwrm+tf+GwG4=;
 b=X9zyjnFEamEy+167GU2eWV207XOQH4uUtw0AgneTZ1BvaCXFMF2g4VlWevwKs4wTlJ+MPeXzoUq7Rqxe7vJe/hlDSi3grg390/0pdaNrMRXasIRhxeAg0ThJn5BHSdy1+lsP7v1FjJE+VSCwYPJphGd+RWdK7g5hX8lPtfnkxhYV+w8VL9NcjkAmNZOWPe+Errj+NgLBUxxQG/zTrK4p/7q2IrMXZn3lB/ImJdUFD3DsFss4TaeiBr5e3Q42FRm057Qj4siqYpHRj9x3Rexn2ZyImrGeUOYGS3vFaRObeIF/UVqOW016pQuK+6aYidyiNwCkcJ1JRmIyJicZqZHLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDD77sYFstjSeWmeoYQeR+dbN1Lac4TLwrm+tf+GwG4=;
 b=23RyYb6DwrJjfuEAYNkmu4RcVjAtSVxlPJol5aA89XI5EppJ0yNE53xeJtDNl2Fyb5v3sK2B9XrEvTGEy6u2GfjUDE0mKJn88Fj4oKR4FnYE3S27qCcFGUVaYuRps9MVnmtoRaE7wkb9EF23IboBnmFgSFsPOhkrMhDHUC6rtg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Tue, 20 Jun 2023 12:49:39 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 12:49:39 +0000
Date:   Tue, 20 Jun 2023 20:49:16 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: [PATCH v3 1/5] cpupower: Recognise amd-pstate active mode driver
Message-ID: <ZJGgTEdmsz/A1jco@amd.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619190503.4061-2-wyes.karny@amd.com>
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|CH2PR12MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 070427f3-4356-4aec-16b9-08db718ccf4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UvwQTSZfFp+cHa4W3BDzCogAHuIAmdjsrc3lah3Efq+6WZv9B3OC6y2TfLUpDpAMZ/7/65XqMIxlEUoiLFqHGqdscozIp0d44XuExLIQHFRdXUX0xVYQWRSNw0ngG5Fc8gIQIOB9fFzIPimNRQJu1C8A+1c4IS6oN1W3PPDF+tP61AL9hHcGPPPgWypYbdlFw2qWre2DZhzzIF8Cn+In4Di0cgk9s02LFJrS0ZcnyOLze0OWCabvR9OOCimRveO3PgMapa7W8SIlnn9OHK6yNscanO2+RdEgubrreNODK6oX7tKFYDns+8EngORUy+gi6pe1BZUWhlv+HU1RaxyodE/GRLhyfFi+NZInpKPZmIqUrbnKCpjR9p3OEZTdqVr5qZkt2pZeDdQOvVUgJqXKama4yit9hmV17OSCOlEFCdp/xmHrZy/fhtOdFYRwFYxyTd3JV4k2XgDxshKb7S5tn6nnevVj8tLl8353gPk9AAB+uy9fgfs3ibL9GjtsGtpGQjNwNHRg61E3Zy5TaS748ht3CTW4lOHafM1geC71DmmawNudPO77lLol9orPGBK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199021)(38100700002)(36756003)(86362001)(66946007)(66556008)(66476007)(4326008)(6636002)(316002)(26005)(186003)(41300700001)(54906003)(37006003)(5660300002)(6486002)(6666004)(8936002)(6506007)(6512007)(2616005)(6862004)(4744005)(2906002)(8676002)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?37f65gbKSfOQL3uHFC3MNgMCLrqIQeeBKFoA8MgF/nKMiERcMW+uRy+YJvFi?=
 =?us-ascii?Q?t9UgAhB3LNyK52WnRkf1HfHeVZfDUW5Z219ja/ltfptUg0C8sKD8B3iIY46V?=
 =?us-ascii?Q?JjeaPJ7auDjxVHaEhUBq8Y+hrj8FqIoKrnTFJijzKW8dmZdCrBVp8DqUA0SX?=
 =?us-ascii?Q?XSSgbtwzlxH6ZV621lCgQxRCDwoFTjoXl7YIvOFwewK1KrEEDRa88xyntZwM?=
 =?us-ascii?Q?BL1qnQdD40w3w5ZmGDM3nA78CrGpEW2dBDilabjvni+4UZVd9PrjJ9B0rchC?=
 =?us-ascii?Q?GhL/CPPeWfmlSzEI2DG0TwkbXeoCT8UQQ3saxlAoaKkxVWNMpt9eoUj+hGVq?=
 =?us-ascii?Q?issSGArRKoF7fxS111+N3H/RoKN4XcWgF6PWIdyMwYCVVYcfWpeudw21D2ZU?=
 =?us-ascii?Q?qox0nkB8ykQO6thsHA3UVGXx8pfWZ3y4SOYZos9LftRGhdxippoXxAx4Pj+7?=
 =?us-ascii?Q?17nl/0Oo9TClrEaRlgv5ek8wuTVKjhN6yq7R4OajT+RzGUdasRCluShmXneu?=
 =?us-ascii?Q?LIo+pE/7zdX1gHfaIALJTCF15viIQ0Iz/jVl031+77Un8KZBbz79r0hHi7n5?=
 =?us-ascii?Q?lSpaiGWiD70ejieOPHTIpqOX3Iu10X+ERcVngVHKpwqxerInI/xLrIB7aIwT?=
 =?us-ascii?Q?kTuBJvaqUZIE/AmjRNokLwIGc3xjEWvoowgbM3MiZyRZNu8y8KmSg/xXGmZ1?=
 =?us-ascii?Q?YQ3gaDSZIgKmU3OkQI6BgrD4dEIDZaClmnB+Njp3SuhSU5qA6LcRqobhD1/m?=
 =?us-ascii?Q?ce81rg1zo1GqFG/WyhhKX+0lhlWXIKd/nqrRftoI2Tzd3KuYBA/WjpRzzItC?=
 =?us-ascii?Q?GpvWvMZXW8otUsBgZfYbeNJ0Aho5/zmsS67dQv8BvldZMNMmUPC+9fcXe3Ud?=
 =?us-ascii?Q?wIeEIOS3pFrd7JNHxY+1zeK4RwErF8JVHeFH77/8suIm6BuKi/Q4xhRCoSVe?=
 =?us-ascii?Q?yftkcoOPf+EstTfdALPGodFNxG4zSj0wUW6N+t337M5HGrLZ8U379k9WqYmg?=
 =?us-ascii?Q?A18AyUtR42dM7jG7X/KNitL3TnbIP5Fa9FXIlutDczeJF0+8+QdD6E2WWQmB?=
 =?us-ascii?Q?UKHOmeZdUrxZme3A6dLMHPcGP3M/fB/xYggDsOhJmavCfHLI7E5I5uXhn1Kd?=
 =?us-ascii?Q?+UIVnaw5elomq4v9+0obgXHs7WgcFyjx/XX5I3K4g9KybVume1VGVW3IW64C?=
 =?us-ascii?Q?wV+2W3nwOfXTPUx7HddBUoJykbDkMRmB0w/FohH1XVgrIF9+6INacE2kUFGt?=
 =?us-ascii?Q?5Y906ExkZTb9PipZB+0x81+zwT1ULiIqVkIdhGXgyLTgaXkjY0Vp6BIPym1W?=
 =?us-ascii?Q?0d9xRBZ4/nldlcVOfXE+hGPcZisP0qYBUVtIrlPWd7pxpUeKSGdfE6h+JvB3?=
 =?us-ascii?Q?JVq0+8dy61UzHm1Z7k2TA2oIHt0eV0fxU/ul8FBQxq2R4/+Ur8MVu5P0RYOh?=
 =?us-ascii?Q?sGLCy0cmzoihOJXInS3s/Nk+aQr/08XB9gqrXl12NWSCQrGlrT0NdiNKw71l?=
 =?us-ascii?Q?r08PYvlI/xFsr8eLm/9kx5fzKezsjN+s4fc2BNgEmOuNOLtz6U1o/1qDBeBe?=
 =?us-ascii?Q?wojGUFAEOyCE9rW0qFuovoBwBPXStjazfTGL0Ar0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070427f3-4356-4aec-16b9-08db718ccf4c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 12:49:39.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVtCvM1cz4z3sBJDBaIQHTsyFspQVJrw+22F0WfvK1d8FX7udaiEZZZHOxk4Y2QkBdZcRETDBx0YE8P/d4fRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:04:59AM +0800, Karny, Wyes wrote:
> amd-pstate active mode driver name is "amd-pstate-epp". Use common
> prefix for string matching condition to recognise amd-pstate active mode
> driver.
> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  tools/power/cpupower/utils/helpers/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 9547b29254a7..0c56fc77f93b 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
>  	if (!driver)
>  		return ret;
>  
> -	if (!strcmp(driver, "amd-pstate"))
> +	if (!strncmp(driver, "amd", 3))
>  		ret = true;
>  
>  	cpufreq_put_driver(driver);
> -- 
> 2.34.1
> 
