Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5B6C0A48
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCTF4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCTF4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:56:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA431C590;
        Sun, 19 Mar 2023 22:55:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l12so9176760wrm.10;
        Sun, 19 Mar 2023 22:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679291757;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtJkCtqb2bB+MWR+u3Gmp/ztE97N0qX+dLRTfM+HQno=;
        b=Y8W2POq43d9PZxpw/Chip8Rt29MbxPOWW3RRojLfpt9PXGMwEQqOyI4LeSXFFtZh3s
         YOkMYf5gUJSlNsPtj354+Ph4O9zlpaZeErdnMbNOWUjzcJk5uTeDBLbnKsGx7TUhyohs
         DPQOPe1qLiUELRNVlL0ZvoiV5ldFT/bAkPMm34GU2hV4a459noXFsdAU0P+o8gQT94dK
         eBNKxVI9wfXHYz9Tu9dHWzpcuxBExIbvk0SYal5Mag98AbN+Co0RW5V5u7aHVk66Mxnn
         3mLvh4oI3UYFynfpgchQRaflKJ6NkR8PEq91n4Cjm25kq8EqtJMcE0Z1PzbC5M66auQf
         s5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679291757;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtJkCtqb2bB+MWR+u3Gmp/ztE97N0qX+dLRTfM+HQno=;
        b=D/4YnpKbr8XPl3CumYqxPkRg7WOTgF4WckV9WzY84/NerprFbApmlBpsXuv6WuQqAQ
         E4A9NWhTFY/Y/GuZUSPhpXBVVwRLDZ9ZrUXhG5NGg4RMeYtXjcFeQLyvZkpS7e5FsOR/
         XIPMzj/Bkc6KljwoJNr0sqXBzWeOmKE5oieYqBhHesH798bkRiKdhZBct+paj3M2DmOm
         iHkh7njDajf96rI+D9EP60AVv9OUbAZCQG3S2zCCeM1iiFflYUhGjWObpMJ9eXSh7m2g
         ypcDsJoEfe6eAmShKCdqfPak+56efdq90h9pkJtnxChkuLLi+nHhfTdWnpQoRHS3ZHgh
         Y7fw==
X-Gm-Message-State: AO0yUKVmDdA78GRIjyVI3iGpiMId8vXQV0xc/K7DMT2F1r4qla9oEEwX
        qRaiNY7wGbDLA1IK6HXplDUmMsw133s=
X-Google-Smtp-Source: AK7set/WH0FKeZbzMjkrVVepWxHIpvD3zUB2eBPb4v1+GHJS39m0q3R4OjFd8+1nkWP1u92Ah0DnUg==
X-Received: by 2002:a5d:4708:0:b0:2cb:29eb:a35e with SMTP id y8-20020a5d4708000000b002cb29eba35emr9407803wrq.11.1679291757422;
        Sun, 19 Mar 2023 22:55:57 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p5-20020adfce05000000b002d64fcb362dsm2725967wrn.111.2023.03.19.22.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 22:55:57 -0700 (PDT)
Date:   Mon, 20 Mar 2023 08:55:51 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Sherry Sun <sherry.sun@nxp.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] tty: serdev: serdev-ttyport: add devt for ctrl->dev
Message-ID: <d2c39186-9641-4aaa-90cb-bce92b2331f6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315105400.23426-1-sherry.sun@nxp.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sherry,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sherry-Sun/tty-serdev-serdev-ttyport-add-devt-for-ctrl-dev/20230315-185913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230315105400.23426-1-sherry.sun%40nxp.com
patch subject: [PATCH] tty: serdev: serdev-ttyport: add devt for ctrl->dev
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20230316/202303160201.bnmM2caW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303160201.bnmM2caW-lkp@intel.com/

smatch warnings:
drivers/tty/serdev/serdev-ttyport.c:273 serdev_tty_port_register() warn: variable dereferenced before check 'drv' (see line 270)

vim +/drv +273 drivers/tty/serdev/serdev-ttyport.c

