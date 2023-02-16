Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC2698D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBPGon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBPGol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:44:41 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE071AB;
        Wed, 15 Feb 2023 22:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6TUR4umE0kc9ChOpg3yc2Gus934xBZIwS0rc2Q6batU6Y8kDJmtliAxoGW66I8D1XeNOeVQppMMYPB48ojSvMkUiGFxzu6A6H3HzHIDRD57VlT2fcojFlmu0fxL1y+4U5JRuIWGPoSKRMMQgFDJTUcZTu5XRbpHu3GWXJfm7kNGHDup0ZR/7POfksatKCaQaIqq3iQ3ykhc9FqsDrNX5aYNjBEb/qkIRbzAG+w/IOAu4nbgPMy+VRn0EAJDru8JRXEkAaNhWgCO6ydvMHGrXoy3KGdCbic03eOVoY15epcFoOg6uM72Virxg9BoRIdYn1y+WNHYwTXKtbrHMrAn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIJB3o3/8CCuHw9ZgkpuddZVsdLp7jl1qf+KeBDlDWw=;
 b=hT/GCVFD/p6hzG18MF0wuiUl3xFkzKnHVU4r1iouE1QBcZlzT4n03txsRiAFFgQ1JUO+B5jq0F0AOgWDsP2yGVM1N5pS6itnamaw70/wQiHt75nl8tI1txBZiBj9K42ZIJMftsK48EsHwKlniMD4KJw7hCk2iG8kxqYwCMIRZCqFyoWavPYavkZcEPsLn2bGUqvlYfILV+NS3+6LhI0xltnal14SSWT2PPik/d9gkFjgtaY0SMmb8TBa7tPXn0vqAErFsXgcqCEiGCGusm3sw6EDfBJRCFbtZl4ZJEM4M/+44ciQNFeWh9RYeE+6Hm8c7nvUrLRLBotRaK+K6tHiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIJB3o3/8CCuHw9ZgkpuddZVsdLp7jl1qf+KeBDlDWw=;
 b=IiaeLktwedxPrMrX4fARGZoiuYO+hA14xvZxnSkDnWPe2B7U1qsp83g1sAL/Mpg6Ay3HujKRxJHmp0JXdhkTk+LKpc9y4Z/mAET3ciaIvQeW+4wuZtNj/nCRjQntV9xfrcBcNgSA2u6J8FnJbR1sdM32GOxjDhBHD1GjyaV1PfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 06:44:36 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 06:44:36 +0000
Date:   Thu, 16 Feb 2023 06:44:22 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Huang Rui <ray.huang@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH v6 4/6] Documentation: amd_pstate: Move amd_pstate param
 to alphabetical order
