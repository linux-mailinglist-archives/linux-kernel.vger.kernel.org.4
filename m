Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5456474A61A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGFVqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFVqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:46:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233BDE5;
        Thu,  6 Jul 2023 14:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr3fY2KEGg4zcr3V1QvFVN9fqLhYPGd47awnMroTqEVnZR/o9ePT7qcdrQ3WmJTkmh+nQYQ2yxEVaCLpyrmiBUMLVBEBph8O5N3hKKBLjYXm8IjcjeB3RXbRry6JepmGs288pNx8ZUEuvW5FjOSyrbIrCVk2Kw2KUN1DbKjpo19rEjYkg/6rbrmOaUDnI6VZuxWp11NZeaAD+L8Js65MzXXH1PbLWHkDusjxArDAYeXj6bDABHJjGDixO97HEGWM7tBbJXecuq2s/0NYQhBiUweHQnTEs4seop9fq2u6fGyLtcNBiQBIJYUWNZAlLl3OHk1ZHrjWZhMoXl1vNTttEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMECaiBDSi5UxfFSW7oNrQZAF5Wksz2n5FeivDMJJlQ=;
 b=LU1qzrRN+ypacW/svuuIk7MQKd9fYJbwTEaZ0C07MxkobjDME2Lwm3WcT8Gb76DaY/OxCuOkrhaxnMk7UDH3gVgRhmM4p3FfTQXvhKetD+aYcDBLWpJcm06ebSkWDowRqnHpVQ1W0PqsmEPOqATFgbln2TUAp2PIYXK7pIcxXveUBpqb5siUGMps4FTktQTdyKoCGXdQzZhXL/4c5uMMdEGRxnFmSUbK45s9qP5lq9k0xYYqH99cgOs3JEc7Co9NZZ60kdmonchzzuI6gZAxI3TYkyIhu+Hp0B1bBYPJTcZhJUEhY2/zt6nItIXHlkgweuZW04JBLbcK10iXIhJTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMECaiBDSi5UxfFSW7oNrQZAF5Wksz2n5FeivDMJJlQ=;
 b=V5S6ryyhMbd94FWzNjVCAzUO6JfiTco0D6IoOtOQ1qAdLTy5qveb16gtaA0dvl1xZvAlJJKAqmZcOZ+xbORWOGSIf2+7hgYyeespX+vRVhw69n3++1sKNHNe1620HUPsseXffRnkxiu/jaUICG2gbwihAu0j943v5xATfj8VqJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3700.namprd13.prod.outlook.com (2603:10b6:a03:21b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 21:45:55 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 21:45:55 +0000
Date:   Thu, 6 Jul 2023 22:45:48 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        Network Development <netdev@vger.kernel.org>,
        UNGLinuxDriver@microchip.com,
        Pavithra Sathyanarayanan <Pavithra.Sathyanarayanan@microchip.com>
Subject: Re: linux-next: Tree for Jul 4
 (drivers/net/ethernet/microchip/lan743x_main.c)
Message-ID: <ZKc2DLIroSNi4tgs@corigine.com>
References: <20230704134336.4c5d1772@canb.auug.org.au>
 <725bf1c5-b252-7d19-7582-a6809716c7d6@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725bf1c5-b252-7d19-7582-a6809716c7d6@infradead.org>
X-ClientProxiedBy: LO2P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3700:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9dbe18-f7f5-4b67-b559-08db7e6a5fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4sJFatofCDaAYG3iUk6wW2q608iusGOhRm0rWgAkOBFPh3dc+kQtzHzEMPGwcoUdrtwTnovxiUsbq03g+r96ZsDgKaa2umWodPycG0d/i5VdkNvhImsOrrJZOh75Xg8RS0RkoS4nnuCr7frH6oTKii4Hk+pafboOrg5fc54fWn4UNn1QpuXFYR7LVzZdI4Jk8faI9D5jVY4E8OsWaooBkXQKVA34qb9/+fcXLMAe5jHCJLUJrsLWnC14jULfEUDEdrAeEBpfqbaw+PnJrnBvDjN3UFfuaWAlZu597ak4radNf/AI9GivXfU5mPK59Kyo9XUtHsdlPcQjh05iCOhqKTxh9umsEvUIHM1d3vDkDJKM+S0wO8RnpxwNl7jcO3yzCFvfoONLmES036K79nUen3AAf11canNbDRRuf7L+95m1Bj95A+R+IJ/w0Yk910AzlyVy+asWcQe+5yB7wjmRLFz0kSGxfg29d4LAJ9OuLUvPaxWG7V8Lge/S0KnAM/v56Kk9unpqKXSV+f7LbcI1t+z7MpheNP0nxiNbF0QDssrwg6CYhglxfaNUauBbWZl6vTLs8g80odv5ZGQJUbO37yKqXcoqqgpFScFjFDq4yY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39830400003)(366004)(451199021)(44832011)(478600001)(5660300002)(8936002)(41300700001)(8676002)(66556008)(66476007)(66946007)(316002)(4326008)(2906002)(6916009)(54906003)(6486002)(6666004)(6512007)(2616005)(26005)(6506007)(186003)(53546011)(83380400001)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ec/BlUob/gvaXApwzRZdndzItPBbvE4wb/ppK1IUHBF5HfGQKoZwc1bcaVls?=
 =?us-ascii?Q?/z3yvl/h01MqXnav/4s6uzOC6GC4LbpN3PXuN3rWd6zJPW+DgtSGUl3LSmwu?=
 =?us-ascii?Q?bOwcZK/0NykLqrqIEUW2yhOCB/sx5SrS2nm3NuUUcHIu37rTCEAXRWaTDRJz?=
 =?us-ascii?Q?g8zp1hgB77K6i+u9e6s9LoEZiXkkKBgCUIEbS8XJLeGEkJ+QteHzl3k39Hs/?=
 =?us-ascii?Q?IobQ3yxLpG9mwVpVGOsV5vA4yehg5Vjv5RHk8ujVYGwJk7zg3ob8Irg0VfSA?=
 =?us-ascii?Q?9xQcmmSZsppuktSMpztdpc2KhMeSptF+CfpdgOXG097zR5exzogG4FZqPUlB?=
 =?us-ascii?Q?LnB7JnoVvfP/1XEJQPN1iOq4JMVYp9dMCUU4V9IIJObzGWPQKHgJ6ry/nNFH?=
 =?us-ascii?Q?BFC2uURd5vVoYKFm0wJYy1B1byiP3Pze81xsO9ZffvIxsEsbwq/BVeNU7+ah?=
 =?us-ascii?Q?NnyxgchRNZj3mPdF3zTWnllD6s9+xTqwBFgWp9aLKJFibtrczdkytSeGK/bM?=
 =?us-ascii?Q?swtyP7wyRPNyg0JmoYqfM/6bIEAM7/3SAl/+GfInx0njLedFJZW7uvHetCHD?=
 =?us-ascii?Q?YjbTYOnu9/Pv8OaOt1s3vqZJ6qvW/afhebd8WgvfF5IVkA5pWz+WCEXjXtxO?=
 =?us-ascii?Q?/M7Wqr1GIw6Ygf8E8NlmhYE6Gr99QZkQQURMvFcQ7x2a12m/ODgMOrCMYAV1?=
 =?us-ascii?Q?4yqC7m5CcHjHbjcCj5cWz/hz9rF9Y3G5ciZWtBZwJ4JIsLu1bgewLBbvqeTG?=
 =?us-ascii?Q?vmg0V+8jTgQjIvAmJ8Pshj8EmqxC7raVxTqlnbds0lsumI6erBIEohSmyUqL?=
 =?us-ascii?Q?feG6ZYtNGPpJMxSaOOwxIwCpxH/IhlM1Fbsl2KcyESipEvhS3a3xdZEO8UNc?=
 =?us-ascii?Q?DBP8GmHwE2JnIPo+P7yRs45fIKbafjCK3GyzYK2hSB18bYVWkYepljPWPWDX?=
 =?us-ascii?Q?zab+AHK4AwMxpeviVc5dTejRjekhX1lSDgp4drXHx2tH2ypQP9UX8VCGWPNH?=
 =?us-ascii?Q?ZXOEtR9xUjD7BZ5KhB3NN/8744hkiGQ/4+IKW9/wUBmeXppMGJ24A9Zi8NRa?=
 =?us-ascii?Q?Cl1o1pMkfj5N/Lx+nuAyhwLzq6Lef+asPKzO9f1hIRrwfxv4sm5DH5YpHzMK?=
 =?us-ascii?Q?wY5mIo4+vPgWYx3OoYh574hiiJGquZauwtoBIm9GYIycYZg9mgYmnoaclCqa?=
 =?us-ascii?Q?6XrP2y6kLa47Ow0jyalI0HGGiDoFRnJqRgdJ4LlZ+PcoT25bJC4h17d9Xbb3?=
 =?us-ascii?Q?TkUJs07TITSDhIH8MJGgU47yvldIton+Q7vByP1FxRJHh843bu33vkVqUiqe?=
 =?us-ascii?Q?gQqC/XrjYvgz38M1v61IxeGdKRcqAft5inVncpcghOqiXfy0Hdr3inekxIl3?=
 =?us-ascii?Q?+aDeTTIe05Qj6rMPc+rxchD1FDrHzGjSUmvZqOGBhanzrJw9RqDIiiR1FQkZ?=
 =?us-ascii?Q?QO9AifrY5+fd2ZCo362ItxIjEoe8pqKjz6fspg5wAAiCFi2X7uNTDJWmGAr5?=
 =?us-ascii?Q?qREXFAC/fjVz1cbYcgBru9w12EPI7NslPPX+dD6YiGTX5Hyc1OuzzOJfLqME?=
 =?us-ascii?Q?02yHGkfDBF9IH9hAZ6/bOKsC5m7DrzPVSWIDlLLWFGOyIWXImIRJ/zZUYiHT?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9dbe18-f7f5-4b67-b559-08db7e6a5fe6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 21:45:54.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+fFGxcbEhNgZyPTh1uiLmjZ9sJQvhj4F+WfmLBvFyctzH6HIBACT7eQc+mflrCQbpIWJeTIKmbo3hmErjz7HyB641zbceOVNXWvg0kInRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3700
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Pavithra Sathyanarayanan

On Tue, Jul 04, 2023 at 03:25:31AM -0700, Randy Dunlap wrote:
> 
> 
> On 7/3/23 20:43, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Please do *not* add any v6.6 related stuff to your linux-next included
> > branches until after v6.5-rc1 has been released.
> > 
> > Changes since 20230703:
> > 
> 
> on s390:
> 
> s390-linux-ld: drivers/net/ethernet/microchip/lan743x_main.o: in function `lan743x_phy_open':
> drivers/net/ethernet/microchip/lan743x_main.c:1514: undefined reference to `fixed_phy_register'
> 
> 
> Full randconfig file is attached.

Thanks for the config.

I bisected this problem and it appears to be introduced by:

624864fbff92 ("net: lan743x: add fixed phy support for LAN7431 device")

I wonder if the following change in dependencies is an appropriate fix for
this problem.

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 24c994baad13..329e374b9539 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -46,7 +46,7 @@ config LAN743X
        tristate "LAN743x support"
        depends on PCI
        depends on PTP_1588_CLOCK_OPTIONAL
-       select PHYLIB
+       select FIXED_PHY
        select CRC16
        select CRC32
        help

