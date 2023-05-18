Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993B8708069
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjERLvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjERLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:51:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1443590
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:50:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so13442265e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684410643; x=1687002643;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GbFMPjUFF9uuaXdP1MBvbLG15PgOtEOYz2afufGOGY=;
        b=ZyycZsK+W7vqKI/wajkBrmb/IKov5NEyGA5ouG/8DGclQF038y5DfFqsrTMB+s4fkr
         eUGu+Ty4MdnljIQAFZHjHlNj5slsxBed0cCB2uYNy+OMtI6nCu9EW6DI1l5AikSkH83j
         TFtIKlbT4Ngy4x1gS3WQ4N72Pf+MZUIEmW29/lCRvFkn6rUUjaKXF0hV+hXaT/JGoCzz
         nDOwhQrTzZwqw0r09ybNpIqPF5gzKuwopKPShlBduTJtb02FvXh0PizifEpErC/5pnHt
         Ney4bxUFVy45qSHTUHoHiQY0XE+FMUjrlyCjmTiXDsnXsq0o/gcleEFBM5B1FlyfZi1x
         qe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684410643; x=1687002643;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GbFMPjUFF9uuaXdP1MBvbLG15PgOtEOYz2afufGOGY=;
        b=gsJBmCcPrje7fnv8b6FbDRz7U1nxA8grpjWwZNBa7Bkfrz7AyL7EL3w4uBY1MCP5ko
         /dQX7c0Wv9u46ndmw2IJfJ65JQiy8v3OgElWCI9taDPrrSwWBHj6TE1l5EnHwG3inP9v
         eBs6dIDqKLVDdKikUINF33swzNaINB12Xz3JL/TkzhfkhDDN+xwIl9l9KL1b+3Ndxg3K
         /PBznEdN2HGwxz8V5tVX2dPaXsoKDPraeJmCJnCFDfmWmoNXEeeTTdqQZoIQJuIENcWt
         zZeBBozJMhG58P+pKBIl1D2mtoE3PW2T2JCmwDRh//TvNzmzQDwJwZLrIhh5a9jI1wpt
         qoGQ==
X-Gm-Message-State: AC+VfDwehciLX+OkbRObYm57URBmbmDGOC1e0sr3ycXSu9tUT+EJ69Vb
        SciyCOJ6cdEmWqDZJNKXtJ8NioldmUX8kmF2rPo=
X-Google-Smtp-Source: ACHHUZ4qI1udVkiV6/Ew6tml0v++zojqe1Evt5p7G+qZ1+mBqq0DfzHz64PbkWrAGEdbtJ+FKGlc6Q==
X-Received: by 2002:a7b:c847:0:b0:3f5:42e:7229 with SMTP id c7-20020a7bc847000000b003f5042e7229mr1035527wml.41.1684410643102;
        Thu, 18 May 2023 04:50:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003f1751016desm1822077wmh.28.2023.05.18.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 04:50:41 -0700 (PDT)
Date:   Thu, 18 May 2023 14:50:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v12 07/11] remoteproc: mediatek: Control SCP core 1 by
 rproc subdevice
Message-ID: <11b3ab8d-1264-4143-8eec-b2ef9f691814@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517043449.26352-8-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tinghan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tinghan-Shen/dt-bindings-remoteproc-mediatek-Improve-the-rpmsg-subnode-definition/20230517-123659
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/20230517043449.26352-8-tinghan.shen%40mediatek.com
patch subject: [PATCH v12 07/11] remoteproc: mediatek: Control SCP core 1 by rproc subdevice
config: csky-randconfig-m041-20230517
compiler: csky-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305181957.ZMXChgJV-lkp@intel.com/

smatch warnings:
drivers/remoteproc/mtk_scp.c:891 scp_core_subdev_register() warn: can 'scp_c0' even be NULL?

vim +/scp_c0 +891 drivers/remoteproc/mtk_scp.c

69e1791d92cfa0 Tinghan Shen 2023-05-17  884  static int scp_core_subdev_register(struct mtk_scp *scp)
69e1791d92cfa0 Tinghan Shen 2023-05-17  885  {
69e1791d92cfa0 Tinghan Shen 2023-05-17  886  	struct device *dev = scp->dev;
69e1791d92cfa0 Tinghan Shen 2023-05-17  887  	struct mtk_scp_core_subdev *core_subdev;
69e1791d92cfa0 Tinghan Shen 2023-05-17  888  	struct mtk_scp *scp_c0;
69e1791d92cfa0 Tinghan Shen 2023-05-17  889  
69e1791d92cfa0 Tinghan Shen 2023-05-17  890  	scp_c0 = list_first_entry(scp->cluster, struct mtk_scp, elem);
69e1791d92cfa0 Tinghan Shen 2023-05-17 @891  	if (!scp_c0)
69e1791d92cfa0 Tinghan Shen 2023-05-17  892  		return -ENODATA;

This NULL check isn't right.  Use list_first_entry_or_null() if the list
can be empty.

69e1791d92cfa0 Tinghan Shen 2023-05-17  893  
69e1791d92cfa0 Tinghan Shen 2023-05-17  894  	core_subdev = devm_kzalloc(dev, sizeof(*core_subdev), GFP_KERNEL);
69e1791d92cfa0 Tinghan Shen 2023-05-17  895  	if (!core_subdev)
69e1791d92cfa0 Tinghan Shen 2023-05-17  896  		return -ENOMEM;
69e1791d92cfa0 Tinghan Shen 2023-05-17  897  
69e1791d92cfa0 Tinghan Shen 2023-05-17  898  	core_subdev->scp = scp;
69e1791d92cfa0 Tinghan Shen 2023-05-17  899  	core_subdev->subdev.start = scp_core_subdev_start;
69e1791d92cfa0 Tinghan Shen 2023-05-17  900  	core_subdev->subdev.stop = scp_core_subdev_stop;
69e1791d92cfa0 Tinghan Shen 2023-05-17  901  
69e1791d92cfa0 Tinghan Shen 2023-05-17  902  	scp->core_subdev = core_subdev;
69e1791d92cfa0 Tinghan Shen 2023-05-17  903  	rproc_add_subdev(scp_c0->rproc, &scp->core_subdev->subdev);
69e1791d92cfa0 Tinghan Shen 2023-05-17  904  
69e1791d92cfa0 Tinghan Shen 2023-05-17  905  	return 0;
69e1791d92cfa0 Tinghan Shen 2023-05-17  906  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

