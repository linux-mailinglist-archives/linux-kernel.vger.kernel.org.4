Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B466F73A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjEDTpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEDToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:44:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD36AA5CC;
        Thu,  4 May 2023 12:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6UWEubLY+5Mmg5E9VMTt5tysGqZESGLHBf52ExXO+o+6BPygl3Fa+dQxWnHBvKiv21HaznwU1sZC5LPyhu96zd80SGgiaybC7O7fvQMCNvcOLC82S3Pg8HGVq+NIJXM5RI69bhGLBSsTrr0G0ERjLaJ73OfcTSUxwG/Oj+sMSBVek5v7KN/dOnmOiyMU8Skypb5YWO/C19rZAkw5MMeEQ7uL7R0Pv/0iMjkVY7/RvBNiDVHtiGih0sYcPelCyTvFn1KIApqvrF5B5J8L6Ql/Aw53vxTiXD1MZ0meSVuaACw8hjui4+0dvf7Ec7qJKatoJAbA5eqpE/NpcqJtp1hnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLMUO/VB1Mxp9r0lxNlTynrTYbfRoMPn4RrhyRW1lMU=;
 b=RpSW8jP/ykPbReoDY1/mlt6PE+gWeemOtrBPclnC5ElEms6W3FEhMX8isOhPgVgnD+IZQ5TITtSZxXpqeXXhUCd/1jQKbCI8fCT9nmBr/U0N1asbrf9vU8cOBKe48edg2Tila9jUYPqkeRsvKff9+ecTQvMACsVLPGRMV0O5mdpcwmujKn/m6ibLlKojQsmpt/AdwnRS1bKZdgzhszkn9U5AVF1/aK1/3XyKz4WzLQpu8DJPXAFLc/wk5P9ef7UuAdR6X1CFdgAM8j0W9CMdTiPGM8wdu5cN1sbrcnj19LNw9+URnWgtR6lR2WhgzdheQOelT55V6Ze7Qp69p55Liw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLMUO/VB1Mxp9r0lxNlTynrTYbfRoMPn4RrhyRW1lMU=;
 b=lr7mY0ZGATIT+mfRgI4NMwubooR1pdPuZbYyr0rbesdb5Y5AgR8EHF/XCdLS1gJzczgR7quq/piY/7T2hhMoa9KDPflbHFo0PKFUSJxhBqNDyQHkOTHEl1MfqZ3n4RbzRJ9YtIvgQeqitewhgnoVm+5prZHTLaRAZIGBuzn8WTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 19:43:03 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::f4d6:1b23:560d:4022]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::f4d6:1b23:560d:4022%3]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 19:43:03 +0000
Date:   Fri, 5 May 2023 01:12:52 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.de>
Cc:     Thomas Renninger <trenn@suse.de>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        gautham.shenoy@amd.com
Subject: Re: [PATCH] cpupower: Make TSC read per CPU for Mperf monitor
Message-ID: <ZFQKvBWhkOhO+Rso@BLR-5CG13462PL.amd.com>
References: <20230504062544.601566-1-wyes.karny@amd.com>
 <4480921.LvFx2qVVIh@work.fritz.box>
 <f6f55e7e-4fff-7be0-9e88-b9980f20339b@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f55e7e-4fff-7be0-9e88-b9980f20339b@linuxfoundation.org>
