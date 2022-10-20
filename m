Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DBE606C41
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJTX5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJTX47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:56:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4515122C826;
        Thu, 20 Oct 2022 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666310219; x=1697846219;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ISpdkIpjRf6dOIBRWCbYHoM13D6eZRMwtPCBL6vu9NI=;
  b=YQjJso//MDvXnqrBa2p7FeK9JR7opgp+E3QPT9TN3fwPx456N4DgWL08
   HAyXFTcMjOpmtvU1ZDpzQQ9uk//aoYgXHhTsGwS/oKA83pbFxIwDEuWgR
   pp3oimTlGbrKLdZrb8QT8VF8UZGMVvlKrxMiw0XK3+XNDE1Hm+cuoF1eJ
   UyeTEj/+JBCX/AEXunfxVwZhJDy5RaSm7f2NebO8dP/qzD88OaTJC4F+8
   2XW8EGHfDzI0D/Uyuzmpb5qlUkDGc1EpBV6PwpvY1kJSOngpaQBgc/gQI
   v8Xv0q4GJ/ymUZIgCsG5ojcXRJmjw2sV4f1TA0736xjWiFjkBVqm2gaNZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287268942"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="287268942"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 16:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="772690353"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="772690353"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2022 16:56:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 16:56:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 16:56:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 16:56:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 16:56:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlIOlJVdhGyOsogPJZQJOIeAiFiIT3XcCJY81M5+oGT48GKXasLt1bX2JGu08/CIFpopG997g9eb6jpaf1F6U9a1jllFmX/YRTSEUkDLq7GGbIviRjBNRs5/Q8H7u/kbX6bXbixHje89gfc3AqmviLHp+OWJP2YYs43GhC5cmfuleDtfM3vio5O/YIA32YcvBdsVLVWxOPyqnqUBciSGMMGA8tm9Kiayy0yzXsc9rCnRIzHLH9pgOp4fu6RTspRG/cDV786X+eOwafcxkNDZGOvcbXtE1gY3dlyM65UWgZdPr67F0Pk3InU777Y6jvJNO32M71i7L02cSdpDLheRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/uLPoXw1NDM1zMp5PmJHy7tQImEPeUlD0VXts9rZfY=;
 b=GV32GmjMolptFMj9ttXLaPOHjUezlNo6Y6pqInZWYWD++QRyJmK2KhtDM2WJR9JQxBofp5o6l0yf83xAeHo+XEkSs3hFPa/T+imYuHdOqOqPcoLzVVYh42pD2YfqRXMnIxV+HhJtgEsi4aEy0EL0OgxdLc4bVJV1KJ+k6E4MWR+5JyiOoEeea0UnKQNsc3aum2qyjWj07CqWmFRw+bUgi1b3zfzU20QYRZSmwYMXBWkSSa/hFsh6J/RnhXJ+OxhKL8TFBsR9EAvPVrAFJvsx+Xh2bi4fmJfw9WmELlXJlqTV/jLJIj8kiS9TZoRwyBJlDoBUxV/0ll5vF/1b4MsMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB6601.namprd11.prod.outlook.com
 (2603:10b6:806:273::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Thu, 20 Oct
 2022 23:56:55 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Thu, 20 Oct
 2022 23:56:55 +0000
Date:   Thu, 20 Oct 2022 16:56:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Robert Richter <rrichter@amd.com>,
        "kernel test robot" <lkp@intel.com>
Subject: RE: [PATCH v2 01/12] cxl/core: Remove duplicate declaration of
 devm_cxl_iomap_block()
Message-ID: <6351e043e52bf_4da329422@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018132341.76259-2-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 35377736-124f-492c-fafd-08dab2f6c43c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boPHqSSA8+Tc1eJ9oNuyXDQV2mncfPew7dIVNLDdFPCCbHUE8Jf5zD4eY/zSNZm9kD/ForFcpHAOURzzQD//K0Gk+csDfNTsz/essoF+Yvk4ZDnKpAGO6UIA/uL6gglzT/4fVOD29JFpZBxUpoieQOweUbD7fdFPVBUkjW+u10LSgDeP7aJu7Z7pA6/0ro+0B1n8zYn7ED0iJElz/CnzKgwjp02mUx+nr3E6SZL7JAFjfYBQb42PqcQQcZySbqjoOdRQitd0pNvSPTmy21srvgS0Yu0PjJMJ6P/n6BpSL3M6+9aeeYY6+XdxAlX1YdF0wkTtYaF5Kw/tQ+jezxUI4cKMOMQkIv0DaZ3QmwmFcGAJUE8MPOtriw2SOCcoknjCwh9tlqe2CgaPOnW4RPbk2zFh9ht8kZCz+AekqnRuf4koUzmyQFusILaWxwquhgSCIr89YTudvFQNTs7NoxQFiGDluU3YmQiT3u65hhKyBQY8FbcEca66MxeC54We/Ua6WDp32njvhAqVM8l2syVj96WFM9pIZ4jH3TeZ+sHgfaHm7ajL2kchuCnJeGNhxbpSvNbz5GcfTYxSKm7zNPXHUz2B42vXK4C5pcxSsk+BUsmT4+hYGy5r8UyHvKMGbz4ULQhBxABLtYsTyHSUg3wKwsm/zpRk2AKzHXOCuIgQb52glPbHu5hVT7Zx3JufKv/xCxbMV1aLR8zFmsqDHhTCIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199015)(41300700001)(8936002)(5660300002)(4744005)(66476007)(2906002)(66556008)(110136005)(8676002)(4326008)(6486002)(54906003)(86362001)(6512007)(26005)(478600001)(9686003)(6666004)(6506007)(107886003)(82960400001)(316002)(66946007)(186003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iMzgJQ+Lp4VuT7fCYb1rs1NnFhQX1Z4G8RD4c4AZ3TLYNagPv2gkPBW0oZaR?=
 =?us-ascii?Q?i+jMeqqxuqzTmlrI++e8BcwJ1tXg3L/qZwMvM35TPxbbyWVSLX31hLbpq6cL?=
 =?us-ascii?Q?e9XxmXbLHGIf6AUujTKb9D2cx8Z/MMmGZLFE6Nr+Cz7waOqgChj81krUiBuT?=
 =?us-ascii?Q?fOhK1ibIk2TQP24GpEX33fB+7o+npTeZWl/KmRHg+afU49qwjL5umSm1eO5i?=
 =?us-ascii?Q?8Ly4geMJ5YJS2h5/jazNm9PC4dGdx0Cv+WUmPHcCeuoN0Xk/lZSei2Lf0mVD?=
 =?us-ascii?Q?nwHN2A+MUUVIhbosHrztvLTkCq8j3aRdx0RLjaN0gzcAO6uNGmdaI2ektAE6?=
 =?us-ascii?Q?cIfU2c+ddl0PUvS+Zwh+tgUTEvOXGgAptPlaX1SCFajDmyl/xTkcAA1KtEeo?=
 =?us-ascii?Q?VfiGvHVcZk7OvpfGksDTx+FXgESs9RDgRYwuo/bxO99ckUinFLR64WM1n0Ei?=
 =?us-ascii?Q?5p1rxqh+iv9vssLtB4nvTAYxENzUXGiuSZ+jP9gUYpgIc3UrwEcjJ33CZmNt?=
 =?us-ascii?Q?yiQ4pg8D3Ki7IMZ2P9lCajUjeWpbSAbranlFjxg3ur3ATUn2NLM6H9soZLrv?=
 =?us-ascii?Q?RHlvXDXbMnT/pIm4+gT5sUtmrh6L7zbdPOuF0g/EkbcI0XFXcXKDDoajCH9Y?=
 =?us-ascii?Q?9PD8HOQ/StuLQAJRdefBBSN/O0sKfb27YNTq14aDbq+Q6EqIUC3f1aePN/7y?=
 =?us-ascii?Q?/S1++1JaJulGWdOExfaop6O49SkK5ZDoTV83DFtMto5MXa//CFgfgAK6ZAr2?=
 =?us-ascii?Q?Xaff3SXk0FqWYr2BcAuxqZ+c/8HEWTgIoiQ8kfvpE4kt7sWZpgkyCBsjPdyG?=
 =?us-ascii?Q?s3+ioro2G7/+Ii/YrwN1dw7FLn8XvQf4cAos8hKwWb00AiM9y8/G9pfjj21y?=
 =?us-ascii?Q?PYZ5oYyPvJhhou/8Xu4XRhHWpfJD6QYf3fA//+hBDC9GD6Mq+avOp4TEUibh?=
 =?us-ascii?Q?cyjX0YX5gLiuWsEdA9r0upOnyYPhJeHrRQLD2V/SG6Fox/Itf39u80zHP9Xy?=
 =?us-ascii?Q?LNpdneXMhCrLnK0m3PieOdXxDipmiNKpSKfj4JUvJ25regJ6Ls5hsd1QAb1j?=
 =?us-ascii?Q?kS+ei4jW8x0FBXuUdeZlkWBaZeswTnG/y5zgHZkbt9iiaZi6dBSIbogypbfH?=
 =?us-ascii?Q?FjtOOaCX2eXgcoB+KlOUSohfUCpdovoXX1iFB9isqBEBUP684d6WPElic94E?=
 =?us-ascii?Q?n9UvHtREbUlS/DGgsocp2DCov1J3tK+HpvLhOCiRMKL6Xl2DQ/2q5cGj9W1Z?=
 =?us-ascii?Q?c9xXt0QPAdDXHD6nGOBBDpqRMIQmV7R51kqT7Keo2v4INXeob/eGXfFC318P?=
 =?us-ascii?Q?i7IkMlzamvAtZgyHGmxOIwGQzo1eQGwy0BN4JB2+1/QU1lsFGkr7gRuiVomk?=
 =?us-ascii?Q?r5QOLBLZFUrYvxWJ5qMmbnBusOFyS7vvEx0aLnwnPQEtCRWMaaX6MDghCgMS?=
 =?us-ascii?Q?/TFPkThi0krUs3KumDGo3PfU6PIunQnbN0zux3b95XFLY7pcqv241XbXW0nE?=
 =?us-ascii?Q?JL8WAhXCja8AR9Uw1yO63Kv4LQ1jw99uka/lPaGMUqJ7wK0v8jbPtXyTtDIm?=
 =?us-ascii?Q?jufMZ1aikiDoU+Q9vfLqCg4n04EEzr3NPrNvcymPZ6DjNpI3OxvD1ssU6wCp?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35377736-124f-492c-fafd-08dab2f6c43c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 23:56:55.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJSwexH8IPNoQBBnnmGtMhIfPOR/xTIKr0vxRz6nXKFC1DQePoedCVDRSBTj6sGRlmWWithBdI3QMs1c3HA2LXsvmpIo9A4YY4QObmjO8aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The function devm_cxl_iomap_block() is only used in the core
> code. There are two declarations in header files of it, in
> drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
> declaration in drivers/cxl/cxl.h.
> 
> Fixing build error in regs.c found by kernel test robot by including
> "core.h" there.

Fixes a build error only with the new code in this series, or do you
have a config where this fails with current mainline?

Assuming the former, this is applied for v6.2.
