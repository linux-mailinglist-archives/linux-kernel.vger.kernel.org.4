Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208F46DC05D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 16:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDIOaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDIO37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 10:29:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7FB30E8;
        Sun,  9 Apr 2023 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681050597; x=1712586597;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xNCcXNnDFemaUE9K9xZLsqXTMip3m2x+u387YBJFkKA=;
  b=RUq2V7/nfvAls9D5kocRjpbojbChmx3je8e4mhS2UwqLBLhslqVwzKU1
   ap2miCGRCDdQji6sk9NVDF/F7neRYNiJQiLk2+5OdM4lhvvDbJLtq28yL
   4SdhH1fBXcMqpzLITQROzjgwMRXGYdxmMTU/SaIebQctAVJuiErk05ghK
   7BjlouzBO2/vuwFaHaplkuVae/03bqqeU1xPUvpNwV9ezoAkScxna0YtK
   ENhfrFFjeoi/BYE8G6JEtkVPU/aH1Lnv9FWgCBUu7X2i7NvK+cG6iSksU
   Sw4xpuA3LEIcavX/W9gJymOBXhFGbvSppIzIStf+ZlXAFVrZhpHW+nAwN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="327316296"
X-IronPort-AV: E=Sophos;i="5.98,331,1673942400"; 
   d="scan'208";a="327316296"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 07:29:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="862256825"
X-IronPort-AV: E=Sophos;i="5.98,331,1673942400"; 
   d="scan'208";a="862256825"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 09 Apr 2023 07:29:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 9 Apr 2023 07:29:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 9 Apr 2023 07:29:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 9 Apr 2023 07:29:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 9 Apr 2023 07:29:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFHgG2WgmMmyrU//3jBj88yfUxdrrjdpc9tqRiImWzwPcEH3H97JSo2q8oF3f/JbOjGqUoWFgb24CbUVAt/gsbl4N6vHgH9GnVbiMnGH8fBCO9g8JL26OUGgy7pGnkJmlzGtZANlYrQepNdgvWdL5DTuLQrhzQjQ90yHb/uXvbGf5G8UOE5SzHbH+v9QugLJEX/frTCxvvYJimNoM3WbFuvQGFBW6IJRuDKljkBZrRGFnmmtB1G4Z9J/Bz8pjkOeAb5+udKKXQNq94iFU9Bvxj3ygLeI75O1o7LiptwPHdOMaz3EXRZITwsv+yOTT4Md0xJVhP6Eqy56cFLGCDVwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcJMz0sFYvugQQxzqhmygST7FXYenxn3z2/ZkvbELfo=;
 b=M9f+9As55WFNj1OmK6TuPUWPu3Ox1iD04Fz0OlntnG+IVRDvhvj+KUG6wCGl+VoJiiQYsp3ntmU97OBmIWxrHbH3xMF/nXQhlAVwldLldp6FzqWc94g7mdQKk+VRhECUnV+T/WEMPkR5o1peL6a1MY2C8QYA3Gve4gPHGAPzRHL1e/enbZE6rcsAqMmREOKWU2IAvBG5YL82PdZ04ChXxTpl6U8odZlroERWxoK65TQQrcpqRhmCxLoeQs+YQ58xZHjAUx/iML+YeNBNCra9ECvfiplqdttMK1x7T/WoAFMhRQ2YgBwATAn71ZPiY3xrIpV1Euub1p6tpCgunAK4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB4871.namprd11.prod.outlook.com (2603:10b6:510:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Sun, 9 Apr
 2023 14:29:54 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::dc82:2501:ebd6:4799]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::dc82:2501:ebd6:4799%3]) with mapi id 15.20.6277.036; Sun, 9 Apr 2023
 14:29:54 +0000
