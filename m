Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1677654CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiLWHqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLWHqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:46:16 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A525B25EA8;
        Thu, 22 Dec 2022 23:46:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SISJ5hA/PrdCi6BoN0Zw1mAws66aOvCqYez2+GDsiZk+L8qtvNYeodcnYYMmXlyZxJA0emjZGygmrAKaYMNR6cNrMNSLThWoVOO9EXqvzwpiElFzTTQ4OXuts0opj8KJXgoWRX7+YngWO+Fh0Gwd1MpfEsOVji1UN8R5xgTFtue7QrQFt/muH5/iW+dm+/wocKLnSsD/1Vksx8j9U88Z3YGWXND3wjVOPCpUMin5oH0zJHHz1vpUt2YAXxiv0H1e2ShH5hgXpBEmTIzw6HJcoHs2r7SOd+dombQjYnL5EWss5oE0tSiUpphcW+TQn1k5uOs4LxVFOX8rwvbqDZXzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Stm5rAG3zMGtzU8bMW7AJWf55Hek/7VWKjcT7I2sve0=;
 b=IHR9PO5Cjv+GljO6qEZc9dBNpVxIyEUuGsS4LIsL1/DJNhM8XikFr9kBFzNLyTsoBQybl2+JkKYb9m6b7sCxNWJahzqZaD55R7toq0b59nnI86+MYeY26FO+Ikr3Xgg8s1BZE4p92FYK24cI6wYVdI37Faad2Vx02jC4Rs+I0tCwUTB1b/U9i4qCD7YDtZhGG7f6stqBoTji9UOON2GQAjTuwgJTvuGV/lXWewrFPWOuFPhVz6CZzRHatXshnXGd9CIs7G+HIuN0xZbfe96ona65HGOylli3PrrXf+iTfXyRdPX/h/n7qm/AR5WAo44U75kAOzyqscEXUaRcbHchvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stm5rAG3zMGtzU8bMW7AJWf55Hek/7VWKjcT7I2sve0=;
 b=KeUcA4IiyRcjglZxIwVU4gcZTq0u8CDzD39GLDX/Uz2/0u0ApZMarSORPRVq4EwlDdnZafZopUcMTnugzu+HfKrZfNCizeFyFma8rOnbJS4Vgz1rTrZPi1Q0Aj1CM/hkBfHqjpWeBinjfEryhY33DB0/F2tBoNC4l52RqeIFcWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 23 Dec
 2022 07:46:12 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Fri, 23 Dec 2022
 07:46:12 +0000
Date:   Fri, 23 Dec 2022 15:45:49 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 12/13] cpufreq: amd-pstate: convert sprintf with
 sysfs_emit()
