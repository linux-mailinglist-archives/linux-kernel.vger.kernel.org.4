Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700AF5EC9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiI0QlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiI0Qk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:40:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F531DB57C;
        Tue, 27 Sep 2022 09:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqrIuz6vNPm4lQcHkS01YBCDNEobbp9H6MIgn5tiKjTcFf5MFTOlh9RiBJmrv/9k/Qq+SFMH7BeU2Ii6nZznpUmQRU65q51WjUDLCE/E36WaxpbAsFjGFEXELQPv4NkjVUHM0awOY1ut22bM4XnF91MEIKj7Cgk/Kv9UIATjzPpv/fIbXCQJSNU15OPkDwH4oT+OKpOE3oL/v99s6ypPqM5A2PnrKdfL5EhPPQR2j/ZU5EbEz6pz50zTnf15e17Wd84REhl5c8iBkHhELJcmqHkc4/Gu0aE72t7Z+KAofQdlK0D4pIHuWz/iEapG0sR5YB+Ar38CsKQO+3ehnD37gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4UQ6iBZCtXop15IcvZVpkQDP0JdiQ7jKet/iFOskqg=;
 b=MnjGFsXRXX/PVegoU4VLHH5EOvcUemPZootS8RNDdTNVqfZz4d1YN+lFq/Lm8Yc3LXtkboeUa7HEOeYyB74h7cQgc0uzqlvcv4kGxh0dEmGI5URUWmtQxRCCnJR1Pj5F2Zj1hLQBmnjISwDHnioAUmnPzQ9q4CKKeoJZTH2uFSX0Nf4a+pXUEnXpnAM4nRUyrLFg1XjKlkCdrah8SG1e0bausflIOv9cggmZOBoPUUMu5T0zt8SUvDrHZjgnJkVt31p02+rrxy3/tO+mywHFXOU/UJB/WPRgEaOXmqBzACnlHdgXyQZydwr+4PhpsTHX1eW9rwFa6XEIXf4P3eYwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4UQ6iBZCtXop15IcvZVpkQDP0JdiQ7jKet/iFOskqg=;
 b=Uw/rF1/y+2b/I0OuoOuN9J+JpuhfT5og3iyI503enhTky3o/NvcL9uzpkOOvkIlFaWv1LwGUFVtqmV8CdGsy5QK8QhnwPqSlhQPGjtBXDX9FC02ll2IL2fPukmpw99qtltURWnA741ZqW83W3bijooMWYompWT2JBzThOQw7RspXznBbmQuhXNLF/1t+hp1GfQ7uxTUtfKaqlkP2Oro7Fcj6PaQuHSznUDFF1QekwmYmlkW/roNo/UlHF6gAERUspaPuaGS3InFU+sLPzVpD01ueqaZB8MzuyZYSgEmXPIxKofpHOmDhu9fUehgavrZP+SW1ZvrtGYDJ1F73FMeu0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 16:40:45 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 16:40:45 +0000
