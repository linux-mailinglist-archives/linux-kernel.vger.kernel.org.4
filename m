Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1665BB8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbjACICM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbjACICJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:02:09 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407E97659
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:02:07 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l26so20491020wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnMuqxy2CFO3SUnH40zU8WEqg5m4XzWq3qxnT2ueo7Y=;
        b=jdIjJYV7tdwaGK7GxRTTkRy3u+CQsh8RA6gl6OJtOe/+v+k2BBn8TQv0WoM7gAFB5x
         dtIsMTP6/c82ZO7dxz/NvUWvqstg87JlZZMs2lcgzVp5mMCNfBGSEKiIlPtYhSVpmw8O
         jQLgmX72r/fIBKOKrfXV7ka6oE3kaVhjcQPi7MfusUqVLvlRSgVJX4Vkxz1CsOy68Tsi
         9JzxrucdJ0kJdjFJTHPEdVhEnDaPlEkF2BuVOkO3QDPiyMuMMvy7whP//B7oAhO9baAy
         ZyWEMZeoGqi7Eqt2bHCxKLOa7ZwI8VGhC+UhVCk0XzJm6r+6IoCNeVq/dTUBm6xfXpyT
         V8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnMuqxy2CFO3SUnH40zU8WEqg5m4XzWq3qxnT2ueo7Y=;
        b=wJoI/Jl7pv5hV6m5f6DmrPcYK8Sur3T5iPem5yRcQYuQRvMQdgqsMQNce2lS8Alnie
         nZS1/CyiTIS5qrQB/IX4eitCF/WlQlzKJAbORZeG0OtdoXgrBTTVlO+4XWHNIENxdodQ
         yBzlWQAs0IxJtpTWfPVuC/c7bOiw6vkqEFD2sAQwRVKReuzWxtPOPzk65rhtiqJIssA8
         bqfwJDx86OOQ7RCILDMv4lFEDM9qq9kJdsUo6zC5M2AmwJ79RUEJzhNOw4KE00E2hXmt
         JAA8g/t7Yl1HrqABIelm+fza8MXYNUymsgn8X/0sh5UYQO4XW50VYPvYybCv/XfY8EeL
         v4ag==
X-Gm-Message-State: AFqh2kqQZh9simuxzUTprdcKISz5LfsNtkMryY4oaCwq+Is5bCxayWAJ
        yZQsKQaMH14RwWU7bVw/Tfc=
X-Google-Smtp-Source: AMrXdXshVs87qZyY8zSf13yrYubU/vGpH/nhfEuE00CGOuwwkLJ/jIpmqabSjnQh4lxvXim5RXoo9Q==
X-Received: by 2002:a05:600c:3acd:b0:3d1:c354:77b6 with SMTP id d13-20020a05600c3acd00b003d1c35477b6mr34067793wms.29.1672732925710;
        Tue, 03 Jan 2023 00:02:05 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003c70191f267sm48856173wmc.39.2023.01.03.00.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 00:02:05 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:02:01 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Ben Skeggs <bskeggs@redhat.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_dp.c:237 nouveau_dp_irq() warn:
 variable dereferenced before check 'outp' (see line 232)
Message-ID: <202212300411.7i7D8MbF-lkp@intel.com>
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
head:   2258c2dc850b8605cb66b3383e50b9dddd1c6580
commit: 773eb04d14a11552b2c3953097ed09cde2ab4831 drm/nouveau/disp: expose conn event class
config: ia64-randconfig-m031-20221229
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/gpu/drm/nouveau/nouveau_dp.c:237 nouveau_dp_irq() warn: variable dereferenced before check 'outp' (see line 232)

vim +/outp +237 drivers/gpu/drm/nouveau/nouveau_dp.c

