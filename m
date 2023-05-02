Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A286F43E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjEBM2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjEBM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:28:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0912C;
        Tue,  2 May 2023 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683030510; x=1714566510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pVyqURKJmfYfAEdHqOhsTYfJHIgtzPIa63rM74G0UvM=;
  b=Xy5QnxD/f8vrtHbq3UvFrdSlUlSL8vrbwhWGUJ3NaBkMJphVtAq4pPed
   QZrOEkLTfupbCcyvDYapJoS+HUyu1IqvjokweM1Y9UWgwG+kBTCqi7oOV
   9BcqkvjjLtU4TheBddpgZeH3bpohTyb+rA9bX/btQZ8aey2qmZNT6W/Mo
   KhrAWIQdCrz+qMzdhi6r1Yg8ho8T0LOQF70IbAqyJZN2mWQzWINcZZPM3
   Kirm996jwa+k3Vbvovvjx+cNJD9//OYDjKi8QIOX8tbvV3qOinrePcdok
   4pwrunEnLH+9jRQ4hSFxGBekfDwXDbXp+jXtmSxSB78lK0ZqGx/wpyPM4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="413825454"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="413825454"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 05:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="840277781"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="840277781"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 May 2023 05:28:24 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptp7H-00012g-1B;
        Tue, 02 May 2023 12:28:23 +0000
Date:   Tue, 2 May 2023 20:27:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        quic_harshq@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v7 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <202305022053.Tqtl2ROK-lkp@intel.com>
References: <20230501143445.3851-4-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501143445.3851-4-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master next-20230428]
[cannot apply to robh/for-next v6.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Kurapati/dt-bindings-usb-qcom-dwc3-Add-bindings-for-SC8280-Multiport/20230501-224209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230501143445.3851-4-quic_kriskura%40quicinc.com
patch subject: [PATCH v7 3/9] usb: dwc3: core: Access XHCI address space temporarily to read port info
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/840e9a485800cf72e5fbf4dca1aaf92085aad584
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-Kurapati/dt-bindings-usb-qcom-dwc3-Add-bindings-for-SC8280-Multiport/20230501-224209
        git checkout 840e9a485800cf72e5fbf4dca1aaf92085aad584
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305022053.Tqtl2ROK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/driver-api/usb/dwc3:687: ./drivers/usb/dwc3/core.h:1674: WARNING: Unexpected indentation.
>> Documentation/driver-api/usb/dwc3:687: ./drivers/usb/dwc3/core.h:1675: WARNING: Block quote ends without a blank line; unexpected unindent.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
