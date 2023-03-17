Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22AC6BEE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjCQQfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCQQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:35:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876565328F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:35:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so22547964edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679070905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwwFe9XoORdWYnr1GggJwexbAEqzdO4e3QsgeG37W0s=;
        b=bJft0Wdr2IsagGUK+795Mty2OjjrtqhsxSPLBzqlylRuW4EedUA1s0x6Lkx2HU2dmb
         Sr595T99LhSewIShJ4Pgqlk9HuZmaoIll1uuivcMVjS1SExqQNGUwiCLcA1BKYm4jqkk
         an7ZKo+A3whn8ygZCHTdr/MLLayqSUPhkxYiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679070905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwwFe9XoORdWYnr1GggJwexbAEqzdO4e3QsgeG37W0s=;
        b=2Ed+tu35JVoQThD/lbMFZlZIWQXvyay+96UUmF2oL/IOfiHbT3x1V2VTb1ZoMyrZZc
         eGlhkMcqlFfPm2jM6CFZnNF7HANq1B5gBSQJOoN7DSyynxpkXve6Gu2v/wtT1KapGMm6
         tVFzFIePCKH1ARxSWvvhzsQHLTuDlv/x9IUNu/yy/fb6rXz2nGDqgfTp1QSuWi7sY32V
         tGPIEdVzkpf0kXmTphsTcoR1lqYPNuLIWLjcvhQiQqXDs+0Nv6Ni/JEFcirVgo+dw1yB
         ir7fzs6UZbhaNZUikptA9BvFeTESRHwt1LvPdVdEhl79PJAd2Ht+zR3f7IREiXwcCC8j
         lhrA==
X-Gm-Message-State: AO0yUKXyHjp4aAYwOl8NOtCEqE01Fmt1ianTK5GiEixPsMSyIGzdJtgT
        U5poThp1HoOhBwzVSlQsf0EdJLsJSLiOaHN6eTrsqA==
X-Google-Smtp-Source: AK7set+G3OW6hkQ+socl1u8JLu0U+gIQKl9zNWjceyKiJgK7JsdAqbw/1V2ZUQGVWCcvywe8kPVghA==
X-Received: by 2002:a50:ff17:0:b0:4fa:b302:84d9 with SMTP id a23-20020a50ff17000000b004fab30284d9mr3947012edu.14.1679070905262;
        Fri, 17 Mar 2023 09:35:05 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id d23-20020a50f697000000b004fd2a7aa1ecsm1299364edn.32.2023.03.17.09.35.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 09:35:04 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id cy23so22578841edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:35:03 -0700 (PDT)
X-Received: by 2002:a17:907:a40e:b0:8b0:7e1d:f6fa with SMTP id
 sg14-20020a170907a40e00b008b07e1df6famr7325815ejc.15.1679070902628; Fri, 17
 Mar 2023 09:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230317053152.2232639-1-kuba@kernel.org> <20230317093129.697d2d6d@kernel.org>
In-Reply-To: <20230317093129.697d2d6d@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 09:34:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxEH_4v3wBJJqJJsR7dWqh-xdRLW=CrbPK+bYZ-RN1Sw@mail.gmail.com>
Message-ID: <CAHk-=wgxEH_4v3wBJJqJJsR7dWqh-xdRLW=CrbPK+bYZ-RN1Sw@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.3-rc3
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 9:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Sorry, please drop this one if it's not a hassle. I'll send a v2.

No problem. Dropped.

                 Linus