773eb04d14a115 Ben Skeggs 2022-06-01  225  void
773eb04d14a115 Ben Skeggs 2022-06-01  226  nouveau_dp_irq(struct work_struct *work)
a0922278f83eae Lyude Paul 2020-08-26  227  {
773eb04d14a115 Ben Skeggs 2022-06-01  228  	struct nouveau_connector *nv_connector =
773eb04d14a115 Ben Skeggs 2022-06-01  229  		container_of(work, typeof(*nv_connector), irq_work);
a0922278f83eae Lyude Paul 2020-08-26  230  	struct drm_connector *connector = &nv_connector->base;
a0922278f83eae Lyude Paul 2020-08-26  231  	struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);
773eb04d14a115 Ben Skeggs 2022-06-01 @232  	struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);
                                                                                      ^^^^^^
Dereference.

a0922278f83eae Lyude Paul 2020-08-26  233  	struct nv50_mstm *mstm;
016dacb60e6d4b Ben Skeggs 2022-06-01  234  	u64 hpd = 0;
a4efad354cf1b9 Lyude Paul 2020-08-26  235  	int ret;
a0922278f83eae Lyude Paul 2020-08-26  236  
a0922278f83eae Lyude Paul 2020-08-26 @237  	if (!outp)
                                                     ^^^^
Checked too late.

a0922278f83eae Lyude Paul 2020-08-26  238  		return;
a0922278f83eae Lyude Paul 2020-08-26  239  
a0922278f83eae Lyude Paul 2020-08-26  240  	mstm = outp->dp.mstm;
a0922278f83eae Lyude Paul 2020-08-26  241  	NV_DEBUG(drm, "service %s\n", connector->name);
a0922278f83eae Lyude Paul 2020-08-26  242  
a0922278f83eae Lyude Paul 2020-08-26  243  	mutex_lock(&outp->dp.hpd_irq_lock);
a0922278f83eae Lyude Paul 2020-08-26  244  
a0922278f83eae Lyude Paul 2020-08-26  245  	if (mstm && mstm->is_mst) {
a0922278f83eae Lyude Paul 2020-08-26  246  		if (!nv50_mstm_service(drm, nv_connector, mstm))
773eb04d14a115 Ben Skeggs 2022-06-01  247  			hpd |= NVIF_CONN_EVENT_V0_UNPLUG;
a0922278f83eae Lyude Paul 2020-08-26  248  	} else {
a0922278f83eae Lyude Paul 2020-08-26  249  		drm_dp_cec_irq(&nv_connector->aux);
a4efad354cf1b9 Lyude Paul 2020-08-26  250  
a4efad354cf1b9 Lyude Paul 2020-08-26  251  		if (nouveau_dp_has_sink_count(connector, outp)) {
a4efad354cf1b9 Lyude Paul 2020-08-26  252  			ret = drm_dp_read_sink_count(&nv_connector->aux);
a4efad354cf1b9 Lyude Paul 2020-08-26  253  			if (ret != outp->dp.sink_count)
773eb04d14a115 Ben Skeggs 2022-06-01  254  				hpd |= NVIF_CONN_EVENT_V0_PLUG;
a4efad354cf1b9 Lyude Paul 2020-08-26  255  			if (ret >= 0)
a4efad354cf1b9 Lyude Paul 2020-08-26  256  				outp->dp.sink_count = ret;
a4efad354cf1b9 Lyude Paul 2020-08-26  257  		}
a0922278f83eae Lyude Paul 2020-08-26  258  	}
a0922278f83eae Lyude Paul 2020-08-26  259  
a0922278f83eae Lyude Paul 2020-08-26  260  	mutex_unlock(&outp->dp.hpd_irq_lock);
a4efad354cf1b9 Lyude Paul 2020-08-26  261  
773eb04d14a115 Ben Skeggs 2022-06-01  262  	nouveau_connector_hpd(nv_connector, NVIF_CONN_EVENT_V0_IRQ | hpd);
a0922278f83eae Lyude Paul 2020-08-26  263  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

