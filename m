Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C022D6D8B00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjDEXOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjDEXOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:14:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E02F46B7;
        Wed,  5 Apr 2023 16:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680736475; x=1712272475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FKhsDwBgWocxbDBm71IX9YxYgh4XGnM3GUQYRhxeNgQ=;
  b=aH44hVKWcHMGqpaDDNa35ciWwmCvPRrv4RFYby3nVCcBMjRWuDBW6dXH
   nCY23xzlvqJRSXBqoRt17caMdlc6wXL2BGa75VZNyY7QlMJm/e0hCl/N5
   moit6dOkft1G4Ve1sVU3RLc1cO2REfBj8MC9iMbdnrsjbKwH/aexI4ztC
   9lPU2SdhQyp4CM926Fa2rNMOF4rdK4imPN77iwTi+Q8CYzzmXe0odW2wx
   5hDUKO0lDDyobVPByPXlIFao9lqFd7Z6NBQOvWsyQbK1codTxIeCWmIPF
   WwbKu46i0gX5+hWKcIH+Xebl9MUcrYOHOD4RT2eCmtNHUoMfyvgODf6Y8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="341318982"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="341318982"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 16:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="798099746"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="798099746"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2023 16:14:30 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkCKj-000QtT-0M;
        Wed, 05 Apr 2023 23:14:29 +0000
Date:   Thu, 6 Apr 2023 07:14:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v6 2/8] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <202304060712.gqBA4oqQ-lkp@intel.com>
References: <20230405125759.4201-3-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405125759.4201-3-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-linus]
[also build test WARNING on robh/for-next linus/master v6.3-rc5 next-20230405]
[cannot apply to usb/usb-testing usb/usb-next pza/reset/next pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Kurapati/dt-bindings-usb-Add-bindings-for-multiport-properties-on-DWC3-controller/20230405-210221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-linus
patch link:    https://lore.kernel.org/r/20230405125759.4201-3-quic_kriskura%40quicinc.com
patch subject: [PATCH v6 2/8] usb: dwc3: core: Access XHCI address space temporarily to read port info
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/a0de434ac81429422ecdf84fe968bd8c3f73445b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-Kurapati/dt-bindings-usb-Add-bindings-for-multiport-properties-on-DWC3-controller/20230405-210221
        git checkout a0de434ac81429422ecdf84fe968bd8c3f73445b
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304060712.gqBA4oqQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./drivers/usb/dwc3/core.h:1666: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

vim +1666 ./drivers/usb/dwc3/core.h

  1664	
  1665	/**
> 1666	 * Find the offset of the extended capabilities with capability ID id.
  1667	 *
  1668	 * @base	PCI MMIO registers base address.
  1669	 * @start	address at which to start looking, (0 or HCC_PARAMS to start at
  1670	 *		beginning of list)
  1671	 * @id		Extended capability ID to search for, or 0 for the next
  1672	 *		capability
  1673	 *
  1674	 * Returns the offset of the next matching extended capability structure.
  1675	 * Some capabilities can occur several times, e.g., the XHCI_EXT_CAPS_PROTOCOL,
  1676	 * and this provides a way to find them all.
  1677	 */
  1678	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
