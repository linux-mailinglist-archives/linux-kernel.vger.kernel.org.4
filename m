Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C108743102
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjF2XW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF2XWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:22:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D81FD2;
        Thu, 29 Jun 2023 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688080973; x=1719616973;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n5tPzMyyTM0v0lMLFfVAZPEphLxdC3MMWbieTur+BoU=;
  b=CBvconM+tyD3gOF2mAvdS92cQkT4rABSHLw5+Pp0a26QeAeN+2sIktSR
   5MlJ3Qo4CwOC6M6BLd5IAcnp6U113vVIFkv3ZR1PexV4okTh9KJ45tZ8j
   V8HsHlrcl1Bv7e3qccAwMDlUdyLU2dg968SV5DJiWDEQMJzPgeWU+xJ6B
   Zp2LFKWYB96o+RzkdwLG1Ce0+EYqQR11O7NuLTE74Cz0gakDKsr1k0+Kr
   JVY83GbNoUHB2kMdztoxUatotrDMeJBQfapX3RehS7r/vLjjtQ34wPj3k
   jiNp78w6q+9OwreEYV/o9vE9D+mt+ph4KuJlfWBFy2RkgysxCpIGg4bkB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365745094"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="365745094"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 16:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="830717790"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="830717790"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2023 16:22:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 16:22:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 16:22:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 16:22:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 16:22:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3kEkIMx5iGxnUEMYDKC9cyzfj5Y4Uf/S947OQoCmKearMZIri6xVC7zpxobDW9GFtEjpz4OxaMKjTPg5G5i6yYGw2SGdiNYu3aKispsKamvLzHIfpJRmlRcwOO+o6oosl8bKBDlic4M/7yqB5d7ygYzs1ggnrLKlNPovE9A9lCab8vuMFcxXe8wcCk/gmknQ0R29O6qFniixJrnepYFp7MNq+uvAvzPOgw8zYCf8jIC39O67BZ1FgyHqbxfvt8pZpnvPRSAuQEYv/lIBLr2FNJ5cYwfaUnhDWooBigR4208ANctnjESfQDhYvMdnrIZZIskN9ChhTo0Wm+LRppzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kry19aXRWFWj/2ETRM9EJ8gBTWv4TYM/nj+ezF5E92M=;
 b=Sql7WPXoIZFuZ1DmaL0R09UX95zMPQGhsFhuUShMDJUbGgCndDlv/m9Cl822/h4R6gF1xBQx/Zq4rgEkfxmzW169+ENhjf+YrtzZ4nRw9pGBnSRw/1Cg3KLuQkaBC0L0KA4nFHUAP/a38UFxMFZ5oGPK68vQVTRiboxlM7xe1J1yx/M7foLJE8xCOxzqxLEqhOrk0nY2ha/sjmoCPJouj9davXNmzpsnSo8Y5LS11DkVw+bl4W6BLl5gzAR8qW4U3QcdHuzpU53suWzItqVEZGPs7WzcZmvd7J7ieweCUtUuTpnMqvwct4wGYyjEDWwp79q+OhvHnMLOE3ARmmZ/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Thu, 29 Jun
 2023 23:22:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Thu, 29 Jun 2023
 23:22:44 +0000
