Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E649270BD3E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjEVMPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjEVMPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:15:11 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2104.outbound.protection.outlook.com [40.107.101.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429731737;
        Mon, 22 May 2023 05:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edHle/clZxuZtQtMnAZvAKPnzlCP7PbwCinJzwWqjFI2Fu7LsD1dfJ/+fdJQYb9/B0kKGYra/uytJDGEQIxeTl5AmDfl097rZWt+nx+8XIAHOgKigEUD0aMvq6MDHhxmXC6m4ZL2zDf6zEomFkmKx2dZ71u5eendf6aNPKpLwPRkuElaWe0Nb0UQS9JL7CZOfG0KmmE0iJbeyQv2p5A7GbeU5MG2ud2e1d5CQ4LRL8fPA4rneRXWy01ZipEFbrHU1l8x2EIzQYrqi9iBXnn1BrW6qz+U/qcAwOb7xaW1qNg3TRp6sLtaU1zlzA15yWV5BqbJNe+OBvMWm6R3dOTHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTznEZk9OhQySyauYe0xlntrH602tjAKLNcjDczvv6I=;
 b=imp681u5xddL1MC4mH4Q3eLwQY0Us8xD27qafjCqhFboP3cAjwm4wpirdIJV4q3n+BjORK5zWifFSMrd4fYsWgULPucq/N6R1sdd8qM5Tbg512JzIUyImEK8L0124Bj42IRovLCYyPzVK6e6IJ4SWcmTMzeiHdmoy4nN5FUijOvkNgWVgyvPhBVoEFaHBsrpBLj+KsUG4GRxjNgAWw5LrGbJQBS/ryYiU57023bvukTMoMrh8X6flwTjGRXZHPtlIeywW4l5Rk9NCjx+1uKOD4y6LdqZa34DJUzpk9JhFDYwfd2bxnfjcU/1cf4x0eZbPUmmuorwB49rBcEe3QZ9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTznEZk9OhQySyauYe0xlntrH602tjAKLNcjDczvv6I=;
 b=ZhnG53VefTnIeyNyGdvCvgyBupdcpo4NokA3bgwyaXqqi7NS7bsnMQAhnoa3SaAKAUCNVbwu+9x5E0AJJj2ECY6pRcBxzm7nZdrCW6/0fXxNSfQ8iMm5TL/ddH9S2XTO4VLKjnfgafKLduq2Jeg5qacbXFhNrgWNNnimQSpkZuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5406.namprd13.prod.outlook.com (2603:10b6:510:126::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 12:13:47 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 12:13:47 +0000
Date:   Mon, 22 May 2023 14:13:41 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtw89: 8851b: rfk: Fix spelling mistake
 KIP_RESOTRE -> KIP_RESTORE
Message-ID: <ZGtcdZU5IGpW3XRL@corigine.com>
References: <20230522085924.913649-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522085924.913649-1-colin.i.king@gmail.com>
X-ClientProxiedBy: AM0PR02CA0183.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::20) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: 26230e5a-b8fd-49ba-c1a9-08db5abdfeca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oewSZBKh2t4eVvdpV0nQShyFhrx+p5RIUUzzpR+2aiN2rm5p44kOYgKFXPyUIukLUELzsKBS4klD4nKGE07oP/JW415/dsv30udrfsW4Iw1E0gh6gdGYdEdIpEFo+s3lSbw5U2phX3MmVE75/fDC/pDKifIKLHkbiD7+XW1hhYVhczqiaab821PywHcTi+npwznj2fFI3HyYtGP9LsZwaFu3F/8IE2lCvXSlhWLsmbJRmkdY8KXeUdAqHjGw8VCRgYMQw6n4hfFx44MKVy1xQYXM+6d5HwuR88zYmUFC2PU9EV/eSojyDZiDUeQlNeZQgNhUhfrjJ2HiSBeM/pYQD5w15471scoSEOTAdXVy7AOXj/EOyFeZm5F+fH15hHG+rh917CcofZLf0ZxWQByHzIcTVzYzoNd1panZzWxY7vZ0f4AGH4JXEBsyilDzQOG7esk4v/IjWadcU/tPNaNzHXwh2dK+GXfsW4ZoArqmEmBDtWqOFRTmVmqvKkUZCWMYLwn0ZV4mba1QK+BPVQFkF13ZUPh/3WsV90iIuF3iQDWGkuQ30xaZRJObbYsobPCMEMzpWxZDGQ3IQffgNSrdH3nIcbxKNWG3htBVkdoWIHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(366004)(396003)(136003)(376002)(451199021)(2906002)(5660300002)(8676002)(8936002)(44832011)(36756003)(66946007)(66556008)(66476007)(4326008)(6916009)(54906003)(316002)(478600001)(41300700001)(558084003)(6666004)(6486002)(86362001)(2616005)(186003)(6506007)(6512007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wTQDTzXSistf20xQwgRy259A+o89krolwgUTrcn2et8ncfixTeHonk2Gz5yJ?=
 =?us-ascii?Q?Le96k36N4KQXcPuHbjMWCM8NuftJiF2Bu2Xzr/DjBUawcfS+jtYS9sTcBWAV?=
 =?us-ascii?Q?HYZbK6NvQG4mx69ZPH0V7R+IVc5MvdoUe5eG5DxpuJj37UpB17S0FNZ00sxQ?=
 =?us-ascii?Q?NnjZAaKpER0vlWU6p7jFfyw8rar1maEzTw0SidM8n3xrDfjD5k+mJqUjg0tr?=
 =?us-ascii?Q?H5+4l9Y0d7zQcQoTtPHV2pkkLGAX9i+3fVfY4yyANzr+kKLf+XFlyyP6nHaK?=
 =?us-ascii?Q?NCdZCuRyhQXjlMZue1oEBwxFQa9zsdaVACk1BEo0dP48xqA0ln7do7jKo1WA?=
 =?us-ascii?Q?IPLtgObD6ugNRHlaR1AaCKki6i5Fw9ofFA6KjsaBYo+UOTWpYOJ+vknZ8AIH?=
 =?us-ascii?Q?HsjV16ZsOge1ibVQog7WLhFg+QQJdaIi4xJVhvKknGp+dweVlB/aNyf1ghwo?=
 =?us-ascii?Q?dknkq7f/i5SCLUrlqXXTJt7O+EaQHSsfXlzXiCdqL6mewl1bRR7FIZzyZHqa?=
 =?us-ascii?Q?Yj2hTKkcaz5zn+DMKE1y4a0aymaceTyVPoMmHGoxWnA6U05pXuDuTOfTjbet?=
 =?us-ascii?Q?n/IGGckyZiR5YCn3SSnleSOA5LyvuUNemKdxDDfFHsNFfuMb+H5k9+saLkf/?=
 =?us-ascii?Q?scSa4vU7eLnuLMU6osUft41+GrPpWvg+SDZu02XRYfOmH/vKOnecAB2bKHru?=
 =?us-ascii?Q?xQH5M1AT2H444fgd1PBfcyV3iUnV39Q2MhE+3yDeKBUWJkLDtV4cy3Srppd1?=
 =?us-ascii?Q?BaeP4JpaLaXUfPBlKq4WRz9BLe8qlYeyrM+7T+W5K/i0pZp3lYFuPLmTvjHr?=
 =?us-ascii?Q?U55Qb38NifVvggaVD07609QXZlKi2Jukn4StK6NDIas0eQu/pGsonH/h2Of/?=
 =?us-ascii?Q?mpq3X/kT60VUqgjeoBqOhBx0iv/CZibR4W6aaPFhOHPA+GPISatVPWDqHrgg?=
 =?us-ascii?Q?+/+bjeLL9ivFMcDKuLTUWEKF/hrRJAnw7EaXZbSxUA9Qvg8AFrF3HJjwnuYw?=
 =?us-ascii?Q?Qn3bztTtleBmDIMO0Vu6tQzN2UwGGbbIH1usW2RZgiLtBxCdq5rVSj2Q/+5J?=
 =?us-ascii?Q?Br6F+sJyj+u14uA8q+kxarDTByGIPDRbZCrLfNlTvZmC9/JpSXmSPVBBKlPU?=
 =?us-ascii?Q?VjvcgKbKMhWbvNt7MHikQ0B6T6X6+EjMKO7d4Q0BHxZwJGbGZWYYMSaU7NA8?=
 =?us-ascii?Q?Wj3XaENsRpRMPMfVRrqHGtuT/AA/xGqFPTfNud833nxuZHQfzrWQpIhzZxxt?=
 =?us-ascii?Q?BzYinHGs/bvd4N0hHU/h7dsvIkBu1n4yYHXkliKFIl4rJWL9qjs0PRGWVA/p?=
 =?us-ascii?Q?S4emiPpifI32QfvD4z9f8mUhqZGbvs+t51k08363RV2En3lv5JMbmmgCp0OF?=
 =?us-ascii?Q?OdZoe8BfyMbl3YQalSOA2ePeeuFOzzM/sfbFe9ieWOja+CUTZiJUt7LiS6/Y?=
 =?us-ascii?Q?Po/UoHI9kHjvLBIHdypKxPzcnOBjC7NRWCmgCqRvl6BoqWITN7uhJvVm9mJ1?=
 =?us-ascii?Q?K1zn+M5WophDYM04TM40WxH2sSNcHzEldmL2Y/tUasTKiZSD/LRjo2UpcXaR?=
 =?us-ascii?Q?Z24pd907wVIbsoWGitJ60Z0SoCtCKYa6myN+bmk4RQlSkUE66QZa+Tx+igkZ?=
 =?us-ascii?Q?MEAPwwLHzBZFo66D8EOBDYNc4vSn8tSX4lvMayAUBb2xe5wuMYkCJLvZEwvk?=
 =?us-ascii?Q?t1f0ew=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26230e5a-b8fd-49ba-c1a9-08db5abdfeca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 12:13:47.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CewZBwTOTXdunrU5cKhkzztRZcEEqBpdtIr7dIDEyA+6tiyiBIr+Jg/tzssKE8T1H4RfhRPgUGm1drZX+jvAGYO8UT9XHChCjHw36J8B+2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5406
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 09:59:24AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

