Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721146E5103
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDQTdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDQTdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:33:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4FB0;
        Mon, 17 Apr 2023 12:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVkL7xCz652gsGeoUHQ7DHPDwUhK0q48lAco3jS+ckGIzZrQz0sQMscw/Ek1jrQNSWp/3jTw/Nxn3eQohcWprz68priRHtpjoyqHtTUnHxfdytMQpd4ogbF0+9uN8DpeQftWUcqN4gtGbnPR/3mdQ/8ix7rQHMZim6gGeP3Ni3Q2y4zwZQ03bpRpjIVkXVQJLhJj/Mnxssmr6s689rGWG4/NzzuaeMLY2lFLn0HQ3wE5hwZ1Adt7CACLaU972ZjYeJLoVVeDnUZLSPh90aemQ3EQe2SciLsuimSfO0HUM+f4wGRF4a4UOWjJHJOjRoQWJ3qW9EUKVz/MgDwnlgpEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+6re1kEHGJhIXITcIFg3cg5K0+FUzt/erZ1M3kTwek=;
 b=U8UNxuJjiVMhH+ZCUUPpvB0rp3SIIEDxjJx7owulziEREn1xgoOdnTKlFr5sCdc/4Uau9EfxR5GnczS7XcBTwRz005WgpZ86ZhqPLu6uAJgBc5DO9LCWmEJJ2fbdSZZrmXokDPaEnieYTe0N92tZRl+npjeZhqu7vUDvt4cHxcLyhDsATOMIki/mFmr3lG5XW3frKI/YjXqsx5BbKwMEL7zy5FgODk//hAn46vFIeYg0+rWHJyuDqEsszBbm/CBHT979vLvUXapYomDEHb5hESrfhyLgMZ30g3Leo25hPDCc40US7xhitKnN8P6rrXWOVOEmdGNU44QIYTejdBOOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+6re1kEHGJhIXITcIFg3cg5K0+FUzt/erZ1M3kTwek=;
 b=c5p3R0mW1g8wU+xXWtkqz6pPrhpkLIhOWkGEXjfyZiqlWKC1K9FaJnTPdNs2eWfqX20g6IilCIXUkLVYJp8cK7ljqiwO1plfA6h2BXG6dXRE8ORXExlSySjDqWZ1qqP7KC+RD41WWJ4l+Ve2zQ/iGjBax2dt99ohRFJV9RVYY1CqL7vNJrmfVP0FnI2AwIGMPTtWjMIrh6tkGkNq+AlRaeQfqm2AtEC+V3T9bmkJRQCU6RxpYYuZIhxNqx5bJxnRI3G7XUZKUjN9gR5bDnYziIupnHISSHI/Tu2az/nT5qRGgiU+u0u+NDlKNwVO+Bf85JVr3R8UcYzITgmWvAX3kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 19:33:39 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9%7]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 19:33:39 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] HID: shield: Initial driver implementation with
 Thunderstrike support
References: <20230417182909.33833-1-rrameshbabu@nvidia.com>
        <20230417182909.33833-2-rrameshbabu@nvidia.com>
        <1a754a3e-2a2b-07d5-c94a-0373a1677e4e@infradead.org>
