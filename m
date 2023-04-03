Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5D6D46C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjDCONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjDCONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:13:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43771C1E5;
        Mon,  3 Apr 2023 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680531193; x=1712067193;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Nk8bAfyRCmkyft+LfTrStK2i3h/sThXnAgI5cBZpNZM=;
  b=Vl8CbeovcGdc46IV6HfAnW+t/PlXU//9exvcnIiHh4iMLUR8tL8KsAz9
   JIX8mzn2Wjj+PohVPxmKhz42sXlZPo1b0yMK8V4kPAyub6megoVtvKfdw
   qwlPwhLK7TvzUBYd55IHJRBzaBjtHHQHAOT4dIzHnkR0Ow3PSh4ztFQ+b
   OM9Tm1kifaCM4VP8UZ//QdWh/ZhbvLGHBntcFujauC99TZTqfpMKmY/UY
   I0Yfqmo7+XtDuguyH4J58z/paZoy5JTY6ElHO+Kj+PkE0McUKRxvioRyf
   92boibETCfvSpa3JIRjzmFzlFlKw4aQ0LEzlMrwhmzdhaL20UwLioZP7X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330480923"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="330480923"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 07:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="688532895"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="688532895"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 03 Apr 2023 07:13:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 07:13:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 07:13:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 07:13:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 07:13:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo7esNtbpfQF5QKZV4hR7Nmb/vde+o7cCYEguuxbdjEG47sDGoo6a5V4hIVNWpER7qeMCOkjiQ0MfcomH/81DRnPWHNFhFccAcN6opVsnB0BhL2Agkr9e42tiQgR2zsFN3sxvOZxd5CPdIVBjoqXlzvixU+yidO5JgH333lgHA53ZklA617issAK7sizG/rh19eU5GQVsYbR8CbHVYXJ1jurGDyhOmmwarpxXghJEl1zO0EeSAgrrF+GlsJ/izJGbss6K0X49o575KkiZ44uRYcLSHAufalMHG89PdE3/t+DGJRjVpdY+ot0B7fHkwcD17NkcF9m9AuCLTXVPOAKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wor4w9CsZLdBvAxt2qFI2Y5jOtkxOg9r3SLfQm28PHo=;
 b=j7BYVTAcpt96WVlerZAyjaNdYkac7bJDSz/z3o8xPVmp9eMqgVMQI6KcuSMmhwsR1PzFpPDXlUdTSEQwheZwKvioSDjx8cp3WLdi/NXEdM57FWSoUC36jMwuQoK985SD3VfjOK8OsdyX0pPS2n431Yg2ko6B6Y/9vCvFeIfYy9a//e3AOOXtswXoaCOzna/p8Xpv4WU9JfxtocCeLG3V63iXC7dLJsyj8SxbgvMDgs4CgW++IMh+7MxL33ipuRuurIsYFTaS59cFqHc4IOjqOfSsQTqBZxvlIorbP+eeiVt0ggg4agW8kF+l5SRsmSg5LW5OztkJ8PaHcb3KIMxFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 14:13:08 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%8]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 14:13:07 +0000
Date:   Mon, 3 Apr 2023 22:07:10 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Joe Mario" <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, <dave.hansen@intel.com>,
        <ying.huang@intel.com>, <tim.c.chen@intel.com>,
        <andi.kleen@intel.com>
