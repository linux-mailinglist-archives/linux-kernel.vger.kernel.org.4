Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAAA733651
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345402AbjFPQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjFPQnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:43:50 -0400
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73C32D4E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=iAyHO8h/KyULFXADWtZLc0Th9/OFH2Czp78dOiCBkPo=;
        b=cT8987TDeNpcpocz3/os+ikvSzExjzavhutAmbmHg7F+k/NnESFJu0wNgQXjIEdB/UnRAvkfpnUDk
         OIXp9BCXd7tpCJ9qntf1422ydkA0C1JrHEHR2ze1h1WZKpoy/CXM4EW+KNkJMsi4uVa6Gd5OtVHaVu
         Tg5fG/gPP3xO4xkGD9kFKEKit4THg+ETmG77P45b4DhcjT+je+wKCKEDgK7sJvIqXFU4q8DcJpK6DQ
         nEoypyhiDCk7Qx6+ajFUTzWJ0/jEJGo2zJkdH+d+s+Jqqv/C3BA5Ua2bD042pOu8se12RIvQ5VWNmc
         g89GzzE+2bZfVOP6ag9XSGg+tM9g0dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=iAyHO8h/KyULFXADWtZLc0Th9/OFH2Czp78dOiCBkPo=;
        b=l5JqasfUxJ9A6iw2h5xmEihAxXRnDiZS9/bzyuZXBB34YDXf/01mhNOvnsLOQ/9N4P+OZOvn2XPX7
         nqrUQmTCg==
X-HalOne-ID: d014f718-0c64-11ee-a014-592bb1efe9dc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4 (Halon) with ESMTPSA
        id d014f718-0c64-11ee-a014-592bb1efe9dc;
        Fri, 16 Jun 2023 16:42:44 +0000 (UTC)
Date:   Fri, 16 Jun 2023 18:42:43 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panel: boe-tv101wum-nl6: Drop macros and open
 code sequences
Message-ID: <20230616164243.GB1697490@ravnborg.org>
References: <20230615-fix-boe-tv101wum-nl6-v1-0-8ac378405fb7@linaro.org>
 <20230615-fix-boe-tv101wum-nl6-v1-1-8ac378405fb7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615-fix-boe-tv101wum-nl6-v1-1-8ac378405fb7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Jun 15, 2023 at 10:21:37PM +0200, Linus Walleij wrote:
> The boe-tv101wum-nl6 is reinventing the mechanism to send command
> sequences that we usually nix during review, but I missed this one
> so fixing it up myself.
> 
> Also use the explicit function calls to mipi_dsi_dcs_exit_sleep_mode()
> and mipi_dsi_dcs_set_display_on() instead of reimplementing them
> with homegrown sequences.
It looks like the same sequence of calls are used in all init functions,
maybe move them out to the caller.

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I have browsed the patch, but it was impossible for me to review in
details due to the massive changes.
But the final result looks good!

With the static added as the robot noticed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
