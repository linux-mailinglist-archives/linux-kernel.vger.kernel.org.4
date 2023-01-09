Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0867662357
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjAIKll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbjAIKky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:40:54 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CC818B07
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:34:40 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4a0d6cb12c5so107173707b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4GG5MB79KA/+iG8tjCkehVlHp0lvZGYfV+k+DriA6GM=;
        b=oX+gSy8dlC3JT3sgpgfMdXgU2gGGk+/cSlhzGvhqU7ra+xAIuvX5gmlu1/2fEgc+Qs
         dtYI9fpso74sbJ8BJNg3nucfU0/xVki4WWgK8IMfVXJpOnf8L6IPKEA0nxhvyvw7c015
         NAJc42nRec+pyaDatOj3+yjuaI9BROcyPytE0icCWebHzsslmcFzNsl4nMySDtYXkgpF
         YJndiY0Fa6+NJ9R0T1JlexsmB+CzIckfFzx4r+AJ4aFXa72y+h9Ed1H4gMxg3qoV/xXI
         LbS1Kx2MHkp4h/6OEcF0+t1fJpC5hJESwvfI17CpcEPmbMRoRAQGMNLVPJIG3C7RvGIM
         eJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GG5MB79KA/+iG8tjCkehVlHp0lvZGYfV+k+DriA6GM=;
        b=xM0bt5JzjNc7wGyW4e6I6Oppz6kUskJfpfWdNAhNrBAsVSxvfSx1gY7nJvVxayW2Iu
         Jql02/P/M0FZWx6ZHPJWrtraD7LX3qbiuj5iOQF6lLKc00LemFkOy576lgxio4+vndRY
         fIExlueLjKiEYgdyt3J0ARUggV1+9uFY2v4H/A1tD165PuHIyQXof2Ucs7YQkhdiA//T
         wjus+OX9ScPtxcM9E1RtK9WEbPfqh5gwzxI4x+2QplBoHZ5n1vnAOYkD8HOfMG6mnSj9
         7t3b4jVEg8mvZ+tgdW9E90piBtZQ22h6r3Idh0evTPief2jBCHcBPz74iy9TwS4HfKlj
         iP+A==
X-Gm-Message-State: AFqh2krGBppSBJajYmsbCUtgqz5ou20crL56H/f176SeMUCnDb9hGylV
        5INgew0LF1SEoazf6G1/PRynjOm/aISouie+/ABPxw==
X-Google-Smtp-Source: AMrXdXvbJg8E9ccFMQ3aL0vvH8SnY7pE6BrEr6EVxZ6O7V2lb8vcdGHfRgcUFU55mvIl+ku9rprFK8ohzvLepTsurJU=
X-Received: by 2002:a05:690c:313:b0:37e:6806:a5f9 with SMTP id
 bg19-20020a05690c031300b0037e6806a5f9mr1578119ywb.47.1673260479291; Mon, 09
 Jan 2023 02:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20230108143843.2987732-1-trix@redhat.com>
In-Reply-To: <20230108143843.2987732-1-trix@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 9 Jan 2023 11:34:28 +0100
Message-ID: <CANn89iLFtrQm-E5BRwgKFw4xRZiOOdWg-WTFi5eZsg7ycq2szg@mail.gmail.com>
Subject: Re: [PATCH] net: ena: initialize dim_sample
To:     Tom Rix <trix@redhat.com>
Cc:     shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
        ndagan@amazon.com, saeedb@amazon.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, khalasa@piap.pl,
        wsa+renesas@sang-engineering.com, yuancan@huawei.com,
        tglx@linutronix.de, 42.hyeyoo@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Sun, Jan 8, 2023 at 3:38 PM Tom Rix <trix@redhat.com> wrote:
>
> clang static analysis reports this problem
> drivers/net/ethernet/amazon/ena/ena_netdev.c:1821:2: warning: Passed-by-value struct
>   argument contains uninitialized data (e.g., field: 'comp_ctr') [core.CallAndMessage]
>         net_dim(&ena_napi->dim, dim_sample);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> net_dim can call dim_calc_stats() which uses the comp_ctr element,
> so it must be initialized.

This seems to be a dim_update_sample() problem really, when comp_ctr
has been added...

Your patch works, but we could avoid pre-initializing dim_sample in all callers,
then re-writing all but one field...

diff --git a/include/linux/dim.h b/include/linux/dim.h
index 6c5733981563eadf5f06c59c5dc97df961692b02..4604ced4517268ef8912cd8053ac8f4d2630f977
100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -254,6 +254,7 @@ dim_update_sample(u16 event_ctr, u64 packets, u64
bytes, struct dim_sample *s)
        s->pkt_ctr   = packets;
        s->byte_ctr  = bytes;
        s->event_ctr = event_ctr;
+       s->comp_ctr  = 0;
 }

 /**
