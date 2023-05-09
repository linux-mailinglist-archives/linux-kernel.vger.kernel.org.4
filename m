Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF26FCBCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjEIQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjEIQxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:53:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C7549D9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:53:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659f452148so1077544766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683651187; x=1686243187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W37NhXu6wJIBmLbeQ87YSwN8pbxoXa2SKsX9DQFeng=;
        b=chpgdPd8dmW2Dvefw6SjayiN805bdKRypAVECSUlEcAO+4Lr/k0NSFPjrHZKhP1UjV
         cEWGXpVIgsChcv/G901EaUmMnFoaQ2VLuSl7KXbQW5flgfOkhWrQsOeXCEBHRRN+cch8
         6V0A3FZnwfa+pA8Zd4f0LqRfo5ZCtzchGl1mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651187; x=1686243187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9W37NhXu6wJIBmLbeQ87YSwN8pbxoXa2SKsX9DQFeng=;
        b=NSNmWBRgGyE2Mf6vNupkiL5f+u6QAh3j3+Qiot6OuRNLpb7/SG9A+r1C13DanGIO93
         FdXJ81qsfcN1iyeVp3IN0V8EtLfPReE5YYrgud/J3L9Xc4SMe0efMWWnRqOOXEiQ052n
         gQNTizNc+CtHYwb3CSWuFXafiQYAvVHtS6B2nSUNAavwfhFwKpppIZsFxVlsukcZZrDl
         fcAH0qvJJaB5qbgBCQs7Rzh1GX/z09WTqpdcOCAWt6YAGza8902DqxDzltTyhT6TBBwC
         SdLdjtDaZDU978up0Y3UIHu3MZPSJlI3Db3Il2R/W7W2/HcbB/8LnErbjIt+vfsFV0i9
         w26Q==
X-Gm-Message-State: AC+VfDwUTO0oQEjp1vdQvH8ftpd2ZPgBXKGbJ4fgVrC6PQZ5RlsBwrT+
        oHJtet0CrRqv19k5A4fAo198tUoJOF/9lvpwqLw32Q==
X-Google-Smtp-Source: ACHHUZ71MCV5Poi2bJ9cgPIrH7t0+2IlS555ZFlq2jR8ypTYNUe3hDmaIPx9RUOTuUSgSgtC/nwm8A==
X-Received: by 2002:a17:907:2d9f:b0:969:e55f:cca2 with SMTP id gt31-20020a1709072d9f00b00969e55fcca2mr3723120ejc.38.1683651187301;
        Tue, 09 May 2023 09:53:07 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906c21500b00965fdb90801sm1538774ejz.153.2023.05.09.09.53.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 09:53:06 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-959a3e2dd27so1076247066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 09:53:06 -0700 (PDT)
X-Received: by 2002:a17:907:1687:b0:94e:1764:b0b5 with SMTP id
 hc7-20020a170907168700b0094e1764b0b5mr15546777ejc.69.1683651185901; Tue, 09
 May 2023 09:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <9b2e791d-aeba-a2c7-1877-797ff5c680a3@kernel.dk>
 <20230508031852.GA4029098@google.com> <fb84f054-517c-77d4-eb11-d3df61f53701@kernel.dk>
 <CAGXv+5GpeJ8hWt2Sc6L+4GB-ghA4vESobEaFGpo1_ZyPhOvW0g@mail.gmail.com> <6d6a494b-3c1a-2bf6-79e3-0ccc81166a67@kernel.dk>
In-Reply-To: <6d6a494b-3c1a-2bf6-79e3-0ccc81166a67@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 May 2023 09:52:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjspoBCSrwL2s=qof3GFnZ4BmMzFbCcEx3VpVP81zXwrg@mail.gmail.com>
Message-ID: <CAHk-=wjspoBCSrwL2s=qof3GFnZ4BmMzFbCcEx3VpVP81zXwrg@mail.gmail.com>
Subject: Re: [GIT PULL] Final io_uring updates for 6.4-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        io-uring <io-uring@vger.kernel.org>, linux-kernel@vger.kernel.org
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

On Tue, May 9, 2023 at 6:59=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> Oops yes, thanks for noticing. I'll correct that and add your tested-by.

.. this build problem isn't caught by Guenter's build testing, but can
we please make sure that it's fixed in my tree by -rc2?

It would be lovely to have a release that doesn't end up having silly
build problems pending for too long. Even if they might be unusual
configs.

             Linus
