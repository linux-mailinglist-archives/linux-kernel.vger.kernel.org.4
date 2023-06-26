Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD973E095
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjFZNZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjFZNZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:25:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2101.outbound.protection.outlook.com [40.107.223.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B2186;
        Mon, 26 Jun 2023 06:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCIa+lkaaDzDvAHtcxl56CIUEB/LGsyuf/2eaJW9g0fXroGjg5zTQDu2oXaOYJ9JvSLE8LvzWgcliftSzLIrR1Nw/A8H+eJiGJ/at6jtMfAK3nTI5Z2iFwC1tXyTU5gH+mwEYlFrGZ74Org84RZhP9dsDSonSZeXpjsTQ1USdsRN6+1wzT51Q0MRX5k1nZntGUYK0eeD8TvKGgLMAptX4YtDHrIkUrEyUfT82xsIVqA1XyZdh0UN365+ak4TCdyuCQNZOm7br9oEG9hdG57rWKP/+BeuzfPnt8F/Pwu6DJRMBlU24lwaKBKfw1y3JG+hWBpSoppVBsyNK+lgFw2FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbvSTNwSx/Ug5qxzi3KKH+Dp3M2ahHOOx46yR9zUXMQ=;
 b=QdrSrTdMYM1z3RgNWuvgd6yXPyxbna6SQwHaoaXmIQyB4XHQgecqSCKLSIx1PIJOaOVWFQRenadJwUr1a1SpmjErH+dZ7cGOTmx4bSB1VxBIdYXa+VA1FR7vTKcmDGlrGuAEuysNh+QPd9qXqm+ywReZ2AIF6KALtLt6rOYb7a/AuZj+IzDbUp6dD34VHtGZ0lQ29FN/vVfudkHO5LU+l+MeMJue4X9qbFFnkbH3jozf8TeUT4Ma8QVd5H3pw+GC2t8T6+VI0KShXitN9yChRRDii3vvOjv5pxEIoKTB/4BaYuvQvZhIaixBt/8YCMzdLy4hOYAINzcDmep+9hti5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbvSTNwSx/Ug5qxzi3KKH+Dp3M2ahHOOx46yR9zUXMQ=;
 b=OXga/VqDRBa4dRMHy3FIB2x13YR3yHjVisxi0tIHTJQcmL7ePTIdFLxMX/LgN3WAI37SgOpERMfCricrXnst8Qxz1dCZAMnrhwiP4bSz4B0Dv1ezLWmQuX6+lYAA2OUcEczsB7GX2n6iHKnaFdRQbGc5aO9yhbn9s4c+yHyRuRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5325.namprd13.prod.outlook.com (2603:10b6:806:208::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 26 Jun
 2023 13:25:07 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 13:25:07 +0000
Date:   Mon, 26 Jun 2023 15:24:59 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Florian Kauer <florian.kauer@linutronix.de>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vedang Patel <vedang.patel@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Andre Guedes <andre.guedes@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurt@linutronix.de
Subject: Re: [PATCH net] igc: Prevent garbled TX queue with XDP ZEROCOPY
Message-ID: <ZJmRq/6ILV6yjZ6y@corigine.com>
References: <20230626113429.24519-1-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626113429.24519-1-florian.kauer@linutronix.de>
X-ClientProxiedBy: AS4P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 1171a415-a436-4e26-0fc7-08db7648c215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yu504m9oYSP6M7KTI+ewn5JvrZa1rhOIObFsKtL99tL6KaY/OGmBK8GanBRDetpD3E9eudS5JZly1sOs3tzZOdpU4mssUALV1CtGfkDx8d9MAuimsHcDeSHkGPugk1zI8NjQY/Go4XTVBBXf2yhj3i+EWtymnkynDxacNuajoke/s/Y5DfnNPDg0693vl3UCaL17Vcn76ACER5+Jet7HQ/A+c2z4g/DnRLwpVYQ1do3o3lsCZC1VQrAIjIOPk9xxOVWTz7wDiXYOkAkbtb7qq7w7eSpGaX4hlOBLWz52KrBYmpQFEqc757YlYyycQxnxOKO7aBqFAprl7VipiwJTO+bqnhQtFqa0czwZxudeNryIuHj6n0zMBAZgcwnw0rONJ7Tqr7PSU/uBEjWyxSTgLA6cmOmNZisRJit/+E16N/XAKXiPjpN5n/d5Ss9/brh4+UpAImlfPrSwcrXMtEvo0YoqFfhndPR89M09+uJg/A7tjNQv38cqkSg2jI7qpAxbiD7jmWqe2YR4YQvgwEaY/5TeMFb2mrwGk5NLgSK5JGFG//d4dwCT+fYsH4UtMNbbVs9qmSkif/Re4BWKqLmuCsy5Dj+Bx6WjVQn27yjzO8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39840400004)(451199021)(36756003)(5660300002)(44832011)(7416002)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(41300700001)(4326008)(66556008)(38100700002)(66946007)(6486002)(6512007)(6506007)(2906002)(186003)(478600001)(6666004)(2616005)(54906003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F1m4Pyb4n/aKXpBCvExm3jYzDlcDqcR9ztyt1kZHfej4EJKZ2GRzxx4Ml2u1?=
 =?us-ascii?Q?5sBgGIJ5Ovk05Uj31RQnIsULHefbhQ01hKsAM4D+PuhJWs9wZhzYLUzNhbBe?=
 =?us-ascii?Q?qlSpyUOvbqHgC+mLfPqLTM2rIphC96aVoyvE7UzkW2sGWKB5dgBwl9E8ZJjJ?=
 =?us-ascii?Q?+ZOtbpskbF44At0roYT6jtlXSUKhguuqQyMTC95ggY9dEG3mKtA/VqDRKLVF?=
 =?us-ascii?Q?8+AROIgyPMdujavvQUBXfnrjpFNO9v/hbePv/QPqvwYOVJRA2kznZ4Kmpdr0?=
 =?us-ascii?Q?7Z3ZrvbhmtyLQKyK4KkS4P+wKUN4H1p8WWFcyxe2QX2s00OJ6RQ8Udqmv163?=
 =?us-ascii?Q?CPGw01g5toAm7Q9tfvUlfwwP2qt/veYqWL7U9lCjx+a5izwwxvL4X/HdrfNm?=
 =?us-ascii?Q?NzlbrtQq1V7skrPVFSfVRre+WO1XJZ1xihtBQaRFP4GlBueSOcKudeM0TH/3?=
 =?us-ascii?Q?po3Hvx/wQuzzg7vUjeKYz7HlFvvrc5nITBOH9JHA6KIN9xC9Vk+TOrHqbY9z?=
 =?us-ascii?Q?8ZvFoyJ4wLU/OHcuJs5DCy6CgdtGGfVay8mD3iP0VZ4zud4du/frYV1QJPK1?=
 =?us-ascii?Q?C/FkGCB7kU40RtETvCZGiOFL97sSMWVk2L6H8T5kFFaL7ZIb25lmLsxBQXXl?=
 =?us-ascii?Q?YDebyl4i2L/v7BrVbMKssdDAQCJXF86tKqtj+PeOzaX2usncxM+g2+GDMmtj?=
 =?us-ascii?Q?3+ohoX+/NZVLlE3sBc/CYxCGuDHVL3D20LmnHB+ci7RKUDMhAIeBjA4Poqgr?=
 =?us-ascii?Q?tWhCemEjGIcCaJrwg7zKSlFvnFWzXhlK2dMgRitNzc5CyMJBsYfxNxyaPKYx?=
 =?us-ascii?Q?WqsDOTyMNmHQn3hWkiHrrwYMKd6Y2SCqO0ZsYludkpXY08eQTCOfwyD4dddq?=
 =?us-ascii?Q?r0j2mjrKCW4P2cWkfeq1j5MWqx5hwTeaXZp3AjXgujaIIOopyk3dc1ucqvan?=
 =?us-ascii?Q?PfcLkLw2IRcQUqRn1tU15cC9T/QaSwAnQqZ3laat1zKMrq6WDB/MaHG5jCh8?=
 =?us-ascii?Q?0o/79numehuJf+ncB2aMUaxlpsDKxS6FjZPSyCnWq0RmR9Eq3oOLokii1s0I?=
 =?us-ascii?Q?JXYCHZEdZSXw/WsmtYpeM4K/PgSlSgZplLTGKo701ZzguIlm74HrMEjkjLRU?=
 =?us-ascii?Q?weXlxygkWD92nzU8eyWcwihKNpj+Bb6eu7NCXUVsIPfvP56eD7ofcCMoGEXZ?=
 =?us-ascii?Q?7DNr37x52LHilQcpNgONIjP1b7KnYmEl6sp9BtQAtqmrthWN7dnn5V9Q/Mz6?=
 =?us-ascii?Q?lUkjMtfM0GD07JP1PMJdAK1ZHK3ViYK8vxGIHDVH/WtGo9aXrb7rkzPPq77y?=
 =?us-ascii?Q?2ju3Mf6eGyj0bFTueYg/RdLixPaebCKGjvhqVeV4PwzFd1vFsTw0wunVx5NU?=
 =?us-ascii?Q?JFA5HwIEMOOHOTJTFGaNqryHWcTa7iD4Ze1FzjZHSy2uK5wcKrJd4KX5n2DG?=
 =?us-ascii?Q?C5yzTvbVu9cbNaSkQf1koXNCoIkn0BEoYSHQLCNuEUMqBLqFoh9w1xP9Cl5y?=
 =?us-ascii?Q?/LM1u7hE28VAD5nGPfTp0wFmTWb5Mh56UEIXu9jqjxn4Ap+DVk+0yBvh+Oun?=
 =?us-ascii?Q?qh+MREqWx54GOlfQogshf19e59P6dFEnzKz6gG1IZe9UeC+9r5nWc9SaX0QV?=
 =?us-ascii?Q?2IrGbl8Z5+sekuJb3Tm66U2KXkvvMD9+qq+MpXpYpwYz0U8kCZWHmMMgQL/q?=
 =?us-ascii?Q?JVSSNw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1171a415-a436-4e26-0fc7-08db7648c215
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:25:07.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwFYzzG2USf9eljvnhaDMmMmd0ST3yokIz0KpaGRMEAT2do1MoMfq7vwEOBoiZwZfJp6bvGXTIKjCqtdd7L5Ojj2vN7+YuI2HQxx23BJ4D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5325
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:34:29PM +0200, Florian Kauer wrote:
> When the TX queue is used both by an application using
> AF_XDP with ZEROCOPY as well as a second non-XDP application
> generating high traffic, the queue pointers can get in
> an invalid state. Most importantly, it can happen that
> next_to_use points to an entry where next_to_watch != 0.
> 
> However, the implementation assumes at several places
> that this is never the case, so if it does hold,
> bad things happen. In particular, within the loop inside
> of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
> Finally, this prevents any further transmission via
> this queue and it never gets unblocked or signaled.
> Secondly, if the queue is in this garbled state,
> the inner loop of igc_clean_tx_ring() will never terminate,
> completely hogging a CPU core.
> 
> The reason is that igc_xdp_xmit_zc() reads next_to_use
> before aquiring the lock, and writing it back

Hi Florian,

a minor nit via checkpatch --codespell: aquiring -> acquiring

> (potentially unmodified) later. If it got modified
> before locking, the outdated next_to_use is written
> pointing to an entry that was already used elsewhere
> (and thus next_to_watch got written).
> 
> Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Kurt Kanzenbach <kurt@linutronix.de>

...
