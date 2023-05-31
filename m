Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A49718F11
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjEaXdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 19:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaXdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 19:33:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEE8132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:33:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-974265a1a40so328916766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685576021; x=1688168021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC5kQss/K4YNkiA3t8ssQaf48GcVeZPJDAECVwcI7aE=;
        b=bHcrVWqLHuOGdNjqH4yHqFgc5fE5p3hGNrFpdHBIN9XpYxYCwLH5w4weJ4Jcp8uSQt
         fwlMBEXymH6kjT9J/Hmbip/2+32v8K+ITR44/uHh/Dt1o3tTrca12Rf5gNwA+qoq1M+Q
         aEuFDzU3ExSTfn3EqsvmRmgQL/Wnn+Kj858SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685576021; x=1688168021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oC5kQss/K4YNkiA3t8ssQaf48GcVeZPJDAECVwcI7aE=;
        b=fWFs+VVUYys43+Sow0NI1niuvj4kS85PoCcQCG9V0tbZH8GmTRpTR9BCflj3dBC2Io
         zZLQthg33vbmvH0ocQ2Mc2QlsdKAYthTqrQr9J0WAnsmZDOKH8NzwG2PSVwGxQ4KjVT1
         ozUt4kt9aC0obrinX2ucwxmv5Ka4dBgS0l6nBLHpfddMqkGMTgHUuPO/outpiGeHumP4
         4RNUNckWUD7Zkm6M6ppt9mrjVCfXG9r37djJjh/Dt+cBIsmLmMHHiKkilNr/PONE4lC2
         EGmA7YNdYnxRht1a1Pm1oRGLajYbjpIsmb50rLm3P3HhlY9iG55/plTXTz06FTxX/9Kh
         q1jw==
X-Gm-Message-State: AC+VfDzPgmJA/qLuBmATP95x8BiSzeXXrsj8k+JUVu8pEOZidjAcCEFl
        OAVWZL0TlLUSoK5DsmgbToSEFik0owI1rN9fd6minyfO
X-Google-Smtp-Source: ACHHUZ6jHhsIXEyieDHr2kM823BxDvogUNKc/cFJ8+CzIzGhLl3ewX1m2+CyyV51f/IAauz3qMDl/w==
X-Received: by 2002:a17:907:da9:b0:94e:4b26:233c with SMTP id go41-20020a1709070da900b0094e4b26233cmr108060ejc.16.1685576021658;
        Wed, 31 May 2023 16:33:41 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id m22-20020a1709066d1600b0096f777fc1ccsm9537725ejr.200.2023.05.31.16.33.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 16:33:41 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-96f99222e80so63827366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 16:33:40 -0700 (PDT)
X-Received: by 2002:a17:907:7f9f:b0:96f:5511:8803 with SMTP id
 qk31-20020a1709077f9f00b0096f55118803mr91233ejc.22.1685576020461; Wed, 31 May
 2023 16:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230531220807.2048037-1-joel@joelfernandes.org>
In-Reply-To: <20230531220807.2048037-1-joel@joelfernandes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 May 2023 19:33:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgumv=8d=CqEeoYMRgqgJXePk7k5q-yi_+mO+AkdZv3hg@mail.gmail.com>
Message-ID: <CAHk-=wgumv=8d=CqEeoYMRgqgJXePk7k5q-yi_+mO+AkdZv3hg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Optimize mremap during mutual alignment within PMD
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
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

On Wed, May 31, 2023 at 6:08=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Here is v4 of the mremap start address optimization / fix for exec warnin=
g.

I don't see anything suspicious here.

Not that that probably means much, but the test coverage looks reasonable t=
oo.

            Linus
