Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC87F72618D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbjFGNmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239736AbjFGNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:42:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF31734
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:42:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso1441756a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686145335; x=1688737335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiIXQUoQS8DCNXkzHjQBBuAray21dUopxg1MttS9gnA=;
        b=iQgS+dx+fa3dWOplc6Y6SGsLPmPzDMWB0E5jSQmg6BaQTGfjbH3gx5Ow0HI930asUF
         rR6rc+0BF90XhwcnU0JSvCQzsGsfdSQUAmPdXgXlZe2Lka0JtXH8IX9IqW1r3Q5/8yee
         IkHfhuKoM+mdf2DtcKEDaZhBuZ17fvnhuIOlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145335; x=1688737335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiIXQUoQS8DCNXkzHjQBBuAray21dUopxg1MttS9gnA=;
        b=hTv8B1AWw40c8duLSsiQl6hNMK2KqKvYdOZLn8KO5F4mmXuZIyn+gyOmRFZZC+oXKa
         R5JEhQ/3JPV2nm4VmA6TBqKY/sCYC46guy3HWgacM5IEKfkL2kgmWJYvlFKC8JQqdaYg
         HXvK4VgXxroTpfAJWHkk1uHGfnYEnKsbXgvEtwVSTsC5tXAd+oi3x98CIMb1X5xcr1qn
         +MqxlNashbIGoSqNU5GbK/UMni7W3dcRBTShJaTv32rWoGHczxXQABgxpHX+OkcCn1rx
         KQrJkh+wPENqysexh0pBxSPiHV/15oR2eDpBJf5GyMhiIRynIrBH0lUh90CLFm+6cMjI
         03mQ==
X-Gm-Message-State: AC+VfDzdQAtlmQUJeCfrtVIbaetn1Jxx623A2AKWgxz5zxKZU+cv+z9t
        lnEEKEO8/R69axuH77dVWQ1waYHWXYVzdiLKMJ4lrg==
X-Google-Smtp-Source: ACHHUZ47tmtcWgkaruixaJTTez/azcofW1vGoN2zQicj5pAnVUOmXvyG6poqQABjckd6tjHXzS6MZdtow2Z7NJLVAS8=
X-Received: by 2002:a17:907:1626:b0:96a:1ee9:4a5 with SMTP id
 hb38-20020a170907162600b0096a1ee904a5mr6776188ejc.8.1686145335153; Wed, 07
 Jun 2023 06:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
 <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com> <CAPnZJGB8XKtv8W7KYtyZ7AFWWB-LTG_nP3wLAzus6jHFp_mWfg@mail.gmail.com>
In-Reply-To: <CAPnZJGB8XKtv8W7KYtyZ7AFWWB-LTG_nP3wLAzus6jHFp_mWfg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Jun 2023 15:42:03 +0200
Message-ID: <CAJfpegu4_47=yoe+X7szhknU+GedJTqHO0h_HcctqZuCiA41mw@mail.gmail.com>
Subject: Re: [PATCH 0/6] vfs: provide automatic kernel freeze / resume
To:     Askar Safin <safinaskar@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-pm@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 13:13, Askar Safin <safinaskar@gmail.com> wrote:
>
> I found a workaround for sshfs+suspend problem!
>
> On Tue, Jun 6, 2023 at 5:38=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> > Issues remaining:
> >
> >  - if requests are stuck (e.g. network is down) then the requester
> > process can't be frozen and suspend will still fail.
>
> > Solution to both these are probably non-kernel: impacted servers need
> > to receive notification from systemd when suspend is starting and act
> > accordingly.
>
> Okay, so you said that the only way to solve the problem "network is
> down" is to fix the problem at the sshfs side. Unfortunately, sshfs
> project was closed ( https://github.com/libfuse/sshfs ). So the only
> remaining option is to use some hack. And I found such a hack!
>
> I simply added "-o ServerAliveInterval=3D10" to sshfs command. This will
> cause ssh process exit if remote side is unreachable. Thus the bug is
> prevented. I tested the fix and it works.
>
> But this will mean that ssh process will exit in such situation, and
> thus sshfs process will exit, too. If this is not what you want, then
> also add "-o reconnect" option, this will restart connection if ssh
> dies. So the final command will look like this:
>
> sshfs -o reconnect,ServerAliveInterval=3D10 ...
>
> This finally solved the problem for me.
>
> But one issue still remains: if the network goes down and then you
> immediately try to access sshfs filesystem and then you will try to
> suspend (and ssh doesn't yet noticed that the network gone down), then
> suspend will still fail.

If the ServerAliveInterval is set to less than the freeze timeout (20s
by default) and you apply the patch and start sshfs like below, then
suspend should be reliable.

  (echo 1 >  /proc/self/freeze_late; sshfs ...)

Thanks,
Miklos
