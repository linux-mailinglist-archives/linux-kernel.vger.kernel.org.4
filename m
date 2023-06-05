Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE30E721F9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjFEHdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjFEHcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:32:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36E2E53
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:32:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso31551385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685950344; x=1688542344;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWebPmkkXZwMfaAQP1En4s9/tKIJUkHKAcCHX0b4nT0=;
        b=yNe89sJMqjCvRZY8KEh8e9m6zed+dTP2I41xn3eYc6SuXCRiwwga/7uKmAV3YR+MsY
         iKPh9hPLUeJHndeZPKyYunIHQJxrFAs9VBmanypZwTHINNxFsA9dKnDfIrBEt742CRcv
         6rjBog+j2Uq6jBQzkVuhxPaOEvaKZdrtixGeKM3IQVXM1gS2YxJDj/Fz842+a6vakY39
         riKH/WUMV1ccD6Od5Vx9jtcUt2Hny8fW9U5ftKERRXESa+Clzd1BxbHZFxDyXpXO3xU5
         wPA9guClNV55pi6ueL/ghMtmxdcSqDSIZjpv5UL0sXHzqFFgn5t+BFAfk8vBF8UIL8g/
         k9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950344; x=1688542344;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWebPmkkXZwMfaAQP1En4s9/tKIJUkHKAcCHX0b4nT0=;
        b=MMB8E9Fe5xyqGWznZ3s4w4FqCAs0CGagX4DLT0nQdql1BdCIHShkbu1kn03zgPIcbw
         8/9YuiV669NB0iiS+IXC9GVZwPUXmNPxY2yJsgD0b8eeoaJED1f5mBb44kBNm4naRmnF
         WppRDDF2H/dW6PY0JlndP9uFQyssDFJx/XUdOXHaC2XH8pxATsOihwaB82a4YZC1wTQa
         BeJA5E5cEGuTQDipSClXAJtpQdulqYAfrS4aynFWFGywFZ96ca2La+8f8GmTYWBo0Xp3
         AKgl0vS+l8ds1j2EyAag9wEXJ6bspGemS/CXfnA4/bPOEQoKU5I43I67uT73HHtMdeF5
         V/QA==
X-Gm-Message-State: AC+VfDwPhE01SBzfGWiZI0cvo88J/QGHfW2FERUiwikN6qdwd4SEU7qn
        VfOT/JnM5oVyC2EPgQkAD0LC7w==
X-Google-Smtp-Source: ACHHUZ6ETpTzw7MhCVETQT2q+Tvi7uvnSQJojKyiNat+/Nd4fj04M9SLAwejgKN8ZOdR8ZdTnTYXiw==
X-Received: by 2002:a1c:ed03:0:b0:3f4:1ce0:a606 with SMTP id l3-20020a1ced03000000b003f41ce0a606mr7175893wmh.1.1685950344248;
        Mon, 05 Jun 2023 00:32:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f60482024fsm9877459wmc.30.2023.06.05.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:32:22 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:32:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Johan Hovold <johan@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH 1/3] USB: serial: return errors from break handling
Message-ID: <3ab35d0b-b5b6-4361-acac-59a4a9fbc970@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602124642.19076-2-johan@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johan-Hovold/USB-serial-return-errors-from-break-handling/20230602-204856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git usb-next
patch link:    https://lore.kernel.org/r/20230602124642.19076-2-johan%40kernel.org
patch subject: [PATCH 1/3] USB: serial: return errors from break handling
config: i386-randconfig-m021-20230531 (https://download.01.org/0day-ci/archive/20230603/202306031014.qzAY3uQ6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202306031014.qzAY3uQ6-lkp@intel.com/

New smatch warnings:
drivers/usb/serial/io_edgeport.c:1601 edge_break() error: uninitialized symbol 'status'.

vim +/status +1601 drivers/usb/serial/io_edgeport.c

12992379710489 Johan Hovold       2023-06-02  1563  static int edge_break(struct tty_struct *tty, int break_state)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1564  {
95da310e66ee80 Alan Cox           2008-07-22  1565  	struct usb_serial_port *port = tty->driver_data;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1566  	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
6e8cf7751f9fb9 Greg Kroah-Hartman 2007-01-18  1567  	struct edgeport_serial *edge_serial = usb_get_serial_data(port->serial);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1568  	int status;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1569  
232dce89b5b000 Geyslan G. Bem     2015-12-11  1570  	if (!edge_serial->is_epic ||
232dce89b5b000 Geyslan G. Bem     2015-12-11  1571  	    edge_serial->epic_descriptor.Supports.IOSPChase) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1572  		/* flush and chase */
cb8eaa8b2b9133 Richard Knutsson   2007-03-17  1573  		edge_port->chaseResponsePending = true;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1574  
984f68683298ba Greg Kroah-Hartman 2012-09-18  1575  		dev_dbg(&port->dev, "%s - Sending IOSP_CMD_CHASE_PORT\n", __func__);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1576  		status = send_iosp_ext_cmd(edge_port, IOSP_CMD_CHASE_PORT, 0);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1577  		if (status == 0) {
03f0dbf74c7a11 Alan Cox           2008-07-22  1578  			/* block until chase finished */
^1da177e4c3f41 Linus Torvalds     2005-04-16  1579  			block_until_chase_response(edge_port);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1580  		} else {
cb8eaa8b2b9133 Richard Knutsson   2007-03-17  1581  			edge_port->chaseResponsePending = false;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1582  		}
6e8cf7751f9fb9 Greg Kroah-Hartman 2007-01-18  1583  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  1584  
232dce89b5b000 Geyslan G. Bem     2015-12-11  1585  	if (!edge_serial->is_epic ||
232dce89b5b000 Geyslan G. Bem     2015-12-11  1586  	    edge_serial->epic_descriptor.Supports.IOSPSetClrBreak) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1587  		if (break_state == -1) {
984f68683298ba Greg Kroah-Hartman 2012-09-18  1588  			dev_dbg(&port->dev, "%s - Sending IOSP_CMD_SET_BREAK\n", __func__);
03f0dbf74c7a11 Alan Cox           2008-07-22  1589  			status = send_iosp_ext_cmd(edge_port,
03f0dbf74c7a11 Alan Cox           2008-07-22  1590  						IOSP_CMD_SET_BREAK, 0);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1591  		} else {
984f68683298ba Greg Kroah-Hartman 2012-09-18  1592  			dev_dbg(&port->dev, "%s - Sending IOSP_CMD_CLEAR_BREAK\n", __func__);
03f0dbf74c7a11 Alan Cox           2008-07-22  1593  			status = send_iosp_ext_cmd(edge_port,
03f0dbf74c7a11 Alan Cox           2008-07-22  1594  						IOSP_CMD_CLEAR_BREAK, 0);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1595  		}

"status" uninitialized on else path.

03f0dbf74c7a11 Alan Cox           2008-07-22  1596  		if (status)
984f68683298ba Greg Kroah-Hartman 2012-09-18  1597  			dev_dbg(&port->dev, "%s - error sending break set/clear command.\n",
03f0dbf74c7a11 Alan Cox           2008-07-22  1598  				__func__);
6e8cf7751f9fb9 Greg Kroah-Hartman 2007-01-18  1599  	}
12992379710489 Johan Hovold       2023-06-02  1600  
12992379710489 Johan Hovold       2023-06-02 @1601  	return status;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1602  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

