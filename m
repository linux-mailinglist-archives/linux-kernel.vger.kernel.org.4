Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2A721D27
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjFEEbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFEEbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:31:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56861C7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 21:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685939473; x=1717475473;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FcSy5F/oKoOyZRFMajkIiODq6zFfML8C6tq9zV3wedE=;
  b=RfyHgW8JhTD+PyQsEwc5jJ3hBNbxBQ8QzNBKZ3GYiwzTsJnDm4t2xHKf
   A51y80j5GGkUGIC0lk5thE98AEIec9u3BCMzH/qMJnVGdRajBnyi1CJw0
   I1Tq7hESoo+U5uhMigtLIGkwnPkb3lK4NJ4bozIUH/f6sKkv0RlmWK30K
   XeQIoqkBezukFPLH4ztbx4kIyiC3d8MhJMoRN6Yni02RtGb1D7ioT70uk
   DsyOJAMJh9BvXj1N/ecfwo0mIXdxGRGm1JC5WocCBDywHwXArBsi0AHS+
   0Sm+jlD8D6l8ItKz0q9w3UkFBv0UXmd5BV2x2aJho7h4f2xslZZC/lNHe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="442654616"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="442654616"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 21:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="741565368"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="741565368"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2023 21:31:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 21:31:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 21:31:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 21:31:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 21:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REIZqENyMyxDhh1HEANrp8hKkBEdjFX3Yv1TMKdoVAKIESb+Ca4/xzV4Wq4Ix2aNoOmOIzxheJzh5bz1dVZo0dZUkmdNywVhwBsODjMADGp5mr+QhP46YAzUJKvSLQLa+QgxGvq5IPNxwEzch41Fl6q/Jbqrza5sz0meC3qI7vtsee823XhtlOv7IWmdcw4+/L3GvhdtH+y71Hk95AlgW6YypJH9vsniPYqqA15s1/HCLPsZcUTsnHE5HiOa0wHekCRnL1iRYyUbF/0dz9gQu/G/G+5wB+8t4449S2AkmSifseWuwKdpiqydvE3DFsrbGj3ol2nSDgo50H4rEgJ+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=789WZWqOpJQ+Z/Lu2PfeAFdUC10EMCsZVbrSe+hmzF8=;
 b=S+k0v10xhBS3hBuOpenS9ELm1VYLJ5GjV/DTQ/KH+PIctAMkdjrt2gwUEaNn8XeJ+KOhP/H7jtsA4C5UZeFmV4BRY37sRQw0cBFfsA3cC9mRggDF0F8YM5QWUL1pTWU0leLOUrJ0Kym7KrIWv4GcpzNuA4zj0s583Ws+Co7yQrTMRldYKAmcHx348ISFMLLJLBVXy4uptVIjwpIH7hNfp6owFmZp6QooxKaA1X8OC1wdpYYlXWCrkuG7NVjS+ECAyw0N6ZpTaBzNhgbZrQrSn7fZrhRIyq0TkvK9WAQz6MKWkAci7l1zGr2wA7PqYZDuBi1nAG8V1iKOC15K/wrBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH7PR11MB7570.namprd11.prod.outlook.com (2603:10b6:510:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Mon, 5 Jun
 2023 04:31:08 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::df9c:ac34:f263:aecc]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::df9c:ac34:f263:aecc%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 04:31:08 +0000
Date:   Mon, 5 Jun 2023 12:30:58 +0800
From:   Philip Li <philip.li@intel.com>
To:     Johan Hovold <johan@kernel.org>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild@lists.linux.dev>,
        "Dan Carpenter" <error27@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The robot is broken (was: Re: [PATCH 1/3] USB: serial: return
 errors from break handling)
