Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B76865BCD3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbjACJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjACJJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:09:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C63E010
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:09:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso22588989wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4VpH6JpHYPTb5N2QEbasH2uVz/byLh3cdPoaV+heNg=;
        b=7mDgAIHeRGltGKdfPnbQWDWxMdgrISNNEmr8ZEWWLq07C+IEHgsYbgcR6k0zBYc/aO
         H+7ZJ3ns8QTYMtH6GPC73xLC46L5SM21YFcSSi/WxokMkmUvkozmDpn5iVGQcqZOVaSe
         PUAI/uJBK/8kkTOICrCLiHDyZ28Oi3SFFXFAhmfM6rPAHT6BsUsrj9L7wq+mfRDJyQBc
         64qOneJttg7RjbsCl7R2yBGuCDPTdEbWfkOah9jk9qv8flepwSdUDbmBd8MfTv6nc8WV
         dlD2o5/Uo8Nwo/9pLLNpLrvbEMvZc1N964hBMzHP1gDQdMuc1Cjj4RBx3SQlq+ktbGAR
         JGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4VpH6JpHYPTb5N2QEbasH2uVz/byLh3cdPoaV+heNg=;
        b=mF0wYrQJT6sdCsyU7HOCOCwiaiGV6k2Ua+sPrOgQiytQhRzqR4R+diuFsRnrRScQF1
         WauS+heNlG4B8dOpA/9FFd5XzX00N0OWEonUE5Bit7HA3kU8uEr/p7AQeIFiGEygppF2
         ru/B4C49ZAUmBW5FzWgm/y3ugKbPjT1KNgvhUvkEKZ1hJ9W2lJMszouNMInemICFCp99
         41H/8TzSvGSHaFxSBn1abBWwcXtbOfYpMQqvF6CBxAky0K9I2Wsd0B2g5yUA8enolMD9
         AGKgMV6OPmrylLyV6/kZyBnZln/8ph66W4Zjwh+riF8GilPLGxUwmiKzl8SjZqVx+IDK
         ABEA==
X-Gm-Message-State: AFqh2koTEgFd1gurjSriHl9W6c8bcnyc2bUSqrm5zeE3VQVSpqQo3Aa4
        6p+7+u1Tpb/YvwobMy43DDf/Zw==
X-Google-Smtp-Source: AMrXdXthod9gNBtDKzM2/ooc897BFsfcfFr9DFrnqllE4RM8cMaiskR8rtfsDxEbCRXDVt3ZdpqNjw==
X-Received: by 2002:a05:600c:18a1:b0:3d2:3ec4:7eed with SMTP id x33-20020a05600c18a100b003d23ec47eedmr33796593wmp.10.1672736950329;
        Tue, 03 Jan 2023 01:09:10 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b002366f9bd717sm35847028wrp.45.2023.01.03.01.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 01:09:09 -0800 (PST)
Date:   Tue, 3 Jan 2023 10:09:07 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Christoph Heiss <christoph@c8h4.io>
Cc:     Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: alx: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
 and pm_sleep_ptr()
Message-ID: <Y7PwsyuZKiQqIp9Z@nanopsycho>
References: <20230102195118.1164280-1-christoph@c8h4.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102195118.1164280-1-christoph@c8h4.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jan 02, 2023 at 08:51:18PM CET, christoph@c8h4.io wrote:
>Using these macros allows to remove an #ifdef-guard on CONFIG_PM_SLEEP.
>No functional changes.

Net-next is still closed. Please re-submit when it opens.
