Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA672D36F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjFLVin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjFLVik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:38:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1FC9;
        Mon, 12 Jun 2023 14:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686605917; x=1718141917;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oBjyFIqm9Wlb66MfsLMbEaDWHUDcoRvMkzlOyG24HAw=;
  b=BPyiy0olt1+RwvyklFYRseqN1FBwWRz8xkYMsLa/tqoiRTZqwTgUxBqi
   jTsNU4PyecKsMqx7xseSmG4dPG9FnfCe4FPanQuvwCpFCx4p8fJnWZaCU
   KIZH+ugSlEx9vnseHxQveqc5GrpiQbPS0gxh8EdSLexMfcRrUtxenprFX
   tP2szLtMrijnj0J07ReWOAaqs3sDmX4fg+wpUTUmWNAACMXhwHXCBZLg6
   rDN3lnftTRM1z96/MYCMld8qZEQH1mszFat+5chEJEt47fcdzGMx4HnJk
   EJt1IlGalXETvoEWuEyPteI5kUzkSQrMqEKPsXNaN+XUflHZ0yFopynfu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="355664255"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="355664255"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:38:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835639767"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="835639767"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 12 Jun 2023 14:38:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 14:38:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 14:38:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 14:38:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 14:38:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrInwXNZxA629KVoca3r0XwrgdRCFdYWR1TtTcTzMjSiTdm8X0rAMrwm531ZFjK7xftzqu4RM45L0AQFRb6qdJyfztMup/g3CWAALBKqR9nHoBKwTrXMt/YEOMLrM8wEUScdP3xuD8z/3EK43v80ri7jC3Sd7PsXBdnQ5pS6tMP5dxv3Azw4AvWLPSaPhGuBCQldar3WqSZEcysclpRFdD3+UckGftofSEKowV+f6O/rXxU+Ac6B0+CLfzpErLnwLb7D8UsaOASB28yIry2LNv+itZkM4jTB0vGixWy5NQI8NcZd9bRzppgFy1FKoGWIAZQqosrXTHD8zRpakrAViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4UkL0PWZU5my/RCaQnKIeML3f/nlpHoam5aaTN56WA=;
 b=jm1CnwZN3+bgfWrRozgzUChKkc0hSRK1pbAgXA0o30ouJEslWT89nPRIGwKsrPajkKSFEzf/VFA8wn4c3UD+B336f9OTfbShYkqVD/jpzwZ0uPV8JGcW+v5VusQ7CR5MIzl+05v0y9YpkCBKKHlkpKfbo5OpXBj36ImIUimR9zZssDfb3h60Wg93I+r00J+thbU2ym+CjIuMBij+GxMcC4lur5m+XxX4P3CVhJWpYmV02gtm7BGg9TByFG0nXXfkr7nC/1y/YEqLTKBQm1zHb7lOJ2HhiMq6RMGh0qzVoSLmw48TzF9VqPFyxk7Jl6Bxk0rG5yqMt+OHaJB66x0KDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7865.namprd11.prod.outlook.com (2603:10b6:610:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 21:38:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 21:38:33 +0000
Date:   Mon, 12 Jun 2023 14:38:30 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 24/26] cxl/pci: Add RCH downstream port error logging
Message-ID: <648790561f7ea_1433ac294ed@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-25-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-25-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d65582-c12b-470d-e93a-08db6b8d5eaf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZ5SY31c7oLZYwvvK3TysDot2kO1SxYNtRejmDfLFS8CHvgXPrk2jy8gTdBiRLYUxokvsxJVo2VrXsyhqTGD8hX/bSC0qKFrS7WYyPR2Vy9llqnLGboENiZhJxd+p+7aYl4iHWHQEYPBd4VvNzqaocutESbr9nph+IDjlEfX29f1CLQG34AaP1wG/jhilrM5rO6YgId3HEkvv91P5SrS8Atf8+vYRhkmQKEsHIYaYtlg7L6xI+Cu+srNPOpOs7SCUVJQ+P28HwJS+sVkMZODrgRT6AfLqR2H7J2/oM7eiOgZW7mgPcKZNxsNuy/ZcBhp5/uXZuuqb4S/4uZsevvk61IXPkYw1fPtR/jXtPIdKn3SAHZ0Wy84l4JiMjhvQl2aF75kjTPfCm0otXFPwrGislvESJ779C5FtsPmvi1BgWpoFNabF4iZ5pIi0qZ/R+OS0CVKSjrtxhws+HIXHKNX9tZdzl7a/1LdSVoJ7EiUx82V2i/c40A6wBhWItyj32LO5DYtLRio64TItZbaq/cLu0e26m5BpTWOfL1bwDAtTgz7It4nHdNIpU0rmPyBV1zp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(2906002)(86362001)(5660300002)(186003)(83380400001)(6512007)(9686003)(6506007)(26005)(82960400001)(6486002)(66946007)(66556008)(66476007)(4326008)(316002)(38100700002)(478600001)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhidE5Mhh6Wqv2lo9G3HYWUvY6G9MgviJtVO6rKGiYyFixRC+YuYuy6kPlbs?=
 =?us-ascii?Q?dbMRYldE3EDK1g4lSNdVvS1Pd5h+6Syxn1IEHzrp/WM/l74OdVPOaqIARldi?=
 =?us-ascii?Q?Mix5raLSisjlx+3HGaAqsff5SRWH9eyWDuFH5HZ0ZlwSmhEoC5sJG/JCcURy?=
 =?us-ascii?Q?BRZhOoer7ZG/V1wfLFpQkrL8nSwWsm7G+5OrsCJlbK+fcLLVO6j5xoPe8BRj?=
 =?us-ascii?Q?4CMEXB78vlVLLQCYKlWYEmICuoehxhdoqNblmVa6K97XI2agMPObW8kH0ir0?=
 =?us-ascii?Q?cBXRzn2Mqw6XgmXPPH518Gi6aCRQG0fAmCXSHm6fvKHkAm9Z8+HjaBKhN76t?=
 =?us-ascii?Q?8Nc/A2Vt0+xAzab/MdQYxvE2AURTMrdt5n56KB2fzQZSOSuPyZ1myHFc4mbo?=
 =?us-ascii?Q?rLYxJSwk0ryBZbl+QW68IQrGGf+cRB0k9QTsfP6qavbwsDzG3y5psjgtzCzy?=
 =?us-ascii?Q?jojgN+iaCrejZ8tyIi3fTgDSZzW3p75JA9CKBKWHcSc9IymFsijUTmoHBAng?=
 =?us-ascii?Q?HL+BJHp6nS4j11zBN+TRqw++kYzhJ0SYgK3KA9HytnZYgpGHf39A5Gjwn2zP?=
 =?us-ascii?Q?v5+hmMlhatBW0Me0HCcudxVGxrzOpnt4EEc7pOGzcLpZsfcxgf+dm6VCd2tA?=
 =?us-ascii?Q?Q0cPBB4flqXL5C5SaTjp4za/6YbZmk+YfhuV+5vp2xRCoYU4zxz5f9dvPBnX?=
 =?us-ascii?Q?2+bwZONvL5YYaltkaGNjgZ8n9Fknji35aFFG9rACPZBcz0uizlrGkmWAioPY?=
 =?us-ascii?Q?oCrDZeaUJfjxpMui4AKSZgobv1aPsvXwbL8kKwHFQwywctOXM0pXQcE+PaNY?=
 =?us-ascii?Q?8n5gQbYvLfOMvfJu68gs8Gensprn6zURTMnkWcq3vuq7SS9FiKCkqVO800l/?=
 =?us-ascii?Q?Da/aoSxRwo8EZ1HprHfq4EDi112A70+3dCdLC88QCdxVK/KSGBG4xVeki3U7?=
 =?us-ascii?Q?YKLV4D29JVmu4YFo3BymaL3Huj/jLtP+0RYdH5Uww7d4Z60J2M4NZV1WVPYS?=
 =?us-ascii?Q?iDUOTmQeuZo7+hunabu70t5nb+oID98qQBY4MyEc0tR2Ip7wQC0siY5nQnfJ?=
 =?us-ascii?Q?sL75V1k3ZcHyMVQoRU8CpSaOZVca2l9GGmdXcAa6ZmtemYEBaj1iZ2J/sd6J?=
 =?us-ascii?Q?Hndxua0uIRHSakodr7t6ZAn8X4s9fqrSK2jLAgQlOdgwkuOcl8GW3ZTeMNSL?=
 =?us-ascii?Q?23xWn1yxjAd4Bcbd1F77XeEUE43YFoR+ZvPrvdpP5vATryTXtCxgHBlNbTVX?=
 =?us-ascii?Q?k80oHSZh7Ck0iRiqGb6K/oBIUaRWRPdO9Z7nW/SsgnSO84WzCO2b3i6L19jz?=
 =?us-ascii?Q?OTgmuw8Q2qqJrb+64sfYc/i7ArknZTZAlGzmbcw9md90yyAm5h7Hk63WCsEw?=
 =?us-ascii?Q?9u1mQPk3muqFoef1KQ1Ifym7c19zZfURaMl0SCkN4nwt1XuMifqA22PNO+Me?=
 =?us-ascii?Q?SU87tN+k90nYGsKHgQpa9NN6BoBAUb+GqH/HXAp4LUzf6nw5Ek9IPRvMrcFN?=
 =?us-ascii?Q?0qtIBb2sks2N9gIeu9cR77x0m4uGNK5fcLfVlfKBq8YguNc2pMO4x7m2JcdX?=
 =?us-ascii?Q?XqsRzTG8mc8gob+iVD9yQbyShYtb+pCn+zFzisj2j+UI37AmySjQxotMpAFN?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d65582-c12b-470d-e93a-08db6b8d5eaf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:38:32.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kALwVP3XD0x73AS7lurxbmRQedo9Fx7RwHvqZR511ZaWUkAwr83ioCKScnaYOl0i34U2xS7/geYrTHFSHCrTWwQJ/6xcxnGnQpU4nfTKxhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7865
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