Date:   Thu, 29 Jun 2023 16:22:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, <alison.schofield@intel.com>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: RE: [PATCH -next] cxl: Fix one kernel-doc comment
Message-ID: <649e124055bb1_13d5af2948@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230629021118.102744-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230629021118.102744-1-yang.lee@linux.alibaba.com>
X-ClientProxiedBy: MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdb3904-593a-4003-d9d0-08db78f7bdae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKNjvNCbOcEHpAbEbuOCgLKM2aFFyInA6O9Zfy/wCNTpn7e7nvezpcyw0h6oaexEzF9gV7LOzPCybwEV7JFivp6goHpJn1POH39luHudehDRZU5l1VLbzcviivPQ9xuxD/tz5/fnqOfoSOwf357tHAHmcwWFUq/BMc8xvADdbJfc4+855clv07NK2zHZm3eDRVEGDWfGryY6besYXwykOflXzFnTyoMZQzNYqOKf/a6+eZUBLPbeRANK/3GMlSop9aj+BGekyz9llQCJnlR2ibeqYdCkjTUPGd5Ys/8MXDoOvW9/Ki4D1OHBQp57JDw+l1dfaWa3pUi2ODL9UWk0x3JFwRVzVJZNMvZEe8bkL6UgQQH4UJa2gKo5fTwy8KhhT7rmoSPC5168dL64CAiZWIw+cLcyZ/F2paH33cnNLLFcPaOCzRMMSMB0C+cnKyW/SCPYG+joJx6+X9n/9ZcjUeAMeoMmIgbmIQcVlFKT+ZffJXp9QOK6cIxJL0cGL3Uh7NGeNO44Myxc7Qt+RggBLZthfyPSQOV5k4LO6ka020ILj7JwllbcOotfvZ08xXeR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(4326008)(2906002)(4744005)(186003)(83380400001)(316002)(66946007)(6636002)(66476007)(66556008)(6666004)(6506007)(5660300002)(478600001)(6512007)(9686003)(26005)(8936002)(6486002)(8676002)(41300700001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fObiEe9P4hwMnbDQNQrjvRFUXpwEwwdqDp6rhw+yzSpKeclp0LWDfCJ8WFmT?=
 =?us-ascii?Q?mT/0E1oRCC0o76mL53/OrkUpxqx97rxHaO5UZi9zMU0nedKEXE/suJ5uFu/t?=
 =?us-ascii?Q?+vlIt+8iMN6HIhU4/nNNdVocQKZncA7dMtZ3ciJ6RGJukvYsfGqjUDp5/bHN?=
 =?us-ascii?Q?kvY4wEwbrBjCVaAdAFd0uUYN06RyapcOy4vziSBpnk/W+dyZ5eUxi1wua41P?=
 =?us-ascii?Q?UZMZY/FkmtPL8pykw94A9i2PMHfWfuYg+px3KM2P9kbVAI7cnisks4zIITzw?=
 =?us-ascii?Q?xPJ5keXxArP+qZsfvTiaIF9GaCdor+LpT35EDJqO2jrqiT+SEkthEIhGrVCA?=
 =?us-ascii?Q?xfBaB3YSKLU1/z0pFiNd76dpnFCTM9Tx9FbOP0gZh9KECgABUEvWHw2C6BtR?=
 =?us-ascii?Q?2yMmTxWC4EKHWXAwcupInDwQ+u+RtzUXtzNmvln5OIoQzHGIWmTJEachfkIE?=
 =?us-ascii?Q?67p5+Vf5tnuG2xhk/MFjK5XXYqHgAmTdksi2qPoltmoQ0bceF6suDr8wbZoF?=
 =?us-ascii?Q?Veu6ntg5O0sWLPUZ1Gp3wVk91Fx4wlUigTZFEzWE2g3vYp5MRaxFqZMCFH4t?=
 =?us-ascii?Q?w82C9Byn3+RlG47s4cM4sW8G+Y3sjiaBeaQTms9NfoOKqEp+ZlOiyebV9/60?=
 =?us-ascii?Q?DPBalnmNeB6UkoZFwWesqcxXIuFykPtY6DklmtH7b6MzDTHHKQDpCtU5e9Jq?=
 =?us-ascii?Q?owlikGJ5BESyJ/mYGy8iuJairX0+ef8mnBTJdlrxDe4eU92ye7PtuCdyoDRn?=
 =?us-ascii?Q?xG1N3EM9OtgH8AvCvsAbaMxfsRAvJYrG1t6XIi9ovvUVTDjS2xxbdWQ/xg+e?=
 =?us-ascii?Q?pFo2NQAdt1LdLH1q22yrpLHatSuUatcqrBPQDX5+4RiF9aNXvMIg7jybFaBh?=
 =?us-ascii?Q?nfKbH819lplzCS8jo+1ksA5BK+30TZWhF4fGJBH0+EslrKLXLA1YfmEKUg9H?=
 =?us-ascii?Q?wGbnLAOV3ZOlqhadvoBUh+t4sH7diYY1XmFUO75FgoOQKe3kZQVa4qs6JTgq?=
 =?us-ascii?Q?dZr/X09kMyXTtuiHqCz1PBuHqJKh6nYCnTDjkzl1pS9fES7f4Hex8tWk3Mc0?=
 =?us-ascii?Q?Ab8shZIIIZ9ZkhUtReB98o8gLCbCtqU6xF5rxYq6XZz8dwF20qcQpPqCEZZR?=
 =?us-ascii?Q?8Rt0BzCo/7rUkCIwbWOIpSae6CYBbYRbLLj6edHpTh9LWFY31W61TAd9+GY5?=
 =?us-ascii?Q?c/ehwY8MHTX2C8vaIZGkPPZqBZ3Lor8EDwj2h5Tl3re5DvvW1QprMVaOhS4i?=
 =?us-ascii?Q?DYCwp18uAJTA2JtlFazQlnWOqTO/sjKWNei8lH2/azB4eVPWuAvPwitaf/il?=
 =?us-ascii?Q?t/yR7e8BVY4nQK1pFSljE90SWIE5DAhXarYPiWlGoCnHteWurbl/rAhk67V3?=
 =?us-ascii?Q?4kPHAMXGtEO0yjfETaTGBg3swuegegLriuurmXJGrfdnjXskmT/RPbcrWMZJ?=
 =?us-ascii?Q?oL+O6o3wpxVyNXgxdtGjLsC7+Y7/UKQlJBC7+gfIVoGDE0dOKcyMeSzCNKYB?=
 =?us-ascii?Q?xaFxm8OnhAL0ODVNwkdNU98/L6vwdw4mfpsuNt6vm1A29trEhGR+BwxvZXcs?=
 =?us-ascii?Q?ej2P3QTJovTWeDodPu75NVWd15JzWI02q/Jvy3jzj0uXSIJLFFSvN3BqLr1B?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb3904-593a-4003-d9d0-08db78f7bdae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 23:22:43.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvAPCkogrgxw/93jWrWrF9wLjHLt9VaPg8RbYqSLyrKiIvpfjmv8oq6fcOK1PAksRIcf+fYLbLO7EwC39ymKc+1hjFYaKEDisqnId2NTTd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Li wrote:
> Make the description of @cxlds to @mds.
> silence the warnings:
> drivers/cxl/core/memdev.c:678: warning: Function parameter or member 'mds' not described in 'cxl_mem_get_fw_info'
> drivers/cxl/core/memdev.c:678: warning: Excess function parameter 'cxlds' description in 'cxl_mem_get_fw_info'
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

I fixed up the changelog to note that this was a missed fixup when
merging for-6.5/cxl-fwupd with for-6.5/cxl-type-2, but otherwise looks
good.
