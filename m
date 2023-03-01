Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302D76A6E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjCAOgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCAOgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:36:32 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0555342BD8;
        Wed,  1 Mar 2023 06:36:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNVv/AeEQwUXhCUNxw9RY7OzgLm2DbUtIJvxSlbNPXDk/Ht7pXmxCovABGd06mTDit09kKAyu5QdoXVUdLVtsDlBGRf1PtMaKqiR/FXCR6snI0tuL2jFEWidV96Ocxqgg3NxMEyWFJ2Bd7V3yrVPNzGnJxAsKwgRB6+C1rqdx4Au4SPYPJG/10zYYxG+h4NqWnWuUB4TgUwFQo+atuC6OPgt6fBVraLajZQw4+o71y5E8gMnpyrJHGJQdKKBLASBBbBYi9ygxPh+EMn3A9bT83sMTdjwWzUMPOEStB5Rn4+p1aqwHPT/bu995+ILGGW2tqDqpn8vH31eGDqXGrtTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it/NvwhObiJHAjkGXCbWiJgPCyaBlHL3VEFuoKT0ikM=;
 b=kW2AUaPehCu9cEWcSAVlA5M8TsfpoacCM3q4GWarsQAIuzQs4lz1EZNLncvauW77Oa3J4sSVyaODYnwiSfvm8B2qg6jkJYm0AG02aWuyV6TmX/UrwR9SYrz3jfy6xL5Nn7v+kBiQR59uA2QqSZ5DZQeu3MRKdYafnoH4PoidEO2iVh30oOYzO7RYImae/0gHSHY8DYs31vw/SSEHfiBr3v5j4SkUI4Sd+UuttfK3+ssZaAH0Y06HtXXYRZanCg9PHeOAFoEbbjqW0s8MFG6x4nYFb1N60FrN1vArOqIEHKlHhpHEEWzS2joB1vYGytOeia6yLj+KDXC8v3JN1nMGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it/NvwhObiJHAjkGXCbWiJgPCyaBlHL3VEFuoKT0ikM=;
 b=Wk8hknaP8Xz3TtRI4xx4gBBMcEhihN/VhEbHChvXL2AC4O5kvUleTTSh3x49jZqsUjdpl0u4MZzR9Xh4ZNVp73LK174VawFBXVu77QI2XVT2ycpk60EFvzCVMBKXyHS7LmSNiqseQqWk/PAZg2+V8dIQofT4ayT751TGlDh2HZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM7PR04MB7175.eurprd04.prod.outlook.com (2603:10a6:20b:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 14:36:28 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8%4]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 14:36:28 +0000
Date:   Wed, 1 Mar 2023 16:36:25 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <20230301143625.7kdnzujlv4psbhla@skbuf>
References: <20230223203713.hcse3mkbq3m6sogb@skbuf>
 <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
 <20230227234411.jqmwshzkeyx6iqyo@skbuf>
 <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
