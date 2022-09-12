Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED505B5BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiILOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiILOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:01:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5301E29CA7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:01:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bt10so15086888lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fTmZlTF0ozUTz9FNHM8ceugdx/I4yrLTc1mvMhk+LnY=;
        b=RWwfo4yxwS8BpjmCu1LJDE/snmzdpu6oE0csDb/L7C52g/YGf04B8d3NVVrPs2ZyKm
         5mK/NNTFxTkccaD9ootPwDWKBLqn7e4V+ls2qpch3xqdUsBJBee+9CSpr7Wo3ueWcxry
         E07Q7kdXxzLDr1FCI41+8douZ0acMx98N5ulk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fTmZlTF0ozUTz9FNHM8ceugdx/I4yrLTc1mvMhk+LnY=;
        b=7yrdBDHCvPpq7uAbkxzc2+aACHNMirGQSHUhPd9zllTPgmLlc0jWTU57cbjZymQog5
         +nh7cPAp+7xxh8fa2A0GBjycgaILVULyqwvekTi/MTeuoNVxMoW3rxoeDzJq4mB2zGZs
         VA16q10B/yqJpLs/rjfAktQt1cMursXPwKeYdYzAmBB8lXlrfVYKRyzjapwp+OzRinjH
         OAO5I3XE83b177ySchUqZ3oOh50pZSLIxBhgTAGbLEzfKAycwf4aLlBS7859ivZf+2XB
         axASbzb9m/IxAwihIXNalxZirvXsqd94AFZOhEEvp2rwb5x7DjTaggS+9x0JBk4ZMhrT
         Oyjw==
X-Gm-Message-State: ACgBeo1R3AC1Nr62NbV3Wk6jQ7AUDsr2YXdmhzLPIVMswzeX49RF47F1
        1lrBn2vOeDeFxz1gv9EspT0LvnGSn7qFDLrj
X-Google-Smtp-Source: AA6agR54MICdw/8XFIaXdGKBYzmaopnebfgOadcskhCsQ1Vc5Z6NgISuGK7yPk1k7E3ELNVtqRGUAQ==
X-Received: by 2002:a05:6512:23a0:b0:499:4c84:b7a6 with SMTP id c32-20020a05651223a000b004994c84b7a6mr4749008lfv.390.1662991282375;
        Mon, 12 Sep 2022 07:01:22 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512340a00b0048d076373d0sm1090979lfr.98.2022.09.12.07.01.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 07:01:21 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s10so10056205ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:01:20 -0700 (PDT)
X-Received: by 2002:a2e:9e11:0:b0:268:c7d0:9662 with SMTP id
 e17-20020a2e9e11000000b00268c7d09662mr7392328ljk.309.1662991280232; Mon, 12
 Sep 2022 07:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
 <CADVatmPAkS9ope2oOQHB8nKc_sx2MM9P6aSqxwdA5sgyqvCvvQ@mail.gmail.com>
In-Reply-To: <CADVatmPAkS9ope2oOQHB8nKc_sx2MM9P6aSqxwdA5sgyqvCvvQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Sep 2022 10:01:03 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh5X9q_MzUHGq1mEjJ9KqFxxDMzXoETMM_gSiGoq-eEOw@mail.gmail.com>
Message-ID: <CAHk-=wh5X9q_MzUHGq1mEjJ9KqFxxDMzXoETMM_gSiGoq-eEOw@mail.gmail.com>
Subject: Re: Linux 6.0-rc5
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 7:59 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> clang build failure as reported in [1] is still there. Nathan has
> posted a patch series at [2] to fix it, but it has not landed yet.Alex Deucher <alexander.deucher@amd.com>
>
> [1]. https://lore.kernel.org/lkml/YuwRyQYPCb1FD+mr@debian/#t
> [2]. https://lore.kernel.org/all/20220830203409.3491379-1-nathan@kernel.org/

Yes, I was hoping for the AMD GPU people to take it and have the
hardware people who actually wrote that code (?) verify it all.

It would be good to have clang finally do a full allmodconfig build
with no errors and warnings.

Adding in Alex and Rodrigo that have been involved in the previous
stack reduction stuff, and the amd-gfx list for anybody else
involved...

Anybody?

                   Linus
