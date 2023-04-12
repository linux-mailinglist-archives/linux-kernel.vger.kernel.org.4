Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CD36DFDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDLSoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDLSoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:44:03 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D65440E1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:44:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id z3so4132802qvs.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1681325041; x=1683917041;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NA3yKE/A/kXoMe2VU/QiDPUbIiNd9/qULMU5+xukd6U=;
        b=T96QhM5Sh+19QAqixHf79oSq09AeNY57s1bb9hNgC1Fjdlfd+Lk9MayayE6mffYJ7+
         92/xlz+ghBXN+hpjI2YWV4wgPGFVyNVPhTSHBe17VgzAENIaAyOZdFv0nlM5U/q7QvUk
         LGWGdDIEvpN8UsXExM8Z74bi+XuMf72JY3Z8CI2zUMDkImIm8AA21IXU2qPuvHfepNYr
         RJCQ1dm8j/TPvS49mvv1Ax8VxFjAwJF5VyAh5UMRrGrgOO1f0RdTmhoK0Tx02Aw0sXyJ
         pqIlb4q/3rWhIFb2I/pcBbv1grpU0kbkpCRefnDTbSdtaVzc+NUNj1yqB4MWImjmYb+V
         8jvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325041; x=1683917041;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NA3yKE/A/kXoMe2VU/QiDPUbIiNd9/qULMU5+xukd6U=;
        b=Arpaf/TZrKQcP4IxpOVLKiuRgaYYlry+TL+jxswsM9urXxvgaGFjZkBbp3Kc7boQwt
         7idnu6gp0hZ22anXa8hPoCJq7nzJ8diXi4lkFFWD1tRd1vOKBsEfTVq+AlAAT9pMlW7X
         vHnODT4iRvXcdXb/1MA3D6g6pZLzLx76pbfde6zE57b1wwVhTBuPtM2C4dh++CmALp4c
         kpcxeijcZy2JnJhK6utFjQx7+4w1On/8ssYDpVaXvncANLFqYoOKnYFUgcfCISLSQMOF
         IrRg4qUT3ojeMjfl+/cdaYu/qBt5v/CtYv6N262tKqMST0MsE3Z61WbwVWcR7CE5qYKQ
         lE5Q==
X-Gm-Message-State: AAQBX9dR0AmIZMb+divuUck8XX6aRx+RxkTViONiTwODjpatJVv0EKfU
        n6hAE0yNawhUEdPlMF7JPhrZxQ==
X-Google-Smtp-Source: AKy350Y3OC9A50D1pW6cq4oVehWpe37l+cmYeLQ8rIj8dC+wF1vYlypEuM8OFvq1g0Zqah6s+Gwivw==
X-Received: by 2002:ad4:4eef:0:b0:5a3:725e:425c with SMTP id dv15-20020ad44eef000000b005a3725e425cmr27210024qvb.2.1681325041277;
        Wed, 12 Apr 2023 11:44:01 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:199e::580])
        by smtp.gmail.com with ESMTPSA id m10-20020ad44b6a000000b005dd8b9345cesm4987525qvx.102.2023.04.12.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:44:00 -0700 (PDT)
Message-ID: <3fa75b5748022c63dfb75ff82e1d4a84d58a296a.camel@ndufresne.ca>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Theodore Ts'o <tytso@mit.edu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Deborah Brouwer <deborah.brouwer@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@collabora.com
Date:   Wed, 12 Apr 2023 14:44:00 -0400
In-Reply-To: <20230412025834.GA301301@mit.edu>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
         <ZDSRSWhWsN34MghQ@xps>
         <CANiq72=n1b=fJ2XZZx_MLKkbKMTmnmTBMgA3GJ_hqyARPtwEiQ@mail.gmail.com>
         <20230412025834.GA301301@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Theodore,

Le mardi 11 avril 2023 =C3=A0 22:58 -0400, Theodore Ts'o a =C3=A9crit=C2=A0=
:
> And for those distributions that don't currently ship Rust, such as
> Fedora, if someone could build their own unofficial packages, until we
> can convince Red Hat to start shipping -their own supported Rust
> compilers, that might be a great way of bridging that gap.

Rust can be installed from package on Fedora. I sense a lot of unverified
supposition to justify your argument. I don't believe this contribute much =
to
the discussion. It takes about 30s to search on your preferred search engin=
e and
find the fact the Fedora ships rustc, and the version is very recent.

regards,
Nicolas
