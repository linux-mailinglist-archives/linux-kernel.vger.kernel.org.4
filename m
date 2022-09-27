Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD855EC930
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiI0QON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiI0QOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:14:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0C959248;
        Tue, 27 Sep 2022 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295248; x=1695831248;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BUY/tWEMIibp5jLDeSdMmalogpr1s1aSlqzdi+ebuis=;
  b=UzRKX1YWQgBP1xCjHerSTHQ2H8lW+55+TaErIQbR4tcAEIL3V/z0oX/m
   HWdx3OP0a631WJgpKHYf+smLKpuKOnkJ/J/9gKbIAl2lUTYqdex2ZNa15
   MStcM91Gczqe18hGUEdtfdxxg54nK1OL3rqYxqv9hxaWrS3xDtsyPlGkI
   w4/KSq5s+BXgZmZCl3EFlIwiIMr9JqJIKzSspBMNh0n25Mgn5FkBMJXHy
   3xtw26wqyqh0xEsSlZZ1i26AcbmKyvidFr5m6+oHrH2Y7zYSBeuIeS6eQ
   fnyUiO3fs2vGhiRwDEiK29WQBgKguaDYgQAIw4mnnqvjrDHCpSjOsXY5B
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281078633"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="281078633"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="690048921"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="690048921"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2022 09:14:07 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:14:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:14:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 09:14:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 09:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKsMFIVNxPr1pPvAGRFfy1UVyMEmh3mGt98Ep4EEpsXtSInVeU9WOi67rCKcElykFty9WkBwapTm6Llnsb4lDi0I+QUH/rYL1pD/Z+bP0ayR0cnqA04L6jGRi48E3pdqdciEr9GsAW3Wx3HcEIso9/nnaTiPEYaoBHvL2Pwe02eeSYztdCiUT1hA6m09mX3gnTH5W+vEbTxlmrW4acEnxeiBIWSxPSH8Ja7Ba+dzQYG9r+9A3eU8RXHdweAQCaqTLzBJzojblc7Iy4EtTFtrxeHXR2/02u78/lUlgt9obSB28gJTnWNv1WhhzOx0XviYwCZhidk0cEJDYPA1+Tx8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1v56cTLzrNiY2reR7+qzhNT26LBPJ1sqtUwqmeJR8Q=;
 b=du+aEYpnOPK2p84MzZOkx4ge5Cz6IKN3BIHrIa5sl1BAiLD8evVpYKf0TR5z1lhvrXRdpZMDLIw0t0ApWCd4e894+axay10arutauCkCAFy2rGZw3A46bjkYsEY99ff6fc4zRzda9mcMYVRHXbAczR3407oe7/Cha4iD1WEEFwB9KQxrCpQBQ5W/zeAHKyLsFMsSulmL8iTFqheV/nayrtsibEf7IQXX1oNFv9CUSlhkv//50hPqGscdpt4wVjAOv6Ixocy2+B3rGZ/2e9lk+xr03yTCLpVkg0vY58QuF24F8T2r9YHirqBGJy6QRjRClR0JOPVrVTQxhaIYZsNZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6960.namprd11.prod.outlook.com (2603:10b6:303:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 16:14:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 16:14:03 +0000
