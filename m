Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCFF66293B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjAIPDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjAIPCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:02:40 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995451E3C2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:02:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id co23so8463789wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=scl7HLexrpFzAYNM3X4Ky/syw+DSRPKvSDyrAeIj/Xg=;
        b=CHAw0gyVrDNWcveZsiRpEav4fi5ABoJLK1XGYiKBa66qrmavgFuFlULji9Ksy5Rhes
         7u8MbCeerP408xQzp74L4b+SCx0M7vz3LW3KHOX+3/J6lxiF+hVo74e/V8EnBYUaLYBE
         6OJmIx0bOpVa6/cUALHUWhx2XJuqIXHZIUDvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scl7HLexrpFzAYNM3X4Ky/syw+DSRPKvSDyrAeIj/Xg=;
        b=DsCgon5KG5REWviOpTrRX7oYupbRRiahq3NUVYi1eyOubgDPeAKxbRvbUt07aVX5Wu
         5JDcuEidGPT8hXNjeUzlmdHyq+wuRTMA5Cm9vqguBFk3G6Jf3YvYICajfQBfFDwA47k8
         Vley66tvptMDICfsCWf4sbTtwOSUj6yHV9Qo0SF3UdpKIkckM1pP3gJcIOdNB9TlBOOr
         8Md0+FMgoNTCOOuRjz1lddt4JR2JtFmbvVgNZLGDeg1VQnP+unNsOKPERm/bpByRKPc7
         YqnwLPlW9lxqX1eAO26c2rReaiFkqfn23h3A2fUkk4/k7octXNs/YaT6ZjT4csqjRtgt
         urOg==
X-Gm-Message-State: AFqh2krzqxiBeTtmdXQcpVokcGFpUktLbdn9yXqZL9OMy06oGTtnwXBX
        P5wnaosb8pGGOSsjz2g92FewgEKzLg/5Xmdq4o8B4A==
X-Google-Smtp-Source: AMrXdXtLHNDyjnAL6zJ2auak1fOjOH8s3wFDYd+GVe/s63gydlggFzt/GvG8ozXZivPLVgmRLHLdDbUmdMJBWoGbY10=
X-Received: by 2002:a05:6000:1001:b0:2bb:3290:2540 with SMTP id
 a1-20020a056000100100b002bb32902540mr467948wrx.18.1673276558005; Mon, 09 Jan
 2023 07:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20230107031406.gonna.761-kees@kernel.org>
In-Reply-To: <20230107031406.gonna.761-kees@kernel.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 9 Jan 2023 16:02:26 +0100
Message-ID: <CAODwPW9SaomZjWQvR1mmV7OzvQkq-_XoDgSmK04fO5rVMGHmpw@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: coreboot: Check size of table entry and
 split memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Julius Werner <jwerner@chromium.org>

> -               memcpy(&device->entry, ptr_entry, entry->size);
> +               memcpy(device->raw, entry, entry->size);

nit: It's a bit odd to change the source pointer from ptr_entry to
entry here. Technically the static analyzer would be within its rights
to give you a warning for that as well, because you're now
"overrunning" the source struct instead of the destination one.
