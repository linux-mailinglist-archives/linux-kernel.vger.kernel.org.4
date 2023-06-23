Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57773BF43
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFWUO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjFWUOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:14:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994132726;
        Fri, 23 Jun 2023 13:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnvcqRziGUuV1DHNTj1D7Pjo4bGk61HdAQ3yPK/tH8gwpOatpIfhZWRrXNbnkdNpeCmvwmdUlEsxck40mHivjTqTfH09/iot/A6bK/1bHF78oQnrzFGUlvL6n8Pptm5lCX2Q6rEC/rVZkExGaR06C6L3P67N2cFK7SpMPsQ0JPrVy917uE3lcT7WhjKT0j3PvbcB+IOAHv3exu+dWMFr3xx9NX5O7O2mD6Qi3YGA++N8QGELQ9IZre4KFkhyNKuyQOi+qKmlcSdm0UVo4LynZMlc0fDrhEnyEAkicPNlu4rjD4wRGLFwLG+oX+LzMDrMiM/DIScDTIZJnxo6o6EGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5l9RZcOUkUw8aQxrfzMmUk9+bpk/jDDHQ2EbRl/Cl0=;
 b=PbooH4aZIp4fOlsja5mn2axfkrAtqTJUuGYYGj6WMHylFk4AP0mxu6i7+sKCykO6HU5KR9+MeQRSWSCT3Sp1PkqlAdrPaPK1HbN5lgY0+QqlLnO95YZ6EhaSzFbXQofKebt/4Jf5DWIWZEzx+aHh5ttOcqdUtGUY3jn1WFCxcAXjIiZrfQHe1YU5Fl1NNcVOdeU1jQ8GpGPeoslBRpJXQ0Fp34KxGDkU11NWmH/1LUoeFD2ftXbiVLF3LjkELbAbvjfheZo/kRlJyDoHg80KU7SIxhBO+nyr5mIctlNtGJvmO868XzY/Mp1evaJKRLih35WSzfqJ4wzgRc3NJzDDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5l9RZcOUkUw8aQxrfzMmUk9+bpk/jDDHQ2EbRl/Cl0=;
 b=TbNDaQDQLeuGdc14HzEW7+hMPR41WAO5Gd5o8kROMjUeuHp1ZHmerYlGc/27q5c0NS/FWzROnlH/rylolNXMIpddg8FeWB3rL8MxNz003D8WTqi8dVKdM3ymmChjO/BNhq9gVUYFKSlJig7zMfU8BxKP/mwwJx2OS6uc4BuBHaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5315.namprd13.prod.outlook.com (2603:10b6:510:f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 20:14:18 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 20:14:18 +0000
Date:   Fri, 23 Jun 2023 22:14:12 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        netdev@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: cpsw: fix obtaining mac address for am3517
Message-ID: <ZJX9FBBvOTv10IO4@corigine.com>
References: <1477668756-2651-1-git-send-email-jhofstee@victronenergy.com>
 <20161028155213.2t3nwwe3lqaynaer@atomide.com>
 <d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com>
 <20161028181914.mskebckucukzhxhz@atomide.com>
 <yw1x7cru445g.fsf@mansr.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1x7cru445g.fsf@mansr.com>
X-ClientProxiedBy: AS4P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b825153-bd1e-42b6-bc98-08db74266ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PP06zi9zUwm/fZhqSUUhKNASoT/ZfWZxars2H8EEZBqowhrFa4zQFxL5RfCd/Z90WDFGmYmuopuSGXVHdPPZhSGQNxfTIhFVj/SA3s0DLG6/wKaSpbS7pnfptDnCKffNaOkdFveBVKX8vZ3i9+PRcJ+BvyArCCSifVknCVgpGuxEpBs2+SdjCc8F3MHv/XYcc2o2QkV6WttE8jpvPOhUS4t+N1wZaz0MWmCI3j2Uz0VqYieollywvnw8f0CtBRc5nlWNCPY7eltRV2HsP+zjbIELinw0VAbmrlRLNwtv4OpUuM5v73k11+z6Yddl8krF+Vclhgvto4zn6mUncDrVNv244HXNGODHJKxfguKjj21rf2hkAHh5uB2l7aa7qBKIpS5cyHQITCPojGnMbjMveTiqim9QNVRnj54xuHYo9KrwqlVGEGW2A1GMuDHBfff7byjnT988fS3Hjarye2inx0+SrDkVnoLywdZ9MEyBX4pf9GoHmC6fciV/zdT7Ckk1H7FtkCrhx982fZq+jf7yZbWOkjQbm4VqpniePiKQgiEdocHCG7ElbW9yGv+XCJutkQkOkDMdszTmln31ZVlUUIZJkANafdmlXDWVfF2z1Bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39830400003)(136003)(346002)(366004)(451199021)(54906003)(6512007)(4326008)(6666004)(966005)(186003)(36756003)(2906002)(478600001)(86362001)(2616005)(316002)(44832011)(8936002)(66946007)(6916009)(66476007)(66556008)(5660300002)(53546011)(6506007)(6486002)(38100700002)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBZQmhXS1Y3REtLS25QQ3NxbitxSkl6U3lZTUU5WnYrQVFtQ3d2dDBKV2Nj?=
 =?utf-8?B?QW5iUVRDenI3TUVLUFo5ZmJNMlpxYUJiaXFqYXM5eXRSVHZkOXc3ZVJrYUgy?=
 =?utf-8?B?bXBkeGRHWDlkN2RKRk82NTRubkhKdFFJOHdaQW1MTmx4a3dKMVZVdzRFOFNS?=
 =?utf-8?B?bjJXRXlKTVoyRVZiTHV6T2dNdTh4cG5sY1pWSkJpL25rZjNOWHhhTE9QSEJR?=
 =?utf-8?B?a2hXWWk0REVidTYreEhwcHNlSDJOZTFleVJ3Y29aTEYyUFg5dTA1MXBQOVBv?=
 =?utf-8?B?MFhSTk1BQ09BdHg0aDRyQjBBaXhsQi95MlJuaUVaL1VPM0NBSHJlekpnbUFu?=
 =?utf-8?B?czI3YmV3S1poL2NrZXhDbjBiM3VnTE5TZ0pzNGJQSnN1Uk4rWnFpa3FraFhv?=
 =?utf-8?B?YThIU29WRitJejAvTWJjNWcrcEk2N203VEVNSEpYVmlTdjU4b215dWNVdzVR?=
 =?utf-8?B?MWlWbEZRb1lpeXBPQ3VRbXN4aWpDTlJVa3FVdy9sVUQvdkdIUG5vRkpVY0tq?=
 =?utf-8?B?alFaR1htcjBhVkp2UGFQSEgwbnhxeEFpK1pJSGNZbHRwTlB6M211aytiY3ov?=
 =?utf-8?B?MmFUK1NMaHdSQUJQU0daSHR6OVY1OHp4OEprZEM3cTZYQzVIWmYrSlAvL0ky?=
 =?utf-8?B?RTAwalJCNUlPUkg2bTlGYk1iTzFjcEZ4dXhGakZwbkVKN3Y4UGc4ZDBSMWMz?=
 =?utf-8?B?MWNRWXJOM2RFKzJLTFNLQ0lSN29xMDdYZE5icnpCNVcvZXFVTzNrZzlzSllZ?=
 =?utf-8?B?eTl2YktMaDh0N2l6UnRKMWhNQ0VwTVlMOW4wYjRQYVd6ZUVZdHoxSGRid2Rr?=
 =?utf-8?B?c3prSmlTUG1aOERpQ2x0SktsaHRaVjJlaGFFWUt3cTZIaVY0OHRMRUMzanlE?=
 =?utf-8?B?SnIyNysrMU9aZGloeVMwKy9SNHFoNGlXZVZ2ZUZoNVkxTmxsSEgzSFBtTWlG?=
 =?utf-8?B?TTRtdGFoNEJPOEE0NTZvNGEvbTRmRk01NjFMWE5vRmNiMHZHb3Y4dTJUbWpy?=
 =?utf-8?B?b1NZUnMrQjhMaHJ6SkMwNEM4SjJLYjZKbU9BcUd3Vyt5bjJidWZWYnlydml2?=
 =?utf-8?B?R2ZLU3cxMWFzRWdkR3pLVXgxZW5kUUNvVENwZXNON1FnSUlKVitnbDMzdWxx?=
 =?utf-8?B?VVl4bmZhVW9YeDhBQlk4eW1KcE9oZU5lZmR4bU5yRWlPUjJRK0JYR2tiSXJi?=
 =?utf-8?B?enpyWHNrSzQxb3QyV1hldno5Nis5WFo2NGFYWWVHU0pyN2RKSUZHQXFwaTEw?=
 =?utf-8?B?NlJyTGQxUlBRZkhrS1N6bHFuYXk1amNMWDBjL0crNlhOS3lGNmJELzhyeVRK?=
 =?utf-8?B?d2ZWUHAxL3pheHZEQzFLL0xKU09nQk4yR2FPTXpFQzZrMk9XWUp6U3VFaVRS?=
 =?utf-8?B?Mm9taTA1MUttRDV3OThPRWJ3b2lpU1ZYTEJuYzJ4WHBSdVRacFlJd1BZcXlq?=
 =?utf-8?B?TzNlZ2ZZTFVkVVplTEgvbUpRTkdFQlFXUTRVd0I5Y251cW45dnpHVlhKNW1q?=
 =?utf-8?B?bTh5Rm5rUGJtOUhmQ3ErYi9OTmxoTkdldk1mUW95TkhzRDF3T2hoZTI4ajBI?=
 =?utf-8?B?eFJNc0VDZEdIcEJYWU5pLzZZNjQ5WGlDVCtJMTJwaHhYZjZiTmZkanpYam1R?=
 =?utf-8?B?WW9wZXFxM1cxa0M5a0k0MjU0b0JIUW5VOFYzTFgyVU1PQ3N3aWsvUkVnRlhX?=
 =?utf-8?B?bVJsRmI2R1lPZzJRYWZmS0RRNDdwVWhxWjVWNzVFSXZWeURCSFdlMUdLMmo0?=
 =?utf-8?B?ZzFBUE1sZDcwYkdWckdyRWMwQUNJZ0xsbVQrQTQwamZqOFVNdWhaRU1KcFVh?=
 =?utf-8?B?SFB1Y3ZZRllDeTBaYkNaKzU3SkwzR0JTWWxpOHBmcVdRNndSQlBxOVA3ajJo?=
 =?utf-8?B?UU1VUkhnbGRjY1JkenpKbFlXcERxM1djQUdQbzZkR1FmOVlOa0RSS2JJeW1k?=
 =?utf-8?B?YUJ6Z2NzNktveGdxeC8vQ0pNaHVMWlJQWjg2WXRiYjhVamJCdDNDaXZ0TER4?=
 =?utf-8?B?WUpkTmsvUnJEQm5FK1pIdURBV3ltSGgzR0Q0MGFKUUhWZFNiZE1JaUtUU1J2?=
 =?utf-8?B?ZngyMHNrU2ltRjV6MERqU1pVKzkzUmVzOGplczVzYURtRzlabi8wS3FJMGo5?=
 =?utf-8?B?ck9yV1pxUjRLVkFpYzFZaVF1RlpmREEzUW1xVU1OT0JoeG9seU0yeTBKdGpK?=
 =?utf-8?B?Y1hpT3krMHZMVC83UVQvdzFFRnZkTVI2dzRDOW01V2lpOGZDbllPUTNLWXhl?=
 =?utf-8?B?NmludSsxSlZZOWtnRWRlaXZUdjFBPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b825153-bd1e-42b6-bc98-08db74266ca6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 20:14:18.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PYXjbicyM3yAENlC3NPj18QoG6BQfNdpfy/gILI+7jA6syrCdpEqFY+eANyi8WxDVkiOKsNTsJwHXVu40O0KhNaqeS6rw+tMKBH6bhv80E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5315
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 03:58:03PM +0100, Måns Rullgård wrote:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 11:19]:
> >> Hello Tony,
> >> 
> >> On 28-10-16 17:52, Tony Lindgren wrote:
> >> > * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 08:33]:
> >> > > Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
> >> > > id to common file") did not only move the code for an am3517, it also
> >> > > added the slave parameter, resulting in an invalid (all zero) mac address
> >> > > being returned for an am3517, since it only has a single emac and the slave
> >> > > parameter is pointing to the second. So simply always read the first and
> >> > > valid mac-address for a ti,am3517-emac.
> >> > And others davinci_emac.c users can have more than one. So is the
> >> > reason the slave parameter points to the second instance because
> >> > of the location in the hardware?
> >> 
> >> Sort of, the slave parameter gets determined by the fact if there is one
> >> or two register range(s) associated with the davinci_emac. In davinci_emac.c
> >> 
> >>     res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >>     ...
> >>     rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1,
> >>                           priv->mac_addr);
> >> 
> >> So it there are two ranges, the slave param becomes 0. It there is only one,
> >> it
> >> will be 1. Since the am3517 only has a single regs entry it ends up with
> >> slave 1,
> >> while there is only a single davinci_emac.
> >
> > OK thanks for clarifying it:
> >
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Is there some reason this patch was never picked up, or was it simply
> forgotten?

I feel like I am missing something here.

The patch possibly dates back to 2016 - but I can't tell because
lore.kernel.org doesn't know either.

https://lore.kernel.org/netdev/20161028155213.2t3nwwe3lqaynaer@atomide.com/

And I see you asked almost the same question in 2019.

If it is still relevant, perhaps it would be good to repost it
for review.