Terry Bowman wrote:
> RCH downstream port error logging is missing in the current CXL driver. The
> missing AER and RAS error logging is needed for communicating driver error
> details to userspace. Update the driver to include PCIe AER and CXL RAS
> error logging.
> 
> Add RCH downstream port error handling into the existing RCiEP handler.
> The downstream port error handler is added to the RCiEP error handler
> because the downstream port is implemented in a RCRB, is not PCI
> enumerable, and as a result is not directly accessible to the PCI AER
> root port driver. The AER root port driver calls the RCiEP handler for
> handling RCD errors and RCH downstream port protocol errors.
> 
> Update existing RCiEP correctable and uncorrectable handlers to also call
> the RCH handler. The RCH handler will read the RCH AER registers, check for
> error severity, and if an error exists will log using an existing kernel
> AER trace routine. The RCH handler will also log downstream port RAS errors
> if they exist.
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/pci.c | 98 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index def6ee5ab4f5..97886aacc64a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -5,6 +5,7 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> +#include <linux/aer.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -747,10 +748,105 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>  	return __cxl_report_and_clear(cxlds, cxlds->regs.ras);
>  }
>  
> +#ifdef CONFIG_PCIEAER_CXL

A general reaction to the "ifdef in a .c file" style recommendation.
Maybe this section could move to a drivers/cxl/core/aer.c file, and be
optionally compiled by config in the Makefile? I.e. similar to:

