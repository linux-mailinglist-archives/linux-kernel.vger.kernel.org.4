Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8023C72E6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbjFMPPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjFMPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:15:21 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576BCA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686669320;
  x=1718205320;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3arq0zItlGalQQXetkNhW3aOTj46wBq0NZ6ZeUV7Dcg=;
  b=Mk3oLdMmX1bS3EWnl5jmzx1n23TCAN7n1YeBF2Zh5ip94abrJChUQxxh
   Za0QVfKc9muF+9r/MewuxIX5tn/V2t7T7MXg73FHe4YHGDnIgpEipvKaj
   cDS+7giZMaP3BZ5v/M7QhA5OZYuWBbP+elpcRWFZ/K0IskfIhsqBhlKPx
   0+zzv2qzHPZQzfPIqQcG7liw6yGG2VndJgDW8Sn0yuBrzkmIKvyFe8IRZ
   Xmby3YQxXwzT1K7sy+dt9n1HIwn52B6EeM88MGJO76wuPKWVSMjNO6Mxz
   iC2wV4xea9B87y1TqAMswUfU4g7Kwxspb/2vFZH6iKtJdtHQpuxL9uxV/
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsyB6D2Q3aZ37ZDWZ2Pipb2MlXjVtI/PRFE8L/RoQsRIh3NydrEeDNZuJbD7Z3/gz9NQeaop8kjzkg6e0j6tAQ6R9ujM/R6lc6uO+GVGgtKXNXuvJ8C08OH/aw+m8gzszuEJHYX00eOYVjZcfuiQ0PM5NqdVU+nccPxrsS/727iWM2IPB4acQ9nNB4wVnhFAF9nrQvSt9sNDpL9TqWvPs4q8FO4OcIw4s6WXgrIzOKTAHrNzPBueqziA5XgISamPHx63MMn5GQMYsZs3Hat0rYhcIjHtHpRqI/yNFLWiKE5w1ry1LBtrAq7uXygAtYdn499aDybt/q8OA4t2hw9skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3arq0zItlGalQQXetkNhW3aOTj46wBq0NZ6ZeUV7Dcg=;
 b=jBoaV7GD7VCSusKWurxGhtNB03tJc7kV7txqSTImrenE6NxGNWLZl8LCOmn34Rwztn8W7Zg79rKBQBiywrXMSJ0dX27e6hDquQk9g063yUjvMPpDwzVJ+24FMfg3OWwu7YPFmYhg7Rag1fu/ZJSGqQzANVCcSylXlF5gP/l/o1OMYb+KzTHHl9H72L3TX56n28b2tO/gA1KxTkVKRhO5WmnBPOzCUDrEIq/lBPdQGyYdsPdgEcVEIk9geC9kFaHhQ6WhAayvVGm4o/D0bNLZG81XedsHCtlkAptuHzV2N6WTCvLPUzqbNtqll80Hq1Bd7B6sEk4RqXYYdHxSts7qsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3arq0zItlGalQQXetkNhW3aOTj46wBq0NZ6ZeUV7Dcg=;
 b=RIuO5roFpdCBHD8RcrqpVHAvwl9qgqLDfK1Q4clxGOK5lRz5D3HMT/Ne2/e9e9+HNhYvPaE+sARhhrPubAJbE+YXQq9aBk5pI0hfg54374udibm9Q4kC9OzJYzb3YMCPMQJjs/uxeHqvcuJgL0GJRfauH7WVvWTSaP3swYbxpvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Date:   Tue, 13 Jun 2023 17:15:10 +0200 (CEST)
From:   Ricard Wanderlof <ricardw@axis.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Waqar Hameed <waqar.hameed@axis.com>,
        Mark Brown <broonie@kernel.org>, <kernel@axis.com>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] regmap: Add debugfs file for forcing field writes
