Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834F4681B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjA3UcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjA3UcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:32:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E9F3586;
        Mon, 30 Jan 2023 12:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675110726; x=1706646726;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Q6BsgQoL05nE8fGPWD0o8Tv32N81pwOo2gnXB2++Nzc=;
  b=VDomGFV8v3fy21LHtvqT02xs23RzHYz37Z+zxVxu42puWIEqrM8rb0U/
   rdgtGw2xC2RT6f6wIGcbNsgUNSepREfHf4Oq23UWaYhXxpEwenKZJC/bH
   U3DDB23B+QZP93GcPlykwMo2+WHpDozQMw66azLOGWslgVSI5pxO+Tgnc
   C1Ec9da7tW/K8nwRQQ4kWJBvQlJP4y+0fsBzGcyESBe/8LmeLSrRWILWp
   rZMYN//xuPDPLj4KGjsd3h2rx9DMOgS0M+Hg7Pz8ZsbhaB42JaY88Q+gr
   DzntZE+hnLDqi21sV14xFwAb2sJHo7C8GYv3RGSTQ4QaKiDGT/5ew9yKA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326329497"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="326329497"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 12:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="838092864"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="838092864"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2023 12:31:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 12:31:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 12:31:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 12:31:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 12:31:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cftXHfH05zzGECjN57Fy9OHs5EAJGWbkMqQmNzTVbEL7VQJwP8I8WNVeRw86WHTQL1DEzM4ghoqiUpglh1uxhexR5dxW+GsWLWjjbgWRRZKYOmUDRm1bX21IPZW8fV3SIumeuQRbwIHYpydJwSh8ReIFJzbGT9vWru5q4KILAIgOQ8k6tkaF1TmUI7gbBmbYKbsopMMYQNLjgyopNVNtYhewlYLwP8GvRHBcgaOCJSwwmb/F9bvI2C82qm/6Qu5liFCHPm8uTwenJEN3byJgFeUYrwydslL1BBj9rXPr7GdbE7iwr+XwN/C+clqbRyXfn8FwLczxfdUUNrySegVhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLzlcALtEMkuKCswE6NFOwQSrn+rJK1a4UKfz9eYTMs=;
 b=nywQRhmjTSI6xe4YERK6htrPGwGa4yegem/zMb4k4q3dGvsqBjUBKNSBnoGwdZU3o9d0AtpGAmFpwKKC97kUNPuKqNdXpAfzjkw4QPIg/I/iuvh8dLlOM1P+hSj+lRkZLYHPW/E3DSdpxwbgrHb9XM74HluCNqYe/cvr+lx3mighFMYX2RRMv86GQhL1ZjSTwOltC7eG2LEjdh17T2lMQk2CyF/rj3ncsQG+HhLroOQI9wsc+fyyYUKB1k9OIcWfjVjd9OQ4bUyyQq3pfroMFNwscTbbTNKd9DUohKkU47su5nYQxIrWQ+NVn62N4jHWZLirTOsX9N07S8fenPXfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 20:31:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Mon, 30 Jan 2023
 20:31:46 +0000
