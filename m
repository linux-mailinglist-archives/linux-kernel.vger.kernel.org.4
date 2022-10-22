Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69C960903B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiJVWHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJVWHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:07:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FA279937;
        Sat, 22 Oct 2022 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666476422; x=1698012422;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aa5bzKWN+Vs0Y6/lUMEKkbEastr+7p+7mzrgGt3nyqM=;
  b=YuJCt13OjnkD33Z0gWzhyD2XnTmtptcxMvH0Z4qbh4SILaXcs1WBrvr+
   nghvjwLzxUjGy3TpL0z/x/cOryENYXhUsdHd+6nxahB7h8mz8w5apqCwL
   AfymAEMQLuksRUHir0VnWwcBId332Nojdb2GkwT4WOn20kZimaf+pv5F+
   CPx7FD6Tx1W9t/W6uY8ahZ9Gsh+lp7SmFTT4+Q7lIzTiW1bQkTRR7270i
   TJvDEzSTifgDid5eO8tCHDG/9WyJb1tJ94ZgzVOfZzod/Yj3W0CW4O7xK
   ZhfMDoVdzrqyZiQ66uaMIiPW5HdGTLP8IhyyJ/U9402XMmOWWmK5y1lT0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="290519207"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="290519207"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 15:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="694113782"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="694113782"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2022 15:07:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:07:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:07:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 15:07:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 15:06:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2MzfUiJR+e4jqYiHxdyFlU5zuLrI8IvFD/D19IaKbArISaBBOC4qPxJCp0glFAp7Mvrn9NPMmLDFTkBtzxOAIIDAG0/eMUPWRtSyv0SQX4mz8mRRDY0lWNiMmMv4IHVQB4dLZw101XOAIlbumLWSXOyCWlWiUIGSBzgfvhcktjlkOnc0N+uZYu/MWhStT07teBbVXPLPfnsR09fAzgxyLvxA7681vFFA8vrmRWfijy5bMB7XDzNiSo4kaXz+SZ/GpjuxMQEgbzqUHOuOB6Mtgopw4L8W4G9ninm1FzRf3zS1p3B9QX0DqfQcagtPWWpcp+qTqX/Dcy9sf//fXM/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyrNDrozPlaLJp58O+EBd7YJfTT9kqCxIMhu+89CgrY=;
 b=aWlt3C1ohJf2UkQHTTATHfKZHF18YOZWe7IC1vxyC5sey54sJGO6TpQcvTLDg5W20aBabHjHcnD7lhZGZ+uBKDlOQZFdTdyciJfPAZHksct4oiLX9pct7KbvppwzIcCzDOJUlFsX9FQRvJ6HTQZvvf+A7+qoklyZRH0b89xPgi6b26nofg6bDd+zTNia8gBs7C9M9wvfLmrZSzwFVUJCG4e1OQWszzAG37/0qEzemStUKdB5gkpbf4CP+/dKwyaXCriCMTs5cWlLyi28bUv8L5ddbVvYqzrunhre3/lOQ8CV6kRgvAzy/Jvudt/Pz3j7WzxQ/73DhGBhhH1TVYermA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB7365.namprd11.prod.outlook.com
 (2603:10b6:208:423::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Sat, 22 Oct
 2022 22:06:58 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Sat, 22 Oct
 2022 22:06:57 +0000
Date:   Sat, 22 Oct 2022 15:06:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dave@stgolabs.net>
Subject: RE: [PATCH 2/2] cxl/mbox: Wire up irq support
Message-ID: <6354697ee26aa_14192942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-3-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018030010.20913-3-dave@stgolabs.net>
X-ClientProxiedBy: BYAPR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::38) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c925b1-250a-449c-72f5-08dab479bcbc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HcFl+USjEY6g6FVNXq52U+jqj+FRJSqy7yYItkYO6NX4WO8DdtU1JZNZPHhTRYVCnJonW/q3Z5r37YtiRw5E0uYjbim2sS31zjy8i01RgpYdcq1ZR4XcG0R0pd5PAwnAWTSgON+v1H51Ch0edEpoCjuFglZxxdcQpiR7HNgVLxzWPV0hGnQEcDQiBpeqbN4Wgml2ozfhr0QjyBaBl0tHVgkt2ZcQPAZMGeQeZ3+CthVIQpB97OaSneTIKIMHPHtQx3h6DJwEJjwIV1jelzp7DKO3ru4WBnYvgWJc23++Xn9jis4EiJvIq01wwRK7FhrdhmoJ2WamEiDGQo2zMyDAtobFz7dRwZHU3p+G+s47mz7tDmEgXJUimeeG+e+/fV9e4li5UEFvkQJvcVb6kpC1Wn428gfBIsLq3DRBz3j2Iis/zIs8u00exUoL69GRQUUPEe24haYpXTp1FpTXvofKquPJiuUNR4x1tCfDmC0AeSe4Ys3WXqxaZi7+qYzqjTRJZtwFl8vn8bL4N0PbjfFBLDkJWT1ElXYaHWt4n/T3n0GVSCUSA8MEb5Rb0usCxupXvY3ib2a67krvzMepaOxM/h4QtVcQoP9ZYxpD+ECg7A5o0P2kKbwn3X39hp/QAnTaYJ6yqP+/fCR9jx9ORptH+XN5YmR2sI2yuu58ayDNV+Xlcwd9m2DMKnpv54JqsG1FtrOVVt6YXj8wCcuEwuaig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(6666004)(26005)(66476007)(66946007)(6486002)(66556008)(316002)(86362001)(186003)(8676002)(38100700002)(478600001)(2906002)(8936002)(83380400001)(6512007)(9686003)(41300700001)(6506007)(82960400001)(5660300002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fMnYzYseTvclZp0E8sk2Yj4m6NrWIwqotZYEugdsJ7iqMAXQ8SF2KEu91EFg?=
 =?us-ascii?Q?fshECOr0sCmUpQnIT2BaUAs4XVSWLD/e9MTsvupO4QHQEj25figJgzZTDN0U?=
 =?us-ascii?Q?05iQekwJ6WMrIIvr5wWbe7/amgoE2JoJ/8YoE28hfjTyM2GWUmC4kU6bAC6Y?=
 =?us-ascii?Q?rEGXLJYx9IO6kyETGA91WDKpu3XACZ/0j1ZN0DT5F2qEdtNdS7fV8hLGJ7o+?=
 =?us-ascii?Q?SvDeLmLcEeo3t+hWWpWY5pOp/pFKEhna53kshAyRuJtTUM8CUNzYshF+iXmA?=
 =?us-ascii?Q?GmZ+F5PjcKK6925gJr7xxU+C3Pp84NjmiAuDJHYw5O3uHs+N1u0UMawDXx0y?=
 =?us-ascii?Q?9+al49LB3S8oNcBkKdaKk12glvwXLUzn+uzS2FkweJbueqGXEklaknB85unq?=
 =?us-ascii?Q?XnUtm0ARiPcu8Mj+69G9zbqAXNqIZWiOOh17fxsCWvtPZYCiDkw4N5wKAILf?=
 =?us-ascii?Q?U7TKnXXCMQ8Zg2ue48WczcvAP5pZPgEW0QHzCkfdbLIaCA9KBP+IT5P9U5CI?=
 =?us-ascii?Q?BZd5y9tqPt++bK6nFS0Yvid47Kgztei0Li7uJtKcV6Ollc395wzj41dSKmZL?=
 =?us-ascii?Q?y3pzjAmRv2nxIR7DDfWt51o2RYsdhJj2XsmMgM9CMT6V8BBz1fCuhWkfDFvI?=
 =?us-ascii?Q?GjXtlGhcP86izCIA/G5dGlPFedrZ3EdEOfHDmiAct92L3jSjPTMcYIRLPAny?=
 =?us-ascii?Q?x/+FKYtP+xcGapATG+MRKzlroHrumQIvV8FbEnaPSEF8tnF1F07k3aP1BNgn?=
 =?us-ascii?Q?gdw3jboRh3XkcYkIK0kvMjlvEzRn4Ng2I+aHxqBUncxDP3t+BAcveMQOXp5n?=
 =?us-ascii?Q?OTFVEWtoDnITV+EfsArvoqfrL9GQtBF4UqsWLKQbW9hojKbHb3glOt9cmzEI?=
 =?us-ascii?Q?mq3rVWAu+b5AR2/ysJkJS2eqIdMLm7xLpCBCPGadgYKGFki8UP0gXaWfnZbZ?=
 =?us-ascii?Q?V1M8gfE0dMaJZOiSPB/33kUF84xwVjZ7nMpJjJ+N5My58ekyBw90MSGYKEFf?=
 =?us-ascii?Q?xL4cWaq0ytv5KTCNUIaa74u66spnNB3j1s3FcEtf4TXk6ijoqn/qKc8o5SMa?=
 =?us-ascii?Q?bYSc7doBTXmSct81hgPk4Ub94MaXAmrTrJ797n7wM8k8+j93vXa1vXdXlhKV?=
 =?us-ascii?Q?IxZlmfLVOq2CYex07PEBsTYCmVG9cZsobDBaE7ECmxf/QUP8Z8kzz29QGYH9?=
 =?us-ascii?Q?6nNidHSl1BOn9my92ig+WfsrnJ9++iaDzP35ZVw1r58lG/Ula6kyFXI0pSBn?=
 =?us-ascii?Q?uYSg/57vyGaPP7aUtVdHqL3i2hnVuKwRcLeInWN7EffKDeJE6eO6z+0vKj2m?=
 =?us-ascii?Q?O7jPdouJW9m7ki1lK/MofPXsqOUJ0F0f8VI7dSXU6/X66ixGyGysXKK/AbfR?=
 =?us-ascii?Q?OkmO3gEPwMvtqI5jjadC/6pHvN0KdWSluoLdSmhu3ZXh8/ISqmbTwPF1HXnE?=
 =?us-ascii?Q?3JPf+xRy5WxPr/BBpoKQKQLKpxxgetOufr3rWO3l72yF0zJyAXVEggksWsY1?=
 =?us-ascii?Q?TwmVvenbhd9sf9ewLEoA94EXNTUhJ+fWxY8ddgBo5NSib+VvrnVC+qT6c5sE?=
 =?us-ascii?Q?JIop+K5ANc6uIgAo9C/KKSmezI26Ujjp0Nq0c4rGRhDO31GWDEZm4RcYaTgJ?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c925b1-250a-449c-72f5-08dab479bcbc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 22:06:57.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bKEzORoDPu3sT7tm5/opFADKEGLNDob8RU5Yd+01Wg9HD8jaDkt+e6RIaWrHdTOJFyj4Isi6Sf4DcOLCSG0CzBlhGfjz/+F6xFcX6bUHRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> With enough vectors properly allocated, this adds support for
> (the primary) mailbox interrupt, which is needed for background
> completion handling, beyond polling.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/cxl.h |  1 +
>  drivers/cxl/pci.c | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..13a9743b0012 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -135,6 +135,7 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> +#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
>  #define CXLDEV_MBOX_CTRL_OFFSET 0x04
>  #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
>  #define CXLDEV_MBOX_CMD_OFFSET 0x08
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9c3e95ebaa26..c3f3ee307d7a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,6 +274,32 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +static int cxl_pci_mbox_get_max_msgnum(struct cxl_dev_state *cxlds)
> +{
> +	int cap;
> +
> +	cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> +	return FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> +}
> +
> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> +{
> +	/* TODO: handle completion of background commands */
> +	return IRQ_HANDLED;
> +}
> +
> +static void cxl_pci_mbox_irqsetup(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int irq;
> +
> +	irq = cxl_pci_mbox_get_max_msgnum(cxlds);

In this context cxl_pci_mbox_get_max_msgnum() looks misnamed. There is
no max, it's only *the* message number for the mailbox.

> +	if (!pci_request_irq(pdev, irq, cxl_pci_mbox_irq, NULL,
> +			     cxlds, "%s-mailbox", dev_name(dev)))
> +		dev_dbg(dev, "Mailbox irq (%d) supported", irq);
> +}
> +
>  static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
>  {
>  	void __iomem *addr;
> @@ -442,7 +468,7 @@ struct cxl_irq_cap {
>  };
>  
>  static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> -	NULL
> +	{ "mailbox", cxl_pci_mbox_get_max_msgnum },
>  };
>  
>  static void cxl_pci_free_irq_vectors(void *data)
> @@ -562,6 +588,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  
>  	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
> +		cxl_pci_mbox_irqsetup(cxlds);
>  		cxlds->has_irq = true;
>  	} else
>  		cxlds->has_irq = false;
> -- 
> 2.38.0
> 


