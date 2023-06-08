Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FB77287A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjFHTJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjFHTJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:09:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB6C2D4F;
        Thu,  8 Jun 2023 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686251338; x=1717787338;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YEM0emHQs+4bGLvdglF3s4HbEKNrlrI4Dt70hLT3TxI=;
  b=lPshTlC1jpZhixkFdlvYZws+qb1Jwg2hFbbqauL39i6WtZwMjC5Tah0c
   JWZcVEZ4HWUdSvmrHSBifyznCVI2uva/OzFGCPoonxm/9hKmHHtl8/qOl
   61ak0OQ7OTtP30Rpz+cQwSW/U8km0fHB3hnJwLDXDnczzuG+oLnDkfIbJ
   fDW+ZrlJpm3Qg4tZOKrgU9hRgIhLQZKU+IE8YYXBCsw/r+xywQkCZTOUn
   7/KRvaGVhmMJEqGZvMh3lawrpC/6mwdSCjRnan80CUO/7l6vIXY6VXpNY
   IctejPZXcERSj2it1cW+xdiCVYrcfsw+POpNjYIGbz50NbXUplis3A7yb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="385757108"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="385757108"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 12:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="780003330"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="780003330"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2023 12:08:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 12:08:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 12:08:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 12:08:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 12:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj0h6BCiohIanhDqy9hYr1ryM52d9ylEOqF5Md5jY667b8o/qDIrokwcNv09tLbZ8JHlHcAKqTL/BK+Y+cZK52NSZijQbZqzL2ymsXm58/pg8i1ojMzSR5LCR3z2ohPTgCs+1RRMAgmrt6ECY7VVthtFrTM5Ieo4SglGBaOp5sw6oDbm0O/r8kcQZqlRg3m2esQF7LAXYkGiy/vSHp2IsXuoRc99gqEeZeKyIGC9aQ9WtTal7ZTNNMuHIYy+53gEfd/odsMMiujZYx2Ar/IE2rgu9qQvTb/pzNBUCZl3wX3Ls9kvTJYb0lyfZWYVxt3yaqgHyS4DpUj1A3gVzMN8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxmNwnr6aeo7jGoj0FEupopZYd5qsDw1wHVPEURyhDA=;
 b=Dvl9v2KHGGNjcz7bbx9Wb1fXLVz4mAoPOaimzcH/caYU11WqHnCBW/sXBH7ibQhzxlmt2mCTQXOUAlhZ6pxWce1bPnT/vx+fp1ZJZ2ocu2TwSLMlJ6IowPPzSyvhYqINFwe3mOrRRyPBB3ZQNQ2Gu9WsJvt93jBL/VQckIq1/bi1OY5NerxEXsmQ/RJVFHuvnQ6TdFX/Ss8wfaa/+WOUtQVbY7wRGf26Mccg7daVf/nMHAYHxW5tlKpy6hpJpImcoB9Xna2zbhr5pgeruItSxcseYjZgYASBRwhXJanTcF87whsp1R5MK1Q/CkkpF/Ns2zD3HzXn0JK6q13p0MFY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 19:08:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 19:08:53 +0000
Date:   Thu, 8 Jun 2023 12:08:48 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <Terry.Bowman@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v5 03/26] cxl: Rename member @dport of struct cxl_dport
 to @dev
