Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8028E728CE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbjFIBLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbjFIBLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:11:13 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B711734
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:11:11 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-55554c33bf3so818452eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273070; x=1688865070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t04VHxxvgy87m1PmWNniDTbl7PTXZyrjVB3uf4V0HA=;
        b=mTk9d4eUqpL2hSkyiy7p1kHFt9V500PQg8nfV5Dl4cS4evEwmPy6yoHgV5DHmS3FxK
         NbgZA37nQ/GUtPrHxqAHe1cNZhEnEiDbVi1MDMRm0zHSlGl5BNGK7uCjjpFBux9c+j4m
         REhnC/GG2TdYlOYMiqxqlWIQc++Bu4uKChohoeciOUW6HfCGVaDf+NlbjzQo9TtcAse5
         gUuyWQNVxzZVCWPx/zM0xrP4L/OhloKweaQleGmQfZ3UcErbnExBga9EGqTaFYExc9D5
         A9Y3Jdvc+OAAwKqa56dKjn32pSlzGTLRZyRot52zNuzCebUrdqBAIefaXWOJlF0MYnyW
         SLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273070; x=1688865070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t04VHxxvgy87m1PmWNniDTbl7PTXZyrjVB3uf4V0HA=;
        b=CShmj+YH8HFly++CRmg4XP4VxHsosTQZVBcOEcaNIzGtOG8wvYtBNJKaR6PQxntqIY
         UI3r3Tod34nX6iiN7HPh4KPpboO9YylAuGMfKMMONPLY8Y/zZ2LP522cbOMco9Ny5iBu
         6tQsZ7To7pMoLRQifFs/KjEwXrDQdGOmcudgt9F6UrbiWmz03D6WtRoPdNTFp4kvPFwp
         K6lEi4D5xnbv91x6QgEDA5CqeyV/nCg1BC2aoud4fzIe5kVPGAL7TEuXXLyPyzFlA3Zd
         Q1UrsfSftuHC2W7ioa/lIqNMV2mjqwUZk4sJhR2YoOGLmQsiEuzEoCHJimhVwxtBk1SK
         YeVA==
X-Gm-Message-State: AC+VfDwSL2TDGbTThtYPWppH7rYM0ysLki0R2MOy4GDQdCaNyz0oEgCJ
        X3YSGdWbPT2EBtM9sQLRhQChDQoRC3pLUzFVCboTFg==
X-Google-Smtp-Source: ACHHUZ7yaBLm0LL+IwFANCK4QJtFGTbyC/PIvIHBAEqLfn3M8KtkReRXt0/UiFfb7ZyHQbQG86UTdc1f5axmdMSv/Bg=
X-Received: by 2002:a05:6808:1b10:b0:398:581:aedd with SMTP id
 bx16-20020a0568081b1000b003980581aeddmr152154oib.37.1686273070437; Thu, 08
 Jun 2023 18:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230608204517.105396-2-badhri@google.com> <202306090722.opxFRfOO-lkp@intel.com>
In-Reply-To: <202306090722.opxFRfOO-lkp@intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 8 Jun 2023 18:10:33 -0700
Message-ID: <CAPTae5+iL0sG8kezCLMFj26QB51L7hoWno63PHiPpepFsKf0Wg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] usb: gadget: udc: core: Prevent
 soft_connect_store() race
To:     kernel test robot <lkp@intel.com>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        colin.i.king@gmail.com, xuetao09@huawei.com,
        quic_eserrao@quicinc.com, water.zhangjiantao@huawei.com,
        peter.chen@freescale.com, balbi@ti.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the unused out labels reported by test in v8.

Regards,
Badhri

