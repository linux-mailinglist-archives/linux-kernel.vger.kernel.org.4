Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1724B62C910
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiKPTh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPTh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:37:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A63275E2;
        Wed, 16 Nov 2022 11:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668627476; x=1700163476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sHa2BXm+wHW/cDcRaW/ETMsv3/mSAgHxu5zt1q9wFqo=;
  b=laQOoXCrBs+uw5Z2cIdzOAa04v3KC58HgNXMpFylB4gzd+zwqx/a39sS
   NPIEXbYq4QrY/4tjaymRz9ZWYMJ2vg0YX/RF95Em7EN5Wx62vqC8SKiju
   9m1U67CaaFlaT03PKTadEmp6Ifz0/eHpVXHqnXMzb42ZMYBOKr0mGq0It
   zoxxkL1rA15HKRfKECg8mFjM07BXV0SxG4ztwm62hVc8JGpUigIbj/nUK
   qRAJp7QTYSax1OS2R8ugUnCbTAYqZ01szK4/UrbhEv0TQN6DPepSC3QhX
   NtR+HD9UuqdWeM4zg4aKVJscQQy5IS6F0zIQsK2AnPj70L3d0JxVVckxm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300171753"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="300171753"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 11:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="968548855"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="968548855"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 16 Nov 2022 11:37:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 11:37:47 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 11:37:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 11:37:47 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 11:37:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/M++sypOs8VKlIf2bonwMJvLIS2rB0JYl7UZEQMw7Lxtv7p06nwA58h9BCYxrNARlE0g1h3baJy+YLeO89Q3ZeYbIM/5dNckz47/Kbky5GHbHhQoipDCREkrWuxoOagMheid0ewOoDFXPmpp6GJ9xVFCl/NcJhMsyWy1b8Dy44VpkzB922SqzalaxTyUWiKu2d1Xc9N7nKOuD6MUDMCXrX2dDp/PbbveDkBPIkBVylURzr+graoCedGKS49BsO7cu+IRGNIOaeVXKiFqOI49wbCtshJW3TQ1ClNnjxwbFASHeuXkDBsU8X8+W/L9UK0EkBpnF1S/fvjD5RQYw1L/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHa2BXm+wHW/cDcRaW/ETMsv3/mSAgHxu5zt1q9wFqo=;
 b=Lv20ODyXAJUZJo7Igsjf8p6ID3iHVLxEmTQsurmVxHWILUhrsmCFdidhhqHVNBW9XbO4KY44M+o3DPxDQQ6WbztF8iaRorVGH5+x9VuryFeXyLCFTkhmmcBFlTHSywDnhs9ftftZWNm3IcQWBmEBXYMONxhtu1SbgQLlRTBwT3Nw9zaw7GfFTuVeJX5tJz1OBE+ySi0uTAvtjnkhnFZHoS0eDecHJ5pX0CppCgE/aly8lr2k8rEVY3gRuPgAXMrRywPbKEwcFvlKd4S91LwgrKL2JQQ3CaSuJMYZkP6A1ECMNGyh0JcLMKaFCbIu5rVIp/eYVAOnCNhl0CGk70KTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB5130.namprd11.prod.outlook.com
 (2603:10b6:806:11d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 19:37:44 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 19:37:44 +0000
Date:   Wed, 16 Nov 2022 11:37:41 -0800
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
Subject: RE: [PATCH v3 7/9] cxl/pci: Factor out code in match_add_dports() to
 pci_dev_add_dport()
Message-ID: <63753c05781cf_12cdff294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-8-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-8-rrichter@amd.com>
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: eb70897e-3ef6-4167-5b09-08dac80a082f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMcI5ggTc0lXJam9cTro70pwzrezISuGUqkvNYnIf4IsI58XxRuv+hCcTBhgxyNmkh1RxDAdZroGxd/K0N2T0jt9jfvPHl8MuvXVPxi/OIvEsh1KbtRf4HDEwfsLMmaob3qzOqAnRLJvzY2mo20lFMAw+1Il3J8pL9j4HxspICEpHXbyzpqxNWsvvlUS5xOpo2n/4dT5+MgbO8pApPOjw0JSvSO+wbKBm4DcbmNlm8B2mux+k5j6hC4WqK2GjaqzpufieRTRyZr40dkeosQJQEhQBCrkRxHp+RvTnfh3Js9QtYnN+ltKPn3zdkQ188isHCmGkLqc3Op1sTSJSnFp6xX3u/duh3A6h4yWq9Xhl0Zr4lToLdUCfBjmo2EmJUwvBFpXuSNEEVQpQHxuSEtSlGv20CoW2NSVHSWWOLZqxN5OIvUpNv/w2uiiFaDFzmSkqV1YZdSX3wAsjVSGrdJWb+jbIIEne+tIzn/O01BmzREya0umqaZRP8SDWd8EOObRpn2uUdGfZ6Y+tmc5ED7bjdZ299i9sH/bKtG67nJWlC8rauP6BCmWpAU5lu99LV/9hw2DrPbiC7P9CMByee8UZbCQXI3AYdJbo+7g5TiCGMb+PiKsVOXfuQcoVqAPNVaxiizwOy1xT7adXwdOcUmfpPsnc38U0+yjUcKSi9UOOe7HCmzpcYNSb4hEQN4+8FGGM1bqoLzF4rKM14hPuUnAfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(38100700002)(82960400001)(2906002)(41300700001)(558084003)(186003)(86362001)(8676002)(66556008)(66946007)(66476007)(316002)(4326008)(54906003)(6486002)(9686003)(6512007)(26005)(110136005)(5660300002)(8936002)(478600001)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MDYxH73KJOQVDa0CWsE1hRiWOO35YhGgy5vuWEZZYuSDcRgg/JjydoDR8ivK?=
 =?us-ascii?Q?GbVArcqIxsEApJzvLGC83s8BvXrE7v2ZK1djn6ht3vui/Z1/10F41cf8Qsbs?=
 =?us-ascii?Q?7ayMZrPfpIx0TKj/XZfBHJ2A9Ri3NmRwuygAxY/jbk/lcKc/buInXehsN9Vx?=
 =?us-ascii?Q?J/erAIj/yvFzxn8E8LAwoQb3Q31RSmFk782LosSDBx0zzC0dwmfsoPHk5r8Z?=
 =?us-ascii?Q?Fl8YV/q+sdSQagSrBz14CNfyhRxlJ/irYziWsLELjCARZPeDFEpgAL2zoJDA?=
 =?us-ascii?Q?gex3w9YsmBVVGu2gavB6OwIZEM0gBM+9B+yvKdbkgs/Bf6yJWTEYi929AQCe?=
 =?us-ascii?Q?heq/epKu2zvegqt9V/CKfEZxqSuVSezsfKVHmxvM9Z+1EP6kkTVwDhkCNmoK?=
 =?us-ascii?Q?o1hx/Qpl9D90JX6jyS+n8BuVS/LtLwkm52Awk8K929T5gN3YhyF4YlAuF94R?=
 =?us-ascii?Q?hYFK2Xq+6P1NdU/5qqi81KIk7jA9wd6Kf3hnaLVtCsSTLk2I5z278GHncreW?=
 =?us-ascii?Q?UFwZSnVz45tEDUjlbsfxsh+7x+Z/AIn5YxKCmOCjeHvm5MAG7DqLFHbCeChp?=
 =?us-ascii?Q?8XvI/64J2xn/YCXPph2CJ14ONJYYjhkzu7NmUqcT1PlqnOR9mwj2alMfDn60?=
 =?us-ascii?Q?z71UboRZvyFi8luK9mbfJiY5+oL5DYUZLIcJuUlpExnIqbaG4x0Xf1plSjoy?=
 =?us-ascii?Q?ZNdLCsnVV/E1smlC44SDYzyE5FFBK6/sUjRTsC4MF65tlhfpaXbmWL980Lmy?=
 =?us-ascii?Q?/HvtlFEJM+vHaqSr2SwfeXOf0XMMezfv3iYluqA8yfTSAc7a5tCuu5uiwStf?=
 =?us-ascii?Q?9Oq7KFPBnxdZLWB+tB63NN3M+xIpcpPZMqx6n4RLTL578wE/3ixAf7+BTycv?=
 =?us-ascii?Q?8nkDU8c5ML+Qozd7sM+x+fb3ezRdqY0OwaczkC93V6+wo7skCioDBMQcjOr+?=
 =?us-ascii?Q?YrR6OCUO//qiius4+9rG8GX4L56364xqC2dr7YOM2z5f3YSJqjrVBLggwN8f?=
 =?us-ascii?Q?ZI/m57wLWmti3QmXghxWHX05aGUw/UA58nwmkz90gJh2qT8MbesSQJBf767R?=
 =?us-ascii?Q?BsEW1s513igosXqM9v81eqogOmDtXOJKke9xo07a0ItwJFXsc0DyKCSWbGCe?=
 =?us-ascii?Q?vcFFhJgglm8n9rbLH5LRL9AGWjV//dy+wgrg81Is7j/lJ0EufNF4HBWeMsja?=
 =?us-ascii?Q?7TRgqSQypPa4P98l3X2wmIW6YE/ViCoMYWh6kEQhzAHnvsxEtPTejAnzZx+J?=
 =?us-ascii?Q?Yq+zU8AIUGPp2X3K1U51mEh9JjoUaUzLCs4HFqonmRE/FXsuhlff7hnMP7pU?=
 =?us-ascii?Q?Hl0s7GUMl+NfJju7dP27ySwecE72h1G+OWEONwm2HFNudfj6UiwIcXgXO0Sv?=
 =?us-ascii?Q?6Y0RiQFiVSYVctti94fp0Ka/yOTN7SbCdaW6QbZnme/yhvHUkiKg6V1btppi?=
 =?us-ascii?Q?cDAa+zkLzL/Y7QlcuRmRqsjbBJoj1gDpXEWmdrUR0lQLudSeaYewUfswKsHP?=
 =?us-ascii?Q?4DNIBNXYVK5cl/isOJokhS7CtjOCwUGVHgTGyJ5ttqKO5nruvqfl4CUcO1RW?=
 =?us-ascii?Q?PHr/KwLmzdOZBR2wGulMkOJkuG2WtK1V3rwS1mFvMKNQdV7CO+U83nb34VNy?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb70897e-3ef6-4167-5b09-08dac80a082f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:37:44.0301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FL8Fiys6wZWqtpRHzHAtLfTFx4RHQ/xRtnyRbnadvFHAsHbQyH5VyqOW0qnQCm2T3vbN453SzA/biRWqQXhefcF4oYb5fWr8is+BjtKM6CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5130
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
> Factor out the code to register a PCI device's dport to a port. It
> will be reused to implement RCD mode.

Per the comment on [PATCH v3 6/9] I am not seeing why this is needed.
