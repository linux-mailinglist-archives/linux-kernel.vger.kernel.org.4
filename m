Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBED70F423
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjEXK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjEXK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:26:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50C4BF;
        Wed, 24 May 2023 03:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jgfgt/xjOKBNv4bIjoBLVTNEUrmoreyN9tM7PvZA+B1gRNPB94BZ7m5ZH+1eaE8ttWIOi8PA4NVvhJCBy2NOVD39qfEDnkwmLb/cEgy9stoQIFqV8Y4PoxFGwyqYz+Tbj9+I5uDChs5bVcWwH2E5qpes/aSIj8XrcI84ulTnypAvGSJSlpvA7Fj8vLZ7lDaWOrVpeZ72HJEldSa7hlfX3ilj4Qblmyhiz6twbHNUDv4Jd07XvjkRbOddxYhYtsJlhIBsYcy8wMRAkakFN34q+pVnkYlLjfPW4g0TnmM2oJy2V7uxcOPfmwvdQLKsUprkIzzRMLsEhMKi4lCX6qAmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVz6IOw7DMAlZHNXO6XAu89h66htV7u3E15z8QD+oBY=;
 b=jzf0BlbkO3AYyRRRXU2kQpgnyZ7ya5/AMxUfj9Uf9gNpflNhWtBwJC0oRUi48Yj8cth3VV+VpL448oQFFliNX1aYhNizlhj2clJrHacNKB0qDOp/UtN6umXjNxRqEe3Tqg+hL/3Usris2GpdCgkt4uUM5rT949NGCBYHLGJcDC0N4FGY/OtRlfnNYHlKQxvFQHXMXIWUUTTWtrpuIMt3swIvn1vYQ7ovrdcvYec9rD/IXLmY2dnXL9OV3ONIvNv13O94PrAb6zAmwb3HuyYP7eWAtgfRktkzfmmSBiUZLjRLffPNj9jD02QTnzXhZfhfVYl0B9sQ5zOt7BRVx7HBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVz6IOw7DMAlZHNXO6XAu89h66htV7u3E15z8QD+oBY=;
 b=Z0rKgKTLTkzDMYScmgPGe2iCLe0Nl+z3EFTBFFXmSPzXINUUIeUD5mQZbLJb3YxbJ6rfQ0uIAGbDqtObzFqDcNzSgaE8eLkXPtEulpYBFQ2bW2sXrjx85IZvhg/sYC11JotrxBO3TekC1KhmSHc/uUlx7m6AdJfTW+LCPF+xNvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5790.namprd13.prod.outlook.com (2603:10b6:806:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 10:26:42 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 10:26:42 +0000
Date:   Wed, 24 May 2023 12:26:36 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] wl3501_cs: Fix an error handling path in
 wl3501_probe()
