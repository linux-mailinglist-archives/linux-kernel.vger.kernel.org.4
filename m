Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CAF73DCA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFZLAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFZLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:00:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9BDD1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:00:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f8775126d3so3955720e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687777202; x=1690369202;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G7sIG9mMWqnBSjmRGaB+tfEB5pMmkNJkQTNkwiFZC9I=;
        b=kOuezhJK6qeL7RdVK0EOMNMSwUCf02bEbVt9y7n+j9VvQxFcy4KlmXddXqoSEo9xXw
         Twj3oux1PDEvBM9/2TCSWUNNfx+Jh3sOhVwLSOMelasvm7JK/49oqOzkPnxvgR6rShTs
         fhqd/Xktl6up0HT/IZGAldUumnle4bP0IQQuCNi8ALDLsig7t5ycgbte5L4+CtorhH7T
         p5bEZMCRp91/Z9tD64QgcB61hKm42eeH0XdgZqedFbQpPzpzhZlkhSVtrnm8tHQzHOml
         eHqGP7Pt/3v8HP739ro4zjbQcottNhuEZWYU5Mi47yOjxN/p8n0bxh1Ks//kGturNmfr
         Ib2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687777202; x=1690369202;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7sIG9mMWqnBSjmRGaB+tfEB5pMmkNJkQTNkwiFZC9I=;
        b=gi4X4VA0rK0hNajBkOCEEyFn+wE5a4/Tnfa1RalO5he48xW9e9Mk85vFYkj6GiaHxd
         jZa3BsrzsdLkugzTPIAeR2Tw0f3zF0lzz86OqQKThv3hoNqV98ebv9+fkrryH4DmGTMc
         YqLm7HLfLOggERKT7khIUNsRFnH32FiCb14aSD4ngYHP7ui7gHoe3+NDqoto6RD2w+QQ
         cHl7S5d0NNody+9GhNHo13gp6lPy2NfPtQ6wTX/CqsSOOOUFp6YJRRKMuT79KIWr/ubx
         NRSdljPb7x8G++t+BpZUkKOIEDM8/kPylbOudVDs72CVzqQjZQ3L9VpkSQtYId7kycnY
         484A==
X-Gm-Message-State: AC+VfDyWVxSURnbmLvPRM/tCKGiPpSGaN2tvnyRfBvoQZx8cROvnjEtf
        +rXGy47zX7xe4muP5xffid+gXA==
X-Google-Smtp-Source: ACHHUZ4zYjhSY+qg0esWzswppt9V4YWWBAzQx43K/Cea8Dvc33slbb6+aW2ukojrhy6ftK1bsVxRaA==
X-Received: by 2002:a19:8c18:0:b0:4f4:fdb4:c76d with SMTP id o24-20020a198c18000000b004f4fdb4c76dmr18353746lfd.47.1687777202458;
        Mon, 26 Jun 2023 04:00:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003f604793989sm10065546wmj.18.2023.06.26.04.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 04:00:01 -0700 (PDT)