Date:   Sun, 9 Apr 2023 22:29:37 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yifan Li <yifan2.li@intel.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
Message-ID: <ZDLL0SI87x9a/qvB@chenyu5-mobl1>
References: <20230401165540.322665-1-yu.c.chen@intel.com>
 <CAJZ5v0j704JoCPTrDO1jTHwP1+8NVdLk7hym5036uFcfo7YHXQ@mail.gmail.com>
 <ZC4zMv1SCiUMbcqs@chenyu5-mobl1>
 <CAJZ5v0j5PWsF6zCCVMRW59WevYLvWiBk82U4MpxqWdFnAcrqrQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j5PWsF6zCCVMRW59WevYLvWiBk82U4MpxqWdFnAcrqrQ@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: ba252e20-0611-4ae9-57f0-08db3906e22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFlglQvEVfLbnjrlZgQw87+st8Z4n0QNSFauBlw9HmdgHssg9hZ1tmP13ESVF2OFDto5GeetNkiFI2KSzd71+OIXpHgaWhUgy2oOtlI16AqQw7mulOFGNk9hXDrt1S4qonHdiFEBbddH6Eg4KCJT/WvTk2lTnDuGFONOoZVZS2nE2UtQa++cefN9ZeEeII9G4YlAYjUE1rlzRg9Sb+jms4E9IN3MwjgaoBQV9lTtzEeKqNJUbKHr0Yqyj7eUJHVrhaVcflf9aLe7oiL07J0lukPEaL4HtFTHdje/QZ957QTYDbVlOD6Wadz+8VGQPMjfaWaKSoOraiJzF3jPL04rx9WzcxUh7MuDk4xVkUuyoDoi7sE1y8gER57C7zpBwkySjsVPu3l/vQXml+3ojy0o9wfESbjYXOTq46emEdkzIHV69cPrfFAiffNYhRA6uusH975OA0gmuzhmuDn78noynX54q7OD0YOuZXEofiOrg6Vw0YfdMVIJLRqLFWLUxlhMSuVxtsIrpoHgBDAT7WymMNzAsHPM2XCmqfzRC4tD84TcckdtkzUoCGAJBuT/vNFY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(86362001)(110136005)(316002)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(6486002)(54906003)(478600001)(33716001)(5660300002)(2906002)(8936002)(38100700002)(82960400001)(186003)(6666004)(53546011)(9686003)(6512007)(6506007)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1JzR1dJRlRkaVVWZFdGUFR0WC9tUkFCc2pja1BaOElteERkUTJsYndmVklH?=
 =?utf-8?B?TkVNZ1BpNWNYRTJsckZleDZyWjdCNTVML0hKbGlTT09VT2MxaFZvQjd3b1JZ?=
 =?utf-8?B?dndrU1d5NEtkMS8xL0hNdUd0M09lOWhEcEV6TEFGUmMrT1BmYUxDRTVtWSs3?=
 =?utf-8?B?MVEreTU2bUlHNzdsNFRYLzBnMVFTZFU2RWtMTGluRC9sVXF0dkZ0YTZGUHFJ?=
 =?utf-8?B?WGhyZVFJYk91NzZPc09USFNjaUZXajhvWFRBaUZnRnNZcUxaREVkb1VOUHBs?=
 =?utf-8?B?eXN0OVcyOW0zRE16S1JaZ1R1V3g3aTE4K1dFc3RtNXRVZnB2dyt1S1Iya2t4?=
 =?utf-8?B?WjJLTmROelJWK2FkS2crSVVXbTFmcjFmRFliTHVVQ3VRTTdRdWh1ekIrc0Fu?=
 =?utf-8?B?TmFDTldhNzNMU0RGSUxqN2lUYUYyVEdNclFVYUFna0JTUzJSdk4yWUU0UG9p?=
 =?utf-8?B?SU9nMjhBejhYeDlZWGM1V29mUUI2dHJWQ0RaK0pYRFVCdW94OVFpbUppaTdX?=
 =?utf-8?B?TTRPN0s4Y2kyanB4dGoveUdIWDY4N01Db3hCNWwxT3ZWbk42cFhhSUNTTW9t?=
 =?utf-8?B?UGhCVzZSTmY5bE4zSnhqUUFRb2pxM3dWeWsybHhDZkdvb3I3eWNXMDczcFBG?=
 =?utf-8?B?eFBNU3JSZ2hTRDdLQ2Y0enFNYVZ4MXhkOU5KOGZCTjFZd2dOSFJSTmhiczNU?=
 =?utf-8?B?Y0d0Q1Roc2Ixd0VrNVZ4TENOUmpJMXpVTXNidTRsUXlsUi9VUHVsdUZxTGpj?=
 =?utf-8?B?QlVmV0YrM2VNZFRac3puck9iOFk0QzlrQ0VRbHRCb1QrQ1RiZzJRM0N1NDJN?=
 =?utf-8?B?OVRYU3ZyRFlMeFh3VmcvamdsN3FjM0NibjdFc0lGQkpMR2Exb1hNbUJjMWdx?=
 =?utf-8?B?UWtVd21hVEYwUGNrN2xtNkJRSFg5d2gyM3ZENVQ5emQ2UmVoZFJPTXdMaGw1?=
 =?utf-8?B?czN3Mk1tc05tZU1rWUVQelhSdWR5UGRPWVNzNGhsSTY3SkJTaVdyTGdOZm1C?=
 =?utf-8?B?WXR3MmNuVXA0MWVVUzlDa0JXQW96TUhCTDBscDlNdlFaS2dxV1gwMit1N2hC?=
 =?utf-8?B?S09PL2tuM1JUY3VyTEMrSXZxTFpKc3hTT3kzQW1uVTVDWlVZeXJ6S05sbHJp?=
 =?utf-8?B?V1ZiaDJWMi9STTdwVmNtQU9TY3RTWTk4ZForb1QycWVoR1hjQldwRnM3U3NI?=
 =?utf-8?B?RGJicC8yNXpsUWhpeEhQNG5SdXhYWFV3MktEZnRUTi9lZTM1bnhoUGRXQUFB?=
 =?utf-8?B?MTNJK3JwcFRUM2V6M1ppSGVPazd3RUJ1RXRkSGhFOVNnNmt0OTdlaW5KekhF?=
 =?utf-8?B?RG03YitGcXQxS3c4RG91ZzBHQk1PeE9FVUJTT0N6c1R3bVdzQVpnc0pwMnJv?=
 =?utf-8?B?aW9YendxaStHQ2FsUE1ZRmlTZGQ1YTRiTzFVemVXMUsycUFMWnRzbVZ2aHhW?=
 =?utf-8?B?RDB3dHVtK2lkdnY2NWRJYm1YNlNXY0FVem12cWVCY2JqbzlqSkFDR3NaNHJy?=
 =?utf-8?B?eXhHMzBTMTBDbTd5N2FRUmg2WUVPMk9oMUVncGpXWGtOa296N0JuZkRhSitP?=
 =?utf-8?B?cktOQkRsTk9SNGpHVFJ3RU9WeUwvb0E1RFlQd2NONExIdXA0K242OWNVMGVE?=
 =?utf-8?B?ZXhvbjM1WkE0SVhVZmNsT0VvZk1wbFBkczVqSEo0bkNsSE0vcXh1TEhmbERV?=
 =?utf-8?B?cXFyMHBIZ0dWdEVmYzQ5YmVqQnpRenVockZWUlF3QTRyY1JTMUtwekVZaUMy?=
 =?utf-8?B?VzZYajEvNkRQR215by80aENNUlhmdFhsZDRKT2tyektKazJoaFlJbS9qc0hE?=
 =?utf-8?B?bHJLYTZWYWtpN2Rlc1BteEw1MjIzcGI2a2tWY2xTNUdKYmZ1UmVVTXo3d2NW?=
 =?utf-8?B?UnU5dEtJd0V3cUxBYktKWEdTVExVemN5amJ1d2k5NUZnNnFjVXdCdG53ZHdV?=
 =?utf-8?B?dGo4NTV5UXIxMEdacWhJODFDNXE0cFJFTGRBYitBNlhpbkp3OElIUlgyMEVo?=
 =?utf-8?B?Y0tualY5WUR2S3NHb0xCczYzaldUR2MzM04vWUt4c1RyN0NSVW5ub3BLdElZ?=
 =?utf-8?B?V0VMQzFtWjk1M1NtWHg0UGVDSUNYSlRYdHdUeWg4QndUOEVRL1BGODErMHlP?=
 =?utf-8?Q?qcMgrAUFM7bHlZtH2AYRS1i5l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba252e20-0611-4ae9-57f0-08db3906e22a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 14:29:53.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFwvhKmhmX55HwpYr5GBXSJSHachgIlf0onUno2kyFFz61ahxe28TcJ2hP/k5ELmdFvIvG83FGQZ5rNafv89Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-06 at 12:02:01 +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 6, 2023 at 4:49 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Hi Rafael,
