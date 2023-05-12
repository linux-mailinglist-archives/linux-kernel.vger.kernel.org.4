Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9426FFF98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjELESe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjELES2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:18:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173240E2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:18:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so48217095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683865105; x=1686457105;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKSRIDy0J+UduLCQdBIRVgaNQhqBgLMPH7ha37U/mpY=;
        b=blQ1l551mkk+RhRNR4/CbhJIKKut5nb8rgm1ZlVdYS3Xs/ZAsSfjl9OmJXiFhLRw//
         fLThEdWuA50YQnH2BZtawfZwWJQL4qD7NbGHby0VERYx9vzBTpa+wxNjToFvj4uRjARx
         Q1zj3aHn8M1OaIfRQN7nFnUYn/LIwrmKZ9YP9n3+D1R+hkV6k7Z8RenSqfHy9PuHieTZ
         40zj5vxBqUuHpHvSZhtL86t70GXZZQNBvXN0cCqktdTtlrE2uWJ+HfdDCT8K7BmgBJCA
         IV0REqLjOlrUvv0Ycs8yZm0zBIQrPutGQ7/qQZScPERY/ozbTz3c+t9jXjAATkuqlv49
         j0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683865105; x=1686457105;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKSRIDy0J+UduLCQdBIRVgaNQhqBgLMPH7ha37U/mpY=;
        b=CzyqBnWaVGz/zxtA2HqMSvK3ED0tPX4cQHD3icEb+e85BweSjgnCXBWEIeyvJ5CCY6
         Fn0xS26J3d33pu01CDD9tM95d5IIjFHuHkqUt+hsOYSgNuN1E0MTI4Ncotz50kB324R5
         YdrG1k7Mk48vqq8SLYBeUibQ1fyYCBhkjBoHOGCwxnhblJtdcF4TEiUc5kYg0QMit7s7
         6lAujN1Cx9RuP0fWRotugNe49A3+Y4oMwnp7APMWOW8NCqqF41K5EoJYurIrxxI/2Rgj
         oi7PIax6GYCapRNdYEShEnZlc3D/D6QxigIcZUHEyIdawTMWlfw+J8OrL0HhMzbYLmVm
         JJ/Q==
X-Gm-Message-State: AC+VfDwZ24C8GngJv02FgLvwB7bhO9SYcP08HRdYiE0F5vW00XGl13L7
        XpSMpn4uiXlqyegIY6mJyo9ylg==
X-Google-Smtp-Source: ACHHUZ5p1QJeBJjKCYP8wu3GMgGcx+MS7p0O3HhkJyuYY/Yip8cIUKZ3F1vH9Kfd5azZX90khyqONQ==
X-Received: by 2002:a7b:c85a:0:b0:3f4:ecf0:8c93 with SMTP id c26-20020a7bc85a000000b003f4ecf08c93mr2384658wml.20.1683865104843;
        Thu, 11 May 2023 21:18:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b003f318be9442sm27555561wmj.40.2023.05.11.21.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 21:18:23 -0700 (PDT)
Date:   Fri, 12 May 2023 07:18:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: Re: [PATCH 2/2] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Message-ID: <3e035312-3c06-44e1-95ef-0a4d36456a7d@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683827311-1462-3-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elson,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elson-Roy-Serrao/usb-function-u_ether-Handle-rx-requests-during-suspend-resume/20230512-015036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/1683827311-1462-3-git-send-email-quic_eserrao%40quicinc.com
patch subject: [PATCH 2/2] usb: dwc3: Modify runtime pm ops to handle bus suspend
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20230512/202305120709.tCFYCtsd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202305120709.tCFYCtsd-lkp@intel.com/

New smatch warnings:
drivers/usb/dwc3/gadget.c:2409 dwc3_gadget_wakeup() warn: pm_runtime_get_sync() also returns 1 on success
drivers/usb/dwc3/gadget.c:2437 dwc3_gadget_func_wakeup() warn: pm_runtime_get_sync() also returns 1 on success

Old smatch warnings:
drivers/usb/dwc3/gadget.c:1648 __dwc3_gadget_kick_transfer() warn: missing error code? 'ret'
drivers/usb/dwc3/gadget.c:2744 dwc3_gadget_pullup() warn: pm_runtime_get_sync() also returns 1 on success

vim +2409 drivers/usb/dwc3/gadget.c

