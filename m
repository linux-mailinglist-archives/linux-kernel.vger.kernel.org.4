Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8BD67F137
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjA0WhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjA0WhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:37:20 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0968AD7;
        Fri, 27 Jan 2023 14:37:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG7LonrvMy1lXLwn+ElPOq0oXoN/9wfd6kswwg8ekK/GWvXNBn7YeXlQ6HTnBrI9fTy9aB+lrCJaerkd1BIeQ02xu+cU8CuPGX3fXNixAU0UTc1y3d4L11Pw0GQaJxnNFpT36QyBfRvI2k+a/1un9fVBNQvWakAn6MI0zLD89MvNQjZDMgqGZEqpu4UbqnLx++fn+voyjRzX0yqAb8w03eHDOnfoH9ovZ+HmocZ7hJYIylk9ivtS5PrewZpTDGwJsisSsU6KvFyxjTstUwaxgDzJY0w1krOf0KGfCyEe0K2DSGNyVp2HtvAdlVU48mDdWMvuZKZ9m2jilIy0RVDPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnO6iFrtgJBMDWvdnx6PtwLNPD7GrurfbuVoeOmCGVQ=;
 b=ZobiUmgxWmAc2fCwjA4WGMXNfGcaDgxl8tyFQeKR9OtoMcvIQduMRLHPdi4/QuWJCKPgPU8FbkwCoJ8g4QMb6CkIIBCrjlB9h07zDWyD9cnzWar9jQaL4UV1GSpaFy+PeDkcSNiWK8LymBBWDtgo2JDLTkP2B7jLSv9xEnkU5JQdUb+UiL31aBdXFxXHStT4JCzyFqngygeLCYyVwMLdJdv9zQbQQmkIcEtL2Tiiznk3thr4yUc2ZPHa08JY5Et0/91ORVglpy3U0HP4vvCTiKJphOWf7U8JvVsc5EiCFgvt+Hi9v0r/mBtAE8XI/AvFKiWwM4o+ElQ2+lDNzPL3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnO6iFrtgJBMDWvdnx6PtwLNPD7GrurfbuVoeOmCGVQ=;
 b=Hl35F2gfodu4vquHx+K5hdLjRhjixBeQ7XP6Nao04uEBI+bxl4nbz2vN3tLoJl7PsZNCj5KZW9KikTzr2k2lOrizxhavzhVDd+64SVYoZ8UXzIbd5V8IPoYSXOdwT6hKrJOf8nBmsJj6BolDfkDCrRug/t2/MDXuCvA5pYs1rDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CO1PR08MB7064.namprd08.prod.outlook.com
 (2603:10b6:303:f0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 22:37:16 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::ea42:ebaf:dd18:6a4c%6]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 22:37:15 +0000
Date:   Fri, 27 Jan 2023 16:37:13 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: azoteq: Fix differing types
Message-ID: <Y9RSGa4tCz50NRye@nixie71>
References: <20230125221416.3058051-1-robh@kernel.org>
 <Y9Hce2OqJOB/uiyM@nixie71>
 <CAL_JsqJACct1J2T357V6CSQWsRP1P7bFpNCmippbYf2rYdd2Rw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJACct1J2T357V6CSQWsRP1P7bFpNCmippbYf2rYdd2Rw@mail.gmail.com>
