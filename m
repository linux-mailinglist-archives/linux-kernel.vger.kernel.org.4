Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB676C2847
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCUCij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCUCig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:38:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFB135BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679366314; x=1710902314;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4tPyuRaXouT139nOYqQ7bRu97LGEnAR9Fga/dSVFUXY=;
  b=dKqR2otELydMQvfHCjb6T309V+GxuW2ddW9z0gL62ANlf2bdY3aoIhM1
   kulL8CXKIte9Pl7jxE8/ws+NBwnNpXz92CryA6qv2Te/yaDGCbL7uvOlF
   VoeJc2Gmto066gOMu3wO+MlHkr5WD/qqjIY99v6COyZ12eMTwORUuqmjA
   T1O6bzYVNzkZsgO9pixBtQkrqLCxUDHzKUVs66/91fv3YolWzoomPpKG7
   L8xCKeQtc3bTjwV340RqSjDjz192RByZgAvClWy/DY46LWhpDhLTJfx0p
   tErb+YNbNPsqiSJAD81ltUn+B0fJyuq9Esr9baGlps/kiplRw650pyLxE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366557906"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="366557906"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 19:38:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713810359"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="713810359"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2023 19:38:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 19:38:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 19:38:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 19:38:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 19:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaRjMp6ORCC96Oa7VVPRSrvpSUlZV+KrAzFAV8xOwEBKZ/1QhiHu/akx1TK4FcNoEEvea1BiSpkaayKpZP5zH1XG2c97Mpbvi2z0vjPlPidp0hquRvT0rOSic4z7ANSiXBzCIteD1NguHVbNvP3HfHZoiarvWmBFoy2+FR/sc+ZIukR4Qu/IoYW9XpDF33pdMpo67rbabq2AMTh8XPujYNC+KTgCqaIvIYxEZRCWwU9CuXaMfSpHk8ckuFkT+k8pmWu3lCNKb8n/QCuHb9g9AzrUbHXJk8AeCSzuKAL7UbIZe2bEwAs0Cnvk+tHnjVk1td7kiBvPKv0jtUDWsuhPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7XJFc0+TbXwNGV6JtI9l/bx6YrHY+W8U3HhWd8NBdE=;
 b=ZiYrWqZFpqkgLDj5PN5OckMY8tfmHrp9EI+jTBeGiaVraq6kzik4ogdawD6B/USBG8FRFcz8eN1Z55spbx1WX/sxF6h6Lk+hgEjC41bjCUeqqbMtUPO55eUs8Kp3fB4Fvnjx7L4+FdfiwL7s6tcu0/T3bMbZODDpP2nFtAl6b4holELVl2oHWTvFo0DZyxAVSjQ0CpfueuPc3BltX3ijImDyRpX6zNbcY4aPEduo3ee0ypwuq4qQEoFIzXs3BViEsaYCL+8kE2blayA5hXlNM6EkvAYftI6LPo0A7ys1qYkfR9g+aVr2F6lGVnfPCVeTGkoL6dShp0gtWg0PAAvwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 02:38:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 02:38:29 +0000
Date:   Mon, 20 Mar 2023 19:38:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: nvdimm_bus_register: Avoid adding device to the
 unregistered bus
