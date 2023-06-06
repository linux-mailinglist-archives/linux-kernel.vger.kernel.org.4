Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F5724C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbjFFTMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbjFFTL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:11:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A187730F3;
        Tue,  6 Jun 2023 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686078575; x=1717614575;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x1L+dH542Xu/5yzpzcqNf+1SsZkDcXbFD0UKS+qw1Ec=;
  b=THHaxaIsP8Suke3GjX8QGSy/0repdj1RXv7ex66/aWqIIjAwt7CiEmsf
   NlFWm9pe0YC8KaAPOVcPqh8NXKfDTOOsZoxTW1KfaCUeEtsjhoZLXdiew
   igw1OD9IdfPqllsAbe81OZlAtmfJ8LLbv2ENsPEInpCmFcnKwYQziDyyy
   fY/8GwqPwirNclk0uB96kde4QHhI/t8OsjMul9jtbnQhO5CDhXoznblgq
   wGYNorIDvxJioJFtEtxHQ+3/h0jZnyIuisN7R1+6y87omHGmg+GS+lOvL
   8FtA6M1IcQP8ypD0VJurcmySch6476AZeS2YA8N78o+1UITum5Nna3DaK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336401415"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="336401415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 12:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="738899087"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="738899087"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 06 Jun 2023 12:08:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 12:08:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 12:08:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 12:08:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 12:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcB1Y5etIKogqlmbTqsV1wxfFu3ziImvcLB4qDTGDNaITIbkvCjVzpDJI5TSCGLJcyA4h6UKpAkaXRewD4WcIS1yorAkK1drPp91caiz0ZtZiWVQ1BHnsO7trOunCO7LLr88yncyMXFQ57LIqpaxbwBMc4B++RoPgohnjR9XYE2ML6bRzH2ZBVBPDh4YoWDR++BV09vbBw8LN2U3K4CVXOq7MmINsoKzRv4LtHkJvBB+nrJg9hVHV8zRYxe6nqjivHEjMhdyOFjydK433jsXJrEC9LGlHi4gZKVts7PUpbq9mJs8KH8TjBRU8Ag9JGJw5DWewin9GH8m/7TN0JFhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlhU1XoMw3th6DUtE/P9c9aYIXZgsyEG9ghQWa1y7yM=;
 b=Ava+veZFwSuLM5qlV/H32NZNRMJdyLLIj7ueYsMK3+lNTvzRlPIOdK38Eqk8BXA+LLS0ZVQYXdPyb0rBKrAx7W3AUlM4XIPWuEv6n+M5ewVDxS5g4thkVQtNQBA8NAw56uK8Q8yU9J6b8+xZnnkYIM7jr1VgyW4+qB/b3KanKMa7D+AJ/dJCvRJ6+XLmV9IvrQfnqyvJzXa7pa4WvMAr3iMRvY+AkEg/7tTFnsZwoYEnixmpgIcpe1YqG6pxOB+LkcxRMRAYg4tbWxW9A2aSFuK7rf57fs5PjDfCYv2hV055liS9PZJD2ZfASTwDp2LCI7VRkvp4upTjiqROiSMq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24)
 by IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 19:08:01 +0000
