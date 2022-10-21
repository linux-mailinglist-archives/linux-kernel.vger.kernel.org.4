Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1638A606F48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiJUFOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJUFOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:14:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3C22AB6C;
        Thu, 20 Oct 2022 22:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666329242; x=1697865242;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bH4qLRzjabx3RPPLjOpBiiwHP1adhWczYOoOT+L+SvA=;
  b=JYKfyQoAY5t3UiDBoqksvVXeSDYJdhyvPeHwvF17KMGuluGkmUdh6x86
   V1RSH05qnMhu6nLcyK4dWudRlB63ttQlyLu7FPvbigpK6ivUm5QDQsMgY
   Ehuah7RRzjc2V1oloQHhCSQFs0SbKLNk0ktWb9+HDt6JqEeAAfa6DO6FT
   09DPkYPKXB1ysKHsIY4JqcsnUtrV6cH79xTn9hPy3Lkhau6/1OO3susZD
   4SkHn5oBG7ISXfXOS5alynU0Jh9CvxWFZR7ip32l3AYGmrD3P4aYrJbTk
   Dp0K1vCf86bDxdJmpwkKkPcN0O+JK4kOQOAICnbjx6HZnJEY8/259Mdmk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304527198"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="304527198"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693476088"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="693476088"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2022 22:14:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 22:14:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 22:13:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 22:13:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 22:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvQkIoeq1AbXsKm3fNJMc5HqBXCoBs+94viraUbJVf9l+lpacGtpXF2R2TankdUpWS7RvH71aFLXOaTJnm8yo1RU5johnpIYFLR8sPYAq24VPFHPzhCo9soJN7UfWpCuSl+DdmnwWyz4Rx7B47WbIZ5EnNkS6fIqhP0Xfo98LWn3jkm85/dj5kdAaWdmYIbF84ICaclqtzXNFx6OdWvfjum1MlVVVQPWvJyjUF8lSjqMRKajGiV0lxfX1qgzUJV7KKIoYWc0Z5jnxFphDC3obcwJJL1RsSgOAWwnsrJfnulugfPpDCPPV5mcMUkmoET08YizK1vPZesjM4WonBUsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VB/jyu4LpEeuD4qJnI4oz9F8Houe4PsTMzcQ7V8+yEs=;
 b=WKKrhYEJSRlAUe0KKi3QoNBYdMLv/i3toUvCdI7rFucFeUpYfIluaE603vUB65/Z0C4t/IQRin94IHYKvAryO3KZktOMnnAlshDcpT4n+Mm96ELO8xmKen9aBOacbQJTg2eU8TBrsUzfnldYlJy+f5Zhprsvdv0W8JEUiAEAVqfeOuWCogKrPhv8Jx+Kh9pgqV2odXBjIbw90jrbE7h2TMe51i0PCVklAKYb3U/RfBX5rPQbn6i+QrpElGgVAA23CdrSZURznEArdDMjxtHWK/cwCUGjPYMOWl98sSUZ1Lfixpl0J3fflV9tPS22x9bA1yK1cX0UOrE6siS3cFtE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4593.namprd11.prod.outlook.com (2603:10b6:5:2a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 21 Oct
 2022 05:13:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 05:13:58 +0000
Date:   Thu, 20 Oct 2022 22:13:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 05/11] cxl/mem: Trace General Media Event Record
Message-ID: <Y1Iqkmq5qho10bmm@iweiny-desk3>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
 <20221010224131.1866246-6-ira.weiny@intel.com>
 <20221011135702.00006f74@huawei.com>
 <Y0nx1UOeYfQu5WYO@iweiny-desk3>
 <20221017173717.00005921@huawei.com>
 <20221017132143.360d2d46@gandalf.local.home>
 <20221018104636.000016fc@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018104636.000016fc@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8aac61-be58-4801-5ac8-08dab3230eab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmKd2qhrnk7l/fp0qSndl5twO4KJv1BDvqiAPZbZAcgYue5Ir3aEEi1jcfdSoKUEdB3gf8iO3RUcnjKIYZmjeLuaM9m9XTRQtNnDqwOupKrgCGpqlOgISeb/NppBPm+JORkdD+t2Yr+v1dGaKrZOXqK858BfYDNKw8WWBOD2FKivKE5C0DVYX+Ryofpt7hHzhiG3yPMdwEv4FM1faBpKwekDgqACq90AyYItu6G0hGmFS9mMDOme4XLyABsFLB9oOxvAP3e2J+dRt+qUyP4icMvUy3NPblcdYnyoExJj38OD76VjmfSXgEvxoLEUFVB5uSOH3bLz2nz8lBm0Ujvwicyo7M96NCB6FGxyrYrDoBcE5iyD9s4421kzAoFbPRe9zlh2nl8TfQDcCQpd+Wh1jAQgtJJ3zniFagCFztpS8PpeGDh0XKZW05FQCZAfmlRms3GmRVJUfU4qQNOb/UOlcU46kA7VVMWzF5CZzZXm6Kds5y/ZOEdLf9SYcOGBNgdbTk/gen0kjHNwPa+2Rb6E/pUjy2u30064cFehbb1Ap7NQt8aMVMGUdaTpg3ruWsVFUvAk8MOeBuuXNK4mTOklZnQF5Ox2700p9CxhjC++W7yneCXoq3ZS6JgZcUrng5uZ8szKY1NMU0PQrUKPlJccXzctqq5vQWv6UceTxAL/NiaUxKCeXExAvMWC7Kry2tIQ6LoEx8T/zaB7AEL74plvfbIVUw+5JFiWSMCg+8HsFac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(6666004)(186003)(6506007)(478600001)(9686003)(6512007)(26005)(6486002)(2906002)(83380400001)(966005)(6916009)(316002)(54906003)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(41300700001)(86362001)(5660300002)(44832011)(38100700002)(33716001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlQr4luDfkaYpLM4OfvqHUXzycVOSKRVuRXwAWTOfCqW+jG3G8kSEYnzYkzq?=
 =?us-ascii?Q?oYF9M6ruc7WvUvHCv2Inr0mtWhkIC1MSHUCcFHSgeMKw3ITxW/K0kYjMNSqY?=
 =?us-ascii?Q?1HEXdoAOoghxoZtYH0h6HtEgWUp0Uea5Uh/D5kmwOXGrS39+siImn+FF7X3x?=
 =?us-ascii?Q?bPRxd4GbZSYN8d8NjxjZhqm0LuBqe1exXndLppmtTANu8VN8EXljf8A+lSOQ?=
 =?us-ascii?Q?h5qXpjpLC7y3rp8xtJSi7MjVMDsXt78BK55jbFidjeOhuYka+Z2ZAfyMyfzN?=
 =?us-ascii?Q?S5Gc59lHAZOlviwfR1kzkhVB9u7fHNwAiMi/dacFQBrlpese+3hmWGanzeJR?=
 =?us-ascii?Q?wcTFasXCGtHVzRlNZY2tl1k8GCo8M5Rjh0fPAU/cTRcgv4cmTbAOoP2cYidk?=
 =?us-ascii?Q?BkJ7GRD2RAzHUnN3c5Wyq+9BLH4uDCLQndEF6jj18FJgbCsMIQQvNO/UstQq?=
 =?us-ascii?Q?ffo7hNo4RnWN7lhAwNsSYXkp4MnIl2ZkWqp2Ew/moqUYp/YxLE8mNoIXQsVY?=
 =?us-ascii?Q?kn5KVzPEPCbEMLhGq9MaQaQybRKb7CtLQ9+MsJNWdUtmhbtY2byarCGzl29d?=
 =?us-ascii?Q?bZCT9foqyNaWNlJimgCpCYrA0ZmW/AFBtBVyod7h84/4bRQrJfAD76616Cqk?=
 =?us-ascii?Q?9ItaJby+j8bUuWXWNy88iXY7gimK/yzWCs/JG8MWXgXq5uVTXUk1VeVEYNnM?=
 =?us-ascii?Q?f9YXiwPDCInh1U3MtuRhjAXopX7MlLImWyhkOpl25DoTAKY/RiEFYi3A/PhH?=
 =?us-ascii?Q?AVU+7eYSD0MhU/r7g9aAiKsAlciFPmVZE0QsEiotpVreUl7OquTPhxbYVAfe?=
 =?us-ascii?Q?BwJprEw/5CGQ28pf5HKxTeuNpHyxlIQQUIP64Zqsrrb9a9zSCz/7yuSnN/7j?=
 =?us-ascii?Q?3TdxvUn3cPvMfsiDEaiA030en2MZQs6hn9duFI6iwSYm+t449Wl7NsOQSGmy?=
 =?us-ascii?Q?cItC5xGrb34jVuMAmIn5UkG8m80pvabz7lUZq1oCKTMj5lZNq1n/sCd+Ih8D?=
 =?us-ascii?Q?q5pXv3KIeJA7OI05eMgiSKkloTh6pHC8AXGuH5+lUm1lO954T1KVR8Iw+n2P?=
 =?us-ascii?Q?v0MPF3pOu7x9gh6paxIhiDFy/WHJmNhLoDLVWVWQWKW2pDwTl0vVTsTrjJ+H?=
 =?us-ascii?Q?g+ic4rA2ZJZOAX0nn3UvKdXMSfamkf1clsvsHqzRcOpa8pWQ2KRBrf8RXI0E?=
 =?us-ascii?Q?zqWxcGDc6LzxnK7KbI22BGIxOYm1KQ6hzcpIpqCTNrMVMEoje5cpwfkpI7L4?=
 =?us-ascii?Q?25Vgx8ILWDLp3mxPYoi6WVEG/59l04AFp8GdW+Q671EvAGFV+WHJI+u167wg?=
 =?us-ascii?Q?iMpVBowfQj+vIHsIVNoOQp6AACrMB52pMRF2Hox6JGPvhdYFlCkm+3FeL2do?=
 =?us-ascii?Q?WAwmQRTlZ0Tywd9rKgIGC2oBWbqqC6rvmo409g8tr1KhH4bcAmm8nnznEB9z?=
 =?us-ascii?Q?WpXDVQRgl37aMHFk4mEEnheu8Kv0xg8dofA/NMmduyReaRIxubiDHFJhymis?=
 =?us-ascii?Q?yRk4pB906ioqsrod7ecIXIPH0ASHAEpIvTTVQT+G6yfjUqMh2uDOn5gtM/qn?=
 =?us-ascii?Q?SmH7wFOs+/eOoiu+gc8sJeSTutaBAEFdy9NfCnfA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8aac61-be58-4801-5ac8-08dab3230eab
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 05:13:57.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+QGFoV7g6eIvcmuL78uIwfBoySj6Ahq+tLBGRBjqBjfHpEZ21NktMB1U46t2CaC5HlV1F9KLnodrtm4Jv97sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4593
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:46:36AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Oct 2022 13:21:43 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 17 Oct 2022 17:37:17 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > > Looking at other similar cases though and we have a lot of use
> > > of trace_seq_printf() e.g. libata_trace_parse_status() though note
> > > there is some magic macro stuff in include/trace/events/libata.h 
> > > to tie that together.
> > > https://elixir.bootlin.com/linux/latest/source/drivers/ata/libata-trace.c#L14
> > > 
> > > That seems to get you access to the actual buffer we are printing into
> > > in similar cases.  
> > 
> > Looking at the code you linked to, I wonder why __print_flags() wasn't used?
> > 
> > For instance, you have:
> > 
> > const char *
> > libata_trace_parse_status(struct trace_seq *p, unsigned char status)
> > {
> >         const char *ret = trace_seq_buffer_ptr(p);
> > 
> >         trace_seq_printf(p, "{ ");
> >         if (status & ATA_BUSY)
> >                 trace_seq_printf(p, "BUSY ");
> >         if (status & ATA_DRDY)
> >                 trace_seq_printf(p, "DRDY ");
> >         if (status & ATA_DF)
> >                 trace_seq_printf(p, "DF ");
> >         if (status & ATA_DSC)
> >                 trace_seq_printf(p, "DSC ");
> >         if (status & ATA_DRQ)
> >                 trace_seq_printf(p, "DRQ ");
> >         if (status & ATA_CORR)
> >                 trace_seq_printf(p, "CORR ");
> >         if (status & ATA_SENSE)
> >                 trace_seq_printf(p, "SENSE ");
> >         if (status & ATA_ERR)
> >                 trace_seq_printf(p, "ERR ");
> >         trace_seq_putc(p, '}');
> >         trace_seq_putc(p, 0);
> > 
> >         return ret;
> > }
> > 
> > 
> > Which is just a re-implementation of:
> > 
> > __print_flags(status, " ", 
> > 	{ ATA_BUSY, "BUSY" },
> > 	{ ATA_DRDY, "DRDY" },
> > 	{ ATA_DF, "DF" },
> > 	{ ATA_DSC, "DSC" },
> > 	{ ATA_DRQ, "DRQ" },
> > 	{ ATA_CORR, "CORR" },
> > 	{ ATA_SENSE, "SENSE" },
> > 	{ ATA_ERR, "ERR" })
> > 
> > 
> > The major difference between the two, is that libtraceevent will be able to
> > parse the above and convert the status bits into strings, whereas using
> > libata_trace_parse_status() will just give you a parsing error.
> > 
> > That is, perf and trace-cmd will not be able to parse it unless you write a
> > separate plugin for libtraceevent to do it but that means you'll have
> > duplicate code.
> > 
> > I know you just want echo and cat, but that will still work, and this will
> > make it work for the tooling as well.
> 
> Excellent point, though in the case we are interested in for CXL,
> __print_flags() is not enough.
> 
> We have a mass of fields that only contain something useful to print if
> the valid bits in a mask are set. I just pulled that example to
> show how trace_seq_printf() could be used to achieve optional printing
> as opposed to current situation where the reader of the print has
> to interpret the mask to work out if fields contain anything useful.
> 
> To do something nice with them in perf (well probably ras-daemon in
> this case) we'll have to parse the valid bits anyway so effectively
> write such a plugin.  There we need to do a bunch of mangling to get
> the events stored in a DB anyway, so this isn't a huge overhead.

Given this information I think I'm going to punt on this and take your reviewed
by on the code as it is.

We can certainly try to change it later but for now I think it serves our
purpose.  Better to focus on getting the code working with irq's.

Ira