Date:   Mon, 17 Apr 2023 12:33:29 -0700
In-Reply-To: <1a754a3e-2a2b-07d5-c94a-0373a1677e4e@infradead.org> (Randy
        Dunlap's message of "Mon, 17 Apr 2023 12:20:51 -0700")
Message-ID: <87leiqb8xi.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:180::22) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 71df493e-9b26-47a7-dac1-08db3f7aa4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIwvzqvrtTSeC7tMJH1wmtkSTJjW11gHanpCB4FW2ZnKq6EKikrpMW1cBfMKkzYQEqwImjQ9e9rLhhtqZjeQ+cv4xrasUUQDD51e+X4BZtAanZlgXe2rOkiOB4NF5per05oFKHuwyVh2T+pYq+m1hatHs0IlBDfL6D5uTZH5l4fx6bwQ0UwJf8ebxzUcYLMH65xf39YbOp/EpsL2ldsZfWn8xw+gA3QyP7E+f9kZ9eCDJpQ5WUmzgh5YaYX37n/aAI6pHFLspumZoWrbXh1vEAYRSms9igzLnUP8GwhwcQGnxEfgvl3xQ9Xh932ffy1dDOsBbqIqTKAS7OgTreXiAFVFp0JV80w1ALZz9lNOhAZeDqPmr1RmJ8CLVJHwcQntzDfmibRC0EDaxqZszP/UwpDH5FvkuSUk5qbJwWG6bOmwYws93BilNS8BfBvOvZz5/MtV6Uh7YYaYKNiWZJMzgxd+OJrsGMKyHRlBjD+hQzt8Nvsa2SfDXJt6tl83SL+dc/+0DCRJzaDw3FFBktFLeHxd/MCq8eL94ATp7Wmfy6Vd1Q/7bzpHDPIpmAJS9aH8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(6916009)(4326008)(54906003)(316002)(66946007)(66476007)(66556008)(6486002)(6666004)(478600001)(8936002)(41300700001)(5660300002)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(26005)(186003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJkJ8/aS3rOQYWkftDEmQA46dYwGRMIOTaocqvmygqA0EEfZWX0Ez8IIS4Vv?=
 =?us-ascii?Q?WBDaollysoL+WCJqh0wHwiuS7XqtuxAR0lvdDEiCDjdZe5vz/CHIzeuXBOAn?=
 =?us-ascii?Q?Q1jHOOkHSo/jwdbPO8J3cMobII7mDfNdbO/gnzGrcww1oc4IjIYUWORCsVYi?=
 =?us-ascii?Q?yhpparZp0k/iTd54j0W2Z5M8z6tMfwsMmNLImxHeI9Ac5L1Gm7HsMxZG02a0?=
 =?us-ascii?Q?uPPsa/hivR9fwwf3iF2IY546eIOu7Slb0AdHykl3967mihJ4ximBZvNTcd6f?=
 =?us-ascii?Q?Eg+Cae7dc++JZjxtmb5j6RABZQoJvDJC6vnMcIwiMGZMEQc8Gb0YFgd9lfuA?=
 =?us-ascii?Q?72DABhfITh67rTESOsWq3Hv2lXcqGE2i20vpYtzwG40qJZCuAZ4WERJWD/gq?=
 =?us-ascii?Q?DBN0uD/asl8ZFyMVZ9OR9N+JItqydi3b4TwFc+l4dOH0TZ5gM8cIBXvLsFKi?=
 =?us-ascii?Q?hZ6GDd38RTlbUWBTOQdByWas3+ZUj1Fi7B8nZrKWIV/Pkck6THw1qPvJ8OoQ?=
 =?us-ascii?Q?4yFCHJRIMvThacwuDygZ8eCi3G0GMs4vhWapAehls4QffpeRyy9t2aEoQlvJ?=
 =?us-ascii?Q?EMkw7I9z/qtyL9QDAq/wdxkU4GInjx6DboOS/rRrTJL89LHP80FsW9QiskNE?=
 =?us-ascii?Q?iw2h/1ATdDr9lbvc0jVIDX9nx0kPsXIPaF7mxX/6ewuRinlziQojLcyAp6tT?=
 =?us-ascii?Q?3VpOzLylZSysAqu5n42G8hY12wuu05YGDFv2gbGwIF5HgBhgRn+IH72tBplO?=
 =?us-ascii?Q?fgd2zzszQtuSLD0kg9vZE4bsXuxZHgjebWperEyDAnV5OujgAWIA2PN57CFS?=
 =?us-ascii?Q?1Z6neB2rpKFhDFemye61+/dJnjMLaWQwSUu+4YP2nCJRKOQ+JyGbQHDzCBEU?=
 =?us-ascii?Q?XS4pRJ+DooM/8VIkp29UFCx2Sfliy87GjRrXhpc+ybxEb0oWwv6ihOq9URid?=
 =?us-ascii?Q?CpnTPhApM0lQncjK4GhsmHk5tGl4qSBw3OzRNrzJMVUBmHO7/QBMv918bEWQ?=
 =?us-ascii?Q?cSlV311ag012gBq7d9zahMWghEYxuF/lQRp1S0enLkInMETgrbN05NIhcNze?=
 =?us-ascii?Q?RAADBS9s3v3JAjWozkrv1gH62Za4Eo/Pfops+shILBSKuhUFw7+F0tQKvDfj?=
 =?us-ascii?Q?kNkQ7OAjwrHFHtcA1e1DopKhZy6y3StyqRphwQfAfGEo/33e2Izgu8F7fkAI?=
 =?us-ascii?Q?C7WzbKfpL04u5iqdsWt5MSdGzBpjzn761b6ZBf+6VLcn21Za9EYBXHP57Ks3?=
 =?us-ascii?Q?PY59QdzhRDnXGVZR5yVU7PRCsswpzMXi6eJKUk/ilGF2ctSVzAJbWKRO7YRr?=
 =?us-ascii?Q?GeNOQvVOHKlC71kRigWvd5QZfAp9scAGgFwbz/O5j2Gj81TjybxShnlTBZns?=
 =?us-ascii?Q?BWD8r1XDgbAO+ZbOnCmhYhdBuTyqY8nVH/KOHAWEs4iaOyh7Q7ti/hSkAkXI?=
 =?us-ascii?Q?UTz34ZMmNRMzeN2H9POB00KMN0lK1O3ibY4j1rgZl5jAxyT7+3nJhJ0tbNWc?=
 =?us-ascii?Q?rMzYXhOOj+iJdT/VXlwtDqFd6NT8u5JVG99yRVpjbwjTRRaluP5fnEOYio5t?=
 =?us-ascii?Q?lFQVTBSTG+Yn3wL28s5VscRjjy/WScPhmT6GQnQgN2omjhgT23YW4eVUfrsL?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71df493e-9b26-47a7-dac1-08db3f7aa4be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 19:33:38.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIW5KhFJ2PkGSeYanIVEzc7P2qk5AIp2yWmTTk9E7HZmzcAc9fGurNWapSPq9WDd94n5f3T2f+dVaMDmEbinBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for the feedback. You are correct about the styling issue in my
patch. I will fix this. I do want to bring to attention that there seem
to be a couple of kernel config options in the Kconfig file for the hid
subsystem that currently violate the styling rules.

It probably would make sense to have a clean-up patch for this issue
overall (separate from this patch, which I will correct in my next
version).

-- Rahul Rameshbabu

On Mon, 17 Apr, 2023 12:20:51 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> According to Documentation/process/coding-style.rst, Kconfig help text should
> be indented by 2 spaces after the "help" line:
>
> 10) Kconfig configuration files
> -------------------------------
>
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.  Example::
>
>   config AUDIT
> 	bool "Auditing support"
> 	depends on NET
> 	help
> 	  Enable auditing infrastructure that can be used with another
> 	  kernel subsystem, such as SELinux (which requires this for
> 	  logging of avc messages output).  Does not do system-call
> 	  auditing without CONFIG_AUDITSYSCALL.
