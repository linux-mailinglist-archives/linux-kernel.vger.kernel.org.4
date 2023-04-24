Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AE36ED75D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjDXWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXWBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:01:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23915596
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:01:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94ef0a8546fso776779466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682373702; x=1684965702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Boc+4cJxgn/c5mI/silLMJUPupCybFpIBrGZbLP33Vs=;
        b=ajUEPxYdb5cnkv/QkqS887ot1XXgKeRnHhs9EpDNItHST29l2mjSwjveeJB3Kk9XLI
         yeKIW8AdVoQMY18V6MhgTeKgp1K+xgmF/1+Y0zdPUnPYmhFSOSO8m5R0RMpeMJyaPcGg
         VAKfyAWB3SLtYv4z462LsW2JMQPxRQJaO1qso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682373702; x=1684965702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Boc+4cJxgn/c5mI/silLMJUPupCybFpIBrGZbLP33Vs=;
        b=OpjE+LdYAHyyQ69suu4uchw4sEQydo2nkhnLS8i60YjCEaLQkQ2ubV+6ghLPmvqSXG
         gCj6dbamOB//4Zt1u4s+exE2OPCJljhqwDlDLNdiLe0gZQxc0UT34LfPx723gYmNLKFu
         YYQJcE3dcbWHS65VY4mBBJh8IsuF2ozIv7VJps8nuRvsGS/xVaBNU9BT2lNqIuA7NGub
         LCP0odkMjQF8JPBn9bBFB4MkhL4Kt0GEKUAvSmlqA5h7B4Y1bmA2buZTqi9w3yYz0wPw
         uiNhupQTf829jQFQqRd+cgP/fJRQ60jWV3SVBTe/n64v5eWZLutEqQZlWx3sIHSxTblb
         mkmQ==
X-Gm-Message-State: AAQBX9ei6fSFrHFW6ND15Gd0B0hO+HlXMojQpsXxkAvx/EBxCz371xqg
        tB25jud7ViWeTPLOm+TUFmimhwd3aoS+M5yGJ04C6qN8
X-Google-Smtp-Source: AKy350YAcz++sqDe1YbWJXqTOeDwrKboZPXWWoswtf5/IaZ/uhNhSBjxasz4GLn7vBhNzgv9IYYq1Q==
X-Received: by 2002:a17:906:a3da:b0:94f:2b80:f3b4 with SMTP id ca26-20020a170906a3da00b0094f2b80f3b4mr11819712ejb.69.1682373702136;
        Mon, 24 Apr 2023 15:01:42 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709063f8b00b0094fa3deff33sm5920937ejj.35.2023.04.24.15.01.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 15:01:41 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94f3df30043so776007366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:01:41 -0700 (PDT)
X-Received: by 2002:a05:6402:31f3:b0:4fb:aa0a:5b72 with SMTP id
 dy19-20020a05640231f300b004fbaa0a5b72mr12425701edb.5.1682373701099; Mon, 24
 Apr 2023 15:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
 <CAHk-=whykVNoCGj3UC=b0O7V0P-MWDaKz_2r+_yGxyXoEMmL8w@mail.gmail.com> <874jp5lzb2.fsf@meer.lwn.net>
In-Reply-To: <874jp5lzb2.fsf@meer.lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 15:01:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2NiwU-SPNnFvuZ9-LNk5J_iW-SvQHJdbSu_spT5Oq_A@mail.gmail.com>
Message-ID: <CAHk-=wi2NiwU-SPNnFvuZ9-LNk5J_iW-SvQHJdbSu_spT5Oq_A@mail.gmail.com>
Subject: Re: [GIT PULL] open: fix O_DIRECTORY | O_CREAT
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 2:56=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> The paywall goes away on Thursday, so this is a short-lived problem.

Sounds good, thanks.

               Linus
