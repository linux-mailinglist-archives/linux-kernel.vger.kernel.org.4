Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323006558DD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 08:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiLXHQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 02:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiLXHQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:16:24 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3EB1057B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 23:16:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so1964541wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 23:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0xEaWb1QFqz30tR9hsZPX6l+DNnz+1joNCdgOk1pog=;
        b=UH5i0oxkeGlU0ZE/vb5tfYeOuPbWJzNSgYvMEEMe+bzpoD7xrczI1FUyvSVIUSz0u1
         X6mEe+u+CmWfdYE42QG4V1v+8NM/UE1K2HBCwuEOeyl90WYeIhV+tdAQBRu7POVp1IBO
         6sCDwk9u4+BXSA4jTNE9rE2u/9rXjHA2/iUmPcdo2w3Jpuzs4n71e4wK9jkNzQ6jC5Dr
         /QTmM+wQsnyGioCL0zee8Rh11MAo0yytpolqjYURwHXSQ45p+SDm5CmiH090RWofT63q
         F9EBpuO5F3zn2Cs8c8KGNFkFZCEim6eNJXU4t1TvlTFTxWSjqb6CDsirNg2DLkfkRe8b
         QBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0xEaWb1QFqz30tR9hsZPX6l+DNnz+1joNCdgOk1pog=;
        b=lJO69SEcH+9/M0CJ7HPYvkIcRpKFfufvDs5AdA5ppjMzpLQ/sIqqGnpT98I6nEDKAj
         JI3HIUzDwLn4nI6aZcYd22mI7E3pnMxlb8oicg/hHLvyOX0VPkjawgETzxKgcW9MJ8HT
         MYvDMuR1Z6hYh/7MohYMUPIBPt0O3OTkYn/m1ixd+KTD5GeW7bGzxYNR0FjkEfA1Leoc
         2IUJR+hMGIm2G7vz8hNJ0M4YrXPbKXRdDTV/MAZYLqUHFJpCw3a7SmnVf/+kPhZiaAAx
         GUw9V6LV1AQPKkKuRx4uKlFrv+435XxsiRqTd7K19SZRhXkRzdCRCBZh8bOm8avXYsOK
         KtDw==
X-Gm-Message-State: AFqh2krGORAGYlZvCkkkfcjMdO2/mCqtQxRdFnslI2iw576ryzwKhkOu
        LW1a1txIS5T7ePrJ0i8d9RU=
X-Google-Smtp-Source: AMrXdXuNYK66ATjSvdIDZHbYxPCE412gXGNQorJFHPaaAHb0SWbSzkK0Qm0TAxBCnEiX0XBWupV0rA==
X-Received: by 2002:a05:600c:601b:b0:3d3:56ce:5693 with SMTP id az27-20020a05600c601b00b003d356ce5693mr8796372wmb.17.1671866171895;
        Fri, 23 Dec 2022 23:16:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003cfd4e6400csm7277105wms.19.2022.12.23.23.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 23:16:11 -0800 (PST)
Date:   Sat, 24 Dec 2022 10:16:08 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v5 3/6] coresight: configfs: Add in binary attributes to
 load files
Message-ID: <202212240621.sgsPYIdK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219234638.3661-4-mike.leach@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Leach/coresight-syscfg-Extend-configfs-for-config-load/20221220-074850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20221219234638.3661-4-mike.leach%40linaro.org
patch subject: [PATCH v5 3/6] coresight: configfs: Add in binary attributes to load files
config: arm-randconfig-m041-20221218
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/hwtracing/coresight/coresight-syscfg-configfs.c:595 cscfg_cfg_load_write() warn: possible memory leak of 'load_descs'

vim +/load_descs +595 drivers/hwtracing/coresight/coresight-syscfg-configfs.c

