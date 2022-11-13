Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403C7627027
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 16:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiKMPPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 10:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:15:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B31007F;
        Sun, 13 Nov 2022 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668352518; x=1699888518;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gnzrxdena9XfUM7vNs+RUR2yYoSK3ObfLXzDPDWt6XY=;
  b=JhBHbnh3fPvxqq5suHbGopQpWG/IWgUX5bqH1qSPocG3KkrkwMs2E5fR
   lkHqD1mlfmQj/WOdKTPjawkQGj2vOsrM9lzhIAoPZLBqrizM8Uqz/NO9U
   wrRIPPU0s4zgrvLBdh1fev7sIGty5VynaL4rK/Tgk+ZbFSNLLIk/7u8zx
   bI8nJxTA654TuPBXuykfEgPy0dT6XO0ammwv0rXDVmo2HlVr7kwlmd7Kb
   YfMTRawiSwjo/s5Td6IqjKjF4SdUjs0E6DATOFLIrz3GcXHVuyhPhKIma
   4GSjv0/7j1fyov6mWbHJ2lif9V7dkHxZrUrvCWhDxfYt/8VplQwkyKID8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="312963657"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="312963657"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 07:15:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="743827879"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="743827879"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 13 Nov 2022 07:15:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 07:15:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 13 Nov 2022 07:15:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 13 Nov 2022 07:15:13 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 13 Nov 2022 07:15:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvdRVGlkVbmgNPYvAXyCMsp4JOmzDe55jfqUSk56Ck2MNqzkr7lnzvfiuAhk7SM2jySIz3kTn3Th1DcW2NYEpXAEWkUp+F+fG9lP6vlPJH+M3MaMIYIYYkfNY3gPONKcfxSiE8x1frdkRrohZVR7VSnfuepv+8zPPSF3mVMLzu2UYEJvtUwMuQFHvchWhq4bMXMZ+u4iNQ4/9P6/l+CoVtYqq/y4lnOyLMlxWzf+VYGnc650niJOWDNaEawg5LK7EfSf/y+/OdZmave2LgwqLWJOLghzPju1jsXweyzSkdCRw9r+AQ0tQwK49Kw6vm0PZpIfajn4gRi+n3hD7HSOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8XewX7q+MIeEk5a0/CbozPQDLspyPlscTtLLcO24pM=;
 b=Ubpcn5XvDww84rTgaqfiadE26KnB/uphel38oAjqI37E8gn5/NhEoKcZ80OSRA7Vm+pXy7AYVosUqA5UPhF8qBu7VbgJdibj7qjdXi6LowpFoIOCXF3HKjHb7tfd2Cu7FQhFth3sGvBMKYKFE/TDv54nUArVrx+I4QWldBMwl61SGvzmwOJti2xyEVSXh9TZ/9vNjIkGxIwtKitEAzAkpXJVbsfjhwIuZK/GbzMVQOo4uAtZ1y2qeVvfU9VFR3Ugbh+koEXJh/rVmeX9aQT5hfQgJzFHb+YrCK3aeYU/pi3Yz/jbTtiI0+vHCWZk2j1H3ggZ2Uw6h+NSicTkObAzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 15:15:09 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5813.013; Sun, 13 Nov 2022
 15:15:08 +0000
