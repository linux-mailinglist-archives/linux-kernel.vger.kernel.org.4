Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA931741653
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjF1Q2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjF1Q2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D99C268A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7488A612D6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90035C433CB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:28:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EKMkXh64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687969686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gEIyRjqszOB2imPwNzpq7+IvC5xqgR+o25zuK2lz2QM=;
        b=EKMkXh64Wwhpun2CMyz3kT2+ClwNaFHuK7Z0+P0u4poAAInjJC2l95CxdElEhI3asSD7rs
        KKmNFfA4b71qpWHSsoAnf1AUT2MuGctWINxRN60YyhIbEjkqnV4ycWJ13x4g4z9dcbyV2m
        40g4Hu91EujW9Q6lZTr15wYy3an0GXk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id caf59af3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 28 Jun 2023 16:28:05 +0000 (UTC)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-79470b88d88so203867241.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:28:05 -0700 (PDT)
X-Gm-Message-State: AC+VfDzLOViF5XnK7XjDmMDHGr/L6YsOUmNd/oCMYBeVXfAjxBAnBANR
        AAeExxtVogwQJG8JryNmAPqXVmJxGbw/jaO1y5o=
X-Google-Smtp-Source: ACHHUZ6t5ME1ufjpIYTlmd6bXx2uCUjTXR3iLr42qMDpKFt65WIy9LHHr0aCtgOUQisBM6crXUOws1Fh+EhMPUaWZQw=
X-Received: by 2002:a05:6102:3645:b0:443:538b:cd27 with SMTP id
 s5-20020a056102364500b00443538bcd27mr5780662vsu.9.1687969684229; Wed, 28 Jun
 2023 09:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230531095119.11202-1-bchalios@amazon.es> <20f65557-766d-d954-f3ef-c26ad2b661dc@amazon.es>
 <6ccec434-42f0-0ae8-8c7b-bea4646c5e7d@amazon.de>
In-Reply-To: <6ccec434-42f0-0ae8-8c7b-bea4646c5e7d@amazon.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 28 Jun 2023 18:27:52 +0200
X-Gmail-Original-Message-ID: <CAHmME9pxc-nO_xa=4+1CnvbnuefbRTJHxM7n817c_TPeoxzu_g@mail.gmail.com>
Message-ID: <CAHmME9pxc-nO_xa=4+1CnvbnuefbRTJHxM7n817c_TPeoxzu_g@mail.gmail.com>
Subject: Re: [PATCH 0/1] User space notifications about VM cloning
To:     Alexander Graf <graf@amazon.de>
Cc:     Babis Chalios <bchalios@amazon.es>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        mzxreary@0pointer.de, xmarcalx@amazon.co.uk,
        Amit Shah <amit@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just so you guys know, roughly the order of operations here are going to be:

- vdso vgetrandom v+1
- virtio fork driver
- exposing fork events to userspace

I'll keep you posted on those.

Jason
