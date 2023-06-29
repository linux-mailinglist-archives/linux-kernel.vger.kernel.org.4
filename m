Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA976742F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjF2Uze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjF2UzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:55:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9377444BA;
        Thu, 29 Jun 2023 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688072075; x=1719608075;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tj0LD+iElOjuI+ahLd3ebVr9wrrkmzYV7BTA6vBBCjw=;
  b=CDCXI874kEHGcq1Gqnzz4i4hIyi68uU4j9sWK8nPsqST45DRYkqVvo5V
   TlOtIZ8AFyAdGRJZDX06EtxfpXzy64QW/JIBxYXxR36wmRj6NLcRspDuK
   PeyVQHM9+y0Jgw/r7R++0zQcza9h9bcEW4nvKnMXLNW1ZF5e1PiH8n9iD
   zQJrhTpAklNi8ivIjLeKiw2iEJZ+wMfHhjgEhrrENgyJGsatEN9n+8Y2W
   0q4Xn+i4OqECR+3xiIxnoG9Yo2G2cMxVqOf+68vjz1FM4lNHTWecm52zE
   UmoFWbuJfA3Y0z1I/wLU1vOUnsFrrvCdCseJyyU3bybkr3G9uA1NBJCEz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="428266953"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="428266953"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 13:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="1047963575"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="1047963575"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2023 13:54:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 13:54:33 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 13:54:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 13:54:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 13:54:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWv/e16GV/iTa563PVBE5BGfTHf2rquVOu3CWcjdB9V/XxpvJz+ruC+MQzvGWxIbuse+JM17vkHmD87h3gwDlrBLfeme8IEv2spxp1mumdnTDVXmf+0kSVnNXNZycMRRHhAGewQDYqlteT0WTZJk5R35j08B/EJ9zLV3sQFw/aMgVh37pKiim0+aSu1x/UXMw7nnH8wsLbi+VFq98PxjEvyAhZeqYWRFWrSZvU24ZVtrE0yTSvKi186WhNzN7Ayjv6HpqSKXetUWfPHnTS0RbW/yGaQPZMqIjdKj4siFpshz8DXethK8TVMML5tWcFvoFgcc3xOk9ksaoR+y6iDZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhwGazaHb/I+hBMoxozK/fwZe37V1HP8VnWsfp1BtNs=;
 b=AGka/MSakM297Uu8quQW+xkoCzmX8gEu83atcuGw5g7RqXwEUKn4dq+N/KDaLGtEBTyHJTRap3f9FQTIEUkD96r16EHiyicw8gY4f7xMpN47X+t3eAwcrb7E7j8r3ApNPYDW9GJ07eS4qPK4UmgHSUow9NVociyKScIrIx3JwubmVeyyVpXG0yStgsjEd3hhAqVCDFH0Z9FsfuVBoYaZAV+x5/+zODNrXGfP++p/S8kB5BuR/3iKU+8hi2jVPWjzJHH+HeCWtRyUBDinE7pYYrwZZQJ1VtqXyb596OqDLj5BmS1A1HPN0NMe788z42nXy+Q5WZrNdJ6uA57zoHwKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6842.namprd11.prod.outlook.com (2603:10b6:930:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 29 Jun
 2023 20:54:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Thu, 29 Jun 2023
 20:54:30 +0000
Date:   Thu, 29 Jun 2023 13:54:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH v5 09/10] acpi/nfit: Move handler installing logic to
 driver
