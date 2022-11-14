Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F47628DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiKNXpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiKNXpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:45:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1819398;
        Mon, 14 Nov 2022 15:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668469526; x=1700005526;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8n+/CimoUDQSp2BaM1P+8Ew095q2zUWSY9zpVIEs+aI=;
  b=jRnlEn/o6ct6DNYGXNSJu3Aot7mPq7PKrJn3cGCgLWjr1dB74BvOrvhC
   ULfaTaGznCq4b5M50vbn6Tc25ShjZDKDn0SvRTWiStC2A8P2wHUcm+kLs
   FjTA4H4mAufPjuGSajgqsIPmpcaMGa0LUq2eB+F4Z5TRSJQDf2w/qqKMs
   vhHy4wTMHZqfMuVhj26eFWqt4HQl1GJN2lu5oTQ/TcUIpRT/6gglEvdhN
   4otQdAOCzYvSue9rRb1GGU2NOOdl2nlF5ARMx2E5dhf29F1g/dwU555OH
   hzmlK+N0kiYU72EiUC9w2fPfdn3alZX9gewOdFmFLV2GSLnOnwMc7TU0/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313260516"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313260516"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 15:45:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="967768410"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="967768410"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2022 15:45:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 15:45:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 15:45:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 15:45:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 15:45:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyWduhJU09MOrBvWb2IQRwEGar+m8oH7Ba5o8QyvxjMumt3yLfwLk/Yf6h8DRVgqAFB5wuk8y/x0IMDz0kGNKqQpjfePb5CPbol3EEyFBZUpFtX48aPpNhsWAcZSmqjJxlAKUxjSMiQhibhLLmeo3+n0YHp5rBwnpkU7PxT37HVYEvJ+tkLimfiUkVntYS8FDlDfnJHPIohA0+449LMUxLbBh/nDlnC7Jz13cddyQ2s7KZ0sHWJy7Cs3sl1Y982qKPwEOyFGnDJuS/tK9AXUTMsm1sGfiRArpypc1SrHPfEhG16y8DkPlNCxHG6kTbj8KroE1waYWwX5g//DnlQMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7q1YSOVw/CX7b5B9X2T0nehUqvFpAc2UKma91DN6Tw=;
 b=hhoDr89WuHwhUOINJKpYCr3T8JoJT+8hKk1jPfW9lsK+DPSwbkVzsZlhAk6yald7QcMs5607VWmGlCRW8q2FPL49FUI/c5QqG00QB+z/ElIkF3j6jLhkkGPpn0gYBM7gQbwK2srsO5dEFvHiolmr1C6xyIQey00AdoOEKxVlcX87LDRfMXhZbUGjfSUPd5UBSpn8/ejhjg9iLU2sdq/oA7g2AHmrWqUr65rQwmlqPC2up0AV38FLJ1q4+JSDKXshyyoWSAcn5pCg+HWh8V7CaIyYxl78EURTFkK/A+bOn7HoK5QZy8xYXJ7iMO9rPgYDG1TeIICY4lb5kNtuxB0xpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA0PR11MB4669.namprd11.prod.outlook.com
 (2603:10b6:806:99::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 23:45:22 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%8]) with mapi id 15.20.5813.013; Mon, 14 Nov 2022
 23:45:22 +0000
Date:   Mon, 14 Nov 2022 15:45:19 -0800
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
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v3 3/9] cxl/mem: Adjust cxl_mem_find_port() to find an
 RCH's port
