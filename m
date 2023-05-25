Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CE77112E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjEYRxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjEYRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:53:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006411A8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:53:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-513fd8cc029so4948946a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685037195; x=1687629195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cki7nTSfn8V9Pz9bjx+wUZ3Q24K9M6RV4kOzAoI4Ezk=;
        b=XrV64fr5Mag6CUjiziJvfDv5unpQ7hhihFblhWSZ44yLetK4OQao/FT84no7dxinwR
         RWzjToFjnd0jRNhRUWE0nTJV15bcsolN/0xXVXWSHDi1GVZCR8IyV4ZISWTFvQ2+cppf
         Xxv9yvIn2ammUFCVrgbuS7gi6wO2x1nBjq0dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685037195; x=1687629195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cki7nTSfn8V9Pz9bjx+wUZ3Q24K9M6RV4kOzAoI4Ezk=;
        b=YSzAb8z2VNvE0NoUPBkhp8JRVdq9PPZeIG+W9V3cRMRw+wJd59eF+5JLOnRGaTaNTy
         jlMlHZOEHM8lMLncZnyxji8aCAj9+BvLTRNgnTMBV+q4eQIq9BYKy/Q/vu4Y0ev90pp/
         259hRbxVUknt3QeQadmpWyHIs/2luvQIDyV8VBqaDFN1VNcwYP4r2dYD3lKojT4m8xBe
         JDK0SdHIeexwK0KY8LEHeP6WpI1aFaxaVdlNmFbQo3qi4dvTjREwVgWqUWF2LxGEXpyC
         KoIk6C6aINEAZU7OYWC2q0F21+C2Y6FHEulveMqwffB1Nh8PwHUkpBw4q/mATKauXAMs
         LhPw==
X-Gm-Message-State: AC+VfDxpwIqnE7typhqjrvsE52DydbkqNpl/711iGqkKs4vMpu6VbR2I
        1/6GGJVBCMiq7iscSNlw3IkapJr+9tKzsaXDN4g4DHal
X-Google-Smtp-Source: ACHHUZ6a4PM9wWX+6g1ZSyIdxS/AAgHVk1nHN70EHW1dIBi8nm1FNSpEdYop9u6/+fFdjJGUlXUUUg==
X-Received: by 2002:a17:907:2d08:b0:96a:928c:d382 with SMTP id gs8-20020a1709072d0800b0096a928cd382mr2752205ejc.48.1685037195331;
        Thu, 25 May 2023 10:53:15 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id bx8-20020a170906a1c800b009584c5bcbc7sm1096894ejb.49.2023.05.25.10.53.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:53:15 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-513fd8cc029so4948910a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:53:14 -0700 (PDT)
X-Received: by 2002:a17:907:9493:b0:965:fa80:bf1 with SMTP id
 dm19-20020a170907949300b00965fa800bf1mr2195225ejc.32.1685037174582; Thu, 25
 May 2023 10:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com> <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:52:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWeV-ct7pFvBF6m1gzbqdp_K7nQe=++Ov029g6Fc3dsg@mail.gmail.com>
Message-ID: <CAHk-=wjWeV-ct7pFvBF6m1gzbqdp_K7nQe=++Ov029g6Fc3dsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        lucas.demarchi@intel.com, christophe.leroy@csgroup.eu,
        peterz@infradead.org, rppt@kernel.org, dave@stgolabs.net,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 9:07=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, I posted an alternate patch that I think _is_ valid as that
> quick hack. I don't love it, but it sure is simpler (and avoids the
> i_ino bug):
>
>     https://lore.kernel.org/lkml/CAHk-=3DwgKu=3DtJf1bm_dtme4Hde4zTB=3D_7E=
dgR8avsDRK4_jD+uA@mail.gmail.com/
>
> that patch hasn't seen any testing, and for all I know it won't even
> boot because of some thinko, but I think it would be acceptable as a
> workaround if it does work.

Well, it boots here, so it must be perfect.

That said, I didn't add any debugging code, and I didn't test it on
any odd setups, and I've never had any problems before. So I don't
actually know if the patch *does* anything.

But it did boot..

               Linus