97b8fd654556b1 Mike Leach 2022-12-19  543  static ssize_t cscfg_cfg_load_write(struct config_item *item, const void *buffer, size_t size)
97b8fd654556b1 Mike Leach 2022-12-19  544  {
97b8fd654556b1 Mike Leach 2022-12-19  545  	struct cscfg_fs_load_descs *load_descs = 0;
97b8fd654556b1 Mike Leach 2022-12-19  546  	struct cscfg_load_owner_info *owner_info = 0;
97b8fd654556b1 Mike Leach 2022-12-19  547  	int err = 0;
97b8fd654556b1 Mike Leach 2022-12-19  548  
97b8fd654556b1 Mike Leach 2022-12-19  549  	/* ensure we cannot simultaneously load and unload */
97b8fd654556b1 Mike Leach 2022-12-19  550  	if (!mutex_trylock(&cfs_mutex))
97b8fd654556b1 Mike Leach 2022-12-19  551  		return -EBUSY;
97b8fd654556b1 Mike Leach 2022-12-19  552  
97b8fd654556b1 Mike Leach 2022-12-19  553  	/* check configfs load / unload ops are permitted */
97b8fd654556b1 Mike Leach 2022-12-19  554  	if (!cscfg_fs_load_enabled || unload_owner_info) {
97b8fd654556b1 Mike Leach 2022-12-19  555  		err = -EBUSY;
97b8fd654556b1 Mike Leach 2022-12-19  556  		goto exit_unlock;
97b8fd654556b1 Mike Leach 2022-12-19  557  	}
97b8fd654556b1 Mike Leach 2022-12-19  558  
97b8fd654556b1 Mike Leach 2022-12-19  559  	if (size > CSCFG_FILE_MAXSIZE) {
97b8fd654556b1 Mike Leach 2022-12-19  560  		pr_err("cscfg: Load error - Input file too large.\n");
97b8fd654556b1 Mike Leach 2022-12-19  561  		err = -EINVAL;
97b8fd654556b1 Mike Leach 2022-12-19  562  		goto exit_unlock;
97b8fd654556b1 Mike Leach 2022-12-19  563  	}
97b8fd654556b1 Mike Leach 2022-12-19  564  
97b8fd654556b1 Mike Leach 2022-12-19  565  	load_descs = kzalloc(sizeof(struct cscfg_fs_load_descs), GFP_KERNEL);
97b8fd654556b1 Mike Leach 2022-12-19  566  	owner_info = kzalloc(sizeof(struct cscfg_load_owner_info), GFP_KERNEL);
97b8fd654556b1 Mike Leach 2022-12-19  567  	if (!load_descs || !owner_info) {
97b8fd654556b1 Mike Leach 2022-12-19  568  		err = -ENOMEM;
97b8fd654556b1 Mike Leach 2022-12-19  569  		goto exit_memfree;

This exit leaks (will never happen in real life though).

97b8fd654556b1 Mike Leach 2022-12-19  570  	}
97b8fd654556b1 Mike Leach 2022-12-19  571  
97b8fd654556b1 Mike Leach 2022-12-19  572  	owner_info->owner_handle = load_descs;
97b8fd654556b1 Mike Leach 2022-12-19  573  	owner_info->type = CSCFG_OWNER_CONFIGFS;
97b8fd654556b1 Mike Leach 2022-12-19  574  
97b8fd654556b1 Mike Leach 2022-12-19  575  	err = cscfg_file_read_buffer(buffer, size, load_descs);
97b8fd654556b1 Mike Leach 2022-12-19  576  	if (err) {
97b8fd654556b1 Mike Leach 2022-12-19  577  		pr_err("cscfg: Load error - Failed to read input file.\n");
97b8fd654556b1 Mike Leach 2022-12-19  578  		goto exit_memfree;
97b8fd654556b1 Mike Leach 2022-12-19  579  	}
97b8fd654556b1 Mike Leach 2022-12-19  580  
97b8fd654556b1 Mike Leach 2022-12-19  581  	err = cscfg_load_config_sets(load_descs->config_descs, load_descs->feat_descs, owner_info);
97b8fd654556b1 Mike Leach 2022-12-19  582  	if (err) {
97b8fd654556b1 Mike Leach 2022-12-19  583  		pr_err("cscfg: Load error - Failed to load configuaration file.\n");
97b8fd654556b1 Mike Leach 2022-12-19  584  		goto exit_memfree;
97b8fd654556b1 Mike Leach 2022-12-19  585  	}
97b8fd654556b1 Mike Leach 2022-12-19  586  
97b8fd654556b1 Mike Leach 2022-12-19  587  	mutex_unlock(&cfs_mutex);
97b8fd654556b1 Mike Leach 2022-12-19  588  	return size;
97b8fd654556b1 Mike Leach 2022-12-19  589  
97b8fd654556b1 Mike Leach 2022-12-19  590  exit_memfree:
97b8fd654556b1 Mike Leach 2022-12-19  591  	cscfg_configfs_free_owner_info(owner_info);
97b8fd654556b1 Mike Leach 2022-12-19  592  
97b8fd654556b1 Mike Leach 2022-12-19  593  exit_unlock:
97b8fd654556b1 Mike Leach 2022-12-19  594  	mutex_unlock(&cfs_mutex);
97b8fd654556b1 Mike Leach 2022-12-19 @595  	return err;
97b8fd654556b1 Mike Leach 2022-12-19  596  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

