Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0542173B223
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjFWHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjFWHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:54:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99990AC;
        Fri, 23 Jun 2023 00:54:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9741caaf9d4so23883966b.0;
        Fri, 23 Jun 2023 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687506885; x=1690098885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4/3vh8wlFrqZZ6Gpx9hGTulu5hIdl5c6zJ1UoXsOoc=;
        b=np5JJnmZBZ80YaKiV6lEVkZQHRUTNi3zuZgCW3aYXoqpi+gJjgiw6vPWv+QkyL4Ln7
         S4kohoXICMcxW+/aV1nnnbQueoU0kceTDiucoK/OnI87O4bZjFVDY7+K652ZaSB4ZDXF
         0tqhprS02sWEuhRrjWTCItyyW8fIORRx0Jq/+qt8jutRkFTZQ5Z3mIMcRULALP+gTgIB
         hhK2ij8bjyri5OFt3fDDZmSomWpgIpavzKjCyHJ398hQHGv0hI8jB7qs5HTgTGgKWhJA
         FiHUOeE9ICEQk6QL4X1MWQX/fvFchndcRVLtvTUI4BPMh1sKvRWowUfABWtnpwjl05bC
         5g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687506885; x=1690098885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4/3vh8wlFrqZZ6Gpx9hGTulu5hIdl5c6zJ1UoXsOoc=;
        b=YexU5rXpSgWHOvAgdz/6raMuXg9aFftRI70wrubquxwqPeih9Ajo5p1XkDAFzp1/CN
         Kn7TuDEsCj946Hi3MKe4fkqo7yDzsT28mNyyiRzn6ZL/IEiE6sJm/iDXfaitex9BTwO9
         0jLK2Tve1jT5UBPkH9Dbio0nVhDzWt9F5dweoMqxKA8JM90PRNlulBL/dP6LxO8Tshov
         IQ3kFC8585TwGlsM8hHZ5W9mjoIBjLaEeoBR97HdKlESN68RFoNBGZd6SkPSYQh2btCL
         AduvoPQzI7LPO0yk+B1bbf/00gPuI7/AK6U0yVVFTp3Zxw84h6WqwBm7Jiof+nsOVj3P
         66OQ==
X-Gm-Message-State: AC+VfDxCP1JY5VujNFTrwbzPmQAC/6Gmu+ZbLGXmUZnS1xOH1G/sGR1L
        TEwXnE8Ffk52pp8G8p5gB3g=
X-Google-Smtp-Source: ACHHUZ5lHZJ8TfyCSOsnWtoMkzRdAG2p1ngYQKBV0Jhf9TjloyTYG2zCx6BDVohXCDi1QntkKFdXtw==
X-Received: by 2002:a17:907:989:b0:98d:9655:3fac with SMTP id bf9-20020a170907098900b0098d96553facmr610786ejc.71.1687506884914;
        Fri, 23 Jun 2023 00:54:44 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709060a1100b0096f6a131b9fsm5653095ejf.23.2023.06.23.00.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 00:54:44 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org
Cc:     alexander.stein@ew.tq-group.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mka@chromium.org, robh+dt@kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v7 0/3] usb: misc: onboard_usb_hub: add support for Cypress HX3 USB 3.0 family
Date:   Fri, 23 Jun 2023 09:54:37 +0200
Message-Id: <20230623075437.2698899-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023062339-cold-turret-dacf@gregkh>
References: <2023062339-cold-turret-dacf@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg and Krysztof,

On Fri, 23 Jun 2023 at 09:41, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> Please give some time before resending bigger (non-trivial) patches. One
> per day is usually enough. I still see some kbuild robot reports - from
> this or previous patchset, so are you sure you compile tested it on few
> different platforms?

On Fri, 23 Jun 2023 at 09:46, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> Wow, that's a lot of respins so quickly, please relax and take your time
> and wait a few days before resending patch series as it causes
> cross-reviews of old versions, which has happened many times here
> already.
>
> I'll wait for 6.5-rc1 to come out before looking at this again to give
> everything some time to settle down.

Sorry for the spam, was a little stressed and wanted to get it done
before driving to Prague. Obviously was a stupid idea I will remember
for the future.

Best regards and please excuse the inconveniences. Won't happen again.
Benjamin
