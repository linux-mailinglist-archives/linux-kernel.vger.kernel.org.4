Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55027420AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF2Gxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjF2GxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:53:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3613E170F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:53:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso3562965e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688021600; x=1690613600;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhjK6sIK66Oywf/hcY6JkHXpmd2mlEaON7WL3gqbXH4=;
        b=D+3t7hoc/1nO9xEQOaUH4DjrV2tZRA6ANa3fEKpuly6OsUUHjgRTgovgBE1jbaBdkB
         xSvXFcIG4RIp9fmnve4EbO3FXBHU2oHvnF+87T71qiJ1mC2CJIPNWr+Rm0itZI4+hNuk
         i9zJpjTTWrwRYZ/QXRvMp3kx5cxTLn96djJMMbJo637w/wmDnrxiGHUmI7GRYSwrj46C
         9FV1gtZcMYYNCxcgKYSJswguPHGENF2Ll7YnT2z/KKbxzqBO+T1sSSt0Xrs9mzsbMjF5
         a/KsnVyaJ7gFonhdBC66rrQ3dI7PazD/xXL8oAqQtmUMzRZzmekLANYZ5EEmAWJhesLe
         voOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688021600; x=1690613600;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhjK6sIK66Oywf/hcY6JkHXpmd2mlEaON7WL3gqbXH4=;
        b=WZkyQUN30NrWRqN1333yc/y+kfSKQqVmhjWnriWej5GL2WSzgujyRX4uboQbrkqt00
         /OhqaQcTuAZclqZAZ5L3zS30ctbjtZXfKYDIhwU35jl8LamcLlnTIFI9mZDH+ePhUbk3
         p3X9O8EFq31lkF2vZEEImC3Ka4qL4ACAKMOw3vPpPQ4rU/u72UnDEubP+SrhS8ODSnBk
         mPIsaDOFla+DTor7seODia5/cPpB03R8goWBg1Y3ExmmaOEI1wtqZag7o0UJ3lH5EmYU
         Ju2Vl9jAZNC6i7ETxCuU3AA6+U545yg832cumKXOgVJMY24QdglGjMZE5dGOrIDA6AuV
         sO8g==
X-Gm-Message-State: AC+VfDxp9mOjCTzvXhjG0qDEo+EerjmN3zczIOG17zbePE6kEiwMWLew
        TCLuFAQQEhf+41FfCI3YM6o8OA==
X-Google-Smtp-Source: ACHHUZ5xh5DE+84LDhRuxDKNAqTYdinTroqj86PueXQ/JA1QuzF2Lz4rvH8/zpTEMfGEjqGZkXSB0w==
X-Received: by 2002:a7b:ca5a:0:b0:3fb:afa0:9a33 with SMTP id m26-20020a7bca5a000000b003fbafa09a33mr3407620wml.15.1688021600677;
        Wed, 28 Jun 2023 23:53:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c13-20020a7bc00d000000b003f735ba7736sm15873675wmb.46.2023.06.28.23.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 23:53:19 -0700 (PDT)
Date:   Thu, 29 Jun 2023 09:53:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Eddie James <eajames@linux.ibm.com>,
        linux-hwmon@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, lakshmiy@us.ibm.com,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs
 attribute
Message-ID: <b12935a2-a8b7-4d70-8c7d-6fd1e92037c2@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627184027.16343-1-eajames@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/hwmon-pmbus-acbel-fsg032-Add-firmware-version-debugfs-attribute/20230628-030615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230627184027.16343-1-eajames%40linux.ibm.com
patch subject: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs attribute
config: x86_64-randconfig-m001-20230627 (https://download.01.org/0day-ci/archive/20230628/202306281205.NFXmu7xb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230628/202306281205.NFXmu7xb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202306281205.NFXmu7xb-lkp@intel.com/

smatch warnings:
drivers/hwmon/pmbus/acbel-fsg032.c:36 acbel_fsg032_debugfs_read() warn: argument 4 to %02X specifier has type 'char'

vim +/char +36 drivers/hwmon/pmbus/acbel-fsg032.c

d2c6444389b625 Eddie James 2023-06-27  17  static ssize_t acbel_fsg032_debugfs_read(struct file *file, char __user *buf, size_t count,
d2c6444389b625 Eddie James 2023-06-27  18  					 loff_t *ppos)
d2c6444389b625 Eddie James 2023-06-27  19  {
d2c6444389b625 Eddie James 2023-06-27  20  	struct i2c_client *client = file->private_data;
d2c6444389b625 Eddie James 2023-06-27  21  	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };

data should probably be a u8.

d2c6444389b625 Eddie James 2023-06-27  22  	char out[8];
d2c6444389b625 Eddie James 2023-06-27  23  	int rc;
d2c6444389b625 Eddie James 2023-06-27  24  	int i;
d2c6444389b625 Eddie James 2023-06-27  25  
d2c6444389b625 Eddie James 2023-06-27  26  	rc = pmbus_lock_interruptible(client);
d2c6444389b625 Eddie James 2023-06-27  27  	if (rc)
d2c6444389b625 Eddie James 2023-06-27  28  		return rc;
d2c6444389b625 Eddie James 2023-06-27  29  
d2c6444389b625 Eddie James 2023-06-27  30  	rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, data);
d2c6444389b625 Eddie James 2023-06-27  31  	pmbus_unlock(client);
d2c6444389b625 Eddie James 2023-06-27  32  	if (rc < 0)
d2c6444389b625 Eddie James 2023-06-27  33  		return rc;
d2c6444389b625 Eddie James 2023-06-27  34  
d2c6444389b625 Eddie James 2023-06-27  35  	for (i = 0; i < rc && i < 3; ++i)
d2c6444389b625 Eddie James 2023-06-27 @36  		snprintf(&out[i * 2], 3, "%02X", data[i]);

If data[i] is negative this will print FFFFFFF1 etc.  (This is an x86
config...  Did we ever merge that patch to make char signed by default?)

d2c6444389b625 Eddie James 2023-06-27  37  
d2c6444389b625 Eddie James 2023-06-27  38  	rc = i * 2;
d2c6444389b625 Eddie James 2023-06-27  39  	out[rc++] = '\n';
d2c6444389b625 Eddie James 2023-06-27  40  	out[rc++] = 0;
d2c6444389b625 Eddie James 2023-06-27  41  	return simple_read_from_buffer(buf, count, ppos, out, rc);
d2c6444389b625 Eddie James 2023-06-27  42  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

