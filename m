Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145C16ED62F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjDXUf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjDXUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:35:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF2855AE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:35:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f3cd32799so900871966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682368521; x=1684960521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EZg4bJwNrqDKm8uUHWAs6EXRYbHfgSrAawqIxS2VJg=;
        b=V1euncgd9P+AT14UWV2Ap2HnJ66xkvHZAAp67OhT4szkcDSemzpko/sKtdpdTrAyhA
         3CgH+Wmv+oTFgzZNpR4NDriBddBgbb+B3CQv3Cprh8OLZ+iz6E70rcRiNDxK96KUHMlK
         ET+xw2M/Q5k5vtjmR1IDDbRJMb/cpnFCrrQFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368521; x=1684960521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EZg4bJwNrqDKm8uUHWAs6EXRYbHfgSrAawqIxS2VJg=;
        b=JThE6kRoyRubRUZOzSDu+Y1cpBVZYvkoWYWKr3oABmgaj5ulNWPO0mjbZEmVf9Ptq2
         9ONXgNlYaMsbiU6d9DSVB2omTPsejYSRan90n4+W0xzeKn0pMuTETVVfIJeV5M7O+H4G
         zaUXncDwF/3R0iRHWW1midK+nP9SM3Ghv9Jcy3hu5LHKSsupfla0uS8vHG5r1zJ23DFr
         jk+8E7NP6+syWPnxvhEGVVB21T90CpClZsmp5dwG0JHWfsEyysDmVZXNCyIO6d1u77kg
         2V2sM4lH2M/zSnqgjaTlT0E8XQ+7KTTZu1sAtZeG+Co+50TllAOtxq3xfS1uSWhhm2cm
         3rKQ==
X-Gm-Message-State: AAQBX9f6hLe2ljDHolJ7fkLX2/szFytgiHcVbDxY2Fm7349HBxnZP82F
        ZM9hEl684W+lddmSWsFKeF6Fju7+RnMMP0hLnty+OiJY
X-Google-Smtp-Source: AKy350YY90Lnxw8s87ojapMRfTWUy7Sm2zZTdu+a6Usmv7V3A58AtoQFpmnK4Zq/s/DutIQKZLUjvQ==
X-Received: by 2002:a17:906:1719:b0:94f:5fd0:dd43 with SMTP id c25-20020a170906171900b0094f5fd0dd43mr11648773eje.62.1682368521057;
        Mon, 24 Apr 2023 13:35:21 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id mc2-20020a170906eb4200b0094ca077c985sm5874199ejb.213.2023.04.24.13.35.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 13:35:20 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so8760572a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:35:20 -0700 (PDT)
X-Received: by 2002:aa7:d689:0:b0:509:c669:1e93 with SMTP id
 d9-20020aa7d689000000b00509c6691e93mr7835495edr.23.1682368519946; Mon, 24 Apr
 2023 13:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner> <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
In-Reply-To: <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 13:35:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFt+rPoEH1bPG2A9K3GNebraLNcbnDiKK=Wp0i6D_0Ww@mail.gmail.com>
Message-ID: <CAHk-=wgFt+rPoEH1bPG2A9K3GNebraLNcbnDiKK=Wp0i6D_0Ww@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd updates
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Apr 24, 2023 at 1:24=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I really think a potentially much nicer model would have been to
> extend our "get_unused_fd_flags()" model.
>
> IOW, we could have instead marked the 'struct file *' in the file
> descriptor table as being "not ready yet".

Maybe that isn't worth it just for pdfd, but I have this feeling that
it might make some other code simpler too.

That pidfd case isn't the only one that has to carry both a file
pointer and a fd around.

Looking around, I get the feeling that quite a lot of users of
"fd_install()" might actually have been happier if they could just
install it early, and then just have a "fd_expose(fd)" for the success
case, and for the error cases have "put_unused_fd(fd)" also do the
fput on the file descriptor even if the low bit was set. One less
thing to worry about.

I dunno. Maybe not worth it. That "two return values" just made me go "Eww"=
.

               Linus
