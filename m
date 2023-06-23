Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA64973B5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFWLBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFWLBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:01:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2100.outbound.protection.outlook.com [40.107.92.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F01BCA;
        Fri, 23 Jun 2023 04:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJm7CaDv8gs22Y2mZfw3VkZkykW42GcKK532rOD28AxtuFXYDHd1lotidcltCgGUqOrZY2osOFiXn9yDYUmb+/L1WswsUIJaCLSldelyopz5IPxP02FqbBf1btZ4lRXsBSEFjO0qLp1SpuQ7pT29Tck7gCKZYakZRnuF9C9SdmqM5/wu6rJSRRObY0cqXQ6/SnqqCYDJRf/XsluKzcpvbzDK0E5HkS7mpFHdl57+M3D4NcMIPtyF/+x6KZQBHwj+ty2/kigzXtB4ank0IYEMPRSJ2ev0RtD4FzvEedSDjJVIrJpsUWO1o+GG5odXL+l46IlSzndSwF8rtNKrHtMI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRO2EjV+iprF2EzVeo8LEgXJP2Vp1StnqhqoJW8wJsE=;
 b=kJjNoplNEMsQdDNsolqv7WbosnALMHaiKF0jMNLU7vho1ADzi1Q7fnygCBXzVz4s6Svabk7+MG3A8r4itcv2eVhjJy029CCNaE0O+dj8d69RO+H8JMSYvZS9uLzNjOAOgLTwnVZqInVjwrxMKzFP5MkWYMXYJ5sy3BUCywuv/VK6HXCSpVzS96ltQvfTn42rZiHMtkF/86cUfBbJChnXuwByU/BJmteO4gqiJDGjRRRrcmNjyfvHJac0KuCKv2OYMnSMmtr2xnTPQW7o+1nhcox8dF8cGKHp5KukBIVKT7fG7OskUe5cJ5vlg2Ev4mFbKRha4nYSMQ/98E2+w+RSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRO2EjV+iprF2EzVeo8LEgXJP2Vp1StnqhqoJW8wJsE=;
 b=s+BTxUYfetjioafTtBme6GJicVBH4ZJKtdkj2er9kEiY8q4BkGtgNyjb9VCTnrr9CDWSeLqcOrrwW9xvwJtzN+RkquhY0xWR/KPnvyiqp4OauYIdU3dP8lBWDXw1vjSdmqiXlJ68mwGI8nhfc4dZQtk26VlokOUyarh52bT5Pi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5731.namprd13.prod.outlook.com (2603:10b6:510:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 23 Jun
 2023 11:01:29 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 11:01:29 +0000
Date:   Fri, 23 Jun 2023 13:01:22 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH 3/3] net: macb: fix __be32 warnings in debug code
Message-ID: <ZJV7go8/2CMkSDl6@corigine.com>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <20230622130507.606713-4-ben.dooks@codethink.co.uk>
 <ZJRsYtU4qPZ0h1xp@corigine.com>
 <fbdc3741b28a0174e3058a998e253439@codethink.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbdc3741b28a0174e3058a998e253439@codethink.co.uk>
X-ClientProxiedBy: AM0PR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a45dd9-7fac-408e-ba2d-08db73d9324d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PofRohCJbkQy4plh8jUAvOOhU9KQJVbtqAQ2JgdrmOrmO3PVCfsPS87odg/CZYInmnFkYcgByBTJ1KzFwXzLLzQONpM7Bzfbut8jgbvD3zAITuo/jw1hepsOwdcXb1JP2rj/xkdwfolsVxKZE5NVo5WwsMDAFdOD+oHj3xWUKcxUdmgZmqIcwykgbVhrlZ5OmOgCApknJfNDjAyOC5mEJeEi+clTViPpeNAVJZadZRqIKyd8DBLxE3OUYJFK+qSwuMap/FM2rcY3H/SPt4JCYqwuolStrATXvcfdN16a8RCkgdrkA4kCIWZyjpr7YziS9GqRRbYUjxfXe21L+PAHXBvJkwq9Hlmqx8MbydtBx4QmitD+MBXGDrOAlLGZyRYLJAng+GR0Rhb3IGPYaxK5oUle4chHimWewPIQEf7YgI1CCGu++AkrLAJTJqOuLgxF48dXpyemLDJy+nCQxmrcKxjQEPAYFou93V9tHjxgqSKCC+/tXsBFVbBUPVWkfh5YDaE/HpaimbiZNDLSEMdOLYJeYu39HpUJGy6aw3Loy9CAgRkh6/KK4V8M7p8DLpCEBlN2nBM9Rp/0m6cobk+OADCHHAAZCmSI31nlZ74PdHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39840400004)(451199021)(6506007)(6512007)(478600001)(186003)(53546011)(6666004)(2616005)(41300700001)(66476007)(66946007)(2906002)(6916009)(8676002)(4326008)(38100700002)(83380400001)(316002)(44832011)(66556008)(86362001)(5660300002)(36756003)(8936002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C0r68SY26q8OIUGuJw5EyjYucHBtgDgbB9iO9QIS5hMEKSoGkO7b7fN+ZqNk?=
 =?us-ascii?Q?KTqetj7lGuhw/sy/1C6wkGqIZbbPQFEud+HASFs5UmdxhvUYIRs+uO3T6tIo?=
 =?us-ascii?Q?9hqLbX/JqtXXrmdAi1H7pxKj10bGLrcVPDaVAFxRcw7KNYJKys3+JhKTpi04?=
 =?us-ascii?Q?TSQL5zDnPcdi8oPGC29tDq9Yt0YEDiTT1Ms5WGqfHyPCozU18TD60DOezKPO?=
 =?us-ascii?Q?emgrfpW3/cP+/HWCaafCreDlQaidr+/Ygr3PExsrgo0RcvxEjXNNUp4v3OCy?=
 =?us-ascii?Q?ufb59C3Azny2yBkpQFyfSH6RGc6RkCar4Piiz+FHrsKiRhW6YbHxQmK0EBu8?=
 =?us-ascii?Q?uxftPpWrdpGq2+H0i3l0RXq+4VBCAOqPexdzWLMlERJRDul9l6dgeDp+kajS?=
 =?us-ascii?Q?sAcQfAGSnPqsxhHJH8XjNb/QilrYx0nkv3rmASZ55sg0w4Fgkui6aSayrfGG?=
 =?us-ascii?Q?Z2qh3aL/2pKUF93uF6BWj9YJQeLDfZmDs16Uft0A8ILFsPIpjzVprF3YWccr?=
 =?us-ascii?Q?xXw/uIEJcm8Yw+21k72ullterMnvxkRQpsDN2zJzdZr5zlyR8F7NSTF5UxIV?=
 =?us-ascii?Q?H30C4e90mWAPpbW6MoVjPm6ap5m0iiGKaoUlPE55sld9I1NaRCrfCyFI1f9n?=
 =?us-ascii?Q?BsEdh0a8ZusyLnGdA5tSNg8dRw50fBapXExS7NQMls/IY0mQvEpbrSYyWuA9?=
 =?us-ascii?Q?3SBtnx6D24IYyZUrzkH/v7AHiUxfNtRYOEJJCWNXHhVe1cS67wdAPiNnEQkN?=
 =?us-ascii?Q?iRbJNcJrAZAgWVe88KhuE/mXhsn2sG6KpzD/5iPeB0xS5afuFdPFf7vGQbzY?=
 =?us-ascii?Q?zb/Du89dVz0hIV7ilfqbkQxqhPTjAx9bCMnhmKjqpl4LA4Cjs3BqWhJu7XsU?=
 =?us-ascii?Q?SysTdZECZtHwmWTh6D/knIhCzxRoMw3m3UjnWaxd3I3R9jlkYK/sRvoKG/nM?=
 =?us-ascii?Q?npy/V5Y7ytU2MP4PC0AtOCBc3pG+ROsvBmdg0KTQZUlO8JKPeTQ1grDVZnN1?=
 =?us-ascii?Q?s7tAHIfUSaLdJf0HvqNU43wdGJTOOsX55g2lOrIYAT0R15ncbdeiK5lkl2wX?=
 =?us-ascii?Q?qG62XT7Hg4rtxXI5xxhru/GOgPUcdeHxix3gLQsjj/p3CR+eokPTM1W0iItr?=
 =?us-ascii?Q?6pupaAEs/KpRr8qAzYM3AtFdkEPj/aaVnNvvoXxCgHQqDO0SS3MrvI5O4kUo?=
 =?us-ascii?Q?T4BGlKSkwsaBoAn4TIw/PxxHdBIe47mGkEaFh+qBMHjU6pwwa4zN2uZPEKka?=
 =?us-ascii?Q?M8ZrUcaBHRe8vbDfcGr7IE+aMlzCoRqxDzIuSUxEBO7xBnStZya/xRTEbFLi?=
 =?us-ascii?Q?aAb2yJQa01xvJVjZTwPbUEY6bfDJTTEPXJGx7WGBRD9SRZZNgGqmktQfg59P?=
 =?us-ascii?Q?ARKG8lUUjZpk8ycW5dtjqvtATMRVgKtO2Q40DsQNcCwhE6C1XeZf92zEHEP2?=
 =?us-ascii?Q?R1jCXOzNj6t+LixBepXYckPFD4Ix1KQLQYwJzJKTNWbczdNk4bFhjHaGErA7?=
 =?us-ascii?Q?E9s277odqPyoAjlo91DWKzNZUIPof+owF69KSrtiPVRRLAWSkFbPl3Dfh7rU?=
 =?us-ascii?Q?zzElUaHDoCYhxXxx7uLBloCLz9NXTlbe3dyy6uq4eiEhwzp6SpTzvy7wLSSD?=
 =?us-ascii?Q?d0WOh4MHYI0SIHyMdEUTwnq77j2CTBa+LR2lVf/kNUfhk57aTkns8FQOQ1By?=
 =?us-ascii?Q?E0zxSA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a45dd9-7fac-408e-ba2d-08db73d9324d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 11:01:29.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzSCajZql7Bls77NFw6eFwKKzKTyu+nCdbxPOlUZA62MxCsKIBolJ96asOaKv6expuXiuGMlH850uzR9kUY/+kl1ZqvEgTGP22/BHXS2PqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5731
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:43:12AM +0100, Ben Dooks wrote:
> 
> 
> On 2023-06-22 16:44, Simon Horman wrote:
> > On Thu, Jun 22, 2023 at 02:05:07PM +0100, Ben Dooks wrote:

...

> > Hi Ben,
> > 
> > this code-change looks good to me, but I have a few minor nits for your
> > consideration.
> > 
> > 1. Please specify the target tree, in this case net-next, for patch sets
> >    for Networking code.
> > 
> > 	Subject: [PATCH net-next ...] ...
> 
> Ah, was using net, but I assume net-next is probably ok

I think net-next is best for this kind of change.
FWIIW, this series did apply there.

> > 2. It might be nicer to write '.../macb_main.c' or similar,
> >    rather tha nthe full path, in the patch description.
> > 
> > 3. checkpatch --codespell says: 'Chaning' -> 'Chaining'
> 
> Ok, thank you. I didn't know about that.

It is quite handy :)

> Since there's another patch that needs work I'll re-send this early next
> week
> with the fixes in.

I think a repost of the series is a good plan.

Please note that when v6.4 is released, which may well be over the weekend,
then net-next will be closed until after rc1 is released - approximately
two weeks. If it is closed then you'll need to wait until it reopens
before posting v2.
