Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10C1743C92
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjF3NVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjF3NVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:21:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2102.outbound.protection.outlook.com [40.107.237.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBE13ABC;
        Fri, 30 Jun 2023 06:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZufISHVXPBYTI653riWcyxwB60hf8xcMu5uV3z7PUTs3wWpeCth3HN6Fn5fFrwdVF3LTe0X3VGwSe+kcvEHFF5duZQTBteNS4eeXJ2U9ZLN9lRnCJEZyBAM4KSrcJHjYSAdC72HzY3g+d86FwwPcpt0qx64zsJqbTHUkrnXR3cHy105JqO/ATlzuwxKHTM4VzgnhBuKmL+8MLFnKFo9Fhzr3HJwnB/oU4TQ2Udb0Vr7zdgrVVgkIzjWB4xu1QSwlK6+QpvLKJ36n/AT05ACGItaFpd22f0AhB2uDs+bPoly4wUmnkxStYf1IA+ol9ooUklGBKMNzQcZGjbZ6lRMuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbgusxccTyBH6AakW+gm7We4uuasvfscbFQkIgr8EUY=;
 b=LG+/jhznZOLHsRLm2FfilpK7eFFPpCM7gzLNEigpI7Usf296caarmVxYn0d7z5tPPvIBIhjUZGmSZI03t1wOetLbc5aYMeaxMCDRoaAw5Q1uCVeUncavf5fS1BN4sh1CPohg0dtX6rBNKeS3RGaQQHR/fXQaR5QPbnJx0EeWoidt6yEds/xZtKNeVGus9hFcAAzixTuwZ0e3dYeZSpjwIHtPcGrzQThl+uvXp4qheTNF8uMO0ECWlA/5o5hcbIzNfYbo3VN/OHhqiBgIEt5HmcSuv7Ih/ajLiz/7QetcMFXhnhj0KQ/fuSq9NrTaHtUJ8i7HT5VttdAv1WejIpEh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbgusxccTyBH6AakW+gm7We4uuasvfscbFQkIgr8EUY=;
 b=W1dzk/CSYivpBIwHSwCAVTUWcg+kbDiAiAWspBZgcMpKLEC7juuZCJ4e2NOn5ArTqCZyR8pXzZ9GafCf41VuVsHOCDBh49IL+Yrqp63ng6erWWe8TEA8nUmf6XMiXwekTEWJklfiGw8F1IE+q3pAznCwbpa1w2ldUqmo9m3OH98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW3PR13MB3995.namprd13.prod.outlook.com (2603:10b6:303:52::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 13:21:01 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:21:01 +0000
Date:   Fri, 30 Jun 2023 15:20:54 +0200
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
        linux-kernel@vger.kernel.org, kurt@linutronix.de,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net v3] igc: Prevent garbled TX queue with XDP ZEROCOPY
Message-ID: <ZJ7WtoU/doUGD7dW@corigine.com>
References: <20230630120306.8534-1-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630120306.8534-1-florian.kauer@linutronix.de>
X-ClientProxiedBy: AM0PR01CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::49) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW3PR13MB3995:EE_
X-MS-Office365-Filtering-Correlation-Id: 000c107b-4e3f-4b6d-7cba-08db796cd984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtM7IX2rLjqjnwvP6uGzXvXnrZV4VZ7/BI7sDT7ZfFe0m5KC4Pv6ePjitQjZSbLnL1+Ira/lpddP0JfD6hWNJ6zlcquQn5VvJJulEtoMR0zUlJakgk6v3oFDqGdKWMVhDFAY/NI8Oh485hZL+2U86s8JO4IGmhWRPHED0qBN5GbctzAjw3aZ1y/Ohs96TUjO9eLgqb2mB3nB/FqfVxEXohR/xR/j2dW+jjpnGgU13g1JuidWirbNsTftVwgEJGpHvHh/DBNyUsGexTHi81g9hkapdtj4ASB247xB+y1ibU9qoGYvfCMVsvxY9eg39/HFnK7OiJoEK3JDmC35qxy7HnCx628JHixmZPAmbcy3PtRu2YFc+BgRxu88vB9Jktm2wXEI/4h7I+I9/iGih+KHBJvoHbg5DS/hKFOoa3Fp3njMuOQ0CifTrjdZliT7G7K503GWHO2UF0UgXhKxyfG9TerkBeVOvh+nwKvF0x4aHsj8AXIJXYr4nB03HYOnNUcR7+ZugvZQ4/9tQ8DgOqhDG567zoDG9HSA0DUyJfZCnnSdDaTlXhlaDay3l6WRrbG96ZSBcfNebCit1idQJPksM2pUbxXcqGq41t5xRB86TCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(346002)(366004)(136003)(396003)(451199021)(8936002)(8676002)(7416002)(5660300002)(44832011)(66946007)(66556008)(66476007)(6916009)(4326008)(2906002)(316002)(41300700001)(54906003)(478600001)(6666004)(6486002)(6506007)(83380400001)(36756003)(2616005)(6512007)(186003)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FqYWJkjwQyT+cgy061gQ4nM89lgTDL/j7JuUjT6hhiVTbLzpwMREQzrFyuf4?=
 =?us-ascii?Q?vI+g2wfAFEe5e5VmZ8j2M2aXKRxTesbneVxDsE12cw87o27Lw3Zg/1qBbAbe?=
 =?us-ascii?Q?mo86hAMds8Ep+esemE3qcSZHSRXFWtWGbPsqKkMIxQ+3xxezBIBIKM4fsaB5?=
 =?us-ascii?Q?+Ul0CvGtFlIMAJsw0zi9RAoqKKt1ZOP5TMCvf2DmjErqaNIKzY6U28BwQvmv?=
 =?us-ascii?Q?SKLpsZRA8u9Ce+KkapWRrU1+LBcXcW6A4kVCiVrCyvQZG2yumhimQpoiD0Fc?=
 =?us-ascii?Q?OkHnC2AIRUNQLxwmRvvGheF4cKhjz3EzZMVzpTB/6DotOEsbgXEk/q48PQzv?=
 =?us-ascii?Q?TulpOTqW7a7ze7yhfmQRxskx7uM3r8VIXMPc7BWccYRDus95dl8Nh6eYXGg1?=
 =?us-ascii?Q?siHt6TImedXkzgkSXFF5z5YSMq81lmDIxleGgwoJYMErCXxXEsBL2CXDtXRA?=
 =?us-ascii?Q?RKE1u4uJIvcwW91KdrEffqGV17j6ACjY/TVhyY0MLhgymUlHeqkdMN1A/MWM?=
 =?us-ascii?Q?A+gG/LS46yRaAmud09q9Qm4B9tNUMzmhKbyOXaF1di+UDMsHxPHT5fLfG+De?=
 =?us-ascii?Q?XyPZbpd2UW2LeaVgzeHL5AFHICPs3f2mv4q9xMM3nabggz3uGKWnqrfPI8B+?=
 =?us-ascii?Q?k6pyi2OBYMw2JCDHJmvkY2YPhY1th46IUsZ4k3lNJJhpi9xgmw2lRVkEiBJB?=
 =?us-ascii?Q?sxY3gLBoUy1ETBpWGtApqRq6MYWwdc1Wfcoes1/tAypSqiTk69c8U+QK+dTd?=
 =?us-ascii?Q?KwqO4d3Er0VYZ3AWB2Oxr+IEJxM9BLxztbpw21YBpvL+NFvHrgCSI75LELSF?=
 =?us-ascii?Q?Vx7ye4ka7SrppCxHW+sWXhO2B7eQnF8nwsYm1JxFW6AF2QM3N7g9qFW8/+LZ?=
 =?us-ascii?Q?3weLsrchY5VvwvJHQHhi1guq6k6fuB8qqnMCdX8TOPlv0f5FTdv6iS9+ZFBu?=
 =?us-ascii?Q?JfytMCTBzlC81E1u5T5ZRAZkCzz4UNB/EbMQBaf25A2E3l1wzMoYhi10prNF?=
 =?us-ascii?Q?Anlzut6nwFNIEVNQlBnH1EbqpRUshHag0raBgXI49wCiLvZtBrzxN7PR3j+g?=
 =?us-ascii?Q?JXOBYu8nF6ISXeqf+kGAM4krbZyfq0oyMr4TKG4OQaTUF/+tFOjGf9G0FyqW?=
 =?us-ascii?Q?VoSp538JJRT+IGX/n6Fodhqa6ySZusYdg82frubwbrfbvyxgoPhP+EBUxRrF?=
 =?us-ascii?Q?Tws0xGTYgJ0Kof170fAMIlEwVoxlwC/VKvi7Tgp1bSKH+Kvd3d09FRBIkGvZ?=
 =?us-ascii?Q?ITi1iPWLwMuBck4zDqPrc7iyGxPSnDg4E5zvHkKpdwPbE0+0o0JWsRhXXQAB?=
 =?us-ascii?Q?1YOZPeV7YuMdIFv3pB6NWKhV92OggyCGLetfMYsq39hcSMRroIvUqm51vspV?=
 =?us-ascii?Q?/TW/Y13ppadkhkeIyzi/LRmGHc8LP3peSf3kEdLINWizDd7zhvpzXNA4r5sH?=
 =?us-ascii?Q?xkoQ4ez81AIU/tjsegXxY7xgdW/Qm9cpDVzXJeW7gL8G1fsoYHcHjC5Gcyy6?=
 =?us-ascii?Q?6SAFRbrFHXUbgaksTyIn8Hp9nT18H7BQYogotOgH5oyEnsyf8isieJ83m4/U?=
 =?us-ascii?Q?gd9Y4fn0Zab3JezpX+QAWeX3NuYfuHEPDk2pZkTjKxAK2lyAL+TMD6XMQHxc?=
 =?us-ascii?Q?X1tpy6RQSSPne1TQjn7OlZoEY8eeznIUrxWMMuFdZmxVLZrXBe7fNP+69pGH?=
 =?us-ascii?Q?AElWxg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000c107b-4e3f-4b6d-7cba-08db796cd984
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:21:01.6760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt6RFtUNodjn36en8xnfNAz8NzmlicESJ5C+eKlbWB2ZMHZeJ0ee0HhqdoY16khz6ClB+vUPeDdcbetkxsWE+4yJyelXd3tpOS8MWgAXBD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR13MB3995
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 02:03:06PM +0200, Florian Kauer wrote:
> In normal operation, each populated queue item has
> next_to_watch pointing to the last TX desc of the packet,
> while each cleaned item has it set to 0. In particular,
> next_to_use that points to the next (necessarily clean)
> item to use has next_to_watch set to 0.
> 
> When the TX queue is used both by an application using
> AF_XDP with ZEROCOPY as well as a second non-XDP application
> generating high traffic, the queue pointers can get in
> an invalid state where next_to_use points to an item
> where next_to_watch is NOT set to 0.
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
> before acquiring the lock, and writing it back
> (potentially unmodified) later. If it got modified
> before locking, the outdated next_to_use is written
> pointing to an item that was already used elsewhere
> (and thus next_to_watch got written).
> 
> Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
