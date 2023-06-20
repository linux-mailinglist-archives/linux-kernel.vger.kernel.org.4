Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663E473750F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjFTT2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjFTT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:28:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99309170A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:28:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-988883b0d8fso448241266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1687289324; x=1689881324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XH1eTCKvssGWMBfvFrdgcklOsCxNlyt2GIpnc07LELQ=;
        b=BlynXctAWH1QRQ92/1liGst5sDK4J+VQcZkeHhN/JzMTNaMJ1YVs/a+8TpEn7V+e2z
         5rsT4otCl2HBLFcn3UZI9U8/bLdOsI5BJgt9hPBTvRlotni4E07NsF/Dwxb5rbyEmVrn
         Cp4ves6PTyv0l/TrGTJFH5VxYdufbQ6URbqso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687289324; x=1689881324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH1eTCKvssGWMBfvFrdgcklOsCxNlyt2GIpnc07LELQ=;
        b=aFR9SY3Y8BXzRPZMqmbv4/QkyH1093NLxXqBnjrpnUNTcm9czH/tk/AUh0GJS2LW8a
         oOaJGNJmbqodKfeQXMVZZe4Y7fNTMg/6JbdfPVUdywqethYT/n2obGOSj+Nx1fcMxjHr
         r5UIofusKGqDYmkeVdmv/ahraxiafQv2exbtWnlOtPVpOlotBm5w3NkA1ViMt2DeGWXY
         ccBbvGvcsHzIT/tlvnnyB/l8mk7+DnkuR8U6Jx7eoStTZ4Xr9qMtFImKN8cMNfUzFBGV
         iQ5dBT2djSPGsN4VqTN+XDVRmoG7nQnJY5hgd9Tw4XGvppSfqbV4EUB3+ccQtkMSBBlx
         y5TQ==
X-Gm-Message-State: AC+VfDyN44VQspNcNiQOfXI19T7/CKvkv2bbbyjxEJlGMwLm4FklzCnA
        /M2Lcgjrfilg92OFNNkno/lC5DqySWrpi+oHM7pOsQ==
X-Google-Smtp-Source: ACHHUZ54HsxZXLKER+8ewm47xglhax+CzJ5iDEH3HsDCWTmmUgIaC+ahifuhHR5ouh2PxWWWI4v7558KxZAH1+RIWm0=
X-Received: by 2002:a17:906:6a0c:b0:988:bb33:53a8 with SMTP id
 qw12-20020a1709066a0c00b00988bb3353a8mr5382005ejc.9.1687289324011; Tue, 20
 Jun 2023 12:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620151328.1637569-1-keiichiw@chromium.org> <20230620151328.1637569-3-keiichiw@chromium.org>
In-Reply-To: <20230620151328.1637569-3-keiichiw@chromium.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 20 Jun 2023 21:28:32 +0200
Message-ID: <CAJfpegton83boLEL7n-Tf6ON4Nq_g2=mTus7vhX2n0C+yuUC4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] fuse: Add negative_dentry_timeout option
To:     Keiichi Watanabe <keiichiw@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, mhiramat@google.com,
        takayas@chromium.org, drosen@google.com, sarthakkukreti@google.com,
        uekawa@chromium.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 at 17:14, Keiichi Watanabe <keiichiw@chromium.org> wrote:
>
> Add `negative_dentry_timeout` mount option for FUSE to cache negative
> dentries for the specified duration.

This is already possible, no kernel changes needed.  See e.g.
xmp_init() in libfuse/example/passthrough.c.

Thanks,
Miklos
