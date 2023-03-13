Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3844E6B8546
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCMWwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCMWw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:52:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EB88F72B;
        Mon, 13 Mar 2023 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678747921; x=1710283921;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fNcZFwXfEhIqiT3FP768B1iipKQ+6PPJZatP7K2qhi0=;
  b=MZ1Lx99Lec/5Gv5NCwY99n/NlHUTvCTsH6qiKOAn79FXLmGtwQUyAmoY
   NYBSdhC+7D8FkvieR7lJEf2CLidWnVa0h5u9pK5AfPeTUhP93XQ6MOBGE
   BykjnrC6B46cqGzwRNI1DNuuFWeEtMcO/3hPDwMtuVhutK5fpzMpQD+FQ
   r3KTnAxq1QnaBbEF/WgO7m1vlV8XrCpyaowYgpdeLcnLlb/I5BvMAh9s4
   ogVq4EU3jfh5EBVJCmDAmQdgcWbdQTGw+2vXZxyC9RRiAtwgb5OP0SwtI
   2VvqT+aOC1P3HMWiTtBxuGroHqQyytPXzHBrIqA0TuqNd4pNjK3Sa8KU1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399868390"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="399868390"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628802184"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="628802184"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 13 Mar 2023 15:51:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:51:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:51:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 15:51:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 15:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh7p4oUWQaWgY+YmOEPXdf7DnssOFsGRoLrJ+aW/+7n/OfUCx1Xssxd0Fjk9+9SbtICd+UR7pADdpclJ8HUufnWicewC+Dh22MxMSfWY9ohk7wcZHDR4GXTwqx9yVxiqnbug0Dc2M9gIf8EqUJAKQP+3RXSt2g1NhIh6PaJMZlMUa4pXT9ooJo1p37Pxi3mIqnLfHNbfjM4BOp3HR+c87Y/wp1hy7wSqBpwVQTArt1fb2bAvt7cc0+VhvxD2s0wW42LldqG/zHuiOtN8JDVJngj1I4cdQULbiMS5e89D8pKsVwFWdNo36dBT1pd15WIAbQeBpc3L4eMuSIgbOWyMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guLWo2cpSQY1BSiOWAlsXuwn+BL2qU8A1ZkQlBQNi5s=;
 b=mBYoPzGgVzZGqtcxjJyZw27r2Cj6Z1Up3GeP1hSLRhxhFEHmCJ3eKa34U2I9WNkU/97OJN+Hqn9AVrNHRzaVfrNKkHE3/ZeEvGXeJJCztT2jlIGulcAyDrfIH8VjCmmd8MF0ajNInzk3O/brP51O7kenwr4m9LKuZrDcwBy7cd79JMaEb71+9Zx21V3hfuEwvZom3rFa/xJCy0/6xkhlRS8CduSkh+jfxYVmBw6HZYcRGnFDFKKZKEW+dud/MA2qy68jPPdMIoJunuuaGXHBWGQqxFWa1vTPggXxOgyQPODm7sccgxZ0AuVU9jbHb1p3TGc0h83sL5iU5GmM4+XkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 22:51:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:51:34 +0000
Date:   Mon, 13 Mar 2023 15:51:31 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/6] cxl/region: Provide region info to the cxl_poison
 trace event
