Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484D55E5E64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIVJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIVJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:21:00 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25611164;
        Thu, 22 Sep 2022 02:20:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 63so11887459ybq.4;
        Thu, 22 Sep 2022 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2+S7HlEBuVCJM6F80dB4f4rhA0eBwB5EJEsljjj7oEQ=;
        b=R61FC6aLSg96pCV7GEgkVJaRSMSzV4HdLoxaGeQqb6KMHlOElwQFntvX2tiU8aHuSr
         kuY33t90hDFNARwlj4HAGOOK/Ragw8GM1WaZ63Y/q213syPamW2RSRhyJ0uSIw2kzXPp
         r7AshXemKH5rGdmvklR/pmijvIjz/3i1eE4EkfaPDBPQVEww4AJMw9tLMJ/7oWHs/70u
         6JnJzh2bcBv2FFftlv2rhJfFM0G4ZsYjf0+I6q7anQT3JW6tEYYCtLcrM2do2JT2tknk
         23glncEimVMOmnZmFtNlprQj2K/M+2dMZUf2NmXO59pcScVGS+YobiNU9Q4xL9Q00V4q
         KVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2+S7HlEBuVCJM6F80dB4f4rhA0eBwB5EJEsljjj7oEQ=;
        b=nFOd1zpqVKsxqXeILdrwwFM1AJjhl4g58zPk5mPK4q0nz2ggSv/Xs4C6t7n2A0irEB
         H0uQknpP6pjAaYdTpj1YWB7vmTOqSLZeIO3yXFYh/QpUqe5W1j34X2Laq0eoZ/Fmwrst
         N2aQ5jqfD43qYhivNxT31wUz5uW/dm7bysmykvsF43lRQRPyAXKJQqSb2cdgoqVX4Ix0
         36HPzmIXSrHaCzpLVS+7QTBTHN2wwVtM/LD/+bQZ9OBS2eKYtfJJFzb0pUG88xIntwW7
         GtItHcdcvOX+i/MWciNS+q+BcQqNKNr+JgPEpByvtkJ71NpszbI+i4SVuaVHIspV9fe7
         OQSw==
X-Gm-Message-State: ACrzQf2D+4Xy+FUytauXou6zw99W5knIPZ5wG4AX/icgRMG2OSDGBE3b
        HU7YuGcJSL/ENrCOpNKfPsjc3OxkFhO2Zwh0y28=
X-Google-Smtp-Source: AMsMyM5EyN7u4n8EdbXrBjCRzmUqkG32AKx0gm9gp4ayEyX1apBgRrSArCx2QDVBntwIADukECOsIoP/EiUdHpNR/MM=
X-Received: by 2002:a25:bd52:0:b0:6b4:22fa:8226 with SMTP id
 p18-20020a25bd52000000b006b422fa8226mr2621525ybm.31.1663838457943; Thu, 22
 Sep 2022 02:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220919060342.26400-1-lukas.bulwahn@gmail.com> <202209192252.T6IGLNqC-lkp@intel.com>
In-Reply-To: <202209192252.T6IGLNqC-lkp@intel.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 22 Sep 2022 11:20:47 +0200
Message-ID: <CAKXUXMy=1_AvqwhjEzaov5jj4sCiB5vB67QsXA395-J7N2Vtqg@mail.gmail.com>
Subject: Re: [PATCH] crypto: add rsize config to .config only if lib_poly1305
 is set
To:     kernel test robot <lkp@intel.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 5:10 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Lukas,
>
> I love your patch! Yet something to improve:

Thanks, kernel test robot ;)

Okay, I see that I need to reiterate on this patch. The crypto caam
driver pulls in a number of headers without a dependency with Kconfig
on the corresponding config symbol here. I will check if I find a good
solution for that.

For now, this patch can be ignored until I find time to send out a patch v2.

Lukas

>
> [auto build test ERROR on herbert-cryptodev-2.6/master]
> [also build test ERROR on herbert-crypto-2.6/master linus/master v6.0-rc6 next-20220919]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lukas-Bulwahn/crypto-add-rsize-config-to-config-only-if-lib_poly1305-is-set/20220919-140531
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20220919/202209192252.T6IGLNqC-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/c1954797e493eabf02f354e290fe380ace0633e4
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Lukas-Bulwahn/crypto-add-rsize-config-to-config-only-if-lib_poly1305-is-set/20220919-140531
>         git checkout c1954797e493eabf02f354e290fe380ace0633e4
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/crypto/caam/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/crypto/caam/ctrl.c:15:
>    In file included from drivers/crypto/caam/compat.h:41:
> >> include/crypto/poly1305.h:56:32: error: use of undeclared identifier 'CONFIG_CRYPTO_LIB_POLY1305_RSIZE'
>                    struct poly1305_key opaque_r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
>                                                 ^
>    1 error generated.
>
>
> vim +/CONFIG_CRYPTO_LIB_POLY1305_RSIZE +56 include/crypto/poly1305.h
>
> 878afc35cd28bc Eric Biggers       2018-11-16  40
> 2546f811ef45fc Martin Willi       2015-07-16  41  struct poly1305_desc_ctx {
> 2546f811ef45fc Martin Willi       2015-07-16  42        /* partial buffer */
> 2546f811ef45fc Martin Willi       2015-07-16  43        u8 buf[POLY1305_BLOCK_SIZE];
> 2546f811ef45fc Martin Willi       2015-07-16  44        /* bytes used in partial buffer */
> 2546f811ef45fc Martin Willi       2015-07-16  45        unsigned int buflen;
> ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  46        /* how many keys have been set in r[] */
> ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  47        unsigned short rset;
> ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  48        /* whether s[] has been set */
> 2546f811ef45fc Martin Willi       2015-07-16  49        bool sset;
> ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  50        /* finalize key */
> ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  51        u32 s[4];
> ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  52        /* accumulator */
> ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  53        struct poly1305_state h;
> ad8f5b88383ea6 Ard Biesheuvel     2019-11-08  54        /* key */
> 1c08a104360f3e Jason A. Donenfeld 2020-01-05  55        union {
> 1c08a104360f3e Jason A. Donenfeld 2020-01-05 @56                struct poly1305_key opaque_r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
> 1c08a104360f3e Jason A. Donenfeld 2020-01-05  57                struct poly1305_core_key core_r;
> 1c08a104360f3e Jason A. Donenfeld 2020-01-05  58        };
> 2546f811ef45fc Martin Willi       2015-07-16  59  };
> 2546f811ef45fc Martin Willi       2015-07-16  60
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
