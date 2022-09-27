Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E765EC954
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiI0QX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiI0QX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:23:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E1AEFA5C;
        Tue, 27 Sep 2022 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295805; x=1695831805;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZG6ndV2SYKyGS4WXabRUYa3SVcQBc6+Uud+wUvAQDeo=;
  b=H8WwiN5Q96T0PWmFtScdIdoGPxiCg32PaDui/sLvkrdi3NRRVqcEpdSa
   3ufYBt4uQFG/ClKIjykM4k3ZYrREEUXEYzQMLlRW8QvLQ0DHqIEPpSg+E
   zp2lWVLMw0RYu95/6iB3DL+ZxzLTMRMOOFpXwD7Yb2tLZoLkmRDeLnWgI
   ub6TDihzRF+I7iqzvNOXXXTIysvH25jv3Zq82+K8SjHtu4XSsA8ozBAkw
   A3/64R5Q9BP/bptS10KZofkGeztMu03jdwRL2N5Csi2zwQpRDLlAoQjte
   oPPPCAQum0y3sm4QATATab0UmrTrtZwSBJDJhznHIIxCFO5O1xQhyiRo3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281080950"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="281080950"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="725572036"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="725572036"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2022 09:23:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:23:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:23:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 09:23:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 09:23:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imrJMa5gpAR1TCs2kMT85RKa9Wf979QRvMmwbCs0khHBxNhApbyadmbMc99uvrRv8ZEi7KJGfG7ToRUo9SIaPMHEM8jqyZl61BpQfVnOAdjXpjlFdB0rlhGYIsq8mPHzsQ6gbzEnYUE/FB+rgDpBtNU4AOiwX10nbJqYUkUgXHRoR9xGpRJT6p5aPtacDYJcP2SLPAPZvn/7+EJ6IFEgPaktbsWlnQRdZdblwKpRvM4vDOwtyALISTXxapyhPQGDmwEM6AKBM7cHFuMbgAtr4CX80m9X3E2jmquaS1DGIa4IR/+vzOWdrmjB27AwSgdwvtqsZsjv437UxrDEghrerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkFapYeO1fss4hC2i9ec5LEfQQbV2MG/aaGekrP96HA=;
 b=D8JmDf73RAwxxcgDrCP7SnjnzZVX9LlNSLHoAXq5ZZJJ1y9IbBlX+4JBLmY9W69yCJBTCuSYZ6vlXGZHRJpPPRWtooEihJVn2f5xqhKhmMDjNeBPXAIvaHL0xO8OmPD0I5Dq5M+nrkmwYmJB9HoTeDfvr9TaRyInLMj03ECemG48MKBVuEECxJZyUUJ0nsExKYKYojibE/y9I7RE9ivnKu/ofHjst2fyj/k6UsmVsJ9Mew+V3u4sJBlvIBAkjWOCQmKUb42FdXnMyVhWkmvo1LgdrtabgRYRePGwdmPFuyDFLEo1zs8A5rVkioR94U37UZfgbxZpEqM1OMeZYyYBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7076.namprd11.prod.outlook.com (2603:10b6:510:20f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 16:23:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 16:23:20 +0000
Date:   Tue, 27 Sep 2022 09:23:17 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yu Zhe <yuzhe@nfschina.com>
CC:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liqiong@nfschina.com" <liqiong@nfschina.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] cxl/pmem: Use size_add() against integer overflow
Message-ID: <YzMjdXArM28bDsQf@iweiny-desk3>
References: <20220927070247.23148-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220927070247.23148-1-yuzhe@nfschina.com>
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: f6aa4f4b-0720-4e6d-eb53-08daa0a497b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3lgp6JGMo8CC1/zsnCBQI94wo2sf5D5KrpJzwMjroPhdjvFxVaBFZWpw9BHSryDiumIVFIHslOx3ohCgDQViVRQRPnXPWiEP551YpArVB0ShDsGH4rsGcp8C1XRlknvuJ4Fn72rTMq7JjoA10MfmNQTVUEkk4OudkdpJhQFle1GmyrE8gx4b6dSrEdUVi+UTbHPP0lvjoiL4r497Y7R6ctVEGtQZwLa9QKsz6l2JD02U6yNIErvXtyVlzZlz9zp7yzKZA/dzaM7YfJdxBB8N8prcQGq58uTGlvrpLmpuvKsNRGAmDFVwNZwZZrwl+FKW4vEuyMKv100Y76JIwSm3cA4Ltdi7Jke08Hg0Pl3FuDykq/5jV5Ae+dXk6p1y/tLu6BKTQdr+BmsSIHteLfadCDMJlkPYMqlED++zczZewxKXnA2+/aLrEG2RKwqKaWVwQ/SGA+YpMmIO5VJ9OA/pEiZvX/DI8edr58j1/Stu5lZHQk698leyB93S32VZ7N+JSbQpTwhpHfeer97G5pvDPFAj9v4tihW0a3XZ0vWIBsEEptzluEi6XljNcBPyKKB/BBC/AMxlEpvB3sX1nNWBzAFjVBpUiaZoUfTHFrs+50+wdtInapMDM6cYss37r7Jj+zmK0AOWrfgsZ3tx1T6RvQrTmuxjv+9dJl4A0ObRXLp3LKbwwqZAxFyjYAwO5Z+idW0VRxTJpvo10svqwcjqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(6506007)(41300700001)(6666004)(478600001)(83380400001)(6486002)(9686003)(5660300002)(186003)(2906002)(6512007)(26005)(4744005)(44832011)(33716001)(54906003)(6916009)(8936002)(66476007)(66556008)(66946007)(8676002)(316002)(4326008)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxdGXckfB20vpvo9LMbmkpbp6LyzZMa9crVmlxjQqFZNsaQM41KQeLE/o+bJ?=
 =?us-ascii?Q?aTqTOAVkhDO2VGgLqS/Rc2RMY46eE8tLFoTxyJdrrVdt81WZjSi8LfM5e9Q7?=
 =?us-ascii?Q?VJmfCFEdf6+rau0CK8wsLfcNrLNW1G2VnbNUnnlV9cNpmNZ0T6VsDoAfizIN?=
 =?us-ascii?Q?bAJ06H3v4GEIUaHuoQO/TIi1BYfLY82O92O0BhfOZj9GmlPll+BzGUY0R4pt?=
 =?us-ascii?Q?5Su5E31Ywkhkptjltr1a8o8qI+lh+qj0baHo54XUu66K2xeCR9TA564Pu5wy?=
 =?us-ascii?Q?Bcbo4jt9QXGywp2dcQih6kTQaCszHPCYxkXKu95tjGzfxlPKzyMeZsmGOpmI?=
 =?us-ascii?Q?otEGCf00CrNrYv026tlh1q6qgis1w5qtAKPza/YvQ/3xgv0BRvqpiC7mTvHw?=
 =?us-ascii?Q?JlzpFtppVAr3HxUsc2aPx/kRTXOYO8hnaUTlvenYagBe5IaQ5pRutTuQHpKO?=
 =?us-ascii?Q?++dQjW3X8EpFiGpfRr+o1d0RuXnNyEsvOJCwB5PItcuZ/kOO+MxYOdgMBt+x?=
 =?us-ascii?Q?tNzgQQhyAwCgcb3smlm334b971gdlK+iDxOWcS4jdZNrf4Xkp/kAO0xQzhTO?=
 =?us-ascii?Q?fpCMsbGDguE9D37/VPxlkMVmt89BaU8tCEmzMDrkehHmT5Ze9byzTySRBI0k?=
 =?us-ascii?Q?OPXAGLbXRD5C97COpHb45++pqSDbb/Ngx2nIywX8svTv7mOxMN7DqZO1i4qr?=
 =?us-ascii?Q?t/G0nkq8cPWOQZ1hEZCDEX4Wj0SNRS032sjRaZ7yLDccvVSlyVcPtN+7mBTW?=
 =?us-ascii?Q?fUyDI2iKJegZ/nxT3WM0EO7Bk+XBG2aZAoEThwNZGUIUX9R6+sh0iTgVB2Y5?=
 =?us-ascii?Q?WxCYicCDUOQU88AIoWIgjTfViQZ9bgpsSHD3JR+n9NTn9OifsqHSh0AVa9eJ?=
 =?us-ascii?Q?LLg4JYLKZ8MF9TIZKYyKpODeCJs6D3SGZaBBuw8xDdWn1XquBzmnveQv4Evq?=
 =?us-ascii?Q?N9GtiVaUjR0jdm33Qrcm7F9snFSOoOsmdHGUMQYZAZ7evEqkiX0uagQExKa0?=
 =?us-ascii?Q?smEHl+U2QoysyxmPMOL+tqTabWYAueYZa5J7zOMPDJBfJPr5YSsgbh6365Ij?=
 =?us-ascii?Q?zTu/7EwdxHIxgod9eg4z32UFQ5FgGWppgRP3zJC6DrlDbBYVL6YA8BGdnxxc?=
 =?us-ascii?Q?ejlL+6TM1AGACgkY1bRc7bnePX5d4hc9hwtEGSDapXDYDdSMyV59PlhGAkE/?=
 =?us-ascii?Q?M4lBypOTYvETWO2St/1Px2nmwwu4nrM0MfGoNSc6cI3wQ/5/a5HfBy2WFXhx?=
 =?us-ascii?Q?4Q0rnvA4BEzuQfOU1tFPsegRJrAjbDhCQqF9pu/5gwlp31QFs/tACp7WaZYD?=
 =?us-ascii?Q?CCgEe9XYx13DhC0g3TSZxtQFejyUdGDHce/49PXMS1Ra8UMKxyPA/jcBKQG/?=
 =?us-ascii?Q?KjFpJJfa1VA6pfxkTHCHdj8vOGv0IcdZrmVz1MO7U1SvhlhBnuhGmb3YeDBM?=
 =?us-ascii?Q?waonAyk4YbU3/26w5ywQh0qHL1Wn6MbaoQgVwKY8GZq7mBHbfCa0cDokKT4a?=
 =?us-ascii?Q?Bi/csCPKvnjQ878ma7G/E0fSxPIOa+xlVrREMS1h01BStPwf9+DGJgk30wLz?=
 =?us-ascii?Q?G4/g/gP6dOi8JEjfW/Te1LIjflOVx5LQTvTgvYS0LsCzinDwsi9VUuvP7MZL?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6aa4f4b-0720-4e6d-eb53-08daa0a497b2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 16:23:20.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +omH8SIeZjnkJR4VqoKyA57iaBDCE16EHrg99u5NLpmWLvihKNvBI6K3y/nGhqN5ycT/P8vMeN1plxHWRsP9yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7076
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:02:47AM -0700, Yu Zhe wrote:
> "struct_size() + n" may cause a integer overflow,
> use size_add() to handle it.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/cxl/pmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 7dc0a2fa1a6b..8c08aa009a56 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -148,7 +148,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
>  		return -EINVAL;
>  
>  	/* 4-byte status follows the input data in the payload */
> -	if (struct_size(cmd, in_buf, cmd->in_length) + 4 > buf_len)
> +	if (size_add(struct_size(cmd, in_buf, cmd->in_length), 4) > buf_len)

I don't see any benefit here.

struct_size() calls __ab_c_size() which already calls check_add_overflow()?  So
why wrap that in another check?

Were you able to get this to fail with some user input?

Ira

>  		return -EINVAL;
>  
>  	set_lsa =
> -- 
> 2.11.0
> 
