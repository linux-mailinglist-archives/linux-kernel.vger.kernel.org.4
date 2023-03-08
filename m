Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CD46AFDFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 05:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCHEqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 23:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCHEqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 23:46:43 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED1A2F38;
        Tue,  7 Mar 2023 20:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678250801; x=1709786801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QcAdQ6QzcChdpvESziFs8Z8K0GlMk1y8BSQSURRc0Bo=;
  b=JfMUtXcdO29exUBkWdSyLz91AjK+BVy4+dCGB6odsScuSkpQLXOKMMPq
   cvr0niLvBXAZplQDKTWxFZxZwZlhQ/5EvTLn/AvSFDOo7EAULJZFK0rRx
   eIBbMLWMW+lyse+cgI0vLX+SMT+aZZUPtuhdgRnlMkZ3VlxVj3sy/t+gh
   apKSXrHek2mDBLz8w+4/FdjVcR+DziGfsBr1O5vF3B+TyiqSDpPtM1+XJ
   0RxeCfqf8Hs2ZLgLWJua49TJNm/+PXSrsnT26Nz77T53dZ21q/XZOiw9X
   E+eY/gzy23HGdTBnOl2FW1bbaS7kCrp0pGu199OD7Pi2raE441biGo5l6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="316458534"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="316458534"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 20:46:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="800624035"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="800624035"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2023 20:46:36 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZlhD-0001sx-1S;
        Wed, 08 Mar 2023 04:46:35 +0000
Date:   Wed, 8 Mar 2023 12:45:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Gokul Krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH v2 4/7] soc: qcom: mdt_loader: Enhance split binary
 detection
Message-ID: <202303081259.uohZV4ZE-lkp@intel.com>
References: <20230306231202.12223-5-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306231202.12223-5-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Melody,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dc837c1a5137a8cf2e9432c1891392b6a66f4d8d]

url:    https://github.com/intel-lab-lkp/linux/commits/Melody-Olvera/dt-bindings-firmware-qcom-scm-Update-QDU1000-QRU1000-compatible/20230307-071438
base:   dc837c1a5137a8cf2e9432c1891392b6a66f4d8d
patch link:    https://lore.kernel.org/r/20230306231202.12223-5-quic_molvera%40quicinc.com
patch subject: [PATCH v2 4/7] soc: qcom: mdt_loader: Enhance split binary detection
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230308/202303081259.uohZV4ZE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3964310160b68a6246f85828ecbcebf1fb9137a7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Melody-Olvera/dt-bindings-firmware-qcom-scm-Update-QDU1000-QRU1000-compatible/20230307-071438
        git checkout 3964310160b68a6246f85828ecbcebf1fb9137a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303081259.uohZV4ZE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/qcom/mdt_loader.c: In function 'qcom_mdt_read_metadata':
>> drivers/soc/qcom/mdt_loader.c:156:17: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     156 |         ssize_t ret;
         |                 ^~~


vim +/ret +156 drivers/soc/qcom/mdt_loader.c

051fb70fd4ea40f drivers/remoteproc/qcom_mdt_loader.c Bjorn Andersson            2016-06-20  126  
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  127  /**
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  128   * qcom_mdt_read_metadata() - read header and metadata from mdt or mbn
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  129   * @fw:		firmware of mdt header or mbn
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  130   * @data_len:	length of the read metadata blob
d11a34a404ee556 drivers/soc/qcom/mdt_loader.c        Krzysztof Kozlowski        2022-05-19  131   * @fw_name:	name of the firmware, for construction of segment file names
d11a34a404ee556 drivers/soc/qcom/mdt_loader.c        Krzysztof Kozlowski        2022-05-19  132   * @dev:	device handle to associate resources with
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  133   *
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  134   * The mechanism that performs the authentication of the loading firmware
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  135   * expects an ELF header directly followed by the segment of hashes, with no
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  136   * padding inbetween. This function allocates a chunk of memory for this pair
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  137   * and copy the two pieces into the buffer.
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  138   *
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  139   * In the case of split firmware the hash is found directly following the ELF
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  140   * header, rather than at p_offset described by the second program header.
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  141   *
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  142   * The caller is responsible to free (kfree()) the returned pointer.
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  143   *
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  144   * Return: pointer to data, or ERR_PTR()
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  145   */
8bd42e2341a7857 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  146  void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
8bd42e2341a7857 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  147  			     const char *fw_name, struct device *dev)
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  148  {
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  149  	const struct elf32_phdr *phdrs;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  150  	const struct elf32_hdr *ehdr;
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  151  	unsigned int hash_segment = 0;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  152  	size_t hash_offset;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  153  	size_t hash_size;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  154  	size_t ehdr_size;
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  155  	unsigned int i;
8bd42e2341a7857 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27 @156  	ssize_t ret;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  157  	void *data;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  158  
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  159  	ehdr = (struct elf32_hdr *)fw->data;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  160  	phdrs = (struct elf32_phdr *)(ehdr + 1);
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  161  
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  162  	if (ehdr->e_phnum < 2)
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  163  		return ERR_PTR(-EINVAL);
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  164  
833d51d7c66d670 drivers/soc/qcom/mdt_loader.c        Shawn Guo                  2021-08-28  165  	if (phdrs[0].p_type == PT_LOAD)
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  166  		return ERR_PTR(-EINVAL);
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  167  
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  168  	for (i = 1; i < ehdr->e_phnum; i++) {
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  169  		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  170  			hash_segment = i;
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  171  			break;
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  172  		}
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  173  	}
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  174  
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  175  	if (!hash_segment) {
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  176  		dev_err(dev, "no hash segment found in %s\n", fw_name);
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  177  		return ERR_PTR(-EINVAL);
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  178  	}
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  179  
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  180  	ehdr_size = phdrs[0].p_filesz;
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  181  	hash_size = phdrs[hash_segment].p_filesz;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  182  
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  183  	data = kmalloc(ehdr_size + hash_size, GFP_KERNEL);
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  184  	if (!data)
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  185  		return ERR_PTR(-ENOMEM);
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  186  
8bd42e2341a7857 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  187  	/* Copy ELF header */
8bd42e2341a7857 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  188  	memcpy(data, fw->data, ehdr_size);
8bd42e2341a7857 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  189  
3964310160b68a6 drivers/soc/qcom/mdt_loader.c        Gokul Krishna Krishnakumar 2023-03-06  190  
3964310160b68a6 drivers/soc/qcom/mdt_loader.c        Gokul Krishna Krishnakumar 2023-03-06  191  	if (qcom_mdt_bins_are_split(fw)) {
3964310160b68a6 drivers/soc/qcom/mdt_loader.c        Gokul Krishna Krishnakumar 2023-03-06  192  		ret = mdt_load_split_segment(data + ehdr_size, phdrs, hash_segment, fw_name, dev);
3964310160b68a6 drivers/soc/qcom/mdt_loader.c        Gokul Krishna Krishnakumar 2023-03-06  193  	} else {
64fb5eb87d5815f drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  194  		hash_offset = phdrs[hash_segment].p_offset;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  195  		memcpy(data + ehdr_size, fw->data + hash_offset, hash_size);
8bd42e2341a7857 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2022-01-27  196  	}
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  197  	*data_len = ehdr_size + hash_size;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  198  
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  199  	return data;
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  200  }
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  201  EXPORT_SYMBOL_GPL(qcom_mdt_read_metadata);
498b98e939007f8 drivers/soc/qcom/mdt_loader.c        Bjorn Andersson            2019-06-21  202  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