In-Reply-To: <2023061322-garter-linseed-6dfe@gregkh>
Message-ID: <5b20509c-e4d5-21f8-fc20-4d02b9abd87d@axis.com>
References: <pnd1qifa7sj.fsf@axis.com> <2023061322-garter-linseed-6dfe@gregkh>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: MM0P280CA0042.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::7)
 To HE1PR02MB3227.eurprd02.prod.outlook.com (2603:10a6:7:35::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR02MB3227:EE_|DU0PR02MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: e40fb718-eebe-43f9-ad0a-08db6c20fb92
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrlxtWd5jfU5SYPbCigs+qJuK+IdvxXM23PmqUP6gbyjXt9YvJY1LxhGdXmApM0ud8gJPiTiYWOMb+GVxKigErNQQDyW5I1XCBVlECa3ImUNA1Db6O+YnJBtUFThBKVh6GKQyKZYO79SEQ00uDMLeBGDR6hz1tPW1L7z3B6bNnG/E44WyyK97qPgo9rlmtulHpWFsdXRkzQO1uRXO9y0e1S7fGKpiBVDyLmpe+LO+Xq9j2kw0AwqNmxFFYcqYjIOnc4BmUedmyGi4Q/r1r7/te9v7kZOOJ2nSSIfPHJfe4E02ccQuq/2k23waZOsVyfozuu1/+mEMFxG8LVpbi/DX/9WRS3G2zphqhyHUyTMofFRlpL8fju/dxB7yTD5RB0xEcZTydNfby+UPst+HQHgpWVFNvh7aYdSjLx2UeKLamfYRf3JEnjzpJMYvJj0f2eV5JgS8uSYzIs1aJTcJR0VhlAuUavnHJEsnvZ+Y1W2Vb7NMOgmSemfdVb/VMFmwMxbs7zGfErbbNo+WQdmU5N6xjOL1zXCpOxzkPVOJJTdJHt/OpbOccIOKHvmWXVm/tiGedXarBlk93jEkdWUx8NzxBWS/8vbx7AYXUQDC0RDNR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR02MB3227.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(66556008)(66476007)(83380400001)(66946007)(478600001)(6916009)(6486002)(26005)(6506007)(6512007)(2616005)(5660300002)(186003)(54906003)(2906002)(31696002)(8676002)(8936002)(15974865002)(4326008)(41300700001)(38100700002)(36756003)(316002)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nat/862J1OqxLPmXLxlZPBsq++kfq6bMwKkg0njOB+l6FHfcwHAtAlVEwRV0?=
 =?us-ascii?Q?Nz0ycGHHf5GIi3Hg6B5qk1ZWpRqdKTVXn/D1EzJ0muKW4RFxMwSCsRBS5wl7?=
 =?us-ascii?Q?oSJ3+qGB2LKUyEtPj5RJzStu4FtoqmRd4zuWPQBdkjPwoIiCr4yKUFlAHpNd?=
 =?us-ascii?Q?K05YDJI4Xf+o5FmocA/vdQjHkeJnejZSEBkvYKFAKEsAh4NGR6UApitCpABf?=
 =?us-ascii?Q?ynbifUx6xrUe4wo1zPIana40J3kv1dnV8ixp46To9TMb1Cu+Hd6x64J1MN2M?=
 =?us-ascii?Q?/Xz83Dlvoy/bOahaMWB0abDgkb1EEwH3DXA1AtTq110KstyZbqVAKmw8+XEK?=
 =?us-ascii?Q?Ax4Ef8GGCdgsgEyx+e9pWQNzB9Ju4VWeu9UltbsMqyT6NMVW+CnBp55ByXKo?=
 =?us-ascii?Q?hGz6X8SJ681aNXAqF6UtFWjo17ttiftvU3hvY9UK6YoC+V+v6w+7k5zcFPMU?=
 =?us-ascii?Q?TjDaqHEoAm+/fj2zqxCauCQzScMZJ4mwbzX5CbogttCx3g34Nzf3MufYCbM2?=
 =?us-ascii?Q?MdMqEHzwYBBqvHuBJAig/gK+cWLW6dIp51LTsxDFZPoKDwDvyyAoARBPwtiG?=
 =?us-ascii?Q?tev7S45G7U+XaTLikRHHnL0iUrQg6pld4APx3sGYmOi9BXK4AhGbTaddH8eC?=
 =?us-ascii?Q?6F10pXHRLtzUuSotJSptAvd5hPufFF3Zu3MvO2VeG99ri1YSPoA2VBKN0xRW?=
 =?us-ascii?Q?w5n/B+z4+00ld/LOg7K5Y5vmTlA+Ya/IjDUxnWcRfTve/p0++eiOyY6kwDyN?=
 =?us-ascii?Q?FGz04zgO2YqNabwDT6X7xdy5xw0/ICHowhecdPMCy4MD1Fh+2ZbTB6PSNqCq?=
 =?us-ascii?Q?he50g94B7L6ZBFXu7ccao1/B1b/2QYKU/uOjKnGcD+qp6/pmvzu3di3Er5aD?=
 =?us-ascii?Q?aScAs3qS6KwgiQkwbySlbA6lMr+6uVf0xdGOLTgfUgGZasNWeElOqyB3SQjX?=
 =?us-ascii?Q?GSxHu3iP7FO69ZALTCd2uWp//UaF3ClTb4GTJv26fiuCqw78eMeGNk7l+ZoA?=
 =?us-ascii?Q?Dx9y3anVmLyfN+ri+/h2YWup1fXUPnZPuHAuNukAkPwMzht4HVLK7wl4xRfz?=
 =?us-ascii?Q?/Monf5l4tO9d2ROgPE//lLMBiBB10t01J/lUE+keMIucFMMTrPKfW4INK+GM?=
 =?us-ascii?Q?EmzhGJZITJwMa35I2TNuAjb83e2WQJAkR4yQ1AdEeIdrla6ELzMDlBlQhnLx?=
 =?us-ascii?Q?h3/RWM2sJeIZHy1A5kM4gSg4TEPGuT89bZbvXaaB85X34trFYsKeI/sd56pa?=
 =?us-ascii?Q?IXF1RICm9cNVyJAtYNpU8w7ESbl2FZbz4g7m4Ydey8Gmfm2TeNLmpMSgmBBt?=
 =?us-ascii?Q?u/i0oB9gSn6BSyB7WFybh+o4rBc+VcG3D7RoDC6dgDfA1H5XfGQPzTtHKyaN?=
 =?us-ascii?Q?zRYKzROe5svA5jG3w224tdliWoRMqerGXIAgMBcbGOCgEisJH3UXWtWmLAqh?=
 =?us-ascii?Q?xSljqW8OvzVLFx18Yr0HabwpKvY/DCCSeGP4DO+MNB/VqmUVFdyCc1yKpFYZ?=
 =?us-ascii?Q?H47+Vj2WfJOu0MzSO1wmovZGz/mONxpR8tPNaAxZZWJQNToQMwRmh20spt3O?=
 =?us-ascii?Q?PqFKHe6i/KM1CRLjS1w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e40fb718-eebe-43f9-ad0a-08db6c20fb92
X-MS-Exchange-CrossTenant-AuthSource: HE1PR02MB3227.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:15:12.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH7Ku7elyG+Q0jFNjg457/Yruu3RmccjVMt6bwhikIixABFlq4v/IfWhazv25/r+BoZxmMK7pmUp1Fp3hrPhhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9194
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Jun 2023, Greg Kroah-Hartman wrote:

> On Tue, Jun 13, 2023 at 01:42:27PM +0200, Waqar Hameed wrote:
> > `_regmap_update_bits()` checks if the current register value differs
> > from the new value, and only writes to the register if they differ. When
> >
> > +	/*
> > +	 * This could interfere with driver operation. Therefore, don't provide
> > +	 * any real compile time configuration option for this feature. One will
> > +	 * have to modify the source code directly in order to use it.
> > +	 */
> > +#undef REGMAP_ALLOW_FORCE_WRITE_FIELD_DEBUGFS
> > +#ifdef REGMAP_ALLOW_FORCE_WRITE_FIELD_DEBUGFS
> > +	debugfs_create_bool("force_write_field", 0600, map->debugfs,
> > +			    &map->force_write_field);
> > +#endif
> 
> Please no, that means this will never ever ever get used, and if it
> happens to break the build or runtime, no one will ever notice it.
> 
> If you need this for your device/tree/distro, great, just keep it as an
> out-of-tree patch with the huge header "NEVER ENABLE THIS IN A REAL
> SYSTEM" or something like that.

The ordinary only-write-if-bits-have-changed behavior of 
_regmap_update_bits would seem to be mostly an optimization to minimize 
the number of writes to a device. The way it is normally used in the code, 
it's not easy to predict when it in fact will result in a write, because 
the whole idea of a function like this is that a driver doesn't have to 
keep track of which bits are actually set or not, or else the function 
would not be useful in the first place.

I can understand that enabling a write-always behavior results in a 
different behavior on the associated bus (e.g. I2C), but in the end it 
shouldn't affect the functionality of the peripheral device any more than 
rearranging driver code to perform regmap writes in a different order, 
which might also lead to fewer or more bus writes.

It seems I'm clearly in the wrong here, so there must be some scenario 
I've missed. It just doesn't seem that dangerous; it's a debug 
functionality after all.

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
