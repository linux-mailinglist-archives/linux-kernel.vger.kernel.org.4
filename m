Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317965BCE2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbjACJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236960AbjACJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:16:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B5BDC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:15:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so20287790wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHo8Xzze3PBVFK2zU2hBup8w4rK6hXfFEZRWIQGZeYc=;
        b=HyuFKahhZyvBGLCfqGMbJCh7iNTZ7FaWiA65PSo0pePGtd4FVHTOVAi+U7h2l1SNbd
         lo9uF7tTJQzh9yBcNbGoJSkRQWv9qWacKra1dB6ixaEYBIAV4diKkEZxm2vIUuVPEZ68
         Cu0fiSJfEfkULXku1rzPMdNNRL2DvWL46PxLLB14ii8+cww9UasWjkkt4WgFFXJsAgLv
         shT67abQ7Elv8OpcYS9iKvCYklh/5wd9iDNhTBIE6JKUf1w07beW+ztoYGZMzHRfUmgz
         VHXM0mtDu9tzUk5gAMO2KvA2ZWtjkq5QmdbWpf6HRuU1SmdoAalNYtrdPwvcj5Y5zc/d
         G7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHo8Xzze3PBVFK2zU2hBup8w4rK6hXfFEZRWIQGZeYc=;
        b=YBv8ZtsF+IBXd3SjpST1unHUJ6XyY0OrBpSAdiaWDfhsqrxe4+kg8h2BMo+W7JeUpt
         0g6URQPRe1fJ/IuLf1tDUavVAn43OFD4rmOdzFqZGLjWeLj5w1CrqJE3gHigfT+irfhT
         1ja8DZgdAd8yLjQjx7WFpflrH4PzYnOSi2rr4YX5R8EX0H/tMan9TUEXcj+qrNtdihTY
         ocwFqEjH/PAlVqMCgbNQEkC5rpfmaCtlRmNGOF3GUTKBkrkOq9Lf+yRZBpl2YNwyLh87
         Lxvri+pqzm3HNpYQQ72xdmm2Yq9KUM2rhEJy3+rJURkqhJK33l65newXjyZq5JnehL37
         qIgA==
X-Gm-Message-State: AFqh2kr/RwJv1gIwFK8fUDUJ1dzf+5L4tfU8MH+A89TAeP0v3CfcQ704
        xLKQ2WIgIFMcmlXAweCMt7gyuA==
X-Google-Smtp-Source: AMrXdXv54IL4wF6qUfjXCz4xIw2V01PypRyzoWP3rbvuLu1/SMNzqCCrgBQVi5m/fUtg4+PvXgOGvw==
X-Received: by 2002:a05:600c:1ca5:b0:3d1:d746:7bca with SMTP id k37-20020a05600c1ca500b003d1d7467bcamr30813728wms.4.1672737357171;
        Tue, 03 Jan 2023 01:15:57 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id x15-20020a1c7c0f000000b003c6bbe910fdsm58666345wmc.9.2023.01.03.01.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 01:15:56 -0800 (PST)
Date:   Tue, 3 Jan 2023 10:15:54 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sean Anderson <sean.anderson@seco.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christian Zigotzky <info@xenosoft.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dpaa: Fix dtsec check for PCS availability
Message-ID: <Y7PyStu4s79FAHWH@nanopsycho>
References: <20230103065038.2174637-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103065038.2174637-1-seanga2@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jan 03, 2023 at 07:50:38AM CET, seanga2@gmail.com wrote:
>We want to fail if the PCS is not available, not if it is available. Fix

It is odd to read plural maiestaticus in patch desctiption :) Better to
stick with describing what code does wrong and then telling the codebase
what to do.


>this condition.
>
>Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>Reported-by: Christian Zigotzky <info@xenosoft.de>
>Signed-off-by: Sean Anderson <seanga2@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
