Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4654A74D960
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjGJO6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:58:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046CC7;
        Mon, 10 Jul 2023 07:58:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3094910b150so5044149f8f.0;
        Mon, 10 Jul 2023 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689001107; x=1691593107;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF4N91VO4731Qxuhb6zJZEzEq5eJXvcQG1cnkkQn1R0=;
        b=c718WTnKC5RcuqbSt2PWn5cWb6II+KZUWRy0H4Bjs1zc2rJxjrco+qt3W+n90c3DSK
         puZbWWbcKCGrwSiSquoZxxqXYz9peGZw9FSBXI6b5euCpFMugIKKfE2E1yLF6gfiJ2dw
         L6JanANiI98n54jxUOu/yZ7/aNmJwah0ETL8pNvpZLaZfGe6XFhGfWLoga5AI9i0g5cO
         O8urv+NhAhTNcJwXvFN72WcpO2TZ1xo2IbwV7mwhCB5TEY3PAjyOax9Qe5roQNSb/G/I
         q+1uGOwxMoSbIS+8B62vvh7YktD3SrI/XMT1KIAILmR05vXn13w/PdHYMoJ3iujePeiu
         Oo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001107; x=1691593107;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF4N91VO4731Qxuhb6zJZEzEq5eJXvcQG1cnkkQn1R0=;
        b=bBhZv9K1BnOkpMCSpb/h2dwgjc9f0mm3EZvOhgACA4wQVmE8u88eASoI5NN/6Q1/m7
         DiTNqQMlBqvrp3kkZ24NE61pFF5c41240bX5EdUKlJJAErFO/4dbD43mvbSrnApw9KCU
         DanppvQZhLCGddVK4MrVci3YbM9UeUo+dK+qhudzd3tq47Vg9ko3FpjdEjQPLDa5veyO
         KP7gqG9swHCKiTkP/6f0acZyACtHF6VcekclLZxpej7Y3pJHv1b0ZmCHK5ndl3NDJwiU
         hC7s90f+4gSPVi9l51lpes/cpQo7jVy2AoUVwn0XSlw3YuNEUuZXXNrlZ4FsX/i/9AL+
         yuLw==
X-Gm-Message-State: ABy/qLbDaKbBhtuFnZqV5TIZEB1Rsx8L4f10vpm3UuMYQlNxw0kFR/8C
        5LojH4KlWZAXfiyG9UtdJnpR46xUj04=
X-Google-Smtp-Source: APBJJlGY4/HeY9i8fA3daSHGlZtUYVxAr8t2ePiTBuBz8noq8I5zGk/M9Akm07p4HVHv/n7ufYh7vA==
X-Received: by 2002:adf:d08a:0:b0:314:3b68:eac6 with SMTP id y10-20020adfd08a000000b003143b68eac6mr11754512wrh.12.1689001107457;
        Mon, 10 Jul 2023 07:58:27 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id f18-20020adff992000000b003143c532431sm11938480wrr.27.2023.07.10.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:58:27 -0700 (PDT)
Date:   Mon, 10 Jul 2023 16:58:18 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     David Ahern <dsahern@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
Message-ID: <20230710145817.GB22009@debian>
References: <20230707121650.GA17677@debian>
 <20230707122627.GA17845@debian>
 <1340947f-2f66-e93d-9dab-055e40e1f9f9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1340947f-2f66-e93d-9dab-055e40e1f9f9@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> put your cover letter details in here; no need for a cover letter for a
> single patch.

I believe some details are irrelevant to the bugfix itself,
I prefer to avoid overloading the commit message...
Do you think there is a specific part of the cover letter that
should be added to the commit message?

> there are existing iif and sdif lookup functions. I believe this gro
> path needs a different version, but it should have a comment of when it
> can be used vs the existing ones. Also, it is small enough to be an
> inline like the existing ones. e.g., see inet_sdif

I was under the impression the coding style of Linux does not
encourage placing the inline keyword.
In which cases do you think I should add it?
