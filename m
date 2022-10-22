Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7777860903A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJVWGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJVWF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:05:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC861DA2;
        Sat, 22 Oct 2022 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666476353; x=1698012353;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qTyzxJb5lqu06UV1HhKfhzFh/nG5c8iwhL6GSanZsKc=;
  b=ZTRJwPAXw9/uRr/tHY5ZAlgZFo41elF8tFHcLIXhV77w0qYVbg28f7Nm
   99MMs72aOXTezjky57f2Ooz5DW+ya/mwd5qm5isY6GobryKgq8ka94jFE
   vlPMUsO5GLChASqvsmLlv9vINWbkK0ZB6JGsiYgTo55UVTOdedKUUNDX2
   k5FUE9UIfgbsd7LTIY+KjCBeu2nvonssjP6knwwEp02aTrry8VidGj1Qm
   o2cnXJVhygp0wrZs+mO0A3mSdeK8o0QYMFFhppfCkjbgx51516au27UB9
   E3jxsI5838rRhEUQLsEVTRgy+axVpPt45VUP7+sD6ng0Gct7uyPFmQ9a1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="369279388"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="369279388"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 15:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="773429469"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="773429469"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 22 Oct 2022 15:05:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:05:51 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 15:05:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 15:05:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 15:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9gcYBP40mErFfyEFgQchRDBPo7uF4LxpCsOljip3bnXEzhYBOr2KVsvmd6GUfC19uJzGicYArxRGEd9jaUr/8InPhwFS0saw62VMpdW4hPIX6dru5s6tx6SqHA0KcSRRCKwOAnK3GvQsQkBxzFrkQHihf0qLSN0Md5l9YLHxGgdsjoHYSEcT/L+R8JeTixY6FxgMA341nvJyGLt4Ig3qbdOx7OMd6Lo+GXsUhQsW2DgtzpAyKVMU2/70oaI48C9oTkaD3GvsDgvBYS7FNHDfNIIwt8jBTJHNxB0sfvTQXBqZ9Sz8AoeGyvb/Qph/zjTF+9kGRYD6xGccN4i2bxMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fAH8FqZwpmHXQ+eCKf3tOgW6asceZamI/2jx9QZcGU=;
 b=UHulxHlf7RKTJZGx0Q0ujHfd7jYUedTRwNH4m+jSPF3ljQrL5xnVjek68FzX7IrHZ/ACk1IajwJuNYXqu54reHEpEyhkJhAiXzyXdv86gdc25afMzEQHffJzsDELtrjop8kipKxqOtbNJJDe6KX2ZfXWPoHnJ8qAo1ArZlfes2ESD/ql4NiE+trNzfGXeLeLSWXtiu/CMRJVfACJM+U/6xCXWp16ndVmM6KtI68CtHLXwKN4oj//FPGkws+WrCgn+MpMNtWRyJvcQ+ueLYX7//eShZuvriVRw7a4Y41bhbbFNz1ZAy6fO2tPh2oiF56dwN3aj+NdSJy6zy/E4rEScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA1PR11MB7365.namprd11.prod.outlook.com
 (2603:10b6:208:423::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Sat, 22 Oct
 2022 22:05:48 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Sat, 22 Oct
 2022 22:05:48 +0000
Date:   Sat, 22 Oct 2022 15:05:45 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dave@stgolabs.net>
Subject: RE: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <63546939ea062_1419294f6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221018030010.20913-1-dave@stgolabs.net>
 <20221018030010.20913-2-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018030010.20913-2-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA1PR11MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: dc608e6d-dd06-4f16-32ae-08dab479936d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pfyo/W6+qwQWRyopwh4HSa5yGV7SytfXv8vyS2w1oxjKKfPRmukHd9es+FrxB/sEjFWLV06Z5PIcjF6m8r5EX7bTO+UvqPq/Dc4XxFwJ8/nPOxmPY1C0jKYFYz5CxSxiywkAGiLxJYYz/qKSNJRfqDkSrxEJqiDPWEfAxevb8F6KB6/A5ao495tAi07dGXWd7Uh8O+zidWgSKgITobuEJDtviCp7vzNKPSHvsZfpRjNgVzy0zo0+mZcajFtSt7bG3j/wNm/4P85O8mfwXghAWDIWiL/lgO7FgFXL23ZlalezrG8ywwKV4GqZDIxsMMIOpjp3vR8WIvOAqHC041wyIeWesAvl3k9juXqRFiVfCoDm+rvX3j+S0GiiG+HksUluejg9JtyPe+AO1BhOYlidcO8JWq7bIFC0gdx2FNTx1OaXXVVkWfyh34laTsFgJ4hcyIPlltzXVh5IVzbvOQrScuiBem6Zmvvmk8R1j0qcKGccPbYffGgONii5MtwLkkJncrqVdeUKAX0tkinkw0TMRD0/7HTwpNv7vaZyXac7GexbjGmnD6kizQqgkxdFaBhHFcE/cwrCxJIgu5Z1zljeWtCw7vU4BTLcC7bZqu7EPGwzWn64DjZb2jpXJ8as1E+9HYAeeZr/v3rjWbrOS3WVocUaPYapo/EdNaAWdMyfoh30hX0vUYRyrZGRoi1fL0DC+J/HSAxSqsjK58fFbAq/wJL8AbxJTa3RPi1O05MUweRS4PppB18+sfLZvcN30TIwdR40Jf2dhuxGHOUPscibqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(6666004)(26005)(66476007)(66946007)(6486002)(66556008)(316002)(86362001)(186003)(8676002)(38100700002)(478600001)(2906002)(8936002)(83380400001)(6512007)(9686003)(41300700001)(6506007)(82960400001)(5660300002)(4326008)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?StKzV88SvkACnnrxEkqPZ3rdbUAFqSPbw2wp0UJAXo5/AgswsTxPs/ccSn4U?=
 =?us-ascii?Q?mSv63H58GIlYw2FlJpc1sFKVWgA3J0SQig2IxwSAOr7GI0UKCoC5FXauQ8KY?=
 =?us-ascii?Q?x4br5LVVUGcnP1of5kIt8/xlCuD8cGOfKpKmSjyPdhF+qFz9rWen1q9C77jd?=
 =?us-ascii?Q?dmPrJa6jSS/PaYP1dLC2KeMdQiO8IR9z7fj8nQflgLhAHZVM6SXbS6f/PXL8?=
 =?us-ascii?Q?xPwVTE5qzFRLgU8ZAS8GtMdcat4oS1Bom2yepqp2KIqL1Z/Zuz/1alz0pfVp?=
 =?us-ascii?Q?+qnMlhFJnhAM7fGdUzw9QiPJXoI4BjAnD+tvMGSYYllhRcaKN7zSd7lW/3EY?=
 =?us-ascii?Q?4p31txJHHGJmrNaiRq/rStAvoZ7yCAqukoUH/b8bVjIw9c32Z90nRCDaUW9m?=
 =?us-ascii?Q?xDp8bIEdeQ2P81C6/qrWXdraBnDVawaYiICled8yrcElW/m/o71972HO+9Gq?=
 =?us-ascii?Q?zUuqEJCu4/N+KoveqGZQq1bSQuGG/iT/SJCMnDiwIF9kGFhEd+1TDOZCh/MM?=
 =?us-ascii?Q?2+yZItPL2LLi7AZSxVGHlPERpZK/YRdSvWoBrPjdLPMsarrJS4CwtsvDoDIB?=
 =?us-ascii?Q?5ZSVXe8iqubOyLY7vIXbDWg5egdNitNOtR/ZwCY8crII0L84P3lTy8itYi66?=
 =?us-ascii?Q?h05fIDdRY7HXTQX5pGAzvG9huBteV8d0U32tg/GIDYU5v9aPBvAkOXlhUcnN?=
 =?us-ascii?Q?D56QuVIu2j+khi/ScEPwRn+fn1yiJSuCFsXX0g13OgHkzsxK92OxfNiXrqpk?=
 =?us-ascii?Q?NxFWqt3nc4T9TCOU8wPHSY1QSjsXAixlvqcEtTzzaZ9fLt9XKa+5dkg1iHS3?=
 =?us-ascii?Q?ZdTMq/CFcma0fiXCjkBi0kqHhyCo44nFVyJ4/cv9lH8kwiqXdwA6VqJjGzK4?=
 =?us-ascii?Q?Jfe19TyoqsKadKbp2tOkXqJ9HHr1i2hQraQer86dyJw2o6Xcv8hgMbJ2DqIa?=
 =?us-ascii?Q?I7RpUZzmGiTfb3iVBbTrZtlZLD4ZTovKyQKFuhhuoFRCnQMG5P2pUVun6MvC?=
 =?us-ascii?Q?1fEpZeISFzOHxZXH40LyzUYFDyF85Y4tYiOWJonkMQN8Y5N+isbZlvCrcsRY?=
 =?us-ascii?Q?QOQEdkAuX5MjUiHgrHcaa+cZJRzfg2LGbxt1NNK4hf+S3hp+Y4cIcj87KBvF?=
 =?us-ascii?Q?xRD4Z29Wupxx9MRvAsCgZKtO9Y/sAL7Taw/xx35tg6EDy1uPvI756c4vfXYV?=
 =?us-ascii?Q?cVgui1kV6m2nebvc4zMfe/4ekjidpvmGSNmU6WtG/I+NgFJSWmPdqM+jDXYw?=
 =?us-ascii?Q?89sYrScyPPTf5GP86QvN2u790MwJwnaN4QLhtjJ2746nGQmr/9KrVp8UIAzm?=
 =?us-ascii?Q?KqhKKLawusogvmp0eFEZOn7At3zS4Ij3RIwWC7K+x/Dn9mAcBoIDn2R7iut2?=
 =?us-ascii?Q?52+oWq0HX3s7slcqWJtip0oQMh3v4bS+pYLNue9Oh6zbu3IH5Es4RpuM7osb?=
 =?us-ascii?Q?z/I9GwpX0O5LZiSo2itgZ57u64ZYVxiOfdQH2tZckNRNkXETHkAG1YeSKwlh?=
 =?us-ascii?Q?nu4ncLH897iE/I9ayMafTMv8tsnMJXECwBGIUo/iofi7RQZCI1I5vRvsb9/F?=
 =?us-ascii?Q?sUIKWiDqWUT9m/aoLC9vRXDLk0+vGvjGXcSOdg2rVf44lK7ArY5fvhKjSIRc?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc608e6d-dd06-4f16-32ae-08dab479936d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 22:05:48.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6Xbt95V6KrV13X01qPst/BH68biMJxTcqkUk8N4TBK9Nljj+tshosJME9THHds790TZiNXD9ObGKYVwlNT+a8BV3RkL3iM3YGDw8oKGYR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso wrote:
> Introduce a generic irq table for CXL components/features that can have
> standard irq support - DOE requires dynamic vector sizing and is not
> considered here. For now the table is empty.
> 
> Create an infrastructure to query the max vectors required for the CXL
> device. Upon successful allocation, users can plug in their respective isr
> at any point thereafter, which is supported by a new cxlds->has_irq flag,
> for example, if the irq setup is not done in the PCI driver, such as
> the case of the CXL-PMU.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/cxlmem.h |  3 ++
>  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..72b69b003302 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
>   * @doe_mbs: PCI DOE mailbox array
> + * @has_irq: PCIe MSI-X/MSI support
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -247,6 +248,8 @@ struct cxl_dev_state {
>  
>  	struct xarray doe_mbs;
>  
> +	bool has_irq;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..9c3e95ebaa26 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,6 +428,73 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>  	}
>  }
>  
> +/**
> + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI-X/MSI irqs.
> + *
> + * @name: Name of the device/component generating this interrupt.
> + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> + *		    feature does not have the Interrupt Supported bit set, then
> + *		    return -1.
> + */
> +struct cxl_irq_cap {
> +	const char *name;
> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);

