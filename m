Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECDF5F326A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJCPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJCPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:24:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E35BC7;
        Mon,  3 Oct 2022 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664810676; x=1696346676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Sn/pKA6KPDgsZOszuzz5XsthCryj6lDRJPQa/oORSQ=;
  b=YdALGbyc32Bg5WgZuVWrrqTg6YqDg4+CDAOPzisK6xTV4Qf1+pru4vn1
   75lXHN0eJTh8swWKDQyVEhp9dgZP2vo02agm4ZVCFuHoNmfk04NCFkjeJ
   bDwKdgsinZtlHptWCtdy6pzSMft5xtjKWpX+TlIyn0y5xnsuFDlg5I0Ru
   GVf53uGnWxoCcjMtbmMuQL7Zo6krs0jSrQ9dn+GDMu7d5xsLrC03A3kJe
   YgZdNJD/sjWEVZTHRKTnEwyIAGLW/5AKJdsdfS3kQPtPAAHLpiHDcOUWl
   vTf0zZQGz2iTaZwW0alQdYbCk8ugDMMw8Gjv27f257hnsSOzAsim7PLIN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="285821284"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="285821284"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 08:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="712635247"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="712635247"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2022 08:24:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 08:24:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 08:24:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 08:24:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 08:24:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gceloLZbfx9Y5wMVJRQujovTxoH0PkPEB4uCt3q24oKF/HB0y7e1XwOr2yWbBlcIo+RjGjRP2Pv66MGQJvK1XoKCbh4kryMihvuGQvhMjagMZwz9w1Hh67uy6WF8kGIwajmOkU6mG3AKd0Po/Z+6kNCWVqAKr+RoOYeqaozQBqJwx3mrqOkF/RjKe9hPhneaDMxgkJSOJfkZYQJeM6TX8BzUe1+G9/1eCyiaEy34M69VzVI8F5Zt5yyN6/Yz/ikqwk4cheG4QI0zv1+xiiFdW8qXptDSAXHdqz0cqmO35e8s0fDyw2JKFtqE2c3eLjZ6B7sokRl+1E++96iyK1lrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l+feBvax6qu3NZNnRaYWKkBL2CSD+gAXBAsLnY/fOo=;
 b=TtLXa1r7QKmXDMkVXteqDOqQcJS3H9JS5tsBggbMLjh96u2QWTvhnC34x+90CmQiFcIR8OIIgVNbKaFV/LJN8Lqzix2Ns6RduY5HV5RG2JlPlBMHKKUhchBe4aA6rAl+eOcoHglLls0FILvEmXi6BvxSEpX91xgpmM/y1Bvc03EhlHsSeY+62Q8r21O15UUBVB06TpqIr3XAOILfTVUO9N7gl/CYSKKE9UbgoKDJ8Baedn8iNnOn9AIDFdTJobPL9rn/aeY6H+N+jsD1Ua+DUr3ZCSGPODKvU/D1moTTkJzjSe9Bsk2TycYXxaxcCoJw+DhvhrfwG4QRRCfI8FsF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN0PR11MB6181.namprd11.prod.outlook.com (2603:10b6:208:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 15:24:16 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 15:24:16 +0000
Message-ID: <f42ac1ce-c23d-49de-0b32-d82cd5f49e1f@intel.com>
Date:   Mon, 3 Oct 2022 08:24:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.1
Subject: Re: [PATCH v5 01/12] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431033184.373387.6520785024194837522.stgit@bmoger-ubuntu>
 <9c45dbf7-854a-1a26-8cec-dde1a1d645e2@intel.com>
 <1cc357af-326e-cf7d-1a8e-2a0c511912ab@amd.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1cc357af-326e-cf7d-1a8e-2a0c511912ab@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN0PR11MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: d5872d72-91cd-4afb-2181-08daa553552b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckN3/HmZH4EjNdnc9KdM4F0z4ajGcXlsfqCdsa7OGfu4G/rJuqmBm+J5c6JKD+cE4Fb9joXVzBXfrfAxbci2rbGlIoEUSo1rOK2O/q77cfKaexG1XOgmkEf+0TEVcYELk4bDvmbQDOTbvtyuVOI583BJQz8D4Sfc+X+Pyk9MEkQMItqr3B9vfIXvmiltX3Nd/aAoIBfjvNl0EOrCAv07CFdqIh467cajPj5Khvwqw4p+3EcYmrahBG4hqbOD6yn65LxrAzqT9j1ITHH60sNPlS5eMcL3SYBMA4vLtTvkhjxz8NlrAcJ3WCF5JV69oyxiBW7PHE6UtjkGP6lbirnb91f+CUPnYPkw9RwBtEzouODz6rpUUjDjWMaoQlVgRQ71qbJ5A2g9ikXL076JR5+Y/gXMFI96rCKBZq+0vrtEOVIlnchtGv0Itsr+vZSt0xXDbOqqpkt/66/uWpnbPMH96P/SOIiokf7WBAf/UOwvGJK72SjolA9LyhsLACD3M6SRmQIQXQg5SnwETRPfTrhHZpZddlyMdpI4n8Pea6jy59a3Y4UV+EOowPvYInTcWsJ5Xt9ehLZw63HhVtUL+Tb5/zQkDutMaKsa2Uwi4MBE8MVs+U9jKZRsER2TFYRQNuYPk2p2XovuWav4oWeboBL8Mbr4LT8tSCNQjt0drPAq9tXB3poXP3cSqpzNJTSJl0c/Jn2q445ZARpAsMy5mo+/cmNpVBLtDymNkwrqw+pwzBqgLUB7mGdoyR9hbAWQUax7bERXVMYzYqwRM7Boh1n6PkCYkAY9XKfhlxTjPAeESoqgoch561Fp2YwflxFanW9tN/AvRu8WsWBN33GEZ385Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(31686004)(44832011)(4744005)(38100700002)(5660300002)(8936002)(82960400001)(86362001)(45080400002)(41300700001)(26005)(6512007)(53546011)(316002)(31696002)(2906002)(2616005)(186003)(7416002)(6666004)(66476007)(6506007)(36756003)(6486002)(966005)(66556008)(478600001)(8676002)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9EWnptN2JFWFRyVExKbXJ2SG9GL3NtRzhnTUFvNTI2Ti9SL1hjdDR6eUM2?=
 =?utf-8?B?Y01rYVBTTitiOHNkb1A0YWwySVpKNi9SbFhLbnpudldmVFRKQUpZSGE1b3Zm?=
 =?utf-8?B?Z2xJMVkzUFdiZXk4bXVMQkRia0lNcXNvNDlhSHdsa2JOd0lKRGNWdlFTUVhN?=
 =?utf-8?B?aGdIU0tMMjYvUCtZK2xCdWM0RmJwb0E0N3J4d0J2Vy9FNWVWYXhpY3grSzcy?=
 =?utf-8?B?ZitvcVAvOUhXRmlJdnZ6U3dlMjJ3R3JvVnYxdnRwbTRFR2pzbTl3SFZaaTFK?=
 =?utf-8?B?aFBrdGdXRGxBVm5GR3prM00vZVRVZysyQWx5WG5uWjc4QXpRZmhtWkVaTE5x?=
 =?utf-8?B?OUtUSm02Z2tHTld0ZStYMldCdDRSNmdFTGswaytZVW5UdURoU1ZycFNqZmVr?=
 =?utf-8?B?dnNHWlRTNkxNQ1MxK3EvVktUVTh0azF2UVZ4emNiOUh5QXc2aGhtRUFzWHJo?=
 =?utf-8?B?TDVUcWlIaURTUmcraklsWFUzcW15aElIQWhrN01XUXUwNGtsakFVaG9ZM0E2?=
 =?utf-8?B?RStnbWI3TE1qcEJCRjFtbHo4N1d1eWtRV01HUUlKSG5jRjRXcFR1NjBFU2VY?=
 =?utf-8?B?MVVMVkJXRGduQmRxSE5WNHR3aFRjZFhEMmNOZUlGYzd4Z2NkWkY0allKR2pU?=
 =?utf-8?B?NmtqRGJ2bFRYbXpwQWRvZG9sekZXRC9hdklvbFZ3eUFIQkJJNWNTTmcvTGIw?=
 =?utf-8?B?QmhhT3J6ekNQQjNhWkdXdTZnd2VDRzEybTRpQ2ZNYzdCY2drS0NnRXRNSk5u?=
 =?utf-8?B?c1R1TnNHQnpIUDZoTDQvU05uMnVjTkprajFCQjdCL0hOK056MG9lRGxYc1lS?=
 =?utf-8?B?cHdOaTR0SmtuWTVIcVgyR2x4L0k2WS94NWR3QUQ0cmxKdCtYTEFoTkkzVVlq?=
 =?utf-8?B?NzdadHh0K0RhOWd3MVl3VkUwMlBCT2o4cHduUW1EYk1MUi9OVEdkVVE3Y1JB?=
 =?utf-8?B?ZzJVd053MkxaMGZHU3lteU5HRzRBTTdic1pHUzVxekcrR3UyYjlHUHhHRnhB?=
 =?utf-8?B?YkpVSXdNZkZWTFZ4WkF6T3g4TGVLMFNLdWNUdXhPR1hsSnBTbUdXcWozaWpG?=
 =?utf-8?B?T281VzZMT2p6VDFoY29LU0UxWG56NTFNbDVsZ2t2Wm1valRoVnYxWWs3MXJC?=
 =?utf-8?B?NEFPS0NWRDMxem5ya0FEaUZjTjVwbmtXckkvZ1BtbEJQUnMvaWtJMWU0d0FL?=
 =?utf-8?B?cEFtNnlpTXg1NjNYTWdrNG14SGFxbFZmVWJaRjVObzl2UHFCMXE3MnBLTTdk?=
 =?utf-8?B?dEk4Y1FnZ1g4eFRoWVdHQk96SzExY0U4QnRQbkpwZkVnd1UwQmJwbzc3SWt3?=
 =?utf-8?B?cTlGQ1dOalNLVFdqY21ZblhNSFF3bTZLaTFSaWZNSStHR2NCeExtd1FGWkxr?=
 =?utf-8?B?cDZpc2hqZ0xqVUVVOG9yeFYreHhZVUlhN1g1SkVWa2Z5TDBRak9yWUVwY2Nx?=
 =?utf-8?B?UGlaVFVGV01ERWpzN1ppeStINURlNEpKcWhmaTAvTU1hZlBuSFVBUjJqaEtp?=
 =?utf-8?B?Q3htM1Qvb1ZuenoxWlJ4M0E1dEE1MGh6SDNzQlRxNnJ1L1g3dGxVdGRzaFVY?=
 =?utf-8?B?U0k3MFR6ZkFEZ1lld0FSRmtJMmJYb3lESkZMeXVvYVk4Mzlzd0dOM2pjVkp3?=
 =?utf-8?B?c3hSWWRHdWN6YktjN1AzbHE3WmU1V2R1cjRCMHRzaGVCNFpxM1huYmRVZ1cr?=
 =?utf-8?B?ZlA0cnlZQUJEalgvUGxhSkdES283aUhGSUNsZUpkdDFTT3MvSndDaVR6M2N6?=
 =?utf-8?B?MS94ckNPT0xDT0RuYUVDR1lnRDlyK2hBUTd1ZkhpWDJ5ZERZVDdmb0RVRk5R?=
 =?utf-8?B?WFJNZWFIQnJzZEEwalk4QWZsZDlMYm9QK3ZxWlBBc1RtQ0swRko5ZGhXYUZp?=
 =?utf-8?B?VllGWWNVa1hETGtNUi9iMVFkREs1cUlFYnIrUUNWTHBQbTVSdVRCNzg5akVC?=
 =?utf-8?B?dEtkNmVCclo2djZSNExMSE4weWpsWDAyK1dwU2JRWHZFOE52THpTT3RLMDBZ?=
 =?utf-8?B?UlBiQU51VVRNS3NnbmswbXhZbldNMGhOU2UzZk03SnRCb2lVNkdKckVtRHF0?=
 =?utf-8?B?WGFEY29oNVE5TjdibVY1WFVsZk0vYVBpUFYxa0JiODVjR2pHc0hDbTFpVHVv?=
 =?utf-8?B?RDVwUlJRNEFPb09SOGJZcDBtck5hb2pvY0lFZUxnR2lmVW9ISzNGSUxjTkJp?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5872d72-91cd-4afb-2181-08daa553552b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 15:24:15.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cWKjHMhD2eVQulrNo9OFIhINuo0lFWaQD0dqZCZdyJxwCSaex0iRxbP6aA6x8vZ7dBU+5pn+Ua0/kY5M+Qq/zIhOrIjDq8uGM0pIzEDeq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6181
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/3/2022 7:45 AM, Moger, Babu wrote:
> On 9/29/22 16:58, Reinette Chatre wrote:

>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2Fc4a9ea23-4280-d54c-263b-354ea321f746%40intel.com%2F&amp;data=05%7C01%7Cbabu.moger%40amd.com%7Cdf869c35332b477dc5e808daa265c0cd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638000855157338562%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=4tuK0pMrJsiW44IKCkeZV8ujS4z9STOa3mKfRKbHulk%3D&amp;reserved=0
>>
>> Also missing is highlighting that configuration has changed from
>> per-domain to per-CPU and why.
> 
> Already responded about this in patch 10.
> 

It is not clear to me which response you are referring to. Could you please
provide a link?

Reinette