Message-ID: <Y6VcrW6pYDCHx8/1@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-13-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219064042.661122-13-perry.yuan@amd.com>
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BN9PR12MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 255b48ff-99ee-49c9-ff1e-08dae4b9c34d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhYiat4/l0ea7uQsHAzp+950iECwbPx3Ui4dY9HXZPLD4yMU/nHc81xVAx8Vpoyk2mP5kKInt2942IjgXPC2yY7U+N/pEi3iu/zdGc5f5KgywRCZ/zSG2cUVSE+C7eQG2p9Tiq8vhPtzQUbDuKJedvDBxcIGZh+eUY6czF83vZxbRx33Z/zxGQVITXnuxiNKY8nacC754l6IARwiROnKG8c8pmTiIr+t/kHq1KyAkE9+PI+jO1ldAbEnJP1g2d313jHHO0AQasD676zmJXmTyzs86IF0ZgaHkZV6iRG2fO/CQ77ad0h8sgicW8J3twIK4XtCohffrGFxUd5NdDW0zLKRgH/Zu/0DG7YE5cKCjr87jL2OXytr5LnD8WM7+6dOAJrS5L/ShAT8s9ytiSLsBh7VW01mTR83794CW+O2JSMSxsL31Yj4VliS/6KTFuh2N8RZUVTYozBG2XzT9NkgR18nd2i0QK1Av7N2B7mhXUjUwwFuZQTQWrFInOE9/YrE2oFvdSPQtpxH0JqNRWSVBhgCvwUZuBjGEC8Yr9FQ5qvomDO2tyNFb6bzOCSHLDebnnzw7KdlD2zXJvF+GUr8Zv5p6DvE3QyR1U6efnVmXCHMotmbQ13Me+yBh3suv2x/B2peI+Dkedoeh/9HAlji/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(38100700002)(8936002)(6862004)(66946007)(66476007)(66556008)(5660300002)(4326008)(8676002)(41300700001)(83380400001)(478600001)(6486002)(54906003)(36756003)(37006003)(6636002)(316002)(2906002)(186003)(6512007)(26005)(86362001)(6506007)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hiPRUNfB/XA0bRA7MSj+lT57CRiWNP648wtUp5USdUuHQrBRMNc1XpRvAS5v?=
 =?us-ascii?Q?rD5z6fbDsI4sGvGsI+Klay9u6Z/VetdvPCMxC4DwqLkUphOrX1ehVtarCDVs?=
 =?us-ascii?Q?Jsv6HBTd5RBryVMmbZaI0NY8ksDUml0uc+yIUIPPJ9vTWEEPR6SmKM2twJbp?=
 =?us-ascii?Q?NJjDNd4szwckhbN85c5akm4byEec6l/vyaqBBBOjs+zQVx2bAglRLmVxZ7qL?=
 =?us-ascii?Q?9YFb2uH3yu6yUujtWXuLRMmLEqGyroKCDX0VmZuPH0mgTcNROdZRjeVDnOHz?=
 =?us-ascii?Q?iY5TOwE4mAO6Ln77rf4+NgYY3DwkI9UUUFbLa+xAgBSqCqxrcZnqHTvf8dBY?=
 =?us-ascii?Q?S1jsCVcD9eEdThrKxg4eOA19uO0TVONiZu1BHYG0oCUHN8pTrHuR/1zO60dz?=
 =?us-ascii?Q?VQ+SvEzHvaIPM8MxEY4Z0a0MIl3c9enFabr1bZmsL1eCKsGlepwnwQPdUI3h?=
 =?us-ascii?Q?Ykml3VKaBviEdchxtkU4pbR6cq50hvBLnc74JBx35tR7RJhJ6PdbrNv60o/w?=
 =?us-ascii?Q?0HWx/tF3Qsof7YRVpxArRA5lnO6r2vIwQM83If6q+pOl+Oul2XHsguB/EhFA?=
 =?us-ascii?Q?Y/dIbql2Hbg+XnqB/2kFaKtoXM2gf48DBb+zJYHy6L74nXNz2AOCsxTowT45?=
 =?us-ascii?Q?fX2HnBhwzK69AWqJQk9Bsn04g9SA1AXo595Cih2NPI1ObPQJttO9TBTiiv/i?=
 =?us-ascii?Q?06AwItm2UEG9oEqrXSD1aNATUXSE2wmfKBg8XqI9Dr7aiwRdIm4iYeednj4W?=
 =?us-ascii?Q?oFv4P12YrpPImHuqhy8hCttIkvKAXFaMKuMPdAXa66nPrkKQTvVPY82JZEQI?=
 =?us-ascii?Q?Xuyi3F6CWFXRaMp6sKEubmC+8TREseujTEyAXy/AQE6jKmB8L4arKmaUxi16?=
 =?us-ascii?Q?gpxLXBkjqh554ye5Qi4fJ3vWrmVuce6blMwF9X/aI0pmyrKQiRrU6UlpkUWW?=
 =?us-ascii?Q?JQGP2vFSWyV4KYH/2bCpgWD9HPfg7gS4An+y2t4pzM9CBOOU6YVYAZvcNrhg?=
 =?us-ascii?Q?vcUNlEGB81MMjPae1lNw1EdZZiySVSPYKXUgAfOdtjQ4cAfMk8XVMeS/4XAu?=
 =?us-ascii?Q?aD25XcxUof1AOl+LTyVrPzkEpafvy2OaKUJZoKeIrIEdwvCytXEuomfrpUAY?=
 =?us-ascii?Q?zTcPD1V8MvA7grZeJxL5EXRF15EJdnGXZ1PKt6CRAi7BekONCLZOFtyYE9HM?=
 =?us-ascii?Q?ssHYNOsIWKrzyGuRg6wCQH6rlLQrlYsR3nHudqLtaYYsdxsb9pg7uz6UoqVg?=
 =?us-ascii?Q?JlJy/pfh9T2yzHrnnlJrjoovPGqmz9Nn+9eEnqbRmieA0D+6v9x7pekWdBvp?=
 =?us-ascii?Q?6Vy4ulRXVk+rvy/3xz4iaHZi6i9mMnph/0LmkTdbLjCe/b7NH4KqJ/076Xja?=
 =?us-ascii?Q?yMnrAOWqRsrqDDYfVsvdpn1xHMxM4hUZm9Ndvg1SGaZTC+q6O2FL0fX23v1d?=
 =?us-ascii?Q?OebByBCitzim7YPiwBi2TpwOXsOXW7VZG/vFu9XiqRdvzEYysGj1n2HZo+48?=
 =?us-ascii?Q?NB7RKQedfAL7iqaS5FldYQ6N0T/5KTR/o4edEzRT8Uj47rdzVGrx8L0BVY27?=
 =?us-ascii?Q?AhQlW2GbqC20QiS3dyLyxorptPW1i6GlX1qWVeZP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255b48ff-99ee-49c9-ff1e-08dae4b9c34d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 07:46:12.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA9F16A8NqOCX39nQrLqmG6jJFipUINhhmU0R4eRpDliti26YZ7o2vpZXbqMEI8USUMEQVgHFJwVW7BQymvAUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:40:41PM +0800, Yuan, Perry wrote:
> replace the sprintf with a more generic sysfs_emit function
> 
> No potential function impact
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/cpufreq/amd-pstate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e8996e937e63..d8b182614c18 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -709,7 +709,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  	if (max_freq < 0)
>  		return max_freq;
>  
> -	return sprintf(&buf[0], "%u\n", max_freq);
> +	return sysfs_emit(buf, "%u\n", max_freq);
>  }
>  
>  static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
> @@ -722,7 +722,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>  	if (freq < 0)
>  		return freq;
>  
> -	return sprintf(&buf[0], "%u\n", freq);
> +	return sysfs_emit(buf, "%u\n", freq);
>  }
>  
>  /*
> @@ -737,7 +737,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
>  
>  	perf = READ_ONCE(cpudata->highest_perf);
>  
> -	return sprintf(&buf[0], "%u\n", perf);
> +	return sysfs_emit(buf, "%u\n", perf);
>  }
>  
>  static ssize_t show_energy_performance_available_preferences(
> -- 
> 2.34.1
> 
