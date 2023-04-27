Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A456F034C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbjD0JV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243169AbjD0JVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:21:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10395E1;
        Thu, 27 Apr 2023 02:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl1MG83E+/ztb877C9M4peV6Z+74H2m9SuXDUEyKec/AkYqSlt/WcdiWkEx2U5E7iIu2NdaQCv8dP0neWtC0OicpypKyrKZ7zSHCbRUQ703sHuLaejVpYZeE9v3avTONtTSi/Gb8U5Blygzp6UD+4hjJ7WFgaxUYg38YHbkU+nSK4D4SYtMcXS+fALXetFt4xX7ei3J9cqGllwwK8URb1+MBuc6jHg9eUN0xMZVwQ/cG55m//cFdpML8NBZ/G0y5xa3l5gD1O2BaKDHTwyaXAHH9UgDZlneKWCrLS8xCIRqCwTirtAg066RrabLaFMtEAvg4ZSyZuyTc/BpsgTDHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa709c/UmayanBuSeO1Iej/NSVHz5VkdNLQg0e9iZLU=;
 b=WCfntHqd1BOByj7TaSobNlXkcMxiTptLg+yMbHxlB662T3nprgBAR8xnxIfw39ahivIl9UlJs5DyJXY1lNoEzn7rc8yYp+9Sk7cW4y8FLlonYoJ6GQETj31hzx67Oz8nJy5LncQiDKB2QnyFDqYfxKghmGc0LkCB8XvQ43TUHl7WbKovGvUfw6OzXb425zWJCTZC44YeisAJNJrB/JV/ySMIUPeenT3bVxX6EKqNNkRSlDIFpR53i451gbzB+wn5EGXxeiEtDoFlYPgIUDEIkFbuJJVtQ9Fd48bv+anCc6shN35mzsMuX62NF0a9qAyVDopLrPkrQ7SrQaUPSPBa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aa709c/UmayanBuSeO1Iej/NSVHz5VkdNLQg0e9iZLU=;
 b=p5e8rDnw9u7FQnrjU8Emsb605yxCtGihZ8TJKzXGXtQFw+ZblKtjxQI+BrDIgNgJLNCv+vpQ2Pv3nOBeWWjuBcXyVPpdC0WG15rdqZhnfcUiMWWgnXjRubi2JuQQmQfGy8dAsZCZoToPZIBQCu6K+gjjdUbW7nhIjTHT+09pStghhXHHlCR7CNR3YN33732UboKu4O08+bb4808GPnUmtm6nAN8VF+chwA76A1/H+NrRamtVLedmyhdkM+ytYwQzHFrgrm9wIqGV7ydJ5ZdqEUGOZNIyRy+LT9OrGTMsXcZOwyByCMFbYmplXxe0B/gH6H/YwFntv3xd7ROFw9suoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PRAPR10MB7622.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:295::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Thu, 27 Apr
 2023 09:21:11 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9cd:f02a:9a74:b797]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9cd:f02a:9a74:b797%4]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 09:21:11 +0000
