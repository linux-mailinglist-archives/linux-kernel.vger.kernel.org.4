Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5399C5E718A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiIWBsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIWBsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:48:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D01118B0F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:48:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o2so17514691lfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=t+VJpIM8r1hmUtikeqRmbHo0tacmsEnV6XoEyKGsAxU=;
        b=fjLLikLTOawpazYOFzD/OmHbBJohJ29UUvhd3Zdjvm+kcAnwFArq9XA5ZEvDg+O4rb
         Y+j4wYkQ6VXnWsOelbqRh1CoQ79htWdm3KxhPvgKasBTklHn0fiOp5BFN+L3lMFFIuqX
         v6u4B0fEO8khuy4rfMyobN8bMNSgeZgbphOCRzmtlf+d4qQHAW4RAq4ewc8oESIsJ83h
         KOAPT2iBctWwfsKrhZpPaJq3MpE9fyz8LihbLCjCuh25C4nQrhe/jzraUoUlfqiGK2Cz
         gbISV4uhizilGhOkJDJXZFH3zRAtOAiizH/xczM7UMJmCzew9DaXjjUgspf+OpzklQHb
         6+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t+VJpIM8r1hmUtikeqRmbHo0tacmsEnV6XoEyKGsAxU=;
        b=CysWqVz7p5YOwV9hXhGwjCJCx1Clxhz5JOpvMiEJvYmTXNatenFGDBev8Fo/jwnYeZ
         vSZB6oLKmFAGBj2G18Crd3PchsXg5qbVRgUhrHtQ4oJb/4IlJQcJFm7Am6iP9qOk06jX
         FdrQ+4RjmXfODbEKuoRGVFQUDdIIraLCWL/UAmLMuFkK9nC9E88zKCXXD2j4nL3dolYw
         Ij3YuEoiAu+Pqzf3T4q4OHJtNrNuMW0gfHTVBBPKCaJp0ONYYzJZTJz/Oe1srxv5ZKLK
         PsUr1QqtJwVfsy71hgUbRDpuXzoUjBCzvVhr+gVlLXu2f0HU8KZfKEcvff00sADKV1t1
         1H2g==
X-Gm-Message-State: ACrzQf1OmyReL0GcU6o868cMCqDPTqiXukjg+enNNqtj0GqV2fv+cU5Z
        jO2TwUQKLTFf52IqKXLRer+7AYz/5ZJbUIlaQ5g=
X-Google-Smtp-Source: AMsMyM5bOuodPEMfMOwCuMfg/YLAo+FqlONYSG4M3OhA2e/GbD5G4jpFUQNUG9Cp0oqztnnZvOjrcPDsjWWvEIgreig=
X-Received: by 2002:a05:6512:3056:b0:49b:704a:15c9 with SMTP id
 b22-20020a056512305600b0049b704a15c9mr2375325lfb.9.1663897678411; Thu, 22 Sep
 2022 18:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220921003120.209637-1-avagin@google.com> <202209212028.0C060F98@keescook>
In-Reply-To: <202209212028.0C060F98@keescook>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Thu, 22 Sep 2022 18:47:46 -0700
Message-ID: <CANaxB-xGhJM4Boo-_fc2=kTE=0RpAL1CUxisNpvzpME_WNM_sQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: switch timens when a task gets a new mm
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 8:29 PM Kees Cook <keescook@chromium.org> wrote:
...
>
> This looks good -- my intention is for this to go into -next after the
> v6.1 merge window closes. Does that match everyone's expectations?
>

This works for me.

If everything goes well, it will be merged to v6.2. Do I understand this right?

Thanks,
Andrei
