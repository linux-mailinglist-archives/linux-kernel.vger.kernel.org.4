Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38276A5012
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjB1ANg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjB1ANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:13:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E520C1968A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:13:18 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o15so30560507edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6auFiAxxwFQX0LU6IDVQBC5x+vKf3oYBXM0DErxZxvI=;
        b=WyRCq92RDe+UQsw+OulHf91BjcSh0ZNcWIbjV9bQZb41Z5ufwDP0Oxl6fp/ndxnXK3
         cHegcYVt5f5F/axkxTafznwrGmwop0xP/cRiStZBrVWwF1KXAhgXbcmSlyLnKNvE4HVD
         CQ+szfvnAjeZKLQSztoCSWslwKGDwJAgTNWRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6auFiAxxwFQX0LU6IDVQBC5x+vKf3oYBXM0DErxZxvI=;
        b=u2L9oRttxw5LXJVUg4Po7kUA8Kai08CbSQhWCvHcBE8bQYWmDALVZS1HWawakzewxL
         878zfOOIyeVKsp7Dt8D5NvjziVZPTH0zxiPpTpcKa685Y9giXl7dUyKxFKHRLhszlxmi
         pvTJQ2uJhkt8jpxzX6kHIl1aRk84zYhq4BtdWz7hXDNS1p1T+XcRGQvxbHe9jtTiOGIt
         OnRkp90rwEv8uRveTjN5OS/HrlGFfG4C03Ddwnfc53B6vXmEAebvPC4Y9jhc2kwW0aZP
         BD9cxHUmDc7IdiZUxi3QNfnGYUOziubHgZQEG/wj6psCZVWyLPB9ZKZIpFHk93en9o8T
         KgHA==
X-Gm-Message-State: AO0yUKWI1YGEtL1dhA5i4eqqgvNUGABP7NrupwOGHJDyH1Pc6KAKbnc/
        eiB+3NgXSg5tpl9YMLsU1rBW2nxBZ3KNZkr7BBg=
X-Google-Smtp-Source: AK7set8z76mRZLwOGcuEQAXPH1mA05dLvyO9T/ZmTPU+Fh4u5BtEbvmTHmPRxM/lbe64tuKPrs8v7w==
X-Received: by 2002:a17:907:c71a:b0:8b1:4516:238 with SMTP id ty26-20020a170907c71a00b008b145160238mr10097863ejc.26.1677543196991;
        Mon, 27 Feb 2023 16:13:16 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906248600b008e53874f8d8sm3774631ejb.180.2023.02.27.16.13.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:13:16 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id eg37so32895377edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:13:16 -0800 (PST)
X-Received: by 2002:a17:906:d9ca:b0:8f1:4c6a:e72 with SMTP id
 qk10-20020a170906d9ca00b008f14c6a0e72mr277841ejb.0.1677543196114; Mon, 27 Feb
 2023 16:13:16 -0800 (PST)
MIME-Version: 1.0
References: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 16:12:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggVYzViaq47Ms7Aw54UaB4fr9FiiKcr3zCqAkMePcXuw@mail.gmail.com>
Message-ID: <CAHk-=wggVYzViaq47Ms7Aw54UaB4fr9FiiKcr3zCqAkMePcXuw@mail.gmail.com>
Subject: Re: [PATCH v2] vc_screen: modify vcs_size() handling in vcs_read()
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     jirislaby@kernel.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux@weissschuh.net, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 12:22=E2=80=AFPM George Kennedy
<george.kennedy@oracle.com> wrote:
>
> Restore the vcs_size() handling in vcs_read() to what
> it had been in previous version.

I took this one directly since I'd been involved in the discussion the
whole time, so we can just close this issue.

           Linus
