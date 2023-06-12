Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19F272D4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbjFLW5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjFLW5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:57:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07176DF;
        Mon, 12 Jun 2023 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686610665; x=1718146665;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qPTgCQZEb62A9ikJES5isiyGjyH4pmBi1pFq+gRk8cU=;
  b=NEfeMZOAG5yJeM6OaXDk/Efc+d/bIdDhzvBOKZcR3o0M/c+h9bhLzFzP
   3wXG/qGqRE5Xs4Y6JAjrPbvA/DWhsEvDq6rNWvtJKqNuOPR8q0Vugr9+e
   o4dwtJ0k8wvf1JuuOxQFrScB4P9DXR5FidV1CIoau6duTEKWWvJGLu5KN
   UE0JKdMtV4GvME20GJFbL5IJhe3TY8KOYeqouMdxHNF/EVjzSgEvjN4cf
   zjw6DjNcGV2lOAkDn2FEOeMT6d452E7qsgii4HoD92OIGZLR2ODC+6QAE
   UlPK/qlpmoTO2P49My6Qt7W1sQX9GOpBVtYTNQl/mF3nlgk/U3jJhrwDl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386571122"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="386571122"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 15:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835653797"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835653797"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 12 Jun 2023 15:57:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 15:57:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 15:57:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 15:57:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 15:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7PlLUcBmeVO1K2n5INAkqKuYtR30xN8U1EsG/DJv1P5BaOehS0AeSArdEf58B7nBHGWL01A6dSUpm0TNlvjLkGZQX0xtaPHqazLUHcTr2gxKP5tuUXlOTP+lQxUuRtBkUwNFhZdbBVHqbBKjpHAdXgsuKfcA/GSrvZ6WEsFZmYXXz+cbIskVZKxuretA2h1pgPnzk1jHr3wLTMcSdO9wSE5arZt0ZOFBbp0G8q9MsaaSZOMGFsrmPkYfUO5ptND9j9hxfiMMJMpVDtzpy/46++21GRcysDS493xDLBwXJL/LMe9c7yT4eDyZK9lgAHHv/b3yJRTG5eG7bWqnaoUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkdfY2m2ZYofXy715rqVH/tYUYrovXwTXsLjE0ULYLg=;
 b=IaItWGSs+WKnaZOObqsB/l5BUULaDYjqgUz3jbfbtvkyzridYr/oQPIEX4ZCqxUUaB84/CW5YJhGaeJy3ZQMpWR24mkxEKrkDgBjAqGhaFVRjYiot6NaXHzOLuVbtoC5LWiHnnaXFB6/pKG7fJ+PEzFaJqkDzIzsUY0CsRdgd/RtQJ8OZUift47LCqpV8Vizt6QE3Syh26uzdb0QD1sJyDBmGDtshgC6bq8phpXDMl84bfUeutQuGxA6NTMXC94oOVomJ4wLfhp/xRFnfmV5M8s6tU9bry6ep2QeaSq0Ji1Kgomg53l633074Sjh+lVfVNkP8whpNvH4dlCPDY1k8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7487.namprd11.prod.outlook.com (2603:10b6:806:317::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 22:57:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 22:57:30 +0000
Date:   Mon, 12 Jun 2023 15:57:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 26/26] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <6487a2d7e89de_1433ac294e6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-27-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-27-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a51b4c-ff2f-4101-f3ae-08db6b986695
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E19Lve31BDBBtEiRxIMP9inJUTK2jcJS5C/rPW1D1/I/gK818V6DS+Ge1XBmP9QPoe7alny3WiF5FMXZeghFh41fiowoTOo9is9DyVCnRNoh/bimRTdLiolMpPhM6RnMY/IiFrscScj7jWH+wyhxK8Dmc9sQqy36ALQVXWgKyAIRjdXbXnQWvr3Gnapt95lxbxxYaNgaVpaxPTT86+bfB+E26CCnVD3vsztQlXw40lUigr0iTlFRudU5DUNJNS/YtGYOCAZ0sZRzUpPy9Nc+9YtNDXztlz/0VBK/CSI1ysiAVJsw3igxw3lGx4OdNpCIBDcwSjZ2NQJkYFvbT9Wox6553WxkkpakpJQUyMRm22l4Tg1FJa36BPsiTcpRaO5GVF+Mr9akj8mgQIBdXvCZx2paCK6t9P63YA5YtsJ3Iz4wr8VJtRZUJN8HrtM5FLP7XRqIeQsJCULGqF6/qKMAxn4vm9CLtmsYtHUSQSIgnOGrB2FNMCTV3LdoPCv9mx442UucoODFk798T9uIWCKJZ3EKafmyoNA5GYlfNfa6bbzI1vYIkV+32bs9YZfa2CioWH8ZyffgCnDgPZvx7EkgLsIQxon3h7q7tnW+kpbgJz2vPen9RMr8be4cMfqInc34
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(82960400001)(38100700002)(9686003)(6512007)(6506007)(26005)(186003)(83380400001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?viuhRkZMZPo7xfPVHSMqfSIwvkosp7Zz5m7svgjQYxTZumo3e3C4U+H4OoX9?=
 =?us-ascii?Q?Ioh/RLAioqPbYoK1UotO8QPNO4PDa1um2Zz6REU9QwecYvSop0y8LmD65Ay7?=
 =?us-ascii?Q?oI+fIL3IcLAcJYepumASwlCxPebxRWrmuuOnTbErnGlekp6p7ucIllOA7UFk?=
 =?us-ascii?Q?gue4IDgwSdX3upYIYsGeoxLQukCodPDlM4sjQcI1njRZNlzW5QFwRqHR+zJ3?=
 =?us-ascii?Q?Lz/9HWT+1wz5nOLopEMtdHPAzVMOwv61PyS9aLHDCkAyPNSvxfP2NVMHAKew?=
 =?us-ascii?Q?G7xLRdpHA2AudSPMvHc/bfIPEXuTW7wDbGVS81Fnd0WfnukGrzWu3IbPqJOH?=
 =?us-ascii?Q?zhqaL2M/HrGSUaCBDuHOPGB+gTA786Ka6xtSNd7ENDnyLfcKOOxlRcRnTkQU?=
 =?us-ascii?Q?gFh2bIagslr4Hfec0IrdFCHy2Q5GaVFYtQu47W/O+Yqfi7sUM03+Vm9t5xEG?=
 =?us-ascii?Q?V71BI6sIWYVQ4kiq4kh2EXRC8+zUGQP4MQrN9myEcvpLRXk4yY30MN5/eSD3?=
 =?us-ascii?Q?8UnuL+T8Oyf4qLiUbqndY5VHCJBtGtDt3T8XfN0rA6zW0eAL0bwFi51w37Nu?=
 =?us-ascii?Q?fB2Nu604DgRo/nfYaLHLtpFGyN2MX4M1aAHPbkl9D0taOY7jFpRhtiyvx6NK?=
 =?us-ascii?Q?+OA3t/vm/w0mfgLfeKysCECmnqHpEQmmTYeims56UlsgxpXXxEOu1YUEPsiu?=
 =?us-ascii?Q?j6CS1kLp7X541hQ4mAijnF/MEz+1ys66uvJ+TWPX0jZrsDLXrovToeqRAzcq?=
 =?us-ascii?Q?31lY6zCoeyLZtUN85B55ao9hc9fcsFDdCOslrtUIv2TZV8tFwi9Qj9MIbajk?=
 =?us-ascii?Q?gW3l7U3pnGdyheD23glZv05B/fWWtQnnL/ltr2IBfGRIOv6TTO7LDR65EtKp?=
 =?us-ascii?Q?nOhlAzwYoT368BFXyp3KK1LlYOvXK/fPOD8PIgEFCuqqLOsDWmH0bvn/9Yih?=
 =?us-ascii?Q?UR/LkBs+LSG2iEpWswlPWaC4vF5z4iqT8mJknBOc8dboXm5PN+5WoZB+hJyw?=
 =?us-ascii?Q?jB369eIWV0E+jyZ6CwRPeIJL/QXjrGwbT6sRxYCC+myNV5BbC9++duhVXYea?=
 =?us-ascii?Q?FcA3cp7hzP0DkLj79Z4ZGoBqhja5Neex4mZVERzUFlReEJ9n6ttO7aO6wguy?=
 =?us-ascii?Q?WZP8U2kXveTT/t1ZvTwnybcB9rPueanRgNb3mQS85sjgfgTEzGogjhiX2H7i?=
 =?us-ascii?Q?rK26K872MkSDe1tby5jopcUS6jaZsTTusRY/JzBakwvNIiqLpBqFdYTCpxqT?=
 =?us-ascii?Q?kBvVKbL1PXnW2Mn2OBcnR2ROJeaqXDHo2fWvSHwtqjg+yiPeDF/DUgOgdAqo?=
 =?us-ascii?Q?I96vEwxP+1FiSpUnK8HwzfdKNHMAocL9Wie4+RYLkjqx6vpV/K/osY4asJ21?=
 =?us-ascii?Q?yk8TT6KkrF2TcIB88yqFbcnVd6vUuXM3EuCnoOUuycxgPz+adrdDufouX9JW?=
 =?us-ascii?Q?OOPi4I6jRKnLO5mfHWtCoEf4wfA08pTC6g+qpix504eGthN1kQ3wQHOuLFeo?=
 =?us-ascii?Q?ozYQG9NDHxENQSE7UEkxGN7cOYjtBEWTVLxAhq8qtl/aAwzsx733bvWtv4GL?=
 =?us-ascii?Q?IQ/WUvLW7sog9xnZMzZtazqemIo1gdmz78hmk94RqeHDkdlpIw9btvU3GFAv?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a51b4c-ff2f-4101-f3ae-08db6b986695
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 22:57:30.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8Pj4vs5pNHGyxbzx4Y35LQi68ufFF8/zggtcGSsq1XjeaIGemzL1fiwsZn8RpB6VBLLxeuMooIJc5x3LCf8Qm1kO4NP9GVhJrc73Qx85H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7487
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
> From: Robert Richter <rrichter@amd.com>
> 
> AER corrected and uncorrectable internal errors (CIE/UIE) are masked
> in their corresponding mask registers per default once in power-up
> state. [1][2] Enable internal errors for RCECs to receive CXL
> downstream port errors of Restricted CXL Hosts (RCHs).
> 
> [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
> [2] PCIe Base Spec r6.0, 7.8.4.3 Uncorrectable Error Mask Register,
>     7.8.4.6 Correctable Error Mask Register
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/pci/pcie/aer.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c354ca5e8f2b..4f9203e27c62 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -948,6 +948,30 @@ static bool find_source_device(struct pci_dev *parent,
>  
>  #ifdef CONFIG_PCIEAER_CXL
>  
> +/**
> + * pci_aer_unmask_internal_errors - unmask internal errors
> + * @dev: pointer to the pcie_dev data structure
> + *
> + * Unmasks internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
> + */
> +static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 mask;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	mask &= ~PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> +	mask &= ~PCI_ERR_COR_INTERNAL;
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +}
> +
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> @@ -1027,7 +1051,39 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>  }
>  
> +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> +{
> +	int *handles_cxl = data;
> +
> +	if (!*handles_cxl)
> +		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> +
> +	/* Non-zero terminates iteration */
> +	return *handles_cxl;
> +}
> +
> +static bool handles_cxl_errors(struct pci_dev *rcec)
> +{
> +	int handles_cxl = 0;
> +
> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> +	    pcie_aer_is_native(rcec))
> +		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +
> +	return !!handles_cxl;
> +}
> +
> +static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> +{
> +	if (!handles_cxl_errors(rcec))
> +		return;
> +
> +	pci_aer_unmask_internal_errors(rcec);
> +	pci_info(rcec, "CXL: Internal errors unmasked");
> +}
> +
>  #else
> +static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>  					struct aer_err_info *info) { }
>  #endif
> @@ -1428,6 +1484,7 @@ static int aer_probe(struct pcie_device *dev)
>  		return status;
>  	}
>  
> +	cxl_rch_enable_rcec(port);

Similar to the last patch, I wonder if it is sufficient to call this
cxl_enable_rcec() in anticipation of VH support and the fact that this
only depends on RCiEPs not necessarily anything RCH specific like RCRB
shenanigans.

Shouldn't there also be a corresponding cxl_disable_rcec() in
aer_remove()?
