Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A996A47DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjB0R0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB0R0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:26:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA3123336
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:26:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id eg37so28722605edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZogG8tw+q6uDbu7auN6I0HH9fxImm1GBhQWedC4se+w=;
        b=KvnKFTkD9OVy+iVEzQSCtDmq561fwnCc359FGEJqYF9HGgIH7FK0mQM6jvycCUtvjd
         ouuWpWhQ5Z8374288fSNpq+CMUFLx0iH+CZEy2EvQhxCQahhiE1HOvYRnd7j6TkEQc/6
         w7IOlZOiUqlwvGIwzPpkssmVvxkQ3Q24s1RmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZogG8tw+q6uDbu7auN6I0HH9fxImm1GBhQWedC4se+w=;
        b=v7VrUo+pe/+OlYGEC2sfrW0PeOWmMyeD4Be4oYCwWTWefaSK73btrbL8Huwi8hAJwi
         SztaJwP7zAdR3/6AbgxIyK3q3BvMhT5W1q3AV60ZfoPvuZGQCx0Xl+0PAASRgFR1oEsP
         tpS2ruc7d+OGo6g8Etsp7VqrAwNOTVFmLNQr/V5oeoXYX0UrSnR0GCCCCBemY1cuxduk
         LM2t9HdMwwiZNNFyhNJDQl0guuK8zEhEwVU/vsEXziRnpzTrg56+Zp2bQggsiOdonIpH
         Q9OarxB1iZDBYsbOXbaNUd4T1aJlSZ1gpFluHzjAKM93Rxh4OCY7QU1WkUtZU1Ioyxg0
         jZIA==
X-Gm-Message-State: AO0yUKUU3GCTPniqjn9uu4q5cyCO6nMaCdJH0xkP6RmDYmlXmqtBUudm
        Q8K5NHS2w+a02UKkFmRqcITjTNpxHVZ9SqW8KZ8=
X-Google-Smtp-Source: AK7set9S0p+W3Y0sa3hR+SK4KyhcAyLTImghpdYeMMcIPIFjsB8BdDlqzs0+kpbICO0ZQy1xdbBceg==
X-Received: by 2002:a05:6402:50d:b0:4aa:ca81:a528 with SMTP id m13-20020a056402050d00b004aaca81a528mr212865edv.40.1677518772208;
        Mon, 27 Feb 2023 09:26:12 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id j24-20020a508a98000000b004acde0a1ae5sm3368342edj.89.2023.02.27.09.26.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 09:26:12 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id o12so28815803edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:26:11 -0800 (PST)
X-Received: by 2002:a50:c34a:0:b0:4ae:f144:2c8e with SMTP id
 q10-20020a50c34a000000b004aef1442c8emr148730edb.5.1677518771169; Mon, 27 Feb
 2023 09:26:11 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
 <CAHk-=wi49sMaC7vY1yMagk7eqLK=1jHeHQ=yZ_k45P=xBccnmA@mail.gmail.com>
 <CAK7LNAR40OOCJhz2oNF4FXWeyF=MOQPwfojHCU=XZ0jHcuSP5g@mail.gmail.com> <CAHk-=wh5AixGsLeT0qH2oZHKq0FLUTbyTw4qY921L=PwYgoGVw@mail.gmail.com>
In-Reply-To: <CAHk-=wh5AixGsLeT0qH2oZHKq0FLUTbyTw4qY921L=PwYgoGVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 09:25:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgM-W6Fu==EoAVCabxyX8eYBz9kNC88-tm9ExRQwA79UQ@mail.gmail.com>
Message-ID: <CAHk-=wgM-W6Fu==EoAVCabxyX8eYBz9kNC88-tm9ExRQwA79UQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.3-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 9:08=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So here's the simple rule: if the packaging people can't be bothered
> to use "gti archive" to make their packages, then they had better just
> do a "make clean" first (or, better yet, do "git clean -dqfx" to
> really clean up, because "make clean" isn't 100% reliable either).
>
> We don't add more broken infrastructure to deal with broken workflows.
> Just do the right thing.

Note: I'm perfectly happy to just revert this, but if I have to do it,
then pretty much _all_ the packaging changes get reverted, because I'm
not going to be able to figure out which parts don't rely on the new
broken script.

So I'd rather take a more directed revert from you. Or, better yet,
just a rewrite to do the right thing (ie "git archive").

Because really - any distro packager had better have the git tree.

                   Linus
