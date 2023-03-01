Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B5F6A73DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCASv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCASvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:51:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01494DE39
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:50:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s26so57758172edw.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677696653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iUZAnJK6gz4oERofIoMWErNXIlGl6/+yG6iePuXC0I=;
        b=OEzv3ztlUkaTFHVQhmuj1cOuU7W508fgRqtyIaeMiq6tyMjmoSbM8qYK+ptLJ2shCv
         hG78D5aijZL8I3UjKY7oy0rMyV1qitjUHubHIKTaUvrcevzM7AkNXIn7fOPtIGoRaBK2
         3H2JyQ1M9DI/AK08U7Q63YyO5mBx2kDhCccp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677696653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iUZAnJK6gz4oERofIoMWErNXIlGl6/+yG6iePuXC0I=;
        b=y2wfsapWyCBuYO1YqN4UXZkm7uNnA1/QDTlJioMy6d+W5AEISMszCsWJ1SVbD4Y9wP
         WExCFC8+d5AAWkVS43cLdonx7B7DMDzvRia3OJgFgkPxddb07F60QXtx2UpMgGPWXi8k
         VXm0yYSt6f+LPLASOEaC2cHB+OcwQ3WNFwMh8tccZn31pL0KrZINChz3L9HAyLl1UCsE
         t8PsRjbUBsTwLdpU6ADsQyMnuPrLEWDqSAD5jHjhL6T7M5ZP+qL7tF/jCynadpydgrgj
         k1xcyGh0kV1/ARoRFRxGRfBaYWso3y0jFBQvnpKC5Wt5MmP3q0ZrILT6RrNngto7zx7E
         IqSQ==
X-Gm-Message-State: AO0yUKUJmanZzWoa+S9mt4wLQiNU/Dec3DVkBS84oYzdJZFyjtsnYsDH
        BUdhB6oPl7Wk3FAPZNYpxuqrWDs5KZe/aMdtVtHmWw==
X-Google-Smtp-Source: AK7set8fMJF9D2ApuA/L7HaJSf1ACkj77LfC7YuAcv3qy435V2sZ47k1riCpLpOgvvj8YvO/xvoHRQ==
X-Received: by 2002:a17:907:3e24:b0:8aa:1f89:122e with SMTP id hp36-20020a1709073e2400b008aa1f89122emr10687647ejc.39.1677696653057;
        Wed, 01 Mar 2023 10:50:53 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id le13-20020a170907170d00b008c44438734csm6140862ejc.113.2023.03.01.10.50.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 10:50:52 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id o12so57839885edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:50:52 -0800 (PST)
X-Received: by 2002:a17:906:c08c:b0:8f1:4cc5:f14c with SMTP id
 f12-20020a170906c08c00b008f14cc5f14cmr3831646ejz.0.1677696652007; Wed, 01 Mar
 2023 10:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20230214132052.1556699-1-arnd@kernel.org> <Y/+WghSbz3l6uipn@dev-arch.thelio-3990X>
In-Reply-To: <Y/+WghSbz3l6uipn@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2023 10:50:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+O8OqVD36P+1cbe-B3wbB9BwfwtM1E6evObs9VpYz3A@mail.gmail.com>
Message-ID: <CAHk-=wj+O8OqVD36P+1cbe-B3wbB9BwfwtM1E6evObs9VpYz3A@mail.gmail.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: remove bogus do_div()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Mar 1, 2023 at 10:16=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Would you be able to take this patch directly? It seems obviously
> correctTM, has an ack from Sebastian [1], and without it, 32-bit
> allmodconfig builds are broken [2] (the other warning in that log has a
> fix on the way to you soon).

Ok, I've taken it directly.

However, the whole "seems obviously correct" is true in the sense that
it now doesn't complain (and doesn't overwrite an "int" with a 64-bit
value.

The actual code still looks odd. Is that return value for
BATT_CAPACITY truly in that odd "hundredths of percent" format, where
dividing it by 100 gives you whole percent?

Because "hundredths of percent" strikes me as a very odd interface.
Even for some firmware interface. I realize that anything is possible
with strange firmware, but still...

             Linus