Date:   Sun, 13 Nov 2022 07:15:03 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thiago Macieira <thiago.macieira@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y3EJ93xzgC/1v0WV@a4bf019067fa.jf.intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com>
 <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3DZmKYV+8HBtZ+Q@zn.tnic>
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CH3PR11MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: c375e1ba-2908-4bd3-facb-08dac589da17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4g9iC9msgWPmgDH3uO/C16q4SYubeG3xBJHCg5XGvf0jYnbc6xEIsjXrX2cANHQmOsieII8A4DIS0upFXOmt/Kv+6PWndjyPhLyCKTpNVlrXWqxYH2s62HpvDWnCnPFthJxbdyRIWDknYvgWRgnk8yr1+AYEaMhzzKDELDJ7wKwG7iyzasuV5nYJFEq+U0CM4MOYW4424ae6UXX+r4hqumzsJ9If8se9QqfJOhSo5IfnCashHLiC9kU2ixBu/+J0DWMBll2JUTfGlVvwcE1XAb70h8H8wRw4fLSiMsPS7aY/TpBN1TfSDFtundtckAW/vGRxdqxvw2eWHVUw202NuMhNhrCp3rBuGS4i96flXN1BHlOCz2gqV4F+Lufx7OWt7X50DX6QGAnGQZU4RGlXgKderpFdku22p5oTRoDLvGamLQsW8H52e5JdqPVZ9uN9omKB3Hct28ijzIMz89rPpdx2p0FWhZNBMbdpFbEe+GDm174NPm1STbN39JZxU7KYM3Jogfq4e4QyZpAR/5oEi2pGp1LpO5r/IOMyNtNCbLTpxX/R1UgY6JOgUuj4gg+kz5hbK3/Vxqfp1dpCs5CXzw5+p9yE0Y2P5rhNEFYqPuy/gl0ZBjJIJD7u3xS252kAep7mbdiSD20xX7Y8jXNnqACTMu13+/zZ83VRyW6xg/+NjEKcOqse13zlpzUd7uKp3VHjTPr2SqcBMuokE3CqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(86362001)(41300700001)(66476007)(8676002)(6512007)(66946007)(4326008)(66556008)(44832011)(5660300002)(7416002)(186003)(478600001)(6666004)(6486002)(8936002)(26005)(54906003)(316002)(38100700002)(6916009)(6506007)(82960400001)(83380400001)(2906002)(66899015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BXhwtjXA1nNuuEOL9GdXedVsFVGfiTTMykI5h2pYq8btdwIkFNgLwZGq03W5?=
 =?us-ascii?Q?BkPAj+Ffpzwv8J8AmFc1q6GPWtxqyM6Z9Pdw+KgdEzKnpUJTzkYF6YAXqFgk?=
 =?us-ascii?Q?wVSA/nemACFmE4q00bw8YsuVFP+RvQ+i2QuPFjtgKyjkF2rhTdyT5SbUjlyf?=
 =?us-ascii?Q?lKUNetN1C10K4P6MA/269rKxAjWoG6Xk1NFKmxHpvYY7LERGdcPF1wIjvjE8?=
 =?us-ascii?Q?Npqb2PVxW1Vr7cXeTyxl2f8D+B2LZS8xi+CYNCq7Lu+DviLHpT3uxzLUBA5E?=
 =?us-ascii?Q?7raRwawDNNcr4MPNxu0aiKB/rCBSAIq5CXYWUQCSChZvuNyIrI+BZqKbT3L5?=
 =?us-ascii?Q?Cv2+gVPQDQ1G9PRxxWcNf/uoJBSa9Lr0R0t26X1L6B8ujOUYitlitdXbMqO0?=
 =?us-ascii?Q?dwFDsIdPlMctDcKWlUCVzEi6RmEXucfM//IiumOUMuR5XK9FHg7p7pCbWNlQ?=
 =?us-ascii?Q?wHoX9e+4Deb0/1GBqtIMJN59HGN//VONbNbL4SHDIjPIH5hWsLNJ+0cCO8QH?=
 =?us-ascii?Q?Zn/0kfwwa/psxBSUASgUcO7Q8aIfrylOXnNYygrnziyiU7fk7A1MWib7s/ul?=
 =?us-ascii?Q?eiPZHsKYb8ucbYUldBOuBqd/+CH1RHcN0kN7Glgf3oYYdYayzjjewY18bkmN?=
 =?us-ascii?Q?4bac6yz7xbtoa1f8Dao7liO5AyDNyoOrYYeFUQ7zN/Pu4Mt2lyt/7BI603of?=
 =?us-ascii?Q?9Hq+b9xOQucO5QcNGwmOZbS+uO04WWvmRTkciPPCZsq3rHauD6d4IxyX5eGc?=
 =?us-ascii?Q?x/WX8pSJ6GTBe3+f6aZZvXBLvL5AUrrjTSDhvzKjBq5ODI61Msjwuzon9A90?=
 =?us-ascii?Q?0pSbTs+woHj5YugzOSbf20ItyWWshczCgG2Vpu8SwyzAoHToy6g5fcN3iVlL?=
 =?us-ascii?Q?NcaHF5d0EnbPWU7gDfiXx/cKnwsFdrkMX16BuCcjskN/TUU5NrC/iSpkQPOE?=
 =?us-ascii?Q?GOZB6FL3qNf4sjDTPk1wANXPw8wcRMfkWc8mw+Bvg3p3pdwL2Jk/x5iv5Xyb?=
 =?us-ascii?Q?7l6C3Xq468XCRP3Um0vWgza6biGW0tEVnVatd0mVj4nQV55l1pt5A3JXg5pB?=
 =?us-ascii?Q?WDnKzn243x9iK01sydMeslaVbP61dG5ji4bB9BFhxTkdpaI/nQQANzMeI11t?=
 =?us-ascii?Q?Z/3dM/6X+PTzXaUaGID8sXnaj47a3Kc5TlZkJ/AKEPZNBXkFkrwRG3LqBqfn?=
 =?us-ascii?Q?BDezntTFuBXfAN8PJf8vVbfhusYvMzQkXrQXo/SJOAf6wzVqzR61hBBSK9g1?=
 =?us-ascii?Q?IhHW/HPjhffBnb3KnSRgxD4ol3KpcZYBFG8S/1taCQq0T7jpyqyMlVIaYAuy?=
 =?us-ascii?Q?b0/NP9fX0MNP5HKRA9kaQ1KBvEjvsOR+tG8OA1uF3arZrWjaCT0M2K2hRjZw?=
 =?us-ascii?Q?nU1Uwp9JxJdQOljEdKWufKOYdr5nZ1RmdGMXY+UYC81exKVCb6GuR4cMexqX?=
 =?us-ascii?Q?c4AjeCbDfxjBGdq5YQCFclucWI10s/XGzO7krcDYOO4wJL7Msd/TXooMFO18?=
 =?us-ascii?Q?pae5LYp4c+5ThD8OAJJj/FDxCv5e0thHQzr45LO5+QTxKgmuBfxBvqugq3Rx?=
 =?us-ascii?Q?sV4zZ4A1tqINwQotBWBpsos/NZY0MaYj7JSGsCQI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c375e1ba-2908-4bd3-facb-08dac589da17
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 15:15:08.8572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi/0fo8XH6TvY8OVZhtqV2wSrU/7diU+U9/KbLaj5Hotb9Gix0aZpxfw4Niudk0/I8H2arANgGdXgQesFrOeDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 12:48:40PM +0100, Borislav Petkov wrote:
> Replying to both with one mail because it still feels like there's a
> misunderstanding.
> 
> On Sun, Nov 13, 2022 at 08:37:32AM +0100, gregkh@linuxfoundation.org wrote:
> > No, please do not force the driver to resolve a filename path in the
> > kernel.
> 
> No, I don't mean to do any filename path resolving - all I suggest is to
> echo into sysfs the full filename instead of the number. I.e., this:
> 
> for i in $(ls /lib/firmware/intel/ifs_0/*.scan);
> do
> 	echo $i /sys/devices/virtual/misc/intel_ifs_0/current_batch
> done
> 
> What you end up echoing inside is only the full filename - *not* the
> absolute filename - instead of a number. So those in a succession:
> 
> 06-8f-06-00.scan
> 06-8f-06-01.scan
> 06-8f-06-02.scan
> 06-8f-06-03.scan
> 06-8f-06-04.scan
> 06-8f-06-05.scan

Do you expect the /lib/firmware/intel/ifs_0/ to contain *ONLY* files for
this platform? For microcode we have everything in the public release
included here. 

In the above proposal, you can *ONLY* put files for this platform unlike simply
copying everything released and let the kernel pick the right one since it
does the ff-mm-ss-*.scan lookup. Only the batch number is supplied from
user space.

> 
> The advantage being, you don't need to remember which file sequence and
> which family/model/stepping.

Even in the current implementation, user doesn't need to know f/m/s. That's
something the driver selects automatically, just like what microcode does
for reload.

> 
> For all Intel employees here on the thread, there's a world outside
> Intel and people do not talk (family model stepping) tuples like we do.
> All they wanna do is run their damn tests.
> 
> So instead of what the code does now:
> 
> +	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.scan",
> +		 ifsd->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
> +		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
> 
> It would still use the *same* scan_path - /lib/firmware/intel/ifs_0/ -
> no one is proposing to give a full path name - it would only use the
> filename string - 06-8f-06-00.scan, for example - instead of the "0" in
> it to build that string.
> 
> And, ofcourse it would check the format of that string against family,
> model, stepping and sequence number (btw this way you drop your
> limitation of 256 for the sequence number which you don't really need
> either).
> 
> And then if the format passes, it would check the headers.
> 
> And only if those pass too, then it would load.

Isn't it simple now? No need to check if user supplied the right f/m/s
since its not a user input, kernel composes that automatically.

> > Right, it's no different from echoing file names, but it's much
> > simpler to increment a number than do a directory listing and sort the
> > file names, so it can pick up from where it left off.
> 
> It is no different - you still need to remember where you are in the
> sequence wrt to testing.
> 
> So if you want to deal with the timeout, that same script above will
> check the status and wait. Not rocket science.
> 
> As to this Thiago:
> 
> > You can't do it with a three-line shell script, but we're not
> > expecting that shell scripts are the means to use this feature in the
> > first place.
> 
> I consider it a serious design mistake of having to have a *special*
> tool. A special tool is *always* a burden. You need to build it, supply
> it, make sure it is installable on the target system and so on.
> 
> And I'm telling you this with my Linux distributor hat on. It is always
> a pain - trust me.
> 
> For example, there's a reason why you can still control ftrace from the
> command line and you don't need any tool. You *can* use a tool but you
> don't have to. IOW, the KISS philosophy.

The tool we have is not for a simple test run. That can easily be done with
a shell script. The tool does a bit more like handling retries if the test
was not scheduled. The fundamental pass/fail simply output is what the
kernel provides. 

> 
> IOW, I really think that designing our interfaces with user friendliness
> in mind should be of much more higher importance. And requiring the user
> to remember or figure out anything she doesn't really need to, in order
> to run the test is a burden.
> 
> Just look at microcode loading: early loading works automatically - you
> only need to install the blobs in /lib/firmware/intel-ucode/. The initrd
> builder figures out which to add to the image.
> 
> And not even that is required - I have a script which adds *all* blobs
> to my image. It still loads the right one.
> 
> Late loading works also trivially:
> 
> echo 1 > /sys/devices/system/cpu/microcode/reload
> 
> And it goes and builds the filename from f/m/s and loads it from the
> hardcoded path - no filename resolving.
> 
> But it doesn't ask the user to give a f/m/s or a sequence number.

I don't think the current proposed interface expects a f/m/s. The entire
IFS design was sort of mimicking the microcode interface. 

The V1 submission did pretty much that. But it required copying files from
some place to /lib/firmware so they can echo 1 > reload.

Instead of copying files over that *did* sound like a hack, the batch was
introduced and that's the only thing needed from user input. 

The utility is more like icing, to run a simple test all you need is a
simple script. It is not a baseline requirement.

Cheers,
Ashok