Date:   Mon, 30 Jan 2023 12:31:43 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>
Subject: Re: Hot ADD using CXL1.1 host
Message-ID: <63d8292f70918_ea22229465@dwillia2-xfh.jf.intel.com.notmuch>
References: <DM6PR18MB28441B6B542B2A59CF39BF6DAFCE9@DM6PR18MB2844.namprd18.prod.outlook.com>
 <DM6PR18MB2844505042F7EDCF69CE08DBAFD39@DM6PR18MB2844.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR18MB2844505042F7EDCF69CE08DBAFD39@DM6PR18MB2844.namprd18.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9a8b7f-16f4-4ccb-8fbe-08db03010172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hx9rWM4mxNElJI4FUwsnQJlgRAE64oVVorbWoIkZYPcv1cRF1YJqDLPYKygQaANGRJ3DYOxGYkPykaApiw5SV/5Ioy93n2OuefXK7c9/Sr2os6zaw6W5GKwNv9iv2zukT+ewWkd7Hntp3Eu0+saHZq8qW/tIYpwxY8BLro9YiHmaIcaVN/RWjTkXA0K0ryPqpo62SRhLaGewG1kiZZEzyIaXJ4rVU/FkXV8/zVqWlpkA9m5WlDIa55PLmtw0trf9w+cYZLTzoDtCdqw7LvA4Y+JfoJLR4jU96J/2Is47L7Fp+FGfn9ixY0E2MYFAiCcE3Ud9tuscKPAzZ49Xj7llHyxsiX3C+6J0RzF94jyVkPizwCTNFR7gR3s0svW0dXeqmfiE+gWgucZjrU/WKK778QnpZ54gXQxYMhXNj9UVfQB5Z/rjriV+JlIZn/zM6CCZC5aE9ZxXji9FiGNHmbupn8i/kVJ18EY7P68g0yxrNsQULrCETEvITjEE7xOSDZLbOATKDNvI4r9D5Onn+DzuBZScRdkp/s0z6qYUOl3a+UAdJvaQRLB7okzd/qnAwIx8jgVkpb+4a1XqLZ7g/8H3DH40TDe/0zBoMC4g6Ugu4yCTK6NgAoBCk7mcRVMInyVh6aSGZbob/lCUT4JxXyiQP/gZtXZuLSJeU9NrhXeKLiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(2906002)(316002)(82960400001)(186003)(26005)(6512007)(5660300002)(6506007)(53546011)(110136005)(966005)(9686003)(6666004)(38100700002)(107886003)(6486002)(83380400001)(86362001)(478600001)(4326008)(8676002)(66556008)(66476007)(8936002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU9SblpMZmhnb1RmK2UxbjFaWVpyUmV3VFZBV0NQc2NPR0ZKVUdtWldNbnpr?=
 =?utf-8?B?T09xcWM0T0poTUNWNjFiNDFMbGNQSWh2dUg1NyttUkVjKytuUUUyS2RjTTZU?=
 =?utf-8?B?ZE4wZDM0YU8rQUJ4L2tZcXRlZ3diNkZ2Um04VzhnYTJlYWVxWWdQcWk4L3Ux?=
 =?utf-8?B?ODRlRDdkaWorSDdHdzBCeUZ4cjRrT0hiM3FBSjNZQ1VJYk5pZ3dFRkxvSW5T?=
 =?utf-8?B?WUptNWZwMEk1OExHcnBYY2dQZ1lDZ1FkdXdDZllKc0t0Q0FOb0NVSFdmT1Uy?=
 =?utf-8?B?amV2a3plLzNwQUVZaERzbGRaTFQ4K1UwMm5aTE5hb0RqbkVSMGNEdXkvZVc3?=
 =?utf-8?B?NkxUNXZJUmVHeE9RaEZnTGFaM2hEa3NxREw3dnZiZDZLQXJXUGxTUTJmN3Bz?=
 =?utf-8?B?aU1LVm9oVEQ4akJ4UGZNWVRTYlFMUHZidlZkeFo3NWlLVDEwUGxpcVd5YUl4?=
 =?utf-8?B?UmFhaHhHYUVWeThJUnMxWGEvZzNSSDJjbXNkZnFQZGE0Zjk5VTJzRHRPQWta?=
 =?utf-8?B?aFdadnRmL2xmY0RUU1N5aG1vRVRxUzA0Z0NZTWt4NG5XNUlaOHYxRDFSeHlJ?=
 =?utf-8?B?UVhwaWlLN1ZHTElSZUlVaysvNjBZWWk1cVZwd3lwVEk3RHhMMUZ0amtGeS9m?=
 =?utf-8?B?aXhkeHBSVlYzbU11K2h0SElqMmNPNU5pZkhwUzNvTHdxSzA3d2VScjY5bFJq?=
 =?utf-8?B?SkU3d0Evd0lsVHZUbjR3Q3k2cTkyQktrbHk4Rnh5VXh5SWc0WmFXZ3hURk1L?=
 =?utf-8?B?TUE0L0hxbTV6dmMzb3crcWxBbmFZM0NMS05qWnhXeGZ0eGZ2MjRpR0gxeU1W?=
 =?utf-8?B?Q0JvVmJsUEJ1QzNUcHM3Z1BqQm9SKzVmNEFUL3FtenhSRUs5cTRiVGFPOGV0?=
 =?utf-8?B?clhUb0FqWWNDc1ZSVFJiZGdnR0t3d3Y2RjRnUXJnQjZVQXNycFpJVnJRQjFG?=
 =?utf-8?B?REdjWEJtWStxamx3a1dOdElTbkFybjhtZkp5dTM2MERtdUJYWEdDQVNZeFNR?=
 =?utf-8?B?UnhLZ0JBWStIM3NNdHB6cCtrUVpIeWJhcTFvcmd0aTVibDh1THJDeXhmeWk1?=
 =?utf-8?B?V3ZDa013cW4zdHlUKy94d3J5VHRmaTlTTU1qaHBFOWxweE1LRVBTdWY5NS83?=
 =?utf-8?B?Yk1Wd2szbFFuS3h1dW9UY0oyVmJvbllNNStXUnhwbzBRVG0wRnJSY3o5dWQ2?=
 =?utf-8?B?MGJVTENTa0xFWjNVOWt3ZmRyU1NjMUdnTXowTzlUb3hUZmtlNW1sclFwSWJh?=
 =?utf-8?B?MG1EUURheENHR2FQc242RVlrT1VxeFI2c3UzcE03YWRRU2QzT0FmNEVvcUdJ?=
 =?utf-8?B?UzVOa0swWDZ4RHBsYncvQ3AxNW5UNXhBOWIwV0traXNCVmtKVTA1TEYzS2FI?=
 =?utf-8?B?NWxOcDJrdHc1ektWVy9FeVhKaVJkM3hFQ1h1ZHNtQWJxNndQaERKa1BqUmdo?=
 =?utf-8?B?YmNFRXBJMlZLYVlkWGY3YXkwcytoOFBpdzdqT0Jwc0hjRTNsa256QWdwalVL?=
 =?utf-8?B?bllRODRrNEdHNE1VNW5aUlNSN3hVQkhVU2g5cDY3d3B2SXozYXlXVUxmRHBS?=
 =?utf-8?B?d2lRZTdGTFZsa1FzcEhrZ3RDdHhYOE5IdXg2OTFMdGM5RlQ0L1VjU01paEVk?=
 =?utf-8?B?Q0xNMUU3SVlTVHV0ZXRuRi80V0grN0tTNzczWjBFc0JleU15STU1SGQzc0VE?=
 =?utf-8?B?UWhOcFVFeHNmbHJWM1l3YkgwYmpKS1I2cDhKMFBiR0lCeUp5L29LTk5YR1h4?=
 =?utf-8?B?ck5UMlR2RWlaVWJuTFZKUGMxQUlyOXNUckswbkVKR3BJd1hvMUZzNDhIckFs?=
 =?utf-8?B?UVhMWVpuT2RCN3B4RHBhekRYQU4rcm52Vnp1VXlJekpiVE1Fd0ljWEl0aHho?=
 =?utf-8?B?QU14djRZZk5pTjVjc3RVL0d0ZWF4YVhPeG54WlVkVFQxb293TlhQN0E0ZEhu?=
 =?utf-8?B?a2p5OXFnUFRROXFVTXZVeEZaU3FDc242cmdMRjEvanVLSS95V1ZsaWdaYzN5?=
 =?utf-8?B?N21xaS94V3dNWTBKbU5rQUpBc3VwSkl3K09DYUkveUcwUVFPd3pYdlJ5ZVBp?=
 =?utf-8?B?Wm9qQ2pwSUJ4NzRlbU1TVUNLRHN2cCtLc3Zpb3ZxekZEM09mNnhLTGErOGZv?=
 =?utf-8?B?bFhoZUtMU0Y2Z2Z6K21naUJXcEo4ZllpYWtUdlBieVhxYjJUU3loVFl3cUp3?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9a8b7f-16f4-4ccb-8fbe-08db03010172
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 20:31:45.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HN88whqGKLz2wy8GiDhK10GhP+nsWJ3zDi1fdqZN7NvXnPKMPCs/YMN0rqxyOFqNRGN5bWS53aB1WRQ6e4Z21bQHsOYFCxXv3pdJi+GgtGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add linux-cxl@vger.kernel.org ]

