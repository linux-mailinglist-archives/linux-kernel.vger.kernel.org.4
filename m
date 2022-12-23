Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B571654F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiLWKsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:48:21 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6602EFA0;
        Fri, 23 Dec 2022 02:48:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ja17so3351531wmb.3;
        Fri, 23 Dec 2022 02:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhLbfasIT+IsJ/fzFBKm8bjMLim3B3v7a2BR1YCQf9s=;
        b=R/pAZCVvoENYrH4goqJ89J4Ckc+WVtX/QbCDc3wROEHKQQV99DN7Uep1LmyeRh8BY6
         KD5TmmrjLxVB3TJMWOrL5L3+J0wl4oUNhNGQHDDDPmezF6byXFfcJQKm0ybBgQEgMIXS
         yj9ghPLj/8CdpJSnjGvJvHp8Uz+tZI+RciFNwbGOBX93W66RdH5bCdhWGh+reox5Op3t
         7evSXHDc3QW93KuI2O19bQvyEHYBuN46caTfdNmLGjEcwqvBte8lLRDopScBBKArsEUL
         QLBMWyvDKBMk4flJj3ERvgm1PRmJVDN7by7SIRs0PRMyqX0Sxfv0yZxSDx1QIukgALrx
         0ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhLbfasIT+IsJ/fzFBKm8bjMLim3B3v7a2BR1YCQf9s=;
        b=P9PfZYWxt3zbeu1m4co8i/SyyiNQnAX9GmseIbdeo8fx1ck4L5hm01MtPMexoBgkwm
         4pMrlIHXMxoGQb+lIvtHO5V0+WYDFCDCSOb5DDji62Nsw69IHV2nCazyiploByitVX9x
         0wMWYMRencIQJmSPYVXFEs2QA0mo1igu5cYstxADzzSX9xURZkXyhuoYTMjcEDUhiz1G
         jyIQdYRL8EKpVIows++/DmMoezpXlc8mvbLOAWjIfOJgceZ+UTtHb1FsH9h2GfyFdUVE
         tywRekUo7eKvD0cmvLtNYgby+K+0j92bTg05hf08Td3dF7/amUdeQpXbn4O+iT5hiyKY
         +ITQ==
X-Gm-Message-State: AFqh2kp5T9exq3D55X0YUKcnqKG3xtSiat36963tL4l/EkODt53g2uOo
        ykRN7r3DGgBFRgLGu+d47LnAnhgURzddTg==
X-Google-Smtp-Source: AMrXdXsTQYAO6Q2FNPFL5FF5iydUP7T2+MRL5z2C2M44EbYBBjg0EEG5KDdXv76nv5T67i7PTYyP7Q==
X-Received: by 2002:a05:600c:4d97:b0:3d2:3e73:7175 with SMTP id v23-20020a05600c4d9700b003d23e737175mr6720694wmp.40.1671792498197;
        Fri, 23 Dec 2022 02:48:18 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c4e5000b003c21ba7d7d6sm4156299wmq.44.2022.12.23.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 02:48:17 -0800 (PST)
Date:   Fri, 23 Dec 2022 13:48:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Marcelo Tosatti <mtosatti@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] hwmon: coretemp: avoid RDMSR interruptions to isolated
 CPUs
Message-ID: <202212170101.tpSDqf7K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5sWMEG0xCl9bgEi@tpad>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Tosatti/hwmon-coretemp-avoid-RDMSR-interruptions-to-isolated-CPUs/20221215-204904
patch link:    https://lore.kernel.org/r/Y5sWMEG0xCl9bgEi%40tpad
patch subject: [PATCH] hwmon: coretemp: avoid RDMSR interruptions to isolated CPUs
config: i386-randconfig-m021
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/hwmon/coretemp.c:181 show_temp() warn: inconsistent returns '&tdata->update_lock'.

vim +181 drivers/hwmon/coretemp.c

199e0de7f5df31 Durgadoss R     2011-05-20  154  static ssize_t show_temp(struct device *dev,
199e0de7f5df31 Durgadoss R     2011-05-20  155  			struct device_attribute *devattr, char *buf)
199e0de7f5df31 Durgadoss R     2011-05-20  156  {
bebe467823c0d8 Rudolf Marek    2007-05-08  157  	u32 eax, edx;
199e0de7f5df31 Durgadoss R     2011-05-20  158  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
199e0de7f5df31 Durgadoss R     2011-05-20  159  	struct platform_data *pdata = dev_get_drvdata(dev);
199e0de7f5df31 Durgadoss R     2011-05-20  160  	struct temp_data *tdata = pdata->core_data[attr->index];
199e0de7f5df31 Durgadoss R     2011-05-20  161  
199e0de7f5df31 Durgadoss R     2011-05-20  162  	mutex_lock(&tdata->update_lock);
bebe467823c0d8 Rudolf Marek    2007-05-08  163  
199e0de7f5df31 Durgadoss R     2011-05-20  164  	/* Check whether the time interval has elapsed */
199e0de7f5df31 Durgadoss R     2011-05-20  165  	if (!tdata->valid || time_after(jiffies, tdata->last_updated + HZ)) {
e78264610cd902 Marcelo Tosatti 2022-12-15  166  		if (!housekeeping_cpu(tdata->cpu, HK_TYPE_MISC))
e78264610cd902 Marcelo Tosatti 2022-12-15  167  			return -EINVAL;

mutex_unlock(&tdata->update_lock);

199e0de7f5df31 Durgadoss R     2011-05-20  168  		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
bf6ea084ebb54c Guenter Roeck   2013-11-20  169  		/*
bf6ea084ebb54c Guenter Roeck   2013-11-20  170  		 * Ignore the valid bit. In all observed cases the register
bf6ea084ebb54c Guenter Roeck   2013-11-20  171  		 * value is either low or zero if the valid bit is 0.
bf6ea084ebb54c Guenter Roeck   2013-11-20  172  		 * Return it instead of reporting an error which doesn't
bf6ea084ebb54c Guenter Roeck   2013-11-20  173  		 * really help at all.
bf6ea084ebb54c Guenter Roeck   2013-11-20  174  		 */
bf6ea084ebb54c Guenter Roeck   2013-11-20  175  		tdata->temp = tdata->tjmax - ((eax >> 16) & 0x7f) * 1000;
952a11ca32a604 Paul Fertser    2021-09-24  176  		tdata->valid = true;
199e0de7f5df31 Durgadoss R     2011-05-20  177  		tdata->last_updated = jiffies;
bebe467823c0d8 Rudolf Marek    2007-05-08  178  	}
bebe467823c0d8 Rudolf Marek    2007-05-08  179  
199e0de7f5df31 Durgadoss R     2011-05-20  180  	mutex_unlock(&tdata->update_lock);
bf6ea084ebb54c Guenter Roeck   2013-11-20 @181  	return sprintf(buf, "%d\n", tdata->temp);
bebe467823c0d8 Rudolf Marek    2007-05-08  182  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

