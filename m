Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBFB5B8FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiINVR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiINVRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:17:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D9A6DAFC;
        Wed, 14 Sep 2022 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663190245; x=1694726245;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4a4X90q9UizwQ29HJikYrz7t9vTI+OQ6bulXqxOE7gY=;
  b=ShQw//eJuiKITSG+3/fu2rHcNq075xLQOGTpPb53Cg7yXfjwI1uUEKq9
   CTQ+ooBesdSYejt3wpzrMnqo7FM/7siEKHTeLCe0Av2EI90P/BgLd7m8B
   d6DhspUd8md+rZ0Fv6r8HSuDUgoIK8wBGeJ1IHnm55sG4oW8H8hHZ4rt+
   mLqlOhdQIvEO8lV3ZYHAi1jW5AEs5q0ULspCTRyBTLgteq5z/xfZr302F
   k6sql0t+Sy0QshPaMnFbq+D7fv5t6kJCkraDQzXB+8AOoge8mBjBVFXhk
   plmsI3tw1XBX6y58Mez5b6xK/+amyQfQfaAu9Z/kSB/O9PJeYOkSTw8tu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="362505545"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="362505545"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 14:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="706094928"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Sep 2022 14:17:23 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 14:17:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 14:17:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 14:17:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 14:17:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2fnlsevEW5ue+1errcfuFbJbcAkm1nGdRJq9Wa2OM+vL/KmpIX5bG7AmiTGyXRrcgY1VTi/KjDLYxgGrk22dwcVmUIG6CDqKO0vxiOuwB18vWsmB3mzpAPbDHoxy9dvM4beI8MKLC7x1QDSmP2H3PsWBNrGAwOt5rol+CdekrQZt5/tTX/oSpWSrrjRAcZ/3h1uT/qE5W70a8k+70Nkqnydo+S3b5nm5opLnfZBFInItsgTyLr24GczWsu5Kb7D+dFl9g5TJE7ButBMXa2KxacJwB3MYZsApvuYirBXQoEkAEhlDe75iLK+xmLnusfxlcKfht25baXo+V5GCGz9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIKgLxFwceU63V/ZHHcR2PsqI98Bm7ENlOry4wzUsLw=;
 b=W6+pN35K+DotwKSKdf9fR0NMexvdKZCMlGzJr0xp5jPxMlF5y8YU4yRyRH5uGd0WwL3tIs9I4iBGDBJOFhTf4PulpfyO02ZVAZmpsOrw2xuKnkeVfSvd321pGZZyT5YHXEHJH5xO5V+wE7+H7CriB8FdnvDuDdPKF246mioMduvpVbWyeGTMHBCvbx7xMGVCzT9wWJ6AVMpmDxJ6j5T7lJcO9tfr03N1+LXigdiYtni5tSCEEUBITO76mxbTh4B1U/VYUptB6qyeK4x/sDZJhb5Env2WHyyhObp/WY4USZPQxNWiunIq7LEt6XcoBPLgnzUNfTTCcEUrzPHcaaJQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5452.namprd11.prod.outlook.com (2603:10b6:408:101::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 21:17:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::1967:b7cd:c851:cb91]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::1967:b7cd:c851:cb91%3]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 21:17:20 +0000
Date:   Wed, 14 Sep 2022 14:17:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 6/9] cxl/mem: Trace Memory Module Event Record
Message-ID: <YyJE2uuPZQqqpVew@iweiny-desk3>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-7-ira.weiny@intel.com>
 <20220825115842.000049a0@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220825115842.000049a0@huawei.com>