Date:   Thu, 27 Apr 2023 11:21:06 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Simon Guinot <simon.guinot@sequanux.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>
Subject: Re: [PATCH 1/1] gpio-f7188x: fix pin count on nct6116d bank 7
Message-ID: <20230427112106.697dd352@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZEoydXMDRONgbhY8@76cbfcf04d45>
References: <20230425153911.32135-1-henning.schild@siemens.com>
        <20230425153911.32135-2-henning.schild@siemens.com>
        <ZEoydXMDRONgbhY8@76cbfcf04d45>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::8) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PRAPR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d71c220-0f82-4edc-6684-08db4700bd7d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYHhg3NWgNmzNxjeB992oLqO35IOadJ9sGqPyJkd817nFaNCYaDZNnSzCQJaF6DokYgK4UbcIZxbiAycETW8fE536dvCxdjblHbsQs+x93ZQS9f1WjOCEi/kLEYwjmluFRHiNN2pCApcoEo4DXjgzWZVtoYww8730o3ArR4gQ2YrGe4itGMxKqLXAYPXXZUVxuGaSUxXripqEyddzW7CqS9ZeZ172ereI1ytPR/gibxDrcjRAMYu5Cr7XiU6/QOBTCtGgQQP1Iinp/kqwmfO6kACyez6JKgAfFft6EPLK1qirIIH77XoC/arjnVXI/3NA+DVbRotZ1qDxl3GxJxabA1r13GUfPMhUawFRtuF/wCjpNVlydbtdJgcQn7JMLqk2ni4eeygAGEql0fO0zhSCVF29L9L6gIYHMUiFkCa2Pct2l1Cu05VQAVDD22jYgBT8vSNeMpyMGnFWk/zHt0QNnu8e6t1yYpsK/pySFh91Wq7DCMJHyRb/jUNJT0Cs4D9+geANzg+Rg3yLeJ25RYGDz//9JeuFk2Xqjb6lEgpPWHmPUC6zriaADqwPzLvGYis
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(5660300002)(41300700001)(6486002)(8936002)(8676002)(83380400001)(26005)(86362001)(1076003)(9686003)(6506007)(107886003)(6512007)(82960400001)(186003)(38100700002)(66476007)(6916009)(478600001)(4326008)(316002)(54906003)(6666004)(66946007)(66556008)(2906002)(44832011)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJ/8KYyHJonlv3TOp2YltjwZ85qshsNWgw9zKL54eZ7kCffqh7Km2IhwfS56?=
 =?us-ascii?Q?DuH2Gkq/HFteURAeVrc1RXiOIwDNjK4kfNovPz9HYtZq48ZxLOexQ5Au8zix?=
 =?us-ascii?Q?KgsnHVe8A8K/a8NwF+lFpvwAN7FOoVu3ywLYeclJvamPKlFFfADjcz0i4KiH?=
 =?us-ascii?Q?AAswXl87Aow+dOLESi4SqjliIFECvpNZlOhYtHnlXDL75xU8AdbHz9Wg/5Wt?=
 =?us-ascii?Q?gtRsVOZf2BG8Wu4RwbmUqaylyPfHgM3hzP3iEWdFhfEMFtW6kg9sZhq9d9Uu?=
 =?us-ascii?Q?NV74gZynYQo2wYS2SeD2zbtqoCImMdGxrome6FLf4Swzii8X5HerA9vkGwL3?=
 =?us-ascii?Q?Ir+iZd0nc5vZad8kPOqDKAYy88j6A7dNAjiLVII72xSYyyq+BcGcuVyHQbp4?=
 =?us-ascii?Q?NQzzzU2Qoe2lDvJLuvjDhwwUyPycG28aoY5zFD9r/2bXlr6OsrWWueA98opE?=
 =?us-ascii?Q?mGmpQmBj2THmwisuuFtulbykYlmTu3cYA2gsc14EMeUsJjvrZb1VGVP9O94u?=
 =?us-ascii?Q?OWYZbby4ybL0wy26gyRR4QTB59ZXiZY76bkHWRB5qs2INhja+Ns7/o/WthQn?=
 =?us-ascii?Q?AFlDVSK8wQUDUwbNQzMN3z1s1DslEaaN9uZ+DgwKMTjPrOchXWVOt9pAiXHl?=
 =?us-ascii?Q?dQIDkcREVH3isRkTyKFEoJgOQCFq7HQqDgxoTebzVg+c5sEGXJ4AZuabhPyI?=
 =?us-ascii?Q?fhbSLET6oMDNi0M4o434T008HzHKdYoQgkuj2Vvsp13Mrph64//3N2/QgxQw?=
 =?us-ascii?Q?HuHj8PnrMWQx/3OJWJXD0hYViRDJtNu7678rn2a90Qtt4vAmY8mdb5a+1ZKJ?=
 =?us-ascii?Q?uIhs8YcIMAJ7jHsQq67w7Tw48OuC43irTXyWSIHYofOQNLsRWxbGbl/+cSiq?=
 =?us-ascii?Q?uN2tkY8UIsaV4W704ElGX1aXfTYhmk4AgBm2I4z9vS3Eph5Ba9aSRZBx4Vuw?=
 =?us-ascii?Q?mcXRdCXelBU310KGyyffTki3P2/GVg0TRt5CT2c+FovWZgiIiJaVBJPLASYl?=
 =?us-ascii?Q?OMCwUf4xln91kIOzKqxaRqXQfWU/0T7tpBjqaSQHAUSYHk6gPRckK1jrYLT6?=
 =?us-ascii?Q?OK1YJK0rNOvsspKvLtQjF1hu7lEqiUaXTwVhld8OTNm403cFjUNf5D7FU9Ve?=
 =?us-ascii?Q?oeK8BneqXaLJAwFK79Vo3+0kI9qMqCk1bC3/cr2X4wbtUB9PpNr/cD6264WD?=
 =?us-ascii?Q?txNHnb1tnTqDhozVHM9hj6PfF7e76PtQkdtG+Z13B3l5jzjukAsQHqAKLh0y?=
 =?us-ascii?Q?m2er4em0jGUn1fBPCiHkemrwzuWjcabVXj6KZNXe10jOrWZ8uMst23ZkSYWS?=
 =?us-ascii?Q?Eu8GRA/KkJjzJ7U1Y89gncmH4ylGTJLIBoHwNi72v0Vj+nloBIYIP2Y+klNO?=
 =?us-ascii?Q?IBBgq5xIZkOpsoURipX3gwJEDFOyfv9ljYI/EzWsSbBjiutZT0TKuRbxrspd?=
 =?us-ascii?Q?fzU4Mf/gkE6BxX9Zqx4cMUY/p9dV7uF/42QhgtUhxh+e1A8RJ1hnAG8oFsTI?=
 =?us-ascii?Q?eHzKu6hLYMnnetwm9Z+i4DWcZDe2FKGWJj8gscS6XWXhhxSCN4KtQdqWjOW7?=
 =?us-ascii?Q?l0qFW6M4+Dpt2j9phBEGOwutPCPg67zaNIz2vwMTmm2/PrKWIbEg9bvME5Wn?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d71c220-0f82-4edc-6684-08db4700bd7d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 09:21:11.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JijGIgdgTaXT0xZP3i44srVcQiKzH4z0PVFV5NcW6hft6URVWkdyXTwqpl3JS2IKuzgxsb2DJ7xcB0OoxHRR8ALsibNP5YfnYkIWBz5YWeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB7622
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 27 Apr 2023 10:29:41 +0200
schrieb Simon Guinot <simon.guinot@sequanux.org>:

