Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9D69D57E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjBTVCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBTVCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:02:32 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DCE59C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:02:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id eg37so5545291edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yq0GbJhWH2XoIlOBzlQE0R2LW2CkRve3Ilke3wYFGeQ=;
        b=Li68PqxzhjhOwhldPjcHROyWLqQAm3hq3lbrw7b0xf+QbCwLi5WsIz6XuXUOTcxKXm
         VfRR66ok62a1DTRs2oMqWLuiT34AxKM4aM9RHcF/QYSWV0eJ33PRPDsmHhe+xKdq3H/F
         beKAxjmDsNmfN5C3J3Eg31CBGQ8Q1bjF1w8nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yq0GbJhWH2XoIlOBzlQE0R2LW2CkRve3Ilke3wYFGeQ=;
        b=bYOHk+tlv1G9WtZ0NfiGP7NWNAsrJrXbnpdXPyen2oDL35pm/LHRosGJleBoLfMCjp
         SqzakqFrDhueTUxYUgInFcEFKX6A+KIxJkLU5SEwRjzlgvMSRqj1FRi8E4Hr1SzVj6fv
         iI1jTwxow7wmcWeT+j9bVwDKdIOgmXhK8Qczi/r5Y9Wux343RiMth9N7OUro47dkDZoX
         jg59br7f+pBuQFPRV2WKv2tasdSuhfSE87pU8gsuwU5XVWNWTuchTf8WpoLvmUQgQiGl
         6SlmKjMXL7e+LcYGmuGQiKnSU64PkMGRT2PrG9PEuNrIkE9P3PmFJmYIVRahg1Re9PeA
         MEyw==
X-Gm-Message-State: AO0yUKVEmgv0Fl29kfToORjunqT5Ss8z6nYUdWyzkbNpOaSjHQFHR9w7
        U4bB0U0jmYLnSKZX1xEEAmDvW1nEsPWcRpDO/08=
X-Google-Smtp-Source: AK7set8F1L+YwWCOmaBd7A890Ll79S6bS43Tw8gnnGh1GLzpNNr9LgUMctsywn/jqpYUZW0v53vPBA==
X-Received: by 2002:a17:906:b4f:b0:8aa:c155:9233 with SMTP id v15-20020a1709060b4f00b008aac1559233mr9621899ejg.26.1676926949229;
        Mon, 20 Feb 2023 13:02:29 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id y25-20020a170906471900b008d2683e24c4sm1866244ejq.69.2023.02.20.13.02.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 13:02:28 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id f13so8826832edz.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:02:28 -0800 (PST)
X-Received: by 2002:a17:906:bce7:b0:8b1:28f6:8ab3 with SMTP id
 op7-20020a170906bce700b008b128f68ab3mr4917257ejb.15.1676926946147; Mon, 20
 Feb 2023 13:02:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676908729.git.dsterba@suse.com>
In-Reply-To: <cover.1676908729.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Feb 2023 13:02:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6-qpZ=yzseD_CQn8Gc+nGDLrufFxSFvVO2qK6+8fGUw@mail.gmail.com>
Message-ID: <CAHk-=wh6-qpZ=yzseD_CQn8Gc+nGDLrufFxSFvVO2qK6+8fGUw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.3
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 20, 2023 at 11:26 AM David Sterba <dsterba@suse.com> wrote:
>
> Other:
>
> - locally enable -Wmaybe-uninitialized after fixing all warnings

I've pulled this, but I strongly suspect this change will get reverted.

I bet neither you nor linux-next is testing even _remotely_ a big
chunk of the different compiler versions that are out there, and the
reason flags like '-Wmaybe-uninitialized' get undone is because some
random compiler version on some random config and target archiecture
gives completely nonsensical warnings for odd reasons.

But hey, maybe the btrfs code is special.

              Linus
