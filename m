Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6771F0E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjFARhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFARhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:37:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62149197
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:37:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d57cd373fso1864054b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1685641065; x=1688233065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VaooKom1fpr+/gFLUK2ePWF2zVhCHZPLzAcFMttDEM=;
        b=MHSqsckRCpeDoAGkYMTNaUf8HXTi7i1vORvFkCxMTEUbOwF3hDPYiDc7fFQMPlAq2F
         cXQdYOZneqJDanRwrJGT5TiAw3lSbDh/dzwSjw6g4CmcRcd2jULq+fPI64PC3km0AJ8o
         2PjBMI8jyygfqWvpj/9HPpCKdpPk7v0MskmbjN6d7QCnag4DGEbtq3amlJSeDTwYc3zT
         c0cV9wX4QJgURi4YJnSboQbChb1aZWzL1hvpMQc5EufEqPm6+DIaJwCYZOZ6FWPWEgmi
         1vId6smHDNqp1/Et5J7vtutwuBFt7gM/c2cO7oARrjPxprOFoTUBsByAcCb0gBVMlPmH
         8rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641065; x=1688233065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VaooKom1fpr+/gFLUK2ePWF2zVhCHZPLzAcFMttDEM=;
        b=V7RYJUrljKz/y4GfjOzcsdQ+F6DaAJXBssAuKt5hIO3IVhZvuF48WxTdmAU6BXrDpE
         Oe/OeI8WOC9NoG1hfVMH6KV4NpJj2Do1Ggh1MeEzY3o37fbZNfqLs6HxmWqFxLbx1+Ob
         e/bZ8xUS6C/qNCOL9JUmTcAJkZRVU3v5c08DRQGANdvF69IOJKD5m9mQg/a/K6qnOcdO
         HqHlsebAJnM6ERHM7vV060y5bJYO23Y5hH696MXexIUBfE+kQdWZQthyKd3q4w87WmDM
         ezFCqDXE3f6nYB/x6QPSECrc6qUOeu3rJY/4+DIP8zK6VEhK+JK4I7ppMrjbX6d6vzx7
         LwPQ==
X-Gm-Message-State: AC+VfDzN2fA8VnJ3ZupwS8vM0YRehCRRAPH2S37SomkZc4ZupZywQjo9
        Ksf3mGdBZTNq+0d+nVj0L3dTVg==
X-Google-Smtp-Source: ACHHUZ7z6hqFz0/ybL9ukj5Ma2ElT9E2J0J2UDKTdWLYHsIJgV2YGGUXYubX2wob3APlALw7YS3Uvg==
X-Received: by 2002:a05:6a20:3d87:b0:104:1016:dd0e with SMTP id s7-20020a056a203d8700b001041016dd0emr3075210pzi.3.1685641064841;
        Thu, 01 Jun 2023 10:37:44 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id s13-20020a65644d000000b0053fbacdaf59sm3139207pgv.69.2023.06.01.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 10:37:44 -0700 (PDT)
Date:   Thu, 1 Jun 2023 10:37:42 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC] net: skip printing "link become ready" v6
 msg
Message-ID: <20230601103742.71285cf1@hermes.local>
In-Reply-To: <20230601-net-next-skip_print_link_becomes_ready-v1-1-c13e64c14095@tessares.net>
References: <20230601-net-next-skip_print_link_becomes_ready-v1-1-c13e64c14095@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 16:34:36 +0200
Matthieu Baerts <matthieu.baerts@tessares.net> wrote:

> This following message is printed in the console each time a network
> device configured with an IPv6 addresses is ready to be used:
> 
>   ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready
> 
> When netns are being extensively used -- e.g. by re-creating netns with
> veth to discuss with each other for testing purposes like mptcp_join.sh
> selftest does -- it generates a lot of messages: more than 700 when
> executing mptcp_join.sh with the latest version.

Don't add yet another network nerd knob.
Just change message from pr_info to pr_debug.
