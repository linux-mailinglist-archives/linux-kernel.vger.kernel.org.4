Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D86BF006
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCQRn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCQRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:43:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12166C7960
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:43:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so23347064ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679074979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juFDL1t+0yx3APjFMS4e9m1CxbDK324iou62xX9HrZ0=;
        b=KVCb0QitJRceshCJW/1OPV00ZBK8c9i6G/G4LiYv/A8SmOvh9XBUwnci7b47V29WCO
         bfrXR/E4ENyR9ExqN9Fd+5H/5/caOVc0BIONWYcc+hqD4J9tzLC8+oqPWeD98WVk/gtp
         rPMOFFNDarwMeJQzdUyiW9fSlHqUJYMapIQQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679074979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juFDL1t+0yx3APjFMS4e9m1CxbDK324iou62xX9HrZ0=;
        b=SGuUL3Gw4oysEykluMBTcUWN+elT5d/+bGcWIWzYKhEKqUh8lzz3MbgCpQ275RiJhp
         WGG+2F48zY18vGAdpRDutxLnfQ7ZvyFtvHtrBxiXWJcdTyfsh7XmKyE67LtsU2RLsZGw
         y/KtG2wYgjN0Lyw0Ow4A+HQvD570qe4w7vn4hoyEXvhzHBUbRrYSvj4cu/MQypvry01o
         7Xe2C7DPt1CSGUrQyslYn6mDs0EHxQ58NAe3sL9mGCUVhNKTjy6JgBBfzWjc9VBS59MS
         BiZzJxbmddBqmhvUlagVYHL8AVcdCl+iyJYp2+x08Rkp6yHKRBk00qNYHJPhQaA+hCjE
         JGHQ==
X-Gm-Message-State: AO0yUKXawUixG0hzRt4okv5i2C2pge+859VOeWxE66f6pVbvL7iB5ZhV
        5vpLLRz2wpTjrLjF0FlUXliE+hI0VmLOMyX3p+kcog==
X-Google-Smtp-Source: AK7set9os6YM9RgZ76UPyy40r8dgrHJnMqhuyw0E77WD1TegQQdmexQniqC+O4tjvjFRALj1ZW6RJw==
X-Received: by 2002:a17:907:a04f:b0:931:51c0:7300 with SMTP id gz15-20020a170907a04f00b0093151c07300mr95087ejc.77.1679074979582;
        Fri, 17 Mar 2023 10:42:59 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906845200b009222eec8097sm1210745ejy.75.2023.03.17.10.42.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 10:42:57 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id o12so23330638edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:42:55 -0700 (PDT)
X-Received: by 2002:a50:ce54:0:b0:4fa:794a:c0cc with SMTP id
 k20-20020a50ce54000000b004fa794ac0ccmr2222273edj.2.1679074975032; Fri, 17 Mar
 2023 10:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230307212223.7e49384a@gandalf.local.home> <20230307212615.7a099103@gandalf.local.home>
 <b919b550-6da8-f9f0-a0eb-0fd8af513817@amd.com> <20230308074333.49546088@gandalf.local.home>
 <980021d5-09f7-9fc3-2726-44884a57822f@gmail.com> <CAM0jSHPf5u4=GGWm6x-zVkLA_LScAxq371ny2NoozuNjHfQefQ@mail.gmail.com>
 <2b7fe203-82f5-2726-cd64-01c7421560d3@amd.com> <20230315162011.351d0f71@gandalf.local.home>
 <20230315202133.7cb1a0fe@gandalf.local.home> <20230315202242.581c67bf@gandalf.local.home>
In-Reply-To: <20230315202242.581c67bf@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 10:42:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH83GOhjDaVnTUYfSf0XOLp-jpFACLSd8Uc59GzaCZug@mail.gmail.com>
Message-ID: <CAHk-=wjH83GOhjDaVnTUYfSf0XOLp-jpFACLSd8Uc59GzaCZug@mail.gmail.com>
Subject: Re: [Intel-gfx] [BUG 6.3-rc1] Bad lock in ttm_bo_delayed_delete()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Auld <matthew.william.auld@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        linux-media@vger.kernel.org
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

On Wed, Mar 15, 2023 at 5:22=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> I hope that this gets in by -rc3, as I want to start basing my next branc=
h
> on that tag.

My tree should have it now as commit c00133a9e87e ("drm/ttm: drop
extra ttm_bo_put in ttm_bo_cleanup_refs").

                Linus
