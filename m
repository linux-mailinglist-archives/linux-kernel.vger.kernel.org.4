Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6D698D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBPGeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPGeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:34:00 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658D41B50;
        Wed, 15 Feb 2023 22:33:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj/cnmucsxmGdRjhCzWIXxSkxWLbZxF3sW/WhBzEUPUKL8yqQmJNmrODTSmo0RTv/ZBpKAwom6zGZ0lrs/FjxBq8/7NRlme7slJCVaHYZtWvpJysQ4gBEwy8EyO56uknU4eJTYHim6/RayzzP/HOGUt/qiw2tX4YxnQAtevyve1E06ZQlrU+IjMbh1RZnSr2GsKPxmR7jZzUJNnWSaqURjaxDakCbmu52BrxLvHhuqXr6Fl8Sze1q0NzAOeHJxBSlLCh3CUaS1iBCq+YF9/ieMuaAv6nzUoPpfXcE13ATIgzlWlGauOoRL7UPcXY1qp+mdWNiqldxXFm8Qse5TZodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLQMK8whtnYCuOACDss0o7DHQXR3A2m9wnWCe5ptC0s=;
 b=RIQviLDfQ+ibxLOBagPzZ7V4zT1GEk92dZV293MbAqvQEUm45IwvESO7cU4lnPSmK5hB3MEZPeooWnM9PO11+f1znS+vLC+4wifsszyfIP/8H7WSRP09WrecUFfV8z50Ji3XzcXnCV2I03gRr0joUV4FpGnhS1X3wd+aIWEw12zY59jOKzXm7DNzk97jiZBww+mdgsYViuckkqAgdFxLO/8GZk5+HtsH/ncA5vrKD1N/ByRYYiLjpCGdnnoGYXAIKzD+onDKKvDpekFA/z+JtRmJd6VonHgRLG8Rh/tW9URqGEHUgs1e/mcl+id5dRfNVYaKhgINFqDE35EmuBSy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLQMK8whtnYCuOACDss0o7DHQXR3A2m9wnWCe5ptC0s=;
 b=ik1G6ivZAS10ek6VAL3X+E1Gr9gQ6seGhR7I1sQNCZ/gAxwYeHkLkl13tVEuYhDCjsELuZNwgwzcI2flq/unl5NNxRLYgUnmnFzW/ka6vH4/DcVjpfU0GLrd06ipMFTlhDkax9WZet3802tnJA9ZLQsAC1IVcb3VZdUUgYGGd14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13; Thu, 16 Feb 2023 06:33:54 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 06:33:53 +0000
