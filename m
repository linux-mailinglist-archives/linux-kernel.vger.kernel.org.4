Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7DC721301
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjFCU7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFCU7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:59:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF5710D1
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685825926; x=1717361926;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g7+UPzT32OXON9i9iJ08yXt3WhQYiJLBIGPrtx9JmWA=;
  b=N67TcyCVKx8/Msaj9ncwhEYxXh3hUk8xtyVnE5i9q6r5yURQPvJhgjQu
   bkizztFnmewB6Lfe0lPdt12xIcfypcro82uaDsCNa6j5rjH1mz6SE+6zW
   Ho7ANzPwnD2OLY3jLSf/CLN3t6t2o5BdT+5ZGSI8X/qw20Zu+kKDpCN2J
   YmFAJRh31PzsVFHct2oEHdWDREWqsVMt+fGZpVCKWMByW0jWfwvSDFq0Q
   RP2cbdXAbZODPyxbVIyFOUl/DGuDC+DbCi4xV8scMMWO2gmDDHCniEC3M
   S9gV2Ur+6ckiBDEeDnlLVGvPUhE28vpj+aZ8AQt52ufXAn+1eqR0NepKE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="358555344"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="358555344"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 13:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="658633737"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="658633737"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2023 13:57:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 13:57:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 13:57:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 3 Jun 2023 13:57:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 3 Jun 2023 13:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLIGxHl5jMvnWq84lenUm1sTDmaLsUY+fPeHSPepb5xRX3msdgUMSYFkgtxUxwRXZnDQdg8B21w3cNp6qQDViEKwXiqbT56Q/wy26MKMEDMK5hlF1wldtUB5fanCmjt+J9KG8V44Ssj0mjWFibfGlXXOajCzPLwbmKAd7iAyWdVRA0J5x3gQu9w/I+J0zYd1gPumDdEKyj8MP2TI8TrW8SMc0OaQgFxQIo8BCtQOxlrrwzTV3RgD9+nSuP3d10HZnu3B1D216Ggk0U+Xys940pYCLYdJ+FTKgK7jftovhVOlrTL97HObeeoIiV/Oq3MGUA5ftZqxlGEAk7+P0v0Xdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9uM52nas5fXw0WyBygH9PpC9YijCySltQm285MX8SQ=;
 b=L/N0u+Caw9lpcLp7tUnxD65IwCCmmHzwGxcwI53yPXz/ssXfQJEtV57LgNZ3nWbdgXI7NbkmN69BQcRSc85Uic3Id0iIq/O/4o4PdG2fEPaQBmS+LMGC4lBMGCtkZJwBGiEVyApZMORHzN+uLAxJKoseRsvRwCBIRaAc6vAsyqwJVZs+YBuGIaZ8LEv5oMt5WmzTBMvA7lTkyUTAwwSri2cxbuxiazAdD4SnHyi65MytO50VhJzGGm+w0MDa6OLOCK6XZUWoXhfANoEHn40bcZ1r5dt3gdHXqeZvHSZdX+ay8y+lkoYcThgYMm/xuBrvfu1Mlny1+XVonxzTImMXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 20:57:17 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ba9:70d4:f203:ff75]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ba9:70d4:f203:ff75%4]) with mapi id 15.20.6455.027; Sat, 3 Jun 2023
 20:57:17 +0000
