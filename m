Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D06F6790C6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjAXGUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjAXGUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:20:36 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC6E3B0F0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:20:32 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4a263c4ddbaso204879487b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dyXFn2lup2sLjbD/KpbuX1CCPdcq3g2m2cieMlwaGx8=;
        b=dRGgaBE05wZKoyL6PoURa8kyaU0QE4JoRH+/PrGTgBN+7o02KYKA8AEGY4JbFuQi3W
         ysgjKlaBLsGOf3ixLDGZDE5TgKPszGZmyXMhx9S2usD4SDjnzOGBKXEIfpZOOEWxY4Tf
         d7qUCDjs+If7k+yg1zW58iaoJX17+YlkX5GrhA4fBjuh2FMNxKxmumklwY345oy6FOGh
         Jx1ZACuiHso9surRyTdhrNqFjWt7Brel0z4VK0LSmV1SjkN8XBePXOHMm/jmncozW+aJ
         07ufrYX9ZKBfR1Vd0XbIPLedajv3eaUDv4UGm1C1SGeKKh/2lW7XT5FYToHiuYY0ik9a
         6dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyXFn2lup2sLjbD/KpbuX1CCPdcq3g2m2cieMlwaGx8=;
        b=N1lE7B2uGya1dlF5BH+TCWU53ihyvbWEDIBRc6xx0ujz8NwNaQBMRddLqWBNmMhkXu
         2IZvlL4WAKJ0Nx1KZOj9jjbEmp2tdcBR4vRhR7wWs2mHgPgivypBc/ZXMrfq2C/kpZ2Y
         sKyZt+/2AEVrN0bwansguyuC3cstFwJlexGCODefZxu/PeLb5jVFZIb9HwtWkYZv18xa
         BzuOO3y8EQeLBoPQCQrK0h42uZukW+LzJATm4bK1Tv/dZIaAtcD/ldVTj8nCiBxlmt7L
         UUSnNGAa0FbmK8Jk34XFGN5CbVJTr3oZFbDx4b1n+ZGZB6VJmIAw0JmWL28f2kOgGzUx
         2Rlg==
X-Gm-Message-State: AFqh2kpKpsRWawemGMR0EV/jEaq5a5yTKRuEatQwfloZtVlqyQcntTpi
        FZuD9u7ci5ZGtq1uLclykeR/iWpVvvNt/tCAZjUVGw==
X-Google-Smtp-Source: AMrXdXvGtDAQmrtie+iMu2/Hn6KcrJFz14ydW887zzDi0fPPgxvoTr6yfqaCAuiC9XOCVbWlCvMM0j/FL50aLD4Ks2U=
X-Received: by 2002:a81:351:0:b0:36c:aaa6:e571 with SMTP id
 78-20020a810351000000b0036caaa6e571mr2408773ywd.467.1674541231962; Mon, 23
 Jan 2023 22:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20230119122705.73054-1-vladimir.oltean@nxp.com> <20230119122705.73054-5-vladimir.oltean@nxp.com>
In-Reply-To: <20230119122705.73054-5-vladimir.oltean@nxp.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 24 Jan 2023 07:20:20 +0100
Message-ID: <CANn89i+-Vp3Za=T8kgU6o_RuQHoT7sC=-i_EZCHcsUoJKqeG9g@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 04/12] net: ethtool: netlink: retrieve stats
 from multiple sources (eMAC, pMAC)
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rui Sousa <rui.sousa@nxp.com>,
        Ferenc Fejes <ferenc.fejes@ericsson.com>,
        Pranavi Somisetty <pranavi.somisetty@amd.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 1:27 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>

...

>  static int pause_prepare_data(const struct ethnl_req_info *req_base,
>                               struct ethnl_reply_data *reply_base,
>                               struct genl_info *info)
>  {
> +       const struct pause_req_info *req_info = PAUSE_REQINFO(req_base);
>         struct pause_reply_data *data = PAUSE_REPDATA(reply_base);
> +       enum ethtool_mac_stats_src src = req_info->src;
> +       struct netlink_ext_ack *extack = info->extack;

info can be NULL when called from ethnl_default_dump_one()
