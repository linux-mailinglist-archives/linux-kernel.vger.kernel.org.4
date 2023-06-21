Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83137385B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjFUNvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjFUNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:50:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2132.outbound.protection.outlook.com [40.107.220.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D951719B;
        Wed, 21 Jun 2023 06:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSKm34Uet1DMqhR+FrdI1Myv7zk8mDHw9tO+We/76kOzc6B3l4JuJ09eI+m7wpPlmp2qgISqHMHYKR7N1Ic9qdEaGPKU8P4PAa7qNgR645vnNAavx6hX+lx3hG2qiRVIvjNtoeDr+/Poub83EIrU2k9VCSBdRp/ZDFhC8VlCZqwulT/6M+pFft/kTxET5VRrORRvWSITBbICAJw0pNNcGR9989mPucs2laX9aby+NFfhj87tzVNEu8otzNtOb1XLGMYF5/bCSvNNQmiKaxZw0PSoEzN0VclTp2s+EWHAtQMfBP9ImvmFQH2qbHeatl4pBvt9uZnHxJpVHsABDu5cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39D6h9Zt5zt8SlABZClFtsBArtpX3/Y/iw3Th0aPvY4=;
 b=jhcQJroEXY3SPYm5LYoAQlW8Aj4lJpzVFVxPRVf3YJfLc+QYOH7JC8I6FHZ0O6W+0hI9AFmjvlR456B+ckbMMd2m0WXdh0pE/1MjrECbsfVRf+4zEPFhdj8CiFP5aDfai1IJbPFXJCKmqb1K67qkqKu0gQBeuEOkGsMzjdpwrd4TJJMeKqzq1q0ldQyDwDCQdIfC75kt1jX62wmGZb47C/6PGQg936Xf//WPJKi0NrcuRLOAWTlbjAyE4wJpKbKsmgO1E6I2dl0XRxMSnxITcCsA4c3Srhh67o4HSha8/p5H+r3ZIPtOw6nL0ivM8JgVn/R8XmS+00DdoH18unIlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39D6h9Zt5zt8SlABZClFtsBArtpX3/Y/iw3Th0aPvY4=;
 b=QxGGVOBp6NgGrIOyysmC4o7xzT3kxjptpSXIbLWb9+pTXByYsc/TPIPDGsZCkvyqjXi4n2+j6TVR7TRexdyZKW1eT1ALyUqllJJfxDxp7Nawun2LV3gusPYl6fPxYRReDEh1t9o8RWi2/8/2OmzaKP+8e1kXMs4QYbWF2TVfG8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB4902.namprd13.prod.outlook.com (2603:10b6:303:f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:50:54 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 13:50:54 +0000
Date:   Wed, 21 Jun 2023 15:50:42 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/16] can: m_can: Introduce a tx_fifo_in_flight
 counter
Message-ID: <ZJMAMouJBKBzMxN+@corigine.com>
References: <20230315110546.2518305-1-msp@baylibre.com>
 <20230315110546.2518305-14-msp@baylibre.com>
 <ZBSPJHkcLG7gkZ7I@corigine.com>
 <20230620125354.ipok6i43lvow66t4@blmsp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620125354.ipok6i43lvow66t4@blmsp>
X-ClientProxiedBy: AM0PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::27) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb769e7-1672-4855-ce06-08db725e8834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9Ru0ue5euwNCfB5Ny/TtOMYwwLy+1BcOBDUV7CWiZcwtbs1/yzrasOhxLNZJKyzTroxisKUvwq4GFLdWp7QP/QYf9JOnPpc2A8WjPV93km5DpPu0l8y5K8aif4xq3y+uj9vKJz419JW2lEdL+/FApkPJJVSFYzDvJR9r7ReQZVteGacpGt3fzlvKz5a1F9WQ/OccBybg+3T4OagaoEEkZO5UEVTqxJtlU4+3PhX9ZKGDUX3/urHv3E/GGOhJNXQ9g+4o5VI+RnyCKdRIZSNOiqo4JgvTnA7ht/Dt/2bgfm1lPljQ0HW4vLoRmOowiu8hEksIU3D7bF9R5GBrFf3TWtJ2HgjypR5eVnQjYBmxCtGd4dk22pVdqacmV7xwk1P8thUjtAMZGUgcikYnCRRSMP5fBbwYxvH0PagnYvb1NSDOmOaIGRzu88Cw0KgZoBQl+cC5vHd/8j1a8bQaLVMI3bd1S+W3iMYDWSVPedy1mivHiUcxWET9gyxjEPkg7xYbOnQHQ7hr0Bnx0g7oo1ZN4vlWNRUpDQbfiwoOgBebTps/lIjBPthXjSi94JZM4GX8icxH79V9hd/usmEevJkZmOaiyjbVfliIJWLK3ZwJ8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39840400004)(376002)(451199021)(36756003)(38100700002)(86362001)(6666004)(6486002)(41300700001)(8676002)(478600001)(5660300002)(8936002)(6506007)(44832011)(2616005)(186003)(83380400001)(2906002)(66946007)(316002)(54906003)(4326008)(6916009)(6512007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4qATgXoKaFn8+jSaM+A16y8vVzyGATLm2A1w4iIJ78pzP64uA4gTDC1pwmS9?=
 =?us-ascii?Q?MVL8yvflJbRsKX2XsEMP+nI0W8DlTwZULaYiyV0bmsixC7YovCQdG8VHZs72?=
 =?us-ascii?Q?44Tv/k3kCeK83KeU5foVkuQcKLtCoJB1y5JXvveydFcfHlX2JGSzeiO+tqOb?=
 =?us-ascii?Q?aayEm0iPcvpVDVoGQ8sJQ86QWQadEeKBHK+GmcfkbkSyTOSdjRmVCs4ktL+h?=
 =?us-ascii?Q?aTHCJEN6sqcfyN2tAmqQ3mCt5wAqC7pY9jJbZb0DGxJeFBw3QJVhWZc+oBxT?=
 =?us-ascii?Q?LhswrD3gtUmowEcUA6TifenMM76bGF6ObnY0wWoRU/+ziM/ETCSQL143Am/j?=
 =?us-ascii?Q?yMRO2YLtrA6mfLbDd/lHdxZINrGoNIotBKnhUC9SrL0jypFsKWtQ4zHN/Gmw?=
 =?us-ascii?Q?oX75YpwwBdEuvbPWLdpiLiGT7kUxSTpHsjLnEqP7lKpoSyITqjmwtTZ4Swge?=
 =?us-ascii?Q?xp9j9Qvu4ZcjKi6jBDd3ZpJ5ZXgx1TPkDQI04H2r5IPqzEEbrGvREbJV61jr?=
 =?us-ascii?Q?YISSXe5yWn1IpZyCbzqe19Y5skBmN9V3B55+NRo7QFDe2bmawRIGucIEqz53?=
 =?us-ascii?Q?9sQmlHomVEq664jOnHJAxxJnJvVEEq9Ej3zM47P9Z0LQoX6CJuZzAw/bqxSX?=
 =?us-ascii?Q?BnrxZD+YvzcJQ5vpPL81lInViI9SngMqqyUJXpasOJiTMko3PhTUVBoe8Nu+?=
 =?us-ascii?Q?npBvDZA8mBye53S+131hPedeKD2snfagRY4tOxsnDzo/5RBhmhT78aLSRRKF?=
 =?us-ascii?Q?boR9qgCzSp2dJzQLXEOyX5otUUmf+Gv7x/9nX4TYZWUwle+4sZydLwK1wOMR?=
 =?us-ascii?Q?V5xdSdw8e9MBkxI7fk0Arfs4FkM/EM3irjfA5esU+vstjMQMxEF8Mv3GZDWQ?=
 =?us-ascii?Q?Td7oYt3nfgwTNxEdaIo/ms1qNO7QSoNBw5c100A+gO8L8+lupQQ8xJRoMEac?=
 =?us-ascii?Q?gvJsBSTq19mO8f22l21wNfXAhGIkPsIJgaRRGPTWzfa/R3uA7pv+cDuy5UA7?=
 =?us-ascii?Q?iQZs/lMmkeYKWth93lS6me9CpXikJ9dCUNxYz6fZhSrso7CA707DA5DUFyc3?=
 =?us-ascii?Q?TWLO8jeqsGJ/FTyst1wVwFIsoROqDFgMrSm/MA5FlwSVeEQQDlickHzxYbPE?=
 =?us-ascii?Q?kAiKFLePpFQ8GlOeqKzMKKI2PFzYSUfmUaGDlNGpDvmqd0Z+Ad/REECyCIKF?=
 =?us-ascii?Q?GCR622jDXo3plkXsCzlr9buPo/UXNvhFmih9gNeaE4hfX//X4edrOZZCrrLC?=
 =?us-ascii?Q?/9xi/Fi58DPdWBsjJPdQGxu37a9SRgAKflCZx9yqNHgbkKjsTX4gPLSPKuJN?=
 =?us-ascii?Q?ssi/xrn2Ste6/5PzJtXu3xAxb6SW0KOEPKrMZBA3k/vZeHPKW72jOfpWyfOS?=
 =?us-ascii?Q?hIupEUSZvi3+WZkFQ47gpB6hr6q7q4SnlH1ImO4TmJTs8Z3QzaW6QJkF8V0c?=
 =?us-ascii?Q?4jzfvaytfT9V9UbZt8oxBAwVGfWrL/BVh2QA8OMldZkZfTYiOrs7LwLYCXGd?=
 =?us-ascii?Q?k/bNImXXIKEhUARUXrTR3lqSaZXteGAzfU/qZB/829npTuHedtz+cge5YQhe?=
 =?us-ascii?Q?jo8xm5K9UD7j13N/MgaDsNnk6Tk7BKVtVr+ihpU9XJ3mN3BhUrokZjA0ItId?=
 =?us-ascii?Q?eppWyYe1upgF23sdxDy51145eiAmwe8GMlBbLJXekd28ezGzJcpz20AQ7Dch?=
 =?us-ascii?Q?2rzFlQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb769e7-1672-4855-ce06-08db725e8834
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:50:54.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isXxfCBF8sOs+ND9pUoWa6tcWgPmVgsQH3hW2s0tcqGY56fgTQ6qmFozqBpBR4l7pHSk1k7lKIvUGSMMKfRR75A9KHypWwmBtwT4KSTAC1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB4902
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 02:53:54PM +0200, Markus Schneider-Pargmann wrote:
> Hi Simon,
> 
> On Fri, Mar 17, 2023 at 05:02:44PM +0100, Simon Horman wrote:
> > On Wed, Mar 15, 2023 at 12:05:43PM +0100, Markus Schneider-Pargmann wrote:
> > > Keep track of the number of transmits in flight.
> > > 
> > > This patch prepares the driver to control the network interface queue
> > > based on this counter. By itself this counter be
> > > implemented with an atomic, but as we need to do other things in the
> > > critical sections later I am using a spinlock instead.
> > > 
> > > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Thank you for all your reviews, very helpful.
> 
> > 
> > Nit, assuming the values are always positive, I think
> > that unsigned might be a more appropriate type than int
> > for the tx_fifo_in_flight field, and associated function
> > parameters and local variables.
> 
> I agree that tx_fifo_in_flight is and should always be a positive value.
> However as the code is operating with ++ and -- exclusively I would
> personally prefer int here as that shows off-by-one errors much easier
> in case there are any at some point.
> 
> Is that fine for you?

Yes, I think so.