Subject: Re: [PATCH v2] Documentation: Add document for false sharing
Message-ID: <ZCrdjpIoOS8ry7y8@feng-clx>
References: <20230329073322.323177-1-feng.tang@intel.com>
 <ZCUPxMQPJ8ETvUbM@debian.me>
 <CALvZod48Fwua_VJvnzHatF-J4YRWqfMFnYjYN6W0_ioLtPZEfA@mail.gmail.com>
 <87h6u2gxvs.fsf@meer.lwn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87h6u2gxvs.fsf@meer.lwn.net>
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: e6885e2f-87c9-4ed0-4ee5-08db344d8c55
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVvRjMpDQTLui/vZVb7dDtA5/yi0U/pRFR2ShkHfQFxfhAVk/74iEsS8pU7jCO1c4jBtCOCXGGiHX7LsbV9u9rL2sTsj/irJEHX+07d0PoGo2mckm6yQ0+ZWIdfExwhHmRIuRTip3zHqi5KysP6mkzAPBcpgLVERPBsxK9dmXfHM54KbUmIrODXw2A5iLlRNNyEsZR0z83up7972IGMA5h3dDvPLa+oudqeo0LRTiahuBU/kZYThmrPtbJUlBMh/9nxzMUq7djBV8AX/DYGIcFnWLskhxAd19524r7H2g2tYEHm0ZgrRekg4q6P3G1VKaZzAib5oSZj65SLjeTXdXx1LpY56tW0VdxhBqbukl3UTocAJUdzsiz0/HbQP4ZX5GawuyLLhXGARLFnpfdTonoeLoUfVFJTC4qPi2IMm4iHh1byh1qmv0d2fyIQy0HBeQ7inHBaWyfUXqYheO9JDOW19FTpX/OWfctU9wGZbZqAth/nU3AcW6rvhCja2rSwlciFvPs2H6+dKMcgIruU57y28CxpueqUfnJkrvbo3/S7bkz3z562uhdBkXzL5dZlA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(2906002)(44832011)(38100700002)(7416002)(5660300002)(4744005)(82960400001)(66476007)(66556008)(66946007)(8936002)(41300700001)(4326008)(6916009)(8676002)(54906003)(316002)(86362001)(478600001)(186003)(6666004)(107886003)(9686003)(6512007)(6506007)(26005)(6486002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGIqyH1lOQvORVPyTGIF70yjMC08klHlhM3Zc9mhd39LDX7YBnmUJ8CqlTHv?=
 =?us-ascii?Q?iprRkM3y+mEwktWnpaRx6Fy5NcvOBRRJDgIGA7J/k8Ysx6wmqHJ1catoU7M9?=
 =?us-ascii?Q?0m9SP4Ke1I91AfFhpnDknOioHHsow6B2Gwez59AY4E6XpCKsg2u5EKg6t9GA?=
 =?us-ascii?Q?RNS/oJ68yUqT67ctsR3MEOwXm5M1/LURcxmTh7cH1dbu96ei7oliD3Z2gF7v?=
 =?us-ascii?Q?uzLfU5uhkMEZb7P0LUsH4d782MUKlpKFtlDPFMXIElgr8IfVRhimewBnrRfR?=
 =?us-ascii?Q?wTWuKxdMs/qVcokGBXP0gNqfnE5In2T/QElVtMBQkxYyMOklKzevsitMOQT0?=
 =?us-ascii?Q?MeL/iT4T1bOBU5E+R/f8DYCYgl5zc05qVB9M8cCW8kcYsNmt/sOnKME0gtPQ?=
 =?us-ascii?Q?9TXJe4qye8uIYb5jaOxz9Zul+OjnMv7NW56otdhjTkeQITHetctiWhlsrryG?=
 =?us-ascii?Q?aW65hBR+S0NdRWYVXZrbyH1onMxCmjCCITraOSFVcLtE7UVDktcJcCv9IWlw?=
 =?us-ascii?Q?lOA/uJydKvAHRqu5JpIyjByUuNPDl30jAAYqeafDlenRgDYjyOVL2m75LCrZ?=
 =?us-ascii?Q?N9NO+e5T72NqTJ4KQEmhOCTW1PujBldbNx4O6YN26hgNTd3OcF4emp7e0zg1?=
 =?us-ascii?Q?MWYReAKOQZlwTUhnr3Va4xgbfQmLTWRGrS4pyjaNvcd++6YcTQ5fcbugRKmA?=
 =?us-ascii?Q?AYRmD2pubmxIKmgWrL6jrW1NNTgjWjVgl/Kc5Fi2wCZfSp6pn/HqKAg5AAV7?=
 =?us-ascii?Q?6KSZpypuo/gDqPER8YRZQLUfbDd4HuC3F9VUmBG14N2SwOzPruaQlIp4bLo2?=
 =?us-ascii?Q?8oBN5NWbz4I7b9iE80w9vnFkOAWVgprEVOSPMIS2bBSWXVR/lFaHBvFOJ28O?=
 =?us-ascii?Q?zPOUjXb0H7YR6GRpI/Ufa4m3dt900/MVyPwPZTCFYquC7htx32gNy+AOmI70?=
 =?us-ascii?Q?ZnguNwWBmhBfEuT/i7f5jB0Zv7svIEpzYxw5gvKkDzF1ZRP0hNWvZ5UEe3xE?=
 =?us-ascii?Q?8OhpNKuAj1BZ1JdZF9PbWaTPJMYBd9mdcxtD3wWjY0UO9LfXMlWKZvi21G8r?=
 =?us-ascii?Q?KXyPQ8RlwYFDvaGn0C2T4ODDR7cWm7yisw+3NRP6S2NlF9mKhdG3K7wwpx8X?=
 =?us-ascii?Q?/kOIvcwDe4zwfgYE+2Ssosz9W1UWrRiGXtjqxaEvt+SqoHbLOjFPAsVmdioB?=
 =?us-ascii?Q?/DwbTLKW/DV9DBHuiQHIVcI8kwpMME+M1IluHaTPv2QbXsWTknquDBCnBGfg?=
 =?us-ascii?Q?JOHIH75U9znjNwZa1dgg3g2mKm+n3AOac7HQ4v/k1203VBU0ZIBScNFl9e/1?=
 =?us-ascii?Q?oBRTp2VuWkdUeHbGBYSUtxCawWhCABtGCk4jaMUke6bIwLUjT4gC7mVEe7BH?=
 =?us-ascii?Q?GgFdhqyKuYMZlttPKvwmeIxbdSz1ElU9qA4nmJfTmrQtD6KTkJy3H/HJQoB2?=
 =?us-ascii?Q?wB1GVW5hfNN27i3k6fbeyal5ogh3gBr8oxEzknyGl9Xurn5mOvnLQty1AmTC?=
 =?us-ascii?Q?NYDG0wJINB5rK62NlnZdsyJdZQNBEnt/GoNGErm9o0JvqCh1WpxEsscba36/?=
 =?us-ascii?Q?nsBSuPA195UJRvZOvNUI3BgMMsL+HilhY6gVQZu4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6885e2f-87c9-4ed0-4ee5-08db344d8c55
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:13:07.6653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcGL4hqUDdxBxVzdi97ahKBP7kCQRxCb8YCZVewxRIOx5+I0C++6j8P7DLUOtUE/xwXO3grUFhUeLZQ2ribBQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:41:11AM -0600, Jonathan Corbet wrote:
> Shakeel Butt <shakeelb@google.com> writes:
> 
> > This is too much and unneeded nitpicking. The patch looks good as is.
> 
> Agreed.

I also agree with Jonathan and Shakeel. And if no objection, I will
address the other comment from Bagas about 'atomic data' and send
out a v3.

Thanks,
Feng

> Bagas, we've had this discussion before ... several times ...
> 
> jon
