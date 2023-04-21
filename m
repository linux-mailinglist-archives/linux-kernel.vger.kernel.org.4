Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B506EAE48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjDUPuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDUPuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:50:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2100.outbound.protection.outlook.com [40.107.92.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35486118E2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3gtyWYpAOE4fiC0T9I3Sx+c67xlJQMll185PsPXccli9R+kSbKoQo32cwbZ7HU5MY25mXBfdzcEtTcPsPo1+6TnkjXtMSNlQAqAAge+0RFH7fZEeSc51JtNu4noTMqRbvGR403rW2Vvko1t5bDWhXf5eyoJYc9WDZUkP+2eYEJT5dnrNC0y1GNpgU+4L9klKByHvJX3f4dquoX47P2x0MnKzK3wcLje7DRzY+BoMXqZl77I5onS8SSRlQZJtVtkwoSFIozmKgedrmKzvC2GcyNGSYin7MjcWCkUfGgj0NCTPdeEHufs/ZD0d2rKGm1Ght8UoX1Dzqf+nrUbZN0lGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNVmlDELI4drqMxz1dtHRB3qeT7BkBPC+0pyPcTSouU=;
 b=M7VRZUQwCgwtFkspC6OcV1x79ptN7moSoNUuk4ehDTd0yXjm5v2GQWE5uCsHsxcDYgoO8TMTpufxJfWY/RBZ5AdGtoJoQaiT/ZwoAcFpmB3hGSF3DWMRYrO2OAYDkmi1j91bVntB2H+Fst+GmN3JiU4MC5sm3NzODmBC2AgY7ZmVvS5CV0E4F8GTMkZZtJhsqddEYbl4tuU6pE9ifuTZPkBLRjkOrW119zcK5eBeha7ToDvXBKW7ilBEyMpyeaKqVFs0Y5sqLedeBHi9FmLhGw3b+r6iMiKZmCADYyCbfnjaJHcjgb70YcmfGe+7HnjFp4OHTOjPeJG7C8cZhBr56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNVmlDELI4drqMxz1dtHRB3qeT7BkBPC+0pyPcTSouU=;
 b=aO7CkEQzmwtflqvHR/5Y5bm56w50GnHzAxbU2k1Lwjuv8CmCNcmE0BdD7NFBDuVIjRgvibN1Co3O41fCxR1JNpYuC92PquprYITE2niaNIYxPzltcS7BCZqA26Wo5AFOU0VA9dulW2zF4FRK4LVrBgQwgHOSvdVNm5eqFXJmu24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by PH7PR10MB6965.namprd10.prod.outlook.com
 (2603:10b6:510:272::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 21 Apr
 2023 15:50:33 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::3fcd:b2d:f7d8:6fb1]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::3fcd:b2d:f7d8:6fb1%5]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 15:50:33 +0000