Message-ID: <648227401791a_1433ac294d6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-4-terry.bowman@amd.com>
 <64817846759c9_e067a294f5@dwillia2-xfh.jf.intel.com.notmuch>
 <80c27ea8-4d82-a41d-1ccb-17d8da974faa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80c27ea8-4d82-a41d-1ccb-17d8da974faa@amd.com>
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce8e852-1243-4cd1-acf3-08db6853cc0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5n04TkitM9JWMDxqYG4xraD1a7WGa8Cg03yNt98pPtnm4IRJcxyqj3mP+EleO2fCqjkabAGinVp2q2r4DCFT835HPQIk50wPqCVEPzbruGBvg5RxIzHlq2XKqzWkZPPzTPjDWOy+kZOfRIbOjk9l0MX5CTGyqDe1L4Zw2Mdj/Wnxa4WFA4iWxBzTUeLJcPdO36SJqtvz3iNaajKYoQi9OR4UOtTsD9uZW6/9MDTvCUDl26tSyKnvRKYjHxQZBh8kVKDVtKWhqwlg5Z95eE8IY8dXyR9Nrgx58fpqOwxTV5bQqFERGPrxqCrwZdHtiTmiEUPobfs9aBrYkBXrgNKdM5cAxoYMA8CbJW2khyKEh08suLogUs8JKp75+bb5fYD0fi+mR2yQYmJ8uvvsMg9MST9VI4WPImCPYFphMqIPw8nM2rIdI/Y9fwsqHPZ42ICGN+jq9WOXJwWUGoKUCNSySzkWwlA+Y3umEThR/9ra/5oA6028sdRtOimgI8lTYDjL1OPp1yVuEDYKd9SNexuOUB0XKrzILNIks2qXmwFasbMf6PAHlWro5cvgoNUkTiR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(41300700001)(6486002)(316002)(83380400001)(86362001)(186003)(26005)(9686003)(6512007)(53546011)(6506007)(2906002)(30864003)(82960400001)(38100700002)(5660300002)(8936002)(8676002)(66946007)(66556008)(66476007)(110136005)(478600001)(6666004)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMU/taNDm7aQ+7iSeI+pafTP3F1bvXo+m2Jph9PyJPO19UClaE1xPqpUSHmv?=
 =?us-ascii?Q?Sidd3wzotyEiJaCa+TzZhYxZ8pRjyHr19MxUBnkdoIUx9L/XMpIfVjMhzIh6?=
 =?us-ascii?Q?vLrawTxQSsEpmwE23RBCnS9JTSh9WEJYg/gh+0TbfMi78qRRhs4FnUaTCLXi?=
 =?us-ascii?Q?1/BUVN5N+Gm7D5GXd4r6d4QtT8koL4rd9NWsMRE8VHxU8y7OBigWoQPO0T8e?=
 =?us-ascii?Q?32OhOkC47YFapDHNqZJyrRSkkLvn+MI47/QVLE8C/PTapMpiHw7vLgVmLiwX?=
 =?us-ascii?Q?NIYZJfQi8QA8v41lny9Xf2Cb/d8aAXMMAH/C+mXXdUXRKmPULwsArERKx1C2?=
 =?us-ascii?Q?TuFmUMKsMvzqjElygNUHnSX0HfoO4Q9YyrFa/7+dtHzh3IrrKQTXUKNSzVgP?=
 =?us-ascii?Q?1wN7T3NydfOBYmJ/UI/RyQ7gqNj5ykkBhN8MpHJaHFlPR2X7o3TPtqx/RtMq?=
 =?us-ascii?Q?yIgT4WhNNMFyopD2CrUMSXmtAmYkRL3sY/B6NyWadbgLijodtnx4MCOx7IGp?=
 =?us-ascii?Q?hPi3VDQm4nbvyQatfUVvCSvGbZpmbyk1Uheb3K/2IGV53RxaQcOOZ1crRs9t?=
 =?us-ascii?Q?UxgOr9EFQm1b7Iy3Kauj9897bqp0g2pjj61goHP1k1ZA9PvjarcmSAqTgbuo?=
 =?us-ascii?Q?Sz80c1W8cYRuwHTReaDp91b0lnf1/AoeYoc47Jcve/C2gHLoKsUidh+2P3xD?=
 =?us-ascii?Q?37m01dXeWlPQ0ShPp0AQYF1P9399wXTe+G3z8lv+EAi+vnsPM4ZTCEQyEPxL?=
 =?us-ascii?Q?vrHbMgGySscklGcPz2hxbVImT6iEZAinxWWcatMPVFOXLq2/HyyPb1pBK6qE?=
 =?us-ascii?Q?BZd2NOEiApijbZFw6/f1PY1yADI1GoKmbFfYJnAkSOsyQoLEAQl6SJlRCFqW?=
 =?us-ascii?Q?x2bh8qMZSthFN6k890Fj/vTRV3X0+69KzphV0bwkk8Vq5ZOmECXdZrE7Qib5?=
 =?us-ascii?Q?ghfxJ0UWVKqKAFIZ70DS4UgbzdSmd/n074fKENu2iTKLrF+FxrlHnsZbXlK6?=
 =?us-ascii?Q?jOOQlBe8XSPPQZwpuCi6yu2QyOUBC2RQ7k1UBCWYgvcSQZg1aGflNSa+cBR0?=
 =?us-ascii?Q?VEy+VqTzVDN9sDktnuH1WakH2mF8aEjbBFGXIDco++kRHqpFc7tunZx4xNDk?=
 =?us-ascii?Q?aGcftuRBplq8R3Y0NJJaxGSDN21TPxpQlPw1BGZu4j3zTRcguXQgom46jA0Q?=
 =?us-ascii?Q?Lo/JAyBkYxQ/hL/Mru8nppaLvJT9sH+ra4XoaCyTvtzrLchdsBcH7yBnuS9G?=
 =?us-ascii?Q?MDNLOG7wgn8XU7+I81Sv5xomHuEJ5Mggxu911c2CcpfkPKZqA7qPEG8dUeil?=
 =?us-ascii?Q?gdKMRENep1ek0sVfL4kEy0rQ/vhoy1gOE7S/KyZZaRTcQn1ECa4WB1wGwjFk?=
 =?us-ascii?Q?tEQ8gxPZpuGDQf3oTARSQpjI3EfSXfASpIubVxlElUhUt4XmhsjormzDVHQM?=
 =?us-ascii?Q?GCd9FSXf/Ne/G3fUkQ7VTll0HwEesMp4TwMJjxdoBmbEnEcwTRE9Xn9wIMkn?=
 =?us-ascii?Q?4BSSwlZCFzAh1pW09juycQfQCPBMJVRm2wOVwkz0udQc2JiTQjPxL18zR5yx?=
 =?us-ascii?Q?v6cVdRHy2G6y976/zmIFeGeU7DuNyY0ldDck69sF85W4IeUAGYmPLlQQbZVo?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce8e852-1243-4cd1-acf3-08db6853cc0f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:08:52.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91FF5yyeYD9WBtbcCyYSbH/xp6EcNXsI0NqB66SBFd/KMwZBGtexp3FLRyz9HOOGc9ngXG1fF7Hy+PWs5BrgWq4Njr+AKKVko9uU7uMlack=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> Hi Dan,
