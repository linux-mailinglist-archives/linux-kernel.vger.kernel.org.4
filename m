Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDE5628718
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbiKNRbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiKNRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:31:51 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C201127CCB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:31:50 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-368edbc2c18so112988927b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eWU2AWq8Eq3gqU4BhZFYarDK0bOR9ZheOlzcH4UPHes=;
        b=ngsM0y8DuJGgF6yy8pkYeuleOgOYsTtSUCNcLqT1ekUQUW6OmtLiaeNsys8QDH+ULi
         zDkbmATi0P9/UGnfA+2IHWgiCKLQwq/05CAUEP1esz1giJb3nMlqNWuqhbJVsd4Yopsp
         BeoYCmnqFsBh2ZzgldWB8crdVBMmZpywZk6rvYgR8lxTje9VR5rJDyeuxXeWXZOevMO3
         BUAYX+Kvx+Rbznu9Te3Sw+m0PD1lKxC08GAmEXmjgQsvx45SpLLVcV9pLMKG4stGJnat
         CzQneiTrPCk+tLNBxb0QsNinY+OqLUyF7PFlmwSNiepf+rrsYuKZXipZ0gkrmf4oFJ+3
         b0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWU2AWq8Eq3gqU4BhZFYarDK0bOR9ZheOlzcH4UPHes=;
        b=fRzLeyLNiPr8ol+Wqn1cyMYQB6rvLjqHWhSYdTPbq9DqwdHK9TljJgXGM5AWrS2giS
         O5oh7L4/gVw2W2KNt78lebyp/Srj4T6MDFhxrLTGgyxtZeEIONFH+42JiT8W63RhrpDJ
         72C3EcYXSdzjIN6b3Kyw/lwuZV0cSOpktXZOEWrJQAo4qMPEYN8eYfpLE2JKQXqxePCP
         Kn2k4s73cSMASqb/ELSR4JNuu95EtS76b+Qej0wEzIKZsXXMLCjUkPOHTtLZJ8jBZCxq
         zU/WcKvvhKPZYI6WmuQyctwCpsmqySlUOMcnzVirPhUaq4sJR6MO2VbSQqN8M0THAfoM
         Ps5Q==
X-Gm-Message-State: ANoB5pklgy5plpjvNgP+n5mhrV0sdv/VzRQjfJYZBrwnnGX4mYAh1Wq5
        4K20SmziJ+er1tW/RS0PzrL7r8HNRCwp1sY46FyGK90nsHs=
X-Google-Smtp-Source: AA0mqf6vu9kuePeMS9l3b991+R2zG6hmWT5m11Wgk0SuA+Vd3yJC/GJQIOJLNpd2zjgtMumhHjn2hxZ5Cq+MesR6OZY=
X-Received: by 2002:a81:1a16:0:b0:370:7a9a:564 with SMTP id
 a22-20020a811a16000000b003707a9a0564mr13696670ywa.278.1668447109741; Mon, 14
 Nov 2022 09:31:49 -0800 (PST)
MIME-Version: 1.0
References: <4fedab7ce54a389aeadbdc639f6b4f4988e9d2d7.1668386107.git.jamie.bainbridge@gmail.com>
In-Reply-To: <4fedab7ce54a389aeadbdc639f6b4f4988e9d2d7.1668386107.git.jamie.bainbridge@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 14 Nov 2022 09:31:38 -0800
Message-ID: <CANn89iK-X6hz0F3g1+J52cxVvm7LNizNa5fmnhpyCMJeYZBbaw@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: Add listening address to SYN flood message
To:     Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Nov 13, 2022 at 5:00 PM Jamie Bainbridge
<jamie.bainbridge@gmail.com> wrote:
>
> The SYN flood message prints the listening port number, but with many
> processes bound to the same port on different IPs, it's impossible to
> tell which socket is the problem.
>
> Add the listen IP address to the SYN flood message.
>
> For IPv6 use "[IP]:port" as per RFC-5952 and to provide ease of
> copy-paste to "ss" filters. For IPv4 use "IP:port" to match.
>
> Each protcol's "any" address and a host address now look like:
>
>  Possible SYN flooding on port 0.0.0.0:9001.
>  Possible SYN flooding on port 127.0.0.1:9001.
>  Possible SYN flooding on port [::]:9001.
>  Possible SYN flooding on port [fc00::1]:9001.
>
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