Message-ID: <6372d30ef4152_12cdff29452@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-4-rrichter@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109104059.766720-4-rrichter@amd.com>
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA0PR11MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: 8441e31c-1b74-461f-b8ea-08dac69a4b01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7EI3TAz4w/hRu8I18Nwa1k+jJW8tVODthjbr/2mrwP4yyRq97q11mVi7oFwfKueeup5RunAgH6yCg2G+es8D408LdbqfqxhM+qlubWqlxyHw65LkKF7F7gJFITvrojdB/Iv60PM5r6xozOLQ6wb8SzV0kY9GsW0MXb+7BADmgR2UQLiNgU53oAnFaZx+yeQw5nnxHyoQjiA68BbRd3a7e/8MaUk6AUJPRCEihfz88qWlqImDmLCQxmCGGpSszauGTT6qI2HR8fU+Cozx7NGMRIEFy5sTsNkXUY8jcGcE/Mg43bFVY5j5s4PpW0UdO4d6FxUPLR6ebBi5p6UzOxiVz7sJ/+WBDfAnJVSTelfC7YxjsJFdj/jsbV+HQd31PnJkDpVjWFCoxVjKe29aGEjkbdpRpoVNWb8vyxiK46vZu/fDw8ZTLzNRgHtihgEMF69hDiFcryYE7wiyR4JXkMFls5YZKHikB0NvpP93hy4MG1X7QiCxxpqg85ilbTw2TlGVIZZwqWyXGe4rtcP0dJIHcBHjjBv345jEHoqyfb4zGHDStqsfoyr/hT/KNXQ0PWa8h5M5paMVIpx1/yCKylmHQPEna1uZ8e8kXVZOEuoCAYcSbLuGZDbj8q7paWshQDDEwKk0UFMImZ2R6ERc1W6i+C2ar/OHAxoxXbfY0ktm5yVINcbm+DPA9omPLkRp42UgUWyudhYageykGBW0LAyiTzCCmsR4aeBFafgM/MX/Qmc7+TDXGknCv5rp3eRd8NI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(6666004)(186003)(4326008)(66476007)(2906002)(54906003)(110136005)(66556008)(66946007)(6486002)(8676002)(26005)(6512007)(8936002)(9686003)(38100700002)(82960400001)(5660300002)(86362001)(316002)(6506007)(41300700001)(478600001)(37363002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dERQcHVRM1FEUEMwaG9SZjg0bDA0NzFseTdTbmRiMlRPSFNGWUtTN211Mit4?=
 =?utf-8?B?eVJLV3JyanJ6R0hXOTlqMUxZd1V6MjJsczRESXorUk94VXJXa1pvTGFic3U2?=
 =?utf-8?B?ZEVLSGJCM1ZjY0QzTGRsYzhCZGlUNEpHOTZRUFByN0drTkI0RXpnNkszS3pY?=
 =?utf-8?B?UkRXRVUvTC83ZXhJMWJ4Z25CRFM4VGxWUkVvdGlmZERibDNFRjJ6aEFEZzVT?=
 =?utf-8?B?MVBZYnE2UmZPQkFwTFpzMnIxQ3pCNnNuMUNydjByYUI4VmJ1ZTNzZHdnejE2?=
 =?utf-8?B?SFhiOUYzVW9CWlV2bnJyMDV0NnIzemdsWXU4UndpcmF2UHFrNldCcndCcE0v?=
 =?utf-8?B?Nk00dWdDOHBHTVdRNzZmVFlhczF1T2FxaE10aHdWN3NLQ20yN3hLMUYyb3dj?=
 =?utf-8?B?MFVvUzNMS1prdFc4OVFSMUFiWi9xbW5SY0ZFMVVBVkdIU1BOS3N0c3ZPUk13?=
 =?utf-8?B?MFlKUk5IRWJVaU9xRGJPbDFnKy9maFp0Qk95d3p4amw0RzJzQndoaEVweFJv?=
 =?utf-8?B?YVdPWUpUU0g2eGp5NEhlNzRKbFB5emZycFdiMnZiUUhDVFRGcnVyRkZRZEo4?=
 =?utf-8?B?K3RJN0ZjblMyc3R4QitTekx1MG5uNUMzNWs0bE1JeU42SEJ1V0t1UnBjVU94?=
 =?utf-8?B?YU9kYmdJdzdOeGdSSW9La2ZpbkszSzlrZ3pOMXk3SGJ6Y1BqTzlzRWlRQjZp?=
 =?utf-8?B?RVNKUVE3SHZBTEo3QXVDbUsvTDJ5Y3Vjc3hNMFlHQjZad25XZkNNZElVUUF6?=
 =?utf-8?B?THhRNkhFKzNFQldQbEQvcjh6QSswcFg5bVZHdlU4M0wvOWZCNmVOdEFIZlVW?=
 =?utf-8?B?UldISWFmRHFPS3YxV0MrMXZkaVNQU2IwY0Y3Z0dCUkM5bSsrVU5qc0l4b1JI?=
 =?utf-8?B?VWR4SS82ZytNQmNXYmRIakZUZUVDSnhWNWRTdWRibGZmcVpJWklHemdvZ3V5?=
 =?utf-8?B?Tk5XR28zNERYNW9ObVBNTUhOVS9ZUkM3eVNXdWxFbU13WVQ0MDVta05uWEhC?=
 =?utf-8?B?dDUwZzZaVWtxbmpGMGZUaC9qOWFxZlFDSnY0a1dTOVdOZk5VeFdWb2JvRU9H?=
 =?utf-8?B?WFkzQStlZDZxYWJkWUZHVExDYnl5UEVQZFEzN1pDTFUxYXM4U0hwRTczWUZS?=
 =?utf-8?B?ZzhQbVpIakJraDJ3L0V4VGFNOEozVG5PUXB0ak9wUC9GbGZvbGFpdit2MExU?=
 =?utf-8?B?Z0hXYnVhK0hFdWwzRXJiMnFjbXBGYVpKRkh4eS94NHMxTGo2MlBUVnhuYkxI?=
 =?utf-8?B?aHRNdzFPblRWbGE3QS9qWVQ1MDlHbWNRdElvZUpFekRITCs2YzlhZjdQL3RQ?=
 =?utf-8?B?bDlXYlk1M2pqU0VabVVQck1kVVVLUDFHOC92ODArMGRnOHBBU1FEc1BXYkQ1?=
 =?utf-8?B?dk8rZlJLc3VMVWJ0eWUwWklmT045V1VCQ1g4VmFldUFQQ1NvRmVUd1ppSEVB?=
 =?utf-8?B?OTZ5eUNSQy8vYjBOeEJvdlZMY0x1WGk5M0hUMkZlbkRLS1NsVU9wOWwrSXpj?=
 =?utf-8?B?UDBFRFF1M2NZK3daRXE4ejdvWG5PZ3pCTXhHdEJtRVY3bG1uQkxDaDBxQ2RQ?=
 =?utf-8?B?MFRXV1lDSjY1R1NIdXQ1UllDNG4wTi8vTjJ1WmoyRFY5Z0tvYjljd3VsQ2hj?=
 =?utf-8?B?TUpacW54TmJLdkZwNzNTWDluOW8vYVRmSVhML2xnZ1p3Z2hEQmF0U21OTWFK?=
 =?utf-8?B?MzVXTUdTL3VEU2NkYktBMEpSTFBWbkxhYmJWUWxodzdDeGF0bElDbGczY0Zj?=
 =?utf-8?B?WU92VGswRnFjU0JkV3Jvc2RreVZicmQwdFdMYU4xdksvcFo0dEdUbERiUmFl?=
 =?utf-8?B?ZjY1Tk5IK1djT3VUUUFyaFFoUjVWamtLN1hXMEtWRmk0ajVlZjBhK25lTUtm?=
 =?utf-8?B?TlhlZkpKRU9qd2M0YVFRSXR6SEZETzdoOFRBcG03UW1HTndRekJjUTAxczls?=
 =?utf-8?B?OWd5b2hHaGlmSEgwZjd2dnd2VDgxUUhNNWlNVVV0WjN0eUFLcC9yZXJPc1lF?=
 =?utf-8?B?dnhjb09Pd1hjTnlONE9pdmFMbDcyY3l3Z0JsdDBtTngvRmRRaDRJaGx3WHRC?=
 =?utf-8?B?Kzl3d25XL3BJQmduUmZMOFducWVROHovVnVPMkpqck5lUHVvSVJHU1lxb1da?=
 =?utf-8?B?djg2RmNnZnU2NXNMbUJjZGtzaG55U1VORlVZQjZ6VWdybVZPQmdSZVRyN3pE?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8441e31c-1b74-461f-b8ea-08dac69a4b01
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 23:45:22.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTPRfcDPXEn9QO83Go/afnMahjRf3Gw/xi9B1nS5pZjGpjuFNfc0iTBnLtye2VPwyt0mhyAaHc/rfO2BOkldcbMFKdUFYP825jfewU4G9LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> The PCIe software view of an RCH and RCD is different to VH mode. An
> RCD is paired with an RCH and shows up as RCiEP with a parent already
> pointing to a PCI bridge (struct pci_host_bridge). In contrast, in VH
> mode an PCI Express Endpoint is a PCI type 0 device with a PCI type 1
> device as parent (struct pci_dev, most of the time a downstream switch
> port, but could also be a root port). The following hierarchy applies
> in VH mode:
> 
>  CXL memory device, cxl_memdev                               endpoint
>  └──PCIe Endpoint (type 0), pci_dev                           |
>     └──Downstream Port (type 1), pci_dev (Nth switch)        portN
>        └──Upstream Port (type 1), pci_dev (Nth switch)        |
>           :                                                   :
>           └──Downstream Port (type 1), pci_dev (1st switch)  port1
>              └──Upstream Port (type 1), pci_dev (1st switch)  |
>                 └──Root Port (type 1), pci_dev                |
>                    └──PCI host bridge, pci_host_bridge       port0
>                       :                                       |
>                       :..ACPI0017, acpi_dev                  root
> 
>  (There can be zero or any other number of switches in between.)
> 
> An iterator through the grandparents takes us to the root port which
> is registered as dport to the bridge. The next port an endpoint is
> connected to can be determined by using the grandparent of the memory
> device as a dport_dev in cxl_mem_find_port().
> 
> The same does not work in RCD mode where only an RCiEP is connected to
> the host bridge:
> 
>  CXL memory device, cxl_memdev                               endpoint
>  └──PCIe Endpoint (type 0), pci_dev                           |
>     └──PCI host bridge, pci_host_bridge                      port0
>        :                                                      |
>        :..ACPI0017, acpi_dev                                 root
> 
> Here, an endpoint is directly connected to the host bridge without a
> type 1 PCI device (root or downstream port) in between. To link the
> endpoint to the correct port, the endpoint's PCI device (parent of the
> memory device) must be taken as dport_dev arg in cxl_mem_find_port().
> 
> Change cxl_mem_find_port() to find an RCH's port.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/port.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0431ed860d8e..d10c3580719b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1354,6 +1354,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	return rc;
>  }
>  
> +static inline bool is_cxl_restricted(struct cxl_memdev *cxlmd)
> +{
> +	struct device *parent = cxlmd->dev.parent;
> +	if (!dev_is_pci(parent))
> +		return false;
> +	return pci_pcie_type(to_pci_dev(parent)) == PCI_EXP_TYPE_RC_END;
> +}
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
> @@ -1433,9 +1441,39 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
>  
> +/*
> + * CXL memory device and port hierarchy:
> + *
> + * VH mode:
> + *
> + * CXL memory device, cxl_memdev                               endpoint
> + * └──PCIe Endpoint (type 0), pci_dev                           |
> + *    └──Downstream Port (type 1), pci_dev (Nth switch)        portN
> + *       └──Upstream Port (type 1), pci_dev (Nth switch)        |
> + *          :                                                   :
> + *          └──Downstream Port (type 1), pci_dev (1st switch)  port1
> + *             └──Upstream Port (type 1), pci_dev (1st switch)  |
> + *                └──Root Port (type 1), pci_dev                |
> + *                   └──PCI host bridge, pci_host_bridge       port0
> + *                      :                                       |
> + *                      :..ACPI0017, acpi_dev                  root
> + *
> + * (There can be zero or any other number of switches in between.)
> + *
> + * RCD mode:
> + *
> + * CXL memory device, cxl_memdev                               endpoint
> + * └──PCIe Endpoint (type 0), pci_dev                           |
> + *    └──PCI host bridge, pci_host_bridge                      port0
> + *       :                                                      |
> + *       :..ACPI0017, acpi_dev                                 root
> + */
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport)
>  {
> +	if (is_cxl_restricted(cxlmd))
> +		return find_cxl_port(cxlmd->dev.parent, dport);
> +
>  	return find_cxl_port(grandparent(&cxlmd->dev), dport);

I do not see why this change is needed. For example:

# readlink -f /sys/bus/cxl/devices/mem0
/sys/devices/pci0000:38/0000:38:00.0/mem0
# cxl list -BT
[
  {
    "bus":"root0",
    "provider":"ACPI.CXL",
    "nr_dports":1,
    "dports":[
      {
        "dport":"pci0000:38",
        "id":49
      }
    ]
  }
]

...so, in this case, the grandparent of "mem0" is "pci0000:38", and
"pci0000:38" is a dport. Unmodified cxl_mem_find_port() will do the
right thing and find that this CXL RCIEP is directly connected to
"root0".