Date:   Tue, 27 Sep 2022 13:40:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommu/s390: Fix duplicate domain attachments
Message-ID: <YzMnjGksgRdKFwCs@nvidia.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
 <20220922095239.2115309-2-schnelle@linux.ibm.com>
 <YyxyMtKXyvgHt3Kp@nvidia.com>
 <b581d4f575b834831f8c17054f73b5b92a891d25.camel@linux.ibm.com>
 <YzGuc7jVSvE2g91T@nvidia.com>
 <07d5527984912ef4c9174fad038ae951a79fd4dc.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d5527984912ef4c9174fad038ae951a79fd4dc.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:208:23d::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cd815c-72be-4963-e13b-08daa0a70660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddbVv6D9XAmtbqvbsQ0Wi3ymiJ1RPxRcPtepk5bqhzxZW1o5Z7ldVrr0XPqCBaYypMx4/s4CrUZ3e8VJRn0PHkdm5/8+cxwSbBftg0NxsYjbIRPjG2XLULKIikAdVpaDFzAkjmWyCqSJEuyWnQHT3X88W6CWSQc4021KlJanHUj8mAf1eq1dYXGh6W6wbrOOaGZhLNTvWh9TIssqDGsTjpgHANIV1T5AQm2MzzOvKqCL/CdBqFAxOYa6PHhc+4ICeUPUP4Yet6QC3vGnMNX7B3NlbHxXys+5rU6gI61SlTlmFUdWdZHxXnck5U6DKjO2s3x0u3utYpU/Ri2+fSxkWl+u57SAM6xw50JZ2N0JI2DXNbZjVUBhif3/RD/EIOcSHs6Iog4ZJd+lqxyScSmq5oyAzPwh3wA8jcg1X7LXzUEYtNfI9j+srfczIfITsoKfU5ZLsp7hqNhLcMGNmnZ6IHKHfin+KwACLLrpqDUdX6wJyKWGUhr9/Iayjsojc+ALfqHcVqaK8Ze76ZROvSMRODDVJlVTHvHy7iKy9BGncbQ/6iyWd8OLdXxAb+eS2ehI+2wqsdnIv7zPKBrctSmxNyE+15PAAXecpf6gxMN21OzCMhFxbgRmbYQrt/3X34ozgwjZIcNgi7YGi1Ps5C0HGhV1+wkSk/4rFAfF6RG3cL53vkTt6/aiYt0LVlCyiNuwOgwSPz8o+ypkHufBZBxTDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(41300700001)(26005)(6506007)(478600001)(6512007)(6486002)(5660300002)(86362001)(54906003)(2906002)(6916009)(36756003)(316002)(8936002)(66946007)(4326008)(66476007)(8676002)(66556008)(7416002)(2616005)(38100700002)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Us/DN20+DBDgBdkeBVCoM7GqxOtRgJgAZyPsczESsJIOd/0XP9XBBlXGzwji?=
 =?us-ascii?Q?sQbDGCsfefvEVDlUAzFsPL4w86wNhCfMQhj6o8Pc9yAYqeKsLB8o8IVpGU3u?=
 =?us-ascii?Q?k0WUq3OfZ1P95XkNbJqBJ7tHuz1YbO/yMTZSvrKHRy4YMFYfchsq1Hn+VhVY?=
 =?us-ascii?Q?/2vECk6++pM3FbRR4PSsLeJLKlTCe0URqdXivE9rn+E9Ghj2tnDBYKieBeG3?=
 =?us-ascii?Q?6CCCG/6guaVtjoDBKVRrcsG1l8kiCQ35nYzyzkSAAC63DuAghNTu5s01gFpv?=
 =?us-ascii?Q?Bd330M8RnZP3XwDXyz+Gcy7yWSqMTmn3F3RifmbMSfN730MvKhgi0fz0qTC+?=
 =?us-ascii?Q?IWPI6LVUrOrnGtGYnmpbJxrTerViBIG6LOJoH4w2XHYHf8+md9YoJ+0lHYL0?=
 =?us-ascii?Q?shHtF3mk8beza1FXspNlboVedURLMzT8OYKORq5qJ8Jfw2TFRxJiju3M6wZE?=
 =?us-ascii?Q?BXxiS1KW9eyiT8DzcEEBtd1ds7uFZPr0R6xAnd/snC09icf84Xtf56FIxYfH?=
 =?us-ascii?Q?iJ4HEtgX3uATWKoPAtzd/Eoje03bNzDOA34ITAcOJbtNhlLVUj9a9LpO3uj7?=
 =?us-ascii?Q?A9a0P1zzsFSK4KQ6TOmOl0MgDheOF1QaMVmxL63n+t0CHDioT6vepJQPf2qn?=
 =?us-ascii?Q?gLlnfJ4KWL8fxEy/4GmMrgwiBFpgTjImm3tUZ7h1VDDJ0920shITwRTn906I?=
 =?us-ascii?Q?88j7hKmk+yspC5gui8Z0ZH8PQru7sRiP/2wmg9qN+Zxu1BmYCrm2FtBixCx/?=
 =?us-ascii?Q?0ok7jiqtWeN+/EmGlELagdW6HHJoyQPOSbt6k1VY0w15Q1L4Nf0QipnLSiKg?=
 =?us-ascii?Q?HYNlLibJQPkukZGNXVoIzgOm228qw+AuHW2uXilNOxJ8VgEWHiaTnnR+m3tr?=
 =?us-ascii?Q?U2sm/iCI1LWzx6BhekV7t8v1taxVSFenIAAEeOtnGTLNNC4ofuiNyao55yoE?=
 =?us-ascii?Q?7Z5jKoVLackkXsjiFeKztNTuHn+bcaP9uMNBcmPsctsYCrPuoW+YdGHTKNc1?=
 =?us-ascii?Q?g68U/EeCyoOAy37nc18AxbRI8JvatPjwiOCCzd1lC9mR5nGInNI3nBqh3Zgc?=
 =?us-ascii?Q?RJfKsGRoeI3Z7JvXemiw6360mDUC/bK5ZsDp/HpoVVMrSqmZK8HkhRlFKbHO?=
 =?us-ascii?Q?tViRR7sTApYV7wD3gIyDTwg/4ngR6lOk2guPGexxg312V6mcaIvlzIVdoauf?=
 =?us-ascii?Q?Pqo/3sswPBt4mviibVqbCyhA0JLKjDiWz/pWJr7KmGGxnBaSre5B4ZBiyZRx?=
 =?us-ascii?Q?ySbDH6RVJ3ThrOBODjbtWSgOh2FJRl7i3mqpPyyzYegc73F4ZP1w23zXrJ/P?=
 =?us-ascii?Q?xsn+l5/XjGVqhGPoKaOHfFXCnL6i3jH9cC1BSsjrxSiXqbKT5Ipp+oFbHasG?=
 =?us-ascii?Q?D1KGr3MMLDv5K+KQm/wD+STX2c1bjZ8O1fzMllY7X8EOV+4Wnmjuyg84jT2J?=
 =?us-ascii?Q?mKGOAa2ZJBTuxWRDkkaiNs/MiHcgcMc2hvYJqkg/t/oyoFHZ4rVqs7arLmMn?=
 =?us-ascii?Q?lEphZfNKskuiEDAF9CQU54yz+JLJ5NCvgnsQCxD1/2q+TlpttiSYUdWOeeOT?=
 =?us-ascii?Q?za91/QGtdA0wUeLmMZs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cd815c-72be-4963-e13b-08daa0a70660
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 16:40:45.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5V5l0RLiEQR4+ZrBxfo2LU1AH7Qv2JvcmefRqazwaAdxvWOhOVFSm3dUC3qtmrq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 06:24:54PM +0200, Niklas Schnelle wrote:
> On Mon, 2022-09-26 at 10:51 -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 26, 2022 at 03:29:49PM +0200, Niklas Schnelle wrote:
> > > I did miss a problem in my initial answer. While zpci_register_ioat()
> > > is indeed the actual "attach" operation, it assumes that at that point
> > > no DMA address translations are registered. In that state DMA is
> > > blocked of course. With that zpci_register_ioat() needs to come after
> > > the zpci_unregister_ioat() that is part of __s390_iommu_detach_device()
> > > and zpci_dma_exit_device(). If we do call those though we fundamentally
> > > need to restore the previous domain / DMA API state on any subsequent
> > > failure. If we don't restore we would leave the device detached from
> > > any domain with DMA blocked. I wonder if this could be an acceptable
> > > failure state though? It's safe as no DMA is possible and we could get
> > > out of it with a successful attach.
> > 
> > Is this because of that FW call it does?
> > 
> > It seems like an FW API misdesign to not allow an unfailable change of
> > translation, if the FW forces an unregister first then there are
> > always error cases you can't correctly recover from.
> > 
> > IMHO if the FW fails an attach you are just busted, there is no reason
> > to think it would suddenly accept attaching the old domain just
> > because it has a different physical address, right?
> 
> While I can't come up with a case where an immediate retry would
> actually help, there is at least one error case that one should be able
> to recover from. The attach can fail if a firmware driven PCI device
> recovery is in progress. Now if that happens during a switch between
> domains I think one will have to do the equivalent of 
> 
>    echo 0 > /sys/bus/pci/slots/<dev>/power; echo 1 > /.../power
> 
> That of course tears down the whole PCI device so we don't have to
> answer the question if the old or new domain is the active one.
> 
> So I think in the consequences you're still right, attempting to re-
> attach is a lot of hassle for little or no gain.

