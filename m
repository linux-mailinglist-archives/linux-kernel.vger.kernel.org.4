Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE26EC73B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjDXHgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDXHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:35:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194E10F5;
        Mon, 24 Apr 2023 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682321745; x=1713857745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1AZevgGbr+OhBwy7Vz/7+7ZqgeucWBUr7uEJu+d9I1k=;
  b=SlXKV7XKFG9C4Id2wQL3eHQb0gEkiTSths0RBcNr21kWikK/Hheu0arx
   QrU7MseB35BnJyuawrPhxacI/1eVvveGT6p/6rguKZ7K737gdIPq/3C5x
   lzPNzddfuJLy+S84uk8Yd1wTvg71G463yWhRW5Er2RlkjHlwHsTa9tYQe
   dbcew25va6x3cyTMMbHlPU5v3z3KkVKXSvlcoAGzsLIb0d5BBvrypQ/bs
   TBnIO/XRDXdgrYdWgp0ycgJdzQw9TBNk/m2W0OkMlMM3QOqkivQmbSL3k
   FqYTOV/0KLi9jDAESbghlZCR4ZI4OlVnRiBZ9cIaHuo2EmKtG4yIG7lb/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="409318145"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="409318145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 00:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="836859965"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="836859965"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2023 00:35:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqqjd-000iJs-1a;
        Mon, 24 Apr 2023 07:35:41 +0000
Date:   Mon, 24 Apr 2023 15:35:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, mani@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, quic_srichara@quicinc.com,
        quic_mdalam@quicinc.com
Subject: Re: [PATCH V2] mtd: rawnand: qcom: Implement exec_op()
Message-ID: <202304241556.fafzkLLk-lkp@intel.com>
References: <20230419093617.27134-1-quic_mdalam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419093617.27134-1-quic_mdalam@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on linus/master v6.3 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Sadre-Alam/mtd-rawnand-qcom-Implement-exec_op/20230419-173849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20230419093617.27134-1-quic_mdalam%40quicinc.com
patch subject: [PATCH V2] mtd: rawnand: qcom: Implement exec_op()
config: nios2-randconfig-m041-20230423 (https://download.01.org/0day-ci/archive/20230424/202304241556.fafzkLLk-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304241556.fafzkLLk-lkp@intel.com/

smatch warnings:
drivers/mtd/nand/raw/qcom_nandc.c:2751 qcom_read_status_exec() warn: inconsistent indenting

vim +2751 drivers/mtd/nand/raw/qcom_nandc.c

  2708	
  2709	static int qcom_read_status_exec(struct nand_chip *chip,
  2710					 const struct nand_subop *subop)
  2711	{
  2712		struct qcom_nand_host *host = to_qcom_nand_host(chip);
  2713		struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
  2714		struct nand_ecc_ctrl *ecc = &chip->ecc;
  2715		struct qcom_op q_op;
  2716		const struct nand_op_instr *instr = NULL;
  2717		unsigned int op_id = 0;
  2718		unsigned int len = 0;
  2719		int ret = 0, num_cw = 1, i;
  2720		u32 flash_status;
  2721	
  2722		host->status = NAND_STATUS_READY | NAND_STATUS_WP;
  2723	
  2724		qcom_parse_instructions(chip, subop, &q_op);
  2725	
  2726		if (nandc->exec_opwrite) {
  2727			num_cw = ecc->steps;
  2728			nandc->exec_opwrite = false;
  2729		}
  2730	
  2731		pre_command(host, NAND_CMD_STATUS);
  2732	
  2733		nandc_set_reg(chip, NAND_FLASH_CMD, q_op.cmd_reg);
  2734		nandc_set_reg(chip, NAND_EXEC_CMD, 1);
  2735	
  2736		write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
  2737		write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
  2738	
  2739		read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
  2740	
  2741		ret = submit_descs(nandc);
  2742		if (ret)
  2743			dev_err(nandc->dev, "failure in sbumitting status descriptor\n");
  2744	
  2745		free_descs(nandc);
  2746	
  2747		nandc_read_buffer_sync(nandc, true);
  2748		for (i = 0; i < num_cw; i++) {
  2749			flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
  2750	
> 2751		if (flash_status & FS_MPU_ERR)
  2752			host->status &= ~NAND_STATUS_WP;
  2753	
  2754		if (flash_status & FS_OP_ERR || (i == (num_cw - 1) &&
  2755						 (flash_status & FS_DEVICE_STS_ERR)))
  2756			host->status |= NAND_STATUS_FAIL;
  2757		}
  2758	
  2759		flash_status = host->status;
  2760	
  2761		instr = q_op.data_instr;
  2762		op_id = q_op.data_instr_idx;
  2763		len = nand_subop_get_data_len(subop, op_id);
  2764		memcpy(instr->ctx.data.buf.in, &flash_status, len);
  2765	
  2766		return ret;
  2767	}
  2768	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
