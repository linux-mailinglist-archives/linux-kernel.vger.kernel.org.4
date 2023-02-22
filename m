Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00E369FC02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjBVTYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjBVTYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:24:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9C13A87E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:24:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so35198838edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qp+azW1Y6r7CacAgRRkO8m4Jpnyu2NHeheXy7XUiGg=;
        b=abF79W0cSKvarjYg4h5M7a4lIbrG3Gk0voZeGSqob41iF6vY97jJzQWJM6viqMyX5k
         YcirW5dejYoTQF/RHdb4y2A7lHhEDKvLImwDNtUk3SE17ZJx372L9PziOL6WlKVOcwTx
         Adh3lNFmqR5kaM/jxgxaXnPorbej2xDLSJajs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Qp+azW1Y6r7CacAgRRkO8m4Jpnyu2NHeheXy7XUiGg=;
        b=HOD81LwgofRBtXMPj0T1vy1kBT8hGGImPWxizzWWByj7SzE9tWX8JgA8gHFr2co4wM
         ID1UgmVLC1+JWGulJLFRh1tEEPErQqcGI+ziAQQELjiFWX/8b1N+9KyMVNrl3Ov19B8u
         4iSBGbf+yIYq+C+AuUXO65KcBqAPbW76jn3NIK/Gtwl1lJahqYO1lKbD0xwgRubi4JXN
         jxtFTnOht6ois0yu59QK0ZqF3uhmcg5mlnz+7WHGBS4yYrnR4VZaUUPwqdWinS2ujF9q
         1jAaDMsZ8R+NjsRjCEScNrivziD+t/671u6hCW7h4KEnIQeJ5o+HHZORdLxlX+m0kNI5
         C0EA==
X-Gm-Message-State: AO0yUKVcZ+YWr/IZEofg3kZlu3d70h259gDFRBluBNAeU5nBYeHNnZvy
        Sf0ydeSCfVp5aI0pjoplf00QRwFlSCvCjndh/HA=
X-Google-Smtp-Source: AK7set9Tu2p4LJqbopM3WaQCqWMt7zPnFntquhhPgf94Qile0Gh2BSXSYaVQc7Qcvhr1GrH+7DFuJQ==
X-Received: by 2002:aa7:cf8e:0:b0:4ac:dc22:5d11 with SMTP id z14-20020aa7cf8e000000b004acdc225d11mr10759490edx.16.1677093839702;
        Wed, 22 Feb 2023 11:23:59 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id dn2-20020a05640222e200b004af6a7e9131sm154585edb.64.2023.02.22.11.23.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 11:23:59 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id b12so34744424edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:23:59 -0800 (PST)
X-Received: by 2002:a50:baa7:0:b0:4ae:e5f1:7c50 with SMTP id
 x36-20020a50baa7000000b004aee5f17c50mr4116290ede.5.1677093838898; Wed, 22 Feb
 2023 11:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20230222101600.y2npwk4hw3ss3j73@mail.corp.redhat.com>
In-Reply-To: <20230222101600.y2npwk4hw3ss3j73@mail.corp.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Feb 2023 11:23:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMd3HJ9m_GFHa4qY_baRGGjcUv3gEQiMpL1_VQBFZSfA@mail.gmail.com>
Message-ID: <CAHk-=wiMd3HJ9m_GFHa4qY_baRGGjcUv3gEQiMpL1_VQBFZSfA@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 6.3
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 2:16 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> - HID-BPF infrastructure: this allows to start using HID-BPF.

I really don't think this should default to being enabled when there
doesn't seem to be any actual useful use-cases for it.

So why does it have that

        default HID_SUPPORT

that turns it on if HID is on, and

        If unsure, say Y.

in the help message?

I check for these things, because developers always think that THEIR
code is so magically important and everybody should care. And that's
simply not true. If we have been able to do without HID_BPF before,
then it certainly didn't magically become important for everybody just
by virtue of existing.

The *only* things that should be "default y" are basically new gating
questions (like the new gating question of "do you want HID at all",
when we didn't use to even ask), or things that cure cancer or solve
world hunger.

                Linus