Date:   Tue, 27 Sep 2022 09:13:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 7/9] cxl/test: Add generic mock events
Message-ID: <YzMhRh276QxjdZM4@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-8-ira.weiny@intel.com>
 <20220825123119.00000705@huawei.com>
 <YyN0qY5yaXwTwLDF@iweiny-desk3>
 <20220920171748.00001260@huawei.com>
 <YzIcKFSRtXHiuG0+@iweiny-desk3>
 <20220927145623.0000040d@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220927145623.0000040d@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdc1876-8546-403c-6243-08daa0a34b54
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIwJEKrl8EAdqR/NiZwCAGPAzDTKs9UpJdG90zZczguobpkBfg9Jy0SV5bdsCOIoZYGG2snrMyKHHvo4QfZd8D2dqjvAGq2kKGiUhVzqSJfkYRkQ7SHmaf74PhhfF+zkkH9YknNN32X1m9mSDQy/3dDHlfNp9xrUnZr4blpZAEeLPR1Ctk89RDq70Dx0QYDywCYhQdkbf7f+rpfQm24GCzTfwYDv6n/8nP/K4qwVDt6oSqsftR1EhfcDgBaW88OKGG+X7dppe8csGjt/6wajTONYtjDhZsfRJf3UT/ZVJ8/H+wf6SJ8KFzkSujkm0XkhMj12YmuyvLXYxbbxDztfes3Tjwac/YB8ztZleu/+ckUE/dJ0u2WYMgYUhgwBDsFbOpKGkvVghtLFkM8kC7j+0YJo+88D4HxegNnOWEDu0+LamQMFBpBR3ZH70lqDzQGRyKkmgsJqSlwA/v9sqaIsl/EsZLsErc4PBSKSVGQxk52Z6jCLwYMmjgXv/C3vRDIQp96cjMm0Vg+gHnVwIswkeQp/V5DAHJoKPF+2SESueBVWyq2jGNB0gvLYX9HbeThQXEGVffaGlL+AksaMXuJ/Lb58nTiDhrGXNJtzXRZnWY6wdbwFQSR++pIFAnr2HguSxFN8CqiI3ksfGxSMlQJWrDrhlWA/8OZgIak1UskRQhedfWL12RrQoKsZ6Tg2s+CrSmHzfMcGhWMTY58K4dyFnUqD4iRM4SFoChtWv31TlA44YwIW2pPk8tPY7Sb/rz1Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(38100700002)(6486002)(82960400001)(478600001)(33716001)(5660300002)(2906002)(86362001)(186003)(6506007)(8936002)(6666004)(66556008)(316002)(66946007)(9686003)(26005)(6512007)(66476007)(44832011)(41300700001)(4326008)(8676002)(6916009)(54906003)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LqxpmU3YWfDVMDe3i7d6uzTTKFSNksDKocpKcWYJDOehWy41UrMmJyGmU8yj?=
 =?us-ascii?Q?RPXu4Av2HzCt6pOd9eXVCyW2TKOOzGiPuG+qEYAcsaXAdbS8GJPLC5YSwPwu?=
 =?us-ascii?Q?urQD0lZPBQ4IlbeLWfRrcsYmjMvCrYqOSKLIZsRMjiRbiUn4sTXW2nhK3Y41?=
 =?us-ascii?Q?ipRdlmaLTRqXfIVPK2nfbilDhWlS+ggL/GOVy94Y71cRcbjDUDWT0VOZ444f?=
 =?us-ascii?Q?R2fA5iALq8cteBZCXzSkhF0upIsy6UIdbKGfzVMR8JbN7Mqims+hEXrGUj/C?=
 =?us-ascii?Q?fYHfILISwnoPttCRN/VoMgX/Z9xA3VOu4XtH8koyU/k1eGbkNcXkrrnEIGpA?=
 =?us-ascii?Q?F2DBRyRZrZ4SC2dlSS9NaokWb17DFaIeAFmwisHSOlbK6OEMBi3RaXSSxVAB?=
 =?us-ascii?Q?1kiRiZcVDT1svpfdp5L08hGfuCPak11/mPAh7xXoB9Nu4iTWDwie1AIPmpjj?=
 =?us-ascii?Q?SsZEuMZDEAPL4CTSQ2JEA2fn1RRm+01jV1FmGO+Y5cyXZXTAsTdhRHfyDJzi?=
 =?us-ascii?Q?L0vcUdJihGy3i4iOubstotlALpQ1nfNQrINQ7N6VP2lkhO8dLxmaX4hHTrKk?=
 =?us-ascii?Q?Lulwn4G+8njpKc4No3WO3lIAtBicnoJCTvqQnBMeZC7LfeNjq0Ub8o/8NJpW?=
 =?us-ascii?Q?4quy2wL8A8ttmeWz5G+KpsVeWhnDxlMEq7JVLV5TJqQ0WyN0ynhDHOAJwFo2?=
 =?us-ascii?Q?sLz9BKYFLCBeOtfts+to6Hc8epY13jK6YN7bsAjhWu50e6nII5rgxQS+wcKo?=
 =?us-ascii?Q?LmWEmkejdxsn6i6Lksa5CP7MLCTTdDbnXkxdJmupBjBzQP3/CFMxdi6dSrHn?=
 =?us-ascii?Q?eIyRbB6ee7GWz7mvuDb18mpdKoZH23q6hzxKpr320/7779lJ5buPqsFMVIpS?=
 =?us-ascii?Q?3dPLN12JMNSWBNrBqJcIK+8VMoakYX+xVJ8hq4Pl3hBxhgZo6gEMaOO9Q23d?=
 =?us-ascii?Q?XLykgLRUUtKYCpVluBZNB+U6PD7FYJ5+G3DIM3PGBP6FBnaKlI5Alo+1DlB1?=
 =?us-ascii?Q?lHg0aLVYXSF8QIghOSF0Fl0lD6HctVjoPIRUbJ1Eg+1uRadYqeERbuMyyuBO?=
 =?us-ascii?Q?Pn+zs/+dvCWemHyYrT7QBPgJYzYOj6Dv0bnayR8ViDbqSr1o0MPqfvGx6A9q?=
 =?us-ascii?Q?rklmGV5h8GDg38X+eMNg4RzpLc6xu8wOEP5BueXObcsI0nBVG3sEhmOMV9DL?=
 =?us-ascii?Q?btNp6oL0kr5zAxkHaA2tW+WPBJ/+0yEZ8oVWBVjOLuJDEXhbLw2W1G617n8Z?=
 =?us-ascii?Q?/vQONDKEnGrJBBbG1LPeSsohc8O4/QY7P3+wdNp42Ug2sKCpiWdi2lvTeTZB?=
 =?us-ascii?Q?yw01vRSYtjXXlSSb6X3HQ1d4MqsrPqbv+sG+x+os2f7CLFxZa7tDDTWQVQBb?=
 =?us-ascii?Q?v2KBBeAJ6aSxQArFP4DRyGJhJ1ecqcR+LKQ5qENaIxhLrpk2jwji7Y5XHfOH?=
 =?us-ascii?Q?zTBBRRHsyF5SaMdbK1I8XAe/hsoWeb6Y7ApB8/z674cop3N4bg0jisMUXiZa?=
 =?us-ascii?Q?OqInTgYk11t+nqvGNAe2Q/qzmIwZr2IkvR3NJx87UGoBFFPW0yz2j0gRI5+A?=
 =?us-ascii?Q?USF1Usl+6ZIsTbrf9AFd8uYNSwAr0Y01it4vY2l6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdc1876-8546-403c-6243-08daa0a34b54
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 16:14:03.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwv2KnaeA+AesgvjPLAwX9RAhogPbgMRfL80rWDLDA8rFsRCv0cMZ7r0ISkDrYWeIhEDl0QJRfzRAupHOy4Qlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6960
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:56:23PM +0100, Jonathan Cameron wrote:
> On Mon, 26 Sep 2022 14:39:52 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Tue, Sep 20, 2022 at 09:17:48AM -0700, Jonathan Cameron wrote:
> > > On Thu, 15 Sep 2022 11:53:29 -0700
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > >   
> > > > On Thu, Aug 25, 2022 at 12:31:19PM +0100, Jonathan Cameron wrote:  
> > > > > On Fri, 12 Aug 2022 22:32:41 -0700
> > > > > ira.weiny@intel.com wrote:
> > > > >     
> > > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > > 
> > > > > > Facilitate testing basic Get/Clear Event functionality by creating
> > > > > > multiple logs and generic events with made up UUID's.
> > > > > > 
> > > > > > Data is completely made up with data patterns which should be easy to
> > > > > > spot in trace output.    
> > > > > Hi Ira,
> > > > > 
> > > > > I'm tempted to hack the QEMU emulation for this in with appropriately
> > > > > complex interface to inject all the record types...    
> > > > 
> > > > Every time I look at the QEMU code it makes my head spin.  :-(  
> > > 
> > > You get used to it ;)`  
> > 
> > I'm trying...  :-/
> > 
> > Question though:
> > 
> > Is there a call in qemu which is equivalent to cpu_to_leXX()?  The
> > exec/cpu-all.h is having compilation issues for me because the
> > TARGET_BIG_ENDIAN is not defined (it is defined in a meson generated header).
> > 
> > So I'm afraid that the tswapXX() calls are not what I'm supposed to use.  Is
> > this true?  Are those some sort of internal call?
> I'm confused.  There is cpu_to_le16 in "qemu/bswap.h"

<sigh> I don't know how I missed it.  Sorry.

> 
> I suspect we've played a bit fast and loose with endianness in a few places in
> current qemu code and should probably check all that sometime.
 
Yea nothing in hw/cxl seems to use any swapping.  I suppose only little endian
hosts have been used thus far?

I greped for 'ENDIAN' and found the tswap* calls.  I guess I should have
grepped for 'cpu_to'!  That found it right away!  :-/  :-D

Sorry for the distraction,
Ira

> Jonathan
> 
> 
> 
> > 
> > Ira
> 
