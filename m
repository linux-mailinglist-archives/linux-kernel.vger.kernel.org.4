Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50B65E6DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIVVPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiIVVPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:15:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EE5C88B8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:15:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w10so9104200pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:disposition-notification-to
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date;
        bh=F/fSD3tiHwAEumeXG+qiH5G3ZfY9Y6LXUkEueVgh6Fk=;
        b=tGeOq2JWiIBsL3jWhqw00ZY4tOCMc7IQwKuz2NBmLdlz6nI72CPqI5nvU4wYA7wrSK
         4ZtSaaYV2fWWtkk6v6ylkQsxeFK/GpQhc5Kroq/oD899bc22M7UnBHR9Kf264D7iCyFg
         NPoBZnxVotT//5zKC5GKwBGbCnKU2NoIe0/OJHqWzMDG0yR4UwOL74fYkFPbPFTM/EZy
         2FWS/hle0d47gTgQgX7IgjjsLEVfb3z04geb4y98if+3dNiERqjRRvZk0HyzSwRUfTWQ
         BRQKsTwaWXeqkdmv1qnX1MPytI/80wucocrAmC2XiQFJs11GsU5g6AGI7NkC7/vFD3PI
         B1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:disposition-notification-to
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=F/fSD3tiHwAEumeXG+qiH5G3ZfY9Y6LXUkEueVgh6Fk=;
        b=kVWUqt/q6cePJFb2IW7kjS/swZBjepk9pgQ4NuCsioflsVet74yRit8vyFP03s/wq/
         9p9KoUv957zPu9I0ilQxyAXzHaX+sETYECZNdIc0QlPhf7vUSpiap067pnQNVFqgTMa0
         j4WIjkPAZCutihkr90KPnE+h/OqThqxXEGamBySl+dOyobcAGOiAngc6l2AzyGp4aaox
         mg3zdo632zbpu/ngLmjKCODV8TfZIaXfyaLcPRaAtUakuKC6SAalaIazPKuqHDByvgBo
         VzOAgTiPu0USbXckUVUJht9W7rgvB9FV57zVZbhKNT1VGdoRYKGHUeiOnhaOSUcuIyvr
         Z3pQ==
X-Gm-Message-State: ACrzQf3Rn+AcL8/AOy0zkGaiE7csS5wnK+TwbiD3U66EOH0ppjJa6noo
        UE0SEdtFndehkyaxkZMT33P5gD7h7xxK/Q4HTUI=
X-Google-Smtp-Source: AMsMyM5ldt2VrAPEWUNgs13BVkUvJnBv9O5XNfcE5ETCAxNGwR13fNpzdtYlY5dOXChaPEyxe5tV+Q==
X-Received: by 2002:a17:902:7897:b0:178:9292:57b9 with SMTP id q23-20020a170902789700b00178929257b9mr5370369pll.102.1663881348801;
        Thu, 22 Sep 2022 14:15:48 -0700 (PDT)
Received: from [192.168.72.152] (157-131-203-68.fiber.dynamic.sonic.net. [157.131.203.68])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902b70600b00173368e9dedsm4485709pls.252.2022.09.22.14.15.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2022 14:15:48 -0700 (PDT)
Message-ID: <1663881344.25129.23.camel@chimera>
Subject: Re: [PATCH 0/8] generic command line v4
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Sean Anderson <sean.anderson@seco.com>,
        Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-efi@vger.kernel.org
Date:   Thu, 22 Sep 2022 14:15:44 -0700
In-Reply-To: <20220922211026.GW4320@zorba>
References: <20210416040924.2882771-1-danielwa@cisco.com>
         <b517fac5-2fdc-a8c9-75d0-174c67f5a2de@seco.com>
         <20220922205334.GV4320@zorba>
         <dcff9b0f-82c8-5aa7-0fff-b749a05fcb20@seco.com>
         <20220922211026.GW4320@zorba>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-22 at 14:10 -0700, Daniel Walker wrote:
> On Thu, Sep 22, 2022 at 05:03:46PM -0400, Sean Anderson wrote:
[snip]
> > As recently as last month, someone's patch to add such support was
> > rejected for this reason [1].
> > 
> > --Sean
> > 
> > [1] https://lore.kernel.org/linux-arm-kernel/20220812084613.GA3107@willie-the-truck/
> 
> 
> I had no idea.. Thanks for pointing that out. I guess I will re-submit in that
> case.
> 
> Daniel

This has been happening repeatedly since circa 2014, on multiple
architectures. It's quite frustrating, really.

