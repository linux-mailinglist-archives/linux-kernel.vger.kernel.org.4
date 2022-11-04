Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC15618FD1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiKDFIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDFIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:08:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB027DC4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 22:08:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k15so3570235pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 22:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DkaQgM6nLFzKSxcq8VZY2Fubwi2bQ7ih1P5bL5BSMfM=;
        b=TYZKbz1H5qSqe2ptkxa1kt54ID94aR2Ozmg6LI6TLNTRdDXLV76U4WXDh1my9ABu2v
         lygGbjLdG19S0g83WWVm+XkJD2BLpbC1KGFTr4lhXujMfiZs7Xjv1kUzHX/Tq/0QLQJr
         bO+gnKboAirg+yQIDejXToYa/Hu+YmriuZxIrrmLwRbjx7lNsCrewVJ9GmnRmpe4I2+k
         4S4g0pttNY486K3cbfSoadBpgwwCRmvXsAU0BuL2gTOYGOE8/TF78LOkosr0odCCe2Wq
         XFhVv+yx+W3rO5VrCGRj1OWpgzoKhILeHOukb6kYCr+H8+AYgAUwGHmw51pZ8BnZhNw/
         JKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkaQgM6nLFzKSxcq8VZY2Fubwi2bQ7ih1P5bL5BSMfM=;
        b=jhAuAX62tryCTUWnSi8qyS2L8e3C4kkbBitVmZ0VwE4+IkD4u9NLqY8E1y6+9DI9d8
         a24loMre9g2Dv4mo/zHNT6UrtVupXpvOewlH+0UrRGERz5rS9G9G32u59q7GP0UyDUD6
         eVg1mS2HubC/EILzJwLSwX4Pw2dT7YfVCYUXwOjm19OuVl+poDG7gEixk25b6FkCfKbR
         ycoIHknLYJuGBrzHYaWT4Ckv/EdWNzs9mRU2rsaA9F5yR9iLtspFsSzP8NH5DEBQTIDR
         ykxXHsQ+lIsF4Zfm1QlBVrJsoIBAIgJFsok+e3x39TLC9SI19FUb4JdVlIJelac/MYh3
         zoYA==
X-Gm-Message-State: ACrzQf00cORhRnfW0PxLa7YeczGh38NCUtmAmVmPed0IJkEBXXmR8vEo
        nxK0PgtRsHWOSckjupaYaRtYow==
X-Google-Smtp-Source: AMsMyM7X/x0nTGiSYRDfwDUcY75WjzSbFpfflxJSvmWYT1bMJYITCP6XOn6n/W7jJGLN66rEniVEfA==
X-Received: by 2002:a63:4f09:0:b0:440:4706:2299 with SMTP id d9-20020a634f09000000b0044047062299mr29677782pgb.115.1667538482532;
        Thu, 03 Nov 2022 22:08:02 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b001869581f7ecsm1582597pll.116.2022.11.03.22.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 22:07:55 -0700 (PDT)
Date:   Fri, 4 Nov 2022 10:37:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
        rafael@kernel.org, sboyd@kernel.org, vincent.guittot@linaro.org,
        vireshk@kernel.org
Subject: Re: [PATCH V2 5/5] OPP: decouple dt properties in
 opp_parse_supplies()
Message-ID: <20221104050752.67eh54ui2ohbbyni@vireshk-i7>
References: <cover.1667473008.git.viresh.kumar@linaro.org>
 <3519763.iIbC2pHGDl@makoto>
 <20221103131051.2ivkhibbsdarbewt@vireshk-i7>
 <2379445.NG923GbCHz@makoto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2379445.NG923GbCHz@makoto>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-22, 01:23, James Calligeros wrote:
> >if (list_empty(&opp_table->opp_list) &&
> >    opp_table->regulator_count > 0) {

I did test this and it should have worked for you as well.

> >	dev_err(dev, "%s: opp-microvolt missing although OPP managing regulators\n",
> >		__func__);
> >	return ERR_PTR(-EINVAL);
> >}
> 
> When this path is removed, things work as expected. Could it be that opp_list has
> not been updated by the time we're parsing the next OPP? Seems unlikely, but
> at the same time if we're ending up taking this branch then there's not much else
> that could have gone wrong.

It should happen sequentially.

Ahh, I looked code for sometime before I wrote this line. I know what's going
on. Its a bug in the patchset that I fixed yesterday and pushed.

Initialize "ret = 0" in opp_parse_supplies().

Or pick patches from:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

Sorry for the trouble.

-- 
viresh
