Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327EA6FE904
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjEKBAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEKBAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:00:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58734268B
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:00:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so12446686a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683766808; x=1686358808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6zIQsKveMNeppazo1Csl+4BW77pPo6cjqKAypY2RM0=;
        b=gSNSa/RZnmetSECvt1nyS7woe6+Zasq249HZAqlBDVSSKLhpWy/wo7rTZ9VNFSAVQb
         8TEemjFIe6okqPpPmP1xxb7AFHM+uizJe+2F/djXSU6QihWNhpLOE99EwUG4J3yl4IZe
         rypefpqKYYRmgEjQZ/rRisp9Zxq1EgtTO7QpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683766808; x=1686358808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6zIQsKveMNeppazo1Csl+4BW77pPo6cjqKAypY2RM0=;
        b=hNvE78pV3oK/nalrMP3yxoOZWgouJUXZ7128P88ry9ivYwfTy052EDYLMcdNGiPcdb
         qKhvIrFJvhek5ym6ae86wafAMvd7RYr3GOatzBWlHgolzJAn9lEWb0Hce1X9Xz5StPDJ
         zy4ykD8VDYDqDFD9lpLs7HignLHIP0sfbkHVS8xPV+lYgEdnSPig27R2n/cBNJJzQVSa
         fp1bqH/cG4SvM0IJ9Hjgfr6ToKAPU/iHsABBI2UpXgo8hI7Fwuhbd//kuDMQswYuR92Q
         QWJ6ux5HgEgCPz8wUcBX8HP4OJaO5XuZZS67XfWL7DgFKXI/uaYz/2WSRUPJKdSxFNTe
         057A==
X-Gm-Message-State: AC+VfDwPsCnrEHedgwM52m5TnzI7UAwm2fmBqBgeM0nGO7tuRmg9I4ao
        /wrkcRX+q5qtEa9lfNc5fyBjVuKOgIhz+y0Ibzvidg==
X-Google-Smtp-Source: ACHHUZ5O5K9hNpe4ASBir3GOZvPYlpP+wnc0hoLfV2ZUm41ZjaJ8kb2ZflMIv9FlOSCeJt1CSVi3Zw==
X-Received: by 2002:a17:906:4790:b0:969:acdc:c4df with SMTP id cw16-20020a170906479000b00969acdcc4dfmr10292540ejc.4.1683766808642;
        Wed, 10 May 2023 18:00:08 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id lv4-20020a170906bc8400b00966293c06e9sm3244888ejb.126.2023.05.10.18.00.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 18:00:08 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94f4b911570so1246804266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:00:07 -0700 (PDT)
X-Received: by 2002:a17:906:7304:b0:94c:ea3b:27a with SMTP id
 di4-20020a170906730400b0094cea3b027amr19259735ejc.16.1683766807624; Wed, 10
 May 2023 18:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <fb4fa92a-eabe-10b8-fffd-7ffc8a70404b@infradead.org>
In-Reply-To: <fb4fa92a-eabe-10b8-fffd-7ffc8a70404b@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 May 2023 19:59:50 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjqkNzpYRzgPAj5hwkYJtwg6UEb+hLUQtUm2OYH93WpfQ@mail.gmail.com>
Message-ID: <CAHk-=wjqkNzpYRzgPAj5hwkYJtwg6UEb+hLUQtUm2OYH93WpfQ@mail.gmail.com>
Subject: Re: [pseudo-PATCH] sort MAINTAINERS file
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
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

On Wed, May 10, 2023 at 7:01=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Please run scripts/parse-maintainers.pl to sort the MAINTAINERS file.
>
> It has gained more than 100 out-of-order entries since it was last sorted=
.

Ugh. That file causes the most conflicts, and sorting it makes it horrendou=
s.

But I guess if it should be done, this is about the best time to do it.

                 Linus
