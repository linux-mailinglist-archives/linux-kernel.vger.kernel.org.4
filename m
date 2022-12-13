Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A8764AE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 04:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiLMDky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 22:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiLMDku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:40:50 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EDF1B9CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:40:49 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id j16so10892870qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUAqA2SlkGJGoP8jdNp8BFCeN3i3DSiZETy07vaICDs=;
        b=g9Nl4T/+fTHSkFjHq2JeyH2Z1NmJhIvGaWhttKU1xSkd8QffENkiRwL1EFi8dsGs1n
         zpDjgklpa4gBd1ZEL6VEnRPTQ5RtKrdkKHENJrwDOWxEAnh8oW5CRMFuErOtRa+54qtF
         4HWD5YH8xkBqOV50nhvtn1xHXJhKz74isoqRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUAqA2SlkGJGoP8jdNp8BFCeN3i3DSiZETy07vaICDs=;
        b=IfS2IsbDwEvk73w9AAHMx+eb4gNDzqh81mHNSSYluz/i9GlvJDSv7svcnnUkhoXSD/
         ViVbCEyARNxg/3ngffhvWMyp/sjaWVacEjKImbaK6D0iMGNLcrrOS31lwdiL01zDcu4/
         kPrNHOcAPVaw2wsV1tbVTSNvFEAO1THbkzgh+WUO3T+aDPn/5jDbI3zYdZ1+94nqlr1x
         Y+uvkzyQ9ZpUDAagsn9q3Nzn2zmJ4ol1YYKqu+Mk3/2Wt8kS+dZEY/Zn/Pyp8Yof1RXc
         UgL+FTFQYGqFxf/xzBBYJhLiQYQUhmEXq46EFTAR953xrlmVh5bCsFneLmlRLGUJjywG
         Yr8g==
X-Gm-Message-State: ANoB5pk1ixSZqJAYPq+DIvy97r7OHRInGFsb11besu+PLAKTTS/SmbGI
        WFKTxpTFmRRtWAxKq51J6ozvbGVD7O5X3ihL
X-Google-Smtp-Source: AA0mqf53l0VOcl/lVZHxjY+HDvXIWXQS3fRJTvn40qTwSx1ZLfV32iYpZzLvTO7sZFPv5j+B+Iyx9A==
X-Received: by 2002:a05:622a:90f:b0:3a6:2170:b0a1 with SMTP id bx15-20020a05622a090f00b003a62170b0a1mr29476477qtb.6.1670902847508;
        Mon, 12 Dec 2022 19:40:47 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id g8-20020ac84b68000000b003a4c3c4d2d4sm6856423qts.49.2022.12.12.19.40.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 19:40:45 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id h16so10892493qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 19:40:45 -0800 (PST)
X-Received: by 2002:ac8:4988:0:b0:3a7:ef7b:6aa5 with SMTP id
 f8-20020ac84988000000b003a7ef7b6aa5mr7555265qtq.436.1670902844805; Mon, 12
 Dec 2022 19:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20221212131915.176194-1-brauner@kernel.org>
In-Reply-To: <20221212131915.176194-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 19:40:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com>
Message-ID: <CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com>
Subject: Re: [GIT PULL] fs idmapped updates for v6.2
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 5:19 AM Christian Brauner <brauner@kernel.org> wrote:
>
> Please note the tag contains all other branches for this cycle merged in.

Well, considering that the explanation basically assumed I had already
merged those (and I had), I wish you also had made the diffstat and
the shortlog reflect that.

As it was, now the diffstat and shortlog ends up containing not what
this last pull request brought in, but what they *all* brought in...

I'm also not super-happy with how ugly your history for this branch
was. You had literally merged the acl rework branch three times - at
different points of that branch.

Do we have other ugly history in the tree? Yes. But we've been getting
better. This was _not_ one of those "getting better" moments.

Oh well. I can see what you wanted to do, and I agree with the end
result, I just don't particularly like how this was done.

I've pulled it.

             Linus