X-ClientProxiedBy: BYAPR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:a03:60::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5452:EE_
X-MS-Office365-Filtering-Correlation-Id: ec45d7e1-665b-422d-888e-08da96968225
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJrxwIiYWk4Ayk+jmGadK79J/Y32GHZnOPKo2jLIVygh1oQrPmC6sbe4vlPeOj086SrrwowG4cMYyCNIZPvS/CD6xiUEmAUDRqvuceWte3+iABHaiXKi2pgO/lQdSIN0zHy21OEBLwbkmdzUE6mKEwCNJ/qWGgi4yYn6RKvlryqgMo73WZrUFX4KmW1Q5cF4PxaoxaJVHouHZnD7UJJVt/RYEsxfw4HEIk45Y9bwpognyLb0gSw2Mm2O+Bx7y/rqqArlIfv8dLMvc3HlkvDfFxwSlHaGpx6ObHKR06dURDLNLs5eublCMWECx/rsFAbHP0xL6A0bHZ1xcELpH+1lKzQleFm0BvJ+DuyhSV//jFg0Sue5P3jaKZ8nqkQdfaQiOK4I4hMWNDkr57x6tGYeXxGcdjV0IRIYnz/2IGSBzT5AsJzXjsfclYxQv27U61tzskrF6dDsM0ZE83qaa5PO7rsGGJi+IVkFsklYwbZQUJS/UbvH7VGBhU5Bizs94cpjSLXs8ODDZdbGd+i9Fcs1LQBcHw3OR6jSYG90UmdtM4tsVHCK2Hxpl1XmoY60fOhm/VUdkqFk/eyKTSpByQMTLMvPO6B4kiDYXB36ZllmcwrEY214+dqbjt5l+hHNm7GzK9Hy0tYjNBroDFVcJ6xlsohkmQzfdiKY4Yq3M3zUDOOlEIxJb17bRQxfsg3+9BLFUMM2o8Smt0mRa6FE7LSDZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(4326008)(86362001)(9686003)(6512007)(478600001)(66556008)(8676002)(38100700002)(26005)(82960400001)(6506007)(33716001)(6486002)(5660300002)(41300700001)(44832011)(316002)(2906002)(6666004)(66946007)(83380400001)(54906003)(6916009)(66476007)(8936002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbKjLGRsfgWh5911SH8BOPvmufZcnuPXbrzKChbkVfZUuyjLeTtvNrw0KGOF?=
 =?us-ascii?Q?DAb6w/2wDJI/I809xipDfhUOvS8fDlAv1v/gHVSXQHQeOgHF9aRYhiAkQv4E?=
 =?us-ascii?Q?oeZe0+KIA3G5YnLsXTPnkMw2j4L+2pUVoyTuxtm6erRJkKgPVveoYymmbXd6?=
 =?us-ascii?Q?XWWVcwwBaWse6423xqg4XO3T7+gRLYOI0Yg04UvUsLE1ORwfPOIOIky7J6vB?=
 =?us-ascii?Q?GUsqPehsPs74KjBl+29I6/jvSqgde6fWLTG4bxGCKGQANiaXK9z7D3XbGG9X?=
 =?us-ascii?Q?Wkf4EEP2WyOaM3JIFtYklQ93y0ZvN88MI7X6Aoo5CnUbLtdTjd0DC/9b6ruV?=
 =?us-ascii?Q?m8jTZICunI+qa6wFYgKwsr0E6KuMmNCQ0mLtOHMHKv5urJVnG45YTojL5/s9?=
 =?us-ascii?Q?A8dpzBzAoXaKAMoQabjXWdVGJfDueuwDLmV0uPw5oLHz1IkN0TVgoCFWShk5?=
 =?us-ascii?Q?lp6UuOxVY5pQkihYu+KNEUXvycy5eJBcP5QE/wrVVUGt6PF1L3t8jDHRU45T?=
 =?us-ascii?Q?eCmdE7kQg33NmAUeuayZhw0bnCjgSodrkQNcTXnSaLHny1may3qrtgMJx1eE?=
 =?us-ascii?Q?HqqGEJB+ADDUGIgencxMgzSZOmbyqRBSQGo9VS2vjwCSaAV9ICq/HVjeU4SP?=
 =?us-ascii?Q?zyZiPokhNLAoBzCopouNIeETqP4xcOabmchFiBP6jvFN8WrLlivejGSeteDD?=
 =?us-ascii?Q?AguxcaW9ucO6TWw5FUbu9dhXio+ZmFXkuPgsZy4cYLo2Uc/4r8854l308t5C?=
 =?us-ascii?Q?YeQgAw41aKa5UlofpdP+tfeVYBUNUnb+55bQQK9kpRUfB3wPBgG7qHnrbwDl?=
 =?us-ascii?Q?iowrsSNI7u7xx9j1ay9H1Uf+0bpCNmU3gSP1alruU9Q3NjmBBUQuzLBIFyK6?=
 =?us-ascii?Q?wSoiB5zT2WEgqbzBW1zcQZdVKeKJrId9tvGug4zwRk9UNeL7MRH80ejZZ2sh?=
 =?us-ascii?Q?M668QIKhuJzXO3XpLGfX2In5yatReB6u1opApPf9i+W/+kjgyZOea4IOVUrm?=
 =?us-ascii?Q?bfx4PIMP5J8oGM8XkZq50i098Ucmar33AVs4Covw96Q7uMiyrEe3CnFnNI5Z?=
 =?us-ascii?Q?MuNlEGUHtCMlhFVMDoB5lTVvWDwW7mrgLCIh2ovV3PkxO9hOxKeE20Rxv0An?=
 =?us-ascii?Q?l3ftv9xSWaQz+uItHKe2Lmoa7yS6VafFJRtl+6xDvc8vkgSWc0hr2HtCAPNQ?=
 =?us-ascii?Q?ZAUk+gy9k0/fqigRxx5TLYpjKB8d+PHX0QtjysG+vaCMgAqGSwQO48+R8m2U?=
 =?us-ascii?Q?NdQCgVxMpXCqzhmgciuvpQ+OlqVp7yF2Pe5dQMtdPQIj/TZoHb73k6m32O+K?=
 =?us-ascii?Q?a5WQVJuL7d5NbI1NnzWTx+kPBELba5fQNblydhK7kAPJj6Nv8ZwuuNLbnngw?=
 =?us-ascii?Q?8BeVnKrR/Eg0Mall8ZkXyextc0bZ5SR+3o1AfhHTDCRWGgFdM5l1ysv8g4b2?=
 =?us-ascii?Q?W4/NrAWx3+h8uDP8BaHPvL9wZkzZ252tCkxeQK2PK+bF7F86iQKBfgxkuAgW?=
 =?us-ascii?Q?64+UCEyVNjeSgJIULZLRSFdkrVL6LoK+ptsBLSxV+x8SBV4ixwvAinFEQ1T/?=
 =?us-ascii?Q?Wy95K5zJTnL/JzLnKBuU2NsKVMZ+opuMVZAtgLbt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec45d7e1-665b-422d-888e-08da96968225
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 21:17:20.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QknywvPx5EiruBYYgCJFEI/GkRGh4ekfFk1ODGBpXbamDUVnOk6iIdiRpzgkXFtM+6OLJeKNDlJaEv2yvUwrhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5452
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

