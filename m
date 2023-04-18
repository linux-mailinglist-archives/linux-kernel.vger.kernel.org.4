Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC576E5594
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDRAHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDRAHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:07:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F273F4C11;
        Mon, 17 Apr 2023 17:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681776436; x=1713312436;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pCBdV4oXiCn7X8BXqbHvMlrvtXzERhXse8oD9JTQvPM=;
  b=jiryFFxDuXh+RghOm80jor+fA1KyqgNafhOjLia8U8tC4gQXz5NGM1ka
   aekdG0DDBMdwGCEmSpwZAntVYYDoUZ+gbX3nKWwJsPnCkI5ilY96Nxs4i
   amJtLp9/T0LQG5D9YBPLiyabG7YyIqq4c0cD/EMcDMcUIlaszzIYsSRoI
   nGpAzkDSRNVViXajsNm3x28bIdhtKPOv75sB4nN8ymDHYHdOxyTA4Jlw9
   5OlFz11MeC8Qzh1MpFaRAzUM4HP+7krnhcdtDXJd2J7M4ytnAHFuFCVoA
   89irOWIfeiEOfo8WQgQy97kLdSDf2kaheqWqiitsOWvzzD6K9iUvScq4w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410253746"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="410253746"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 17:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="760139209"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="760139209"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 17 Apr 2023 17:07:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 17:07:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 17:06:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 17:06:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 17:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1ApUYoMK1DXy6spj8spOABjg3umUz9XU6Rro7NPvjrZhyggGKorMWWPrlNoPuZxAcr/fjcIBLOVmpYS0WIAlbPzJp5IMcOj2Q2xdL2WlmX2QEzdF1i3BoscTd8/0+GJNu1vy7nNqkEXBEWMa5gVjOS6Xj6JUgdDeUaELGqwZnf6mjQ3Ln/VX4/GCUcyfAk5S/55d1Rz1xcFyqsLjkDzdImjFN7c3NHxv/Kw/8V/9sj5ThUJ4iuUqPkMD+YnR9C9S8LR53d/qasz7aFzrH1VghTZCgKuqT8F7LL4IBqvWeU5r+yFNbcUeRyHbThsYZLF3Yuvt/609C12EfAPzWDvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z/rR7fHZgoFe3nugwEvvNnRpdi54SNktsrTQehD9yM=;
 b=PszwsIexCHlzQilgeOfeNY2ezBBD8hT8iQ1RD4bg0aNWQmIYp/MmruZKkasjta/4VYKBDh3aiJ9QYjV8OZOj05/XjAx4EL/yoN174+PUDbUNjjogxcYhQgNLVuZBB17V17K+OBmBr9gwtLUHVKsCgdLNO2cr2bEc6xGjH37yaBYtjrBxt475E8dNdIwAeVcbhtgdhILBQfw+Sk3GQsDh3exuHlWES3o+FHg38YgEA9t5XzyFvhNKM/wcGK1o00ruQtD+UHrkD7gfctOwhUIIpgyeT7uj8050fzolb3osO023vo6IbkI5rHrqiTQo9YnDixu/eDeD40BleXyCw/xuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7684.namprd11.prod.outlook.com (2603:10b6:8:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 00:06:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 00:06:35 +0000
Date:   Mon, 17 Apr 2023 17:06:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
Message-ID: <643ddf0869622_1b662946@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230411180302.2678736-5-terry.bowman@amd.com>
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: cde3a836-8fd8-4fbb-e6af-08db3fa0c599
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5g870ZcgMIhizd4A6I4tFwrsJA71fo5axRCye7XFB117wvef6T7v36C/feS9lFG+yw848DMiR8uIugTTqSp/bezhhjDhXDGIpPha++2sxTQ6ONDUMUVHay1nfQTyx0pMPjA3+GQn28TOcmR8QYBE9emuysDhmgJuPCyPF2ZXxOFIr/GHgqWXJFRbfjSyeWjzjDHX3mlQtY3feDdfWZQa03KUaTIXNsw1AUiUL5cZnhBinQEg3ISa4PV95P1UxKdHlFwmNOSS1iOLagPF7ssIZ4j8Xfyip3oKgDUm6TCtZh51zE3t4uK5dmB2JMNzlc2v2obIZ1HPfbbK13Y/QGDzT92q55LxEfmBewZ9TFTGdGHhgFR5HyjYcccykEeiGdUDOa0UiNWvuTgDT6aLCIrtVfHxPfa0xbm+YTuveN1cc6ofrnh5EF3yrtA7V8wY4Qh6OTZiePymkkRytmh2ntooz83YyQVKP1mEwwBZ1S4fQVszQCmzwAqpGAV9x4vZlkQ3+vipY/UjD+oKjTkglJSJn4VYJSF/4QpDAjAkYu0s+d1cNmTKWU8afUadnzo9m9N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(478600001)(6666004)(38100700002)(8936002)(8676002)(316002)(82960400001)(41300700001)(4326008)(66556008)(66946007)(66476007)(186003)(2906002)(6512007)(26005)(9686003)(6506007)(86362001)(83380400001)(5660300002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qOsIp6OWUAEifit7kk2MqtVT05Mw3ZmrDotZantwTy/Ol/D3o0/0s74vro2k?=
 =?us-ascii?Q?ujnAW702aLkSErprpGXaBeOSW0keoIULgo02xgKF77uwJoNtKUs1L7pyV4oT?=
 =?us-ascii?Q?e9PFjLxAgDfmeQds0bys4wDAZIrbnQG+GTVLqCyBnaoa71bJRUqtAWj9YoS1?=
 =?us-ascii?Q?BBYMMorKpHSHYFUbezJgLSfVVocfITL0wxhNnKkkps0hDII3fpfz5xiBteqX?=
 =?us-ascii?Q?o7BJtnr8yNGhgNyUIHoloHq0SGVmeyeVeCVU2lZelD5mSgkrbWQvU7sPXNwK?=
 =?us-ascii?Q?4jFZjfp3Ak5Ij0blC+f9kIlq0EDFdcIJuXvpN0y8tRkLjCKLh61VURpK40W9?=
 =?us-ascii?Q?Gub1uL+1UCDAuKKQSDZTixgKbwYSepXSnm3dYFd9VlPS3YTymQnBmn2ighkM?=
 =?us-ascii?Q?zyRa7BAQ2teArD2Kqrk+6eDu6CE/62kKUg7z9Y4iIUpyLk6eae6j3WcPBafh?=
 =?us-ascii?Q?r9XTklkgWv4dm4kpIAnzl/bmSqWlRBZLbNfuQ03kSxt0sBRlrZBzEEmZKFQQ?=
 =?us-ascii?Q?kgD/OxOJHm13ODvre9G7dldTqK1cDfZ47iurRQn9G3u0idm1mj1jB1GD/DPb?=
 =?us-ascii?Q?wsMERJwqRGekDqYwMgakahXy2MIO3dwu3sbFPSvCDcziG9BEifWRndUY1j7Q?=
 =?us-ascii?Q?V1LC0lPmz4Oddkdcibb64fmq0w/qJb/lA0pnahHnS5WjuaUR0nD4oMkatq8W?=
 =?us-ascii?Q?LSFcOY4+509tv5VGcoau124dm334IrrA4P0e+3G494fKDH5DKZQbEzZpMhJ+?=
 =?us-ascii?Q?wRPZEdE+zFdboNZByg/ttai2mF5z8uD9C78cASFduauGK2bajlY+iLA4HYPq?=
 =?us-ascii?Q?msgcP5oYiFJ+EaommjnzrHRTBqdqCjkR2pdteY/jskvuwYf0waapTYFSZTvw?=
 =?us-ascii?Q?qrzzp4uvo67FitU6iukeBgy20j7P0WBey5Sn5IMX4v3DsfON4kavhPS7xiDA?=
 =?us-ascii?Q?BJpgbff5JFQteXHITwHGcnfYT3djPHzN3vCLiRH+4ic6GJ+b5ZHOYYM6ZMji?=
 =?us-ascii?Q?uLQLkaqmXCiMJUHZghyb3GZazBcmX+MbP/NU0qahEB9CQ6xQ5c5gwSTJAUjh?=
 =?us-ascii?Q?m8X/IapZbO4pXDPz4LPqotcGQ4nxLRKtRMblb2jubYVa66iWu9GMkZvzWtWI?=
 =?us-ascii?Q?nhE5uPIJlkrbzuBKNwKzHiriG7f+eZ4N2vfLvHcflbQJFlRhAe/ExZoocChS?=
 =?us-ascii?Q?lePl+9sThLOjYN6ICwXPzAAQL42FwfMOCv3enjRTZx+W1ti126/eFj6FGw/U?=
 =?us-ascii?Q?z1crgil+G98KDi84l8C2UEKdiBcTTcYWw/9ycCODAOL98xNCaAWiObn5CkFo?=
 =?us-ascii?Q?jcP5g0WGLHxdhkNx7Af0HBoRCJrHaiNWxu1U0GvDYqX7cJbBWi8O+abQLMc1?=
 =?us-ascii?Q?U87gZM/z/EQhaXpzvjiX1nExw7TP8IqqO0AlNOHHsRVw7FWNYDz8sc1zAJy0?=
 =?us-ascii?Q?FcAPkHsXx8Dn/V3iwDn2+M99StMpGb1fSu41tPSDxhpcwz/K72hPOH2jXBDx?=
 =?us-ascii?Q?vX2bP/GLWffTatZWB2SCKp9kETTw3UFI6HGCFdYOtovk064cVqSkx9Qa2/zb?=
 =?us-ascii?Q?NY6YYM3kfMxZ6L9AdCuljiuxSyGpX+EL3tNQRObYWq4vJwE6qtm5/qZlSGHj?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cde3a836-8fd8-4fbb-e6af-08db3fa0c599
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 00:06:34.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If4a4IyjghfvPEGSDnUPUAKxZTNVBH0Nd7Hgv41goekKRagiK1/Xy7a09MuEiVU5umUjhOZuxr4EDH/FyQFppX8nIBfthasMOTvTdKNtbSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7684
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> RCH downstream port error logging is missing in the current CXL driver. The
> missing AER and RAS error logging is needed for communicating driver error
> details to userspace. Update the driver to include PCIe AER and CXL RAS
> error logging.
> 
> Add RCH downstream port error handling into the existing RCiEP handler.
> The downstream port error handler is added to the RCiEP error handler
> because the downstream port is implemented in a RCRB, is not PCI
> enumerable, and as a result is not directly accessible to the PCI AER
> root port driver. The AER root port driver calls the RCiEP handler for
> handling RCD errors and RCH downstream port protocol errors.
> 
> Update mem.c to include RAS and AER setup. This includes AER and RAS
> capability discovery and mapping for later use in the error handler.
> 
> Disable RCH downstream port's root port cmd interrupts.[1]
> 
> Update existing RCiEP correctable and uncorrectable handlers to also call
> the RCH handler. The RCH handler will read the RCH AER registers, check for
> error severity, and if an error exists will log using an existing kernel
> AER trace routine. The RCH handler will also log downstream port RAS errors
> if they exist.

I think this patch wants a lead in refactoring to move the existing
probe of the CXL RAS capability into the cxl_port driver so that the RCH
path and the VH path can be unified for register mapping and error
handling invocation. I do not see a compelling rationale to have 2
separate ways to map the RAS capability. The timing of when
cxl_setup_ras() is called looks problematic relative to when the first
error handler callback might happen.

For example what happens when an error fires after cxl_pci has
registered its error handlers, but before the component registers have
been mapped out of the RCRB?

This implies the need for a callback for cxl_pci to notify the cxl_port
driver of CXL errors to handle relative to a PCI AER event.
