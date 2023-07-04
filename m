Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4894574758D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjGDPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:46:06 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46C410CA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:46:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53482b44007so2782614a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688485565; x=1691077565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut9W76FKV+Lg/Nk3Q8fpYQfXZYC0YQoH73u8akKRiCM=;
        b=O5QUE2/eaB2IalpuzNuEpk0Q2Vk7hSTHA+TLIf5LYyCw25zZd1uqEQdOa/qc4kuMsV
         tXcVLpWfGB6sAdnXlI2kWez7aOgTSOQ68YEtOPTI3xSA5+rU6uJiIwJVvPB8oej3RCfG
         M5wc2BU0P2AOW3N/ybsxWt25Z/tFG1TEZVjkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485565; x=1691077565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ut9W76FKV+Lg/Nk3Q8fpYQfXZYC0YQoH73u8akKRiCM=;
        b=jefJoKb3aCbIGuslodXbSCUYc/e7Lal91lWegC908S57PwrWUWy7rcI90px010gwaf
         xy7j1TggZ061vxSF4Wxsf5Nv2LBHzcZEnAPcwm1IvQs/kcylgI+NUAiAk1eoedO4Wfw8
         KHmdcKefqWUbDxoIsXVZV4+AMoCORsmg0rzi2yBeThL4J5sqCcZEuAz3JE+ruUk1jA0s
         /Lhp31F8QUVY0QSCmngK6V7o4Et0QqkCAn26Zdsj3vDuU9IdWmDcXOXOEEksY9Mf1xx/
         /tRFpqbqMBVa9dkBbcAU+jc3DxVm3XTJ2KBX2P9ouNcM/Dn6ILV4Tnq0sC7rus0gZ9WY
         hubw==
X-Gm-Message-State: ABy/qLY3U0xkWgHgi8PUHzbyDCqwrFiSxjlPOXKUMABrEGgdcb/IUNoa
        EyiS28tUkGCKz4tS+0CropKFKuoRBT+sP7Hc7TVlwL//UZc7ginx
X-Google-Smtp-Source: APBJJlHNiEz/TsF8ZoZpcG3iC5rBPXBsnfzkr9aqCwymLema2t/+jBNd7zG2QXsm7C2ggFkH+uvDVgtCWhKoEudf6iQ=
X-Received: by 2002:a05:6a20:3d1c:b0:10f:52e2:49ec with SMTP id
 y28-20020a056a203d1c00b0010f52e249ecmr13107156pzi.53.1688485564792; Tue, 04
 Jul 2023 08:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230704153630.1591122-1-revest@chromium.org> <20230704153630.1591122-4-revest@chromium.org>
In-Reply-To: <20230704153630.1591122-4-revest@chromium.org>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 4 Jul 2023 17:45:53 +0200
Message-ID: <CABRcYmJgOAFMO2Uuyn1sdoTLk1PXrxuqo4Hwkg6UkSDgMOvnYg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 5:37=E2=80=AFPM Florent Revest <revest@chromium.org>=
 wrote:
>
> Defining a prctl flag as an int is a footgun because on a 64 bit machine
> and with a variadic implementation of prctl (like in musl and glibc),
> when used directly as a prctl argument, it can get casted to long with
> garbage upper bits which would result in unexpected behaviors.
>
> This patch changes the constant to an unsigned long to eliminate that
> possibilities. This does not break UAPI.
>
> Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl"=
)
> Cc: linux-stable@vger.kernel.org

Oops, this was supposed to be stable@vger.kernel.org... I'll fix that
tag as part of v4.
