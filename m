Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99275617A10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKCJhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKCJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:37:45 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1762AD3;
        Thu,  3 Nov 2022 02:37:45 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 129so1500621ybb.12;
        Thu, 03 Nov 2022 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rEQaoZvjRMsJ4e/mV6mD21ZtiZswBVNuNIWwQ2LBDZg=;
        b=bVVcWIYmbU9WsKE1HYi8uk3fZqESbYCzHy7/i8i1qKDWZ5fmB+bzyRx140gNkqvwwv
         c66WPry7a35/iAh/HdoNfHErwFUIjdefyMI8f78kLzrojEktkcIRxx8XJ5q17BD9kj2t
         vLaUYepgxP+0/pCcn8ZzXDnnNNVdPmeK60rfgHbK+ru2F9yeCG2QTyVRjTLrcNOCCDbc
         vRVBD2qz7glLT0S1Hl5sUdRZVK2v3JpqtmM/4G125vPmdyFFQawUo5ODhjdElEzQ7fo7
         y1GyM+fOMIGBjjX77ufMKckS4LjpK28l6F2yMh5JuDMvGC52pembXCyv6F0EIu2Xn0Q9
         SNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEQaoZvjRMsJ4e/mV6mD21ZtiZswBVNuNIWwQ2LBDZg=;
        b=a59XpDn0n17UQBLnNlVCiYBWcLqjrLWeEV0quEp1dRTqnY8JaRx/MZqGIQlEPuNZKQ
         24BfUpvo+rFkzWnIC34UCZSJAWPPeNKaLfLbtS1gXN8NaLZ+RtMA4KxCeQQuv01qwYrb
         gpDnea57vD+u2d6qLbS/4dKkLXhsVnktWjMoHdshvdVzZZvpavwGKgBGKBW56Y925Uac
         vVuBauyqGnfWTA/x+xIKVabk377PrV1pP++jEJWoFrFaRYCHfXjUBpspsusfD73+2Ioa
         +LOShpt8MbY69cIccCIta4c7n3wyiPZ63i+9iIeHUmWhhla5xDk+NlBj6zGSM1d8MLx4
         mmVQ==
X-Gm-Message-State: ACrzQf1hs1+cR85KtZ7p+9ZqjQ1ScHmw4UaQNk/J5rYHaJNhuvt0s1cc
        xIMb7MXc7i5Hu7zshNx3a9k/E52Po6lvGlL6Kyw=
X-Google-Smtp-Source: AMsMyM5hX8jicN+wTGB5+I4+aFH3DyjzOT7OuiMnlaG62SIjA9qwbp+eKeF/NNTRGFAjdzj0trgU1UXVNErMwXsXCXA=
X-Received: by 2002:a25:76c2:0:b0:6ca:6604:4928 with SMTP id
 r185-20020a2576c2000000b006ca66044928mr27520549ybc.323.1667468264527; Thu, 03
 Nov 2022 02:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <CACMswuMVERF_+R3Qxb0xGHCBQUCuxtBLA+eDo__Coed3BoVC3A@mail.gmail.com>
In-Reply-To: <CACMswuMVERF_+R3Qxb0xGHCBQUCuxtBLA+eDo__Coed3BoVC3A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Nov 2022 10:37:33 +0100
Message-ID: <CANiq72n1eo4AX2mHdWkYUmLSy2WOHCGG+X6ZTmtPft7JC+t2jA@mail.gmail.com>
Subject: Re: rust nvme driver: potential sleep-in-atomic-context
To:     Dennis Dai <dzy.0424thu@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Andreas Hindborg <andreas@metaspace.dk>
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

On Thu, Nov 3, 2022 at 7:12 AM Dennis Dai <dzy.0424thu@gmail.com> wrote:
>
> The rust nvme driver [1] (which is still pending to be merged into
> mainline [2]) has a potential sleep-in-atomic-context bug.
>
>     dev.queues.lock().io.try_reserve(nr_io_queues as _)?;

Cc'ing Andreas and fixing Wedson's email. Note that this was written
when it wasn't decided how the `try_*` methods would know about the
flags.

Cheers,
Miguel