> > On 2023-04-05 at 20:37:32 +0200, Rafael J. Wysocki wrote:
> > > On Sat, Apr 1, 2023 at 10:59 AM Chen Yu <yu.c.chen@intel.com> wrote:
> > > >
> > > > The system refused to do a test_resume because it found that the
> > > > swap device has already been taken by someone else. Specificly,
> > > > the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> > > > do this check.
> > > >
> > > > Steps to reproduce:
> > > >  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo |
> > > >        awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
> > > >  mkswap /swapfile
> > > >  swapon /swapfile
> > > >  swap-offset /swapfile
> > > >  echo 34816 > /sys/power/resume_offset
> > > >  echo test_resume > /sys/power/disk
> > > >  echo disk > /sys/power/state
> > > >
> > > >  PM: Using 3 thread(s) for compression
> > > >  PM: Compressing and saving image data (293150 pages)...
> > > >  PM: Image saving progress:   0%
> > > >  PM: Image saving progress:  10%
> > > >  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > > >  ata1.00: configured for UDMA/100
> > > >  ata2: SATA link down (SStatus 0 SControl 300)
> > > >  ata5: SATA link down (SStatus 0 SControl 300)
> > > >  ata6: SATA link down (SStatus 0 SControl 300)
> > > >  ata3: SATA link down (SStatus 0 SControl 300)
> > > >  ata4: SATA link down (SStatus 0 SControl 300)
> > > >  PM: Image saving progress:  20%
> > > >  PM: Image saving progress:  30%
> > > >  PM: Image saving progress:  40%
> > > >  PM: Image saving progress:  50%
> > > >  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
> > > >  PM: Image saving progress:  60%
> > > >  PM: Image saving progress:  70%
> > > >  PM: Image saving progress:  80%
> > > >  PM: Image saving progress:  90%
> > > >  PM: Image saving done
> > > >  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
> > > >  PM: S|
> > > >  PM: hibernation: Basic memory bitmaps freed
> > > >  PM: Image not found (code -16)
> > > >
> > > > This is because when using the swapfile as the hibernation storage,
> > > > the block device where the swapfile is located has already been mounted
> > > > by the OS distribution(usually been mounted as the rootfs). This is not
> > > > an issue for normal hibernation, because software_resume()->swsusp_check()
> > > > happens before the block device(rootfs) mount. But it is a problem for the
> > > > test_resume mode. Because when test_resume happens, the block device has
> > > > been mounted already.
> > > >
> > > > Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> > > > problem because in test_resume stage, the processes have already been
> > > > frozen, and the race condition described in
> > > > Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > > > is unlikely to happen.
> > > >
> > > > Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > > > Reported-by: Yifan Li <yifan2.li@intel.com>
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > ---
> > > >  kernel/power/hibernate.c | 18 +++++++++++-------
> > > >  kernel/power/power.h     |  2 +-
> > > >  kernel/power/swap.c      | 10 +++++++---
> > > >  3 files changed, 19 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > > index 793c55a2becb..f50456e72f0a 100644
> > > > --- a/kernel/power/hibernate.c
> > > > +++ b/kernel/power/hibernate.c
> > > > @@ -683,22 +683,26 @@ static void power_down(void)
> > > >                 cpu_relax();
> > > >  }
> > > >
> > > > -static int load_image_and_restore(void)
> > > > +static int load_image_and_restore(bool safe)
> > >
> > > It is not very clear why the argument is called "safe".
> > >
> > > Either this needs to be explained in a comment, or I would just call
> > > it "exclusive" and rework the checks accordingly.
> > >
> > OK, I can change it to "exclusive". Pavan proposed to add a global
> > variable snapshot_testing to indicate that the system is in test_resume mode,
> > and we can check this flag to decide whether to open the block device
> > exclusively or not. Then we don't have to add parameter for load_image_and_restore()
> > nor swsusp_check(). Could you please give advice whether this is applicable?
> 
> Well, in that case, why don't you simply check pm_test_level?
>
After rethink about this further, it seems that the global variable snapshot_testing
can not present the race condition described in 39fbef4b0f77 in a corner case, if
we do like this:

     1. echo test_resume > /sys/power/disk
     2. mkfs.ext4 -O mmp  /dev/sda -b 1024
     3. mount /dev/sda /home/test
     4. echo "/dev/sda" > /sys/power/resume
 
We will still see the kernel crash, because in step4, the software_resume()
will open swap device non-exclusively because step1 has enabled snapshot_testing.

That is to say, to avoid the race condition, we should let software_resume() open
the swap device exclusively no matter what the hibernation mode is.

Maybe fall back to add "exclusive" flag for load_image_and_restore()
and swsusp_check() is simpler.

Pavan, what do you think?

thanks,
Chenyu
