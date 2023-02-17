Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F204969B5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBQW74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBQW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:59:54 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3947E68E6B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:59:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id eg30so9646584edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tEQSmYhd5lnJCtQxFzcCmvjtHrTwKOp3ygZ8THJUUCE=;
        b=ZdJkqJ4waQDuAQJEGWyJ3hvuW/8LBVyQq/Bo2iaLWQOjLKDO7Ir0YbQyTKVjnLyaEJ
         L136l5pyGoYnoq+SRQNSW7XcfX/Gn4wXGFRTHr5L0wolMkcFPPWX0PU9KPPebXKrs8A0
         EiWYr287GSbz5INdOAvFqnTZ5ur67QlgITwqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEQSmYhd5lnJCtQxFzcCmvjtHrTwKOp3ygZ8THJUUCE=;
        b=bWA/O0kBUAt8LY8yCaIHqAYruC+y+blCZxWDfEU+IlHC3buHSXFfR4sYN7dRUtFIAs
         rBGqyflfsEpL3cQqvOLfl0LX6vZBj1nLsLlfMqhD6KEGFBaEiS0X2ypnkjS01Pm+Caff
         xWG5B77SlOKwfQR6MZ6L+ZJzdPqlIo0M4YaBlguOk13jNVHUtPwEc2CvlEXqUjtu7+7Z
         sHyLbz6oWHExlZX2Lv/6T+Ckn5ltDtzedIP3e5a0jIweO7aCmOQDKJB0TXrap/AISscz
         dBTaqCczmXXcX+UAai8b/TeGJbJdAqu2kiH3vRaXqZgKkUZAwrbqKTm8tsmQIRyzZElZ
         6nlg==
X-Gm-Message-State: AO0yUKUwVr3eYek3Xe8kcaLaYZvDL179iB99NSR7ZaLzsu5JQuJFaJbG
        Y89OqlyEheU8mf6nbj+58GEB8ik+p89ca1W/bDs=
X-Google-Smtp-Source: AK7set+tPNmzLPNpRe9Ba57kS92ig62MpbiUhJi6I2PV9GLuRXnKGkodx6TeT0fYCeJJ0W+rhnj10Q==
X-Received: by 2002:a17:907:a801:b0:8b1:304e:589e with SMTP id vo1-20020a170907a80100b008b1304e589emr1665480ejc.53.1676674756959;
        Fri, 17 Feb 2023 14:59:16 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id jz19-20020a17090775f300b008b17cc28d3dsm1751934ejc.20.2023.02.17.14.59.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 14:59:16 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id er25so9629119edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:59:16 -0800 (PST)
X-Received: by 2002:a17:907:988c:b0:877:747e:f076 with SMTP id
 ja12-20020a170907988c00b00877747ef076mr1226419ejc.0.1676674755989; Fri, 17
 Feb 2023 14:59:15 -0800 (PST)
MIME-Version: 1.0
References: <87h6vjzzjh.fsf@mpe.ellerman.id.au>
In-Reply-To: <87h6vjzzjh.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Feb 2023 14:58:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=m4sr1iLbt_PMmbrWsjLmkCAbz=NkKZmfTYFWv-RA7Q@mail.gmail.com>
Message-ID: <CAHk-=wh=m4sr1iLbt_PMmbrWsjLmkCAbz=NkKZmfTYFWv-RA7Q@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-6 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     bgray@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
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

On Fri, Feb 17, 2023 at 2:40 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Thanks to: Benjamin Gray, "Erhard F.".

That just looks _odd_.

It's not like the full name wasn't already elsewhere in the kernel
logs as a reporter (and at least once as patch author), so I just
fixed it up ;)

               Linus