X-ClientProxiedBy: PN2PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::6) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|BN9PR12MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afa1324-ecf0-4717-357c-08db4cd7c5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sxyqqk4sLvsbXJeRpJW3bTqJHcwRbew9LvAH/UJi/vitXSRguJGAG1nWDe3+hGBM7vpC/s2dPNcGROFh0n/tv24Tcaqu7HKLKYnKp/L/QjpCoYC5rsKaVPdTXcvLjEMAjCV7xpr1tL0GIIpprYtqeBcZtN6ZkY6edrN4CEumsPxTfHPbbD++HcSOVhLbIPkxCplzV+1H8knqhgKh6jnpqCkIybAnSRgudwPpwHBMZQc33eyw5iRFPwXcDVIVm6kWPf6XcGATOLXwPraIlkv05e1LBm2+FAw/cpu7tGsVVpQnNvmjSOiEdhj07DSBPgI9yzY+AINjc+RWyhqb1QZKaEtoR3dqfjnxDJE2q/gHGyi9s6dCrwT4MBgcMSwpoci8ZrP1ATT+VRyfXh2vW6wjxbx/v1bETtmE6KBfrnoiVL9xDaX43I4p7HO8/yVSqeoBKFb5cwDyDI6RVyzGOdsoUR2ftnvJaIF2fhP/Pi6QIilE0yOSshIfD7RuYnBnRkVIwBAU75r9OPljaffuY7YBL5CWUEpzvSeTeBYduliAV1fggdq3ryKvNi0zLAJjD/C5AvLO9HeeAOSImGUDlP4d9yUyUF96Pq2LlhnBr8FAmio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(6512007)(6506007)(26005)(53546011)(44832011)(316002)(186003)(110136005)(478600001)(41300700001)(54906003)(38100700002)(6666004)(6486002)(5660300002)(8936002)(66556008)(8676002)(4326008)(66476007)(66946007)(4744005)(2906002)(83380400001)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bdEUHANgFPrEg0wqNJDySRRgfG/T7Ml1+iPNxkVe/AgZ8J6k0PEW6hPzDSxD?=
 =?us-ascii?Q?Db7ugi9pev3nD3PjNZiCcNZwqMDlowXo5vWQ/Oaa1vb5uMIf4h7T/AdDJ6rz?=
 =?us-ascii?Q?fjI5ZtqoJ6ZkjHyis7PlDhQq06BJ+olVu/WaLjpMZc1lOgtZtAl6BT9SOqRN?=
 =?us-ascii?Q?jCGZm/FeqmH+sjNUL7q6BzSI3UaXStI5JOAxX26H3dkjXKVr8m1KVQjq8Hk9?=
 =?us-ascii?Q?1a+lX16A4MA0dsrtfT+2bqBdZGmHHLQHVmeBxtJBKrEAZSLUHVpjNdhUBtDx?=
 =?us-ascii?Q?TgV3kcXQNDk5Em6lFzMW2uVtRI4g2m+X2X/V8+gHhBeuWrAg0kt48n+ZUcfI?=
 =?us-ascii?Q?+dk9hug7bPVYWFNMozy7BNGvOhbiy4z69lFTkm734DB2pFRQiI3/MNeE6xD3?=
 =?us-ascii?Q?esLmw31+ouDq2P36rW5o4bomdEmXLIHTii8gfUtGFXxzI57Jud9ExEU2dEtG?=
 =?us-ascii?Q?EmQVb5g+1JRcUKB7l+l9J3MlvSIcvvDp70v0wJChaSpjA42w3Ctp+r4Wh+qE?=
 =?us-ascii?Q?qD87c/rjUIo9B1Y1gEPZ2Cnu5jBrRzBET01iAgWp/CYqAaLv84/a96ZJIm9Y?=
 =?us-ascii?Q?06mfxXaZETajZQZbCZQZwd60LWyBk/AGsbvMKShJOI5nL5t29QIqf2usZ1EH?=
 =?us-ascii?Q?H2OP7BI/tbs0ZpEir3BKSaKkswbPtvqtZVsl2ZZt+ILUs0hnWnxcB/JpRB+s?=
 =?us-ascii?Q?v7XnAUaa5dEx3hhJ0XIqLapoVGWiovVvtD1+BbVFC2kU9k3IVvCVyLfVifiF?=
 =?us-ascii?Q?oe7tbaevU0LQxiiv7AKfQL+eS2mXQ1/NNg6P4XzttvubbzfjMOAKa4VZhFjc?=
 =?us-ascii?Q?X6C1SfqxtsAu11irBrz4ypCr/+7p6uTPdw/L9IHahkQwOYwh7JaA9FnkRn1y?=
 =?us-ascii?Q?9FyVUeRfJ7/emMcfba0LRpsfj07FEYVHzMUJHaWQ19ZDfsJRrtxofr8AsuFa?=
 =?us-ascii?Q?MOxDOJIUaOvYjDKU2kboZjM3pBO9v420zT1rwnI3vzgVPqMpqIcatMSFPhD9?=
 =?us-ascii?Q?jXDhU62VGCn0gHPnNgl9AkVmAeRBCWDfWoDX9GiYzlbyRhDdETx1cPgzrfVB?=
 =?us-ascii?Q?NC+ubu4RVXXKvWkZjZs5/M1oduNEUOdVP5y8jjh6a4hI0M09P1B3q6UL1bi3?=
 =?us-ascii?Q?yl+4J2LmmO8mzJGLCdetTPo6MMhfQC0JNq9heStgJ+uMA7DSeswpIEaOJvVr?=
 =?us-ascii?Q?IyU+k7L8D4ygaZCzT5oZkIF31fjchCQr0OssEqzEz/K/Ksc5RMmUOv3YurWt?=
 =?us-ascii?Q?8hsZrCE+e6dTzZEUMwSGu0O4GbXJFX8AMsvTU+EV7xSy/N/MC8p2SYSu/SAz?=
 =?us-ascii?Q?F/vSJjXQX6iC8w8wCbBgbxFF7LFPDZIgMKUPjpMHzwiKyUKtXlGXJljLHxIK?=
 =?us-ascii?Q?95lToIyswTwq2L4BKQw4ioTv56b57SbZCsrMpL6bOiTK8zxbFPI5tQyIiCU6?=
 =?us-ascii?Q?62yVLGiuarT2yJHOswPSPg1E+wF43It555lq4pslnCmFFhM4I5b5T4AMn4e+?=
 =?us-ascii?Q?XOmzeD32okoCiTIgB8/n6cEjO8ygRGonTspw09+qDBGin/nzXoivzk68cSHj?=
 =?us-ascii?Q?VBiyf+60aYlM1NgrpKb/zANyiSjlnpLgxAxMYkX1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afa1324-ecf0-4717-357c-08db4cd7c5d2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 19:43:02.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PaltX8pItHymeLGPgkt9QOSozWzkKnm//PeR3WG9/0S8zToUsbcip/r4uZ2D01wiSy3yBJoy3MCwsQkIaCETw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 May 10:09, Shuah Khan wrote:
> On 5/4/23 00:47, Thomas Renninger wrote:
> > On Donnerstag, 4. Mai 2023 08:25:44 CEST Wyes Karny wrote:
> > > This technique improves C0 percentage calculation in Mperf monitor.
> > 
> 
> Like it. Thanks for finding and fixing it.
> 
> > I very much like this patch.
> > Would be nice to see it queued up if Shuah is ok with it.
> > 
> > Thanks for this one!
> > 
> >       Thomas
> > 
> > 
> 
> Thank Thomas for the review. I will queue this up to send after
> the merge window closes.

Thanks Thomas, Shuah for reviewing and accepting the patch.

Regards,
Wyes
> 
> thanks,
> -- Shuah
> 