Message-ID: <ZG3mXH+I3qx2O0I1@corigine.com>
References: <7cc9c9316489b7d69b36aeb0edd3123538500b41.1684569865.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc9c9316489b7d69b36aeb0edd3123538500b41.1684569865.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: AM0PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:208:122::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 965e0b06-3cbd-4255-32f8-08db5c415de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTszSAa8iSJVvPdN1LT3rr+JpvKisO6tS7dUMG3eXqg81cRZjaf79tdieBbzBGVEh9aH8JaA68BbqkjENXwWPojjtYkrBxByh0nzg9XuBXWvvJD0Bpw9G+GOf3Jyk0afRXWvb67BBChUvjb2kP2/hnvWyChTzpc04Mk5i9bPdAzkykpbMNzG6kV0woY5tR9TwFrpw81itO3di8epJHaYUfxBnIMFTmaF+hmw/ke+Riv0H5i//ucHGpVY/ic1FppaIjqrpCBLLy+86L+sZRujNQ7uGmMOsrkcnituho/NO368BkiEllzSi6VB0PCLO1tl1PmVe+TH0mIJY7no6KF3n0TnRPyxHwJG7XeXCkhDemfgTPeW66yvkmMNerFG8xYgb9uvW8gvunbT2gN++DWq59KLSsgkPIse1Q+Q5Wb5+S5hU4+uGvyHB0zn5Ksxq/K5PmffsNzKYUEDTkqpNXaMygUWWksX4XzPtOn1gPuJWuVyVPLqjkr+shq1rM/rrdrz/GOXsSeR7rcKhD7zy+Ir3s9MQh3zcDlv4sSjXBinIfkCGMMcWYKf/BmNRkwllJggsJN4Yu46gdq0JbfaNRA/W/kIV6qx/ysBKZ/EY3XWneVOig0ZewMz411pW15xCSXN7ao8LtnpYVEGYsiyyTUdvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39840400004)(366004)(451199021)(2906002)(54906003)(4744005)(5660300002)(8936002)(8676002)(478600001)(44832011)(6666004)(41300700001)(66476007)(66946007)(66556008)(36756003)(4326008)(6916009)(316002)(6486002)(6506007)(6512007)(2616005)(38100700002)(86362001)(186003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XC/EcgdDslXgrsIiyQecb/aMCBMX9NntAMhJAyHARXcqKvunKeXsMdT/vGsN?=
 =?us-ascii?Q?QUVUaoVJ8WQx+81/X45OTEVef8grhuhNuN/mbtYCd1hanM8FscufKoNbd0+z?=
 =?us-ascii?Q?e+1gsLIyMzLa8Je8CDDs2say2PL7HXl53+19W9qDRYL5chJ8f0RBFVt1NUvZ?=
 =?us-ascii?Q?DuGzCFRSj9PuTCTAFgqYU/KBJ25OLb7L/bwprFQ+ITP93qJqrRTZHTSnxCP1?=
 =?us-ascii?Q?FNhjkzACws3Ry9ySkjOnylw3vFhskJGTSm9dny+Tu/N+wM6TkPV1SDBbHWkF?=
 =?us-ascii?Q?rtvJZ+HQ+/MbIFoWQ7nyOo25q4lT0/bfJFryhihsmEKUaAaW/7dztqbIFQQg?=
 =?us-ascii?Q?5RNTbEGqbVlFW8sahiQtdluLHhsAEWjIXxT43oqB2tFIWveFyFGveYSXEhfy?=
 =?us-ascii?Q?v+sFVa76nQj6YsdicepXtHJNJ36+WQQep3ojLB/Tv+6TW15fPls2LVs45F/A?=
 =?us-ascii?Q?8XQGqUKRzqGoD9OQZb93buyXTfdw4iJS1COhwH26srqnnv7XExcV+0QvjqbF?=
 =?us-ascii?Q?7wSAHNpVdqdTL9B86F+lBZLH++nTz1GfRmYK7C4ywMazl/PKHGjogFI+mM1t?=
 =?us-ascii?Q?jPRtrxZhRJexoeBHTOoiWtm+9zSkjVBFz/WxlGzJ01t5xiH0vf+k/oAOvSgG?=
 =?us-ascii?Q?L1YJIlVDxhr+Ogz2sI5VJUSVlhwypkHFVkhjDeOdkY/B5Si4OfdrR1y2ygjW?=
 =?us-ascii?Q?70+UNdj9yKvSSND6VGJg+CZv6VRHqcqtT+fYAumkGC2p40MmVQIcCAKb1Sjb?=
 =?us-ascii?Q?UIy5Ij9v4MmJolQ6oJkACUwAvHifR88dZ2ZU+IG+P3DmMSyT4WcRA7MkHQlX?=
 =?us-ascii?Q?M3zVc657k0PB3ydlQf4HoLuX+lOJfFReqUKpESYMRutNE+qQleg0qAMm28OF?=
 =?us-ascii?Q?Ohc/MYASQtD3Ji7XKUGNQwUHYdVHpD9u8RM40bLBfHGgrgxQHL9Sg+vSxb9J?=
 =?us-ascii?Q?5Fn+6eT8L+XPhKh6KYQlme4fEAjyNPJJirk04sGVDsVyBHIs6RUZrIvxPOtF?=
 =?us-ascii?Q?Q8hgqmoe8KzeGonJAdkFZNoqjEROoxiCSn0ePnOEbLHPFHAtC9s2pFCBSC1+?=
 =?us-ascii?Q?jzqFn8R76NzhM/i2F3YttSNoYobWbjCsUtMv9ElcnLwsdY87Xwn6GjAR6H9E?=
 =?us-ascii?Q?6m/5C4PJBH4PcUymKIMLsnljW098fnUBS/FObiJ9m3Nl2bqZA5ZkkH51yftV?=
 =?us-ascii?Q?TDm+NjyO8yRb5J0/Jilm6Y6SJXKSBdIo/mPZ0LpaXt+fcWoUXqiDqZz3GLDe?=
 =?us-ascii?Q?3iLUwcLA3ZQl+tiGpUT2dbVH1dEPhgg2dpOFk/jDlDIJFnfUFXdlg/+6vJzY?=
 =?us-ascii?Q?ntGf+Slygq/shVVWYmAo51BJNDvcz8jOyDzELIhWH0VivFpPcwrujVpWVtxE?=
 =?us-ascii?Q?fSdQ0p8asi5a5ZAvvjFjR3Dh3v2ap2sBlusxEvLsvORn0XOQB/Iz2+JfOje1?=
 =?us-ascii?Q?OmKRlrCDOL89949l5VWYHyN+tnqHgYG9+X+XETt+HbmcG1OhRqdjcQhgWVlL?=
 =?us-ascii?Q?b1oWOVXpyg0Y0KdWSWKaXlQOsdXLA3acGYV9SJEh8hS3P661OH6iMog0n/XN?=
 =?us-ascii?Q?qwAHO4wgi4TZG5qObWg34Mlkp+axq34+tSTpMmq5l51mOPVKLEGLjB/Yyjs0?=
 =?us-ascii?Q?BFOLUUkBx0Mn1U4LUnhr4PhcmNDUXF54qEsV4icIBbsIdA0dQFq5GPCZs5M3?=
 =?us-ascii?Q?jrC9SQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965e0b06-3cbd-4255-32f8-08db5c415de1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 10:26:42.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7A6SH+0T7BUvtOjkcs9pyWLjmyztlR/m/QcFJ3UzB2wDABl5NNbXKi7K0MpKAfOWhKTzUUYvtxcXxEfAIP1SliEY1pR9KRWrSi/ZCwWmsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5790
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 10:05:08AM +0200, Christophe JAILLET wrote:
> Should wl3501_config() fail, some resources need to be released as already
> done in the remove function.
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

