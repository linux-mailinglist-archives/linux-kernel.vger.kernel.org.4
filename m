Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C072A87F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjFJCgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjFJCgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:36:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C735B6;
        Fri,  9 Jun 2023 19:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686364574; x=1717900574;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u/byKgqnsMu2FypQ4mOvwIXrylhPrs3PMsv80DwwuIE=;
  b=YHmXa9QDiG0Ed/XE3Hltn2TzpCaVzRisiVn47u93EuYcAc3ZCFPbUkKz
   bpluuF1uxTNZJofgnF4Y30JJMMxncg2RsWZws0URQP7nVdt/gK9SR+3cr
   Eo+PvLI9JfMstQcvrYY3WrO5TZrJhtYnb2eq3vtoV446SGcpa+1eKunn7
   HrSd2X2QYT2uzf0nnkZiBIdYQ2uGOtfhN6AASPiS6GMFiyIajzr56xbOB
   FOhHVG3M29eYCLEJqY2TGn8vom2SQjzgQHm/LcxuTotgHF2k6PmT50uOM
   x8CdgB9exQ9njVGt1VwTtVl36HDkCcGjqhed/BS5r3v85Ve+XzU2aIA3I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="421316255"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="421316255"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 19:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="687960666"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="687960666"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2023 19:36:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:36:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:36:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 19:36:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 19:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi9Dvh8H1xKB19aJan+OxocYIYzEt9aZRw0c+ENEFLbGSom4P2phRJrtCb3T2WklHN5sg04RxbaHqqZAzD+f1oJLGLi9EFDYFuDRY0CCv/JTq2S4l01GEgV8HhLjGj9a4OBFPI/Cr/57PQ2a+AV6GDl4Z5PrQiitLs+Zox3ew5QAlrUO68SCAo8Zkv8Rnb8GhEH38QaTTBmt0MqSAVYek4SM/QBl9H8cof2qINHsFzJJVtxY5WNcABsjZXqL1WchBdcb2N5SbWs38hanMnA9b8lxvcOGTF6d8TDA3328XopqIPShVn/XIoWMEGx/5nVa7xTGcyzxkw5W3jwaIB5vUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nm+urBfxwk+XrMAaQqF7glXGi/ywHWdf3TrEtUacag=;
 b=ceWRXvQxa/vEvDLYxg+/Al1FYnB1xxHJ85K/rxbkY874ULi8NxJ+UQ0TJUkjfLtWuekD1+YpgiFIDb2YaoVMcGKzlL+/5FAi0AHG4iWXF35wooFPizC/ebFga1oBjYjHLgJ+8tVKZyMsdz5QokSXdAElh/5kQiWtq5qcknxKSmb/m9n2lCyfCoVaspo++ov7n6yQbANh2iDSA9PgF4yAWlXpS7cdp2V6Yvkra/V8YnqjbitY3gzGETEqaxjT22mh19SMSU4c48Jdi3mmOMeQL41MujDXJbjD0Jpp8n5fGhObpDmGEF7vdx43AJQiBzH9JXEmbiQfZCYyIMxxqczbYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sat, 10 Jun
 2023 02:36:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 02:36:08 +0000
Date:   Fri, 9 Jun 2023 19:36:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 16/26] cxl/port: Remove Component Register base
 address from struct cxl_port
