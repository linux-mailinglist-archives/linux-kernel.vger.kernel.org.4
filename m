Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148856A2063
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBXRSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjBXRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:18:18 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4A215172
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:18:16 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-172b0ba97b0so213407fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35PGRLtjsjSa+3EItqYEIxiwSUdQKu7BSFkIqr4eHiA=;
        b=tfOX2azmW+P5tLyaCIYjJa71QCFt1Ez9MNReD9CNClgYl85FQ2A79V+0AZ3MJGKSSE
         beIXhnSNR6rgZDRt26NPtGnkXeExpdRHUsT+KeDdHALq+HShbosv+rUuqIzrVAOmQqch
         byKscWZX8cbBXkhzBVpw9ZFDYZcwLN25tPX0ZbuIIdhsKKz2MmFB4c0dzmNg4LZGkq8J
         3LNw/n2NfpfoJGkcwr5tULVuAc5Y9fm9xByTdmOdtzFCWHsubJsuKUlnk9uzDnhW8x1C
         sxzIKc+qPkVNX7pLCmO8CR/923GFL5ry9at+naPM+3O2gNsP/OsnHkhZiO4TuOTVTt6c
         48Sw==
X-Gm-Message-State: AO0yUKXOa+sM3bMau4t9BwH7uGBPxVWUaRBMKB88Q5sGH7eXkvQ+82Vm
        YNbGbLcoe9Yg9P/bGtMxHr27x0E9t+axsw==
X-Google-Smtp-Source: AK7set85JfXQILno8ExtkEWgJFuj9sSVyUI2N+YY0ZwavaJMHxakyyzqWguG9pzYTXa53JuzXj0KHA==
X-Received: by 2002:a05:6870:96a5:b0:14b:bdda:7754 with SMTP id o37-20020a05687096a500b0014bbdda7754mr13128889oaq.37.1677259095671;
        Fri, 24 Feb 2023 09:18:15 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id o186-20020a375ac3000000b0073b45004754sm4187091qkb.34.2023.02.24.09.18.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 09:18:15 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-536be69eadfso295931227b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:18:15 -0800 (PST)
X-Received: by 2002:a81:ad43:0:b0:533:91d2:9d94 with SMTP id
 l3-20020a81ad43000000b0053391d29d94mr5193404ywk.5.1677259094700; Fri, 24 Feb
 2023 09:18:14 -0800 (PST)
