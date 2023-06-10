Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D96672AC7B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjFJPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjFJPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:07:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9B3AA8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-652d1d3e040so2250657b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1686409665; x=1689001665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+OwDas9lj8b/o3V8lkOk9a6MOfWBvvSjFJASd1oAkw=;
        b=OOATwZuJz1XpIayU6qEWJsTjt3CY+4SMX0O0hFz4qhukDiqKsW+2HfODMVSjDY0PS8
         dM86VQyjvRTSnncMd8NEQ1Y3ajqSyztqwK1L4AHsdyCggJCjMPhoHDYKqNNW/QTmsvkl
         My6SqZzBK775E7qllyKf/D3HPM+CU0UogJlokXdyYcF3DIiOmW498DR8UJaYMOxa4taL
         sO3cymRYwckFon9LanxHS8e9U/hC5GpwfPqq9UwNBxRTStvS4jMi3j+bn53NCB2HcAzM
         zZwpBqsJYUp+qDWJUUO7vVRWb6hTATh/04CW99B7zboxr6WE5Dc4EPBPdzzm3JjPAp3M
         PTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686409665; x=1689001665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+OwDas9lj8b/o3V8lkOk9a6MOfWBvvSjFJASd1oAkw=;
        b=ZZdTHF9f756JhkzaP0cy2AeXeRX477dBI38Q5kt4Q/DCGec2LOcrO5Nd8xCA4SQOxC
         B2VL16EnwEsjJXZ7c6Qe4PSai7is+tFcqzT2TKHGaKOi30LbaGJC1+ixoYf8JXtycHXm
         orR5BTWoDi5OoDiNbWniJJi5rTKdbfCvQmJS+EaXRuFZ+TnDyn2VcVtsIL7QewYfVg+o
         REH7jhPHN5UAjGljihANVtv7oRbMD65znffN0Y1VKhX2HNUudv7/9u5T+JfegMay/E0c
         qpAANkK9XSVBi7PIsaD8yIo19e4XicSRqBKnbbFlyvf8jzWSPD6fvDFhULy/SX76+pXF
         Up8Q==
X-Gm-Message-State: AC+VfDwYXdOSdSDVvrnvVnIBpSIpH6KC9fw3/4D1GAqF6PgjYKBC5NjW
        dqcK3c08NIcc9i3Xfk+G6VYsYg==
X-Google-Smtp-Source: ACHHUZ4r4eCGoy6iuu0IW9XAISMqoeXHH/Fv2bhIfewU3fQ3CD19OKfSes9kinrORhYOGStJ4RF3lw==
X-Received: by 2002:a05:6a00:22c4:b0:646:b165:1b29 with SMTP id f4-20020a056a0022c400b00646b1651b29mr5033723pfj.23.1686409665296;
        Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id 5-20020aa79145000000b0064cb6206463sm4231318pfi.85.2023.06.10.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 08:07:45 -0700 (PDT)
Date:   Sat, 10 Jun 2023 08:07:42 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yi He <clangllvm@126.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] Add a sysctl option to disable bpf offensive helpers.
Message-ID: <20230610080742.5b51a721@hermes.local>
In-Reply-To: <20230610110518.123183-1-clangllvm@126.com>
References: <20230610110518.123183-1-clangllvm@126.com>
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

On Sat, 10 Jun 2023 11:05:18 +0000
Yi He <clangllvm@126.com> wrote:

> Signed-off-by: fripSide <clangllvm@126.com>

You need to use your legal name not a hacker alias
in DCO since DCO is intended to be a legally binding assertion.
