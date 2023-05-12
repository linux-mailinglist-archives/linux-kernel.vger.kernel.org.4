Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7D700D70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbjELQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjELQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:55:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55791736;
        Fri, 12 May 2023 09:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksaGBvvG3o+4jE1ZC0Rr34wxsZLZdjDgnyQ6/sn8oPyPlOWL6wnZN91uqun6BirrNYzfXTQ0g1Tdq52E+a1WuRrITUdEEukpwBCvPcJ+7htOSzTI4oae/n8Pyn/NzYwYEklkMSMNIVKWHqvaUFK8tG8J1S4+K2FV6dmVXuAqWafIhEx9ipR6S02qdMRwrHFubmpfmXVQWzneIswi3pjPwupSiznOuTT02z3UiLCeLUyhSJJuHPd8z3rnmKgavDgooMBrj3l/IGuhv79isYuXO2j99qow14AQOePool4C/1PD77mG2SDAGfgBdQVPiahVpAQtEDZ/veorxNnJ2nufXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NC7lIb2TPNhXyaqOrtLd7SAa3yBCsx8kRb5TE3/wJIY=;
 b=TmNM+Y35mspBgEMhhrUBEzxvUW/InD4WMcQNQQ0G8HsyDan8Wwm4pdCUlK5KSX8ZI3oEkKmRAMFvVoi+2BOf3dyJJGCFjExwI3z6/bbbU+39jB79bo1jte6AbfK/5Ij3M0BPeRNd+OtgPe8pWLmIIvyG23VgSpdbsY2OATGkG1C7CcPjr6kp3lTb21VNkzMkueHSvi1WMANe8amSW6uIPPgfNoLfETSVNIVeTzjSs3Ah41AZnPUnmaYnsBHbtbF++98222EpYMYA7RZjIZbOJr2cJ25a4ZBooXGqQVuK2FTyQMiTzMcSzKtRR1HqB7rpQnulCkcthXnOq9eQ62TPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NC7lIb2TPNhXyaqOrtLd7SAa3yBCsx8kRb5TE3/wJIY=;
 b=RHv5ZTWDgEXWHAVLHhIbSZOMzChPBGiktZIamk/3usRnvHaSP6YfE9TME5lX39kHPRtJvQ4gme6eX9S1u2A3yrK1PRzB/edeKYBNbxVzLzEDq1Uvssy/EuCdzGcKPbFxcyBICtbU9cBmudlcYfZC9gMc6QtN+Pfc3OvgGDR55bY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BLAPR08MB6932.namprd08.prod.outlook.com
 (2603:10b6:208:306::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 16:54:57 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 16:54:56 +0000
Date:   Fri, 12 May 2023 11:54:53 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZF5vXU2xAfATr9vL@nixie71>
References: <CAH2-hcJYVpBNwnMS6qUp4=MW8kSryDAz7G5cNA8R00QabC9bjg@mail.gmail.com>
 <20230503153231.1136114-1-tomas.mudrunka@gmail.com>
 <ZFMN5nmqLAX170SE@nixie71>
 <ZF19yOojiaSbo3vS@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF19yOojiaSbo3vS@google.com>
X-ClientProxiedBy: DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27)
 To SN4PR0801MB3774.namprd08.prod.outlook.com (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BLAPR08MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: fae254d4-18a9-4e07-9158-08db53099d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgG8NjL6ZcYKuuBIraMT5/ruT5k0F3yK8rbCDnCIbR9s2m+M09wp7srwFkWYtnk+icLg0LWl418TX4DxP1rbpQNGXKYy4JM0gnenuUlEIDEZ+GFWLVpifZkmCNb3jC2BIOChY1XMJ3O7ZZCYDFcPsbuOU8eMz6cZhaLW9CwFYv1QIMZvOKiJTIPwDG8nw+s+95AjrKrgQePE4L5BQXtWNUbmr94gfRmKOIN9ZvqzzpXOaxQGpIeMGZnocyR3bZvPz2ihmv/IlwEEkmFWbraqpx6c+nDjG6o6cUGbTbyJzn4YoVJh2PEg6e/IjF0QTY/0WinE/Nsi6p6mldXouRSES7IUub1GUw+8IxMb6CxHaI+pgV/rbCr/C2L8TBJauPmbZJCDOgFo7H5aCLtfCnjAu7lD+GlzXSeeci/u0NlQUEdE659P7vQBYmhbSfxQjW+0dkT0LgChZGDdccIInrWC9cXJU9gnMC9RYixetdLeFm2EfOBcCP/17a3Rme2KYJN2eaX9Fp/zAhcbFlZinwaFKLK/IGE4Ak1G0C025BKwYS2XJzSuLrOfbCZqnVteZw9v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(376002)(346002)(396003)(39830400003)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(478600001)(316002)(86362001)(6486002)(83380400001)(26005)(186003)(6506007)(9686003)(6512007)(8936002)(5660300002)(8676002)(2906002)(41300700001)(6666004)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aE4TU3D4Pmr6DwKms+LTZRaV3aWtF7U7mW6fK+7gVuFkWqSMZm0QjoSMv2+s?=
 =?us-ascii?Q?nwX2IWmAzGioJKUhs8Z4myeuXD8lgEnCfrilttFhfSrgMDoActpsVnHWUUuM?=
 =?us-ascii?Q?NMcjO6vHRZhOHZwKrMajrU8UW6Xs3OWR5tyRpq3qg5m5un2E6bVQef4xa0qx?=
 =?us-ascii?Q?y4IDTWgWcMZm1ukZKyEMGSl1haXOUin0oF/xZjv6buOaVcZVcWAXSikDU+DT?=
 =?us-ascii?Q?IIz61ua34nSRoQtCJDmdnG5m3ophdr/HMSVxbRkdVxklfMxtxsktvfItBUcC?=
 =?us-ascii?Q?bSObwtVK3alFcVVdapGrclp/BKtDN4kLDlx4zHDnEd/sS3zy3yUL+HquHUJv?=
 =?us-ascii?Q?xeRIuCeLowLIopiOb0G5OEloje69X7ZytTarjE14Tp/IFqXqWpQGge+ScfgP?=
 =?us-ascii?Q?FiQsuCdN/sMJwm2LtxTeAj7aZnN0N35cB1R5M6DfEN/r/x0nz92QNnQo+s3a?=
 =?us-ascii?Q?S05+Uc+AcnESjfYhJ/INU56b1nMCmQVwKMQdxOL7BgkHeTIMJVrwe/VEmWhe?=
 =?us-ascii?Q?HOfJWG8Ksxtpl2FUgjhn6sUT6MZmLRnWyiewnxheuQjAqgR2d9bxoZ4fazdf?=
 =?us-ascii?Q?p9cqJOM5114j3/unL4M3xFrcxGv2T8zqqPGcYglug04Aoj8sn8E10VKnYXx6?=
 =?us-ascii?Q?0H8b7syI7mLRbbnfE/Wcz1wXynlLeaXOtyyNJ9TsJzQnRhgKOrD1VBbGofDP?=
 =?us-ascii?Q?l9ChgS4vaEUUmmRtnDPSzdcStLOlzrW8kpD3myLzeQ3VioFnAQJVBFuzpsmw?=
 =?us-ascii?Q?LnbaXjyK+x8p8iWtV77daW269tZuVWcPfo0wQ4Nz//TXrIYPlgndqKsDSLFV?=
 =?us-ascii?Q?6bc1GAWCuXyABg9VFfk+ANUo3Hok7JQduIXTkkTI/osFkVNsFbNBwy/BZCcg?=
 =?us-ascii?Q?V9eJGFMvdYXnsKqJxXt6isYB+w8PPb5gI8t3qw0xelm/iPwcAUp8cKihIZih?=
 =?us-ascii?Q?VD9byHnzWPda0LHR2613ITL8NbRPR7gMCTKaksrFrnBScDprre4eSL3TN1yF?=
 =?us-ascii?Q?qyiDaiMVOdV0TcWeA0s4S6QyTUrRGuBL3Ymb3gdJSjbWyb+EkIDmPd0ZnIS4?=
 =?us-ascii?Q?13zP/M4/bWkk8X3x5z7CbHS9oOTwhidvbHfCYqRRizlM7H5tGlSvon/AuHhE?=
 =?us-ascii?Q?E6edp1pHb4K9qP0jHtYgAzb4DdUpnrbZ4e4uosXR7Gk9I8ih8kzt4iWjjfyA?=
 =?us-ascii?Q?0tq7Rs6d4ibf+luw2JptQAexA71YTNHIDy9azzd56NnHos5iza9k0qjcvB2/?=
 =?us-ascii?Q?ySHHMjPynlRq+xJmWKHUS4Hd2LjlChLJLhWjoZOfTGTDDyhC9y1OnzKQO674?=
 =?us-ascii?Q?G6f91Yr0YAfn1OXd6bFJT2RspRXjazWivOa3dXCs4ph40nWUABGbWhbk5RD/?=
 =?us-ascii?Q?QPN/+NWDRMou1gE1N+CExBGGyZwJonsvdj5Bk1NW7q/3KupZ5A1mVyIgHAgn?=
 =?us-ascii?Q?Qv8OslvtbZw/qOk76SlFyBWc2OLIeNFdz10U3mY90+Y6OEnMu9TtNx4Dm93C?=
 =?us-ascii?Q?qCcfFS89uZlkrzTGnFnY1gmwblS9hT7FbUHK2a4WNxF9WgxDpTYfCmiUVphT?=
 =?us-ascii?Q?LQcrfM/O8fkF427cTPSEu9EIb7vpLLERoiDIdeFV?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae254d4-18a9-4e07-9158-08db53099d0f
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:54:56.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYq+s2PY2L+t6vT2qVPfmxYgF1eOVWTVteK8l2StULHTBBuVlF69tzPrHuAesN5gdXgcPx/Gs7xiG7dgz6dvDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR08MB6932
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, May 11, 2023 at 04:44:08PM -0700, Dmitry Torokhov wrote:
> On Wed, May 03, 2023 at 08:44:06PM -0500, Jeff LaBundy wrote:
> > Hi Tomas,
> > 
> > On Wed, May 03, 2023 at 05:32:31PM +0200, Tomas Mudrunka wrote:
> > > LM8333 uses gpio interrupt line which is triggered by falling edge.
> > > When button is pressed before driver is loaded,
> > > driver will miss the edge and never respond again.
> > > To fix this we run the interrupt handler before registering IRQ
> > > to clear the interrupt via i2c command.
> > > 
> > > Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> > > ---
> > 
> > Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> > 
> > >  drivers/input/keyboard/lm8333.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> > > index 7457c3220..52108c370 100644
> > > --- a/drivers/input/keyboard/lm8333.c
> > > +++ b/drivers/input/keyboard/lm8333.c
> > > @@ -178,6 +178,8 @@ static int lm8333_probe(struct i2c_client *client)
> > >  			dev_warn(&client->dev, "Unable to set active time\n");
> > >  	}
> > >  
> > > +	lm8333_irq_thread(client->irq, lm8333);
> 
> So this is still racy, isn't it? The interrupt may come after read is
> done, but before we register the handler.

You're absolutely correct; I had not considered this corner case. Apologies
for the churn Tomas.

In that case, it seems the solution is to either move the dummy read after
the handler is registered as in v4, or remove the hard-coded flag and allow
dts to specify level sensitivity.

> 
> > > +
> > >  	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
> > >  				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > >  				   "lm8333", lm8333);
> > > -- 
> > > 2.40.1
> > 
> 
> Thanks.
> 
> -- 
> Dmitry

Kind regards,
Jeff LaBundy