On Thu, Jun 8, 2023 at 4:20=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Badhri,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on d37537a1f7cf09e304fe7993cb5e732534a0fb22]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Badhri-Jagan-Sridh=
aran/usb-gadget-udc-core-Prevent-soft_connect_store-race/20230609-044555
> base:   d37537a1f7cf09e304fe7993cb5e732534a0fb22
> patch link:    https://lore.kernel.org/r/20230608204517.105396-2-badhri%4=
0google.com
> patch subject: [PATCH v7 2/2] usb: gadget: udc: core: Prevent soft_connec=
t_store() race
> config: hexagon-randconfig-r015-20230608 (https://download.01.org/0day-ci=
/archive/20230609/202306090722.opxFRfOO-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git =
4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=3D1 build):
>         mkdir -p ~/bin
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout d37537a1f7cf09e304fe7993cb5e732534a0fb22
>         b4 shazam https://lore.kernel.org/r/20230608204517.105396-2-badhr=
i@google.com
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang ~/bin/make.cr=
oss W=3D1 O=3Dbuild_dir ARCH=3Dhexagon olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang ~/bin/make.cr=
oss W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/usb/gadget=
/udc/
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306090722.opxFRfOO-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/usb/gadget/udc/core.c:17:
>    In file included from include/linux/dma-mapping.h:10:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:547:31: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      547 |         val =3D __raw_readb(PCI_IOBASE + addr);
>          |                           ~~~~~~~~~~ ^
>    include/asm-generic/io.h:560:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      560 |         val =3D __le16_to_cpu((__le16 __force)__raw_readw(PCI_=
IOBASE + addr));
>          |                                                         ~~~~~~=
~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded fro=
m macro '__le16_to_cpu'
>       37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>          |                                                   ^
>    In file included from drivers/usb/gadget/udc/core.c:17:
>    In file included from include/linux/dma-mapping.h:10:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:573:61: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      573 |         val =3D __le32_to_cpu((__le32 __force)__raw_readl(PCI_=
IOBASE + addr));
>          |                                                         ~~~~~~=
~~~~ ^
>    include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded fro=
m macro '__le32_to_cpu'
>       35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>          |                                                   ^
>    In file included from drivers/usb/gadget/udc/core.c:17:
>    In file included from include/linux/dma-mapping.h:10:
>    In file included from include/linux/scatterlist.h:9:
>    In file included from arch/hexagon/include/asm/io.h:334:
>    include/asm-generic/io.h:584:33: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      584 |         __raw_writeb(value, PCI_IOBASE + addr);
>          |                             ~~~~~~~~~~ ^
>    include/asm-generic/io.h:594:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBA=
SE + addr);
>          |                                                       ~~~~~~~~=
~~ ^
>    include/asm-generic/io.h:604:59: warning: performing pointer arithmeti=
c on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBA=
SE + addr);
>          |                                                       ~~~~~~~~=
~~ ^
> >> drivers/usb/gadget/udc/core.c:850:1: warning: unused label 'out' [-Wun=
used-label]
>      850 | out:
>          | ^~~~
>      851 |         trace_usb_gadget_deactivate(gadget, ret);
>    drivers/usb/gadget/udc/core.c:886:1: warning: unused label 'out' [-Wun=
used-label]
>      886 | out:
>          | ^~~~
>      887 |         trace_usb_gadget_activate(gadget, ret);
>    8 warnings generated.
>
>
> vim +/out +850 drivers/usb/gadget/udc/core.c
>
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  815
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  816  /**
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  817   * usb_gadget_deactivate - deactivate function which is not=
 ready to work
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  818   * @gadget: the peripheral being deactivated
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  819   *
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  820   * This routine may be used during the gadget driver bind()=
 call to prevent
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  821   * the peripheral from ever being visible to the USB host, =
unless later
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  822   * usb_gadget_activate() is called.  For example, user mode=
 components may
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  823   * need to be activated before the system can talk to hosts=
.
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  824   *
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  825   * Returns zero on success, else negative errno.
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  826   */
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  827  int usb_gadget_deactivate(struct usb_gadget *gadget)
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  828  {
> 5e42d710a108c2 drivers/usb/gadget/udc/core.c     Felipe Balbi           2=
016-05-31  829         int ret =3D 0;
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  830
> bfc8a68e3289a9 drivers/usb/gadget/udc/core.c     Badhri Jagan Sridharan 2=
023-06-08  831         mutex_lock(&gadget->udc->connect_lock);
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  832         if (gadget->deactivated)
> bfc8a68e3289a9 drivers/usb/gadget/udc/core.c     Badhri Jagan Sridharan 2=
023-06-08  833                 goto unlock;
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  834
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  835         if (gadget->connected) {
> bfc8a68e3289a9 drivers/usb/gadget/udc/core.c     Badhri Jagan Sridharan 2=
023-06-08  836                 ret =3D usb_gadget_disconnect_locked(gadget)=
;
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  837                 if (ret)
> bfc8a68e3289a9 drivers/usb/gadget/udc/core.c     Badhri Jagan Sridharan 2=
023-06-08  838                         goto unlock;
> 5e42d710a108c2 drivers/usb/gadget/udc/core.c     Felipe Balbi           2=
016-05-31  839
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  840                 /*
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  841                  * If gadget was being connected before deac=
tivation, we want
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  842                  * to reconnect it in usb_gadget_activate().
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  843                  */
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  844                 gadget->connected =3D true;
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  845         }
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  846         gadget->deactivated =3D true;
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  847
> bfc8a68e3289a9 drivers/usb/gadget/udc/core.c     Badhri Jagan Sridharan 2=
023-06-08  848  unlock:
> bfc8a68e3289a9 drivers/usb/gadget/udc/core.c     Badhri Jagan Sridharan 2=
023-06-08  849         mutex_unlock(&gadget->udc->connect_lock);
> 5e42d710a108c2 drivers/usb/gadget/udc/core.c     Felipe Balbi           2=
016-05-31 @850  out:
> 5e42d710a108c2 drivers/usb/gadget/udc/core.c     Felipe Balbi           2=
016-05-31  851         trace_usb_gadget_deactivate(gadget, ret);
> 5e42d710a108c2 drivers/usb/gadget/udc/core.c     Felipe Balbi           2=
016-05-31  852
> 5e42d710a108c2 drivers/usb/gadget/udc/core.c     Felipe Balbi           2=
016-05-31  853         return ret;
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  854  }
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  855  EXPORT_SYMBOL_GPL(usb_gadget_deactivate);
> 5a8d651a2bde01 drivers/usb/gadget/udc/udc-core.c Felipe Balbi           2=
016-05-31  856
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
