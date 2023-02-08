Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06B68F247
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBHPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjBHPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:42:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC034956D;
        Wed,  8 Feb 2023 07:42:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso2922633pjj.1;
        Wed, 08 Feb 2023 07:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/0ibr3xWIOSvviFAnF+Jjnk6yNyOnXhh++cOBo8dgU=;
        b=WHRjH6yl0F5Yvay/yRcpKw9TKepLiswlKDi4dRBPZWH1pB7h5vNztOJPYR+sClOjmo
         cJ09lc9vOI2yKC15K5gKw2iRpqBTrdA8FM7u4FWp+rW2b8XjpQYUV9LaTE+AYAiWyeAb
         nuObHc16pxAKrY5cNeK4VXCwFSoFla6tdEX/fdoUaXUTvk4nXYMEs9WRv4Jf5wyxFu/d
         braS/CKaDA/+Ca8+d4L/eQv5I5n4OZd0Q8y8OyPnPQ8zNhgdcRHHOemb2feD094pD5BH
         FkSp156zj1tRZ9tgdGYrHGNyk/03R3QPEMA06vlyjz/6WJqFEL/dEGBbTTCHecmpqtFP
         +ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/0ibr3xWIOSvviFAnF+Jjnk6yNyOnXhh++cOBo8dgU=;
        b=6GrONAytrGuglrozkeUvaJ6vtODFCMTYgxBYIT0OjZdS9ti02qQ019toCY7jTeogRi
         FfphpDs201di5Nw1VFdRzBz0jyvezXAhll1oeHb1XzX/sOtGaJjslqHgsyzIBpwc1oa9
         uFDMs2f+VlkGbkrO3j/uuxazCp9qRZRlYeYuICnL4gZ2RGXdzUtvO9CuxGZxtxlUeuPk
         o5fb5OKmC+EkC6s2RyQvOTdbNOlc2q8zy4SoiORUJCVHN7+B4d6nYWG7+iMdpPvyqyto
         mHOc2+bMG5bwYDBczQDb4/W7tlp2//aEx7GGcZ1xWy53Fw0yYwkQIfhxBnQIPseR7bvD
         +GTQ==
X-Gm-Message-State: AO0yUKVGI7jfcsH61oWYd3r1gS0yzhLw7/FsVdVdZKyNo0Ws1OGN7nPz
        K/R0GTI/rVZl4KCaUHUdnWY=
X-Google-Smtp-Source: AK7set81LY2ndY5hT0oY3Yk/LDX6q+fpckwkVjUI2/9xRbK7TJO0zbuEihLgvQY9EvWcfMXrdYPQyQ==
X-Received: by 2002:a17:90b:1a8c:b0:22c:9078:178 with SMTP id ng12-20020a17090b1a8c00b0022c90780178mr8869666pjb.27.1675870972528;
        Wed, 08 Feb 2023 07:42:52 -0800 (PST)
Received: from kazuki-mac ([2400:4051:ea3:5910::19a])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090ad70e00b00229b17bb1e8sm580094pju.34.2023.02.08.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:42:52 -0800 (PST)
From:   Kazuki <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki <kazuki@kazuki-mac>
Date:   Thu, 9 Feb 2023 00:42:47 +0900
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: s2idle breaks on machines without cpuidle support
Message-ID: <20230208154247.avb5ol4kyrx3y6mm@kazuki-mac>
References: <20230204152747.drte4uitljzngdt6@kazuki-mac>
 <20230206101239.dret3fv65cnzpken@bogus>
 <20230207194818.exskn3dhyzqwr32v@kazuki-mac>
 <20230208103511.w7jzxw6spy6humdn@bogus>
 <20230208112031.sdfuluajjerf4wwp@kazuki-mac>
 <20230208141658.kede5ylqk4zqvrnj@bogus>
 <20230208144327.3ftjxnquwhsdykfc@kazuki-mac>
 <20230208150306.ve2pnt3pvlmf5wbu@bogus>
 <20230208151939.meya6c5gayspvmtr@kazuki-mac>
 <20230208153407.4a5vnbctf77xf5vf@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208153407.4a5vnbctf77xf5vf@bogus>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 03:34:07PM +0000, Sudeep Holla wrote:
> On Thu, Feb 09, 2023 at 12:19:39AM +0900, Kazuki wrote:
> > On Wed, Feb 08, 2023 at 03:03:06PM +0000, Sudeep Holla wrote:
> 
> [...]
> 
> > > Well, if we are allowing to boot on such a system, then we must allow
> > > adding a platform specific idle driver. It may be useful once we info
> > > to add deeper than WFI states.
> >
> > Hmmm, I thought for arm64, non-PSCI idle drivers were prohibited? Or am
> > I mistaken here?
> 
> I don't know. I am not against it especially now that we have allowed a
> non-PSCI based production system to boot the kernel.
> 
> > > Are we ? I thought were making changes to enable it. Or are you saying
> > > we allow to enter into such a state and render the system unusable, if
> > > so we need to fix it.
> >
> > Both as I mentioned in my first email. Apologies if it turned out to
> > be confusing.
> 
> Sorry still confusing. Are you saying you can enter s2idle and crash or
> hang the system without changes(especially around this s2idle code) ?
Yes.

Thanks,
Kazuki