Message-ID: <ZH1lAtO0nG801FrZ@rli9-mobl>
References: <202306031014.qzAY3uQ6-lkp@intel.com>
 <ZHyGd5BRjUaOdYyF@hovoldconsulting.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHyGd5BRjUaOdYyF@hovoldconsulting.com>
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH7PR11MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dedffe7-2814-4d4c-1850-08db657daebb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcN99UVGQFgdQyQwp8SBCLoRNlj1wIaQQTT3/Izw8NhjzoQzCf/yFzx+bndfae39e67UZ+ypWL9gzlp7WMGAV5JtR3CbE1pl2746lBEfOIaRRdkL5omRK/BKuwMcn/X8wYjl3xpgZGhQjKG48W0Oxh4FiW6lBB8sv2DEtpnCZi5tGb0cS+6hsUSsB0Y92JsG2OkRNl05FqSHi1tD5Ody0LjlMoVSyvltqoOzJSFGYD3vUKv79IVz33hUBbYhog30XUWGL44WqKGW7qpWZx86dfReeE8ecGzuR1RIY/1G1hCn807hWDEnEgdTjIfu9SMx4AYyLFNFEeUIIaMasUjh3k3V4nYgWRciwyrOu/lrzJj6Ds4F0ncDsBYTCNM7fq/9ccQOWsQFJzlxPgLa97mOYs2CAllwDaaNj+CCaFKyakyQIX9ySuEqU6use+qMUEG+eXjX9yBsAJ+eGcW0m29byNG7yOIop76UdpDqpdZadWKrzgM3ZrxRBF6rp6meqIqbOGSQCuiPu+0d96T9fj9gkLcHSKpTJ5GEcvtCm7TJhG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(966005)(8936002)(8676002)(41300700001)(186003)(2906002)(5660300002)(44832011)(26005)(6512007)(6506007)(9686003)(83380400001)(6486002)(478600001)(316002)(54906003)(6666004)(82960400001)(86362001)(66946007)(33716001)(38100700002)(66556008)(66476007)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBN2LKJHCPCm1/nckefbWQDxUb50IynA2q038K2n/rqOTjAGi7fZrD0hX3No?=
 =?us-ascii?Q?WtO4TBCfLgOcJ+2UCPT4mAi1Fd/ZXWISJjDgcLq5pZcfjZJtODOskKqc1RPt?=
 =?us-ascii?Q?rR38LYhMbUVKeNJ5VShKYZAMhDlg5D2FECj/kVXgTBqpjnxh3ZCJM1aJC68d?=
 =?us-ascii?Q?Mou3hPAV3SOXTVceYIszL852ixlidQnLUFNuyMBifKcG7qEqkoDaUZHBiv5Y?=
 =?us-ascii?Q?vbYyFL47LVxoLEDpontRoCfrp6mq8aL6w7nscItLYISIu/3nQwQZ3KWjHdmO?=
 =?us-ascii?Q?2UZ6kpFB1cFK6yaviZkyJDQwStE7gx+8+n8Mrt+TqmZH+Z2SQpY+h+8Vq+c0?=
 =?us-ascii?Q?pDcCpNsWTDVKIDs4EYhpIatxY9J9gVM+nzKjJCTfPwLxDpyPER3oWXVxp4Iw?=
 =?us-ascii?Q?d2jiCv9RWTOCmI3sUUUJqByNDsG9a/DtxhxjgI/GPflleG28G4hFli1J1Tdb?=
 =?us-ascii?Q?neAWWr6hLJxA+QIRxZind8pcB+eAb7y+Rv9wFl/jzjc4ZIrBdD7J7O5nSw7c?=
 =?us-ascii?Q?CzCnhPMZDFX0Flif3YCxev/ue5sLkD0cHNpugXGCwVGG/SRU4s/pPcv0rrKF?=
 =?us-ascii?Q?KxCltECWs9QaBy5wTHVDD+300eWss20u4MN8IuLrb4pdcD/ImNbGehZnJt3v?=
 =?us-ascii?Q?SZSBQbL8IQlOnt7XVy4a61hKbUqYePrQK+EnIBSQZKNoJChQaUj9MzGhOr6f?=
 =?us-ascii?Q?1z+v2LNKa3Px2MFuGu8AGr+WK5XKZNeQUgn3mhmP4X47vJhwpYlE+Dh/lWPG?=
 =?us-ascii?Q?Z5w+BFIrCwBir6kyJVWbh0tTy8s2qn9+c3vJ4gm8gXni8jbsbKk0RPo8M0Tf?=
 =?us-ascii?Q?byfHSk0SyIr1sIWI2+DQTp5pg/nHIyE1uiX1nZfPMbWELRBMmiM8pmAmuMDl?=
 =?us-ascii?Q?wEWo3qevxy7t92tSr66OwD8v0MBnV5pZneGmMe72D7T+AbesQS1M2zzAkGgg?=
 =?us-ascii?Q?yNCUX6MQmdM2F9q9aKJvwvTISc1K51KnJOx0bcCg+W35g/k+IblT+36Fl15K?=
 =?us-ascii?Q?g/EUfJAMy86N/CPhWtk47oLA8VGKzJpiYM7F/Ma5xQp09k1LmLeYzUN+F1ba?=
 =?us-ascii?Q?JEFMUw3vxqI6idpLKL/ok6W9e9KBzeHO3zRXMvXWPa9r9y0ZMB3x8tIOsdCy?=
 =?us-ascii?Q?5wRt7MTmXlWBdauvmaFwn7m72dWr1z8Dkm7laazTE5OY/+hoh8QuGvuwO1uY?=
 =?us-ascii?Q?KT9OeKiMjSf9DjO45awS0m9MjioyyFqjyzHqAbKUfM2pLQuGMGjn7IqeXAjS?=
 =?us-ascii?Q?tXtYHslE9M/HIJuXxcYzqpKh/NudvTOl4MTm47GM7jXzwZCjBc9dYrCBHylB?=
 =?us-ascii?Q?k2UpwoRDrpwSTwCwg9nCYeHQn91a6BX2K5E5wv+TAKH0SlZlMT6iv4G8sclQ?=
 =?us-ascii?Q?za9OA+SyUTkYK4S3JWzNSUsPXHM0zTi3fay3asJJv4tgPuwzIDk8bFQlSslL?=
 =?us-ascii?Q?qd9ye9gZR7ZRyEW+GSIrbxaoLb/8aKZ4/XFWltrx7znxGr5u+ygDPUyd3dH6?=
 =?us-ascii?Q?BTnYbdl2cxShU5JLqYuo9la8n8gRiL7u1AVzRKBOfe+3b56SJLUIEYj5xEIc?=
 =?us-ascii?Q?dCAqULFbyEm1bJRkBhVg4Wm115GP40V2+7ryCxow?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dedffe7-2814-4d4c-1850-08db657daebb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 04:31:08.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLi8lG2GXPA/LvXZ/ONS9W3wv6AVZqN5XWR7iuhjlkNgMeM1L0I6g6Z3yE8qAdrFBFFD1hkdDOiST0FCbOXuAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 02:41:27PM +0200, Johan Hovold wrote:
