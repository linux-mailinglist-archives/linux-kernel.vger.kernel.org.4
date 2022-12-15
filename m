Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA064D512
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLOBqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLOBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:46:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E58C2CC8C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:46:08 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so1171701pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vs8w6gf6XZn0I/3+WAtppiqxnavuWxrUlZH19ofyHec=;
        b=Ci9W3Q4exXCYLAm/L+wORSHz9MRXJoPHm4+W5Nygoe+k9OLBNd0ESNf0rQg1XdZCQx
         uA/OKqo5ULioeDkX/CWpNgq1jxlobYhn99Hw/1vwTMABYXrPThKB6cVXn8vrL7xp4In6
         dPutpD2tajWxPSBlnpXnh/IktX87w62R42irnoxbitSr0oWoYvWl1A1SepofqBC5TYS/
         agpN/41p3GHzJmjdUVNKVmZR1qaGan4wtCkTW/SuMN8ypRQREZoTtl7gLgbtL+P1xoxL
         3Ykxd32UBpE/qOgbWugCa82iPal5XlFDxrdgJuOZSu+FQTL1dHAmvjuvO31RP2g/yarF
         PxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs8w6gf6XZn0I/3+WAtppiqxnavuWxrUlZH19ofyHec=;
        b=56oOmeWDQ6EK+TvdPTzDFbssq3vO0LmB9pAI1rR0vw+FZUpgpgWaLKOgiMbYuebzKo
         iqQqFWvIb+UzCGGHuN3a6nVRoW4wcwDTqNDTutAG37g43k8xB4IrorSEVyeo4X+r3ROQ
         wB3Tg+HGeeM5QSlL9llDSuqDm6+cy7FW9POgApuYBpHjYMEBmIXtLqwXHMiP6+t2mUSF
         DV5MU/z7EetOdZ7qe8STkTb2+CJBre10yWQHZ1F8RLEP7lPqtm+0k/103iphL+bGr5SP
         9V0MTNmDHBgNLfTFalQt+cn1U0ryqzQqYtXDPZR5JW+wFhdFKD3jCKuF0KqaMEEGfDAd
         5mIg==
X-Gm-Message-State: ANoB5pmPeSpNcKRXHOiYErKPi/+/JDV6yovZ3ppz/6UUz1tdeaW2BFia
        2g/ZA7KfefPyxL+iYL8Y2wx8Iw==
X-Google-Smtp-Source: AA0mqf4wnhcHIDOjmThgfw5J2sRiJqfPhND4eT5hA0zd3+wIWPy2XaCMcxuK4950g1+RCXZnttP/SA==
X-Received: by 2002:a17:903:268f:b0:189:dfb0:d380 with SMTP id jf15-20020a170903268f00b00189dfb0d380mr28186679plb.33.1671068767729;
        Wed, 14 Dec 2022 17:46:07 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902680800b00172f6726d8esm2443890plk.277.2022.12.14.17.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 17:46:07 -0800 (PST)
Date:   Thu, 15 Dec 2022 09:45:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila 
        <adrian.herrera@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, songliubraving@fb.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
Message-ID: <Y5p8V1jkuE6MguRM@leoy-yangtze.lan>
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com>
 <e3e123db-5321-c96e-1753-27059c729640@arm.com>
 <Y5iPsjF/lEsEldU8@kernel.org>
 <CAM9d7cj=Pu2QAONzd2JSVzd_X9DakeV=khcFGD_d-ES5zrx+KQ@mail.gmail.com>
 <Y5ngs0bh/R8xPFvo@kernel.org>
 <Y5nyYeVWpLA/IH1E@leoy-yangtze.lan>
 <Y5oJRXnlRju3gDxl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5oJRXnlRju3gDxl@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 02:35:01PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > I don't know anything for eBPF counter, so this is why I am still a bit
> > puzzle which way is right to do (bind vs separate eBPF counters).  But
> > I personally prefer to let eBPF counter to respect delay, so it's fine
> > for me to apply Namhyung's patch.
> 
> "I'm fine" can be read as an Acked-by, right? :-)

Yes, have sent my Reviewed tag on Namhyung's patch.

Thanks,
Leo
