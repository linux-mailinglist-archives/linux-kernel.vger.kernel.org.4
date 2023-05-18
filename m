Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5427E70870F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjERRj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjERRj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:39:26 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE376AA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:39:24 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-62385a3106dso10469316d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684431564; x=1687023564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ym80F6m3sCSA9zVZmaKKkeHjU+KvLOxFrDGkEBGtXJY=;
        b=QNCUvTgtS7EnY4NPHxD+TL2v/vt5PkkUOf23yqFrvfWWMDQcKqTm7ycFuYg039uriV
         aZRjBtnCo82xFmPPnAOpf8iCwb7z+xR9b1nY+4N7/HwVUYZgsnhOnYM3raaYXo5WyVAX
         Hr/3Unj4CCHa//RyN+F7tgNCpxpiGbCmGOekLAYp+/rbq1k8fpwgh9UM0/MEaFzE42E7
         8sR6NR01FP9MMWR/afrNOwXbJK/cR9DeYeXl3lvIz3O9Cg9//s1GIsiTsTX+I+A025gs
         02bR161mpl2Xp59IIQReOl+8Ua7pP2p2jwFSU/ipFFcmg4V/yMlvyuS41Umvey6cioJ7
         PhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684431564; x=1687023564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ym80F6m3sCSA9zVZmaKKkeHjU+KvLOxFrDGkEBGtXJY=;
        b=Fm2Ccs9KLr8z5Up5JEq/jjN1pPqv9TLywsIrWMif7aFjgfYQ3wZ0cQGC8tAuzzleOb
         NL4lsnh4oQog/LrITzzMki5QyoVDGaX0awNfro0co65u8D0/Xm/HRC5d8X2eC/KI6V4O
         21egYWd6IZ6TC69vFnHqlRRCNYXYVJND07L87iHsDFbuVLzejtR6d4TgS6lO91Xg0cPn
         v5f/qv0GCOLtJnVknRfysN58HQpp2RpXSNTSt9Ai3JU/oIn389DIGva+DU7CRWQD3HUa
         ScKLRO1lVF+sPfyr8HSM8RKslgNGm8+8VGS0SJdru1jnmH3RTsS25VxI7VfDbJow1d+Q
         fnCw==
X-Gm-Message-State: AC+VfDzVxg+BsEOd9zaguKBqrZsRbLZj3iMgSycoibaNIWGfJoEZo5Co
        lbytFHx41h7HofWK5OyCusVz
X-Google-Smtp-Source: ACHHUZ4+WSpE0ffoG+ndbrGnpfTrq/93DWzMQ6pF5Iq2vQKe/z7VXKOBYVf4kpsCXn2l36cwUW5sPQ==
X-Received: by 2002:a05:6214:29ca:b0:5a1:6212:93be with SMTP id gh10-20020a05621429ca00b005a1621293bemr597210qvb.29.1684431564046;
        Thu, 18 May 2023 10:39:24 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id r15-20020a0cf60f000000b005fdbcab3065sm667484qvm.72.2023.05.18.10.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:39:23 -0700 (PDT)
Date:   Thu, 18 May 2023 13:39:23 -0400
Message-ID: <cb8077678d0ff3192e273ef443e490ee.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: keep context struct members in sync
References: <20230511123148.722343-1-cgzones@googlemail.com>
In-Reply-To: <20230511123148.722343-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Commit 53f3517ae087 ("selinux: do not leave dangling pointer behind")
> reset the `str` field of the `context` struct in an OOM error branch.
> In this struct the fields `str` and `len` are coupled and should be kept
> in sync.  Set the length to zero according to the string be set to NULL.
> 
> Fixes: 53f3517ae087 ("selinux: do not leave dangling pointer behind")
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/context.h | 1 +
>  1 file changed, 1 insertion(+)

Merged into selinux/next, thanks.

--
paul-moore.com
