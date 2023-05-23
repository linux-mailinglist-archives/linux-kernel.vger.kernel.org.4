Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B488670D8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjEWJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjEWJ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:27:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8951E119;
        Tue, 23 May 2023 02:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684834033; x=1716370033;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4pmQFILBmz2f/mXPtC0/un3f6702ACX81f16N8rZ8rA=;
  b=XK89COV7/PaQju0iv+jiVFWvsr1MjtgaXCFQlp7O1Yo4f3kvBpLZvxzG
   dC5qfjvD+7Z6zHqyrLR6Z8FZW85GSOdj50Pbg3tRF03YmXJklD08eWtm7
   1UWvmQbBjlTtV+fnuGxhDV81YjP+hZ+dIQ/xulqcCpJpdJaBCKnQEv3rh
   om9WFBcUJrloGU+eXNlgJDWNJBp68C6U0TUb7Bt6AJlGFUgXJjfEFe/jn
   LNJ+jmOHKaVXllPN2mFDoFyyYDOnhrN3O/dtVZu+I+Wyt70+Ve8T9Q5OI
   7z+ABFa33Nj6idN45LyZOKHlFaTagwE5DHkajM1nMTg8yEb4bWvUYor67
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="381429767"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="381429767"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="734683883"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="734683883"
Received: from oodnolex-mobl1.ccr.corp.intel.com ([10.252.55.104])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 02:27:11 -0700
Date:   Tue, 23 May 2023 12:27:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Steve Wahl <steve.wahl@hpe.com>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: ISST: Remove 8 socket limit
In-Reply-To: <20230519160420.2588475-1-steve.wahl@hpe.com>
Message-ID: <bf9a2943-f4eb-eb24-e18b-1b1c1959fe31@linux.intel.com>
References: <20230519160420.2588475-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1415302906-1684834032=:3565"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1415302906-1684834032=:3565
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 19 May 2023, Steve Wahl wrote:

> Stop restricting the PCI search to a range of PCI domains fed to
> pci_get_domain_bus_and_slot().  Instead, use for_each_pci_dev() and
> look at all PCI domains in one pass.
> 
> On systems with more than 8 sockets, this avoids error messages like
> "Information: Invalid level, Can't get TDP control information at
> specified levels on cpu 480" from the intel speed select utility.
> 
> Fixes: aa2ddd242572 ("platform/x86: ISST: Use numa node id for cpu pci dev mapping")
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  .../x86/intel/speed_select_if/isst_if_common.c       | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index e0572a29212e..02fe360a59c7 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -304,14 +304,13 @@ struct isst_if_pkg_info {
>  static struct isst_if_cpu_info *isst_cpu_info;
>  static struct isst_if_pkg_info *isst_pkg_info;
>  
> -#define ISST_MAX_PCI_DOMAINS	8
> -
>  static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
>  {
>  	struct pci_dev *matched_pci_dev = NULL;
>  	struct pci_dev *pci_dev = NULL;
> +	struct pci_dev *_pci_dev = NULL;
>  	int no_matches = 0, pkg_id;
> -	int i, bus_number;
> +	int bus_number;
>  
>  	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER || cpu < 0 ||
>  	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
> @@ -323,12 +322,11 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
>  	if (bus_number < 0)
>  		return NULL;
>  
> -	for (i = 0; i < ISST_MAX_PCI_DOMAINS; ++i) {
> -		struct pci_dev *_pci_dev;
> +	for_each_pci_dev(_pci_dev) {
>  		int node;
>  
> -		_pci_dev = pci_get_domain_bus_and_slot(i, bus_number, PCI_DEVFN(dev, fn));
> -		if (!_pci_dev)
> +		if (_pci_dev->bus->number != bus_number ||
> +		    _pci_dev->devfn != PCI_DEVFN(dev, fn))
>  			continue;
>  
>  		++no_matches;

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

With the note that _pci_dev is not a good variable name (but the rename 
would make this fix larger than it needs to be).

-- 
 i.

--8323329-1415302906-1684834032=:3565--
