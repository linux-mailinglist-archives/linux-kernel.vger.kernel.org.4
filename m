Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A296E701562
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 10:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjEMIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjEMIwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 04:52:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C65372A4
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 01:52:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f42c86543bso37014005e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683967948; x=1686559948;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFiPsR74mJR9kYLZiNuO/LBpL6tXQD4xr+oUTIlTgpQ=;
        b=THMT/NzAjks6HbLuMxTD1VS/tKSoTYPk/ztRAK/tJUh3U0B8JqH+6zE/UJWAIDogvV
         PP/sm97oEu/X++ClABFxoHH/ucLCl9r8bXhBOGiAdMKKnv3Y3lHE1Zo7IId91Sc4v4AB
         Jq6E3+H1SYz1ilKmcL4f2UegiBG+skROdhrJguSbP9b95oyVuhXhn5A81g2Lx9KXgqyF
         sVu3ds/3RBtJdXaVVQD0HqJtSmN6r0pKLWa9IZHiuQNnbdIHRjpLCOQRlGXV+txQUmh6
         TO9NOkqwJvoQCQduMIlBquUOEzTha/j5hC7a4wS1/vAx11qQPV/OU2+fLAWvtliWtJHV
         X+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683967948; x=1686559948;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFiPsR74mJR9kYLZiNuO/LBpL6tXQD4xr+oUTIlTgpQ=;
        b=DmX5Q7GMgJa51eDz9G/9G/afXf08qZ2zsb1IMx9pGlpDr9XBX7TwlGA+ytz2zrYJa2
         gf6C1En/uZMxT2JosM2nhrh6F79A7VkkjQP0EjHCO5NvjGWD5sf7CxgW3CtQAgShJCj5
         Xo+dzI5XyjAwfbohr7Ns69jTR/Zq4oE71P1yNFrkboXZ9cbp894viSDFg9vWxUft+9as
         4FqH/1TQnfUGABLFvkiPN/SAjerNRdUisGUploaLebToeu3pLFU+kG8CmpIe7LsucVe6
         f6P0m9khgyKT2qlPGcKe82iFMu7RLFY8KpTeo0qp2InYtwn/JndputFsFWRfngY1lEcc
         ZRNA==
X-Gm-Message-State: AC+VfDxsg3xL/VV5/rlcw3FQKet/RKvWOJmz2pigWicRg6wuuvLPAlDJ
        WPnXO7kfxvU2xvjN1kITBLQ+yQ==
X-Google-Smtp-Source: ACHHUZ6T+ABMgpDzTYDLlWrTTc79NsejMYs1SyXwyQX+qUUX1r9XQYiujQZu7ve0l+WFFNCZJIljEg==
X-Received: by 2002:a7b:cb06:0:b0:3f2:5a60:a03e with SMTP id u6-20020a7bcb06000000b003f25a60a03emr19015560wmj.14.1683967947950;
        Sat, 13 May 2023 01:52:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n19-20020a1c7213000000b003f4268f51f5sm16725978wmc.0.2023.05.13.01.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 01:52:25 -0700 (PDT)
Date:   Sat, 13 May 2023 11:52:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Oliver Neukum <oneukum@suse.com>,
        wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 8/8] usb_pcwd: remove superfluous usb_device pointer
Message-ID: <d65447c3-58d2-4489-9317-f74ba2873108@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427133350.31064-9-oneukum@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oliver-Neukum/pcwd_usb-stop-open-race-disconnect/20230427-223413
base:   linus/master
patch link:    https://lore.kernel.org/r/20230427133350.31064-9-oneukum%40suse.com
patch subject: [PATCH 8/8] usb_pcwd: remove superfluous usb_device pointer
config: parisc-randconfig-m041-20230509 (https://download.01.org/0day-ci/archive/20230512/202305122231.n8RlGMhT-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305122231.n8RlGMhT-lkp@intel.com/

smatch warnings:
drivers/watchdog/pcwd_usb.c:215 usb_pcwd_send_command() warn: variable dereferenced before check 'usb_pcwd' (see line 211)

vim +/usb_pcwd +215 drivers/watchdog/pcwd_usb.c

143a2e54bf5321 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck   2009-03-18  206  static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
143a2e54bf5321 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck   2009-03-18  207  		unsigned char cmd, unsigned char *msb, unsigned char *lsb)
^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  208  {
^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  209  	int got_response, count;
5412df0bda90a2 drivers/watchdog/pcwd_usb.c      Guenter Roeck      2013-10-14  210  	unsigned char *buf;
41b4f0869562d7 drivers/watchdog/pcwd_usb.c      Oliver Neukum      2023-04-27 @211  	struct usb_device *udev = interface_to_usbdev(usb_pcwd->interface);
                                                                                                                                      ^^^^^^^^^^
Dereference.

^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  212  
143a2e54bf5321 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck   2009-03-18  213  	/* We will not send any commands if the USB PCWD device does
143a2e54bf5321 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck   2009-03-18  214  	 * not exist */
^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16 @215  	if ((!usb_pcwd) || (!usb_pcwd->exists))
                                                                                            ^^^^^^^^^^^
Checked too late.

^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  216  		return -1;
^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  217  
5412df0bda90a2 drivers/watchdog/pcwd_usb.c      Guenter Roeck      2013-10-14  218  	buf = kmalloc(6, GFP_KERNEL);
5412df0bda90a2 drivers/watchdog/pcwd_usb.c      Guenter Roeck      2013-10-14  219  	if (buf == NULL)
5412df0bda90a2 drivers/watchdog/pcwd_usb.c      Guenter Roeck      2013-10-14  220  		return 0;
5412df0bda90a2 drivers/watchdog/pcwd_usb.c      Guenter Roeck      2013-10-14  221  
143a2e54bf5321 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck   2009-03-18  222  	/* The USB PC Watchdog uses a 6 byte report format.
143a2e54bf5321 drivers/watchdog/pcwd_usb.c      Wim Van Sebroeck   2009-03-18  223  	 * The board currently uses only 3 of the six bytes of the report. */
^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  224  	buf[0] = cmd;			/* Byte 0 = CMD */
^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  225  	buf[1] = *msb;			/* Byte 1 = Data MSB */
^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  226  	buf[2] = *lsb;			/* Byte 2 = Data LSB */
^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  227  	buf[3] = buf[4] = buf[5] = 0;	/* All other bytes not used */
^1da177e4c3f41 drivers/char/watchdog/pcwd_usb.c Linus Torvalds     2005-04-16  228  
d7e92f7f768477 drivers/watchdog/pcwd_usb.c      Greg Kroah-Hartman 2013-12-19  229  	dev_dbg(&usb_pcwd->interface->dev,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

