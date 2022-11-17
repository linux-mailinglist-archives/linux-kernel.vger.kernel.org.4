Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B03562E503
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiKQTLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbiKQTLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:11:14 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282258756A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:11:10 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so1661805otl.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FWnLlursaYJKfOWPydpMGhECaxSct87sWPPYmZvjBnw=;
        b=Cz7wQpimV+YosOt9d//L2iWXvsIwwTN7+tjHjRw1UuXZTFbUfBv45GZ47lSCAi6EcG
         VLCxZlhWhKMLKfFv0VpaJ6NGzl9T2WpPOA2M7MVPeRDJmz+0+7kWkh8Dq5RGn36c5YZN
         RCkckS0hqvu2id02Rcg6k7XcFXzcNLD8MIzBGgWMWN0N0VHHd1fSFMQklCX+brbbuBgE
         ih/7mR/sPjlt/bW7MM8g1MVwu+GTjymRKZX2kFP8DUezPbyyoBQYIDFml/uoor40SgeV
         nSUMnBnJUmDecXZkRmTJfH0roB/Hyh4UDmNyK8ednN4Veb0goHe6OwvCB2TlDb1m3iQE
         C3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWnLlursaYJKfOWPydpMGhECaxSct87sWPPYmZvjBnw=;
        b=DzpA5hNa/Xg+1K/5ZDU8H9TRw8lrdcPGte+xdHJrjMbQnb6VYppdP+iZFag1/LLeOt
         ng7B4bT14XVoT6KC4au2ci1gLJ5szFj4xfw7qJWQoS3U3CAmsJkwaNh3gkP/UlPJcmHa
         hmatGZvPLBFAtMF6fkgKiOZ7w3iODY8tF/X/EukKC4+HFC40tJU7jlBjggpBB62EmOtr
         qF1d9qBayMwMA6+CwQsXUpRxavpZ7nymf2z/DzdjZPen4MyBT22+Kt7z9vPrD7NKzK0A
         4eJpN1p6UozGhrDbJmqpD1tz4B/TzNusKrTP/YWTrKtfag2rU+hVhHbeRcI1smEliKKR
         sfbQ==
X-Gm-Message-State: ANoB5pnEGolFJA3VJrskGBTY9/5S4K0itYwdr55KX3D7t2gCQXAmlg+I
        xk+GyQjCnHwXpQph85pNFmqCiaFwP6WVhC4x6UhF8jHZcFc=
X-Google-Smtp-Source: AA0mqf72zx045VT5xpVnSFZ6Iun9LWo8yDAnd0PQxV+G2W6PiH+rxSFgg06B0VtTYQpHPSkqtismdJCDIQ6RZ3AVZE4=
X-Received: by 2002:a05:6830:1510:b0:655:bd84:a806 with SMTP id
 k16-20020a056830151000b00655bd84a806mr2136812otp.108.1668712269869; Thu, 17
 Nov 2022 11:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20221117181127.1859634-1-dionnaglaze@google.com> <20221117181127.1859634-2-dionnaglaze@google.com>
In-Reply-To: <20221117181127.1859634-2-dionnaglaze@google.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 17 Nov 2022 11:10:59 -0800
Message-ID: <CAAH4kHZneEeJvH0ppJBEUqMQeWH_KS-h+BG+QkNqMV64F0PENA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kvm: sev: Add SEV-SNP guest request throttling
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Gonda <pgonda@google.com>,
        "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding kvm


-- 
-Dionna Glaze, PhD (she/her)