Message-ID: <Y+3QxifmInvLA076@beas>
References: <20230206172157.49887-1-wyes.karny@amd.com>
 <20230206172157.49887-5-wyes.karny@amd.com>
 <Y+3JSn5uVCxMShV/@amd.com>
 <Y+3ON855qAWNcuYE@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3ON855qAWNcuYE@amd.com>
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fac58e-dc46-4bbb-6abd-08db0fe944a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QOzWAGa6gLkoMPEtc0BBVJ9SLhSSvFhlrNtmoHXS1cnXt3ipDJmir2KdS8kNsv4YwGo2D2xAybYrGUl65GSGePMkSpWFplNVk11cjbBBHAVwWSu5rdf/NU/1tAnHzZiGgDJDg0+ayukEccg5ZErjJL8wGKN9wejyGkvaLgePSUaN9M4LtNb/J8xQ0RR6racLg63GRbSrBX6AR/fXUgxg3CR0ymXZFz7RmKQnuk/g0Rsv1VewAjXfqZ5p/RYp8K8ZNLRft2Wmyl7yZaTCQ+F5kAQHtPUnMWWORH41RnIgVjowMO2QMZcea5DHWvlTJbcjKk2B9YnZge8FgTevqHv3jhMIxsIP2r8/918bZ7zCmM53u/mJhywrl7WbI+4OpKmXZM8bJbdkUdol/YkYKA9NoEw6iwmymwg83vi/PYlPxgz86Qw/Du/GsNRtgamRAqew6g25h/W/na87w2Iq/x8KGxXJaSEt+mVaw4In0ANmkzQa83bmDLImJQdaM3ilDv9MmQLuduqExT3Lvpxr9p6p/i9NRqgXbJvZkE0krFtPwp6RC6GUpFKveS9XCMGA1wCuEKJwGGOPo0Zlh2eUi8cGUfQHAul16CNc4uRTM1ThdiZi4M6JPKmuVKQT7fjJSm4WAAWastmTy5+pjRIxDuMPAgdscQyJu0u4rK7fJLcjgNSufi3RJUhUhB5ML+4JaSa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(6636002)(54906003)(316002)(6862004)(8936002)(6506007)(6512007)(9686003)(186003)(86362001)(478600001)(6486002)(38100700002)(33716001)(6666004)(26005)(83380400001)(44832011)(5660300002)(7416002)(2906002)(66476007)(66556008)(66946007)(8676002)(4326008)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9tuYcfsSyI0thjeYmGCJoX15ydKPoVUy5AR1FpqqiGk9Kx4B3hKsqTnMqnZW?=
 =?us-ascii?Q?+UKg8QyCxe2OuuHpUVs1VtkwKHAgsCb3Npqo4Or2m1xBCjTxyA975G7hpWTU?=
 =?us-ascii?Q?Jyubpep42d3kj1BOh+2V1s8BkffWQrQRA0RLJVb1m5rZhbs1VSOKxx+MtPy0?=
 =?us-ascii?Q?S0vbR2ykqiLzlXkd6qZox00DNzJcVF1zJ9Q5z6SiZ3gKbgFpPp+KMruVKmye?=
 =?us-ascii?Q?qnQxEH5PX7QxzC1LLlXqCQPW2KMfWZmMEFgacIjVzEv++1r/gtcEpH0TGtnv?=
 =?us-ascii?Q?sMWQvKZWb+BVyt2LJd65OtN5W688arzhKjNiJrmVBTiFNuHFIZXsV5pcftw9?=
 =?us-ascii?Q?zH7hDVH4H2+UCNt5i+4gx7vjaGoICpOfm2xqhB2Db/bAq6rbCAgF2lfowY0Z?=
 =?us-ascii?Q?wCGLFShwSMZmZbQCxezfym4frUGi7MPTczkYof9DuKQGuJBjuLqgDG+38Wrh?=
 =?us-ascii?Q?wSFCvuLtq4mq3v2NWEdG++vO6G5WqPkED9wO7DM5Wb0h1NJoq68bscqeU4zP?=
 =?us-ascii?Q?uGOfZnq/hFKIjXYJCwfrLMaLUQY8ee4k7hoGim8cdlzPts6Jt5qbGsTecnrN?=
 =?us-ascii?Q?KQO5txvPIEz7PyMtuorCuYXhfoDo4RdAZVkOFOq5HtyCrAUFBJ9Zkq+ZZXPW?=
 =?us-ascii?Q?pM/Y5hChVAJ+t6CnBNRGbRCtysdH2rTttXunwdIYjoInj/d1YIdR2MNXGLLB?=
 =?us-ascii?Q?Gret4gNkFl4OYqKm4KI5Su2gCJKCX9d2y1DFInQyU+Lcd4Z51Dc/x2bLa1OW?=
 =?us-ascii?Q?LKCvKdT5ADLSrSLJDSmJSfrW3DXjEWGRYeIskH31hZaWa0CF+rVqOuz6FW9A?=
 =?us-ascii?Q?QDpKJdkba189BudiSl5NfwNI6yCzfmnfF1+F7m9x7paeMDItFASnEqtwOy7W?=
 =?us-ascii?Q?lVh7G0p38t2pkSbIWT8bhCCiLQUxXB5f7yMwA7pJztqKRrZBq/GvskIU2JvW?=
 =?us-ascii?Q?lrYX8095WCKBScVQwRkRHfoo2yZBOXWiSXydGYFo4hmKQHurhfX+fzFq9kzl?=
 =?us-ascii?Q?6YgbsKGoKP+mhQZuTMl/xzJ8Ro+NDHV6IS2+eOsyrhXrTKNpV5Fq93UKbLhG?=
 =?us-ascii?Q?mCT9V3Now/XOlepvCiBFQ3EZvMTOm6vzId9XOdboHSTAcSoPTfWdqXyBnQqU?=
 =?us-ascii?Q?R4MNeLly0jKpnjOTo0TSOmSGd3oa4HEsuY1KJTCIn8rfETQRZo3bgjZ4Ho6M?=
 =?us-ascii?Q?vRcva6o5pQeRnhdCbq70L/2hlBnF+98ikLB7F96+mA2upAiphUHTfi8Trws/?=
 =?us-ascii?Q?RK/qdh9HK0L3xQUogv7EHbNhY17f6zwgomWRgQPqkJXXcCL8XpxN9rH+/eGI?=
 =?us-ascii?Q?WX8fUJtraZsSlyY8CWUH+92EzWrpailZDD4NXSawt6f0ep1ve8oi5TMmGMBe?=
 =?us-ascii?Q?jpLg9Y+NcFxNg2rtwCzYLF/Vbqmfg9YP83IuQJJpWAhuptBLmUz7dn4VGj2M?=
 =?us-ascii?Q?SU0xq51Zu9ExG6G3mghe7AJcCpxvNnuEiJ+xwsJA4uC8bXlXxUpn8XhjFmnK?=
 =?us-ascii?Q?OgEP3Nv56IMdsfkSYuhSNnDpn8QVRv5st86Obro3jYKr8N9D8L35+WXVXG8q?=
 =?us-ascii?Q?WKd1DHpotS2Ziaa1ATuozDmbCnnmmjK61VauEr8Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fac58e-dc46-4bbb-6abd-08db0fe944a6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 06:44:35.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOebsvncAuu/pOCatXntR25tb00+DBr/CQFBNc+fqlXxj3bDe+BHdV+xkB5fcQly9iZHlit18rA5K0Peul0Fsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Feb 14:33, Huang Rui wrote:
