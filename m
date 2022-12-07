Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6964635A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLGVkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGVkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:40:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D02748740;
        Wed,  7 Dec 2022 13:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670449206; x=1701985206;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OKXeDqh4fRr2y/27RCZDb9kbU0PNnPasxfo8dXtijd8=;
  b=AFl1whBsMtjljjxpzPhyDeeVHP6XNN10jVtkyL90bF8NzRespAHUL17K
   k2jiEFVjZCXN8PluOrTVwl06CNXEDhJBhlLnZ3WWeh5jr58bWznp+Vzwi
   1k+4zbEqYmQEaaVRsrD3aOgC7s/EXd871MsTZDP+2PNOmwIUnQGfZ2uPR
   +asSeQm2eiQyfvD5kpJGJ7TRX7t8PSTD9237VBa+dSN290rfsdYLKMrHc
   1NruAz9h+2Huv8SDYmJfdVi2Igg6X/BZRv3GK0vil36Ffw9huT7Kl/sOy
   rUalXFt2lfFcDwfkJHMeu6wpaA4cbdGt74aPFPdgxwbOmwepfyhkL2duj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315723769"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315723769"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 13:40:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="646762772"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="646762772"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2022 13:40:05 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 13:40:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 13:40:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 13:40:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 13:40:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkL6E7xl+gyWTNcnHEtincMNK6ih/TCp7k+nHWvXA7/OIAC5HyOIjZSzEP6LqC2DdUXb8J/3Ofm89TTeBkc9ECfpnr8eHFes0Y5jAL6FZCMreEMnHt5Acj4IREqb3xs+ju6IKG0cqzFdYTPxxUZMznidnzPIMCkDcgTFaJFaOj7eItZ+9I4N9i0u0UHd/kfYHnLfdBkdObLPf/Ayu+7uGeHIbD++h/yGR99ZgAN45Imqr7l9YQyWjGsaIjNx3C7m3GM0W0tEyWCpuBIb1sspj6o/0SP7Gdutf1RP85q3RAf9ePchvSSQFn4XhDl/S+4l2zIg1l7d4n3kShXNpQg3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYfO6kxcNq8cJYwuSyQTGCPx73gW3VXFeRfLpsUsSpo=;
 b=HMRmmDjm+MWdfT8VguwSeoYiNq3ZvvsmekmMBZXAI0DYnCO3xWMAThwJb+Ayy1t4kYtpTtgNMSgad86XYOmuiIOk+K4RZhKJEs6rmN+tIPLysIh/g4coVgIy1wnLCuti9/g+R0E6M1pSjCoA+9xw72ndVGocqF3qbNxun+oQSlsFUuo/T6HyN39cp0hLxVGWgosEscr4+44YxiTcP9v6tuNDAT+T5kz9ON9ua4UwIpH+5Jk+078eGO5dhcAsKWctmZ+2Z+bRFzTo8XXsCgYI6jx7t4ouPmvL/DHDKzSIjsMqyuTxvrgcy3fw8AngnsJJ8PsB0M2YyOSaXGYBZTcL6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB6499.namprd11.prod.outlook.com
 (2603:10b6:510:1f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 21:40:01 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 21:40:01 +0000
Date:   Wed, 7 Dec 2022 13:39:58 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <6391082ed3374_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1668115235.git.alison.schofield@intel.com>
 <46c7c7339224744fce424b196da3e5566effec17.1668115235.git.alison.schofield@intel.com>
 <638ffd5eaa3a7_c95729426@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y5C7EYz1VrG2H7jh@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5C7EYz1VrG2H7jh@aschofie-mobl2>
X-ClientProxiedBy: BYAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::41) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH7PR11MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 693418ed-147a-4f63-9c1f-08dad89b9835
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHiif/DEqSOCG/e5bVba6p/ArtsR0TdVgl3ZPEqIfuaV5IADYFNhhWOrjLqgbpN45pAxJYRpVsMOszJTcmy9J4CAHv3eHZFBlP/QbG+l1znBODhG0s7jM4dLx8MrjnF4fobLmLePc2ACQmQ/QmJcuz5Elf+eezj6MFRmwIYDCr8kXUSnBewApn3APJxTg/c+NR8bBa5b2bDUMl4J+cyTOw6hyJyoPtbvppy8LZhXtiQMaD4UgcgrRyUAC7JWByFYrzkto8PhRqet2xWckK6k5TyzONc5DrVx79l0a8ZekYwiveUj5FZAD67UDBfi4fBgYImWosCe8h4WMVPAOM6gU/TlIuqZxrgro4VKY5xh/R9yF6OoVDhAXEjRQO5LkFqRLo3uev/jDMZXcTgReqLRzGA7FLVvIt4OiGq+n7+ikWLttl6lsDTFApZ4Nv+6uHFN5hY+Vc00G5U7mchATiEl+JFvX1oNX50CNhiqRLCspASACfBGPeDO3SWFfd/7NB1x4MjaxH5tNL+tcr966wz64FnYB4zDhvVtAl4KdYZlsEfTXc3MhRYh6JRpYlQtj+JWRXvE765tTXg3qZQSjWuA9ng8jk7FzO3NLSoCISWcvNuauANWLS2cFJ4RV0K4Fch+4umVqfl4i1Qd+t1kK8UFTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(26005)(478600001)(2906002)(6486002)(86362001)(41300700001)(6666004)(66476007)(82960400001)(38100700002)(66556008)(66946007)(6506007)(8676002)(4326008)(316002)(8936002)(186003)(5660300002)(9686003)(110136005)(6512007)(83380400001)(54906003)(15650500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z3fCUCtf0qaOYkOPxK+LsI5/mXr3ll6AIoYkT+0+MUuvjrMtbob5N5hs1L6M?=
 =?us-ascii?Q?Z5RU+9uyNH6U37HkV5DivTRIbUZGglS3jzUbNcJtKlF/TH1jk5TqgOrFpiXb?=
 =?us-ascii?Q?0L0OUxtzNSOtHKu+ggI+HA6j33fjHNRAMiB7EXRWPnUzq/M5huv/muYnSRhe?=
 =?us-ascii?Q?EGX6O9KgZg4ynAtVdpj17zBXfThWSljnMi73gZ4NtrcVEOMppJ6CFERfeYrK?=
 =?us-ascii?Q?MLCtQU4uaOoEaFPy8Ov+d1taGIoQKbwAHpgTFEi/QZm3FMi2D8cDRU7vEEtK?=
 =?us-ascii?Q?dBfpGl2gk1sk3WFOAxtn1dIrfyTCKG7qYOXp0fJav99vBka3FkE2s65oiLXe?=
 =?us-ascii?Q?j4b694QmSs3xNcONea2himLlgzfOB2J13V/x+BLQ9x/BRmiNaSHyEmXsR+bA?=
 =?us-ascii?Q?7cXvg4hCcqQtUsYazGUKul136AQml/ZEFhFXHgOAPY6drbSQ7O1xFEWtonj4?=
 =?us-ascii?Q?oCdalhX8gMUvrKSvpU1SklReAuM0yzZjG5vLoNkFDkKKFRKlfzhCnNzh5tz6?=
 =?us-ascii?Q?aF94cn0+Gtws0P/6fRNBtn7aD0tH0rw1D41oLzQQQcdkBW+iOH4B6uwUH5xA?=
 =?us-ascii?Q?sL9zcHDLbVUMaxfMEqq3VQkJO4GjEaSLYzJj5WIqd5EFwjz/47wc/ZpOne6T?=
 =?us-ascii?Q?tXA166PJrNg/H4sfw09IHK6SgDzgrKMrt0EaA+/Dp0vUalcW9GYawQVYvh1B?=
 =?us-ascii?Q?KT16AXPZgaplkGpLVRJR4DMHyEhMA3kskIzaaMGLJ3vuq0jkW2Pz0wVm765c?=
 =?us-ascii?Q?6nibmI23IixSQ4xJOXuUJDmxL+BtuNrGgWmU5N3SDaOE4xd+EXew0EvvIHfR?=
 =?us-ascii?Q?97itNoW0IsxDWXYN1Bqj19ZI6c+NEEnQetKXpBs3pMORtDUHVsor/Xxx85KE?=
 =?us-ascii?Q?b52iVz5BDawUxfXmjBDgi9LSo299Z6odl5RWwLfVXxq0z/rbCvZtlEsfdI+D?=
 =?us-ascii?Q?9Noxd7Wdrj8taHa9yR4BRGNE0qi+gnF82HjpyqYlpMT3KCrRsh6u7nm00Avf?=
 =?us-ascii?Q?kftQ125RWOoB4yzgL4hjLIcWSIHEwisgNCysLFEOmaO8bHfPPl18ndJ/Fnbb?=
 =?us-ascii?Q?nvFnU0wNOO4JcJyHqcEVcybkOTmTcTPMt1Hq1+i4dWpVge10Di1Fclm1w6FZ?=
 =?us-ascii?Q?BFckDbl+usLfjhlPmo0BRUKwDFujafqMVKELeZqLpHUZQxPK0YpHeh972rT/?=
 =?us-ascii?Q?LrwSKLDopU127p9in80HLREry8dxZyl52K4v5qreMiYBcWAYQkdBNCF0jjub?=
 =?us-ascii?Q?uQSjL0bVR1XsUiywfOVZkpjSC1wzCXZaHvpWNrKng+BjSAr2QL5Yh/noP1Qn?=
 =?us-ascii?Q?p9uEYjtvVvHMHE09bydH2I0P6dnB6c6/u65MGfll7cu3h8YKIUryx/mmULXb?=
 =?us-ascii?Q?5U1I13h2NT34shkI0tQcBZGpMGevIARChBIf/hRRAzCp+8z/XkHvP+ahzVRs?=
 =?us-ascii?Q?SbDvsJumaEDfIEWXzDNxpGWy0eMIDu3wdN2WkzlmodUkAoSSACT3OsDkPItB?=
 =?us-ascii?Q?pmfucmGl5XzlgfbyyJCmOzyXBy48nY1z8dTpb8fslKzO+1ywdCfKxOGTx3HE?=
 =?us-ascii?Q?JIAFzgPiLfKjZXAMC+pWVT9uT5G1hzzZgNB3lhjfXWnaKqBfNLMo4mjOo1q2?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 693418ed-147a-4f63-9c1f-08dad89b9835
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 21:40:01.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PdsjjIc+OLlJXjoP3gfarEEfLT+anPiFbRNNyzLDU1tlrjKFnmrFdMvXd41vCbDJAGPsjcRWCCiX4mVk62AhPz/wyodQ4xXpYEtPA9dWcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Tue, Dec 06, 2022 at 06:41:34PM -0800, Dan Williams wrote:
> > alison.schofield@ wrote:
[..]
> > > +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > > +		       struct cxl_region *cxlr)
> > > +{
> > > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > > +	const char *memdev_name = dev_name(&cxlmd->dev);
> > > +	const char *pcidev_name = dev_name(cxlds->dev);
> > > +	struct cxl_mbox_poison_payload_out *po;
> > > +	struct cxl_mbox_poison_payload_in pi;
> > > +	int nr_records = 0;
> > > +	int rc;
> > > +
> > > +	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > > +	if (!po)
> > > +		return -ENOMEM;
> > > +
> > > +	pi.offset = cpu_to_le64(offset);
> > > +	pi.length = cpu_to_le64(len);
> > > +
> > > +	rc = mutex_lock_interruptible(&cxlds->poison_list_mutex);
> > 
> > So I do not know what this mutex is protecting if there is an allocation
> > per cxl_mem_get_poison() invocation. Although I suspect that's somewhat
> > wasteful. Just allocate one buffer at the beginning of time and then use
> > the lock to protect that buffer.
> 
> Intent was a single lock on the device to protect the state of the
> poison list retrieval - do not allow > 1 reader. With > 1 reader
> software may not know if it retrieved the complete list.
> 
> I'm not understanding about protecting a buffer, instead of protecting
> the state. Here I try to protect the state.

Ah, sorry I read cxlds->poison_list_mutex and assumed it was serializing
access to the buffer, not a state machine. I do think it would be
worthwhile to make this a self contained structure with its own kdoc to
explain what is going on, something like:

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..02697d1d951c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -193,6 +193,19 @@ struct cxl_endpoint_dvsec_info {
        struct range dvsec_range[2];
 };
 
+/**
+ * struct cxl_poison_state - summary
+ * @payload: ...
+ * @lock: ...
+ *
+ * A bit more description of why state needs to be held over successive
+ * mbox commands...
+ */
+struct cxl_poison_state {
+       void *payload;
+       struct mutex lock;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -210,6 +223,7 @@ struct cxl_endpoint_dvsec_info {
  * @lsa_size: Size of Label Storage Area
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
  * @mbox_mutex: Mutex to synchronize mailbox access.
+ * @poison: Poison list retrieval and tracing
  * @firmware_version: Firmware version for the memory device.
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
@@ -244,6 +258,7 @@ struct cxl_dev_state {
        size_t payload_size;
        size_t lsa_size;
        struct mutex mbox_mutex; /* Protects device mailbox and firmware */
+       struct cxl_poison_state poison;
        char firmware_version[0x10];
        DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
        DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
