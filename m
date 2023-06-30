Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534E9744108
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjF3RTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjF3RTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:19:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA771DF;
        Fri, 30 Jun 2023 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688145581; x=1719681581;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LvIrTWLc8YnZEC7vhMoLxaaR13PoT9wVnJoNTU5iff8=;
  b=O8Xbnq5W4A6ZuY+kWvvIL4m5CX2i+nRPGWCPikPVUUuUJjYMv3dQEvLi
   BkE+iJaw1w1I5cs+1ZYlESTrur71EqOCHwVQYF+Xid2AzTHMQ3U7LrO2+
   aRuQb/C3MYJP0a1oItWbLSRtMAVJoQ/sOlqdR07FmGy5IiNjKfPp3YFB/
   UkNMnYx+qd5qpud/pNpoE/oO/7VMNMHPrQlpd9DpReUoJrU/7oXpycN/l
   yyQOdZFdhPplPjGxiL/scRUpJ08kzvRA3eNpaLjsTPiQx3p7XXev+ha5A
   mSK5acqMX6Up26q1VxOUHmJ8UaQbcLQ/wxvNolOIvBtv7WuSu94dBYfLU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="365931289"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="365931289"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="841919398"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="841919398"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 10:19:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 10:19:39 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 10:19:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 10:19:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 10:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcxM7o+mbpTs+PeTmheazoxBQLnGElymcrZSmDbsZf3UIsngHCVt6GdP7V8oicreyhaEqANHcJ/qAX7N8UVLQds4Ti1qG0eA/CO3hhzpwKXb39g7T6WNbXxv2+kl/jfiBL3EDVx0Rzb7eB2kcZExSodccceZ+ypvfESmDbJ0I8Q87pce4qQlvXz5bRPQxsxzjnyitB5z9wnzRi9T5pdJ5pvEfNz3PAgeS79dij62h5DFKbsxbCK48GPXaoiuJKk3cJ2FSLqnHHjOYqFFU5dHBaYXO2j85SArj7hJd3fvPdOttqNN+OAPMmHVxKmE85B9UtXUMWO5kG8ypIDB8BaTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvqjFday4Hw6wjKCFmyeIw9d4WyWyK5G2nd5nV9tQEM=;
 b=ePP554AX553gV8pIOomT65PkxqwgibD2YremCLlTnGUrrjbPZTz0A1UnZqV16LrBJ4aRNtJ17TFkVTY7iUOzYP7dFWSpwWpMr1OUv4MVIACK7W5Ffq5gah+VXUBAiGk+3bADtVSAWwC79kLhM+Ai919FsVFqPpoyp1BiwQLw3whXbx+hKnSQKdf9kFHqU2cL5J0iRHtUH3uvVbuIFGGN26hP5I9V98K7nZ9O52DkpsDBc+DfaskEMik2W7HDNicaHFn7I8EoHYdoJISQv5gz2pKsGT7WVENiuGeUmP5kJTXiZ4MK0TYCPuG+BikaIn1O12LaPtdYklx+llq6LS57Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8421.namprd11.prod.outlook.com (2603:10b6:a03:549::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 17:19:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Fri, 30 Jun 2023
 17:19:35 +0000
Date:   Fri, 30 Jun 2023 10:19:31 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 09/10] acpi/nfit: Move handler installing logic to
 driver