Message-ID: <6483e193a46bb_e067a294cd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-17-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-17-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2490c8d1-134a-4091-276a-08db695b71f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4TXpwotuzmg4pDWfbzWCvuPQNOoL+dMTxvWRnCW2pUdrHfkJ6/IdGk74LE8Ew1EDGBNz4JCsIy0AIVUI4sgvehD1LUgv6rjlzmyU6oUC7SDczbKk157DmPDyNzxrOxmr/9Tx6QsLtXJ1bo60FehgHnYkZ9/q+We5ITpwE+wPBs1yVRGgssbTas6s8Q9Fa/LVZCo/CJ+940jXOUitAELJ4GeqSz1DIwqEqne7e7vtNnYVAaMkP0Bj62fiQhfTpNbptUTiLFBzlI+DwoIcn1goAHFL9HtyTk0UXNRDfaqpz+cJkgHVC2I+a4GZl9s9PV4JBCNqYiDlnrpG070IZfV94PF7/aUEKnDNc0nZYMviFSonDS+NZYdB/flT6+08L+WivFrCzv1EK6FUzx/7lQliCMtvx4TcJsgXJBxvaHfgrxA8dDnZGeI0pQX3grocXwd7F3WSImVeLL4VoC4jgmggKgxIzw9yWubJzRal0G8fAaETTq97jt+2OtGcZRrbRbGwNO7ztVujddQakIL3C7gXr/gQVZyVRtbFyD+bFyhx6mH+hN23IU3aWw4NhqztMHZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(26005)(9686003)(6506007)(6512007)(4326008)(66946007)(66476007)(66556008)(6486002)(6666004)(186003)(316002)(478600001)(4744005)(2906002)(5660300002)(8676002)(8936002)(82960400001)(86362001)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s0lfvqXdVafvqnkPfZOAss/SEG/yAv3XNNgC73YkhIvVsPiFjp70Y59mmXbJ?=
 =?us-ascii?Q?w8gvyeL8N3AmXzVekYeuosd6V9kBXpxl1If1cn/7RU4bEWh5eWxihN7JcTWf?=
 =?us-ascii?Q?+twF6+IylwpxI4Oof7XE9ZCV3Eb8QnofIah0c04an+PInAyYziO1rzhEGOXi?=
 =?us-ascii?Q?92gynbfqpH1aDn1kmQTuL8iWFaeqp6I6FBoJ7UDhsJuYgZQqNGM3fOSfhAWR?=
 =?us-ascii?Q?cr7DRFlLKLkOQ0LznKN9Q2XeOXHoycuMLNM2cw4W5GtjcOEn1A+We5Syd7rH?=
 =?us-ascii?Q?v4MWE9/1RfMe4y5oz3Sn+HxGutw72M3obszxYjzEQhYRaQBWBDmJ612amGlu?=
 =?us-ascii?Q?RNtrJV5J2IS25L9uuA4dUUIkIbYk5sB9xH1uFz9Wb3G2jyh/Iyz3CyIKsZ6E?=
 =?us-ascii?Q?8PKcswi0gkvpT8FyEhfMw2Kw9Xejju49LmVEkZuvqajpvbF2UoDOC//xycJb?=
 =?us-ascii?Q?nFKu7gDK05/IaOF/WOUTB8lY0ZrWLeclSolNIAaito5OeSJava+NbUuKpfZz?=
 =?us-ascii?Q?aFzzwygDjadA2n+OoLza/bXwQlX0N0uUD3FW6GVFw7TTV4Jj+8HC0cVWwbJh?=
 =?us-ascii?Q?fZ7sz6jY3XcJa2l2WTaV3le4vZQ4T5iAJ5ONKJY9raAMxaMLR2ReScmMloiV?=
 =?us-ascii?Q?dui0JjMZ+W8Gd9K3mYehDO8beu17in85VZHnwN2W/u2Gk1JWVfB5xH+Bih+i?=
 =?us-ascii?Q?pT+t0nrpk3yEXGfnFiFix0VUx7eKThTTlsCbyik+D+bZGNXZrPlmSslCaZ/N?=
 =?us-ascii?Q?n5A3qC2M//M1+EWUdrmxJdKxtLhcE6AvSBKXMZOG4Vv6c3AbgZ1/ZWnu7nCm?=
 =?us-ascii?Q?LTgcnmOPFBiAm3/bLFeaGPmVVqFR/dUo/qRU0FP6zSEtQ7quXA3wz90nKHx9?=
 =?us-ascii?Q?BpHqJasW9lYEV9QGi1ntBKlDVMhvHJDCzyzv5P2Hsfg20buhfedTjRGLY3he?=
 =?us-ascii?Q?3Jxh46Jr2zYi1pLDuRiCotLmKZXVS4dlL3rw9f0f9ksT+9/QDkgkINhvM3w2?=
 =?us-ascii?Q?1+OwP/E3EiwOq1blvQYZFaKZapMeM8q9rLTxJiR+pZCNH3KM7EBi34z4Imde?=
 =?us-ascii?Q?s7p0PHTFtx88cQdKmuvkLonMHLdW7frM7GWXH4DWCg0lPrZC6iNidUkdOACl?=
 =?us-ascii?Q?mKPIQ6lDtmJPJPa9BbMCPmc+BJ8dm6EvBI6TzJT+E7FSfD3URv7t1eDGUk5r?=
 =?us-ascii?Q?3XRicv+dIIbKSPPR1NTMvVNgu1mWtTHcXuCRotiWyKqeigQOXo59/lSvn579?=
 =?us-ascii?Q?dKGCk+hV8po1ByfTf1OgOyGkAHe2V503QsrpZ3TLN3oicUxDI1K177gDeYxt?=
 =?us-ascii?Q?ssVYzdZU3dMIQAgkYqtrvOtbVtUc+J8FCM6D6RjF6DuYZgmGEelcN4z9GYO/?=
 =?us-ascii?Q?o6lG4meVadyNyU7xjDJS+niTwXECFzVzkIxJynkwuKaqTLIUNdtZDe/l5DqC?=
 =?us-ascii?Q?Ltqu2d21VtEcokCxO4KSXyYUZ1yYJuQRqom5nu1Kp08MKMWvep6xxw6rJHA2?=
 =?us-ascii?Q?5MOp7jysr6yqNFeH2pXAY7hZB9eqjWWb1MP73p3EXm257SOVfDy3GNp3d1Hd?=
 =?us-ascii?Q?YQngGq8i8nqgACct2yiGjhTz+q28u2ho68jx6IuJqfF+uh+oTexNgQo88D0l?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2490c8d1-134a-4091-276a-08db695b71f4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 02:36:08.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhN81MIuMftm1Fk9KMUY33YVtm/eZKmcEwCN1DvUt/I+Wryyu8qvrZPfOEZ+RWcvtnGSN8msnNOl8dOMA+94pnWu2Bjddh8dJoHTnuKO4fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> The Component Register base address @component_reg_phys is no longer
> used after the rework of the Component Register setup which now uses
> struct member @comp_map instead. Remove the base address.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good.
