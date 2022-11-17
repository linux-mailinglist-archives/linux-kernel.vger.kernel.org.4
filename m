Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA362E2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbiKQRWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbiKQRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:21:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6E7342E;
        Thu, 17 Nov 2022 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668705715; x=1700241715;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/U0J2ypqVQspsvF0N+kofcgLnytTswS40sC4fzc2anU=;
  b=AVDVjP9scbPE3WVftxYzsqFXJ2PE2GOOZPm9rvCU7QBZ5loS/TFNi/Zt
   uDWEIS5VQpB+Pob84pXKG0TOYu2lCKkOA5mjjOq+FSD1QIRPDSHpjM4CP
   Hl63w62XSE7zkVbHTALSZwSg+3ip2tJELH4UATx+T3CV1frtqGPiBp7r9
   NiD/zlis3Q7UE/C6dhsaxphNBXNbavY6JKoq/1MHjVmmqBpoYvIv0a4zP
   LtZKat/eDZkCLqJXjS2QNxAMHSMYdogSOc+uqo4Ea9jGu1E2OmNGu+Sps
   HIaBMX3hb9/OxLw489P4ZdrSy97PKz/UQPNSk+++E0PY0jF5qTUnre2Lq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="314732799"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="314732799"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 09:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="639885894"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="639885894"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 17 Nov 2022 09:21:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:21:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:21:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 09:21:05 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 09:21:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xrim7oL+BlfvJjh/19kdrw+EwrMotmy2UdPUIKjk2W9H9M04N59WxHvPyd1Aha+PxtOC0tegTNZAUMxrmC/VJsuo7kesWODLV+GjMR+8kn/JdoHhmEW8oiy3n7DPssw95qIefxty4D0qbCr8VNs1JAQ1lsguXF5QJQTEZnn8KwYPanX94KdYe3inbPCxlQndy1Ptn+dILzXm5eSJUhdKdm3RzEyHq/gzNnrEcd2m+fBpgBSp3s8EWQuI1UI2mfjkRdGHRYF2XKnSR6VO1Fwlr+xs7EdKjNVp2mQjolE4dXmo2ckpPS36XMntb9+W2/X9IFm1Qgc9q38SmO9V42gPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnauU4Ik7Hol9zxbRN3eTIdr+ecwzEwN5Y+s+ezl3qE=;
 b=JQqSBsS0qKkbYQGVCMFjXSw7qvQpoxdD6ZEoiPPikSYpHGvWDZXNKdTQwX03iND8tlxK6oJ1ebxUKkhBxQIXlR1pZ+ofD6iyn8BoqU3dAGoRdaOXSBO7j7R8ojk7A3h3m7WjFEI+vkrm+AQX/jQ17CytUQU/ySgwtoQ8Hh8Q4uClGZV5eBkw8lny1BCi01viC9DXaAAuNE3UPS100aNuXFsT1E/pEMlgOqtzodBRYhSHRUXYURD+IOh1wIzbIv0+AFb5qdwY1szWOj4Wkj/bYA1qnr0ePY9DIj9akD5edhiEakjFXC9awwZk4ZO1/VW7xlCn46phoLfOC7fDPO5AwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB7398.namprd11.prod.outlook.com
 (2603:10b6:8:102::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 17:20:59 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 17:20:59 +0000
Date:   Thu, 17 Nov 2022 09:20:55 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3 2/9] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <63766d77d1ece_12cdff29499@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-3-rrichter@amd.com>
 <6372b35953580_12cdff294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3ODbwk+12JvWyhJ@rric.localdomain>
 <6373d24866bc9_12cdff294e3@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3YoBpIsgRRbRyLk@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3YoBpIsgRRbRyLk@rric.localdomain>
