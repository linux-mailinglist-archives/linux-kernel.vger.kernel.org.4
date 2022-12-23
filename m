Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EBC654F68
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiLWLDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWLDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:03:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9195F7C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:03:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y16so4272342wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvYvXobQ+Ky3hqmyTPit8ouaMYhq1ZZFDys9+K2SpT8=;
        b=m5i+tXbswj3gQWymnBrVrFXUbgdHhHSzjX2wl3SZKz1JMnKthqpyZ7h1NdVwmJy0IZ
         fyU6zfXrGruDte6Q4y8ESLR6q9CbV7OnrENIfOM5m0sYuHufVNXutX0oT+Nui8I+J0+O
         3fid+z7FxSfYqiU6DB/e/qXskENP2MfuC5EyCYdbYC+xWqKFU8n/k0ljCJVw3Mu1l3+r
         bNXHc8WtI4D3/UFPJns24TA73EhccdZOE98EyiXZ7Jeo4S3bw8CMntY+G/ORucMZ8vis
         ayr1QOvINIk2qseILiXGPNMZ6dP8lUvM6JM1SOzutS57teSmT6HAfxpcG0thVL6HrcYf
         k10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvYvXobQ+Ky3hqmyTPit8ouaMYhq1ZZFDys9+K2SpT8=;
        b=qBdvnJ+xb83C3tbQ6sodlNhQ8vNVDx/fL/BMtVFRxCtDrFP0JExcVMsCnlu5qqlHb9
         8XlFLKwUj7jw8uMzVQXga2Z9D/UcHSrWqdgpPguIRL2TGDU77EBZTnpxl0R+oJ+/pNUS
         kBSW4x389vwh+jlx9GG4vNzz8yp+P4/Y4iK386VHSZeZKcnTGXwNWbXvtFPh/Z8phL7I
         M/VjSNiO1XOJvo3k7mxOnodH18F8YcVlNXaMWV4OMKYXl77P/+KjTgHbuRmywFWnjmEm
         NU41PgU7pafzACbumbm6mTLhiSaYnq4sKRNf4rux5XdjyCl2T4oz7hjd2sVishcyOegt
         BDtg==
X-Gm-Message-State: AFqh2kowPAmVJ5c71kVoUlGAYhTKss4WpsRSiGPeU00J+jhs1ItuisYA
        1lPRUVwjQWDQhspgvO/BICs=
X-Google-Smtp-Source: AMrXdXslk5QScMgjYn9aeyWXDO0SBZSzPBTXvCA9H9+GU993tZtuAjoWFjDuKR3HHsBEm5KDvuEikg==
X-Received: by 2002:adf:ef8f:0:b0:242:7491:3be0 with SMTP id d15-20020adfef8f000000b0024274913be0mr7605133wro.67.1671793418749;
        Fri, 23 Dec 2022 03:03:38 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b00236883f2f5csm2816167wrq.94.2022.12.23.03.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 03:03:38 -0800 (PST)
Date:   Fri, 23 Dec 2022 14:03:34 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: drivers/nvme/host/auth.c:950 nvme_auth_init_ctrl() warn: missing
 error code? 'ret'
Message-ID: <202212222333.vrYfUBqM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
commit: aa36d711e945e65fa87410927800f01878a8faed nvme-auth: convert dhchap_auth_list to an array
config: i386-randconfig-m021-20221219
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/nvme/host/auth.c:950 nvme_auth_init_ctrl() warn: missing error code? 'ret'

vim +/ret +950 drivers/nvme/host/auth.c

193a8c7e5f1a84 Sagi Grimberg   2022-11-13  931  int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
f50fff73d620cd Hannes Reinecke 2022-06-27  932  {
aa36d711e945e6 Sagi Grimberg   2022-11-13  933  	struct nvme_dhchap_queue_context *chap;
aa36d711e945e6 Sagi Grimberg   2022-11-13  934  	int i, ret;
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  935  
f50fff73d620cd Hannes Reinecke 2022-06-27  936  	mutex_init(&ctrl->dhchap_auth_mutex);
aa36d711e945e6 Sagi Grimberg   2022-11-13  937  	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
f50fff73d620cd Hannes Reinecke 2022-06-27  938  	if (!ctrl->opts)
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  939  		return 0;
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  940  	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  941  			&ctrl->host_key);
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  942  	if (ret)
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  943  		return ret;
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  944  	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  945  			&ctrl->ctrl_key);
aa36d711e945e6 Sagi Grimberg   2022-11-13  946  	if (ret)
aa36d711e945e6 Sagi Grimberg   2022-11-13  947  		goto err_free_dhchap_secret;
aa36d711e945e6 Sagi Grimberg   2022-11-13  948  
aa36d711e945e6 Sagi Grimberg   2022-11-13  949  	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
aa36d711e945e6 Sagi Grimberg   2022-11-13 @950  		return ret;

Please return a literal here.  Either return -EINVAL or return 0;

aa36d711e945e6 Sagi Grimberg   2022-11-13  951  
aa36d711e945e6 Sagi Grimberg   2022-11-13  952  	ctrl->dhchap_ctxs = kvcalloc(ctrl_max_dhchaps(ctrl),
aa36d711e945e6 Sagi Grimberg   2022-11-13  953  				sizeof(*chap), GFP_KERNEL);
aa36d711e945e6 Sagi Grimberg   2022-11-13  954  	if (!ctrl->dhchap_ctxs) {
aa36d711e945e6 Sagi Grimberg   2022-11-13  955  		ret = -ENOMEM;
aa36d711e945e6 Sagi Grimberg   2022-11-13  956  		goto err_free_dhchap_ctrl_secret;
aa36d711e945e6 Sagi Grimberg   2022-11-13  957  	}
aa36d711e945e6 Sagi Grimberg   2022-11-13  958  
aa36d711e945e6 Sagi Grimberg   2022-11-13  959  	for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
aa36d711e945e6 Sagi Grimberg   2022-11-13  960  		chap = &ctrl->dhchap_ctxs[i];
aa36d711e945e6 Sagi Grimberg   2022-11-13  961  		chap->qid = i;
aa36d711e945e6 Sagi Grimberg   2022-11-13  962  		chap->ctrl = ctrl;
aa36d711e945e6 Sagi Grimberg   2022-11-13  963  		INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
aa36d711e945e6 Sagi Grimberg   2022-11-13  964  	}
aa36d711e945e6 Sagi Grimberg   2022-11-13  965  
aa36d711e945e6 Sagi Grimberg   2022-11-13  966  	return 0;
aa36d711e945e6 Sagi Grimberg   2022-11-13  967  err_free_dhchap_ctrl_secret:
aa36d711e945e6 Sagi Grimberg   2022-11-13  968  	nvme_auth_free_key(ctrl->ctrl_key);
aa36d711e945e6 Sagi Grimberg   2022-11-13  969  	ctrl->ctrl_key = NULL;
aa36d711e945e6 Sagi Grimberg   2022-11-13  970  err_free_dhchap_secret:
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  971  	nvme_auth_free_key(ctrl->host_key);
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  972  	ctrl->host_key = NULL;
193a8c7e5f1a84 Sagi Grimberg   2022-11-13  973  	return ret;
f50fff73d620cd Hannes Reinecke 2022-06-27  974  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