cxl_core-$(CONFIG_TRACING) += trace.o
cxl_core-$(CONFIG_CXL_REGION) += region.o

...it is borderline just big enough, but I'll leave it up to you.

> +
> +static void cxl_log_correctable_ras_dport(struct cxl_dev_state *cxlds,
> +					  struct cxl_dport *dport)
> +{
> +	return __cxl_log_correctable_ras(cxlds, dport->regs.ras);
> +}
> +
> +static bool cxl_report_and_clear_dport(struct cxl_dev_state *cxlds,
> +				       struct cxl_dport *dport)
> +{
> +	return __cxl_report_and_clear(cxlds, dport->regs.ras);
> +}
> +
> +/*
> + * Copy the AER capability registers using 32 bit read accesses.
> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> + * status after copying.
> + *
> + * @aer_base: base address of AER capability block in RCRB
> + * @aer_regs: destination for copying AER capability
> + */
> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> +				 struct aer_capability_regs *aer_regs)
> +{
> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> +	u32 *aer_regs_buf = (u32 *)aer_regs;
> +	int n;
> +
> +	if (!aer_base)
> +		return false;
> +
> +	/* Use readl() to guarantee 32-bit accesses */
> +	for (n = 0; n < read_cnt; n++)
> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> +
> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> +
> +	return true;
> +}
> +
> +/* Get AER severity. Return false if there is no error. */
> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> +				     int *severity)
> +{
> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +			*severity = AER_FATAL;
> +		else
> +			*severity = AER_NONFATAL;
> +		return true;
> +	}
> +
> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> +		*severity = AER_CORRECTABLE;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void cxl_handle_rch_dport_errors(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct aer_capability_regs aer_regs;
> +	struct cxl_dport *dport;
> +	int severity;
> +
> +	if (!cxlds->rcd)
> +		return;

Small quibble, but I think this check belongs in the caller.

> +
> +	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
> +		return;

The reference for the @port return from cxl_pci_find_port() is leaked
here.

How can dport->rch be false while cxlds->rcd is true? Is that check
required?

> +
> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> +		return;
> +
> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> +		return;
> +
> +	pci_print_aer(pdev, severity, &aer_regs);
> +
> +	if (severity == AER_CORRECTABLE)
> +		cxl_log_correctable_ras_dport(cxlds, dport);
> +	else
> +		cxl_report_and_clear_dport(cxlds, dport);

This is the code that made me go back and have heartburn about the
naming choices. I.e. would a casual reader assume that correctable
errors are not cleared, and that reporting is different than logging?

> +}
> +
> +#else
> +static void cxl_handle_rch_dport_errors(struct cxl_dev_state *cxlds) { }
> +#endif
> +
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>  
> +	cxl_handle_rch_dport_errors(cxlds);
> +
>  	cxl_log_correctable_ras_endpoint(cxlds);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, CXL);
> @@ -763,6 +859,8 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	struct device *dev = &cxlmd->dev;
>  	bool ue;
>  
> +	cxl_handle_rch_dport_errors(cxlds);

Per above comment on "cxlds->rcd" conditional, it is mildly surprising
that even the VH path calls this helper.