Message-ID: <640fa8f32013d_22c07f294e8@iweiny-mobl.notmuch>
References: <cover.1678468593.git.alison.schofield@intel.com>
 <b5ba1187b04a18f49be9ebb91b699cfa8573eef2.1678468593.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5ba1187b04a18f49be9ebb91b699cfa8573eef2.1678468593.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9795df-ea59-4412-6a1f-08db24157ea1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2Ug/nOeSwSs0XBa1wrd6Jmn7FmFgkHF86clgXjf6NhgSOTqRlQsqqC3Cf0HBXkzXpA+cHxN38qeBLj6kXur14iiXvhgKcpK1YoZvnsKPGHRQXKYkfW2Qn01tsYsNc2C564pm20m0WdufX2IOaGszQLJX1pWQN9luk9aW2/uQ3cf891Z7MFJQvVLewKR6LnuB67308K8u8ZZh2db9xicNzEqu4qdT9E3J9zMN0K/sZf3msCH36GqjQhrHAlJB+U06FSSaSow1iTMzjI/x5INebtev8L/VQZUdKrXxVPDtjWtwaSfcT3LjdANT0tc9g9RyeVvYGEmL738ZV+sEHf1GDWLx59Z6fo2gZ4eh1l13VHmDhiNzsUCoUOhr8J54AGpM/X0VX6Q4/I1QESvEo9IUTfZPvQUvyUVy5HScDleLEnzHQwR4/ei5WB+5QWo/zbcNhCjvH+bLmJK3jiJympcaZ+xBnjNc9CKXptuY8BvkUJIbwt6oAXnWxXO+yREcbE5emEQ2idVHO1ecwYQANjrVLnSgBv5PHQfJaWulKRK/tFV+4EGoPEd6kdTVA1PKM92ap22E1oM2dMnW72+nJlbWsiW6dtevfydZ47Ijc/zgeaa2H7qG0f0MKR0OwTySOJ2CmdEO4idF78qijYgdBmqwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199018)(6666004)(82960400001)(83380400001)(110136005)(38100700002)(316002)(478600001)(8936002)(186003)(6512007)(8676002)(6506007)(9686003)(26005)(5660300002)(4326008)(66946007)(66476007)(66556008)(86362001)(41300700001)(44832011)(6486002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/QLWQzZh9CEnvYUXRs5Gd75MBl6s+qmuj9YpU0LjU/5HFnEQ2TU5JRiDdB/8?=
 =?us-ascii?Q?oFI2JcyTIaqa515/JaMz0C/EsaBUxizZkn7+XW91ROccPZnjRaRDAK7yq5Qg?=
 =?us-ascii?Q?NVRTzxPYEZ504FJOy/wpzyASBuQ+cIfmmGaMUJ8j3/qI8GKuZx2+qGBp19Li?=
 =?us-ascii?Q?TsOItETf0cfA7lpJ8Wx22oe0TtJ5cwza8wGMIMmAUHV7ExSMqDZdCeL/KsUM?=
 =?us-ascii?Q?7E04UKXS9brNtRj8Vwe/QwzsZQfEBuFW92iT/LIIuz0EfWvK1XqyOFM2rfFo?=
 =?us-ascii?Q?6Es0aG49IFhSjZ6iKJDP14626r0quA4UuAk8YYc8ZRDO/18/AlDvrxlMJdiF?=
 =?us-ascii?Q?nHiOMV0NHSMaglZSJXKLzU+HCRVWlnRtyb/GA9AszCuNlU5BMZMj8HCxehI0?=
 =?us-ascii?Q?o+Mq5oUwQo7KlRDbFxao80I9BE6WGwCEo6vvvB2PmYP4rz997GfrjtwnLEvy?=
 =?us-ascii?Q?o/T8l0dM55LFNQCRXmwe6s+nA6kGp1qDglJhwpmVzPA12YrnTD0VCM4LYkfy?=
 =?us-ascii?Q?D3rpO2PGomMQiyDqWDlSQbvuY9oQvjB/nBCAiN13Dx5cH0gUuy3J16nRmlR1?=
 =?us-ascii?Q?TZBF3q0yURPNZSBayLH4sHhLZ46RCemVENnMEvSuqPTpI9zJP7BDGsv6PASj?=
 =?us-ascii?Q?C/HZU/MMHMq884rkz62WNCVX/BEBHKourMK6xV8n/mAt/FX8WPUn4HTiJAFM?=
 =?us-ascii?Q?hOVV7l5ykRmAncwikhf/ENMykVqhioMKt+xWNR6YUX4sapcATOviihfLZVBx?=
 =?us-ascii?Q?ClCMH7K7HVQuQzvveG/BHdXy05/xlmziCbMWkpvTKyGzbdWUtwkH0ewIgkKz?=
 =?us-ascii?Q?maPcrW4nU4rddcQlJ/pgXGN4pvuFuQ3d5CNOFB54ggIvX93/kdmSHZj/MBT0?=
 =?us-ascii?Q?6RrzPhHfhLn30R+MmSpLGOJlbNNqnUag2mJr00E5pMH6/pfJacmsUe2qcbi8?=
 =?us-ascii?Q?JAYohHKsOPLtbjq7DieIxh5OZgnb5z4cXNyvwafmNCtb/7M4rqZuD1B7H7tc?=
 =?us-ascii?Q?sphkbeIQ8gVujb1Z90qSIwq8ewoB7i400z8/uEcYRyvJgqBU9IBzqaXUh/Br?=
 =?us-ascii?Q?V2fPliZtap2Cv6mXyejFvOhzTN+P0fZLRFCHEnKXvOHTvSz+4SPuGP7UKSQm?=
 =?us-ascii?Q?L3VDvAAScVGdJBW9UEImdxmp3tfZGBF7D9jTTWSgC1f3Z7AQDYqPPxK62hX7?=
 =?us-ascii?Q?inMBf/JqD/z+GCDOSDWsE0U89q+mdy1+g2oOrnyU4FbAxpPCUYTC27xQsd5W?=
 =?us-ascii?Q?Z4nzEzEkG0vYLjHWC7kmalNZBFRVFTeUrwgwoYGa/BuuI7kBYxCVhLNVzcAo?=
 =?us-ascii?Q?sHdhxy8u+eG7zOHa8b+PywRT6logd395rWLDaP+NVXCNFRLiWFA1wOlH7VuY?=
 =?us-ascii?Q?IAiNi+DJu+OwZtPJYkc5Bgh9Ty9hKoUTj7VQnEUisMf4vyuJ3c3PoeHyHkwE?=
 =?us-ascii?Q?VeK2N0duv5bdMCOLltyK8oTa+6ctEOTgjKPwNc5sI6FQKYXKjeZacJpFxsul?=
 =?us-ascii?Q?8SygshU02St77If7xyZqYknsn4GoBLtZPZm8OQ4GfcF29EjUIyVryLUmOR1q?=
 =?us-ascii?Q?Mb3XBFeu5Ri3TnMkSVdXXuH1gVq5yh4uqUdF93A2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9795df-ea59-4412-6a1f-08db24157ea1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 22:51:34.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pyl5WeWUhXBZ2xS5TTt3mP8/CgG/4yR9byGeR64pWGBSD7XYFohZCfNtvbIMeT7b6qveSuBwgh6HEUV6+UAd+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may need to know which region, if any, maps the poison
> address(es) logged in a cxl_poison trace event. Since the mapping
> of DPAs (device physical addresses) to a region can change, the
> kernel must provide this information at the time the poison list
> is read. The event informs user space that at event <timestamp>
> this <region> mapped to this <DPA>, which is poisoned.
> 
> The cxl_poison trace event is already wired up to log the region
> name and uuid if it receives param 'struct cxl_region'.
> 
> In order to provide that cxl_region, add another method for gathering
> poison - by committed endpoint decoder mappings. This method is only
> available with CONFIG_CXL_REGION and is only used if a region actually
> maps the memdev where poison is being read. After the poison list is
> read for all the mapped resources, poison is read for the unmapped
> resources, and those events are logged without the region info.
> 
> Mixed mode decoders are not currently supported in Linux. Add a debug
> message to the poison request path. That will serve as an alert that
> poison list retrieval needs to add support for mixed mode.
> 
> The default method remains: read the poison by memdev resource.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

[...]

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ea996057815e..5e65818d2171 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -139,14 +139,29 @@ static ssize_t trigger_poison_list_store(struct device *dev,
>  					 const char *buf, size_t len)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_port *port;
>  	bool trigger;
>  	int rc;
>  
>  	if (kstrtobool(buf, &trigger) || !trigger)
>  		return -EINVAL;
>  
> +	port = dev_get_drvdata(&cxlmd->dev);
> +	if (!port || !is_cxl_endpoint(port))
> +		return -EINVAL;
> +
>  	down_read(&cxl_dpa_rwsem);
> -	rc = cxl_get_poison_by_memdev(cxlmd);
> +	if (port->commit_end == -1) {
> +		/* No regions mapped to this memdev */
> +		rc = cxl_get_poison_by_memdev(cxlmd);
> +	} else {
> +		/* Regions mapped, collect poison by endpoint */
> +		rc = device_for_each_child(&port->dev, port,
> +					   cxl_get_poison_by_endpoint);
> +		if (rc == 1)
> +			rc = 0;
> +	}
> +
>  	up_read(&cxl_dpa_rwsem);
>  
>  	return rc ? rc : len;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..1a558adfe32d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2213,6 +2213,102 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
>  
> +int cxl_get_poison_by_endpoint(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port = data;
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	down_read(&cxl_dpa_rwsem);

Oh just realized aren't we already under the read lock when this is called?

Replacing this with a lockdep_assert() could make the logic here easier.

Ira

[...]