> On Thu, Feb 16, 2023 at 02:12:53PM +0800, Huang Rui wrote:
> > On Tue, Feb 07, 2023 at 01:21:55AM +0800, Karny, Wyes wrote:
> > > Move amd_pstate command line param description to correct alphabetical
> > > order.
> > > 
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > 
> > Wyes, could you squeeze this minor patch to patch 3? I think we won't need
> > an additional patch to fix alphabetical order in the documentation.
> 
> Alternative, you can move this patch prior patch3, then patch3 (guided
> autonomous" can add the documentation in correct order.

Sure, will reorder this.

Thanks,
Wyes
> 
> Thanks,
> Ray
> 
> > 
> > Thanks,
> > Ray
> > 
> > > ---
> > >  .../admin-guide/kernel-parameters.txt         | 46 +++++++++----------
> > >  1 file changed, 23 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 56d5c189e458..d7685b4268ba 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -339,6 +339,29 @@
> > >  			             This mode requires kvm-amd.avic=1.
> > >  			             (Default when IOMMU HW support is present.)
> > >  
> > > +	amd_pstate=	[X86]
> > > +			disable
> > > +			  Do not enable amd_pstate as the default
> > > +			  scaling driver for the supported processors
> > > +			passive
> > > +			  Use amd_pstate with passive mode as a scaling driver.
> > > +			  In this mode autonomous selection is disabled.
> > > +			  Driver requests a desired performance level and platform
> > > +			  tries to match the same performance level if it is
> > > +			  satisfied by guaranteed performance level.
> > > +			active
> > > +			  Use amd_pstate_epp driver instance as the scaling driver,
> > > +			  driver provides a hint to the hardware if software wants
> > > +			  to bias toward performance (0x0) or energy efficiency (0xff)
> > > +			  to the CPPC firmware. then CPPC power algorithm will
> > > +			  calculate the runtime workload and adjust the realtime cores
> > > +			  frequency.
> > > +			guided
> > > +			  Activate guided autonomous mode. Driver requests minimum and
> > > +			  maximum performance level and the platform autonomously
> > > +			  selects a performance level in this range and appropriate
> > > +			  to the current workload.
> > > +
> > >  	amijoy.map=	[HW,JOY] Amiga joystick support
> > >  			Map of devices attached to JOY0DAT and JOY1DAT
> > >  			Format: <a>,<b>
> > > @@ -7009,26 +7032,3 @@
> > >  				memory, and other data can't be written using
> > >  				xmon commands.
> > >  			off	xmon is disabled.
> > > -
> > > -	amd_pstate=	[X86]
> > > -			disable
> > > -			  Do not enable amd_pstate as the default
> > > -			  scaling driver for the supported processors
> > > -			passive
> > > -			  Use amd_pstate with passive mode as a scaling driver.
> > > -			  In this mode autonomous selection is disabled.
> > > -			  Driver requests a desired performance level and platform
> > > -			  tries to match the same performance level if it is
> > > -			  satisfied by guaranteed performance level.
> > > -			active
> > > -			  Use amd_pstate_epp driver instance as the scaling driver,
> > > -			  driver provides a hint to the hardware if software wants
> > > -			  to bias toward performance (0x0) or energy efficiency (0xff)
> > > -			  to the CPPC firmware. then CPPC power algorithm will
> > > -			  calculate the runtime workload and adjust the realtime cores
> > > -			  frequency.
> > > -			guided
> > > -			  Activate guided autonomous mode. Driver requests minimum and
> > > -			  maximum performance level and the platform autonomously
> > > -			  selects a performance level in this range and appropriate
> > > -			  to the current workload.
> > > -- 
> > > 2.34.1
> > > 