Date:   Sat, 3 Jun 2023 13:57:14 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 6/6] x86/smp: Put CPUs into INIT on shutdown if possible
Message-ID: <ZHupKtSqj1LC911k@a4bf019067fa.jf.intel.com>
References: <20230603193439.502645149@linutronix.de>
 <20230603200459.947733085@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230603200459.947733085@linutronix.de>
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 395a0886-cc12-4512-45e9-08db64751db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gp3WU+azSbnTN4JJrCD4NmBPd8IRvYMFobj976TYpShhgHOfJVnZd4q3NKptqdmR9ryRMDMvX72WPaaveksMJ36DXiVzH97aAJ62D8+VgU18yWMxLhhV2QLdExEBMapyLRATik9qj27OIEAZwRu8Smrqr/NjZwfdfb8oAxWKvSseNhTJjUZerLUECYrM2vIDCou5X45BzSHQG5hRX/pqwFazHkhfg4knIyU1NdpCnpt9PLJhVSO4PKAcN+ILdKayiIplzNzoOk3f056jBJmGnee3Nwu9MEVkkNkEX6Mq3rsB0qeRDi3Uk+H6yUow0fR2bvXws7flAt62qlnMOEnFxuzr0V1dQXB+I2A7MorXAQ1PvnsmMPOtcc9u2jJmj19XzD/Agm1+jkf+LdObhweeo3GyKJ62RfZ8/iBlZ0BlZ4uD3GGetpNkg5yOz4tyyQe1XLpd1wzc91xcyRCe6ClMwlIGWnaKHzSo3ArOqXQjMVL7XDdMAtgcxz7zYGkK8GSybEk/6Wi6B8s/vZEu45K0NYGkeBYUrjVwYsKktSpgh7W6k53cGDU3Y7CQ8LP9JrC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(6486002)(6666004)(6512007)(26005)(6506007)(186003)(86362001)(38100700002)(82960400001)(44832011)(54906003)(5660300002)(316002)(41300700001)(8936002)(8676002)(6916009)(66556008)(4326008)(66946007)(478600001)(66476007)(2906002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILTkIntzk7KE7WaORh33qGOI7y0KvdI9MbuV+S/fVhHWVHCWc3WkMxfdrAeR?=
 =?us-ascii?Q?pe7Ei/5ko3ZoroK7WHYLvXJVW3ILoTMueyK4spuDQMvaRA6VWKNnB9UBL5Ct?=
 =?us-ascii?Q?bSyaLMjcD4qAkgT0sNbIxU+8urJlYYNm5v8Qb6ZofWT5bPHYP/PqOdpJzGl2?=
 =?us-ascii?Q?k+49icD1sY8Bpgk8VJ0IymVIpNlNEdQ2uXQm7tZ2Xz3RMqj0pGVmnTT2BydT?=
 =?us-ascii?Q?xSZLB6vs3iRV0SB+/XFUepu/KQOhR+bZA8JVn7mTN5jUp3a7RFxTkDRi3s/m?=
 =?us-ascii?Q?slWx6psQl3oViN3/ajZlgqiBjDOkmVYkGOfp3EVN0VTIvvHeO8j5P/zuoGfQ?=
 =?us-ascii?Q?NvPxAp6UqtWI73CnXkx7fdRCy/49oeVywKtxwstLCzidAm1JrTeWoXYFKrjt?=
 =?us-ascii?Q?tMrWtP7vC8yuPj6YIgeVbHOVLdgV4n0kJ2BeUryw8GSjm90Hck1T+NynDihm?=
 =?us-ascii?Q?hr9l1vNLLsNTgYPoVtiks/MGe0plzw35cBkuMCyC2CCuWrBbU1drhFm/tYBQ?=
 =?us-ascii?Q?UO9MjjtaUij6ktgKanZjLFx3gxL0IegdGcRnFd/Zv+Qe68DV1zjc34KyYacS?=
 =?us-ascii?Q?1xce4CkYeveywu/FpA1vsLtvfNiPXUaTMHt1OG/DP9600Qll6lSNjh6YmbAC?=
 =?us-ascii?Q?igp3i/JAIy+fnOr4ALz1hPyUcwbl13vxCURknnmPsTqrcfrJD/7Zx7w9+J3j?=
 =?us-ascii?Q?IAQ5hK2l7dvtG/kEPKkVDKb8LrFViV+IQrYna+0uKTAbgZef7FU8qS9qi4NH?=
 =?us-ascii?Q?YAY6v4LMs22UTpuwKQPX06eFWnyzOOIFdm5FQV8gpG1eywPMXZu9H0OnxBTd?=
 =?us-ascii?Q?64isrGSaJLAgbTSAeV5j6iMmnPjQxvOzPRpC/u/j+f89PC+IvL+V4zRD4Bg5?=
 =?us-ascii?Q?t8iFGZkUobLE5WpcImZnQoiFlgxa027GhnXx5GpcRN1KJiuMWdU5fJ68FmJw?=
 =?us-ascii?Q?KkeDXNRTwrPh6j9Y1eQ6Zar3+a6vwGBgXqa3OH6B1YF6zSvsEQjwKzw0GQMn?=
 =?us-ascii?Q?Pi1JfCY1Cw8OPM7qCl9aI//Y/UA2P7/UySPBxdVj+Oe/I9dWT3qwAFxugodn?=
 =?us-ascii?Q?AV1AumtjPG+Yowe8y71X0xMs9uC67IzN+jOtI0Ahrd4eTY2uSCtyHekGKMNC?=
 =?us-ascii?Q?DFBuTPcVjAWBlvRQ0VHL/8UySMIQV9xlTaUk1MCsWBmCswWtQ2C2BJbXVFU7?=
 =?us-ascii?Q?Qw3jJxpHfOqDBGvqmb0eJGSMjIDuhgaqCtrQMW/sr/bCGAfdlzq4crFUpWKY?=
 =?us-ascii?Q?RXD5S9YDSZoZSVoEdumQvInrMEh88EKn85PwmhUVEKCJGVWDS7wUOtqoZ49Z?=
 =?us-ascii?Q?KeyVWL/4fNWTpF4c8czsXGXq0KrXdWN2/xCnJhW0PPdwx3/Zkqapadw4yPS7?=
 =?us-ascii?Q?LCPiR2kjJN4JKYrrTwBf0GzRxp1v4n7/yZCw6vch0pe0EW6LN5beiRwF8bXh?=
 =?us-ascii?Q?sfVs3cWa+o6p/U/OCBvRXSZxbJfbiVVLmC36EihgGs89BycqDQGH5jiRh7DW?=
 =?us-ascii?Q?cc14T/Lteh7TOWDDKP14sO6o+bv+vij3XqpqTzL9aXtTWLJqewjyrb8ZqcpG?=
 =?us-ascii?Q?kKgkWobkDSxx8SehVSvfKWOEtBC3SVQ9HNNE9hry?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 395a0886-cc12-4512-45e9-08db64751db2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 20:57:17.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gGFmEJONPaK4snLkzE/w1GUdH1TwCJ0xUXDW3FtLm26kdhXqP9jfHrMjKFgOg8HgCxP+GQQv8h38AoZwp0+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 10:07:04PM +0200, Thomas Gleixner wrote:
> Parking CPUs in a HLT loop is not completely safe vs. kexec() as HLT can
> resume execution due to NMI, SMI and MCE, which has the same issue as the
> MWAIT loop.
> 
> Kicking the secondary CPUs into INIT makes this safe against NMI and SMI.
> 
> A broadcast MCE will take the machine down, but a broadcast MCE which makes
> HLT resume and execute overwritten text, pagetables or data will end up in
> a disaster too.
> 
> So chose the lesser of two evils and kick the secondary CPUs into INIT
> unless the system has installed special wakeup mechanisms which are not
> using INIT.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

For the whole series.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
