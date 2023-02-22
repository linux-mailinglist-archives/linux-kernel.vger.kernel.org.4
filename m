Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7981269F5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjBVN4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBVN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:56:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E9F34318
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:56:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bt28so1152907wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfx9GIQthScNznDFCqzH5flRQGeg4eShNoLLTObVoqA=;
        b=Ha643dO7qOiXprayRf0OAdAt/+8RG80sykrJEsfP9GWJt8VQeVB4fmFnwVCIwAwtdP
         +KNCzM/C1wuEDeHxEhQ5BFPmOiv3TlJ9l2zcwDLtlI2vkS9/d+BCdQbxBj/zFNOrTix/
         TOd+VSkQjuBxGyHbEwcMRioKmorTeRuwqyewWEbVzOVTIQzwu/IPRvQhw6KY/Dh9LrL3
         JmPQyEnw9Ij8mAIiXtmx7DNQRNBLfXd1GXfNyRJ4v7Y1OfCKNZ0CBrR5KrqIHOaJxs8v
         GTgdKBy6t0ZK0IqxUTphw6APtCGyLm38tXwPU5QAxL1iCFFYRPExfjamJs+8wG/LCxkV
         MIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfx9GIQthScNznDFCqzH5flRQGeg4eShNoLLTObVoqA=;
        b=zL+fH5lBUt5v7s31pZPQBed3CXg2lwf+9ZPjUZdhSyOm1jqw8u0QUpSWbaRAWeW6Nk
         kFOqchtD3oo7dEnkbBWUdcc3FX3nfaTOEhMMmjEjqX0gZlodBOQGG4kGSIrj43UJkYza
         imJpvnvI6tIsp0KhMtYxfIyl/hg5EQpWlk4KiaH/SQV9G8W3OLrIVtltrniLJokswLyL
         2spTWlcNsti/qLsubq1itArFXj2d3vd6QtsqetYV1VIf6NB5PyL5LgpIVIJu2wykNSTH
         gyS1VnqB9NdjDj9A2eAAdB23CURKTDe3PVtaxk1m6ta4cO/R9QCq4o5w/bygED00WI8g
         JSQw==
X-Gm-Message-State: AO0yUKWXvLVL5ln4bNpgWcSwVW5rReHTIaEFOiYhPHAMcEzmQeoz+cVY
        CVvJq9M3C2v04PzIgcPALIk=
X-Google-Smtp-Source: AK7set/BZUgjOOWNxLFNSLaMwtt4XeAzoHzo3TtmzM8CLiXfvOuloxjE/JqxKdWQIMBs/BXixCtbiQ==
X-Received: by 2002:a5d:5141:0:b0:2c5:9fc4:8844 with SMTP id u1-20020a5d5141000000b002c59fc48844mr7525389wrt.9.1677074172064;
        Wed, 22 Feb 2023 05:56:12 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b002c561805a4csm9490203wrt.45.2023.02.22.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:56:11 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:56:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: arch/arm64/kernel/acpi.c:443 acpi_ffh_address_space_arch_setup()
 warn: possible memory leak of 'ffh_ctxt'
Message-ID: <202302191417.dAl9NuE8-lkp@intel.com>
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
head:   925cf0457d7e62ce08878ffb789189ac08ca8677
commit: 45494d77f279d0420f06376dcf105b23e300c5a4 Merge branches 'acpi-scan', 'acpi-bus', 'acpi-tables' and 'acpi-sysfs'
config: arm64-randconfig-m031-20230219 (https://download.01.org/0day-ci/archive/20230219/202302191417.dAl9NuE8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302191417.dAl9NuE8-lkp@intel.com/

New smatch warnings:
arch/arm64/kernel/acpi.c:443 acpi_ffh_address_space_arch_setup() warn: possible memory leak of 'ffh_ctxt'

Old smatch warnings:
arch/arm64/kernel/acpi.c:448 acpi_ffh_address_space_arch_setup() warn: possible memory leak of 'ffh_ctxt'

vim +/ffh_ctxt +443 arch/arm64/kernel/acpi.c

1d280ce099db39 Sudeep Holla 2022-11-10  433  int acpi_ffh_address_space_arch_setup(void *handler_ctxt, void **region_ctxt)
1d280ce099db39 Sudeep Holla 2022-11-10  434  {
1d280ce099db39 Sudeep Holla 2022-11-10  435  	enum arm_smccc_conduit conduit;
1d280ce099db39 Sudeep Holla 2022-11-10  436  	struct acpi_ffh_data *ffh_ctxt;
1d280ce099db39 Sudeep Holla 2022-11-10  437  
1d280ce099db39 Sudeep Holla 2022-11-10  438  	ffh_ctxt = kzalloc(sizeof(*ffh_ctxt), GFP_KERNEL);
1d280ce099db39 Sudeep Holla 2022-11-10  439  	if (!ffh_ctxt)
1d280ce099db39 Sudeep Holla 2022-11-10  440  		return -ENOMEM;
1d280ce099db39 Sudeep Holla 2022-11-10  441  
1d280ce099db39 Sudeep Holla 2022-11-10  442  	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
1d280ce099db39 Sudeep Holla 2022-11-10 @443  		return -EOPNOTSUPP;

Do these checks before the ffh_ctxt = kzalloc()?

1d280ce099db39 Sudeep Holla 2022-11-10  444  
1d280ce099db39 Sudeep Holla 2022-11-10  445  	conduit = arm_smccc_1_1_get_conduit();
1d280ce099db39 Sudeep Holla 2022-11-10  446  	if (conduit == SMCCC_CONDUIT_NONE) {
1d280ce099db39 Sudeep Holla 2022-11-10  447  		pr_err("%s: invalid SMCCC conduit\n", __func__);
1d280ce099db39 Sudeep Holla 2022-11-10  448  		return -EOPNOTSUPP;

Same

1d280ce099db39 Sudeep Holla 2022-11-10  449  	}
1d280ce099db39 Sudeep Holla 2022-11-10  450  
1d280ce099db39 Sudeep Holla 2022-11-10  451  	if (conduit == SMCCC_CONDUIT_SMC) {
1d280ce099db39 Sudeep Holla 2022-11-10  452  		ffh_ctxt->invoke_ffh_fn = __arm_smccc_smc;
1d280ce099db39 Sudeep Holla 2022-11-10  453  		ffh_ctxt->invoke_ffh64_fn = arm_smccc_1_2_smc;
1d280ce099db39 Sudeep Holla 2022-11-10  454  	} else {
1d280ce099db39 Sudeep Holla 2022-11-10  455  		ffh_ctxt->invoke_ffh_fn = __arm_smccc_hvc;
1d280ce099db39 Sudeep Holla 2022-11-10  456  		ffh_ctxt->invoke_ffh64_fn = arm_smccc_1_2_hvc;
1d280ce099db39 Sudeep Holla 2022-11-10  457  	}
1d280ce099db39 Sudeep Holla 2022-11-10  458  
1d280ce099db39 Sudeep Holla 2022-11-10  459  	memcpy(ffh_ctxt, handler_ctxt, sizeof(ffh_ctxt->info));
1d280ce099db39 Sudeep Holla 2022-11-10  460  
1d280ce099db39 Sudeep Holla 2022-11-10  461  	*region_ctxt = ffh_ctxt;
1d280ce099db39 Sudeep Holla 2022-11-10  462  	return AE_OK;
1d280ce099db39 Sudeep Holla 2022-11-10  463  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