> 
> 
> On 6/8/23 01:42, Dan Williams wrote:
> > Terry Bowman wrote:
> >> From: Robert Richter <rrichter@amd.com>
> >>
> >> Reading code like dport->dport does not immediately suggest that this
> >> points to the corresponding device structure of the dport. Rename
> >> struct member @dport to @dev.
> > 
> > This one I don't agree with.
> > 
> > This can switch to ->dport_dev if you like. The reason for ->dport was
> > for symmetry with the ->uport of a 'struct cxl_port'. So if you change
> > this to ->dport_dev then also make the ->uport_dev change for symmetry.
> > 
> > Unlike a 'struct cxl_port' a 'struct cxl_dport' is not a device in its
> > own right which is what I see when I read dport->dev.
> >
> 
> Ok, I'll change the structure member names and code to use the following:
> struct cxl_dport::dev  -> struct cxl_dport::dport_dev
> 
> struct cxl_port::uport -> struct cxl_port::uport_dev

Sounds good, to save duplication of work I already have this that you
can just adopt:

-- >8 --
Subject: cxl: Rename 'uport' to 'uport_dev'

From: Dan Williams <dan.j.williams@intel.com>

For symmetry with the recent rename of ->dport_dev for a 'struct
cxl_dport', add the "_dev" suffix to the ->uport property of a 'struct
cxl_port'. These devices represent the downstream-port-device and
upstream-port-device respectively in the CXL/PCIe topology.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c        |    4 +--
 drivers/cxl/core/port.c       |   61 ++++++++++++++++++++++-------------------
 drivers/cxl/core/region.c     |   48 +++++++++++++++++---------------
 drivers/cxl/cxl.h             |   13 +++++----
 drivers/cxl/cxlmem.h          |    4 +--
 drivers/cxl/mem.c             |    2 +
 drivers/cxl/port.c            |    2 +
 tools/testing/cxl/test/cxl.c  |   20 +++++++------
 tools/testing/cxl/test/mock.c |   10 +++----
 9 files changed, 86 insertions(+), 78 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 67f4ab6daa34..375f01c6cad6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -67,7 +67,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 
 /**
  * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
- * @port: cxl_port whose ->uport is the upstream of dports to be enumerated
+ * @port: cxl_port whose ->uport_dev is the upstream of dports to be enumerated
  *
  * Returns a positive number of dports enumerated or a negative error
  * code.
@@ -622,7 +622,7 @@ static int cxl_cdat_read_table(struct device *dev,
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct device *host = cxlmd->dev.parent;
 	struct device *dev = &port->dev;
 	struct pci_doe_mb *cdat_doe;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 93800e6e095f..a45a063d52ce 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -561,9 +561,9 @@ static void unregister_port(void *_port)
 	 * unregistered while holding their parent port lock.
 	 */
 	if (!parent)