I don't know about FW driven PCI device recovery, but if FW can
trigger some behavior that causes the kernel driver to malfunction,
(and not having a DMA domain attached is malfunctioning) then that is
a WARN_ON condition, IMHO.

Especially if the FW driver recovery is done co-operatively with a
driver, then it is reasonable to demand no domains change while
recovery is ongoing.

Regardless, I still think this is a bug in the FW - it doesn't make
sense that a domain can be attached when FW device recovery starts,
and that the kernel can't change the domain while the FW device
recovery is ongoing. Presumably FW should block DMA during recovery
and just book-keep what the domain should be post-recovery.

Keep in mind, we already have some WARN_ONs on this path:

void iommu_group_release_dma_owner(struct iommu_group *group)
{
	ret = __iommu_group_set_domain(group, group->default_domain);
	WARN(ret, "iommu driver failed to attach the default domain");

Attach is really is not something that is able to fail in normal
cases..

> and the device is in a defined and isolated state. Maybe in the future
> we could even make this explicit and attach to the blocking domain on
> failed attach, does that make sense?

This would help somewhat, if the blocking domain is properly recorded
as the current group domain then things like
iommu_device_use_default_domain() will fail, meaning no drivers can be
attached to the device until it is hotpluged in/out.

However, this is hard to do properly because multi-device groups
cannot tolerate devices within the group having different current
domains.

Overall changing to the blocking domain or back to the default domain
should never fail, drivers should be designed with this in mind.

If fixing the FW is not feasible perhaps the better error recovery is
to sleep/retry until it succeeds.

Jason
