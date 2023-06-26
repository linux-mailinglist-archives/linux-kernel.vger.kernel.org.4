Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1309B73E50D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFZQ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjFZQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:29:25 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423430F1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:28:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b698937f85so30739331fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687796902; x=1690388902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDx+IuqzGva1uK4gy9QOPWYhXMmafnbm7x3aeXYCsus=;
        b=Br+Ye6favdnO37HvoZuszkxaHJu1iQNNcuY11vq0ID+bNJi5tvgm14k+y0nk+Vjccs
         WHaUJTWDx1Xy3WcBnUvVjca5tZTziPOka0CTAcDyR3Hiu9SDayO9HAT2ZoXF2SyMEi9/
         GAbOMnj3gqZoZe/dFt5UaTjghy9ixtaY6j0Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796902; x=1690388902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDx+IuqzGva1uK4gy9QOPWYhXMmafnbm7x3aeXYCsus=;
        b=MWGRpCpIsMb4MeCEupQSbLNH8UD1fbpzhWXc56Zow37agjpb6qr/LZXV1IJy6pTxd+
         xMtvbgt8G9/VmfREw97Fgn8vFCcqhxIKFtjEgP1c2CNbfnV0kcZBE9+nTktMomuOm0jG
         /6gIEpfpdJexwHXe/VFtj1jIgu7bdXyZLjJklzejVKL0R9PFpyt5PqIwigum/Ba35dJV
         YhQQc5Sb8CTrNPvaeK5aS1r/6o12ggJ2VhnUmxNrx2dJSHjFBv/YhLVpukNNnmCNGPw4
         1WIUUvhj8ytKrIc4M17ki2Me77rpMqUjpYh83ZLQBW/KtMop8BpdbtFDRgDbu9zjYZrN
         0BRA==
X-Gm-Message-State: AC+VfDwXIDBCpe94nWEWdcieAmVflkQsa90isYDQQeUyOiypHlO++zj7
        kFkfUamX4KT4k+cmndyA91vb2iZuSO/jyFunKAxVPNQT
X-Google-Smtp-Source: ACHHUZ4Up8y7D7yfE+3jcUW2QJBl23ymf+ohxpsjeavqZeL/n7xBL14S0KEL8rhf/E2VW1KJA5iKyw==
X-Received: by 2002:a19:7b02:0:b0:4f6:1b45:e8aa with SMTP id w2-20020a197b02000000b004f61b45e8aamr17194061lfc.50.1687796902004;
        Mon, 26 Jun 2023 09:28:22 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7dbd4000000b00514a5f7a145sm2960454edt.37.2023.06.26.09.28.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:28:21 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51d5569e4d1so2317604a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:28:21 -0700 (PDT)
X-Received: by 2002:aa7:cc07:0:b0:51d:a310:c7d8 with SMTP id
 q7-20020aa7cc07000000b0051da310c7d8mr930411edt.2.1687796900833; Mon, 26 Jun
 2023 09:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZJWlqGlx6LymL7lO@tuxmaker.boeblingen.de.ibm.com> <ZJWrPSb631x4NIh9@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
In-Reply-To: <ZJWrPSb631x4NIh9@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Jun 2023 09:28:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjfA27W5=wx_68UcG=dUPw3RZrwpXTGSuLj8hJjJTwiw@mail.gmail.com>
Message-ID: <CAHk-=wjjfA27W5=wx_68UcG=dUPw3RZrwpXTGSuLj8hJjJTwiw@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 6.5
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 at 07:25, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> On Fri, Jun 23, 2023 at 04:01:13PM +0200, Alexander Gordeev wrote:
> > Hello Linus,
> >
> > please pull s390 changes for 6.5.
>
> Sorry, this is rather for 6.4 final.

Oh, I only see this now that I'm looking at 6.5 pulls.. With that
subject line, I just snoozed the pull request until today.

It's now next in my queue, though.

              Linus