X-ClientProxiedBy: BYAPR07CA0098.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 367393a5-21dd-46b4-fc11-08dac8c01803
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LdHmMCC4NmvASsqvgaK3aj22s45CnwQjBg7PcAdoqaRH1MK5hthziqrktteAfeAtj3m43aDtba4vS8MOk7Z5EcnHP8lHMGWQSdjaRprVG0zENjxdQpwIF+x2ImmDx2poXOfo/7gZkSCvNMUDc7biNtDjYsvHb6FMGDRsCXi/JSHBm53xBUe87WizTNs+m0IlJu9PXBKhCpj+zI7aC0SeRapLsXvliTojb/K7yfTRYa5xnC23yWhMV0Vw2mKnwUCK0yRs828Xpu7bosrySRBkQXVITcoCbmbAaBq9Z75xeXKSt327l2Y0no/Wz/uTc20viDpKrd8wERusvCk8kna8ZdQlyu6koraGmIqWrDZW+dkbxcY46/gmI5/wyVyYI3Z2kxZYKGdJBCKh9ZYeyrM/m5XPKF49In6r+6AG0laV5yyugyNMiaGskBOwJwSi6dEnPxsgkOlTlJ5tg0PD1vRQrwe6Zs96aIzdwgbJ98jBch4+revLMpZym4qUbNYdV5PAYPteSnv2dYnq6J+YWo/7hdbJYLlwGrWcwsDDYJl4cinlf8c1fbUORqbZJ9+w/YX6QJ9j1MfHN0xBY9QZwTfwd2dTkBP0YpxEzNeXKp4Y/zd4aygfAJxcS6RwH6lAqmgfCcO5KO5NcA+GeodLDBejg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(9686003)(26005)(6512007)(4326008)(8676002)(7416002)(41300700001)(66556008)(5660300002)(8936002)(186003)(66946007)(316002)(66476007)(82960400001)(86362001)(2906002)(38100700002)(83380400001)(478600001)(6666004)(6486002)(53546011)(110136005)(6506007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V5bL0TF1oHdSdttDWSOq30gVkOYTbF0x5BSwnrerzqbRNOzW+aB+RXipZGKY?=
 =?us-ascii?Q?F4og7yx6nwA/6Z0kCh5vsaYlHkVZCTqARW1Jm9A5sLEl2zr9GWKAtW+SgqbI?=
 =?us-ascii?Q?czYp2eaXY5LcZINlpCsaR3Baeu8cJQb8SXQo9dynwbWp6lNbk8rloRxORKYt?=
 =?us-ascii?Q?I6rOUANzlDYj8EoTM8YmhZ3gydsE2L70DZ2lvyItLHcWVDDrltB6zh9acN5U?=
 =?us-ascii?Q?1i7YMQTGkdek1L26egnnMZ6REKeSMxOAttKPPX+FljEhBQVWZIcBpWj5n32u?=
 =?us-ascii?Q?wW4RXyQwYK5YCx4hwHxH+xwk25+nbg3g3IeSQIdb/VGgxFm/UQuu/P7VwTlN?=
 =?us-ascii?Q?MIe6pdO0TrWGze8FHX9YrWGKGUEZeoopbmT7sqBMdrn1zqNRxcQqcczrWkge?=
 =?us-ascii?Q?c71qyPEFCo5ocIz7WF5O19A2TV8y7IWyraHttkNwt1lUuPRaHYyAVYXdg4+W?=
 =?us-ascii?Q?K/5meEppUb9kUY3OAsfHHBI7bF00fmLjs4zb0Nj/3MM1bnk1Q+CIW00b3cH6?=
 =?us-ascii?Q?kOmS74ONoXahDQofcRhZ2LiyimpEzQqJFwMpJF/Ug0g2sqclibj83nT91XNp?=
 =?us-ascii?Q?ZjlBneUjIzj3hrZxO5EKShrdzLooek11IZl+MrxcmKHV73WF6OAZZlZp69Hv?=
 =?us-ascii?Q?x4tU5d6MOFNz0koKcc4L3LlZcU8n5WiED1Cb2WiLLES/JN7XxV7ld3rQWehz?=
 =?us-ascii?Q?vb47Dyn5UVq3u5D2KTo6kQVJlbvWyabxABxIpBARvVezH5zuDBV6v8wfBOik?=
 =?us-ascii?Q?r54hT0liWUnIWHyu+hvAvK6yFnvKx98BD13Zk8lGDbLCtOGbuSpPvCadSiIe?=
 =?us-ascii?Q?sH/oq8POLJtVte6wrtXYrfoB7HgznCLLa2SYEMykKYmQ0iLiHu12GId5m2gk?=
 =?us-ascii?Q?X2nugwA9WRZlybS/U5wglzkBG62YNJq+jVDhtUyKB4NR9rHrg11nMgw/bbff?=
 =?us-ascii?Q?3Tpv5vDdrL3+HpAyFSLIXVdGlJNHjK1qCn4oLAECyfcNjWp2DnJe3WNy3U7U?=
 =?us-ascii?Q?v+xLpdS5pjZd4imVS0xeurTmMiPY36VauRGtLriNUZiopVpom6yCabx7dPuC?=
 =?us-ascii?Q?9nVdKbqx0PU6kog4WhxHFedzfG7Z1qTMv79zh6lR0wZU4wKc+WRxeq0qJaEP?=
 =?us-ascii?Q?MEQPQ6HV/ZoKH7s7xHChSuL50tYvKlq845D2w1/DprU6RhWPNCocG8D0JIuQ?=
 =?us-ascii?Q?Qi1PWk6mXBud1HiHwxe5LphhfYTlVC6T5cR0Ct9m3fNIuk96qNSbEOmjKiNp?=
 =?us-ascii?Q?MZOInb7fSKyExZi/BcjIb4Gb7PbkblnfO2YZki332zUmuo2tDnUtNtZ7NCEC?=
 =?us-ascii?Q?WnUCtwh7VXRAb8SIp+MBXBptTP4blG0vukh3NV1odzsrAv32GMWfN6l2Y+dS?=
 =?us-ascii?Q?OnhQikCSOA7m2ZlDVPZLhQM/FovTj0Xoh1rG5i4DFPBKiTyjpyI8rMf0WnGg?=
 =?us-ascii?Q?gr1FkHisAFSmm0mF6g69R+FEMo7nqVBAHENIp2FwP8rKlhSoHLhrf1YjlZaT?=
 =?us-ascii?Q?zXDBUT8yHT6AmKVl2Jae9seoWRmBbdm4xynZV28FV+VtQ5hMIysqccmlan3+?=
 =?us-ascii?Q?h2ApWhMkgA5mbwF9jIPRqfYqHNC3h0pltAQRkq7hzgtUJ/GM6s5n3o/f0WuZ?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 367393a5-21dd-46b4-fc11-08dac8c01803
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 17:20:59.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlwastZGjEa+50ONqOP48tpjdpyXhOYY3synAVNHmErHi7iirn8QaWYZ6d88SUO1IN/jsFSZdpg/Sog7QRF8tSGLunOnTIJT6525/KANU5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 15.11.22 09:54:16, Dan Williams wrote:
> > Robert Richter wrote:
> > > On 14.11.22 13:30:01, Dan Williams wrote:
> > > > Robert Richter wrote:
> > > 
> > > > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > > > index ec178e69b18f..7a5bde81e949 100644
> > > > > --- a/drivers/cxl/core/regs.c
> > > > > +++ b/drivers/cxl/core/regs.c
> > > > > @@ -307,3 +307,49 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > > > >  	return -ENODEV;
> > > > >  }
> > > > >  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> > > > > +
> > > > > +resource_size_t cxl_rcrb_to_component(struct device *dev,
> > > > > +				      resource_size_t rcrb,
> > > > > +				      enum cxl_rcrb which)
> > > > > +{
> > > > > +	resource_size_t component_reg_phys;
> > > > > +	u32 bar0, bar1;
> > > > > +	void *addr;
> > > > > +
> > > > > +	if (which == CXL_RCRB_UPSTREAM)
> > > > > +		rcrb += SZ_4K;
> > > > > +
> > > > > +	/*
> > > > > +	 * RCRB's BAR[0..1] point to component block containing CXL
> > > > > +	 * subsystem component registers. MEMBAR extraction follows
> > > > > +	 * the PCI Base spec here, esp. 64 bit extraction and memory
> > > > > +	 * ranges alignment (6.0, 7.5.1.2.1).
> > > > > +	 */
> > > > 
> > > > A request_mem_region() is needed here to ensure ownership and expected
> > > > sequencing of accessing the RCRB to locate the component registers, and
> > > > accessing the RCRB to manipulate the component registers. It also helps
> > > > to sanity check that the BIOS mapped an exclusive range for the RCRB.
> > > 
> > > Right, that is missing.
> > > 
> > > > 
> > > > > +	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
> > > > 
> > > > That PCI_BASE_ADDRESS_0 does not belong there. It ends up being benign
> > > > and forcing ioremap to map 12K instead of 8K, but it is a
> > > > config-register offset, not part of the RCRB size.
> > > 
> > > Note this is BAR0 + 8 bytes, not 8k, and it does not map the whole
> > > RCRB region but instead the first part of the config space up to
> > > including the 64 bit BAR.
> > 
> > Oh, sorry, yes, my mistake. However, there is not much value in mapping
> > less than 4K since all ioremap requests are rounded up to PAGE_SIZE.
> > Since an RCRB is only 4K per port lets just map the whole thing.
> 
> I was going to keep the ranges small to avoid conflicts with other
> requests for the same page (though request_mem_region() was missing
> yet).

What else will be conflicting the RCRB? Linux has never accessed an RCRB
in the past as far as I can see. If there is a conflict then we may need
to move this mapping to the PCI core so that it is managed like other
mmconf space.