Date:   Thu, 16 Feb 2023 14:33:27 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
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
Message-ID: <Y+3ON855qAWNcuYE@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
 <20230206172157.49887-5-wyes.karny@amd.com>
 <Y+3JSn5uVCxMShV/@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3JSn5uVCxMShV/@amd.com>
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c8f474-ae65-4677-921b-08db0fe7c5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: do9mD6KhPs1y8WRWI4szhoB3GRLKD9urmqoEDVgu40aE8opXWgt3arP2uNlr+0LJrskId/92zZ+Nqb5CC7HkcKNgYGJCwxSfGcJiEjWNWBBdxvsH7t4JAT466m7gL10ojCB7DFTozmmFG03Ft7NDGrS8EjPNP4u3EhTjA+pGe5Xv792YeLt2x8b+BCvVt97jEpiNzU02n9gNpSXpxa+alpKyyVNK5sK7g5iUnOJNvPtFOsp0/HdIeRNJBFJOqSMZxZATKtjd0iHKbzOaVHnamSqsvvLbdxADV4rn/QanCR/8nPuJlhj6CcuS4Wm47Fw1jqHUeqwAy8jM/lapenI6RxgqAiQboTq1la/8iUZY4lJvrOGAyHfXCiMK2IbE9SBjf2i5fsvtQNKdTbyCe7WfaEPny0Vipcmna+FnfvIl8YSp4wyTiLnHc0LwOaF7Km3zyzLYSYCNAMYaVOTt8jKa9cyQtwjEsljOck/SbaL0bsatZcHgKL9NK+QuUe7OSDUzgO+QG7kfOmPC5SLfWSA8Mw7WCLO2prT7cf4bsopw5f0y6mzcznvzKcmgJ1sosGkofKuv491rhi6IwBH27pXneVcUA58fxGGsW5nFm6whOv/ovDH+CBmARubRe+jQVRt8Dy8RT2j3DNkgWazU+QCS/ivhO/xTAclq1YL+jWhjA8hMcLHqldoRQsNhrRgjY35i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(36756003)(2906002)(54906003)(6636002)(7416002)(5660300002)(8936002)(6862004)(66946007)(66476007)(66556008)(316002)(37006003)(4326008)(41300700001)(8676002)(478600001)(6486002)(86362001)(6512007)(186003)(26005)(6506007)(6666004)(2616005)(83380400001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?inSx6EC7247UgoPi5itPlSXnh8FCrbT7HdXT0Jz1qCJej8pRDxFD1vLM15po?=
 =?us-ascii?Q?b/Iccr2eXidExUM7EBWEzGazWDJRVtOUOlZ6bBY+jIEQ4HBf+nOhnlk/aBmO?=
 =?us-ascii?Q?Z4ikV9ikst24vd55K14175gxu8lvWy16wl47ouWp/D/owNuoL7UcWijtvQiq?=
 =?us-ascii?Q?mZc4A0IaoBXEejMBSqPOZmk7UOUs5qltdbN6lJqD0oG6s+YSZMvTSN5LxQRb?=
 =?us-ascii?Q?TzAsOMPzCltqIiPPm42iwI//WOvH2it5FWi4iVyWWv16JJpYMRIQ+6jMcgwC?=
 =?us-ascii?Q?N7o+AxrXZBL7S6jANPDQ8H1LcvM+ChgyQV6LoKsf4L+N0J26l39ryXkJVe8K?=
 =?us-ascii?Q?daWgfwGP+YCG2mRZ6fl2Nb1eYPUqiVpEeY2AtBBkRLtNN8FMTB1gzMp3j4hO?=
 =?us-ascii?Q?/XE93yAnYWd0RUAVpMF+aQ0PSwROuRsHIGmNcRNHerP59b8il1UPz+2QixVb?=
 =?us-ascii?Q?My+F484t+kLZgPhZeQT37153ToCQbRIQuxu5mZz4bI36Q9CkR+a3pw/fNdqP?=
 =?us-ascii?Q?P0IhN5y+bE4OAzi+urhYfLkSNXC9QHcr5RxjO4GaXxil3CFqOUSNMqcFTdkz?=
 =?us-ascii?Q?aZ3gSCA5XvcbQcacg+GEdNqKs5X/qnMWvoRYTE0uahR7HPmtOIdB4S/Co2Fe?=
 =?us-ascii?Q?/CpjzGsPSpuJkermBcsM3xhck7ZOZYfTV49XBA874NKFOV7Z9YQovGHGDSIM?=
 =?us-ascii?Q?qrst2NPFtN1MxH1yjJBps3VbF+soc8+OefND8t8vLXeDF0dcubYMJ7jk6XcY?=
 =?us-ascii?Q?d09yqSMqvEFdpm4T4Ap4WdW+vVLjQO6SaOUUjHU27OxHP8VRBVo06MYa2FdU?=
 =?us-ascii?Q?I2FeUug7Vx+bKOtNFUwYgMoiRCMjy8mN9s9EeSCkPxB7IEwY8p6GpUuEL/pj?=
 =?us-ascii?Q?jrBUlGT8WUwlqNVn/wSKSHhtQscQTq47ExoSRanF6FP0+5mcz2VHq98q0eWb?=
 =?us-ascii?Q?SJa+4I8sYSv51cJoEPM2zZUZy649hKUHmaUVlyVbdDaB1010+if6DN4wES+h?=
 =?us-ascii?Q?Yo3hnZ4/ctYVW5xj+WBZvBTI4ir2kZsjQuVeMahHk4PAV9HcMH6x9odvLVBI?=
 =?us-ascii?Q?0nHfPy4mPMkwhox0rvxnK8JwfmVM4/Mtf+EsJtMl3Ly00yr4tUp/B+k4qAWq?=
 =?us-ascii?Q?RA5+g8PjPrXHxCgElKoOz/9R0bKlw5sMOvx0hCLyqmnIUoZdzgiUb83J/4YO?=
 =?us-ascii?Q?Zct6vVmwGNCWd8HPV0cWuBWjFDxTnA5BeauHxfZ94SZ4BRe9jCi83pdDNiim?=
 =?us-ascii?Q?lkG7QIiK0MhhHJo+zhThbVHxMuN4l1fpxzSYQcr9bUOJtwsNcDC9cOZk8b93?=
 =?us-ascii?Q?lxj1PooyNusYYSdlf/IqtK6HBlhV6D71kjXwZAtM8+nlVwBYbzS018nZugsp?=
 =?us-ascii?Q?2fF56YjLbrFBCf1NvFnIsc4RvH+eJFOW9BegfzYv0W2ebH5TlThC2vrI07rL?=
 =?us-ascii?Q?e5Ph4skPtKyl/C7w2wQyAAY0WNNT1A4U4xELvQxdsSkSD91tzukE5Px2fFw8?=
 =?us-ascii?Q?jA+NbuoMoCl4XfPiItxCBS6gJmiuZGBJ7/reTidDWTNvkzzyNBRXZh4KGjhK?=
 =?us-ascii?Q?J+2uwFx/uDVS0U2ig9eiguHUcjTPU77bk3urEde7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c8f474-ae65-4677-921b-08db0fe7c5d4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 06:33:53.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmgEi6IPZw9vq2QyW6vEqk59owtxChK8f3HHdRRkkZJWbY6/Hdj/zujetqd0PKIWzskp7iC7mrA32C2ebRFTYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 02:12:53PM +0800, Huang Rui wrote:
> On Tue, Feb 07, 2023 at 01:21:55AM +0800, Karny, Wyes wrote:
> > Move amd_pstate command line param description to correct alphabetical
> > order.
> > 
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Wyes, could you squeeze this minor patch to patch 3? I think we won't need
> an additional patch to fix alphabetical order in the documentation.

Alternative, you can move this patch prior patch3, then patch3 (guided
autonomous" can add the documentation in correct order.

Thanks,
Ray

> 
> Thanks,
> Ray
> 
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 46 +++++++++----------
> >  1 file changed, 23 insertions(+), 23 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 56d5c189e458..d7685b4268ba 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -339,6 +339,29 @@
> >  			             This mode requires kvm-amd.avic=1.
> >  			             (Default when IOMMU HW support is present.)
> >  
> > +	amd_pstate=	[X86]
> > +			disable
> > +			  Do not enable amd_pstate as the default
> > +			  scaling driver for the supported processors
> > +			passive
> > +			  Use amd_pstate with passive mode as a scaling driver.
> > +			  In this mode autonomous selection is disabled.
> > +			  Driver requests a desired performance level and platform
> > +			  tries to match the same performance level if it is
> > +			  satisfied by guaranteed performance level.
> > +			active
> > +			  Use amd_pstate_epp driver instance as the scaling driver,
> > +			  driver provides a hint to the hardware if software wants
> > +			  to bias toward performance (0x0) or energy efficiency (0xff)
> > +			  to the CPPC firmware. then CPPC power algorithm will
> > +			  calculate the runtime workload and adjust the realtime cores
> > +			  frequency.
> > +			guided
> > +			  Activate guided autonomous mode. Driver requests minimum and
> > +			  maximum performance level and the platform autonomously
> > +			  selects a performance level in this range and appropriate
> > +			  to the current workload.
> > +
> >  	amijoy.map=	[HW,JOY] Amiga joystick support
> >  			Map of devices attached to JOY0DAT and JOY1DAT
> >  			Format: <a>,<b>
> > @@ -7009,26 +7032,3 @@
> >  				memory, and other data can't be written using
> >  				xmon commands.
> >  			off	xmon is disabled.
> > -
> > -	amd_pstate=	[X86]
> > -			disable
> > -			  Do not enable amd_pstate as the default
> > -			  scaling driver for the supported processors
> > -			passive
> > -			  Use amd_pstate with passive mode as a scaling driver.
> > -			  In this mode autonomous selection is disabled.
> > -			  Driver requests a desired performance level and platform
> > -			  tries to match the same performance level if it is
> > -			  satisfied by guaranteed performance level.
> > -			active
> > -			  Use amd_pstate_epp driver instance as the scaling driver,
> > -			  driver provides a hint to the hardware if software wants
> > -			  to bias toward performance (0x0) or energy efficiency (0xff)
> > -			  to the CPPC firmware. then CPPC power algorithm will
> > -			  calculate the runtime workload and adjust the realtime cores
> > -			  frequency.
> > -			guided
> > -			  Activate guided autonomous mode. Driver requests minimum and
> > -			  maximum performance level and the platform autonomously
> > -			  selects a performance level in this range and appropriate
> > -			  to the current workload.
> > -- 
> > 2.34.1
> > 