Why is this a callback, why not just have the features populate their
irq numbers?

> +};
> +
> +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> +	NULL
> +};
> +
> +static void cxl_pci_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +/*
> + * Attempt to allocate the largest amount of necessary vectors.
> + *
> + * Returns 0 upon a successful allocation of *all* vectors, or a
> + * negative value otherwise.
> + */
> +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc, i, vectors = -1;
> +
> +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> +		int irq;
> +
> +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> +			continue;
> +
> +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> +		vectors = max_t(int, irq, vectors);
> +	}

Forgive me if I have missed something, I only look at interrupt enable
code once every few years, and the APIs are always a bit different, but
is this not too early to read the message number? The number is not
stable until either MSI or MSI-X has been selected below at
pci_alloc_irq_vectors() time?

> +
> +	/*
> +	 * Semantically lack of irq support is not an error, but we
> +	 * still fail to allocate, so return negative.
> +	 */
> +	if (vectors == -1)
> +		return -1;
> +
> +	vectors++;
> +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (rc != vectors) {
> +		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
> +		/* some got allocated, clean them up */
> +		cxl_pci_free_irq_vectors(pdev);
> +		return -ENOSPC;
> +	}
> +
> +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -494,6 +561,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
> +		cxlds->has_irq = true;
> +	} else
> +		cxlds->has_irq = false;
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
> -- 
> 2.38.0
> 