> On Tue, Apr 25, 2023 at 05:39:11PM +0200, Henning Schild wrote:
> > The count was wrong because i looked at the wrong spec for the chip
> > in question. I now got access to the spec for that very chip and
> > group7 has all 8 pins, just like the other groups.  
> 
> Did you use the NCT6102D / NCT6106D datasheet in a first place ?

I do not remember which one, but one of the few one could find online.
Now i have datasheets for two chips directly from the vendor, both
files not publicly available and i am afraid i can not share.

> If the only difference with NCT6116D is the number of pins on port
> GPIO-7, then maybe we should handle it and claim support for this
> models as well ?

Please hold this patch back until i confirm again. It might be that i
got the model name wrong as well and might have to fix some strings. I
basically started my journey with a preliminary driver i got from
Nuvoton, which maybe made me think i was looking at a NCT6116D while i
was not.

At least that is what the chip IDs from the specs seem to strongly
suggest.

I am sorry for the confusion and will try to clean that up.

Now having access to some of those specs, i can offer to add more
variants without testing. Such support would be in patches on top, not
subject to fixing what we have in stable already. But i would only do
this on demand and have a weird feeling about it, the code might be
trivial but i have no means of testing.

Henning

> Simon
>  
> > 
> > Fixes: d0918a84aff0 ("gpio-f7188x: Add GPIO support for Nuvoton
> > NCT6116") Reported-by: Xing Tong Wu <xingtong.wu@siemens.com>
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  drivers/gpio/gpio-f7188x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
> > index 9effa7769bef..05c0edc4778f 100644
> > --- a/drivers/gpio/gpio-f7188x.c
> > +++ b/drivers/gpio/gpio-f7188x.c
> > @@ -282,7 +282,7 @@ static struct f7188x_gpio_bank
> > nct6116d_gpio_bank[] = { F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME
> > "-4"), F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
> >  	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
> > -	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
> > +	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
> >  };
> >  
> >  static int f7188x_gpio_get_direction(struct gpio_chip *chip,
> > unsigned offset) -- 
> > 2.39.2  

