Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD56EDA47
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 04:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjDYCm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 22:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYCm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:42:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31593A5CF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:42:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94f910ea993so769559066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682390544; x=1684982544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nopTUbVZ7u3O1SJHx/a+pOrc1wtXatQ+0xOyurfkVU=;
        b=bkGHOFl/A3AIkh+vhdFHdK4+suPQ7wV0Q2e4XGDIMNcdqwBkFgovSOnoWzQbYFEcEF
         xB2a8712eKqExMB7wsRe3p386ZmohKyqo2p9SrvFu+ghj800bdzoLx/HbccUPD/EDffU
         DZT3QVbuw69Qv64XYIXyURZdjXcKJOT6jw0AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682390544; x=1684982544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nopTUbVZ7u3O1SJHx/a+pOrc1wtXatQ+0xOyurfkVU=;
        b=gAu1V1iMnEmgqgrL2L5jsZBvSGCXHN5FYaXsiKlyHPliPhbfgEgd28RBwHN4RGZtJO
         Xt+MguS/vRpUmomHawRN8B4RSZ6EX87ishwVdyWX/+uqS4Z5GU4gLv+Hv4frtcnz2YbY
         l0OvoGXFCggS7x2tA/0HZgSO2DKF7OR/NKonh1hJj9LCk88FQT++sS7s/mpiuXPNWE5K
         QECULHgyuqvMc/rGcSK2gvaIppqffoXOIhnK2iKU+3CoVHoRIJ5JpZAmyc54UQ/6C7su
         EtfS+yMNaxkkTvRliUg/2qLwmNr4vrHVr18+RuolibIzI5mwsgTqbTS6HhpopcNsN6jo
         0zqA==
X-Gm-Message-State: AAQBX9cH+KJ0KQmDq8pbqv+3OByOQ0DFo2lFXa7dApOktNwsHHLSlKvS
        EHK2pDq9Ud/Q2tcOFFFxGbsRL5d9FiHIcQNNVIpLOHCR
X-Google-Smtp-Source: AKy350ZcKPABwapLjHu9ri4vPojx9ffsVd1htC8cvDbnp3ksNNb6dJG2630+JIS9YMvLGZr6mSr+CA==
X-Received: by 2002:a17:907:a40e:b0:94f:a292:20cc with SMTP id sg14-20020a170907a40e00b0094fa29220ccmr13911355ejc.41.1682390544447;
        Mon, 24 Apr 2023 19:42:24 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id d20-20020a1709063ed400b0094e93ec20adsm6179014ejj.106.2023.04.24.19.42.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 19:42:23 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso7794510a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:42:23 -0700 (PDT)
X-Received: by 2002:a05:6402:7c2:b0:508:4954:e30c with SMTP id
 u2-20020a05640207c200b005084954e30cmr14782354edy.11.1682390543388; Mon, 24
 Apr 2023 19:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230424042638.GJ3390869@ZenIV> <CAHk-=wibAWqh3JqWaWfi=JWNAz3v_qb7LZ+76qF+PKEJciHbGA@mail.gmail.com>
 <20230425023511.GO3390869@ZenIV>
In-Reply-To: <20230425023511.GO3390869@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 19:42:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTKF81MosfR2Y4fiR=WvKTRw-AODYzstkXD=TiizETdQ@mail.gmail.com>
Message-ID: <CAHk-=whTKF81MosfR2Y4fiR=WvKTRw-AODYzstkXD=TiizETdQ@mail.gmail.com>
Subject: Re: [git pull] the rest of write_one_page() series
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Mon, Apr 24, 2023 at 7:35=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Point...  With this one it would be along the lines of "the parts of
> Christoph's write_one_page() elimination series that missed the previous
> merge window".

That would have been nice, but I've pulled then now (ok, nios one
still pending), and it all was small enough that I decided that the
"one-liner description" was barely ok.

Your suggested ones do sound much better, and I'm hoping to see
descriptions more like that in the future, ok?

             Linus