218ef7b647e336 Felipe Balbi     2016-04-04  2392  static int dwc3_gadget_wakeup(struct usb_gadget *g)
218ef7b647e336 Felipe Balbi     2016-04-04  2393  {
218ef7b647e336 Felipe Balbi     2016-04-04  2394  	struct dwc3		*dwc = gadget_to_dwc(g);
218ef7b647e336 Felipe Balbi     2016-04-04  2395  	unsigned long		flags;
218ef7b647e336 Felipe Balbi     2016-04-04  2396  	int			ret;
218ef7b647e336 Felipe Balbi     2016-04-04  2397  
047161686b813a Elson Roy Serrao 2023-03-24  2398  	if (!dwc->wakeup_configured) {
047161686b813a Elson Roy Serrao 2023-03-24  2399  		dev_err(dwc->dev, "remote wakeup not configured\n");
047161686b813a Elson Roy Serrao 2023-03-24  2400  		return -EINVAL;
047161686b813a Elson Roy Serrao 2023-03-24  2401  	}
047161686b813a Elson Roy Serrao 2023-03-24  2402  
047161686b813a Elson Roy Serrao 2023-03-24  2403  	if (!dwc->gadget->wakeup_armed) {
047161686b813a Elson Roy Serrao 2023-03-24  2404  		dev_err(dwc->dev, "not armed for remote wakeup\n");
047161686b813a Elson Roy Serrao 2023-03-24  2405  		return -EINVAL;
047161686b813a Elson Roy Serrao 2023-03-24  2406  	}
047161686b813a Elson Roy Serrao 2023-03-24  2407  
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2408  	ret = pm_runtime_get_sync(dwc->dev);
0660b8a88d4d6a Elson Roy Serrao 2023-05-11 @2409  	if (ret) {

The checker is correct.  These days it's better to use the
pm_runtime_resume_and_get() function instead of pm_runtime_get_sync().

0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2410  		pm_runtime_put(dwc->dev);
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2411  		return ret;
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2412  	}
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2413  
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2414  	spin_lock_irqsave(&dwc->lock, flags);
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2415  	ret = __dwc3_gadget_wakeup(dwc, true);
72246da40f3719 Felipe Balbi     2011-08-19  2416  	spin_unlock_irqrestore(&dwc->lock, flags);
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2417  	pm_runtime_put_noidle(dwc->dev);
72246da40f3719 Felipe Balbi     2011-08-19  2418  
72246da40f3719 Felipe Balbi     2011-08-19  2419  	return ret;
72246da40f3719 Felipe Balbi     2011-08-19  2420  }
72246da40f3719 Felipe Balbi     2011-08-19  2421  
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2422  static void dwc3_resume_gadget(struct dwc3 *dwc);
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2423  
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2424  static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2425  {
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2426  	struct  dwc3		*dwc = gadget_to_dwc(g);
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2427  	unsigned long		flags;
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2428  	int			ret;
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2429  	int			link_state;
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2430  
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2431  	if (!dwc->wakeup_configured) {
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2432  		dev_err(dwc->dev, "remote wakeup not configured\n");
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2433  		return -EINVAL;
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2434  	}
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2435  
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2436  	ret = pm_runtime_get_sync(dwc->dev);
0660b8a88d4d6a Elson Roy Serrao 2023-05-11 @2437  	if (ret) {

Same.

0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2438  		pm_runtime_put(dwc->dev);
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2439  		return ret;
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2440  	}
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2441  
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2442  	spin_lock_irqsave(&dwc->lock, flags);
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2443  	/*
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2444  	 * If the link is in U3, signal for remote wakeup and wait for the
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2445  	 * link to transition to U0 before sending device notification.
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2446  	 */
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2447  	link_state = dwc3_gadget_get_link_state(dwc);
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2448  	if (link_state == DWC3_LINK_STATE_U3) {
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2449  		ret = __dwc3_gadget_wakeup(dwc, false);
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2450  		if (ret) {
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2451  			spin_unlock_irqrestore(&dwc->lock, flags);
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2452  			pm_runtime_put_noidle(dwc->dev);
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2453  			return -EINVAL;
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2454  		}
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2455  		dwc3_resume_gadget(dwc);
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2456  		dwc->link_state = DWC3_LINK_STATE_U0;
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2457  	}
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2458  
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2459  	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2460  					       DWC3_DGCMDPAR_DN_FUNC_WAKE |
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2461  					       DWC3_DGCMDPAR_INTF_SEL(intf_id));
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2462  	if (ret)
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2463  		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2464  
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2465  	spin_unlock_irqrestore(&dwc->lock, flags);
0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2466  	pm_runtime_put_noidle(dwc->dev);
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2467  
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2468  	return ret;
92c08a84b53e5d Elson Roy Serrao 2023-03-24  2469  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

