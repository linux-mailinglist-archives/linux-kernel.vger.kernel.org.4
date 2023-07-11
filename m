Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5848574F6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjGKRR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjGKRRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:17:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2123.outbound.protection.outlook.com [40.107.100.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27F910EF;
        Tue, 11 Jul 2023 10:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjN1bUpy4yUjHspqLH8F0fDXWOqHuMAZUpOHvybg+XMYLMUjEXeHgEih1odP6q0Ks6pdBMcKT9GbSKuCSJV8KCL16r5kRNVo89R0iLxIx8xcOv3UV5twf4pjY71+D2H2WuXVbNHP8vSdHZn6BiAz1h0oWdnripSWEVydaaPOh+FVN2fYJyeAcVDxUtVHN0YtxwXvxcXl1QHo8iNbVAJivrjQzONf3hZpZs2hOfr6vHlhDi/kEYS3LPtqqEgYRRUFV6OFef5qEY4+OJu2rLsM2uGA5JxMQszTMWjizZGNh4GEBAVJPn85Bzj5iItxXCjyoFpgoPBlFMqb6d/2wYO8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+70ZNlJW1FV/L5yTPGtSSLvKyeUIFfwwdNNEar8X30=;
 b=gcFCJo8kTNGKUQakplqWGEzxYG08eMWt1F2iKik410m+qsQTKeODnLPD6YJMllWTpq0AOy2GVqrC5lDPKATXGWQ11pDNXU8P7ae9hX/oAkdAICN9V2vMLUqpjFTU9B5uZ+6Vgptc5sPPU7CY3qq/5e6hXHfBdrjI07aW4aVq00sRaZPRCS4cRfK6EYhFsm1stRVqbj9LuT9D+/ulPAGnk5ptRvHdnUAhioHPrsJJQScSstftPzY/GsaIRdTt2PTGeaOHz4bZj/5s8uB1o8RHmPBCwifIcBMd4hrtlNBMmIoFs22GKC4xcsyaFvAWXlg5pzjheuIXYQnYSXXaTFT1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+70ZNlJW1FV/L5yTPGtSSLvKyeUIFfwwdNNEar8X30=;
 b=KraXtJRiJE2ZLBirbLHg6tXAqYz7OcDgF/1xHPT1uXeFVYl1xqa8/9jQD8kQOV8ASSICK7Bjnae+7DdRpU23g8AsiotN6Kvat/A9PbB0uIXBgX7U3RtsRnj7lHxoax+WD6cYE9W5r1z1FcvMl3Kk79609EMPvTeLcD5maZMFQqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5594.namprd13.prod.outlook.com (2603:10b6:510:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 17:17:17 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 17:17:17 +0000
Date:   Tue, 11 Jul 2023 18:17:07 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, schnelle@linux.ibm.com, vkoul@kernel.org,
        eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@amd.com, dragan.cvetic@amd.com,
        linux@dominikbrodowski.net, Jonathan.Cameron@huawei.com,
        linus.walleij@linaro.org, tsbogend@alpha.franken.de,
        joyce.ooi@intel.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, tglx@linutronix.de,
        maz@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        kernel test robot <lkp@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 5/8] net: altera-tse: make ALTERA_TSE depend on HAS_IOMEM
Message-ID: <ZK2Ok5i2m7zS6Uq0@corigine.com>
References: <20230707135852.24292-1-bhe@redhat.com>
 <20230707135852.24292-6-bhe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707135852.24292-6-bhe@redhat.com>
X-ClientProxiedBy: LO6P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 66873dbd-2086-4a91-cae6-08db8232ad7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HvtGbTTyeBHvZjH1P+rb18xwVsa2L+0BLmd1dAAoij8VEc5QOU6/3kSwjlmMeOTt8AzqLjsjaXsOAD5n3BSWukevo/VwIRowbFNVjL3y9d/BLSrC+QEN0e51SGRqH9s75gkgQ3jEgPNDnNe35Qs3TwH7/2ZREg1X0hNB7ekQio/yOCXrZJLELAE51dYEGWiwgfxZLklDKtz6Z0AgM/ugheVcLZRit6KDIDeDfpjp+7gtP6eoaxUxaotOKiVZmsT7Rl3ZqyRZvwY1ajlIMcvDi0B4pjT1g04GExaPC2On80iBNG30qbUjAb/hpHQo3nh8W/6gpTHvtLxaYieeBj7TxTEp8vk/XB1CERZor7Cvv8JlmrqTqabojOr4lWOjUs1R963kNVgTU4ckRSidh02NvWA55S/14DLn4pKKFmK+wNS4V0r67JemepyTjuM4Tu4R60Hq80azoO8qfD9ABbpjV4uCHLdleuqA75QfZWrvv/+R93VK4KmF7daSBYIT1XOvykQ/lFUOMYRWVLqm4W526ofdz9Mvp25JNaUwn46l53zkSL5oCMET/9R907OyjSqI0S/g2BVTtMcLe48bYqz0gMWFRnziszvsyl7HyRwJ0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39840400004)(346002)(451199021)(66946007)(66556008)(44832011)(86362001)(7416002)(4326008)(316002)(2906002)(6916009)(41300700001)(66476007)(478600001)(5660300002)(8676002)(8936002)(38100700002)(2616005)(6666004)(6486002)(6512007)(83380400001)(26005)(6506007)(36756003)(186003)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FyMOOjTMyF56Pc4KZ/E/2IYwWosT50YsCN/SO73ls4XWDVv6wCKk4yjR+1I4?=
 =?us-ascii?Q?4e9tm5IQj23Csn8NpDyJ63ie1zJBbK7Lwf3rwKUkg7KRRhRDcZO3hgXxAHPl?=
 =?us-ascii?Q?yiVva8Bk2G+cmbRi58/TvhH63yWC2v5E4Ey58Vr24umpNOmF6pIyiwII2VLs?=
 =?us-ascii?Q?CGy0IdqDhyDCGnIuYmSTplAxjuuZJsbknwzJUEVgIJIt+LMQljl4oWzoY+6I?=
 =?us-ascii?Q?FiE81qim8O+M/qKMA8bS4vvEZ9P6E9qPUpvSCA1zYLNNxWe3DyCNYSxvO9Q4?=
 =?us-ascii?Q?YumngkkhZiOJMUVDinF4PHRPP/rryF+Mjf5woammUPbS1TsiiiC5FxO9HKvk?=
 =?us-ascii?Q?XYWw1jqMFnYl+MgnP0bs4ilYz7HXNE4Si/CKEt+ybn+PIYBe7hBeKeGEA0rt?=
 =?us-ascii?Q?iU0Ar3pQxJA2/2uYKh4TiriyvLNEJGzBKxCV+NXy1xp51vvaFCtFBAYrdqsN?=
 =?us-ascii?Q?SD9rv+GpT/2TXLeNc0aUsHHQlLKdJaZ4bKIceRphLbf3hEUJ4o3hdtKFLX4N?=
 =?us-ascii?Q?IeC0ByKzOYSg+m2uGQ5aTtaz3x2uIETkdpJS7BPGABkIRlTXv4owtnxAWA1C?=
 =?us-ascii?Q?LpAnyuf5j8UMgLNsS1KTs2iVHrEWrI3j6Tqw3cFdq1hZ6KMzwh+91G7P824+?=
 =?us-ascii?Q?K/+tKbnAqy87ph7dPzX8lUqBPnh9aiPGjVfvjwHjpDj791OXmX0NuPZ1NBfm?=
 =?us-ascii?Q?7SmiE30p6tPuz4aTFz2+HztH2uhdV4S2RImIv5o7Mlcdf1SzzfF06pZxdA5z?=
 =?us-ascii?Q?2q2niQtLFpo3S8pHdp73M5PbI+Navj/0qfy7QBibczCagFGItGN0fD0aOJqb?=
 =?us-ascii?Q?4uWmFvNif4JGvYMsp0LUvivAgxoTSqVJeZm9aoZn6nKlGFaOFQtohHm1t/3O?=
 =?us-ascii?Q?CZWPFU/wCrsmAYj7Nw0YlrcXCcBqCVEMP8xK/QnzZOdg4R7XQSqEEkxpKMYa?=
 =?us-ascii?Q?M8N1/KqeAxLgomrxmyWADEbJxpygfe0tyl6hwxFHTkXtudGvBjoGZ6FxnUvU?=
 =?us-ascii?Q?/gY4FbHlaiMVxfMVCGZC3WPYUXb7IE4fXqeFKoDS/0uNeP1tGvNrifKUyrZr?=
 =?us-ascii?Q?J/cGvs/jNn2Pb3LhAh4WzMIobHw6kY7dBmsSUK0DL8fhZw8eLo7e2oiAnD5R?=
 =?us-ascii?Q?lu7o79tav5WT7W9/T42e99cK40C31E7CsoOIzeNmTgL4hac1NX49eujQ8SEr?=
 =?us-ascii?Q?FQco71tSeJWR4gmMBJxVE8ppz3a/kgToXWRLj+wqFyaAKUstj2TXJ0jVTPNl?=
 =?us-ascii?Q?ruIcjVw1HX3hPF5zA3J4a3j8x8UWXMu98jW36mSkKUJ1y4V7ggMMCytifmG4?=
 =?us-ascii?Q?+Fk/tQqhdeAf4hkj9G/aKeBQZx9y2hgUILDKB7wZjYsBoaV/dLf8LYdu3yWS?=
 =?us-ascii?Q?djjChoaxO326Udc79O0VEENbu8hJ1oh2XW4vTVyid4kE54RvNMYzQAgGmXAM?=
 =?us-ascii?Q?NMSOtiNbM/2+eHbAgNPM4WaZejS8Z7SLLf8qLy3g/WTJytNLhhEkv8KH4FGo?=
 =?us-ascii?Q?Y1W5XK9REa6FMy1XsyjLgtWyCiGZ27B0jRm5Ry6u/9N5GP8TS4jqwb4yaTy0?=
 =?us-ascii?Q?a0TCrPGSm+ymwMBTOrBTFlu/qb5qsjh+PbaZm56yNku4xEFEEM0wfendcKES?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66873dbd-2086-4a91-cae6-08db8232ad7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:17:17.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvOI87SIPaSqhfle6VJqV1sty6nDP4dI2qc+BaMZ7FyPfozjs/FMaNsB6nXu18psGQgXzrOhYGDXJh9adipvjLfUOkVGienUcH2u5YXOX3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5594
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 09:58:49PM +0800, Baoquan He wrote:
> On s390 systems (aka mainframes), it has classic channel devices for
> networking and permanent storage that are currently even more common
> than PCI devices. Hence it could have a fully functional s390 kernel
> with CONFIG_PCI=n, then the relevant iomem mapping functions
> [including ioremap(), devm_ioremap(), etc.] are not available.
> 
> Here let ALTERA_TSE depend on HAS_IOMEM so that it won't be built
> to cause below compiling error if PCI is unset:
> 
> ------
> ERROR: modpost: "devm_ioremap" [drivers/net/ethernet/altera/altera_tse.ko] undefined!
> ------
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
> Signed-off-by: Baoquan He <bhe@redhat.com>


Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Simon Horman <simon.horman@corigine.com> # build-tested

I wonder if this should also have:

  Fixes: ed33ef648964 ("Altera TSE: Add Altera Ethernet Driver Makefile and Kconfig")
