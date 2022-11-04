Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD79B618FFA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiKDFZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKDFZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:25:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890082250B;
        Thu,  3 Nov 2022 22:25:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so7245300pjk.2;
        Thu, 03 Nov 2022 22:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSKbU0jHcouLky4DFb7gK6PLbAEPDHmfcc7VdTGMcjE=;
        b=XOvUy5ztrk81oS/tJUgf9CeQcUsyDZkgNHWm+qGtz9odcQvFgGLAfw3CgEYKK6oOtR
         l5yAsZKCXpUSxHhAj7EeSIu3lRBcYldcn7P1T7chLRf0nQ4vVDnzwK0h8bjXpO340baq
         Kfw+djicbIJcrhMIQ3BV46j047HX6fKdpGE/Wa5bcP3QkyvnF50m+02e1MlO+Qmnn2Vd
         LwtPhTBXAm57XZiBVvW3LTkvd/6FlUt2Cq9sD/GKdXxCW2/2CpUqebRomUiBjkDL+0n0
         z9ffyuiI+Td5jE7s0Kll3QC2y1bv7xhcth1uHwuCoANlSv2enhs/FbHWZt8plLi9zz0O
         DXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSKbU0jHcouLky4DFb7gK6PLbAEPDHmfcc7VdTGMcjE=;
        b=AaNcthi/qxPVzFzE8sI95GFN1mRcY8WgjtRxEZa9OEVt0fSDBwpVFAucixy4XkqRre
         oWePIhMVXTGo8p2BB8pQBPxCSi0sqZZQj6063JtMZxEJvTZZyr5c29VCwvl4v0Y/gfi2
         fAn6/0TUHPvjVO2G7hBwzbsJAobvv8QwBO9SNf7AlUGU+EBLzqwXUd4ujOOjno5IXIBU
         Et34jYe9bct+WZ1N8+ykAld5/xw+4/Bzt9pRJlF/4YCO5CCFa+PyCcTwtoHT32zxrYZD
         gTvd1yDSBku4lbIlYoLEYdz41oE8jJAzH5y0MSJvCep4S0k+zEdFp/qS3Q+fEvz2+N/T
         2UaQ==
X-Gm-Message-State: ACrzQf1Ab+5w7RZaoLndAcgzw4z1EHajIcRA/LtljMKmCf6TM++vVsXX
        8HWzawpfyZlLiQ/R+f2ZBIM=
X-Google-Smtp-Source: AMsMyM5lmtR4VUQJqUUBzODapKxhxQjG+reS6Uuuf+QnTLmkkdl87ad4FUDsplLRZ/TN96pXG40Qxg==
X-Received: by 2002:a17:90a:6045:b0:212:fe9a:5792 with SMTP id h5-20020a17090a604500b00212fe9a5792mr50787039pjm.178.1667539550012;
        Thu, 03 Nov 2022 22:25:50 -0700 (PDT)
Received: from makoto.localnet (2403-580a-80ed--ccac-899b.ip6.aussiebb.net. [2403:580a:80ed::ccac:899b])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78bc8000000b0056bd737fdf3sm1674042pfd.123.2022.11.03.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 22:25:49 -0700 (PDT)
From:   James Calligeros <jcalligeros99@gmail.com>
To:     James Calligeros <jcalligeros99@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
        rafael@kernel.org, sboyd@kernel.org, vincent.guittot@linaro.org,
        vireshk@kernel.org
Subject: Re: [PATCH V2 5/5] OPP: decouple dt properties in opp_parse_supplies()
Date:   Fri, 04 Nov 2022 15:25:43 +1000
Message-ID: <2209158.NgBsaNRSFp@makoto>
In-Reply-To: <20221104050752.67eh54ui2ohbbyni@vireshk-i7>
References: <cover.1667473008.git.viresh.kumar@linaro.org> <2379445.NG923GbCHz@makoto> <20221104050752.67eh54ui2ohbbyni@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 4 November 2022 3:07:52 PM AEST Viresh Kumar wrote:
> It should happen sequentially.

 I noticed the mutexes after I got some sleep :)

> Initialize "ret = 0" in opp_parse_supplies().
> 
> Or pick patches from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
> 

It didn't even cross my mind that opp_parse_supplies() returning
ret uninitialised was causing the failure further up the chain. Applied
and tested, everything's working as expected now. 

> Sorry for the trouble.

This is on me, I should have heeded the compiler warning.

- James


