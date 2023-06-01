Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033B7719F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjFAOQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjFAOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:16:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE8180
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:16:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d41763796so589112b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685628989; x=1688220989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twYg540X1PIqbMF2MOY+lphD+IJXhD0ehbrQ95GCUew=;
        b=jGOM7i6CcGiTXBM1GKdxW+jDWjdpp2qglXKx6pdPELGipE5rc4OtuIloV7IG5PtsTa
         AhO2ZY5uCu1mLbAzLjCtGTTEbs/0A5y+LD09wjEcQHrh5s5BmE8SOnMudG2hb0hv4qJI
         63ENFL98pu0rrzG4Yqkt9aFn60UFMHD/omZWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628989; x=1688220989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twYg540X1PIqbMF2MOY+lphD+IJXhD0ehbrQ95GCUew=;
        b=HOmKaUkJ2y6dNQQ9Y8U8joWb10gBkfd0oi6EJ4vOgNLMlXjD+/ZgsseYEqvxERk63X
         y5HlxmOkI17eSy9hHKPDiqWRG5Ft/riKHoTsIWt8vo9PGU0i6ZfblWm3IKr7UXJox+L7
         7s163a5/EhmT1fkZC80sJJ3pbkMYz2B/5am4HKJr+PjO9LJwaoHYkfzHWMXYyIgKMPVO
         DYVZVKUF9b/ia20pbCacjVqd0MPkpZQgmaSdG0My/+aeS8p5LQqI2LYV/CNshjYGg5gn
         jLMwe3jMBq8Frzcf59Q8MDR9lhO+g3m1lMKqtxftZr9tTQFjPNCXbfmGwiZ/H4kScaKY
         l0ww==
X-Gm-Message-State: AC+VfDwUT/WnIjbaUT+Qj7h0lpFKOZmmMekUlNC4U9P/Xh/vkxdyptlL
        Jx0vV8DON77yovPwF+KbeiW8Nw==
X-Google-Smtp-Source: ACHHUZ6dhSWZ+kaR9tr/tIo/y+AEBG5s4fnH5RJmGHToxHiUhgSxFkypP+G3Y/KlWXTXgmEvAZ48Zw==
X-Received: by 2002:a05:6a00:24cc:b0:644:8172:3ea9 with SMTP id d12-20020a056a0024cc00b0064481723ea9mr7579505pfv.15.1685628989187;
        Thu, 01 Jun 2023 07:16:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78c18000000b0064fe332209esm5272822pfd.98.2023.06.01.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:16:28 -0700 (PDT)
Date:   Thu, 1 Jun 2023 07:16:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] firmware: meson_sm: Fix memcpy vs iomem type warnings
Message-ID: <202306010716.02A835503C@keescook>
References: <20221012185234.never.936-kees@kernel.org>
 <166602031304.3572695.12870664862275915316.b4-ty@linaro.org>
 <202305171124.4EB0D65@keescook>
 <9158d9ca-fe00-760c-4c95-f2ee045038ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9158d9ca-fe00-760c-4c95-f2ee045038ee@linaro.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:59:14AM +0200, Neil Armstrong wrote:
> On 17/05/2023 20:25, Kees Cook wrote:
> > *thread necromancy*
> > 
> > On Mon, Oct 17, 2022 at 05:25:13PM +0200, Neil Armstrong wrote:
> > > Hi,
> > > 
> > > On Wed, 12 Oct 2022 11:53:16 -0700, Kees Cook wrote:
> > > > Use memcpy_{toio,fromio}() instead of memcpy(). Silences warnings from
> > > > Sparse:
> > > > 
> > > > drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 1 (different address spaces)
> > > > drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> > > > drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> > > > drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 2 (different address spaces)
> > > > drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> > > > drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> > > > drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> > > > drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> > > > drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> > > > drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> > > > drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> > > > drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> > > > drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> > > > drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> > > > drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> > > > drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> > > > drivers/firmware/meson/meson_sm.c:206:9:    expected void *
> > > > drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> > > > 
> > > > [...]
> > > 
> > > Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.2/drivers)
> > > 
> > > [1/1] firmware: meson_sm: Fix memcpy vs iomem type warnings
> > >        https://git.kernel.org/amlogic/c/7dc69c7d073e6004a281db8f7f15cf6ebf702ea0
> > > 
> > > These changes has been applied on the intermediate git tree [1].
> > > 
> > > The v6.2/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
> > > for inclusion in their intermediate git branches in order to be sent to Linus during
> > > the next merge window, or sooner if it's a set of fixes.
> > > 
> > > In the cases of fixes, those will be merged in the current release candidate
> > > kernel and as soon they appear on the Linux master branch they will be
> > > backported to the previous Stable and Long-Stable kernels [2].
> > > 
> > > The intermediate git branches are merged daily in the linux-next tree [3],
> > > people are encouraged testing these pre-release kernels and report issues on the
> > > relevant mailing-lists.
> > > 
> > > If problems are discovered on those changes, please submit a signed-off-by revert
> > > patch followed by a corrective changeset.
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > 
> > Hi! This change seems to have never been mainlined and seems to have
> > disappeared from linux-next.
> > 
> Hi,
> 
> Indeed it was rejected by Arnd, but I failed to find time to investigate how to fix it
> 
> https://lore.kernel.org/all/4a6b34ef-f5d2-4e56-a7f6-6a7c9cdda416@app.fastmail.com/

Ah-ha! Thanks for the pointer.

-- 
Kees Cook
