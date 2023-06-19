Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31B9735D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjFSRbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjFSRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:31:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CBD19A;
        Mon, 19 Jun 2023 10:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6CBNAKJQSJ2VY0s8j9sThuAZ0GrTURbZuPx8Wjmwv1bqDnpOFx5Elg13fD2ymgAamjwSND2J9lVm7Bxi1zZ6gHfxp8Mall2R8+X+k5poX97TCGTJnKjcVUxhkwYDXVsGTKhFzfCk/Ju5c+UiBkVzSrIT3MFlY9un1OQ+PwKGuDak1+XizDomE6T6+9Ry1EW/zHk9U7CGIwv6CzYWWriAZlEUUIJagTHwwO0rr6zs7m4dXZ+R1ot1DW6QjA2T+3+HT0B6/oWgNwR6KbFhxz+i3EE4LbtoI9erzivgkulL5wroOaWcLOb2Ox9orhENqJxs7bTgAdsl3QLVHWbYST+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYG+/Mi1CAnHMbyZmV6RZd/aQycP8VJ1FMXVr/ngiYk=;
 b=S4iSR0E1zBstMZ2j87DPA/rz6Ge3m4gL69+5eO/izb3VeDqDKQU7rrJo23uRBt1wtCm5xRx7+wMuTtakVyxgrSIN30K3RtbC3SqzUHUF1gvjmO5iotdcMIT1j6hhZhocZFHajYCXIRFhlPOX2u+Bi61Wrg21IjmTUbtXCgSXw2ySLgfHyNOqfXozyvgnbZ/7+IpY5C9ZlXa9UkzN4xxdflpftxwhYDYt7/1XRPs2q5Ht4sSbONIbTzv6+NmD/hZUXh1Jcv0sxi6OIUxmZEHcPR0bCjAy36dFDvNr1LHajEd+s4MdagZrcqQkQFKfBGalGFAm7/YDH2bgOvVGdNTmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYG+/Mi1CAnHMbyZmV6RZd/aQycP8VJ1FMXVr/ngiYk=;
 b=nuPTYOCCs6XmVXaW34Qofkbw+LrApZGdXywJwj+NfnMTz3GF9mQeBECapYWjuqKcU/K/HAs3baHzVtaz8h9qm/sqqmyEcIghLwm8PAQ0P23F5FU/MJlW3U2SQlndN0C2Gech+gikP797jvFWGxhEFdBlkr9G86AW53dmYjcr5uA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 17:31:16 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 17:31:16 +0000
Date:   Mon, 19 Jun 2023 23:01:07 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        gautham.shenoy@amd.com, Ray.Huang@amd.com, Perry.Yuan@amd.com
Subject: Re: [PATCH v2 1/5] cpupower: Recognise amd-pstate active mode driver
Message-ID: <ZJCQ2ypbQgZOOjt3@BLR-5CG13462PL.amd.com>
References: <20230616120620.147643-1-wyes.karny@amd.com>
 <20230616120620.147643-2-wyes.karny@amd.com>
 <348fbe1a-6c2d-68d2-b4fc-278407ede33c@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348fbe1a-6c2d-68d2-b4fc-278407ede33c@amd.com>
