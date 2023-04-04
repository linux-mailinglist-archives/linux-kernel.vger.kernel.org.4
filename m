Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613E06D5EBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjDDLN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjDDLN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4019A7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680606789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+vCrGsG4EGlFPdvDqtaQU8ToAjG1wpvWgMdAwD4jDE=;
        b=Ki49OWuQvREPvvug9nMqnPnbZbesmDlykKoXH4Zv1HH23ka2PBA1CuH/DdNbUYgSF/45xq
        1Ni5BcklVgy0uRNaPXag1jsCyAZCACLzhmwX56Yd4s/gxdEgUGTmWM6DAzGaQELqwsnzbb
        kAeMx08oVMGwY/UaXIB5jb4XN/GNnkg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-3FhpmE3rOtWYyykwWkoDNA-1; Tue, 04 Apr 2023 07:13:07 -0400
X-MC-Unique: 3FhpmE3rOtWYyykwWkoDNA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5419fb7d6c7so318793227b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680606787;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+vCrGsG4EGlFPdvDqtaQU8ToAjG1wpvWgMdAwD4jDE=;
        b=HK7TiHDNdO8N7YAjL+YmVd+xD9JIX79xIKYea6TtA8YQHLadZ0b0j70wb3Um0s0TCr
         0FhhMluOAN1ILoBmHA6S4ClcPzyEFdPKdBha6bODEN5KATsYsg6gh7sUlcvd3hBSfO/3
         JkKgORDffVaQkgAOrujNkcpllLgZohZKsR37HrIKE2+y1sQQNFDmNFgOCM6fU5brz02D
         eRoOLJezH+1YQm1rq7C5fbHev9qdmlSpxtbeWU3qvdokmAd6J1xdL3ZHSzoq070UqVBe
         2OeBpBR1bdYSA1yfjqnfvZxAs11A5Grhg+/afEn1PeyPaCI4rl8BzkMhvl9ljjRq5Gtu
         GHmg==
X-Gm-Message-State: AAQBX9dsOb+iIrhvzU+eTm9iIhq4NC9l3HVZGyQI4t2yhwjmXnFVTo1I
        kbMgrO/rlN0qPni9HMaVzFRK+HPHgFJmSz0eFjhJbTiiXIZmMh0xI+3+CIHdF7EwLHqIuHDb4xP
        uXsu8aSSNt4Ve3ArPkwIRP7Fz
X-Received: by 2002:a81:de53:0:b0:541:978c:5d2 with SMTP id o19-20020a81de53000000b00541978c05d2mr1814291ywl.10.1680606787337;
        Tue, 04 Apr 2023 04:13:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y96Ha20GEcd6uktYakCn5N8OghHenjtSfQerSC/XyJhNsXG37WCXbO5Be6es9Di9Vy8mgtdA==
X-Received: by 2002:a81:de53:0:b0:541:978c:5d2 with SMTP id o19-20020a81de53000000b00541978c05d2mr1814280ywl.10.1680606787038;
        Tue, 04 Apr 2023 04:13:07 -0700 (PDT)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id cd8-20020a05690c088800b00545a08184f6sm3114810ywb.134.2023.04.04.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:13:06 -0700 (PDT)
Date:   Tue, 4 Apr 2023 07:13:03 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     jic23@kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, andriy.shevchenko@linux.intel.com,
        trix@redhat.com, lars@metafoo.de, nathan@kernel.org,
        ndesaulniers@google.com, u.kleine-koenig@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com
Subject: Re: [PATCH] iio: light: tsl2772: fix reading proximity-diodes from
 device tree
Message-ID: <ZCwGP6rBLgbDGvkv@x1>
References: <20230404011455.339454-1-bmasney@redhat.com>
 <202304041451.gj8oasQp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304041451.gj8oasQp-lkp@intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel test robot maintainers,

On Tue, Apr 04, 2023 at 03:13:24PM +0800, kernel test robot wrote:
> Hi Brian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on linus/master v6.3-rc5 next-20230403]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Masney/iio-light-tsl2772-fix-reading-proximity-diodes-from-device-tree/20230404-091630
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20230404011455.339454-1-bmasney%40redhat.com
> patch subject: [PATCH] iio: light: tsl2772: fix reading proximity-diodes from device tree
> config: x86_64-randconfig-a001-20230403 (https://download.01.org/0day-ci/archive/20230404/202304041451.gj8oasQp-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/9701bd10d6409568197894b603f8a1e23280e82b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Brian-Masney/iio-light-tsl2772-fix-reading-proximity-diodes-from-device-tree/20230404-091630
>         git checkout 9701bd10d6409568197894b603f8a1e23280e82b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/light/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304041451.gj8oasQp-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/iio/light/tsl2772.c:599:30: error: use of undeclared identifier 'prox_diode_mask'; did you mean 'protnone_mask'?
>            chip->settings.prox_diode = prox_diode_mask;
>                                        ^~~~~~~~~~~~~~~
>                                        protnone_mask
>    arch/x86/include/asm/pgtable-invert.h:22:19: note: 'protnone_mask' declared here
>    static inline u64 protnone_mask(u64 val)
>                      ^
>    1 error generated.
> 
> 
> vim +599 drivers/iio/light/tsl2772.c
> 
>    572	
>    573	static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
>    574	{
>    575		struct device *dev = &chip->client->dev;
>    576		int i, ret, num_leds;
>    577		u32 leds[TSL2772_MAX_PROX_LEDS];
>    578	
>    579		ret = device_property_count_u32(dev, "amstaos,proximity-diodes");
>    580		if (ret < 0)
>    581			return ret;
>    582	
>    583		num_leds = ret;
>    584		if (num_leds > TSL2772_MAX_PROX_LEDS)
>    585			num_leds = TSL2772_MAX_PROX_LEDS;
>    586	
>    587		ret = device_property_read_u32_array(dev, "amstaos,proximity-diodes", leds, num_leds);
>    588		if (ret < 0) {
>    589			dev_err(dev, "Invalid value for amstaos,proximity-diodes: %d.\n", ret);
>    590			return ret;
>    591		}
>    592	
>    593		for (i = 0; i < num_leds; i++) {
>    594			if (leds[i] > 1) {
>    595				dev_err(dev, "Invalid value %d in amstaos,proximity-diodes.\n", leds[i]);
>    596				return -EINVAL;
>    597			}
>    598		}
>  > 599		chip->settings.prox_diode = prox_diode_mask;
>    600	
>    601		return 0;
>    602	}
>    603	

This doesn't contain the code that's in iio/togreg [1], and that's why
the build failed. I originally developed / built this against
next-20230330. I just checked linus/master, next-20230404, iio/testing,
and all have the expected code that defines prox_diode_mask.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/light/tsl2772.c?h=togreg#n593

Brian