Message-ID: <649f0ea3bfae4_11e685294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-10-michal.wilczynski@intel.com>
 <649def832ce1f_11e68529491@dwillia2-xfh.jf.intel.com.notmuch>
 <81dbbc8f-fc05-754d-56bf-5e74169b8dc8@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81dbbc8f-fc05-754d-56bf-5e74169b8dc8@intel.com>
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 67de5457-3e80-4258-78c1-08db798e2caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHi326u1iumsL15dINYjKc/e6Uk5MqgLZDzrH8GqRF8Xv6lZyW4OiRN28THnA3H1sOhP70VvOLPLsS8nwV3IIzoE2VT3zFrt88JLRX0gKI3easFgWpB2MK/e1SFiCIa3TBBy2XF1Rj84f8Wmtz/elYPZQbJFmjtEjX1JYf0ykHtrBn+104UIXXINtyWAlUEp0XxNLuq1ykGoXJh/IFutVLADlwUdi0vCAQGO3n1XpJpuOYfQAz+R2J1N6zZsRyqS70ITg/4BaLbY2jlt6ibV+Y/vMXui2Pc5T2BTBhrqImB5nq+txuMBx8kxGveGhiH/m+t76JJwpUdT3vd2zhGXE2Gfc3mo2zwGyPM0cwvv3C4H4CpKw51uGFjRFUFG6DZtwsVMkwYrM2zceva5buDjwNYbZiFdT2CjumjE4q6dZPUDLtat4hFjsrCxNDwpU0FE2IOs6vX5laXQFDQlxkCTODvsePmhBP5MWdbBwH0pSm4eRvidFtMnmzG1OyJNF+u/JQpiUYke000xQxTAE60AeuTHHiMxZzLZiFDbNSvsMR+4dTJ4csjgPE8dNQcljuy7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(6666004)(110136005)(6486002)(478600001)(107886003)(53546011)(9686003)(6512007)(6506007)(186003)(26005)(2906002)(316002)(66476007)(66946007)(66556008)(41300700001)(8936002)(4326008)(5660300002)(8676002)(38100700002)(82960400001)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?38rm0LyKNUioiVIJzB8+EQu9gG8dujoMIDCwNXC8WlLSnA6biVfz6yWT2Y0D?=
 =?us-ascii?Q?JucYF/SjKK0abg0l/ZxFM2kMXp79JWvGn7ftwZhs1IoKpljSD66gwE/Rl9lk?=
 =?us-ascii?Q?1EYP/VSd/8+RTt3rBpyX6rwAaNGdjqQHVGET2/ECrRTQg2URnolJKCQuFPHD?=
 =?us-ascii?Q?niJDIgmaW5UT17TuSC6SvYLVgroqFJmg4aFL5Rl3/5P37iDJ7EjduCSok170?=
 =?us-ascii?Q?7ybfHkfYWEcCbY4bIveK9Uw7T3EQGvHmOGMVoVKzHOmJ/wLDLvhvzc+DcFbv?=
 =?us-ascii?Q?QOJBcy2Jhy9cXzYnR5wRzmCa2mLLDVadkzf4rx9fTePq3tyA/toX+R/Idxru?=
 =?us-ascii?Q?9zkl6kglTal9UzV8YRdQeCziZA4F3YRvpy4XJpds6RSAICCAEQ/a6Uorjt9C?=
 =?us-ascii?Q?LR/zP+Di7g+VYLHjuaWPs683DyLdFHWM7VV0j53l8g3ZZw3LCR6yfYqeUQv9?=
 =?us-ascii?Q?zya5lhsIMeWK05dWEaR6aoFojLpnR71voukp0ZAEfyxC20biPFFXdno1Wq/F?=
 =?us-ascii?Q?ocp4ekjvKjlAKLSEcxvW36V29RA3b/yF4EluJ/mKvNU6ZjP7PoyPTMDpnO0Q?=
 =?us-ascii?Q?6bXNA1RxAK0GLSyvdoTiTaHMBOJIrzs6/wPAx9/7waXXVrNiEVhabR3jCJEA?=
 =?us-ascii?Q?uN9by5kn56hK60dkFCsKoPIm0SF9wV3sPY3fDYQclBRsyJO6MwWzmFVm1aq1?=
 =?us-ascii?Q?dItr56EPuntZlZ0H4O1UnfBEnxRSpLiES6foiUC3/umf1k+fE2ldAk3b6vdr?=
 =?us-ascii?Q?qcm8eQplDVUz1MFO35jMs4QfDV7wZuOihzROUkl0eeJcQTeMJPKXaW/Y0TH7?=
 =?us-ascii?Q?IcnAbGS+7F/FRKFMT/B3/S89pAxvK/rzFd3mDtX7UM5CQpYcCiopA2UDCos8?=
 =?us-ascii?Q?5I+M9MaMPyLqlA9SSQow0B5nfkVHIWqDk6L3iZf+BsKY/rpyAY3qJMgIbLdY?=
 =?us-ascii?Q?saCEiKS8uewwoe/weax1tqU2zF7BG7zVwAswT9+y1i2gUNNJCipm9sJfrcfV?=
 =?us-ascii?Q?gEEC2w2zglUc53w3agepOiUXK59N5LT8RneR86kBYKDDpLtw5khLDIhJOG3o?=
 =?us-ascii?Q?VrKq5FalLwnVfTPZDgx150GvCg9lZcn1LE8PTEcQ29zGyQAuX7yggXnsQ+OW?=
 =?us-ascii?Q?9deLf8DLxU4djLvEye9iaMJ4I1RN6NMVU0F8dirOutYAIAT3D29CectX2FpD?=
 =?us-ascii?Q?fP0rBqLbkSUSu0MXgPyXMXiiJIFDZ90JY62aUCjGyTEwsqmSl4xSebG7I2De?=
 =?us-ascii?Q?eLYNsEAIyrM9GoGN0gvL8bksaGpdtlSxmXDF58UNEfeq/vr83G6zaRisYlBo?=
 =?us-ascii?Q?UGybQAEhbfswFu0peBuV8a8KF+KiwIUIjJDABEPiambRgupEa9N7vGi18aNO?=
 =?us-ascii?Q?vM1x9DNgL6IkPmG1cfCY4QOUZkD0v+ZsFPMhmKDOwRCSUkDIIfn3OEAm12kB?=
 =?us-ascii?Q?y4RdTY0y4xIltMu5tQdIzkgCHhaRuT5ETynLGr90hRiTIwi47wCM2LGI8l3t?=
 =?us-ascii?Q?r1mYrGHjo7NQW5Zogq0DtWg6nMissR6K52Xl/ijD53Vm4jR/hPzqne5zSmQE?=
 =?us-ascii?Q?w65K5Oi0sW3ysj7wAeX9DMwxI2sBXNEEtiDrElK8tP+cfEIG0p2N2q4Rodwz?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67de5457-3e80-4258-78c1-08db798e2caa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:19:34.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4+AiSlXQSEdkWVH0fOTGmjIfmu3x2bukM6iRQtQT1DP7mdEA+T54Pv6dXI1lVLReEaFyPgd2GNbtm1JdI6l7pO5zsmHYDhlOshaY92QwyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8421
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wilczynski, Michal wrote:
> 
> 
> On 6/29/2023 10:54 PM, Dan Williams wrote:
> > Michal Wilczynski wrote:
> >> Currently logic for installing notifications from ACPI devices is
> >> implemented using notify callback in struct acpi_driver. Preparations
> >> are being made to replace acpi_driver with more generic struct
> >> platform_driver, which doesn't contain notify callback. Furthermore
> >> as of now handlers are being called indirectly through
> >> acpi_notify_device(), which decreases performance.
> >>
> >> Call acpi_dev_install_notify_handler() at the end of .add() callback.
> >> Call acpi_dev_remove_notify_handler() at the beginning of .remove()
> >> callback. Change arguments passed to the notify function to match with
> >> what's required by acpi_install_notify_handler(). Remove .notify
> >> callback initialization in acpi_driver.
> >>
> >> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >> ---
> >>  drivers/acpi/nfit/core.c | 24 ++++++++++++++++++------
> >>  1 file changed, 18 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> >> index 95930e9d776c..a281bdfee8a0 100644
> >> --- a/drivers/acpi/nfit/core.c
> >> +++ b/drivers/acpi/nfit/core.c
> >> @@ -3312,11 +3312,13 @@ void acpi_nfit_shutdown(void *data)
> >>  }
> >>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
> >>  
> >> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> >> +static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
> >>  {
> >> -	device_lock(&adev->dev);
> >> -	__acpi_nfit_notify(&adev->dev, adev->handle, event);
> >> -	device_unlock(&adev->dev);
> >> +	struct acpi_device *device = data;
> >> +
> >> +	device_lock(&device->dev);
> >> +	__acpi_nfit_notify(&device->dev, handle, event);
> >> +	device_unlock(&device->dev);
> >>  }
> >>  
> >>  static int acpi_nfit_add(struct acpi_device *adev)
> >> @@ -3375,12 +3377,23 @@ static int acpi_nfit_add(struct acpi_device *adev)
> >>  
> >>  	if (rc)
> >>  		return rc;
> >> -	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> >> +
> >> +	rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	return acpi_dev_install_notify_handler(adev,
> >> +					       ACPI_DEVICE_NOTIFY,
> >> +					       acpi_nfit_notify);
> >>  }
> >>  
> >>  static void acpi_nfit_remove(struct acpi_device *adev)
> >>  {
> >>  	/* see acpi_nfit_unregister */
> >> +
> >> +	acpi_dev_remove_notify_handler(adev,
> >> +				       ACPI_DEVICE_NOTIFY,
> >> +				       acpi_nfit_notify);
> > Please use devm to trigger this release rather than making
> > acpi_nfit_remove() contain any logic.
> 
> I think adding separate devm action to remove event handler is not
> necessary. I'll put the removal in the beggining of acpi_nfit_shutdown() if you
> don't object.

How do you plan to handle an acpi_dev_install_notify_handler() failure?
acpi_nfit_shutdown() will need to have extra logic to know that it can
skip acpi_dev_remove_notify_handler() in some cases and not other..
Maybe it is ok to remove a handler that was never installed, but I would
rather not go look that up. A devm callback for
acpi_dev_remove_notify_handler() avoids that.
