Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE768336C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjAaRMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjAaRM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:12:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F3D3CE3F;
        Tue, 31 Jan 2023 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675185131; x=1706721131;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=27xTbnZe/JPWodjJDY+k4dEvxRYbAIlyWWcQbMWkQ84=;
  b=ErGvJ/dCXtpmkBseRZpX1l83qA2V7pUxIcd8frZ/swQ0JGiwXqIJbdQq
   ZEQJc/HuyD82nt7GJNKpFmrOxTopPCqoXaKI1P4cImLUfULqSX/+ShO8J
   s3XlB86r6m4d/2PSLnU7m31AGhjj+HERtAXPVF20DoHYup9nIavr/AKw2
   39W95/Wkxyx5Onz/hg5rZZ/o5Ra3OvKme0Strl7V+Txo8A9Hyi1Yehmv4
   vZAMUhJKLD/W491OXAz5Xj28XTEBQchHKyC4+nWR7sJyeyEMrRUNwZTFW
   3/0R7riZ7OJEiIQsN3Bm6x02IIROqNzsxqgD3IZ6oEqtryuuEKrx1juAK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326557965"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="326557965"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 09:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="664554900"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="664554900"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2023 09:08:53 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 09:08:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 09:07:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 09:07:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 09:07:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEaRsALcTwoY8/S1G5dsAf1BdvosbU+8+gBGWOr8uDqzyn9zRAaeSPsasJWGAMoumLAIYSv9vKhoTSRzEsBa1BBpxH2Ig4Y7nm0v7+in1hZoHf3Cp6BIK4zmfOF5VtYoZZthNBT5Tfmz4GgQsdZHM8mlYFBK/InYKkRJAb2V/qqKbzFPD5HtHUQwhccdGpMMah9l9UzYFx13ePfYspwEjfpEtqaar79A8JmXNPbVMp78j0kvFm0SvX0w9kx2WF5aYicwCaXxeACWo16y31sLfg2Bk7C8i0dX8gIpFuUIy7lTIk6LeTketA1ONx4Uaqm7Apad1B9QiRmtc6lZnMlwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27xTbnZe/JPWodjJDY+k4dEvxRYbAIlyWWcQbMWkQ84=;
 b=UhSzJ/+8xSPdSTljGpr+NlGDhLXC8ZQg6EDx9PDik4HU2+OTC92a5+VEEVH+xea0yum1ux/5DiLHQBIMovaBFUBtMcWui1vuQxb8Z86ARHDBkrgfG5N/QnSf+l/Cv/oJM4X+Mu4bDcqkUbDJd3yFE4Do7bwM9vm0jBU91ms1zMb4CAdSEORwqJg/iscv8qyOrtvpic6urJLtp5s6OziiIGluxixT5Fm1bDtR+3nOFfcmi/UlQux3mC3Gl9p1kQr9W4xdnwWQwwRWzeNtp61JTeePVBxViLWI74c3gBPEk+zENcTQ/cgF0TxEsjBm7vfPtwTlBKDkm1pwZP+i/Klj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6015.namprd11.prod.outlook.com (2603:10b6:8:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 17:07:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 17:07:40 +0000
Date:   Tue, 31 Jan 2023 09:07:37 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shesha Sreenivasamurthy <sheshas@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: Hot ADD using CXL1.1 host
Message-ID: <63d94ad9901a1_8e2c294bc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <0D3A81E2-C99A-491D-AB66-FC6005E38667@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0D3A81E2-C99A-491D-AB66-FC6005E38667@gmail.com>
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 2289fcf1-ee03-4702-b54c-08db03ada8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZXktX7ToTts12ieyg3F5NLXNVOl8B6JfW3+OtmZFFDeRIeWcU/F0gZmaqfGf98akETkG1yJMPTaY4xKS+N0zDf1/UvtFGIISfIwduZSX/AU+RJSMkTUzKAMzvZ9UZKVmUCD2O+HR9VtwexZOCfiGmtVChH51sJkIn2MShVX63HijKavoe69z3wHjHEJfDG2TOh4WoyA2h+LSAMDYqGTiEWQy73HsdeDL7A6o2kDA1I8YjRrdGGUwYufFpNGblvNx6P/sUQTV2G4SNvJNAmglk/KE8+a7UrpKCghLG0DGKLldaDe6MuPYy77pR9SOpZkXO7pHIe8CWvsxiEZNIQsvjlapuJ2HzuOipDAZsUOa+o2E6hnSu9ACyTAnGh/veOiI2BMLe1/qQRMjAtO/PfVU14tw6/ShgjQWvIsHfCsWWE5RM2LWFBy+j8q/W/3Ya8vh0P/+1UCJ/DYdwSp2hg7vLG+qAbNM+F0W5Zjm6XVmDpEO6kVpSwmsOqwL+nUSdg7NGEaNrpj+z6dVSKyEiKrjIV+8XpNtJqiE621T3Jubc8cu97b6X8yg21mrHJdlb05tBF7WvQjULm55+ra+HtkQYZoNpNk1KL9bOQ206rcBHQZWnXkKKWc56QXnOtHRqc0T3NfftF8bY6LtCIZmiAJd0PbWy7lHT0ik9KfV6NZibU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199018)(8676002)(6666004)(8936002)(66476007)(4326008)(66946007)(66556008)(4744005)(5660300002)(83380400001)(41300700001)(6506007)(316002)(6486002)(110136005)(26005)(6512007)(478600001)(9686003)(186003)(38100700002)(86362001)(2906002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZDLKkLJw843JyPRJ9SUoaH6DM4GpO07+FwgqG4z+l7LgpTgINIxs3Sne91E?=
 =?us-ascii?Q?GZ5ciCG9pW2+G0sHfHlAz8RtUY5eKqL8otbuInOn4NNk2xuw8N2lquQr5g69?=
 =?us-ascii?Q?5l+4tbc/2rKaLah5aYI4656EmOs1S3qjcIZ21/wAOvan54tVuqdSb8zs2u6W?=
 =?us-ascii?Q?qjRFW8ewf+hN4hYpYhNzxsigdmB8PGNxHyGemYo9F7qKsiRhkAPgRToEhT7c?=
 =?us-ascii?Q?UvpGNUvto/1MSUPwoxgaaKqtztpN02Z6mxYL41XFSPXzCagmFrZTr93ekA08?=
 =?us-ascii?Q?whSn4ClCwp4q3G4d/eQJPvLliysAviZDJKXfCZ8RYV7iFQ1oSF5DCxqeQ41r?=
 =?us-ascii?Q?3ZKaHNX1bOtp5w/ciN1L7XGsn4Ox0btB96pndW5vxmtu6Fm6sKgMh9JUd+Yj?=
 =?us-ascii?Q?pBJw+ufRUVt3fzCcKG7003c5CBobpA5xM+k+5pu5yy7VCFCl7CVsLYJ37iQB?=
 =?us-ascii?Q?039Dno5oRDTLteCDGZmFEvzw8rHNjZ28HmzTGSmQbUq1VNG4nAVuxdCarsR7?=
 =?us-ascii?Q?n4lOI0/iyhBhnP+iO+V+HhkjI+qQkBjJzfFVi9J7yaBwsib9OvQs/67m74lz?=
 =?us-ascii?Q?2rgDSFGQ4isGcNhxmDrXRPPvpmChN8aQRdIgWtuiSmnFTjr69ECEApJQNCRs?=
 =?us-ascii?Q?eiYGJXvU3uEVtaRzzlJYoAmCYzcAP48acHFGkwwOKFo+CuOley8rLyNEszrP?=
 =?us-ascii?Q?YoXf2u+mYDCbpH6ULx42v/heWYeczHitMv+IywaOGylkYlh7BIsoFUXiTTPZ?=
 =?us-ascii?Q?SgRnttn5PGb7nuuT2c8e+yBx5CJZKuxMfYNC/24F+oIBzflpBQScTdFvY72L?=
 =?us-ascii?Q?bPcs8wDzhzfgIovPPCggfkQT3qsn2NpKKJHHuKKvbQ/wbt0Wux6WQ8CJmOpj?=
 =?us-ascii?Q?9cIHP3VJMNI7KnrbYUUmTMULnMdBTpxPj6GFbMZd+Nkeo5qBAJyWMeoKhQM7?=
 =?us-ascii?Q?c1msoOsC7f4l6Xq2UxYhiU9bYFO7OjcShuda4d1YlYEkid0LQ4Qistfw6xyO?=
 =?us-ascii?Q?JhMA3FtwtfRxB5Lh+jOgmjKVEo3BEWGZyHIsCbCWKem9QV+sQ/v5MtxGowah?=
 =?us-ascii?Q?UUa33DO31vyChzsouNPN5f9w/XGT4Jy34EmJL2lstqE8EB2L6G2cJBgO6TzT?=
 =?us-ascii?Q?VQPFwDTrdrAKpIbnYN42vxIVidtrMXIbDv9tNcxoNy25WPK8RRQ55v01ioHA?=
 =?us-ascii?Q?oUtwvhRKmobY6JksjmEFO5EBgjGPLAk/+Z2CtxKeg6F1LT9vDKAFcKJToPRD?=
 =?us-ascii?Q?G2mEGks1Nsrx9uYResbxlPhbPRUO8Sk0zuNdA61Gel0Rz+/+7vdWUL3APsln?=
 =?us-ascii?Q?8inFO6Jh5jlJjwaLO2b1+clDRTEUUfqOqR+PnIIh3W0IOo7+nD/gPLfamzTI?=
 =?us-ascii?Q?RsSjqLcG16b0Hz33LfFtUz8M6NDsEJcXT31pUriyJbdCIFlD3aPUKKlGGkIK?=
 =?us-ascii?Q?ZvZLrrKWDgouZP0FfnOGqJKHwLxP7v9cprvPDU5/0Ewr9T/Knyr0Pwbtglgz?=
 =?us-ascii?Q?tBli9Gjj2Q6Usvm0ta23iL7VnEmRQCaFIJlj4uXZj7zeqwE1kKw0BTFhZ6rH?=
 =?us-ascii?Q?XzAwwnOU+whtJs+Vnj6CyDJ6DsDHzddUX//vvOxZEHdy7NHU3XwnOsHQQPHd?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2289fcf1-ee03-4702-b54c-08db03ada8be
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 17:07:39.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iQnPT+UZDbHEp6CXB9swkSSzIABV74kPrhz1379PsCbS8QzAm2FTyk+HMLOj+rAZd1Xcq02Jvws6YeEC41Uw0da9gZrX7uNtQP7qnCIfCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shesha Sreenivasamurthy wrote:
[..]
> There seems to be some instability in using DAX. When the system is
> given all the device memory using efi=nosoftreserve, the stressapptest
> (https://github.com/stressapptest/stressapptest) runs for an extended
> period of time. However, when the system is booted without
> efi=nosoftreserve, and assigned the special purpose memory to
> system-ram using daxctl, the system crashes after some time (20-30
> mins). Is there any known instabilities when using DAX?

One difference with late binding of memory is where kernel data
structures are allocated. So the stress profile can change based on
kernel activity. Otherwise there is no known instability with delaying
the online of memory.