Message-ID: <649def832ce1f_11e68529491@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-10-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230616165034.3630141-10-michal.wilczynski@intel.com>
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad76c26-2564-4419-37b6-08db78e3088d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9sfaZCUTPJtTBiXSfYWIPZyNt9CquBsZEjgNEZcA8hGuEpyt+DbZDhaTlZ8HZzX7LxXe6pcw3vSgvac+Q3rUvWmGXRYMSb/b/wlkvVWL8sQSyxu9dwIN3KZA2kWqwvfohEa5fN4aBup7Bo8tCQOt4J2fPzLIykVC43fSDPwC8S9081wIwiza9MPWs14xhZVkvRdnwGnQ/c2bg8zL/Uw+Bj6lUuinPWbODcr3evlH55bDSlb0plQc/t4n8gC8IoEcAithlsKBa/T40VGw1OO0Rm3UeauaF1nNvNmiXkRvz6pWJfTMJiwrB1BX/I8rND+zn4dgs6L/y6C8PxaUzGjwGk2M6mF5BNqbIGRpljwj5O5riT/HSIAV5EsD/JoDBBMFssEDj3CFMTnH/vC4C+3wwMwu7Wm9EeBcRmJQyIGrjD4UAy9v88xrmLzL9MYnaWKfBOLDupUbRjV0YQ+Ff8Vx0NH7vZWDCTqs0DULPjLMqZJz3bz+W1p3WNPaVZat8VYbegWbCycT17Mk2PujrNgQzlwmc52rhlwE/j+4uIF5O4bWtW8A992qOtrfS4vHcdU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(83380400001)(2906002)(5660300002)(8676002)(8936002)(86362001)(316002)(4326008)(41300700001)(26005)(186003)(66556008)(66476007)(66946007)(6506007)(6512007)(9686003)(107886003)(54906003)(6486002)(6666004)(478600001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9JafkKq/wrQgisCfwNMN6AOfqYoS1sTCFckxgdosKC1I/NZqQAZOPP+Qd6z9?=
 =?us-ascii?Q?UEi6Fgsk/EXGCeVjeWOVSnnV302ybvuA90nSmmWXF5AA7eygsPzccOVgM0ma?=
 =?us-ascii?Q?ghMcVMMTxVOuIE0gNN300LteVywMSiP0kIMbxYzKetBjA1hKJs8kJFGYPcVJ?=
 =?us-ascii?Q?DZrqVs4NOwrmLvbABrXLs5aFc+U0NBJxl2EomNX1qW1tGvyLAEZckM5ot9DF?=
 =?us-ascii?Q?8frre4vU1mKZICvxbgXJ9xvAq5y36LzQcJUO55paAT1dTpm6LVE7sNqsD6oe?=
 =?us-ascii?Q?FPpqF/Db4aMdGOv6lBbtyNzgd8ei7aM4AVF2EM2CNQ3mla09oTQVlcHaF+z9?=
 =?us-ascii?Q?DYC3RS/OFYsTtD852ZGWoV0ILrg8jjhVbxoztklLQlfsbbncA6QSbZAf3EMa?=
 =?us-ascii?Q?iNmrp0jXUAN8HGOtUSSKtPvg4UJnbmDI3cAfuXXlH/yNPgBG565DoaExvdtz?=
 =?us-ascii?Q?ioZD4DXxWQdEzELxEOL4Xw+m3IFGj09jkcc2dGjaLtSATT0UmoUI8YHUmzXX?=
 =?us-ascii?Q?8ZQOCA6HqdNm2DHBnFotpdu1RGAmz8R+DzsUUmqn3MM528b2+oHBRog4UMJn?=
 =?us-ascii?Q?UwLnEJ7aJFk/dF0X738mJn3J8jnHv9YSoKfL1CT9hze5jrqwsPRTJyK2IdJP?=
 =?us-ascii?Q?EeI2IazerYQQuH7TdQjdM5OQvSScqSqW4DINuXX0P7iEsB7uKe+sgOETmno2?=
 =?us-ascii?Q?aPo1XxYnSgJJyEULU7+VSQeori92Ww9YgMJuutytY3acCZLaTXlrkNN+KP2N?=
 =?us-ascii?Q?m4LppIcz/SFt1SxnHJUK5ff7SmuOA1F/pRtFvTLnnqrfle0bdAQsmVP4gpvH?=
 =?us-ascii?Q?GWp/LIiIScUPGo0LDfz2TC+poByk/0wYojUBpVIYzZK1JYF5EtSuEnmURA1x?=
 =?us-ascii?Q?Tquy3/6WjOeDFZsx630Jp9mvVvceq2NFVAAycnXf8Tsi/U5BRf+w7igqjahF?=
 =?us-ascii?Q?yxALom5KNKghBcC1O7xHPRSGenxeoInjI4B9yGnM4htsS/5ga1bJq4cI9zh6?=
 =?us-ascii?Q?2VFTiBq1SWNaE6zQVNYn989xF7/GBu2CmKfNlhR79JKBUilXDs+V7+Zwj34B?=
 =?us-ascii?Q?8oDyMCLiZG6+aBIvQVSbauKzed6W83m0rQO3eAi+LOYTBG8tS1PTpitK5PFI?=
 =?us-ascii?Q?+eJYXXJFy3hpsI5k0nQcV9j1Roy9u3pLto8Gb38emtKYSUkOsq50ObJu0Het?=
 =?us-ascii?Q?CNHO4kcnxtKi0kelBLcO0YhY5hdACrCaAzhcIjc6+PNgvpKmsNd+o/6Mg7nL?=
 =?us-ascii?Q?2PJHOaJkwZE2Vh7QLmWvBjQeNo7lcNSMuOHPifDEW8oVJqs+jnqib4CAwVmf?=
 =?us-ascii?Q?y4S0sMpwlq3qVLf/FVtzu+EITN0/YdXPwCRvtYZLYQ5SPMEJTEk6WgvXf45a?=
 =?us-ascii?Q?X2JYAT2ypeiZBHmEJ/sgfVpRsonlbK2Z4KTReN/P63WWf5BIOHt9GSoa7lob?=
 =?us-ascii?Q?5XwjmZKZ3xtYsEtPqxrTIovqTzhXLScd1mBhHjCFenDl4mB7mQt3WAyaxwoe?=
 =?us-ascii?Q?4FIulKXKWLGgmoJBPtgUFq1cHiMtrisluH2klKvBTieme62qw342/U96hHoW?=
 =?us-ascii?Q?S7NEESMtkmUACYioz/hzAKn5o1VyIZnA2OkStiuU+1cWu4YPbz9FK06heLub?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad76c26-2564-4419-37b6-08db78e3088d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 20:54:30.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge2JaPNfUEHQgfi7yQiBkn3gRCZFZhNCVyhgao8t/l38Q49NpUXBX75MqtvtFxMcR8v5yTYUzY/Ft1DxhGQNbahXSbednNjCrrlWIglamTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6842
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

Michal Wilczynski wrote:
> Currently logic for installing notifications from ACPI devices is
> implemented using notify callback in struct acpi_driver. Preparations
> are being made to replace acpi_driver with more generic struct
> platform_driver, which doesn't contain notify callback. Furthermore
> as of now handlers are being called indirectly through
> acpi_notify_device(), which decreases performance.
> 
> Call acpi_dev_install_notify_handler() at the end of .add() callback.
> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
> callback. Change arguments passed to the notify function to match with
> what's required by acpi_install_notify_handler(). Remove .notify
> callback initialization in acpi_driver.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 95930e9d776c..a281bdfee8a0 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3312,11 +3312,13 @@ void acpi_nfit_shutdown(void *data)
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>  
> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> +static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	device_lock(&adev->dev);
> -	__acpi_nfit_notify(&adev->dev, adev->handle, event);
> -	device_unlock(&adev->dev);
> +	struct acpi_device *device = data;
> +
> +	device_lock(&device->dev);
> +	__acpi_nfit_notify(&device->dev, handle, event);
> +	device_unlock(&device->dev);
>  }
>  
>  static int acpi_nfit_add(struct acpi_device *adev)
> @@ -3375,12 +3377,23 @@ static int acpi_nfit_add(struct acpi_device *adev)
>  
>  	if (rc)
>  		return rc;
> -	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> +
> +	rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> +	if (rc)
> +		return rc;
> +
> +	return acpi_dev_install_notify_handler(adev,
> +					       ACPI_DEVICE_NOTIFY,
> +					       acpi_nfit_notify);
>  }
>  
>  static void acpi_nfit_remove(struct acpi_device *adev)
>  {
>  	/* see acpi_nfit_unregister */
> +
> +	acpi_dev_remove_notify_handler(adev,
> +				       ACPI_DEVICE_NOTIFY,
> +				       acpi_nfit_notify);

Please use devm to trigger this release rather than making
acpi_nfit_remove() contain any logic.

An additional cleanup opportunity with the ->add() path fully devm
instrumented would be to just delete acpi_nfit_remove() since it is
optional and serves no purpose.
