Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54D16F0827
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbjD0PWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244194AbjD0PWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:22:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD104EE9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:21:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so1600938266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682608912; x=1685200912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwewOZK7JBxGabnXdHhR1rBDIN8G0aMcI1DZlXZ+li0=;
        b=g2A6QM0BDUoUqE0IeGiIMb66AZcDuDEzbh8NnUSrTk9Y4Jqq2BZ4N2rqALEc9qWHkc
         UO4dT6+2nZLmN0BpS5GOp0cQf1DwuKFIyY8US3/JZG5N3sIcGzXqXDTAO9GYPqZP2n0e
         QHKKaRSyBJoMUgMstqZnPa5+w6oUXLX4GsjpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608912; x=1685200912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwewOZK7JBxGabnXdHhR1rBDIN8G0aMcI1DZlXZ+li0=;
        b=Jrftnsr+u1D0OHNOSho+l3wJM1DLnUu+FwadoZ3vBQdDyh1ARreh3dpB4535gsTNv5
         RrwbGzCed9QMG+ftbOcJWkXgYhpJLDAKAHE1vS/f0MBjNEMv4sXuzSSbVxzxAZVYoxFJ
         C/7X1xR78iq3XCh4aoPnCcMO68oWMS2o3pYBi6Em2nfMQbAFgTqNTTpYlpfAO2zrXFRu
         +32UiBmAimBbUGDIUtmwuFIeoQsSq1AkQ/9/XKGTn0FAbhzaguKwl/PFXJJNpAbc5rSG
         ePqStzxvDGK4ry6hopBEBd2OwQUF5Sqr9kj8ZEp2B185VFu606MI7t9HYKb884ZFegO/
         1ndA==
X-Gm-Message-State: AC+VfDyBM1WGKjpbUFA7MEwubtOFBMTzRjf4t1aYxGZVmTAyxMhr+QpF
        TxDDqLV1m5vfVno+Qm1IexcY5TkYR33PmSEJs6TTXQ==
X-Google-Smtp-Source: ACHHUZ4czcJl0H71if79lPtebtktB8KJY+hFQqpNrQs94AOA5/baGwy8jtKY4lkgsnkOf4+TjcngUA==
X-Received: by 2002:a17:907:3ea7:b0:95f:4c5c:4eaf with SMTP id hs39-20020a1709073ea700b0095f4c5c4eafmr2426876ejc.46.1682608912431;
        Thu, 27 Apr 2023 08:21:52 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id sg9-20020a170907a40900b00959aba150c3sm5235077ejc.50.2023.04.27.08.21.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:21:52 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so14982519a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:21:51 -0700 (PDT)
X-Received: by 2002:aa7:d407:0:b0:506:c2b2:72fc with SMTP id
 z7-20020aa7d407000000b00506c2b272fcmr1606707edq.7.1682608911570; Thu, 27 Apr
 2023 08:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV> <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230427010715.GX3390869@ZenIV> <20230427073908.GA3390869@ZenIV>
In-Reply-To: <20230427073908.GA3390869@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 08:21:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHbXMF142EGVu4=8bi8=JdexBL--d5FK4gx=x+SUgyaQ@mail.gmail.com>
Message-ID: <CAHk-=whHbXMF142EGVu4=8bi8=JdexBL--d5FK4gx=x+SUgyaQ@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd updates
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 12:39=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> int delayed_dup(struct file *file, unsigned flags)

Ok, this is strange. Let me think about it.

But even without thinking about it, this part I hate:

>         struct delayed_dup *p =3D kmalloc(sizeof(struct delayed_dup), GFP=
_KERNEL);

Sure, if this is only used in unimportant code where performance
doesn't matter, doing a kmalloc is fine.

But if that is the only use, I think this is too subtle an interface.

Could we instead limit it to "we only have one pending delayed dup",
and make this all be more like the restart-block thing, and be part of
struct task_struct?

I think it's conceptually quite similar to restart_block, ie a "some
pending system call state" thing.

(Obviously it's entirely different in details).

          Linus