-		lock_dev = port->uport;
+		lock_dev = port->uport_dev;
 	else if (is_cxl_root(parent))
-		lock_dev = parent->uport;
+		lock_dev = parent->uport_dev;
 	else
 		lock_dev = &parent->dev;
 
@@ -583,7 +583,8 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
 {
 	int rc;
 
-	rc = sysfs_create_link(&port->dev.kobj, &port->uport->kobj, "uport");
+	rc = sysfs_create_link(&port->dev.kobj, &port->uport_dev->kobj,
+			       "uport");
 	if (rc)
 		return rc;
 	return devm_add_action_or_reset(host, cxl_unlink_uport, port);
@@ -614,7 +615,7 @@ static int devm_cxl_link_parent_dport(struct device *host,
 
 static struct lock_class_key cxl_port_key;
 
-static struct cxl_port *cxl_port_alloc(struct device *uport,
+static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 				       resource_size_t component_reg_phys,
 				       struct cxl_dport *parent_dport)
 {
@@ -630,7 +631,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	if (rc < 0)
 		goto err;
 	port->id = rc;
-	port->uport = uport;
+	port->uport_dev = uport_dev;
 
 	/*
 	 * The top-level cxl_port "cxl_root" does not have a cxl_port as
@@ -660,10 +661,11 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 		else if (parent_dport->rch)
 			port->host_bridge = parent_dport->dport_dev;
 		else
-			port->host_bridge = iter->uport;
-		dev_dbg(uport, "host-bridge: %s\n", dev_name(port->host_bridge));
+			port->host_bridge = iter->uport_dev;
+		dev_dbg(uport_dev, "host-bridge: %s\n",
+			dev_name(port->host_bridge));
 	} else
-		dev->parent = uport;
+		dev->parent = uport_dev;
 
 	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
@@ -687,7 +689,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 }
 
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
-					    struct device *uport,
+					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
 					    struct cxl_dport *parent_dport)
 {
@@ -695,12 +697,12 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	struct device *dev;
 	int rc;
 
-	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
+	port = cxl_port_alloc(uport_dev, component_reg_phys, parent_dport);
 	if (IS_ERR(port))
 		return port;
 
 	dev = &port->dev;
-	if (is_cxl_memdev(uport))
+	if (is_cxl_memdev(uport_dev))
 		rc = dev_set_name(dev, "endpoint%d", port->id);
 	else if (parent_dport)
 		rc = dev_set_name(dev, "port%d", port->id);
@@ -735,28 +737,29 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 /**
  * devm_cxl_add_port - register a cxl_port in CXL memory decode hierarchy
  * @host: host device for devm operations
- * @uport: "physical" device implementing this upstream port
+ * @uport_dev: "physical" device implementing this upstream port
  * @component_reg_phys: (optional) for configurable cxl_port instances
  * @parent_dport: next hop up in the CXL memory decode hierarchy
  */
-struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
+struct cxl_port *devm_cxl_add_port(struct device *host,
+				   struct device *uport_dev,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port, *parent_port;
 
-	port = __devm_cxl_add_port(host, uport, component_reg_phys,
+	port = __devm_cxl_add_port(host, uport_dev, component_reg_phys,
 				   parent_dport);
 
 	parent_port = parent_dport ? parent_dport->port : NULL;
 	if (IS_ERR(port)) {
-		dev_dbg(uport, "Failed to add%s%s%s: %ld\n",
+		dev_dbg(uport_dev, "Failed to add%s%s%s: %ld\n",
 			parent_port ? " port to " : "",
 			parent_port ? dev_name(&parent_port->dev) : "",
 			parent_port ? "" : " root port",
 			PTR_ERR(port));
 	} else {
-		dev_dbg(uport, "%s added%s%s%s\n",
+		dev_dbg(uport_dev, "%s added%s%s%s\n",
 			dev_name(&port->dev),
 			parent_port ? " to " : "",
 			parent_port ? dev_name(&parent_port->dev) : "",
@@ -773,33 +776,34 @@ struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port)
 	if (is_cxl_root(port))
 		return NULL;
 
-	if (dev_is_pci(port->uport)) {
-		struct pci_dev *pdev = to_pci_dev(port->uport);
+	if (dev_is_pci(port->uport_dev)) {
+		struct pci_dev *pdev = to_pci_dev(port->uport_dev);
 
 		return pdev->subordinate;
 	}
 
-	return xa_load(&cxl_root_buses, (unsigned long)port->uport);
+	return xa_load(&cxl_root_buses, (unsigned long)port->uport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_port_to_pci_bus, CXL);
 
-static void unregister_pci_bus(void *uport)
+static void unregister_pci_bus(void *uport_dev)
 {
-	xa_erase(&cxl_root_buses, (unsigned long)uport);
+	xa_erase(&cxl_root_buses, (unsigned long)uport_dev);
 }
 
-int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
+int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 			      struct pci_bus *bus)
 {
 	int rc;
 
-	if (dev_is_pci(uport))
+	if (dev_is_pci(uport_dev))
 		return -EINVAL;
 
-	rc = xa_insert(&cxl_root_buses, (unsigned long)uport, bus, GFP_KERNEL);
+	rc = xa_insert(&cxl_root_buses, (unsigned long)uport_dev, bus,
+		       GFP_KERNEL);
 	if (rc)
 		return rc;
-	return devm_add_action_or_reset(host, unregister_pci_bus, uport);
+	return devm_add_action_or_reset(host, unregister_pci_bus, uport_dev);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, CXL);
 
@@ -920,7 +924,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	int rc;
 
 	if (is_cxl_root(port))
-		host = port->uport;
+		host = port->uport_dev;
 	else
 		host = &port->dev;
 
@@ -1374,7 +1378,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		rc = PTR_ERR(port);
 	else {
 		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
-			dev_name(&port->dev), dev_name(port->uport));
+			dev_name(&port->dev), dev_name(port->uport_dev));
 		rc = cxl_add_ep(dport, &cxlmd->dev);
 		if (rc == -EBUSY) {
 			/*
@@ -1436,7 +1440,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		if (port) {
 			dev_dbg(&cxlmd->dev,
 				"found already registered port %s:%s\n",
-				dev_name(&port->dev), dev_name(port->uport));
+				dev_name(&port->dev),
+				dev_name(port->uport_dev));
 			rc = cxl_add_ep(dport, &cxlmd->dev);
 
 			/*
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 13cda989d944..39825e5301d0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -906,10 +906,10 @@ static int cxl_port_attach_region(struct cxl_port *port,
 
 	dev_dbg(&cxlr->dev,
 		"%s:%s %s add: %s:%s @ %d next: %s nr_eps: %d nr_targets: %d\n",
-		dev_name(port->uport), dev_name(&port->dev),
+		dev_name(port->uport_dev), dev_name(&port->dev),
 		dev_name(&cxld->dev), dev_name(&cxlmd->dev),
 		dev_name(&cxled->cxld.dev), pos,
-		ep ? ep->next ? dev_name(ep->next->uport) :
+		ep ? ep->next ? dev_name(ep->next->uport_dev) :
 				      dev_name(&cxlmd->dev) :
 			   "none",
 		cxl_rr->nr_eps, cxl_rr->nr_targets);
@@ -984,7 +984,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	 */
 	if (pos < distance) {
 		dev_dbg(&cxlr->dev, "%s:%s: cannot host %s:%s at %d\n",
-			dev_name(port->uport), dev_name(&port->dev),
+			dev_name(port->uport_dev), dev_name(&port->dev),
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
 		return -ENXIO;
 	}
@@ -994,7 +994,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	if (ep->dport != ep_peer->dport) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: %s:%s pos %d mismatched peer %s:%s\n",
-			dev_name(port->uport), dev_name(&port->dev),
+			dev_name(port->uport_dev), dev_name(&port->dev),
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos,
 			dev_name(&cxlmd_peer->dev),
 			dev_name(&cxled_peer->cxld.dev));
@@ -1026,7 +1026,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	 */
 	if (!is_power_of_2(cxl_rr->nr_targets)) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
-			dev_name(port->uport), dev_name(&port->dev),
+			dev_name(port->uport_dev), dev_name(&port->dev),
 			cxl_rr->nr_targets);
 		return -EINVAL;
 	}
@@ -1076,7 +1076,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	rc = granularity_to_eig(parent_ig, &peig);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
-			dev_name(parent_port->uport),
+			dev_name(parent_port->uport_dev),
 			dev_name(&parent_port->dev), parent_ig);
 		return rc;
 	}
@@ -1084,7 +1084,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	rc = ways_to_eiw(parent_iw, &peiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
-			dev_name(parent_port->uport),
+			dev_name(parent_port->uport_dev),
 			dev_name(&parent_port->dev), parent_iw);
 		return rc;
 	}
@@ -1093,7 +1093,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	rc = ways_to_eiw(iw, &eiw);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
-			dev_name(port->uport), dev_name(&port->dev), iw);
+			dev_name(port->uport_dev), dev_name(&port->dev), iw);
 		return rc;
 	}
 
