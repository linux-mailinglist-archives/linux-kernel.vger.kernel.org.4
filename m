Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A35E74B2FB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjGGOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGGOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:21:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC011B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:21:50 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-401f4408955so236681cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688739709; x=1691331709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YzcEN8sL+SbJU/4j7ElOz8HzSX109GbxshTNxdwHOM=;
        b=GCKlUGEVb6aH7r/AOclMN1bOHdnJrze/cKh7XnKUR3K5hwsn0HZZCgpNAvh1WVxfux
         jBpDnlOTKcc393pCJyJut1iqJWW/yy/GZKg0QSVIsi4oTp84PZqF5JskRdy8HJrVF8QU
         MAft0Mb9KkdMY9xuXnL0/kdLHHX5GPBHyy5IwxXVY3LhYdcGaPymYM5ZXhzGB1+twEo8
         eg/7Y/U/0sjYwMMDIYZE3Jpez/AAUM8GlInUDYLJ57pfv4z0N33ctuErYcfCjR9k4tun
         8IE4vLdYfi9O+DJSJuriBnkpItamt6wRrKGT7Zk94kyeI13720xq1PheP1/FmEBCp3Fg
         ItvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739709; x=1691331709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YzcEN8sL+SbJU/4j7ElOz8HzSX109GbxshTNxdwHOM=;
        b=QdXJsEmOnO4Fnl/WOxk45AO2SlFfHN7jxbum5/wSBabsKXb5RIwqxs6OYiaJBOpOhg
         Ovae7KqSrT2jXw4pavDdAKG0cUmdZebbyRHa9UZ8Z9BRFjf0uCOv/EPjCoWVZ1icIC2J
         /K1bWjfSH3bHUBDCV0+Xz1hJ9fX30FYdWpGoNpBUJcgx7PZhD7Ik7q1YI7VkW1lSJumx
         In2FQO/kxmHOR+OmlnomGxcWniUmz2AqbI7mwYUwiJ5M+C2F6g2aKRRbtxefXR9iv5fJ
         0bjDcO1HoCHC+NONhY1L6aw03ic4Meojh+ZhDe0WjJWY1XeYkPwKOLKG69lZRTI0FQJh
         jqow==
X-Gm-Message-State: ABy/qLZRIb3i2fe1QnLKM+JUuRCg0+hE1G+ZazYXc11tWJwd8IZ26Ocg
        SdUOL+VK/Tx4WqvAFBTlk2S1tBWPd5nGCsrccgeshw==
X-Google-Smtp-Source: APBJJlF8hcqB1EFVjm4Ky/dypZl0bel4E71yWz7JrK9bKZpjmXHTyWo4I215bw1nDLrW9TyNsiSPnBsE0ss4aa4JDVY=
X-Received: by 2002:ac8:5fce:0:b0:3f9:b8c2:f2d3 with SMTP id
 k14-20020ac85fce000000b003f9b8c2f2d3mr152813qta.19.1688739709457; Fri, 07 Jul
 2023 07:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com> <20230704001136.2301645-2-anjali.k.kulkarni@oracle.com>
In-Reply-To: <20230704001136.2301645-2-anjali.k.kulkarni@oracle.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 7 Jul 2023 16:21:38 +0200
Message-ID: <CANn89iLOGdFBJHe4L2Lk_iaNEvLYG5KYGxF=G9d_Lx9dU8Wv-Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] netlink: Reverse the patch which removed filtering
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, kuba@kernel.org,
        pabeni@redhat.com, zbr@ioremap.net, brauner@kernel.org,
        johannes@sipsolutions.net, ecree.xilinx@gmail.com, leon@kernel.org,
        keescook@chromium.org, socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 2:11=E2=80=AFAM Anjali Kulkarni
<anjali.k.kulkarni@oracle.com> wrote:
>
> To use filtering at the connector & cn_proc layers, we need to enable
> filtering in the netlink layer. This reverses the patch which removed
> netlink filtering.
>

" the patch which removed netlink filtering." is vague...

Convention is to name the reverted commit with sha1 ("title"),
to ease reviewer work ;)