> On Sat, Jun 03, 2023 at 10:40:42AM +0800, kernel test robot wrote:
> > BCC: lkp@intel.com
> > CC: oe-kbuild-all@lists.linux.dev
> > In-Reply-To: <20230602124642.19076-2-johan@kernel.org>
> > References: <20230602124642.19076-2-johan@kernel.org>
> > TO: Johan Hovold <johan@kernel.org>
> > TO: Johan Hovold <johan@kernel.org>
> > CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> > CC: linux-usb@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > CC: Corey Minyard <minyard@acm.org>
> > 
> > Hi Johan,
> > 
> > kernel test robot noticed the following build warnings:
> 
> > New smatch warnings:
> > drivers/usb/serial/io_edgeport.c:1601 edge_break() error: uninitialized symbol 'status'.
> 
> Thanks for the report. Now fixed up in v2:
> 
> 	https://lore.kernel.org/lkml/20230604123505.4661-1-johan@kernel.org
> 
> The robot currently appears to be broken though as this report was never
> sent to me or the relevant mailing lists (and I just happened to see it
> by chance).

Thanks a lot Johan for checking this. For now, the bot has 2 similar mailing lists,
one is oe-kbuild-all@lists.linux.dev, which contains the high confidence report that
is sent directly to author and related CC. Another one is this oe-kbuild@lists.linux.dev,
that we will send low confidence issues here and they will only be really reported
out after manual check. So we can reduce false positives.

But sometimes, we may miss some reports of real issues, sorry about this.

> 
> Looks like there's a stray newline in the output of your scripts which
> causes the mail headers above to be included in the body instead.

Thanks, yes, this is by design, when the report is confirmed, it helps to send
out the report to actual users by removing this extra line.

> 
> Johan
> 
