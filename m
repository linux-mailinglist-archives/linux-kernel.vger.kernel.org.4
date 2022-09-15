Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE25B9F62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIOQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIOQI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:08:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9167DF54
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:08:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bh13so17746196pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oSryEY6pZAlX9YRyNSXz1SzfzTIUx7TUAHbTSJ6bgrU=;
        b=TWkFY1xTGyuKO2eSQLVulQ/4429UaJfBK1tZUADR2Q3aa3UQGhkLpUZ7jH1DndB5/U
         S16D5T1M7VeqOWWQhM4k3drCbFK9hn+yZdTk2mNE4z8oIwrIpnogQAFb9/KqVKAa64VM
         g0fQYUkWuZEMGZp2vTpDIfxMtM6droSCiAiPNiUQXbx1Zqf18dQomfyw0ir0rY5m3d5r
         rqXaaMpKhSe8hxxvUQjyrPXsGC3+bIurM68CEOCSpOSgCOul5kA0l62TuIpBXNjQwaQ7
         bje3UPnil0+e+jJ6kwC0MNK30iWPtqId/KlIa98MfRMQpW4R709dzk56WGfu0Z02WXqt
         l/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oSryEY6pZAlX9YRyNSXz1SzfzTIUx7TUAHbTSJ6bgrU=;
        b=gyJClrFuuVSu00zpi9D8x5144WomSzIIYT4yep4Y7ulhZbeoa+jy7n0Kat2S+2Ul2q
         RtMGgJWa0eEqZnDFcXFlUx9beNZWJKnQVVwOPpZ7FQsU1GFEnLZv+avQfwMg3iGVOZt2
         qRnvzIUzfIbsGmFE/b9AWe12kO8NwXEkbCpTBYMvT20SYDWNqhOV2laTgpT2dxY1nbma
         fq2rR5qUQF0hqf73TVEN9H0atDWvq97tMMmKV+Xm/hKQxLKAU8dYe4QHzriAkvQAki/i
         oTrQt8r+oglRN22YTziTJXlTmlYufQma4CexgQGIGbcj6Uykt11GQkn4rafw/D9JZdwg
         TNsw==
X-Gm-Message-State: ACrzQf0TaxN+mRsAoFiGmC9R2ltbXOqN5a1SiUNZdMtxFtujEmlzLRDC
        uGrY88KAJCeH/gYFYr1MRX/cVw==
X-Google-Smtp-Source: AMsMyM4q3xImUdLofHIofioy3acasHIAOnV0nNh+ZAHLKYfbXqL0rWo3wu+puIWxh/edtN+uTVYAIw==
X-Received: by 2002:a63:dd51:0:b0:430:18d9:edf8 with SMTP id g17-20020a63dd51000000b0043018d9edf8mr480809pgj.163.1663258135003;
        Thu, 15 Sep 2022 09:08:55 -0700 (PDT)
Received: from localhost (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902a40100b00174fa8cbf3dsm13045175plq.157.2022.09.15.09.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:08:53 -0700 (PDT)
Date:   Thu, 15 Sep 2022 09:08:28 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        krzysztof.kozlowski@linaro.org, arnd@arndb.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        william.zhang@broadcom.com, anand.gore@broadcom.com
Subject: Re: [PATCH v2 2/2] arm64: Kconfig.platforms: Group NXP platforms
 together
Message-ID: <YyNN/IZgOAlbSHnF@lx2k>
References: <20220829173830.3567047-1-f.fainelli@gmail.com>
 <20220829173830.3567047-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829173830.3567047-3-f.fainelli@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 10:38:29AM -0700, Florian Fainelli wrote:
> Group the three NXP platforms under an ARCH_NXP menuconfig symbol to
> make make selection of similar vendor SoCs visually nicer.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Hi,

While these are convenient if they're done right from the beginning, the result
of adding a new dependency like this is that old defconfigs stop working if you
just go with the default.

Was there a reason to group these now and cause this config churn for
downstream users?


-Olof