Hi Shesha, I missed this earlier because it does not appear in my
"linux-cxl" filter. In general, mail to linux-kernel does not get great
response from domain-specific experts, so I recommend going to the
domain specific list like linux-cxl@ in this. Comments below:

Shesha Bhushan Sreenivasamurthy wrote:
> From: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
> Date: Thursday, January 26, 2023 at 6:05 PM
> To: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Hot ADD using CXL1.1 host
> Hi All,
> 
> In our setup, the host is a CXL1.1 running fedora 6.1 kernel. This is
> connected to a Marvell CXL 2.0 Type-3 memory pooling device. The goal
> for me is to dynamically change the memory configuration without
> rebooting the host or the memory device.
> 
> The approach that I am currently taking is to use dax. I configured
> the memory device to export 8G and the host sees 8G. I am successful
> to convert the memory from ‘devdax’ to ‘system-ram’ mode so that
> general application can use it. At this time, I modify the memory on
> our memory device to export 16G and host crashes in few mins. The
> steps I followed are the following
> 
> 
>   1.  Configure my memory device to export 8G
>   2.  Boot host. BIOS populates SRAT table with size 8G.
>   3.  daxctl list --regions --devices -u // Shows 8G
>   4.  sudo daxctl reconfigure-device --mode=system-ram dax0.0 -f
>   5.  Use memory in my application

