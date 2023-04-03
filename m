Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D40B6D3D22
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjDCGLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDCGL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:11:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED178527F;
        Sun,  2 Apr 2023 23:11:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ew6so112626051edb.7;
        Sun, 02 Apr 2023 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680502284;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gP/NAOYyuv0YBnm/nFebw7X1khDfTArI7Js9IuJTeyU=;
        b=fvXEIW64HYGcT3RzfX5lo60MtOsOPf4xOlyaT5Gjcv1vp00oIq8IZAh0cE+M6bW0J5
         NeffADjSx/WOmYqJFZpwQNAnlk6zFOYrCgPClrSki0lXfMy46ipO3y5Tjjf54KsqQ8Uy
         L4QByAtRMfW9Z+iiUcNfeDykSOLXfzSrvhjeLucMZnlOLHTvWByptBAkzm5KoJaLdhm/
         tAHOl0RdryGwSxEBMPoDK/uYFuoQuUblB9xUQGmoQcU16PMebXbz++GN4X7PZw5AnCId
         VO05btGwwuoTAk0ESP/rAqMJDVDD2gXRPC3iB37eBC8GXAehDgLZgn0UyZ6xpS37A6jK
         KVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680502284;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gP/NAOYyuv0YBnm/nFebw7X1khDfTArI7Js9IuJTeyU=;
        b=iW/b8jGSgrVk0yPLL2GLfvhn1LtVWsijKg952KyMZ2MVmvFvJZAKNplzIOiJQy4ag7
         0pF4b4odVA8kHYorQC2J7UE39JwGZliF8cDYNd6mgFVUXQiSa5+zt53vmejNl95ANjvX
         t5r9Dwvtm2clrZQPlKEZnQKHPjf2fB+U38YkuiYmRSNagZTfwvjASwbgR8yWomS9EBmA
         ACn7pHG7QWQou0+4JGbv9dv2IweZR2RJY4v1QYm8H7gGyU6tZGRmbMIyVvhtVsg2tJLD
         w/DO4ehZXC7Z5ndbtGMFpIbaP6/J5/iixqUALdXfyMEMpBsdJOrxMploPo5xp/Xpt7kK
         x1Ww==
X-Gm-Message-State: AAQBX9einmhQNkQqkXo0AYb7Lo8290AACht1ImtFXpVRh5OJ6CNF0KPu
        ILGKpzUwC6zn7vMTJf3YeeI=
X-Google-Smtp-Source: AKy350Ye3LiLkSxBkKbzdxrTQTtUxqZAoBTleoqrk1A27MshnAmxLQ3Itn7a+kAQANDTvjUWfdBXFw==
X-Received: by 2002:a05:6402:d3:b0:4fa:e1fd:5a30 with SMTP id i19-20020a05640200d300b004fae1fd5a30mr34077597edu.19.1680502284345;
        Sun, 02 Apr 2023 23:11:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u23-20020a50d517000000b004af720b855fsm4062690edi.82.2023.04.02.23.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 23:11:23 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:11:11 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
Message-ID: <b5c43582-0a73-45ec-83c2-8c1bfd2af2a2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331074650.75-1-avri.altman@wdc.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Avri-Altman/scsi-ufs-mcq-Limit-the-amount-of-inflight-requests/20230331-155149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230331074650.75-1-avri.altman%40wdc.com
patch subject: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
config: parisc-randconfig-m031-20230329 (https://download.01.org/0day-ci/archive/20230401/202304011340.ltlHYazS-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304011340.ltlHYazS-lkp@intel.com/

New smatch warnings:
drivers/ufs/core/ufshcd.c:8473 ufshcd_alloc_mcq() warn: missing error code 'ret'

Old smatch warnings:
drivers/ufs/core/ufshcd.c:5412 ufshcd_uic_cmd_compl() error: we previously assumed 'hba->active_uic_cmd' could be null (see line 5400)
drivers/ufs/core/ufshcd.c:2350 ufshcd_hba_capabilities() warn: missing error code? 'err'

vim +/ret +8473 drivers/ufs/core/ufshcd.c

57b1c0ef89ac9d drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8457  static int ufshcd_alloc_mcq(struct ufs_hba *hba)
57b1c0ef89ac9d drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8458  {
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8459  	int ret;
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8460  	int old_nutrs = hba->nutrs;
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8461  
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8462  	ret = ufshcd_mcq_decide_queue_depth(hba);
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8463  	if (ret < 0)
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8464  		return ret;
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8465  
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8466  	hba->nutrs = ret;
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8467  	ret = ufshcd_mcq_init(hba);
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8468  	if (ret)
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8469  		goto err;
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8470  
2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31  8471  	if (hba->nutrs * hba->nr_hw_queues > SZ_64K - 1) {
2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31  8472  		dev_info(hba->dev, "there can be at most 64K inflight requests\n");
2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31 @8473  		goto err;

ret = -EINVAL;

2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31  8474  	}
2580a95e61d461 drivers/ufs/core/ufshcd.c Avri Altman   2023-03-31  8475  
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8476  	/*
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8477  	 * Previously allocated memory for nutrs may not be enough in MCQ mode.
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8478  	 * Number of supported tags in MCQ mode may be larger than SDB mode.
6ccf44fe4cd7c4 drivers/scsi/ufs/ufshcd.c Seungwon Jeon 2013-06-26  8479  	 */
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8480  	if (hba->nutrs != old_nutrs) {
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8481  		ufshcd_release_sdb_queue(hba, old_nutrs);
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8482  		ret = ufshcd_memory_alloc(hba);
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8483  		if (ret)
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8484  			goto err;
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8485  		ufshcd_host_memory_configure(hba);
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8486  	}
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8487  
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8488  	ret = ufshcd_mcq_memory_alloc(hba);
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8489  	if (ret)
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8490  		goto err;
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8491  
7224c806876e46 drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8492  	return 0;
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8493  err:
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8494  	hba->nutrs = old_nutrs;
4682abfae2eb3a drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8495  	return ret;
57b1c0ef89ac9d drivers/ufs/core/ufshcd.c Asutosh Das   2023-01-13  8496  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

