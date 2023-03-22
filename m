Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9476C449C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCVIHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCVIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:07:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683395D243;
        Wed, 22 Mar 2023 01:07:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x3so69261516edb.10;
        Wed, 22 Mar 2023 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679472436;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDLy6gXwopARuTlfqgOxRX3tSQF+2gi6u0FbFURqkMs=;
        b=TbpxK+Kj5hBU/t7V/bNNwtnWIt+6XtX+jmwCZf0otN1AJnWtQEXtFOX9ps1Wy3aOlm
         99StdSC7NqHD/I1Sa6B9RYrPNVRo4V8PPi2h7MEE5e47svEcr0FC8Tg+9sRaX14+Q/uJ
         OtJhGLVuz1s5hYuKl+J8vCv2aPf0S+dD9UBdIkI5rSI24Ins5+XhwRqmee3eXH6grZUI
         CyawVtJzbUECUIwo3rksYgvl0wiISbYa5rq51K5NM8ByInkrCOB+e1YYRxqa5PxqujNH
         Cnj/A5uVMN1DigvxGgw7th2QCew5OH0Agwvqn6IvKZXySHugzmHbBq5hNwwFyF/UVLnO
         AdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472436;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDLy6gXwopARuTlfqgOxRX3tSQF+2gi6u0FbFURqkMs=;
        b=k+DVEoJhZpn6vqVM6rkdM2aFA6CyhUdjggtHuxDtwNrw3rvZI29vRq+gRr0uVEYbzR
         ztr/rzBL+uz9IIQxr82AWneHLzV5CgvAF1d4p5S+cCgSvADBIyzH+eVGgwltOh7PLSZa
         teDQDfD+I6sg41RzZJmDno0/GQiedortuTdQw36Zzvd3lsy+0Ql5TcpenmrUhiwPr59h
         bbcZR2GtIWs21i024G+CFX3ZrLVNTWIZUPY6Hc7gBN6F6NTZrzK526dgzMVLSp5SNUZv
         loQ9zpzG/1tKhdL8k54ONaHQewrJxxrSove/v/oWZ5jo+/vdWjC+TAFkhhGtwo4orLzF
         3xQA==
X-Gm-Message-State: AO0yUKUKsakUxip7z210fjNSXyx+0zEWVD0jHnhYuk4KTaIcvMDpogrI
        89vCatKqhF6ET9pgtbyXLTY=
X-Google-Smtp-Source: AK7set91PeT1rns8zGWrRzVqfZS5PLsJGVSf/j1OePGS0f7y1hnEHyGgIpr/NupFZ+AmDUGtUMiU1A==
X-Received: by 2002:aa7:c84e:0:b0:4fa:b302:84d9 with SMTP id g14-20020aa7c84e000000b004fab30284d9mr5948545edt.14.1679472435784;
        Wed, 22 Mar 2023 01:07:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u3-20020a50d503000000b004fcd78d1215sm7371005edi.36.2023.03.22.01.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:07:14 -0700 (PDT)
Date:   Wed, 22 Mar 2023 11:07:10 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/core: update cooling device during thermal zone
 unregistration
Message-ID: <a6d760f9-18a0-4bcd-a3ce-ab2b9db53c7c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321154627.17787-1-rui.zhang@intel.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Rui/thermal-core-update-cooling-device-during-thermal-zone-unregistration/20230321-234754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230321154627.17787-1-rui.zhang%40intel.com
patch subject: [PATCH] thermal/core: update cooling device during thermal zone unregistration
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20230322/202303221159.6cdRxcUo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303221159.6cdRxcUo-lkp@intel.com/

smatch warnings:
drivers/thermal/thermal_core.c:1436 thermal_zone_device_unregister() warn: iterator used outside loop: 'ti'

vim +/ti +1436 drivers/thermal/thermal_core.c

203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1402  void thermal_zone_device_unregister(struct thermal_zone_device *tz)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1403  {
a5f785ce608caf drivers/thermal/thermal_core.c Dmitry Osipenko  2020-08-18  1404  	int i, tz_id;
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R      2012-09-18  1405  	const struct thermal_zone_params *tzp;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1406  	struct thermal_cooling_device *cdev;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1407  	struct thermal_zone_device *pos = NULL;
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1408  	struct thermal_instance *ti;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1409  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1410  	if (!tz)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1411  		return;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1412  
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R      2012-09-18  1413  	tzp = tz->tzp;
a5f785ce608caf drivers/thermal/thermal_core.c Dmitry Osipenko  2020-08-18  1414  	tz_id = tz->id;
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R      2012-09-18  1415  
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1416  	mutex_lock(&thermal_list_lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1417  	list_for_each_entry(pos, &thermal_tz_list, node)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1418  		if (pos == tz)
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1419  			break;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1420  	if (pos != tz) {
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1421  		/* thermal zone device not found */
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1422  		mutex_unlock(&thermal_list_lock);
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1423  		return;
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1424  	}
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1425  	list_del(&tz->node);
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R      2012-09-18  1426  
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R      2012-09-18  1427  	/* Unbind all cdevs associated with 'this' thermal zone */
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R      2012-09-18  1428  	list_for_each_entry(cdev, &thermal_cdev_list, node) {
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1429  		mutex_lock(&tz->lock);
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1430  		list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1431  			if (ti->cdev == cdev)
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1432  				break;
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1433  		}
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1434  
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1435  		/* The cooling device is not used by current thermal zone */
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21 @1436  		if (ti->cdev != cdev) {

Here we are testing to see if the loop exited by hitting the break.  If
the condition is != then "ti" is not a valid pointer and it's kind of an
out of bounds access.  I used to fix these with:

-	if (ti->cdev != cdev) {
+	if (list_entry_is_head(ti, &tz->thermal_instances, tz_node)) {

But these days we just prefer using a found variable:

	found = false;
	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
		if (ti->cdev == cdev) {
			found = true;
			break;
		}
	}
	if (!found) {

55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1437  			mutex_unlock(&tz->lock);
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1438  			continue;
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1439  		}
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1440  		mutex_unlock(&tz->lock);
55a1117eebc62b drivers/thermal/thermal_core.c Zhang Rui        2023-03-21  1441  
7e8ee1e9d7561f drivers/thermal/thermal_sys.c  Durgadoss R      2012-09-18  1442  		if (tz->ops->unbind) {
203d3d4aa48233 drivers/thermal/thermal.c      Zhang Rui        2008-01-17  1443  			tz->ops->unbind(tz, cdev);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