bed35c6dfa6a36 Rob Herring  2017-02-02  264  struct device *serdev_tty_port_register(struct tty_port *port,
bed35c6dfa6a36 Rob Herring  2017-02-02  265  					struct device *parent,
bed35c6dfa6a36 Rob Herring  2017-02-02  266  					struct tty_driver *drv, int idx)
bed35c6dfa6a36 Rob Herring  2017-02-02  267  {
bed35c6dfa6a36 Rob Herring  2017-02-02  268  	struct serdev_controller *ctrl;
bed35c6dfa6a36 Rob Herring  2017-02-02  269  	struct serport *serport;
225acc66b125b9 Sherry Sun   2023-03-15 @270  	dev_t devt = MKDEV(drv->major, drv->minor_start) + idx;
                                                                   ^^^^^       ^^^^^
Dereferences.

bed35c6dfa6a36 Rob Herring  2017-02-02  271  	int ret;
bed35c6dfa6a36 Rob Herring  2017-02-02  272  
bed35c6dfa6a36 Rob Herring  2017-02-02 @273  	if (!port || !drv || !parent)
                                                             ^^^^
Checked too late.  Are these checks really required?

bed35c6dfa6a36 Rob Herring  2017-02-02  274  		return ERR_PTR(-ENODEV);
bed35c6dfa6a36 Rob Herring  2017-02-02  275  
bed35c6dfa6a36 Rob Herring  2017-02-02  276  	ctrl = serdev_controller_alloc(parent, sizeof(struct serport));
bed35c6dfa6a36 Rob Herring  2017-02-02  277  	if (!ctrl)
bed35c6dfa6a36 Rob Herring  2017-02-02  278  		return ERR_PTR(-ENOMEM);
bed35c6dfa6a36 Rob Herring  2017-02-02  279  	serport = serdev_controller_get_drvdata(ctrl);
bed35c6dfa6a36 Rob Herring  2017-02-02  280  
bed35c6dfa6a36 Rob Herring  2017-02-02  281  	serport->port = port;
bed35c6dfa6a36 Rob Herring  2017-02-02  282  	serport->tty_idx = idx;
bed35c6dfa6a36 Rob Herring  2017-02-02  283  	serport->tty_drv = drv;
bed35c6dfa6a36 Rob Herring  2017-02-02  284  
225acc66b125b9 Sherry Sun   2023-03-15  285  	ctrl->dev.devt = devt;
bed35c6dfa6a36 Rob Herring  2017-02-02  286  	ctrl->ops = &ctrl_ops;
bed35c6dfa6a36 Rob Herring  2017-02-02  287  
aee5da7838787f Johan Hovold 2017-04-11  288  	port->client_ops = &client_ops;
aee5da7838787f Johan Hovold 2017-04-11  289  	port->client_data = ctrl;
aee5da7838787f Johan Hovold 2017-04-11  290  
bed35c6dfa6a36 Rob Herring  2017-02-02  291  	ret = serdev_controller_add(ctrl);
bed35c6dfa6a36 Rob Herring  2017-02-02  292  	if (ret)
aee5da7838787f Johan Hovold 2017-04-11  293  		goto err_reset_data;
bed35c6dfa6a36 Rob Herring  2017-02-02  294  
bed35c6dfa6a36 Rob Herring  2017-02-02  295  	dev_info(&ctrl->dev, "tty port %s%d registered\n", drv->name, idx);
bed35c6dfa6a36 Rob Herring  2017-02-02  296  	return &ctrl->dev;
bed35c6dfa6a36 Rob Herring  2017-02-02  297  
aee5da7838787f Johan Hovold 2017-04-11  298  err_reset_data:
aee5da7838787f Johan Hovold 2017-04-11  299  	port->client_data = NULL;
0c5aae59270fb1 Johan Hovold 2020-02-10  300  	port->client_ops = &tty_port_default_client_ops;
bed35c6dfa6a36 Rob Herring  2017-02-02  301  	serdev_controller_put(ctrl);
aee5da7838787f Johan Hovold 2017-04-11  302  
bed35c6dfa6a36 Rob Herring  2017-02-02  303  	return ERR_PTR(ret);
bed35c6dfa6a36 Rob Herring  2017-02-02  304  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