Message-ID: <641918a2cf2d3_26992942@dwillia2-xfh.jf.intel.com.notmuch>
References: <1678955931-2-1-git-send-email-lizhijian@fujitsu.com>
 <64133bcbbe368_269929415@dwillia2-xfh.jf.intel.com.notmuch>
 <ca55bea9-d2a8-ccce-010e-a26f6003a059@fujitsu.com>
 <641401d75d039_1dee294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <eae85bab-cdb6-b8b3-8014-2e7f3916bfe2@fujitsu.com>
 <6418981ac577c_1dee2948f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <cfa1a053-b99b-c22e-b80c-4b92f5f4e225@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cfa1a053-b99b-c22e-b80c-4b92f5f4e225@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 06970ece-3958-45b2-5502-08db29b55a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phZddksJX3yCTQGRz3lsj+HsTc+ZQBNz4hwWON2qg1JmsSBKry1SPsPbzPN7AfHUDrEFJmIMpGxKRPB7iPgpUNcIF12ooeVE1g+v2YL72YKNBMK+ImJmfFXXJ4ZiZ33eydQY2fRaD/JL3UZtD1VRoOAXr3uNKAY0SCYpsSsEKmQDfgmG3nXNY9F+q2kmcX6TxIdhppeS1C+a0HcZdkQTgCsactMglMS0yRZr9N181hvsMIWf1H+AeOZJrLo/VySJo257mkF4Sm1HQvyWXj5ynqL4SkGLUxXz6XuuG2/42eC78blItdbQ77tRIWAkX4vQyCJwAcJgmQVbBh7W2LlNZXKM/777wC3M7Qg3R1MXx57ZfDBE/ZRnu76h3HxLF2C9SzD6awee5t8dfZqpZWhlDrhS4+iOSSMJxKQVJ1Tntl+G4IR3nYomCwNv+cX38O3/awTe1AKu8WPTL+tS6ssPNySZgbNbuaPQ25XGB9R03S9HfJeTKIWxKiEJy00YwL3ZuRWNKo3RWaf1cRrr/py8rq4ldZFJSkDA5MNCD//YzhTRhsoXUMVAYzMer7fTv6FNCobb5+WGpWxoJej6Ue4q3wHxy/UuBwj2QWq2kAbkMRsAlY8VAB2DSVgY4uMq3R1Rf/RLYPfXtOiX9fiNZVDMtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199018)(38100700002)(110136005)(4744005)(8676002)(316002)(66946007)(66476007)(66556008)(5660300002)(8936002)(4326008)(41300700001)(478600001)(2906002)(86362001)(82960400001)(9686003)(6666004)(186003)(6512007)(26005)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cAmdYwjmHXkpvxS23pk7mw6C33RwprDiBQW2WL19ubqmvFf8X5oK7Aa4WEVo?=
 =?us-ascii?Q?ubQcpLBfdIGSy025fddiU7byi2uN3w/ErhBucV7/MG+Ua5RPRfbwPHfIntm3?=
 =?us-ascii?Q?MkHsIKTBMS8HNJSbgcWmpR2eAkMknUTxAMaXVnX5YFYh8+0LFJjO3YckczSL?=
 =?us-ascii?Q?fbEr10jTTt+8P1rS94Afmo6XszPjQ9ZJnzgyPhmDvA73ztdWdcaaiIOUtCmm?=
 =?us-ascii?Q?h1E4COvOmiPmGN2YiqHDDt/Lz7PkV300JJgpHXT9lNcWREib4axbGTt4oMS9?=
 =?us-ascii?Q?J4kizfS5zyH5P16kM8RLMR5G5qGLrTA+Va471jKT5iWWCmUyLkXFSRoLPZ8G?=
 =?us-ascii?Q?voCnm4Hh6pVa4FkZ7U3nXtsb3xe1ZjX5a+I/wEY41bNs6YVt9l8icMCYOetc?=
 =?us-ascii?Q?7+rr6kzWgMaQM/KmLNMysuL4gEuT35rIpYVkby9gatXoNUuezJvJw0A+362+?=
 =?us-ascii?Q?GlenVyr4R5AK7GK/gqFT7N9npIWCfXNjnN8Iz/lBihoIuq4vAT8FBsFh3MSt?=
 =?us-ascii?Q?fZVYtvFMYj8nNHxxqbx2PBKQHo1jg66d53AVPlXe6bteWnKRMpYDzz4FvXkq?=
 =?us-ascii?Q?LRlMzua9amWit7vYaHFbNEwCH5o1siCaRvItd85udDF8i0moc/Dt6iNkuZns?=
 =?us-ascii?Q?Oz45lvq2V2nXpZ63E+h/XgFKmoI/tH4zdC2s/qPkNUtWUnW7ehMu94Lwgx05?=
 =?us-ascii?Q?Fti74BOZblC5hTz6jSP0O93FLTQ6TCU/mKujZechLwTLrQU5guR6/bZOESN6?=
 =?us-ascii?Q?b/To82z3uj44aeW7oEZUGVO5AHPkZv52ShS043NSMVWfojOqlIHQeNbsDnAa?=
 =?us-ascii?Q?bgJpfljR+b/Lwm+3Nbfq2MNYwFF15xsdL9E+y4K7Vk5rFhj2sQcy/txcUOcv?=
 =?us-ascii?Q?/EOl0gfHhNNwmDJaZctsZPBcsnuoDNzFNf04Ayj/XzP5fWgNry1aws+guYdG?=
 =?us-ascii?Q?ev3HVWgF5H6dQvG1ol/Jrm7mQiIT38WSlo1N14QF8vvPFLh53rjUvGxkxNs4?=
 =?us-ascii?Q?EGQcZdQ35oyJ/3UpTeU+k5xpm707AbTb3mWYxsw1qohWMBW2GAhDTJKBHlp+?=
 =?us-ascii?Q?CcAQniPdq1vjjNXnHdzny5xE9hbbtGoyJiX8T+dndSH3AklkkOHlrvkWGpVR?=
 =?us-ascii?Q?iHLQGeo0DglZ8q9XaTnWahtgIQKZ6Q5lPYXEo2jJf7yvwztjTREik/K+93rq?=
 =?us-ascii?Q?x5tBICWrYNahStvADyYiU28Z9DyzHHYYEswMKAib5j0Y/2xspecvrTJc90d/?=
 =?us-ascii?Q?GvJRdTag0lsmHrXh/DILutOIYLQWYfRd8qjihhx+MZcn62c2AosPW3Mvbbla?=
 =?us-ascii?Q?cePhWuUqxnH6B0OahJt243fo+ey4nzCFTw6d63XA/bPfzsiE0T5caykmCUhg?=
 =?us-ascii?Q?EFN2DGN0B5WFqQsJxq3MeXSalOeKGaBE8XA6VE5we8UcbSERihtcizB35p2f?=
 =?us-ascii?Q?AZc9eXKIG5CCyISKZJgfauKl5GpBMc6vYtlCf62bpfmritCskKaoy4dYkbN5?=
 =?us-ascii?Q?33yvZZvj7B0ciyzOVZ3uCBDb5jbDTuq2VoWnruXyPAhVgVXXX66Xiwik2yMq?=
 =?us-ascii?Q?OkAXLiXMHJy71EgflDYOSddz7sSpqUZUIvBWzZIP/Thn8Xpq36UJgzouEzQl?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06970ece-3958-45b2-5502-08db29b55a63
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 02:38:28.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gzj7Wdh6rGnIAEraEYCco3tClsz+tqtOd5NFh9tbEZ+uST3cGjIv4HVHSi4lssEFEZq+Z9TaWQu/ajS77DTsTMq8H31jfPEkGyMaomIgxDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lizhijian@fujitsu.com wrote:
[..]
> > Now I do think it would be a good idea to fail device_add() if the bus
> > is not registered,
> 
> BTW, below line 369: device_add() didn't fail in practical.
> 

I think that's ok because the device gets added, but never probed due to
this part of that commit I referenced:

@@ -503,20 +517,21 @@ int bus_add_device(struct device *dev)
  */
 void bus_probe_device(struct device *dev)
 {
-       struct bus_type *bus = dev->bus;
+       struct subsys_private *sp = bus_to_subsys(dev->bus);
        struct subsys_interface *sif;
 
-       if (!bus)
+       if (!sp)
                return;
 

...so it does what you want which is disable the libnvdimm subsystem
from binding to any devices without crashing.