Date:   Fri, 21 Apr 2023 08:50:30 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH] regmap: don't check for alignment when using reg_shift
Message-ID: <ZEKwxhJJNkuX7VTr@colin-ia-desktop>
References: <20230420150617.381922-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420150617.381922-1-maxime.chevallier@bootlin.com>
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|PH7PR10MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0bbbbd-d367-459e-5200-08db42802405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozARoo7YhTTC9edqiiFtIslF5/eAC8DeLc+IO8oAdpUP5XE5J434D8hKzV7vNaoAqwWxQr/uvdiYpdhh0SxMcx4XA5mxmcOEyxEIo8yxLcwzbH6M2aq7qV2eMncPIZu/bTBY0prJhnCTXd5D/NdgDXHwS6qD+3Q8oz7Y4toMF7cpa2Gc3FsLx75Y/cwUSyGT5oEKIJTPxXlh9u2aEYDSSYajg3nVcv8D7215dkdg51uq9a7EapUpMNoSJlJvOp2St9mB5b3fUL11uoDqazkwTQEmrRMqLpusfTZyjuMTNQS9vbDLj4JoCLJjpGm5ezJcQGucMJoMRURmRQmkdCr0CSLmWHF/Wam/os6ulGIfixEbhM1ExPR0+i2zijQwbJPKcsWUxHgfwG8/K1YDVAtoFABDnL9dG4PGzomIMAMCPqzrYdsh+RQDYCMQjp1odtVGluhC56eDB5DoaA4y56NyiqHwEai9s8cWKRH0+aZ+II+RdkYs5ULlkLdftgHor4VF/YUHlcvIgOfBIGApZlXP1Tev//0QOH0vI5AdHBVjpYDS5njjscb80RYlQfGkAjzv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39830400003)(376002)(136003)(366004)(346002)(451199021)(33716001)(86362001)(2906002)(44832011)(5660300002)(186003)(83380400001)(26005)(6512007)(6506007)(9686003)(4326008)(66946007)(478600001)(6916009)(66556008)(66476007)(6486002)(41300700001)(316002)(54906003)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BcM2ztQ2SEoyjGstiZVgwcVtKAPbrOBuxWBLfB7N2P0JytwO2QBwD50fbBK/?=
 =?us-ascii?Q?TYHxXTfWv+sd/GaRkWCiZSJ1ONctZZZ5naB1kPJYqvY6l9F3/p1BJm2IoU/H?=
 =?us-ascii?Q?KwU2tyMDUyxrUb7g4MSatx5kNDEiqu+g8l4EVEN9mPJrT3I/BWzCDO1v3rRm?=
 =?us-ascii?Q?Aed+wSl7rSSaKLO0g734qxosyuSx1r2KjPvPsdZzF/HpKIFWaMJmDr8hQw0A?=
 =?us-ascii?Q?Lu1HNOuGjwPFGvYAizg1q356xq9AlMM5dKt2bQ7yKWV/IDXYygdq8MPY2PPd?=
 =?us-ascii?Q?EVtrebWrtPSxfkAmfd434xudVPO8HgYM69Ysqz4gQ5OWxcfYcckUqQeptHlP?=
 =?us-ascii?Q?PkIRtGlVhWKgVxc6QKo1c6oNpQr7O7Z6UHnOeTFV7XlPxwjt+BOaYCHLDQgV?=
 =?us-ascii?Q?mMuQbld1VF93V2NZbKy3I0H7QJNIjCSSzFISpU1Ds4tK6CzdnodyntN2eZ4t?=
 =?us-ascii?Q?P4c9NXbhahgMx20F2j/hsNDBUiz4xJRcgl+nRxVqyn7pwc15itkxjqlExRMz?=
 =?us-ascii?Q?1FAndULtURpIMQs/7qELztIeS1HQtzCTps1vetx8lfVBx3VZkb9Lqi6BdskP?=
 =?us-ascii?Q?Ja15I4TsNOEFxuzjGLzn2eAmSTdvFVPjNqcsw089Dg30ZUq2NnBLFI0hpCY8?=
 =?us-ascii?Q?9yieMf+cIkCEtuJpKXP6Gdv5I/ayRsptQqviV+LIotrNhKT11c5O6vppZgWe?=
 =?us-ascii?Q?NuoKVPgC4XZffvms+sPAV0J9EBaRHJq0iiuoGxMVlBNoGWOEqyR/3HN+iWRQ?=
 =?us-ascii?Q?DjJL9CwzuovgNgw6jPGNv2Nye/+oVSr0j9L9gjr9GZU5Ej0L53X7Oqn7dFaZ?=
 =?us-ascii?Q?1+SmfOTf4FvuNr1T1iznSzafu3J3ereXERkqwyxh7VKDRC/h2B9x2hU08MZe?=
 =?us-ascii?Q?mbsbZlq9wOyoRsjEvTLmPklG22HLMRkqOOIGxtLXQM3LhqU+wx4NJ8SeZicB?=
 =?us-ascii?Q?85Hi9ge+H2z/6WvQqHJCbNlPtBotaLpgushwlZnn16DNXRj6g8G2v2IOqUIl?=
 =?us-ascii?Q?hTNPoL9v0c5nhFCQsxnbjvBOsXr0+Zp+GvwHUhAH7v7gCEoHwoK0vOy51QdJ?=
 =?us-ascii?Q?yZ7y5yrjE3cjLZFymwJp6TbemJ5GXjBSZx0H+hjZFtJ2QdQjp5oVbfcqOYai?=
 =?us-ascii?Q?wSIW+V8F8vgHH9yswXAiHY+uxTiqlDicO/Uip63CWKk2Es5lbFe9k0FoYIVp?=
 =?us-ascii?Q?t8wjUNcksIX1PI1GuZwi+yEXMqYhgfP9vAYIz7/Aj92Xt4Zz+kT/3jexvPI4?=
 =?us-ascii?Q?VNpYgGva+4SzcRyubQwCKn+FkMDk1e6LxKMmzHbu8aQ5WqfHgdN/aHFAzADd?=
 =?us-ascii?Q?twWz+MfjZbGzAxa95RFdpBcaCfjCZu7PXh48xJopib1LS0z5Vkp/aVF07pqV?=
 =?us-ascii?Q?qst1uJWmkD7rDc+HftqmcL8F+LJd+roMAmclLbGV0hXvg+g3YOZrEvZovRg5?=
 =?us-ascii?Q?bOjcFirH3cL4LQe72Ezqc8t7T+0Jx7sy3WtTgUUwUWjff+1hzdqgBbPs/Xo0?=
 =?us-ascii?Q?8/OpsHwieOuuEDCVqF70N7t35Pl1+8jKiRB4Y8nP+irw/jiUv7SEfOzhi1HK?=
 =?us-ascii?Q?4zU6cBsrOQ2wdFEr28BYX0RDbZQERNeklPSrLgzNLnR6CUuUyOx7g1qgSxnF?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0bbbbd-d367-459e-5200-08db42802405
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 15:50:33.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wbb0aScmrVd51lQw07O8LJsumdyTkziflePk30fkwWQbOVXo0LZFzDlDVZb1aAXkinkIVMtL1h/W8j/Ve75K0dLg9NuVQLGhYzbnYX0V2Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6965
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Apr 20, 2023 at 05:06:17PM +0200, Maxime Chevallier wrote:
> On regmap consumers that require address translation through
> up/downshifting, the alignment check in the regmap core doesn't take the
> translation into account. This doesn't matter when downshifting the
> register address, as any address that fits a given alignment requirement
> will still meet it when downshifted (a 4-byte aligned address will
> always also be 2-bytes aligned for example).
> 
> However, when upshifting, this check causes spurious errors, as it
> occurs before the upshifting.

I don't follow why upshifting should make a difference to alignment.
Assuming it does though, would it make sense to test

map->format.reg_shift > 0

instead of just !map->format.reg_shift?

> -	if (!IS_ALIGNED(reg, map->reg_stride))
> +	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
>  		return -EINVAL;

In the case of ocelot_spi, we'd want to flag an invalid access to a
register like 0x71070003... Before this patch it would return -EINVAL,
after this patch it would access 0x71070000.

Colin Foster
