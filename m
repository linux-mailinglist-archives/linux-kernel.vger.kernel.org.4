Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4199F740309
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjF0SQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjF0SQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:16:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB397
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:16:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so6906745e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687889759; x=1690481759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AhTPOEOj0BqxLY9QE/JlifSVTXobVSdIih6u1SdRovk=;
        b=NHqPmZG+gvs0hXwQO+IFOjNdZ+oKfc/qHB1hP/sKw/JujEh2s7IyKS6rYaKiqxBm4p
         bMIai8Xiu17vEWjkbtBDJw738ylRuAiiWr6J+9Sqjf+UXRJSAH3vy0jB4dvCbulJ650S
         UbR6GSiqyXYEOfeHUGvh1im0sQSy6CwnJKU10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889759; x=1690481759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhTPOEOj0BqxLY9QE/JlifSVTXobVSdIih6u1SdRovk=;
        b=YvtLvfzqS6ZmX6SgvvCWXVmB4s4SsTIccXpTVBVqn+qfWcZNrRAFQ65KCKgENMrLJF
         /zQALxFVQyPAQMYBtz8hxZiGxRfyXV/0I3p4v8WTWLajqebNym5ydR0U2hnWrfvwY3aI
         6R/vjTH7i3WSpZ+TNAMBXDDzUaAaByFZ8zbr5ukYcv5Qi1RIUToxOpuN8M7Sxipbr0Rv
         wvcQlnajgBS6Onow9ctZ1ts/K9HO5u7nIfqbQlGRCrBlJEib6OaGuZq3vB6cHhqT5zSN
         GgTnhIckWe2WdkU3YFCnJYv1oGp16ek1IakZJpy67udoMgeqN0AnxrrZTqOxF9AxC1ji
         J4KQ==
X-Gm-Message-State: AC+VfDyrNpPdy8vJ6TWBZcWsniggWK5YZfTn/nRf2OgUMraicKE/pQ75
        qifp5XHyv+lQi+fWgGiU+z5zpH5o+6kp6I40BZUBrLCe
X-Google-Smtp-Source: ACHHUZ5a0TRz6bg/zmHLocnF8+ywTSiiYhUx0Ac8fHicbl2g6+6FO8KqBVjxk+aUE8xElKrf6ftBgQ==
X-Received: by 2002:a05:6512:ea7:b0:4f7:6b72:3323 with SMTP id bi39-20020a0565120ea700b004f76b723323mr18668272lfb.55.1687889758399;
        Tue, 27 Jun 2023 11:15:58 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r11-20020ac25a4b000000b004fb7da93c24sm463409lfn.273.2023.06.27.11.15.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 11:15:57 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso5028318e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:15:57 -0700 (PDT)
X-Received: by 2002:a19:4f5a:0:b0:4f4:d071:be48 with SMTP id
 a26-20020a194f5a000000b004f4d071be48mr18541427lfk.14.1687889757421; Tue, 27
 Jun 2023 11:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <b0bb8387-9216-0fe7-61e9-7e2daceeef20@linuxfoundation.org>
In-Reply-To: <b0bb8387-9216-0fe7-61e9-7e2daceeef20@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 11:15:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvD6pq-7vp-cCMEnS+EOp2TmLxFKPS3Nw+Ncqt0XZVGw@mail.gmail.com>
Message-ID: <CAHk-=whvD6pq-7vp-cCMEnS+EOp2TmLxFKPS3Nw+Ncqt0XZVGw@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 6.5-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 at 08:42, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Please pull the following Kselftest update for Linux 6.5-rc1.

Hmm. I pulled this, but it causes multiple objtool warnings.

The cause seems to be __kunit_abort() being no-return and objtool
having not being told about it, and I'm double-checking the fix for
that.

But I'm unhappy with how clearly nobody seems to have looked at
non-fatal warning output again.

This was why we made the kernel use -Werror, because people would
ignore build warnings that weren't fatal. Now objtool warnings seem to
be triggering the same laissez-faire behavior.

               Linus
