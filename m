Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3292474F637
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGKQ44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGKQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:56:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2101.outbound.protection.outlook.com [40.107.94.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BE010C0;
        Tue, 11 Jul 2023 09:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU4RIsZv7VIUYbpH+V9iy1sSZ9nxvQrxg3a4wuihh480iMfd/VrnE7gdfrrvxrjon+sR7l0TzkV3A562/cM46CYed7gtgPDJCEuM6jgUbQgh6VWApauA2Yw1lAwy1GF7DJvXaYiJpS4t9EvhXnunKmF1J7/k9c7A1jzcB0zH7zJAKXZ3IOBHrxPv1R+f5J7hs9Rtxf4S+2UZqgK4HdjC++pGiNBpfF5t5gY6URwqx5qSIOhtTsIoXxl6QRordO4uMmw8M2fUMJRRfOXp/TWGcHW3SUv83yQGw5uFvCyudoUYeRObGUCgKvlYQJt1QZ1hk/TXomx+2lZ8U2WXhzvqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R8sfYCi7huBlqXfJBAcQeV9EgoY5tiUNSDj324RfHs=;
 b=OwLArhj6EL1CvSWrzRGodN2nhJZzaB73nBNL/8K8mOsl2B4v1NhFDcjC0cGkN9LMUB8eDjn7XZonQmpPwE3UGpMBhThER3vkzoaYC9xRoZBwYSXZkgBhDV/doIo6nTgUhZZZ3h/VjeYlhwZVUOoqXt6OcHQAg334HTMJMbIDRPly2WmG8RxUvduCzqsseJq6QrgUEO/U9xnH+kfqTlBXK3EGW6z7/+1WSiadQKXQ1WRxCsuvG2Bc8T8xiZLjN0aJ4zl6ORIz8EJrYE+UIY7VsLQrxdE0u4mHXcj8H+sbd1yns8v9P2fciJCKGNgGsQE2dl3NkUeaqvpRMteZC7xAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R8sfYCi7huBlqXfJBAcQeV9EgoY5tiUNSDj324RfHs=;
 b=Tljq6hS89Pt/Ijw3lkU2VlKtj6qvtrfTMXq3CowV0osYHrfmmwEpURONNUP7lkw+qk3rTy5iZe5/WwqC8/H4m/VnsAmuZoCYyOuAvia4RGU9NXLQAUbEsCEcQYoHh1zWNP+T7vIhtNUs38FKcoQZCe4nHgTxyMdsjmknfk0GSlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB4961.namprd13.prod.outlook.com (2603:10b6:a03:36d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 16:56:45 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 16:56:45 +0000
Date:   Tue, 11 Jul 2023 17:56:37 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: mscc: ocelot: extend
 ocelot->fwd_domain_lock to cover ocelot->tas_lock
Message-ID: <ZK2JxXusoKjkZq2m@corigine.com>
References: <20230705104422.49025-1-vladimir.oltean@nxp.com>
 <20230705104422.49025-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705104422.49025-2-vladimir.oltean@nxp.com>
X-ClientProxiedBy: LO4P123CA0132.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e82d80-bea9-495d-1342-08db822fcef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MQiqGD/Y4p+4hC9BIL3OXTCqTLe64FvlQQqAy1Z5tTeRv+Bq1ASzjHFnHVy6OYOdyAX14cMrWmlYfe5L57yi0dNudL/WLYBVz8YzP855N7nlUfZWGwqiEFOpZAc4PdwpVxARmxJZF1TVUPjQew2ejFW8G/NpurBWlQT1mpnrzTVMo/vP8FqjRFhDkK6obwT6aNCAY3ASdJmm16onwXr2ccCIKcUK9XmsfLPmwYAP2ZVCZJ2fv6/pfUK8lRHL4BarW6+cQXeFg6Q8O3hbVBQ2o7f8xT3IcG5zwZf31O+n0TV+nrbka1mSif8sK8wiUqPt72xMLor3mB03K18zrLKWO8ryyDRO8RUPD6BRX/jMFcaFLQ0iu1TJ1+yjGU/+fjB9Oct5F/cfkt73qjJ8yAdPIpNRYrVSnU+58+xYK//eQ5m0ioCsk/88UPsvL5xXjBCW/BI4Iw0S87YkRgkaurTa+4LuQqacAj73pA1R9bfxYMekJaccR//4Q02MvR1iGJs7qFMVqIzPoFtf7csLUaCpixqIHBXWphF/a710yMPHEjd2Wp/CAu8vwfhe7AhubYCTkHI+8XBjelxBZtK9IeT63PjDTQUPoWcE7vV6GlmdXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39840400004)(136003)(366004)(396003)(451199021)(38100700002)(54906003)(6486002)(86362001)(6512007)(6506007)(6666004)(36756003)(186003)(26005)(478600001)(2906002)(4744005)(41300700001)(83380400001)(316002)(8676002)(7416002)(5660300002)(8936002)(44832011)(66946007)(2616005)(66556008)(66476007)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+tdYnjCKJsnn+89p9AKWvSuuSGSEaEztYFx/OQhar7E0XVrdWvBK6s/6MUF?=
 =?us-ascii?Q?yPa7fvrfL0fgqkv9ZxChzfZf0+JI6u0BnWqI2GiDSFQPjodtQDvIFWT83FXQ?=
 =?us-ascii?Q?eTqfahoJkHJTU05imo73skecfOITwxlOXB890CU9xB12lfqpwOXwd3bRuf/1?=
 =?us-ascii?Q?WDWknMn6m9IBZQZgD5wikUfatRYWrEsMafNrMrXNA+f1ZaxMmxckSIczqoVZ?=
 =?us-ascii?Q?GaayzFf4LY7vCkEVPkLqGmOOYFuN5oGTIrui2HBgQ3+o2bP3G0ADhLe/rPis?=
 =?us-ascii?Q?k05JF9YIHl73X1rtPO1x4pNLTBrhdSbAuAjTDHYp6oBkrkXRWbMfk3U0X2Ww?=
 =?us-ascii?Q?cNOrNh2X2JCcmhAk+9aZo73NmJNonCOzss9Ij3U7urBuRyTGbEz4ZfLNm8vz?=
 =?us-ascii?Q?lHYFdGERt4cQYpe6gfiIuICTqKNe2/3N8c8zikA/QULVr/XBQbLUdAIAPdQG?=
 =?us-ascii?Q?SxnqJusxOnW2V/4g4sAF0Kut2B807pHDv1VyKaADJui6Up3sQ4fk5gtzh0C7?=
 =?us-ascii?Q?h3QrI69F1L+GSR94EulOdy7vYdE7evCbja85Eukzn7cZauYPRgFPMWPjIPtl?=
 =?us-ascii?Q?yuKEyeSim575zoOB206O+IZSnsRwBwBPVv6MSdWrg9ifJHW6z1dDTbfqbfr3?=
 =?us-ascii?Q?fncihI1fg4tmVFy12xNyXySlHruu8rd1x+wGJsC/sdvIxOly+CuBDqcKzekD?=
 =?us-ascii?Q?yzTNRoYOeneL4VuoKcnnEMuWD9/i9Y/Vj9TG/6ersqtwht/CyRrZhKvfmGzN?=
 =?us-ascii?Q?GTCMJflfWG4ZDQEcCw030+HA2uGl9Grsl8RFjk6Q1N32f61dLbl171Xd8GnO?=
 =?us-ascii?Q?qikpaJEcPpBZwgy+WQc12lOlDZQAmll3gopdbh2tv303vUKDGPEwSvIxJdF9?=
 =?us-ascii?Q?nEztiYDTWz+2SlCKELcWvw8htog9hJvEQQmuMQadsYLofnBPG5uD4D2+KfXc?=
 =?us-ascii?Q?a68uO3+sEJhVtW6xNOJbbQhsSwhaiQnorpE038hIMHkAKkog+8e3Y5oxMTMb?=
 =?us-ascii?Q?ulJ7ro2orvzgTQbXtzxRRw/eErXgsTCP5/Y0WmVhTaSIXs5wtpbo9PAQKByN?=
 =?us-ascii?Q?2YqhRrKZ1pesdj4N+z1RtNNZ/uVmD9yPo1JN/nEe4Kccn1ZvM+evcco25m6h?=
 =?us-ascii?Q?Dy0TPKQ2cgWgdL3MVBdZVvKalxD+g5NMQBmqrKaebNXS6j40k873vxbK3T1y?=
 =?us-ascii?Q?in0M2V5H1d7XrK9HaCope8TI544c8WcKL7zHrO7pwAcnyLNXzrCuGY0IHlgy?=
 =?us-ascii?Q?6YxeOd0t65i/oO8DkaRD0Pa/e8ewkCt0y5XOudYhSJSmiwQsUSWHmgftNQoj?=
 =?us-ascii?Q?SNvSLa0v/sJY69Di2oMYLc1gRRbHqH7gTFAq7ZO07cxZ+qlBQkXwj+5cRERV?=
 =?us-ascii?Q?lMVAbJUgoKGeSXOAFkAlYunJ2vsr7qhU714LEqXD+CHeWh0aQe7x36P8JZzI?=
 =?us-ascii?Q?ho8dnq8QaA6RfSJ07v9k9lHXCRcej22WvD0vlkH56slQmUfsKcwB2BI+CItE?=
 =?us-ascii?Q?d5B24VD+nFME5nnlqaVcBtsXdQhrPm+nBA/CjGKk/16Rkcez/tR0MsyVaLdo?=
 =?us-ascii?Q?pu5mJLe/SBssFzOTj45NurNCpCFsZD+hznsXe/L2By/QGEmaF+HHPaMEYVYy?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e82d80-bea9-495d-1342-08db822fcef2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:56:45.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsQadsNk74+b8v9uRXhie7IFNNCdsTqfQY5xDeJ+o0dLXHtFqo8f4lBvm9TEAEfQFCgaFAWwBCqFUT8looeoryADBV9bTwVvqVnLfqGVTBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4961
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 01:44:20PM +0300, Vladimir Oltean wrote:
> In a future commit we will have to call vsc9959_tas_guard_bands_update()
> from ocelot_port_update_active_preemptible_tcs(), and that will be
> impossible due to the AB/BA locking dependencies between
> ocelot->tas_lock and ocelot->fwd_domain_lock.
> 
> Just like we did in commit 3ff468ef987e ("net: mscc: ocelot: remove
> struct ocelot_mm_state :: lock"), the only solution is to expand the
> scope of ocelot->fwd_domain_lock for it to also serialize changes made
> to the Time-Aware Shaper, because those will have to result in a
> recalculation of cut-through TCs, which is something that depends on the
> forwarding domain.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