@@ -1113,7 +1113,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	rc = eig_to_granularity(eig, &ig);
 	if (rc) {
 		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
-			dev_name(port->uport), dev_name(&port->dev),
+			dev_name(port->uport_dev), dev_name(&port->dev),
 			256 << eig);
 		return rc;
 	}
@@ -1126,11 +1126,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
-				dev_name(port->uport), dev_name(&port->dev),
+				dev_name(port->uport_dev), dev_name(&port->dev),
 				__func__, iw, ig, p->res);
 			dev_err(&cxlr->dev,
 				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
-				dev_name(port->uport), dev_name(&port->dev),
+				dev_name(port->uport_dev), dev_name(&port->dev),
 				__func__, cxld->interleave_ways,
 				cxld->interleave_granularity,
 				(cxld->flags & CXL_DECODER_F_ENABLE) ?
@@ -1147,20 +1147,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			.end = p->res->end,
 		};
 	}
-	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
+	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
 		dev_name(&port->dev), iw, ig);
 add_target:
 	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: targets full trying to add %s:%s at %d\n",
-			dev_name(port->uport), dev_name(&port->dev),
+			dev_name(port->uport_dev), dev_name(&port->dev),
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
 		return -ENXIO;
 	}
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
 			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
-				dev_name(port->uport), dev_name(&port->dev),
+				dev_name(port->uport_dev), dev_name(&port->dev),
 				dev_name(&cxlsd->cxld.dev),
 				dev_name(ep->dport->dport_dev),
 				cxl_rr->nr_targets_set);
