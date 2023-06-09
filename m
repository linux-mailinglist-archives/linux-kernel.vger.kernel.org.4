Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82A172A2D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjFITGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFITGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:06:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60C3592
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:06:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so3651680a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686337591; x=1688929591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+ONXQdK4a1fSmqiExKhyWkPlcAP+HPrxGCh1eVdlew=;
        b=cVW5FwqKdsiNy0NAGkMdO7aRrUU+kamUFGT0NxsE7zEB9un9xkK8rTE9IQ0zvAil90
         j39g/w3gG+hesvKwGpCwJHYZIgzoQeK/dxjca5UR7k4Qagr0gJL37i7lWFKVHX7s0qZt
         +iU1hifj8CdPgFlPauUDbnJMP5HGMSPDEf2ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337591; x=1688929591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+ONXQdK4a1fSmqiExKhyWkPlcAP+HPrxGCh1eVdlew=;
        b=UbJJg4ifmXhBPV6kImsbOa7uV4JPNwJg+CRPLCT77PP43ZaE7vqGMFRCJYhpWUqWVJ
         ORATMkoA05EXon/mB09NrfZyowQeO/2JG9Oc147od4BqPG0BMl5GcaElyCF11BKu/c+u
         zrfqo80GZ0/trrcLWyi0nx9rsQLkBpcAF2GW5Dnv+pXbwXsTlWMSi050GhuqMdvTemi7
         etFVauVk35yZCDtXnr3CkqRfx+KLBiixQvTKt9xlTxcv66aIea+eoZtjXDsuU4Fr6Y60
         xkpLA9d6I8a/dJ/JjwZDgireH0UrL6q0g7vwa0rPFFdGmU5PZhoCDYwDD6Se2GqcNKS1
         cYwQ==
X-Gm-Message-State: AC+VfDz4qiWlq+LK+aRsaO9AQMOWtLW6ssDeq2gSYuthkDliUF39inFr
        eJUqQC85ZedQruVOkeZWPTf9jDxygNAzQzrHXWbB/RYy
X-Google-Smtp-Source: ACHHUZ48pQt7omxk90Rrr4w6mEx77fjUGN0JqERVc7JH7Qn2dL4w55BuRpHsTfv/v1c+Ylxk7GmmfQ==
X-Received: by 2002:a17:907:2d91:b0:97a:bd0f:ac74 with SMTP id gt17-20020a1709072d9100b0097abd0fac74mr1754818ejc.26.1686337591216;
        Fri, 09 Jun 2023 12:06:31 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id cb14-20020a170906a44e00b00977da0f14ffsm1645805ejb.171.2023.06.09.12.06.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 12:06:30 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5169f614977so3643306a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 12:06:29 -0700 (PDT)
X-Received: by 2002:a17:907:26c1:b0:978:930e:2279 with SMTP id
 bp1-20020a17090726c100b00978930e2279mr2489992ejc.52.1686337589586; Fri, 09
 Jun 2023 12:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230607200903.652580797@linuxfoundation.org> <b979807a-a437-4d3f-98f9-989da52abb30@roeck-us.net>
 <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
In-Reply-To: <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Jun 2023 12:06:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whA=HsyDFtgQnWMZP-08ddhMh1a88OZHCXf8N-iP6hFQw@mail.gmail.com>
Message-ID: <CAHk-=whA=HsyDFtgQnWMZP-08ddhMh1a88OZHCXf8N-iP6hFQw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Ido Schimmel <idosch@nvidia.com>
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

On Fri, Jun 9, 2023 at 11:42=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> I managed to revise my bisect script sufficiently enough to get reliable
> results. It looks like the culprit is commit 503e554782c9 (" debugobject:
> Ensure pool refill (again)"); see bisect log below. Bisect on four
> different systems all have the same result. After reverting this patch,
> I do not see the problem anymore (again, confirmed on four different
> systems).

Does this happen on mainline too? It's commit 0af462f19e63 in the upstream =
tree.

It was in 6.4-rc1, and I see a clean result from you at least for
-rc2, so for some reason it sounds like upstream is ok. But I don't
really see why that would be the case...

                  Linus
