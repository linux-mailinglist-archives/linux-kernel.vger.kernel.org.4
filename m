Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9319972D84B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbjFMEGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFMEFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:05:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2857EBA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:05:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-652699e72f7so3970013b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686629153; x=1689221153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfTL1pm53OB2rrP9dgQfJUkf2zAW6WKCt7VbeD4MNBg=;
        b=NSFI1xpdWBza+uSPuSdOAiDw6VF7uRiWJCGoE3/ROna8JqKen7P25T8JVoFc/E4rrC
         TLILfhmgjCi8v5TlWs7RjtRp+CxU+wh79M7nWjfOScB/E+nYLUanE2E+hS0KKILCZRb0
         OXBXmU4QuIEo8GQs6RoFdUb/L/abxVYvNfH4mepbiw7bDPXPEn8V5Qb5dzPYDWEGZQeA
         qKDqnIR32eijoixBAFDY0CpiuBeviEUmTtsCbuzTDwCJ+FBMGkuMyZCy6C5nnpdEDTkt
         NXqj1IWLshbw80qwHinsT6sIzTatUrM/n4Z0aDo/AsB/uzcEWZBrpu63n8mXG4GrH9xT
         rGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686629153; x=1689221153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfTL1pm53OB2rrP9dgQfJUkf2zAW6WKCt7VbeD4MNBg=;
        b=huycjhjwzNb1U1aYFd7DxDShngdX1MiEQcLde510Ns2T2Bv5+OqjYHdPRPOLPy2t28
         VgnDUDwxOJt//B97VRgHCS6kNYHW+dPMdDMTozD7iRTH3Sa1Ezdb0/JRNGfp0ZoaywwD
         VXD1Ok72F4vGuq9sePmqcQMLBKAzRmfixmHqXEmaCWiz0iBDH24beqQxpTpXWs2nlVAk
         aVJgqATJTkKXf8TCty6zM6ggtueXiTmqDheq7dJoISstRHaiIjhcyDt6/d2FCHAjBOgW
         dAfUFx/41WPYnB0uDc4MF3Tr2whmmvb8N0dnzZnFnME88A1hS2Cy+FdBjuXWjc4Nx03z
         OwyA==
X-Gm-Message-State: AC+VfDznBUrRH2xvr7q1umlCl7qBpsCg6L33PrQg4+d0pTbZzK/9ZNOo
        JTQ2yK+s2Sck1hl6ixkLFDfuyQ==
X-Google-Smtp-Source: ACHHUZ7GJmHpQ8tt053WOPM06grblEbOGewnRdwM4b54cATGEBorvGaXp3cT0WC14a2VXED68f4j+Q==
X-Received: by 2002:a05:6a20:7fa6:b0:11d:162d:bb7 with SMTP id d38-20020a056a207fa600b0011d162d0bb7mr665538pzj.41.1686629153578;
        Mon, 12 Jun 2023 21:05:53 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id t12-20020a62ea0c000000b00643355ff6a6sm7798198pfh.99.2023.06.12.21.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 21:05:53 -0700 (PDT)
Date:   Tue, 13 Jun 2023 09:35:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: amd-pstate: Set default governor to schedutil
Message-ID: <20230613040550.6mwktq7cyv32wfd5@vireshk-i7>
References: <20230612030321.3097627-1-perry.yuan@amd.com>
 <20230612072627.5wzmsfp64jho3bdj@vireshk-i7>
 <CYYPR12MB86556045C209552FF99C47C89C54A@CYYPR12MB8655.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CYYPR12MB86556045C209552FF99C47C89C54A@CYYPR12MB8655.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-23, 16:11, Yuan, Perry wrote:
> Thank you help to provide the ack flag.
> I have added it to the V3.

Normally you aren't required to resend a patch just to add a tag. The maintainer
can pick those while applying the patch. Of course, if you are required to
update the patch and resend, then you must include all the provided tags by
yourself.

-- 
viresh