@@ -1172,7 +1172,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 out_target_set:
 	cxl_rr->nr_targets_set += inc;
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
-		dev_name(port->uport), dev_name(&port->dev),
+		dev_name(port->uport_dev), dev_name(&port->dev),
 		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
 		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
 
@@ -1492,7 +1492,7 @@ static int cmp_decode_pos(const void *a, const void *b)
 	if (!dev) {
 		struct range *range = &cxled_a->cxld.hpa_range;
 
-		dev_err(port->uport,
+		dev_err(port->uport_dev,
 			"failed to find decoder that maps %#llx-%#llx\n",
 			range->start, range->end);
 		goto err;
@@ -1507,14 +1507,15 @@ static int cmp_decode_pos(const void *a, const void *b)
 	put_device(dev);
 
 	if (a_pos < 0 || b_pos < 0) {
-		dev_err(port->uport,
+		dev_err(port->uport_dev,
 			"failed to find shared decoder for %s and %s\n",
 			dev_name(cxlmd_a->dev.parent),
 			dev_name(cxlmd_b->dev.parent));
 		goto err;
 	}
 
-	dev_dbg(port->uport, "%s comes %s %s\n", dev_name(cxlmd_a->dev.parent),
+	dev_dbg(port->uport_dev, "%s comes %s %s\n",
+		dev_name(cxlmd_a->dev.parent),
 		a_pos - b_pos < 0 ? "before" : "after",
 		dev_name(cxlmd_b->dev.parent));
 
@@ -2059,11 +2060,11 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	if (rc)
 		goto err;
 
-	rc = devm_add_action_or_reset(port->uport, unregister_region, cxlr);
+	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
 	if (rc)
 		return ERR_PTR(rc);
 
-	dev_dbg(port->uport, "%s: created %s\n",
+	dev_dbg(port->uport_dev, "%s: created %s\n",
 		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
 	return cxlr;
 
@@ -2191,7 +2192,7 @@ static ssize_t delete_region_store(struct device *dev,
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
-	devm_release_action(port->uport, unregister_region, cxlr);
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
 	put_device(&cxlr->dev);
 
 	return len;
@@ -2356,7 +2357,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
 
 	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
 	if (rc == 1)
-		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport), &ctx);
+		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
+					     &ctx);
 
 	up_read(&cxl_region_rwsem);
 	return rc;
@@ -2732,7 +2734,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 err:
 	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport, unregister_region, cxlr);
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
 	return ERR_PTR(rc);
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7232c2a0e27c..754cfe59ae37 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -536,7 +536,7 @@ struct cxl_dax_region {
  *		     downstream port devices to construct a CXL memory
  *		     decode hierarchy.
  * @dev: this port's device
- * @uport: PCI or platform device implementing the upstream port capability
+ * @uport_dev: PCI or platform device implementing the upstream port capability
  * @host_bridge: Shortcut to the platform attach point for this port
  * @id: id for port device-name
  * @dports: cxl_dport instances referenced by decoders
@@ -555,7 +555,7 @@ struct cxl_dax_region {
  */
 struct cxl_port {
 	struct device dev;
-	struct device *uport;
+	struct device *uport_dev;
 	struct device *host_bridge;
 	int id;
 	struct xarray dports;
@@ -641,21 +641,22 @@ struct cxl_region_ref {
 /*
  * The platform firmware device hosting the root is also the top of the
  * CXL port topology. All other CXL ports have another CXL port as their
- * parent and their ->uport / host device is out-of-line of the port
+ * parent and their ->uport_dev / host device is out-of-line of the port
  * ancestry.
  */
 static inline bool is_cxl_root(struct cxl_port *port)
 {
-	return port->uport == port->dev.parent;
+	return port->uport_dev == port->dev.parent;
 }
 
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
 struct pci_bus;
-int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
+int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 			      struct pci_bus *bus);
 struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
-struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
+struct cxl_port *devm_cxl_add_port(struct device *host,
+				   struct device *uport_dev,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2845a7a69d8..76743016b64c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -72,13 +72,13 @@ cxled_to_memdev(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
 
-	return to_cxl_memdev(port->uport);
+	return to_cxl_memdev(port->uport_dev);
 }
 
 bool is_cxl_memdev(const struct device *dev);
 static inline bool is_cxl_endpoint(struct cxl_port *port)
 {
-	return is_cxl_memdev(port->uport);
+	return is_cxl_memdev(port->uport_dev);
 }
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 45d4c32d78b0..4cc461c22b8b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -163,7 +163,7 @@ static int cxl_mem_probe(struct device *dev)
 	}
 
 	if (dport->rch)
-		endpoint_parent = parent_port->uport;
+		endpoint_parent = parent_port->uport_dev;
 	else
 		endpoint_parent = &parent_port->dev;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c23b6164e1c0..4cef2bf45ad2 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -91,7 +91,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_endpoint_dvsec_info info = { .port = port };
-	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
 	struct cxl_port *root;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index f5c04787bcc8..4f62eb55f8b8 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -754,7 +754,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		/* check is endpoint is attach to host-bridge0 */
 		port = cxled_to_port(cxled);
 		do {
-			if (port->uport == &cxl_host_bridge[0]->dev) {
+			if (port->uport_dev == &cxl_host_bridge[0]->dev) {
 				hb0 = true;
 				break;
 			}
@@ -889,7 +889,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 		mock_init_hdm_decoder(cxld);
 
 		if (target_count) {
-			rc = device_for_each_child(port->uport, &ctx,
+			rc = device_for_each_child(port->uport_dev, &ctx,
 						   map_targets);
 			if (rc) {
 				put_device(&cxld->dev);
@@ -919,29 +919,29 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 	int i, array_size;
 
 	if (port->depth == 1) {
-		if (is_multi_bridge(port->uport)) {
+		if (is_multi_bridge(port->uport_dev)) {
 			array_size = ARRAY_SIZE(cxl_root_port);
 			array = cxl_root_port;
-		} else if (is_single_bridge(port->uport)) {
+		} else if (is_single_bridge(port->uport_dev)) {
 			array_size = ARRAY_SIZE(cxl_root_single);
 			array = cxl_root_single;
 		} else {
 			dev_dbg(&port->dev, "%s: unknown bridge type\n",
-				dev_name(port->uport));
+				dev_name(port->uport_dev));
 			return -ENXIO;
 		}
 	} else if (port->depth == 2) {
 		struct cxl_port *parent = to_cxl_port(port->dev.parent);
 
-		if (is_multi_bridge(parent->uport)) {
+		if (is_multi_bridge(parent->uport_dev)) {
 			array_size = ARRAY_SIZE(cxl_switch_dport);
 			array = cxl_switch_dport;
-		} else if (is_single_bridge(parent->uport)) {
+		} else if (is_single_bridge(parent->uport_dev)) {
 			array_size = ARRAY_SIZE(cxl_swd_single);
 			array = cxl_swd_single;
 		} else {
 			dev_dbg(&port->dev, "%s: unknown bridge type\n",
-				dev_name(port->uport));
+				dev_name(port->uport_dev));
 			return -ENXIO;
 		}
 	} else {
@@ -954,9 +954,9 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 		struct platform_device *pdev = array[i];
 		struct cxl_dport *dport;
 
-		if (pdev->dev.parent != port->uport) {
+		if (pdev->dev.parent != port->uport_dev) {
 			dev_dbg(&port->dev, "%s: mismatch parent %s\n",
-				dev_name(port->uport),
+				dev_name(port->uport_dev),
 				dev_name(pdev->dev.parent));
 			continue;
 		}
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index dbeef5c6f606..da554df50bac 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -139,7 +139,7 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
 	struct cxl_hdm *cxlhdm;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_port(port->uport))
+	if (ops && ops->is_mock_port(port->uport_dev))
 		cxlhdm = ops->devm_cxl_setup_hdm(port, info);
 	else
 		cxlhdm = devm_cxl_setup_hdm(port, info);
@@ -154,7 +154,7 @@ int __wrap_devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
 	int index, rc;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_port(port->uport))
+	if (ops && ops->is_mock_port(port->uport_dev))
 		rc = 0;
 	else
 		rc = devm_cxl_enable_hdm(port, cxlhdm);
@@ -169,7 +169,7 @@ int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 	int rc, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_port(port->uport))
+	if (ops && ops->is_mock_port(port->uport_dev))
 		rc = ops->devm_cxl_add_passthrough_decoder(port);
 	else
 		rc = devm_cxl_add_passthrough_decoder(port);
@@ -186,7 +186,7 @@ int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_port(port->uport))
+	if (ops && ops->is_mock_port(port->uport_dev))
 		rc = ops->devm_cxl_enumerate_decoders(cxlhdm, info);
 	else
 		rc = devm_cxl_enumerate_decoders(cxlhdm, info);
@@ -201,7 +201,7 @@ int __wrap_devm_cxl_port_enumerate_dports(struct cxl_port *port)
 	int rc, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_port(port->uport))
+	if (ops && ops->is_mock_port(port->uport_dev))
 		rc = ops->devm_cxl_port_enumerate_dports(port);
 	else
 		rc = devm_cxl_port_enumerate_dports(port);