X-ClientProxiedBy: BE1P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::7) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM7PR04MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: a2483353-6957-4246-b517-08db1a62576f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99VUEqcqFBZmmipPI9JPQnX3VxrKDUAr3hYHfCFhChWeH4kd/vgbxDO9j+h/foYwn26Msf2wrbUgrd8zpGhd+7+k3QVkUzIUa7n6ooB1D8WW1qUjGBSki3kdSqo1ZszAaM+OYz6e8CsPvSvC+ARr4lMTfq0zpg+rbMNDKLpD55VPVZUiS2ezerBzfT5o3qigS2Lzn5W1C5knO+wMd/PrRPWXnsrqW5ctBVfyX5RewRuu7R3AxOgRdMTq/TLTm4TO8okxUYCTCOht5h8mk3E5osuu4EQATkNnyhwVX2DgTZkQ+fcy1E1RZLnLlWjnYLOhSYgNBbtITmM0UHxpTPQJpmUv3ZBxW9LG0ysK5olvBv9cxb6MB74Bs8O33AOLK3tK93CDcg3KE+eWNw8pXLuHKDsZdm9oAbNxhU7Mbulkie+3vXamreTIEEcnwQ/iH2ypWwT6Rh9TXFiB49oqgxTMkjFhGkJAuk9pz0c+omTfoBLYrfi0Rx73XolloUKtlxnC8y48wuwzspSCNt+3mDm/FbdOObBgBQv9nQb20CKujHwWZ/SJFr73PMlnsM/thBxTZS7Qpch4uF+jqrnaQtHbRqxT4j8Fr4vmZ0kJYF45inWpgg8YjxA+oPrGhB+0N6W1WhC5P/OFeQwTAkqOOhaL6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199018)(8676002)(38100700002)(33716001)(8936002)(6916009)(478600001)(4326008)(66556008)(66946007)(5660300002)(66476007)(44832011)(2906002)(41300700001)(54906003)(6486002)(86362001)(6512007)(6506007)(1076003)(6666004)(316002)(9686003)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?68H1AvyqsUP1N6X3k2Q3EhiaXj1Axm/j3SPJSOWMgR/QspfbpW6l1UgQIGKL?=
 =?us-ascii?Q?eFkUyYjRT2D+n1RrGqUpTpABUHsDR87luQ1E+kzJ0BQtuyV7Pv5jOaGll9Du?=
 =?us-ascii?Q?lSDOH5uo2/4SaLiUSmBzrGi422DoDIo/3bdTfOyDCVx6KNvbqVFkEt+lLXV2?=
 =?us-ascii?Q?LMYwtuIGp02ZRfamnmeLg6bdgN6byFLOSGaNkp+sTVv8ZaQgz3lw6OiePQTL?=
 =?us-ascii?Q?5n2a4vPmZVDS3weAHItbQ7YQWW1h0DFmLb2fFg2rb+n14otgbeKR12+Z7ZuH?=
 =?us-ascii?Q?6KgreOJqLehsMo7wquEstOPVjoYYuiMvTT8e8Cx3aRT+jbVO6MTPXP+wiQoP?=
 =?us-ascii?Q?ShYtb3p4qTmMv4NcK4+FVuwum7YpmijZhRVLxk9K55QbvUcCOfzC7FELLzfa?=
 =?us-ascii?Q?Q+jzqEqOUfN2Dsjripyq5w+QhrXQglRSnOu3/mCOGwt9vagXNazM88u8B9jx?=
 =?us-ascii?Q?zxb2/cn/EtWjThGxnSjt4bWXr1uyprc5aQTQpWwC9fx2BVYkOV7cronLniRn?=
 =?us-ascii?Q?mnujRikvteofwyYQlplM2YLrMk38HggrMggHqHr69OIanJIDeTsNohsQPinA?=
 =?us-ascii?Q?zxxOCxHM3dMmnhHo5PjwBzmW1Kj+M/HWdVcUB4LkQu9rXd11kRTQY3H7iPVl?=
 =?us-ascii?Q?Gu+fgbMADBQ8hbMLjLJ0JtUpjO9Jj2V1u4e9HPz/eHECEGvuEYT0VX5lfRaN?=
 =?us-ascii?Q?y1b1oPZpL8jYilghwQ4Ee4IjduHqwR52R9KBbyUNSqj97t1fFGn2q16tCCFB?=
 =?us-ascii?Q?5xLhEo88u1YPTe+t/Fln2jTXp9XCq/t9TLiWowfmApFWmFIe0MpO7Yt6G+mi?=
 =?us-ascii?Q?JPvSeYgHoG+6P6srilcWTxrOrmIfyTvhxRmEtZj6uZ1g8cuNOOFXDGaOjzQb?=
 =?us-ascii?Q?K9Sq5GlRRtEsdek2nGApYOUfi/O0HnPKy2djpiwBzdzP+8SlCx4zWx3gc2J6?=
 =?us-ascii?Q?KsideLHlV0XbZ+Ss7B7KF60rGN6N/N9vFSFVsjqDSNFBIcwHzx8fG9Xfe+Jb?=
 =?us-ascii?Q?tQryMBeZIWEc2+ytNa8Cis/MKiyK7WoVX4X60aYV4o6k0UiKrxNK+g1dFHCC?=
 =?us-ascii?Q?zgRvhqRkwE+2UFS8zJRtTQiK5nSeANqHi/DqWYn+4OOIq0XdsqmYTaanB1Li?=
 =?us-ascii?Q?KObjPMDLaBBTldriaeA4nnNUHYjz18l2AezJ2itDWKrXW0BMCWMqKEbBb855?=
 =?us-ascii?Q?UlHan5wDXD98di5ON3yXVZm6xr+ytCWr3qwgB+569EyQBBVsQrGUVJ9EDAeO?=
 =?us-ascii?Q?7/yfN885yPSzMeyu4AZW25UZIk829fInVyZAhkC3xoSATzM07imYRkrAa45h?=
 =?us-ascii?Q?hrfQu5Ni/PH2s8Q4PUAt3zhOhx46okU38kVxR1OJgw9AOU0O8XieEiqV61BW?=
 =?us-ascii?Q?LWSIKMGSMxs9fu1UwpuHoFRejiIL1gtfyCGBXusbxSDyKkxXvsHuyERqMVej?=
 =?us-ascii?Q?71u0/ZXbQ4VlMaUa34jCbAQlCQoJMS7LiTNzof5na1nhXokCpoqpXQqHapCT?=
 =?us-ascii?Q?i7ENsYM9knS41u3it/LrsXbCu2JAdHhv5DOjvZCwsJYtsjP/61tsfMCFOOAm?=
 =?us-ascii?Q?DzTmNBxSPIir+VBoiwOb6so6g6Yav10e8BT+JvgbCuSVWS8U6Lp6WoitjBOP?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2483353-6957-4246-b517-08db1a62576f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 14:36:28.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyhzhNws92TE57vp2WlamD/ew548DMQb/1Sj1axii3E8oIQFci2mcn2xfLIG+1abZmf/joF1+kkPRWLFlyHRVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7175
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 04:33:16PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 28, 2023 at 01:44:11AM +0200, Vladimir Oltean wrote:
> > On Tue, Feb 28, 2023 at 12:26:19AM +0200, Andy Shevchenko wrote:
> > > I believe that there are few reasons for that:
> > > 1) (besides that what Heikki mentioned);
> > > 2) the software nodes only for quirks, seems you are trying to implement
> > > something that should have to be implemented as proper DT / ACPI device node.
> > > 
> > > Can you elaborate why do you need that (as you see no other board file requires
> > > this)?
> > 
> > Trying to keep the answer short while still answering the question.
> 
> Thank you, this is helpful to understand what you want.
> 
> Random idea #N+1 based on what you told is: how about DT / ACPI overlays?
> Random idea #N+2 is: have you considered FPGA approach?
> 
> So, as far as I got it right the device _can_ be considered as hotpluggable
> blackbox with a lot of hardware onboard. This is very much reminds me FPGA
> sitting behind PCIe hotplug capable interface.
> 
> What do we have now there? Can we spread the same approach for your case?
> 
> Because to me board files here looks like a hack.
> 
> P.S.
> Yeah, I know that SPI is not hotpluggable bus per se. It may be that
> we actually need to reboot machine after plugging in/out the device.

Can you please give me some clearer references for #N+1 and #N+2?
I haven't considered either of those options and I'm not sure what that
would entail.