On Thu, Aug 25, 2022 at 11:58:42AM +0100, Jonathan Cameron wrote:
> On Fri, 12 Aug 2022 22:32:40 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL v3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> > 
> > Determine if the event read is memory module record and if so trace the
> > record.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Similar comments to on previous patches around using
> get_unaligned_le*()

Yep...

[snip]

> >  
> > +/*
> > + * Get Health Info Record
> > + * CXL v3.0 section 8.2.9.8.3.1; Table 8-100
> > + */
> > +struct cxl_get_health_info {
> > +	u8 health_status;
> > +	u8 media_status;
> > +	u8 add_status;
> > +	u8 life_used;
> > +	u16 device_temp;
> 
> As previous - even though they aren't aligned, I'd have thought
> __le16 etc will still work.  The unaligned accessors are fine
> taking __le16 * for example.

Ok my bad on using u16 here and I will change it.  I 100% agree that these
should be __le16/__le32.  That said there is no need to use the unaligned
accessors for the 16/32 bit fields.

The unaligned accessors cast the pointer to a __le16/__le32 type and no
architecture redefines those.  So using le{16,32}_to_cpu() should work just
fine on all archs.

[snip]

> > +
> > +	TP_fast_assign(
> > +		/* Common */
> > +		__assign_str(dev_name, dev_name);
> > +		memcpy(__entry->id, &rec->hdr.id, UUID_SIZE);
> > +		__entry->log = log;
> > +		__entry->flags = le32_to_cpu(rec->hdr.flags_length) >> 8;
> > +		__entry->handle = le16_to_cpu(rec->hdr.handle);
> > +		__entry->related_handle = le16_to_cpu(rec->hdr.related_handle);
> > +		__entry->timestamp = le64_to_cpu(rec->hdr.timestamp);
> > +
> > +		/* Memory Module Event */
> > +		__entry->event_type = rec->event_type;
> > +
> > +		/* Device Health Info */
> > +		__entry->health_status = rec->info.health_status;
> > +		__entry->media_status = rec->info.media_status;
> > +		__entry->life_used = rec->info.life_used;
> > +		__entry->dirty_shutdown_cnt = le32_to_cpu(rec->info.dirty_shutdown_cnt);
> > +		__entry->cor_vol_err_cnt = le32_to_cpu(rec->info.cor_vol_err_cnt);
> 
> I've lost track, but my guess is some / all of these need the unaligned_get_le32()
> etc rather than aligned form.  Maybe just be lazy and use the unaligned versions
> even when things happen to be aligned - then we don't have to think about it
> when reviewing :)

See above.  I think the 16/32 bit fields work as intended except for my lack of
using the correct type.

Ira