X-ClientProxiedBy: DS7PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::11) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CO1PR08MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fecb310-5e02-479c-ce3c-08db00b70a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M55msE7nybLUJmjUlvXBagNmUwPr74El0EqfoA+JG2Ql09P2eBDNfB3GnJJnnri5G+YKjObV3yHHeXKNc/8nAPqKggcZd6PFvmsuOQBQXItyUH6My7DJRQ4RmtxPJ13pUzHMCNu6YZBPW1o+693yxJMbg9CfKbCS6CcY+0skv6iFJgwPNDv9lfxoxJvUFun+pPPHcEwX7Tp+wDHGzf2ljWnyClDrEeK30JdO3L1hmmOItkAEAIxuaIWvOENktDO9AyD85+FdR+D9Peg/3JvX0cgMesywccYpxmjmn6mUxPnBc9XptHFeqq4cVCgJmSla2TU9EcbC7UQczc0cKopoXQPQNwJPl1UPvPtqi66M8B9WM1fZLNd1MHAtqRPAVGAFw1qlcXy/snxaoFXhCpR2m75+IJtr09QckGaXBeT65odKwv0jB7Cp7G/Ox1FIYqRbFMuY5UUPFYJKtf4bO3avjjsUGXLh3fVk4TPdw+26JpYjLeL32jumsLpKXmdM01DJRvt5BWhlHfWc88tQTFqYVB6BuquysZqtRJP1K3jWG08LuvdYcpCE7BVTFPmBpLuZGzS/pUqnrPVqxsWYE9kDKZV2BvWs0a6kexfKqsGaznC6bSOc6X2Fnnd2m2O6qMWTTEu0Ax7zAomZpsjsbnVPOBlGzm2+jMrT+KNz7v1930Km2m9tMDp5ixhkRPoUK0Y/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(39830400003)(396003)(136003)(366004)(346002)(451199018)(54906003)(86362001)(316002)(6506007)(53546011)(6486002)(966005)(5660300002)(2906002)(66556008)(6916009)(4326008)(66476007)(8676002)(8936002)(478600001)(41300700001)(26005)(66946007)(6512007)(38100700002)(83380400001)(33716001)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZvI0Ta8YYBt6BG7XqVPp2OO9S+bHfoT0YTY/q/Nq7A5RJz/+NgNehHxfLY3L?=
 =?us-ascii?Q?+oDNGAGc+QZVn+u9Aq+Usx+KCwjY89i/MhdDcqb5u284sBZH9ykncHHC97l3?=
 =?us-ascii?Q?+k3YjRRelrqTTAVt+Y0m+pwvK82uIMD3WvnCNS5AGPnhtc3oV47maYfbDEhL?=
 =?us-ascii?Q?mqfds0QKoBgWYbL/H09CiD+YVi2jtVPcNSaAZf6hchF8m8inpnWWkmIvRXR/?=
 =?us-ascii?Q?92OvdiJl90HA2OFZOVo5YljGy42ksvRo9h6cnmRHxeivuoBN9I2NbrVy7Jyy?=
 =?us-ascii?Q?92qkigRAj3umTXgA1jVL2GPHbQz1i5BCUluJpPtcZM1QgdCQkm57quQtrCSO?=
 =?us-ascii?Q?B4yVz8OXXIZ0eXj6wMbOj0tMsQCzlf9AvaMYoPydR4P5glNcjmjVEG4h40ge?=
 =?us-ascii?Q?M34aDKyaawAhpojeBc/l0PRbBJ7VxUcsJFwHFG88aV6vo1fUob4y1iEoae4Q?=
 =?us-ascii?Q?S0DDACkvpRmroktic+/2/hC6MoYbwttFqb94DyOA/fVCw9bGeJJtBkZKgrJe?=
 =?us-ascii?Q?8aPrVlr7g+IF4A25nSdJMCNFTtP7ZXpO6Wja/L5Prm6Bz6TAxD5Nw/Usb5jf?=
 =?us-ascii?Q?hDoIGDOgRepG+znNJ3rpOSq4TZeAEH0WwfbxWE9OuZtIAgsADZYk6/gDfMZ3?=
 =?us-ascii?Q?fC7yC6zyxTYaCqg2fXJXR6OXung7rZlqzJQndFYkYEEMAPHoeWk3YuRrtjzR?=
 =?us-ascii?Q?8xBuC4fA2Zm0GZO34M0mOuFYr8AlWoMZP6e8nZtGFHK/+qvT3C6IbMZUuOVX?=
 =?us-ascii?Q?snHeq24wnuYUXklF3e4uh9mxoUkSQyoE+Yn3V4H99HegyKwf+6lGmp9ove4W?=
 =?us-ascii?Q?gjIdfEMY1sk33ZIsYMNHNWWczaiyHGwuNLEMC6k28xCJ5hkGxqmUnL5FrD1F?=
 =?us-ascii?Q?VxFtDdYZ6+e4aQJpg9txzc4b7PMWDa0RdkvfO2oniOyyvZe3cfRBMKNwgJ6T?=
 =?us-ascii?Q?S2xvauq+zyKwJ/HXdtnN9fF9Es1JA8uGuNHoXy2XN9xllfwX8OvqNoS2UL9s?=
 =?us-ascii?Q?Yva/h1t9tZMG4VDBQmrNVRIPj9unOpNsmaH6+V+wFR9xfYIbBajLhsnSikhE?=
 =?us-ascii?Q?7CtUNUQ2x2SK7Jb8u1GKnAXS+8dMF9GFpezNmCVhDz7iMx7Z9zide8VzgulP?=
 =?us-ascii?Q?WtZsogpyniI9EklKSEQneBOEvdI2fqdtFQqP1KWOH3vVxeYKjts5/okSUxVf?=
 =?us-ascii?Q?M1dvkiOz2cdYUfIIgMI8ok5xasEnBgQfOFYzyW+PFPwj9LSz4h50INcCplKi?=
 =?us-ascii?Q?2jzyiMzWnSvdiEKvI+29WwK/Tqcrdnyza7XEOnAWpQiACS6/nz9dJNu8aXtt?=
 =?us-ascii?Q?Qc0rvUSC3ZG6TQZCLzAtY0BbfQ/1itxURo1RF1gqlrS6z1wxeVFapOODmsty?=
 =?us-ascii?Q?rV2LQWVwkG+nmw+LZWV+mFeTHePwXS1OX9SuerCXnH7U3tBUuKopKrLWi6aM?=
 =?us-ascii?Q?fpPTHACnqr1MJu8MPrpkLBQCwFeecfr8IZZzXCSWqU3GsnjCf1eXanngYlFF?=
 =?us-ascii?Q?QPhg6R1s652gd1et69w0Z0n/l5zjp1VyTABkodZQZjgg4sIynvEwK0MbGsL9?=
 =?us-ascii?Q?gMV13w2H60zkdRM7vxW4kC4P82L8abXXdNyTNCRY?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fecb310-5e02-479c-ce3c-08db00b70a49
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 22:37:15.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hLh19JGkm8/jqIvXxelA9PRlu2VsU4GxizyJHec9Un4lqa64uPt733WYuDy87JXMa33v1W1OS6Hzup0jb1LAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7064
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jan 25, 2023 at 09:10:33PM -0600, Rob Herring wrote:
> On Wed, Jan 25, 2023 at 7:51 PM Jeff LaBundy <jeff@labundy.com> wrote:
> >
> > Hi Rob,
> >
> > On Wed, Jan 25, 2023 at 04:14:16PM -0600, Rob Herring wrote:
> > > 'azoteq,ati-base' and 'azoteq,thresh' properties are defined in multiple
> > > bindings, but have differing types defined. Both 'uint32' and
> > > 'uint32-array' are used. Unify these to use 'uint32-array' everywhere.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Thank you for the patch. While this is a step forward in moving toward
> > a common binding for this vendor like we have discussed in the past, I
> > do not agree with this approach and will instead propose an alternative
> > that accomplishes the same goal.
> >
> > For all of these devices, a single sensing channel takes a base and a
> > threshold property. IQS626A is unique in that a fixed number of channels
> > form a trackpad, and I decided at the time to simply define the base and
> > target properties for all channels as a uint32-array.
> >
> > For all other existing drivers, as well as others coming down the pipe,
> > base and threshold are uint32s. I find it confusing to redefine all of
> > those as single-element arrays, especially on account of one device.
> >
> > In hindsight, a better design would have been to define a child node
> > for each channel under the trackpad node, with each child node accepting
> > a uint32 base and threshold. That would follow other devices, be more
> > representative of the actual hardware, and keep the definitions the same
> > across each binding.
> >
> > So, that's what I propose to do here instead. I happen to have a fix in
> > review [1] that addresses a bug related to this parsing code, and would
> > be happy to build this solution on top assuming it can wait until the
> > next cycle. Does this compromise sound OK?
> 
> Shrug
> 
> How exactly are you going to change an existing property and not break
> existing users? Or are there not any users?

There are no known users at this time.

> 
> We have the same properties with 2 definitions. At the end of the day,
> I just want to fix that...

Agreed on all counts. I've folded my proposal into the existing fix for
this driver and sent [1] for your consideration.

[1] https://patchwork.kernel.org/patch/13119464/

> 
> Rob

Kind regards,
Jeff LaBundy