Ok up to this point, no interaction with the CXL enabling. This is just
the default kernel behavior with a BIOS that applies the EFI_MEMORY_SP
attribute to an address range.

>   6.  ---- RECONFIGURATION PART ----
>   7.  sudo daxctl offline-memory dax0.0
>   8.  sudo daxctl destroy-device  dax0.0 -f // All numa node memory mappings are gone
>   9.  sudo sh -c "echo 1 > /sys/bus/pci/devices/0000\:38\:00.0/remove"

Note that this only takes care of the software side, the CXL hardware /
decoder side is not touched.

>   10. Reconfigure memory device to be 16G

Does this reset the device?

>   11. sudo sh -c "echo 1 > /sys/bus/pci/rescan"
>      *   CXL DEVSEC (Cap ID 0x23, DVSEC VendorID 0x1E98, DVSEC-ID: 0x0) shows size to be 16G 😊
>   12. daxctl list --regions --devices -u
>      *   This still shows 8G ☹

Yes, because there is currently no hookup between the CXL subsystem and
device-dax, but I am working on that:

https://lore.kernel.org/linux-cxl/63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch/

>   13. System crashes
> 
> There is a mismatch between what DXL is seeing and what PCI DVSEC is
> saying. Looks like I am missing some step so that old 8G information
> is removed from the system. Can someone advise ?

So you need to dynamically recreate the region, especially if your step
10 above resets the device.

> Now, I can try the following
> 
>   1.  Power off memory device
>   2.  Power on and boot my host
>   3.  Power on memory device
>   4.  Configure the memory device to have 8G
>   5.  Follow the above 5-12 commands
> 
> With this, the question I have is – will the host recognize the PCI
> device as CXL device and run cxl.mem protocol or will it just see it
> as PCIe device ? Note that the host is CXL1.1.

Does your device support the HDM decoder capability? As it stands the
driver expects to use HDM decoders for region creation rather than CXL
DVSEC range registers.

My expectation is that once the ram-region creation work is done you
should be able to do something like:

cxl disable-region $region
cxl disable-memdev $memdev
modprobe -r cxl_pci
<reconfigure device>
modprobe cxl_pci
cxl create-region ...

...and be back up and running with a new region with the update size.