Date:   Mon, 26 Jun 2023 13:59:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Message-ID: <7ba59f01-57fe-4ad2-917a-0a199528b1f6@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620133711.22840-5-dwagner@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-fc-Do-not-wait-in-vain-when-unloading-module/20230620-213849
base:   linus/master
patch link:    https://lore.kernel.org/r/20230620133711.22840-5-dwagner%40suse.de
patch subject: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
config: openrisc-randconfig-m041-20230622 (https://download.01.org/0day-ci/archive/20230624/202306240125.U2jdrjAY-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230624/202306240125.U2jdrjAY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202306240125.U2jdrjAY-lkp@intel.com/

smatch warnings:
drivers/nvme/host/fc.c:3590 nvme_fc_init_ctrl() warn: passing zero to 'ERR_PTR'

vim +/ERR_PTR +3590 drivers/nvme/host/fc.c

61bff8ef008845 James Smart       2017-04-23  3533  	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, 0);
61bff8ef008845 James Smart       2017-04-23  3534  	if (ret)
98e3528012cd57 Ross Lagerwall    2023-01-20  3535  		goto out_free_queues;
e399441de9115c James Smart       2016-12-02  3536  
61bff8ef008845 James Smart       2017-04-23  3537  	/* at this point, teardown path changes to ref counting on nvme ctrl */
e399441de9115c James Smart       2016-12-02  3538  
98e3528012cd57 Ross Lagerwall    2023-01-20  3539  	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
98e3528012cd57 Ross Lagerwall    2023-01-20  3540  			&nvme_fc_admin_mq_ops,
98e3528012cd57 Ross Lagerwall    2023-01-20  3541  			struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
98e3528012cd57 Ross Lagerwall    2023-01-20  3542  				    ctrl->lport->ops->fcprqst_priv_sz));
98e3528012cd57 Ross Lagerwall    2023-01-20  3543  	if (ret)
98e3528012cd57 Ross Lagerwall    2023-01-20  3544  		goto fail_ctrl;
98e3528012cd57 Ross Lagerwall    2023-01-20  3545  
e399441de9115c James Smart       2016-12-02  3546  	spin_lock_irqsave(&rport->lock, flags);
e399441de9115c James Smart       2016-12-02  3547  	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
e399441de9115c James Smart       2016-12-02  3548  	spin_unlock_irqrestore(&rport->lock, flags);
e399441de9115c James Smart       2016-12-02  3549  
ac881fd1288ca6 Daniel Wagner     2023-06-20  3550  	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
4c984154efa131 James Smart       2018-06-13  3551  		dev_err(ctrl->ctrl.device,
4c984154efa131 James Smart       2018-06-13  3552  			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
4c984154efa131 James Smart       2018-06-13  3553  		goto fail_ctrl;

No error code on this path.  Originally it didn't matter because it was
hardcoded to return ERR_PTR(-EIO);

17c4dc6eb7e1b2 James Smart       2017-10-09  3554  	}
17c4dc6eb7e1b2 James Smart       2017-10-09  3555  
ac881fd1288ca6 Daniel Wagner     2023-06-20  3556  	ret = nvme_fc_create_association(ctrl);
ac881fd1288ca6 Daniel Wagner     2023-06-20  3557  	if (ret)
4c984154efa131 James Smart       2018-06-13  3558  		goto fail_ctrl;
4c984154efa131 James Smart       2018-06-13  3559  
4c984154efa131 James Smart       2018-06-13  3560  	dev_info(ctrl->ctrl.device,
4c984154efa131 James Smart       2018-06-13  3561  		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
e5ea42faa773c6 Hannes Reinecke   2021-09-22  3562  		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl));
4c984154efa131 James Smart       2018-06-13  3563  
4c984154efa131 James Smart       2018-06-13  3564  	return &ctrl->ctrl;
4c984154efa131 James Smart       2018-06-13  3565  
4c984154efa131 James Smart       2018-06-13  3566  fail_ctrl:
19fce0470f0503 James Smart       2020-12-01  3567  	cancel_work_sync(&ctrl->ioerr_work);
cf25809bec2c7d James Smart       2018-03-13  3568  	cancel_work_sync(&ctrl->ctrl.reset_work);
cf25809bec2c7d James Smart       2018-03-13  3569  	cancel_delayed_work_sync(&ctrl->connect_work);
cf25809bec2c7d James Smart       2018-03-13  3570  
de41447aac034c Ewan D. Milne     2017-04-24  3571  	ctrl->ctrl.opts = NULL;
17c4dc6eb7e1b2 James Smart       2017-10-09  3572  
61bff8ef008845 James Smart       2017-04-23  3573  	/* initiate nvme ctrl ref counting teardown */
e399441de9115c James Smart       2016-12-02  3574  	nvme_uninit_ctrl(&ctrl->ctrl);
61bff8ef008845 James Smart       2017-04-23  3575  
0b5a7669a457dd James Smart       2017-06-15  3576  	/* Remove core ctrl ref. */
0b5a7669a457dd James Smart       2017-06-15  3577  	nvme_put_ctrl(&ctrl->ctrl);
0b5a7669a457dd James Smart       2017-06-15  3578  
61bff8ef008845 James Smart       2017-04-23  3579  	/* as we're past the point where we transition to the ref
61bff8ef008845 James Smart       2017-04-23  3580  	 * counting teardown path, if we return a bad pointer here,
61bff8ef008845 James Smart       2017-04-23  3581  	 * the calling routine, thinking it's prior to the
61bff8ef008845 James Smart       2017-04-23  3582  	 * transition, will do an rport put. Since the teardown
61bff8ef008845 James Smart       2017-04-23  3583  	 * path also does a rport put, we do an extra get here to
61bff8ef008845 James Smart       2017-04-23  3584  	 * so proper order/teardown happens.
61bff8ef008845 James Smart       2017-04-23  3585  	 */
61bff8ef008845 James Smart       2017-04-23  3586  	nvme_fc_rport_get(rport);
61bff8ef008845 James Smart       2017-04-23  3587  
ac881fd1288ca6 Daniel Wagner     2023-06-20  3588  	if (ret > 0)
ac881fd1288ca6 Daniel Wagner     2023-06-20  3589  		ret = -EIO;
ac881fd1288ca6 Daniel Wagner     2023-06-20 @3590  	return ERR_PTR(ret);
e399441de9115c James Smart       2016-12-02  3591  
61bff8ef008845 James Smart       2017-04-23  3592  out_free_queues:
61bff8ef008845 James Smart       2017-04-23  3593  	kfree(ctrl->queues);
e399441de9115c James Smart       2016-12-02  3594  out_free_ida:
61bff8ef008845 James Smart       2017-04-23  3595  	put_device(ctrl->dev);
3dd83f4013f0e8 Sagi Grimberg     2022-02-14  3596  	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
e399441de9115c James Smart       2016-12-02  3597  out_free_ctrl:
e399441de9115c James Smart       2016-12-02  3598  	kfree(ctrl);
e399441de9115c James Smart       2016-12-02  3599  out_fail:
e399441de9115c James Smart       2016-12-02  3600  	/* exit via here doesn't follow ctlr ref points */
e399441de9115c James Smart       2016-12-02  3601  	return ERR_PTR(ret);
e399441de9115c James Smart       2016-12-02  3602  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