Received: from MW3PR11MB4729.namprd11.prod.outlook.com
 ([fe80::2439:c11e:512b:9edf]) by MW3PR11MB4729.namprd11.prod.outlook.com
 ([fe80::2439:c11e:512b:9edf%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 19:08:01 +0000
Date:   Tue, 6 Jun 2023 12:07:56 -0700
From:   Abe Kohandel <abe.kohandel@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] spi: dw: Add compatible for Intel Mount Evans SoC
Message-ID: <ZH+EDLkdn+u2Rgwe@ekohande-desk2>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
 <20230606145402.474866-2-abe.kohandel@intel.com>
 <20230606172836.rbvhaxala2voaany@mobilestation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606172836.rbvhaxala2voaany@mobilestation>
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To MW3PR11MB4729.namprd11.prod.outlook.com
 (2603:10b6:303:5d::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4729:EE_|IA1PR11MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b57bc5-5dc9-4589-f4e1-08db66c158df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHWVZwunDmslxEM+JoJ3KvorwwotB8Ohs2tVPL8PsYs13BlISbg9nbcPBigE9UuqnfjEiGvIMSlD5URuCWL9ssN6eKfjDxXF42uGAu/TzohMvKFf5qQmLVBLammqZeW9sf5eg2XvmXy2PshN+QUTlMAspof+t0F2LYmxZ0Z4mlZD7aR56fQIv7KyUUHPbSGtF54tQVSEyHWxDNRfEmXJr/19Jt/G9HylCG3sWlJ4Ii+xXK4/jk5Co+mNP4Y2feFqw1/w0RXOwWJuz1LgwpDIFMqUsPufkMwwr6DXnpdXjr4fVGTB1jAxPr5At39qRN116zZmQSi4UMwNUL+ZDNII603sKM0ndrTRqYAWAZ4O5mNkjlrDHufQcatmqwQal/A45X85ZKP5NPM0hkaUMnW6k7E5n+p8i4FjTgLKwFVMGyYygWZZcJI4x60OY4NqRHj2mxu5hOu/H5DNQh+fYaH7OQleobXf2fXtYGuwsQSIUqvm+tO6gFXkdnF1vB33Fi/rVf8S4XgiHYzjv7Jqrouw7fipU5iy1XgUSCreH9xPLCS10kNX+URxJ2edOGln6SaS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4729.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(2906002)(478600001)(66946007)(6916009)(8936002)(4326008)(316002)(8676002)(5660300002)(41300700001)(54906003)(44832011)(66556008)(6666004)(6486002)(66476007)(6512007)(6506007)(26005)(9686003)(33716001)(38100700002)(82960400001)(186003)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xGjLGAapTne6RatbjpIuZcH/cVORQ65Cmc/8sDzsYZCs0kSs/TTEof86IRAD?=
 =?us-ascii?Q?W8kn0j7Nu2iYVJRX1GfDC0/TMtuLfJ8HI09pvFDcqachs2P6nP/r9AmJZSK1?=
 =?us-ascii?Q?d+eQpMs4d9CixVjXgXHPGsyCCfXyEDvR+lW5dryxk+XN536uIgh/EXxNtMM0?=
 =?us-ascii?Q?RUIvT/5Xdeu2lUBoRnR6sFVtrq3yz/G7z1aARV/+74bOz4syy/9SMuqe6XfW?=
 =?us-ascii?Q?Tn+yKr6/2oj26oMxLPkl8k03ii4f+M8bnC3o3/m+ONLHdW4Vf1uM+qmghCIU?=
 =?us-ascii?Q?npuNfCCroIlqNU9dFiN0Vu6BE6GkJshAaNtV3LwfY9O7Df4aSspaZ8RYnZxk?=
 =?us-ascii?Q?gK5CB2kD4ArAYZdaABhm8U7tmOZP7ihukn/7QypJKhyrqSrAfK0jQp4NTRlu?=
 =?us-ascii?Q?FHAhyYqFr90RZmSTZUBt5TrcmmH+CWq3kRT6hIexn/BzzckAQjmXeJww0Efa?=
 =?us-ascii?Q?HWxnc+hectGcxsFXsomcmNIyK0V6LSzq6GI+SL4U2EIHjqKkGxY7gRrNX1ZZ?=
 =?us-ascii?Q?maY9bRDp8B7vamFbDwWNJqLWr6avxUIChdWdNfkIq/DJor8tKK8yRYxL7elk?=
 =?us-ascii?Q?bkx9Ghin20Il9ViEZdWCdJezMhWLx636a7fuZlZu4/yi4JMw39ofs39486B/?=
 =?us-ascii?Q?bhDTFIi1/e3m3UfEWmsfJs3RCEfpdBc5e+FxvsQgODhEQK/ICK4MyACSjnP3?=
 =?us-ascii?Q?HEyf2Wqz1Ozbm34MQ1K/JaKpmMvCnamoCRcGeLIMxaDFMwsXhgOFWP982rSt?=
 =?us-ascii?Q?TDbAbOGJQL55wOMvEAP+j2CEDLpRXYNMw5CFnyPqalvAssRjYHH6OzGDyjOR?=
 =?us-ascii?Q?QOl6JoyGVasrSTu+4r7PeFOuhNN0kbgiLiAj4DtYO8EwG6/oRDrMaHu1D4Aj?=
 =?us-ascii?Q?oqPYeax1/9LeunO5mGFJqWUAKKe6nWOKUoUuRawRt8plGK/iOAhAvLP60PbL?=
 =?us-ascii?Q?Hh6rMWzwyNwbXhI6Fts+Jy2uK6sgPRmGBwR+M8AYJz/FuHpCKGOEVL2FCKLG?=
 =?us-ascii?Q?N855vrd4ZidJdysE2D3E2F2jwQxM2675mreFnV6xfkkxPoJCpDmWnyd+uSY8?=
 =?us-ascii?Q?JrwZxlXIgYVqvvi5fuS2qQZ1Mzd//Nl/IJvhAaYUyaypY4JE1h9n0lyXr3ir?=
 =?us-ascii?Q?0vdZl0Zu3H9mf0HShLRqjdm5oB5CCuFexamqRpEjmWJ/qctY9wPPImGtFxhQ?=
 =?us-ascii?Q?6ZtGuNCkFwn/l9WrJ6rIc9oFly/tmo+g0G5Pre+a6tvQ2Ft3wIQ74MSzddqQ?=
 =?us-ascii?Q?aw7XZUtyRcYprU0EpT0atM+8xZuS3mFEGrBs9lar3pLKyz1OzkbRK4u0oR3y?=
 =?us-ascii?Q?UdtZVewJGcg9ECgsj8bor99MbVhtEcialGHrKUM2ecSiriAz3ZAkVz8a5LWf?=
 =?us-ascii?Q?2HAGYY2m7BIAFApzclx33EyPKuYlR/I7LjOBW+0lMe+x9KtHGmTO/Zs3gPbl?=
 =?us-ascii?Q?Lj4ugjNuAm/IB9PLhqQyl88ceClTBzVcOZt17Zenc2qSg8EiRw6JVaXk+bEE?=
 =?us-ascii?Q?lPFs4aiTjTnAq5B7cr6aq2fr6rvKDrV1QZ/G6Z5oREFN2R5sTDBvOHYQzlyX?=
 =?us-ascii?Q?yuNvvpN9m84N0ljaA0LDsdTMcjdo4h/wZoa2qt6az78s2mmk0pUHXoJ7gF0O?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b57bc5-5dc9-4589-f4e1-08db66c158df
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4729.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 19:08:01.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7p370YHGvcwcPc5O5eXmOdWy5gvE5+jU2ychdIyp08FRPAHTEFcjhaQPbXQeBaX+mGtBYli9AYy647pWoCVjDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6513
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On 23/06/06 08:28PM, Serge Semin wrote:
> Hi Abe
> 
> On Tue, Jun 06, 2023 at 07:54:01AM -0700, Abe Kohandel wrote:
> > The Intel Mount Evans SoC's Integrated Management Complex uses the SPI
> > controller for access to a NOR SPI FLASH. However, the SoC doesn't
> > provide a mechanism to override the native chip select signal.
> > 
> > This driver doesn't use DMA for memory operations when a chip select
> > override is not provided due to the native chip select timing behavior.
> > As a result no DMA configuration is done for the controller and this
> > configuration is not tested.
> > 
> > The controller also has an errata where a full TX FIFO can result in
> > data corruption. The suggested workaround is to never completely fill
> > the FIFO. The TX FIFO has a size of 32 so the fifo_len is set to 31.
> > 
> > Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/spi/spi-dw-mmio.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 5f2aee69c1c1..c1d16157de61 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -236,6 +236,31 @@ static int dw_spi_intel_init(struct platform_device *pdev,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * The Intel Mount Evans SoC's Integrated Management Complex uses the
> > + * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
> > + * provide a mechanism to override the native chip select signal.
> > + *
> 
> > + * This driver doesn't use DMA for memory operations when a chip select
> > + * override is not provided due to the native chip select timing behavior.
> > + * As a result no DMA configuration is done for the controller and this
> > + * configuration is not tested.
> 
> Based on what is written you didn't test the DMA-based memory
> operations on your hardware. Well, this driver doesn't use DMA for
> memory operations on the platforms with the native CS just because
> nobody has implemented that feature so far. AFAICS if DMA-based memory
> operations were supported by the driver I don't think that the native
> CS auto de-assertion would have been an issue except when there is no
> hw-accelerated LLPs list handling in the DMA controller (in the later
> case we could have fallen back to the IRQ-less implementation though).
> Moreover having the DMA-based memory ops implemented would have been
> even better than what the driver provides at the moment since it would
> have eliminated the mem-op transfers in the atomic context. So the
> comment seems misleading. Another problem is that it refers to a
> feature which may be added in future. So the comment will be wrong
> then. So I would suggest to either drop the comment or change to
> something that just states that the DMA-based mem ops weren't tested
> for this hardware.
> 
> Am I wrong in some aspects of understanding your comment? Did you mean
> something else than what I inferred from it?
> 
> -Serge(y)
> 

You have interpreted my comments correctly. I can see how the comment is
misleading and can become obsolete in the future. I will shorten the comment
to just indicated that no DMA-based mem ops are tested for this hardware.

Thanks,
Abe
