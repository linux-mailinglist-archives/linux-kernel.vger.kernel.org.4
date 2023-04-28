Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D726F10A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 05:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344783AbjD1DDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 23:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjD1DDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:03:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1586530D2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:03:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-95678d891d6so1710301866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682651018; x=1685243018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSYUAhHGsv4p/YHSuQ4XkvXSQPBakl8RRPKNeekkNlA=;
        b=AvfuI8lNhw9F16NA3wNBqkfuac9y7byg8mQPlI7SFv3u8PcH3WlgBIbpTxTpgKEdN4
         8kv1NGZ4k7h/wv/NOF2wxgaNEiCBaSvogt6b/7bFEdb2M9J9nNbMoHNxTNPXZ/F5FXLH
         XGBp2ShaalNUaGvVdHXA27gAX1AbWo1fWNjPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682651018; x=1685243018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSYUAhHGsv4p/YHSuQ4XkvXSQPBakl8RRPKNeekkNlA=;
        b=C4mC+qHUbTvdhKx39iwfwD+RVIQsblPVjUDJyKVAMXgd9zsR89iNCuyba+FYv+ETrp
         6Ysh0gmn+xp7axSKhicJuVzl23ipjxtTAG8utjNfPM5P30cyqaygaP6rFJfzFO8SNTEV
         prKi4DU3evk1W3MnmWJh6M7D04jEK6Xjkdg/8lqm08MgKmYk7ZL0uMubhT6ovpK+Vpqk
         4oXaRcROizDXO4Mhb44iFABzmKlyfsXgTlt57PjUlzZvuqXHwV3AGFXE/3wmTyQzb/vY
         fSrDHkpdItVYddDk3BREgpJ8G3PAzs2tnryiptaM+Yep0KDxmsCP2zDl096W7FWtFsxO
         uMlw==
X-Gm-Message-State: AC+VfDyGsd3Qh0YymkiduYdKsq0+ozczvRDM8XHdquDuQ5Zm0tHu0zKW
        5tbVS9hXtreFkOLuvYeNXLkwn/He0fa8JYLKGTvOZw==
X-Google-Smtp-Source: ACHHUZ7d2CqcClvVJGPdDcWea/DdQoQCYutckhIIvcG1S6T/CXlw16IEK9N2JTH6aA4foG9bTnsGYQ==
X-Received: by 2002:a17:907:6d05:b0:94e:f1b9:e933 with SMTP id sa5-20020a1709076d0500b0094ef1b9e933mr3700748ejc.53.1682651018339;
        Thu, 27 Apr 2023 20:03:38 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906779500b0094eef800850sm10535943ejm.204.2023.04.27.20.03.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 20:03:36 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-505934ccc35so16122891a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 20:03:36 -0700 (PDT)
X-Received: by 2002:aa7:ca51:0:b0:509:f221:cedc with SMTP id
 j17-20020aa7ca51000000b00509f221cedcmr3189721edt.35.1682651016171; Thu, 27
 Apr 2023 20:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
In-Reply-To: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 20:03:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5=LfeCMv5ZPAtzWhJyW=y1rVJFTRBfgcqzoUNk5NRDA@mail.gmail.com>
Message-ID: <CAHk-=wi5=LfeCMv5ZPAtzWhJyW=y1rVJFTRBfgcqzoUNk5NRDA@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Thu, Apr 27, 2023 at 3:33=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> - Suren Baghdasaryan has improved mmap_lock scalability by switching to
>   per-VMA locking.

.. related to this, we have that new PER_VMA_LOCK_STATS config entry,
which is 'default y' and has basically no help test.

Please don't do that.

I don't think any of the VM debugging stuff should likely be 'default
y' in the first place, but if they are, they should most definitely
have a good *explanation* for why they should be on for a normal user.

                      Linus
