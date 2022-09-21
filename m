Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B6F5BF77C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIUHTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIUHTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:19:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9595EDEA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:19:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y11so5505603pjv.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mbP07g1noMtBwAovb+f0lmPWi5E4lDqv0e8jXEcwP6s=;
        b=oQbEPWxAcGvQuj9r0zyTmcLJVaJrtHFahYYDBAVBgeb4unPu9qypUBqPWBsRRYPyT+
         XslA0Pr4C39y/TT04dqc4q8GwXoB3QMXnc++pX+TS6Kr9B7TejCZzLO1VTCpbXuZemEk
         HBTUGHu4LwPimDuPK/IeEuVhqP9ir2/fDHIrJwSBtaMocBm/WhL2B2jAHUdpQ5xifvJX
         Nk3iLbIOwQs/cP3V27vT0TZGMv0XT29YdV4lNlQM/tIQP+3YDiA5TJMIeK73CyUL15Gt
         mltNWdNbJ3eQHdolr2RGjdocrPblT4MHt6xkrEyRTgMeflRwQwdauJBikrO1qqy9Qg+F
         Rv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mbP07g1noMtBwAovb+f0lmPWi5E4lDqv0e8jXEcwP6s=;
        b=mwNsgjSfjKIlIQJKElJLY7XiF8J1JDKzMpm/dye4Wq/Hz97CYQfKRSivYoOLpGs5P+
         fxQSgM7e/oW/ShxrkZ3X3a8cquSgIH5mXSIbACQvsqhcJidTKULv4ol+5MqoZvi0YdFo
         s6vfTDpkAOiB2N1kjLvssvJcZ5nvadGyO0Yud6c0sBfx1fpVw44z6AD0LQBOg2Ww3FWd
         4OFOGkt2qGU7eZISso+uOVTSTfqXlmcAx39rS1mDphAsEvXkYipi+j63RVn9baMFoYAo
         qGYFYJLhErQNq+BH6dKbLhKF7uHX/hbBysDyZOugf9vW8yBy3T3ngMfmvaZGgQLNvATk
         zb7A==
X-Gm-Message-State: ACrzQf3/ufwmGr9EGENz2bmZk/dWGTp/RfF/6MGngNp4zm3GBAmCWeTr
        VqTfQFspO9W51ipDMqpyXLX6xw==
X-Google-Smtp-Source: AMsMyM6s2EteCzlJrPISAF0j3JIEyARdyuJl1a5kIdKFotyiQw8rJN1Kx6iEB4hdoanME+dtrQjWqA==
X-Received: by 2002:a17:902:c941:b0:177:e69a:a517 with SMTP id i1-20020a170902c94100b00177e69aa517mr3413184pla.144.1663744756561;
        Wed, 21 Sep 2022 00:19:16 -0700 (PDT)
Received: from localhost ([122.171.20.238])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001743ba85d39sm1212084plh.110.2022.09.21.00.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 00:19:15 -0700 (PDT)
Date:   Wed, 21 Sep 2022 12:49:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     jia-wei.chang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rafael@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        matthias.bgg@gmail.com, andrew-sh.cheng@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Fix KP and lockups on proc/sram
 regulators error
Message-ID: <20220921071913.p7kwsjnnuad2jgvk@vireshk-i7>
References: <20220909093724.40078-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909093724.40078-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia, do you want to reply to this thread as the Fixes patch was added
by you ?

On 09-09-22, 11:37, AngeloGioacchino Del Regno wrote:
> Function regulator_get_optional() returns a negative error number on
> any kind of regulator_get() failure: failing to check for that in the
> teardown path will lead to a kernel panic due to a call to function
> regulator_disable().

I don't see how this can happen. The code does check if the regulators
are enabled earlier or not.

> Besides that, the "proc" regulator does actually provide power to the
> CPU cluster(s): disabling it will produce a lockup on at least some
> SoCs, such as MT8173.

We are just dropping the count that we increased earlier, how will
that disable the regulator which was already enabled ?

> That consideration is also valid for the "sram" regulator, providing
> power to the CPU caches instead, present on some other SoCs, such as
> MT8183, MT8186 (and others).
> 
> Resolve both situations and by simply removing the entire faulty
> branches responsible for disabling the aforementioned regulators if
> enabled, keeping in mind that these are enabled (and left enabled)
> by the bootloader before booting the kernel.

This looks fishy, we just keep on increasing the ref count of the
regulator but never take it down.

-- 
viresh