X-ClientProxiedBy: MA1PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: f41c2630-bd81-4482-5450-08db70eafc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPmRiTPcMkSoDba5uBTlQu00iZ4SQy5C+B9zx03BhaqzbOn5KsTEizN29/3olLtntGTTg3obNNQRrAJpLa6qz6bzQlkV/kAz0+GSELWyBkx+KmYkIsGhfcV3XfKg6fCIeEXJEll7tLqHPjDc6xT4p6BiJm60HeZO9tH/NzfNENjPHzWyOjon+KbLZsJ/1Rm/DETO106jETfOHWOf0lGskQNw541Rrm7wIIjuzdIYdOGLexGLLxgB2BnkgF+XO1IHsOCp4oOqvVnJQ5sGvvtvpTTqljzEtyTjGjntZfLiKK4EkVjhcSSBZ4fY3O30GHsHlRZeAUILajcV8w/UDCDavXQwdeiHmFsy2MJWHHEceboaB9Nwz/TPohUACEA5eJZweTX9nysPbJqko+LjEhhDlL6L5aPiVKk1GzcpEOwWfJr2Rpn5qToEu5Y+1Hbc/A5ptsH+/uOFix+Wl4dLWyZGQ7EMbBCK6mrcImnVGArU6Pd18gvB6AyPYwTHeTkCUORRGwDMPaeOayi0IlVCKY0Skh1HEuA56hVsP3FZSPBPU6Lg9NaY9gfw4/yjTJTQ9Li9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(2906002)(6666004)(6486002)(86362001)(26005)(186003)(6506007)(6512007)(8936002)(53546011)(8676002)(66476007)(66556008)(66946007)(6862004)(38100700002)(5660300002)(44832011)(316002)(6636002)(4326008)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HY+tjgZwOEQFhIPEl3TOXFKOdtqUhyThahEB6Oam+HJToqcLNwqEfRm7juGp?=
 =?us-ascii?Q?ysMk1/BenOH9X+QtuoZ9Nmvu7XVKOTkJLgVhBpEfoweLG+OEwkS9TNEcngzk?=
 =?us-ascii?Q?ynlnE9KNcIwVBMHn8py1ECy0NLdKFkIR+sISNuSIGAIA2BZOoDZqtJ2G4fu9?=
 =?us-ascii?Q?KdOfFCdPTUE0x5TGv52fQcB71JJ2qi4PaYppp7d2RCBf8qJZAtbGRXoXh1DF?=
 =?us-ascii?Q?ruTfhgatNAO6YaR41s2c0JBPb3OGSf3mEXoDyuM0mQDdIT3Pw2ucGs/HdhIL?=
 =?us-ascii?Q?5/8LgAKTGCOjxptkw0jix1fm8P7ada52zT7ifmyUSRlLvPIyxB1CTuu9yY8V?=
 =?us-ascii?Q?0vwyqg9Mapd+OBfyenIHGMTjHl/vJHjHnPctrSB+SGKAaNLT3ztRqwV2WyLG?=
 =?us-ascii?Q?XMYMVxWTnlOnqBKCtpf030ni8J/qnDJblq0GoCyXA66YicHE6SZPig3X9CG1?=
 =?us-ascii?Q?266d9tWZ0klrTdDvvTA7BWF5iw5xzgzV+3b5pnqa/8OQBup3uken63QvyMtR?=
 =?us-ascii?Q?EQxfes6uNoFJyCLpAbRLrswvIsF0+IcIEKi2BNKgtcsBUArTHHEUaRZqEXAn?=
 =?us-ascii?Q?TXnMKLzhSPWUbToV0uIY3ie2Vy6//D3HDaHP4gLosuQJG2cwU+5vkfGYW8B9?=
 =?us-ascii?Q?lpq3GZvKsmo1qaogzcKlZPO3/yQUlERCmwayDfzIYpewitTvE5+0N02qPrur?=
 =?us-ascii?Q?9AQDRp7wvWmLuntoti3VE4cf/agx4CRV7/S25db6audcC2W6sBGpU9qZcQ1+?=
 =?us-ascii?Q?LUIf7ZtPIZMNbxPFsm7IqRFHJ0nb2f2yKbAnlaJD0k5oWSykBFFvk5rB4MbF?=
 =?us-ascii?Q?iCtP8Z9Win6YrQf9v9oin0+75rXOierwWOb7s8J7wfH9hClh+ysqGq7vNcCO?=
 =?us-ascii?Q?QaoWD8T86PBNNMKNAd7g0QPrtDu2Oid0cv2trSjq/1gUfn8hSXlzkBhobzPL?=
 =?us-ascii?Q?7Rp8AK91MLS+nuQl1OITH394s/1LRJRez0Cvdx8oF7aE7U30jZzT07Ka7cu0?=
 =?us-ascii?Q?r90tWYqqCKZ4NUQyUA9e78BTQHZ8Um5mMo8znLee7BReU4N8eo/ipU79J04f?=
 =?us-ascii?Q?l8eFLREGjLyS+wgcpq/CnrlxdbAdGH0KnCmo7YfGgOgiV7Ru+C6bm10+DJcU?=
 =?us-ascii?Q?0QVAOehwp3xfAtdZK5XESeKF8x2+uG2ho4x+ZUn3A0RFQ4tSFSOFEqlGBn/2?=
 =?us-ascii?Q?z4bBYimmLdDgnXgeeHAUi6QYMM4jEFqYyEGHRKsORWHYksmzzaCnDxMcuklr?=
 =?us-ascii?Q?8j2Tc/NFvgQ6mml/uKnqj814PJAWCZkMGWhRu5RAJKMtq104aI9zt5diuP3V?=
 =?us-ascii?Q?Mbu3iSXIWdaCa7aDhlHCYrDgw8baQ8Y5de32hqjdmf5VMKVWN88PcAWBzOhV?=
 =?us-ascii?Q?f3ex0FJUUxo7JRFtCms42Yc0Upizy9NbOfwmsITb6hEsB3dsF/99TiXsI3hV?=
 =?us-ascii?Q?ZUUEniCtficw+vVB3IYFs36tsFGzQn13Zf9eHM9lWCKlq8vOJMj5rqIcr0b9?=
 =?us-ascii?Q?buikO+NNGdLm4hmfhJgD4bGGoBsUD901pEeB3fEPNELorPEK98mJJoMb8gWU?=
 =?us-ascii?Q?XPGOP2SIGYg+zxAR7fFzzg8G8XQgDtbTYlM+GbDn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41c2630-bd81-4482-5450-08db70eafc30
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 17:31:16.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcWCZ9b0wOWg33gzJreRXh+JKYlvWLf99GN0LwJkLhaE0zRdoRxojEA97XkVHQc9juO2isoPbGpvF81xFqyvWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On 18 Jun 20:58, Mario Limonciello wrote:
> On 6/16/23 07:06, Wyes Karny wrote:
> > amd-pstate active mode driver name is "amd-pstate-epp".  Add this to the
> > string matching condition to recognise amd-pstate active mode driver.
> > 
> > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > ---
> >   tools/power/cpupower/utils/helpers/misc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> > index 9547b29254a7..21f653cd472c 100644
> > --- a/tools/power/cpupower/utils/helpers/misc.c
> > +++ b/tools/power/cpupower/utils/helpers/misc.c
> > @@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
> >   	if (!driver)
> >   		return ret;
> > -	if (!strcmp(driver, "amd-pstate"))
> > +	if (!strcmp(driver, "amd-pstate") || !strcmp(driver, "amd-pstate-epp"))
> 
> To avoid getting caught in the case that a kernel didn't have the patch
> separated from this series (for example if a distro missed it in a backport
> from separate directories), how about using strncmp() instead and just look
> for the prefix?

Sure, I'll update the patch.
I'm thinking of using strncmp(driver, "amd", 3), because in the above
case the epp driver would be "amd_pstate_epp" therefore common prefix is
only "amd".

Thanks,
Wyes
> 
> This would also let the tool be more future proofed in the case another
> amd-pstate driver was introduced later down the road as long as it stuck to
> "amd-pstate*"
> 
> >   		ret = true;
> >   	cpufreq_put_driver(driver);
> 
