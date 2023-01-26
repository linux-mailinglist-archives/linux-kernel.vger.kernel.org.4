Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49B67DA13
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjAZX4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjAZX42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:56:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5120C6BBF9;
        Thu, 26 Jan 2023 15:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674777380; x=1706313380;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VYUVW7CL9ypocyrP3BG7nEIRwZsMDTKYgKGdXQiVPI8=;
  b=SVu7CWVAPqT4Ye9rWAFz1GsKivX0t1a8veLHsVIziZ5MEy5kd2wA1XOc
   Le46cPgHFcn66ihaMc+C2gEUo3BFv4kXnYHQQIOgU1iurcSlwkPjB6RJW
   Ym76gMHDxc/IxFbcBBDqZ/yFu0OKfusIUFo3+IWvr8SsuFwhYmZFc4HCC
   D0zj2o1XShpYOK6deMP3pGNyvnuJlA6k7Z5qRuiNIdmbpRJbCiLuxTHuS
   5zxAHntKED/41TewuOcIeAJKwCzCcuWwZW1evU8rG/FwhZhfCvkrcDYI8
   ua4doNyTM+poXpbmmOtjTJv2l6kjrJINRtxEbw5bZEJZRfWoHfoKZsTsM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="413210766"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="413210766"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 15:56:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="991868758"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="991868758"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2023 15:56:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 15:56:19 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 15:56:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 15:56:18 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 15:56:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxbbHq/EjYgQGs3ZEpLFQZJjv4PkxnbESzs+gBe/TPBQYYbc1czRYHGdENUW6PjEKwM9ZSVaaphsPviMN7pJ2N1ELPIASvzp9SsrWn4Fg1Lar/xvxHXmAYPnR3gQf0KsmMwCWj3etMWfr8UYbvQrMlizMjRIz91Nvvs7ZQMSeArAk7sO5YQr2bBo2tLTyC6vwcMWA6XdMO5nf0HOeOV5AbCJoKOgq2kbbG0OcS7MEmMwWXeOByLSw5ragiov1wG1yJ2Z2/DRQpaqiyjXIfN3hgzUR+LKkRyA/n8Kg/ngsvI9kg6+fTqFN8pMbug60jbyZDyZ+dK34KzYxR7wnWdtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St0kcfIi3CRvwXJ2HilG/zHkWZK+IMEc36140j0DUsY=;
 b=eOvdrzCH3iwGWcFpR0xD6AS1YVQ4PKAazAJ+v56+XiEMTrKDKyVHMygiAziT2xo3K/Yu/P0C4egPxzeRNenOZPpjT0ES4h3gg439h/fsyD9dIq9Ovr2ugZ23qYVqyORrNSu5nPUd/YViqbTlY8oRXLwOufha4bP4sJva9Jl93HujNXvpx8KnV7uVuNC2+lbSC/EHPRJn3s3l9HT+ydkhVYhWapx9fUh+Aw+IdUIe5Gc23kzwAY2f6S6CfIIXr9G6f5OKlpkqiSXSSjYwu3gbqbc3t9EA4eLPO0p18dQwtZQntwo7w38CbFVpVV0deGJ+k+G4RbBHHtIbFAPjL9fIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4923.namprd11.prod.outlook.com (2603:10b6:806:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 23:56:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 23:56:16 +0000
Date:   Thu, 26 Jan 2023 15:56:14 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2] cxl: fix spelling mistakes
Message-ID: <63d3131ded3ec_ea22229485@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230125032221.21277-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230125032221.21277-1-rdunlap@infradead.org>
X-ClientProxiedBy: BYAPR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:a03:80::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c3122f-3fa5-4496-a99f-08dafff8e972
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQXj/57+HyWTHD4Eu6EyQ/rbF0m+ovbFdFaqzN55dkvEQDlP4xpoohCcWoRXPWSyNeWECJ+MvOqSmD0C8wmR51kjpZ7+tZoKqcsDIV02FLGayTP31BexwpvcFDcMaImuTbty0vhUqSRsGOB9lcJjPArN34R3ezEpcLlEeUr1xRpuhDYrL4J4fAR2IqdtYo+xNYYHLX2IPnYKj1QGRLBm5uRMvuZJg4/smJMTkh1D+Da9SyenHO0DHYmkLwGp+csPxYXzAOkr5ut6N8oyNxNx0ojNvGWa5DkG5feARrX+fQPVFqwRdAqgnDrAtlcMF48x5C5t3BXsdynLVDsZxj0gi1EYcwMW9lmyuxYcIzGdVD3MIcm5HGxR+HxnUypr1lLyutg/TEqDdYx7E7PUNLOpRFBmLFwFQDI4u1HUlN4JpGeOz45PBWV5IzndHQc1dRQK6RNMO/rW6sZtltR7cRw8zFiB5SM9MClvDB7QNdCDalyC9wIsQEYjcU2ZAN1LQtBD1KIQ7kyyxa21fBjyFlXS7Eg+riuOwea1UE6Bxp00yBaUqzZYS7a4XRpJBFvJFK3eRw4ddFe7rFLyGK3cPJfaAciayKaVUpjmWGmts6rhPbOgrMAEjGst/CY6C8ZvJR0eCEKBPjCoBkuytM7D0LIMhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199018)(8676002)(54906003)(82960400001)(316002)(6506007)(6486002)(478600001)(66946007)(5660300002)(4744005)(2906002)(4326008)(66476007)(41300700001)(8936002)(66556008)(38100700002)(26005)(6512007)(86362001)(186003)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tXJcW9s+8SlDUdkVXVSYpOO6FPq0e3sakuFIkPIiTSwQoiQ3GTmQ6+PMyJk+?=
 =?us-ascii?Q?lXqulwJMKngL2meOz5sJGrH5r7ebbdj1qr6osrpoEv5rk6XIoALBklS8nDJy?=
 =?us-ascii?Q?oA/fZxFqYAzIANDkpWLNDw4PSCcXxeze/eFw6fFNR7ItMcckuONUp1PQjVFn?=
 =?us-ascii?Q?chwf3lUAFYtqY1z+RMFsnKQ5hNGs9LkTVyj7H2ziz0I5bvLk5fbM/mFfba35?=
 =?us-ascii?Q?BodLrLjfzXUb4Md2f+QJuFmlnWekG19qbBUu9MiQobfZwghfEbjuyBcuqWb/?=
 =?us-ascii?Q?uIcmAHi7rSQXGXj++4QWVUzubrYHD6zITQBNppLMbgBaN0RM+k917dpP/eBv?=
 =?us-ascii?Q?7qD1M9cbq3GvdmaEO1hp3spGl8TOPQu/fw0F0ILbULzSxTmj2i8f7hnzLtGS?=
 =?us-ascii?Q?ted8bXnYFGEWArKbvGdIMuz2GQJA3xovkT2lt2UW6KIof+idox0QRnRAZVV0?=
 =?us-ascii?Q?FtSxGAeRt4ujAOmYgvAVnanCE9Zc9GxPKDfIYaR3WgHGWavYz1EdJ469DovJ?=
 =?us-ascii?Q?G8hS7xJxwWdlNaWR18QB9T+QAvdtbOPHuAe44sCjzCqJOC/xqdGWUeWW184t?=
 =?us-ascii?Q?ezFSaAbvYC5XxO3b5rjnzZuk6JO/kot3TdFJ88R3oEPRWCIOkddGzALxeb8n?=
 =?us-ascii?Q?8B16m9OuaCzlP1KmviaXygiyJZqpExsFvlqHX3djzJ/v5u9b8zT3j7R1JDvY?=
 =?us-ascii?Q?n04Ydxg7K87gMQFlvEeSmdukk73LSwiTCiK5/zRu3LHpoXca8aPR0MwzUlW0?=
 =?us-ascii?Q?3rl8akwAsyVSToiB6qyz9XM5+BWPMNGYAqfAoJb0UYqA1d5UStE/M2T1TNh9?=
 =?us-ascii?Q?AzB9uGIx/CulZH/fU/2m/8s/BfJM+al1EFGJax9qd/jP4PlC1/J3F07idHCv?=
 =?us-ascii?Q?ceHwAw9Y0llp9HP5iTbxf0J1ytXTN7QXyuPenud6U3q6HbSh0+6MIYzRVv07?=
 =?us-ascii?Q?4J/phjlurPXTPkl44eGV8yQujV3vcAgPcxHwvYQ3GJ5MWBRLbKG976EMje4V?=
 =?us-ascii?Q?hPlavRbm7JB5AXMiXpkph4geu0C/9sMOXELKeuywZpjxRRUOCeeqPevbV4ks?=
 =?us-ascii?Q?xnIp7EYLEE6EImco6kkDvRUaEL4TPdGJEM7CPEkHeFq9xfECCTd8y89yvntk?=
 =?us-ascii?Q?CmKFE3DS65SUB+seKPL+5zk08cG1o8YA5OKfLgUfYho+ielrkHMEWx/TYdyC?=
 =?us-ascii?Q?eyVpZXRj14tQHNI6zMwAZX1qszi25iASKRMzwzl8Nk7vyV8edzCQPaQMRett?=
 =?us-ascii?Q?bc/EnZuztSL0Hju2mJGuj5Fq82NBjx+jC5INmo2LD18YJTNTWwY1iiIdlTbz?=
 =?us-ascii?Q?dWznBrX4gArO6MytisMNgIkwXL16L6ksPXhyXY+9IQZqRbvFlumf2A0dJbZ9?=
 =?us-ascii?Q?PhKc/TBQs9FtMakzL7QzURho+15UqVxBUtJITk1Uou2xCUS61x36+7OR2lyf?=
 =?us-ascii?Q?XC0oMGhIuqE1z+HLre5N7rxvfbvoBXWzlmirCPxRdRvT2PpanAU9ZZamAGBK?=
 =?us-ascii?Q?UZaGPlAN2munsmKFSECUh+krj5mNa8mOZK9TTtoptOEMHgiUOip7Eo2O9o9G?=
 =?us-ascii?Q?CzVy01DTIEqB36oGK8jPjmHG7XQcWN4WmQm9AXqeEOCfDhN7Mb+Nacru42mb?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c3122f-3fa5-4496-a99f-08dafff8e972
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 23:56:16.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yn5WmO4AT7MQO/TWPy3F7z7yFBcmMccvs74xRwTn/9php9QhMDJKfxhlnnEvyS5RdTQ/F2dgKmBGJJT8USmoi4QEQudJ+554HHOv1tgi1z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4923
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> Correct spelling mistakes (reported by codespell).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> ---
> v2: add corrections for other source-code spelling errors (Alison)

Applied for 6.3, thanks Randy!