MIME-Version: 1.0
References: <202302240951.roaFGUy5-lkp@intel.com> <20230224084559.x2ceoc6r24uh3wms@pengutronix.de>
In-Reply-To: <20230224084559.x2ceoc6r24uh3wms@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Feb 2023 18:18:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXOr5OFwte3FNVXRUERRwJiqxVXgwCjGC_y6jxmftxrLA@mail.gmail.com>
Message-ID: <CAMuHMdXOr5OFwte3FNVXRUERRwJiqxVXgwCjGC_y6jxmftxrLA@mail.gmail.com>
Subject: Re: drivers/media/i2c/tc358746.c:817:13: warning: 'p_best' is used uninitialized
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, Feb 24, 2023 at 9:58 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> On 23-02-24, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e4bc15889506723d7b93c053ad4a75cd58248d74
> > commit: 80a21da360516fa602f3a50eb9792f9dfbfb5fdb media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver
> > date:   4 months ago
> > config: arc-randconfig-r031-20230223 (https://download.01.org/0day-ci/archive/20230224/202302240951.roaFGUy5-lkp@intel.com/config)
> > compiler: arceb-elf-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80a21da360516fa602f3a50eb9792f9dfbfb5fdb
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 80a21da360516fa602f3a50eb9792f9dfbfb5fdb
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/media/i2c/
>
> This is still a false positive, should we initialize p_best to make the
> compiler happy? I think Hans did this once, but he said that this will
> be gone with gcc-13 if I remember correctly.

Are you sure this is a false positive?

> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202302240951.roaFGUy5-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/media/i2c/tc358746.c: In function 'tc358746_find_pll_settings':
> > >> drivers/media/i2c/tc358746.c:817:13: warning: 'p_best' is used uninitialized [-Wuninitialized]
> >      817 |         u16 p_best, p;
> >          |             ^~~~~~
> > >> drivers/media/i2c/tc358746.c:816:13: warning: 'm_best' is used uninitialized [-Wuninitialized]
> >      816 |         u16 m_best, mul;
> >          |             ^~~~~~
> >
> >
> > vim +/p_best +817 drivers/media/i2c/tc358746.c
> >
> >    805
> >    806        static unsigned long tc358746_find_pll_settings(struct tc358746 *tc358746,
> >    807                                                        unsigned long refclk,
> >    808                                                        unsigned long fout)
> >    809
> >    810        {
> >    811                struct device *dev = tc358746->sd.dev;
> >    812                unsigned long best_freq = 0;
> >    813                u32 min_delta = 0xffffffff;
> >    814                u16 prediv_max = 17;
> >    815                u16 prediv_min = 1;
> >  > 816                u16 m_best, mul;
> >  > 817                u16 p_best, p;
> >    818                u8 postdiv;
> >    819
> >    820                if (fout > 1000 * HZ_PER_MHZ) {
> >    821                        dev_err(dev, "HS-Clock above 1 Ghz are not supported\n");
> >    822                        return 0;
> >    823                }
> >    824
> >    825                if (fout >= 500 * HZ_PER_MHZ)
> >    826                        postdiv = 1;
> >    827                else if (fout >= 250 * HZ_PER_MHZ)
> >    828                        postdiv = 2;
> >    829                else if (fout >= 125 * HZ_PER_MHZ)
> >    830                        postdiv = 4;
> >    831                else
> >    832                        postdiv = 8;
> >    833
> >    834                for (p = prediv_min; p <= prediv_max; p++) {
> >    835                        unsigned long delta, fin;
> >    836                        u64 tmp;
> >    837
> >    838                        fin = DIV_ROUND_CLOSEST(refclk, p);
> >    839                        if (fin < 4 * HZ_PER_MHZ || fin > 40 * HZ_PER_MHZ)
> >    840                                continue;
> >    841
> >    842                        tmp = fout * p * postdiv;
> >    843                        do_div(tmp, fin);
> >    844                        mul = tmp;
> >    845                        if (mul > 511)
> >    846                                continue;
> >    847
> >    848                        tmp = mul * fin;
> >    849                        do_div(tmp, p * postdiv);
> >    850
> >    851                        delta = abs(fout - tmp);
> >    852                        if (delta < min_delta) {

So you assume this branch will be taken at least once.
However, if the smallest delta is 0xffffffff, this is never true.
Moreover, tmp is u64, while delta is unsigned long, which is
either 32-bit or 64-bit (it is 32-bit on ARC, I think).

So I think the code can definitely be improved by cleaning up
the types, possibly killing the warning as well...

> >    853                                p_best = p;
> >    854                                m_best = mul;
> >    855                                min_delta = delta;
> >    856                                best_freq = tmp;
> >    857                        };
> >    858
> >    859                        if (delta == 0)
> >    860                                break;
> >    861                };
> >    862
> >    863                if (!best_freq) {
> >    864                        dev_err(dev, "Failed find PLL frequency\n");
> >    865                        return 0;
> >    866                }
> >    867
> >    868                tc358746->pll_post_div = postdiv;
> >    869                tc358746->pll_pre_div = p_best;
> >    870                tc358746->pll_mul = m_best;
> >    871
> >    872                if (best_freq != fout)
> >    873                        dev_warn(dev, "Request PLL freq:%lu, found PLL freq:%lu\n",
> >    874                                 fout, best_freq);
> >    875
> >    876                dev_dbg(dev, "Found PLL settings: freq:%lu prediv:%u multi:%u postdiv:%u\n",
> >    877                        best_freq, p_best, m_best, postdiv);
> >    878
> >    879                return best_freq;
> >    880        }
> >    881

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
