Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB8740017
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjF0Pvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0Pvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:51:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F71AA;
        Tue, 27 Jun 2023 08:51:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98377c5d53eso570388966b.0;
        Tue, 27 Jun 2023 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687881111; x=1690473111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEINvILC+4P/bCKZ6JhrNskO2VgD6BklCUUwDEwGbD4=;
        b=EM41lxrCMDd6CEtpqKQp53KiHwR7ITG4AVh1PUjRwhL/TNKBVawsPvQWEpfnRflXik
         VULuxeJrI6jJOjZkJjWGH7bFFwTzG0coU3mpwGQRSWuaSwqnLNMzd/Eu+gkbXoBB014Q
         NS9IEOZOkfE3R67RiahpGaloNV7KmYgYRlHn8iNQpCU8jjbJfPDvBtDnPE9UE6QHuxVZ
         0gG1nWcThqm9EaLprOGJ/Yygei97aHjI3mV098knIAyXGJdyOwAb8LnvI0Q/VhtYwTAI
         700TAjs1TyHMXQ86H027nYzjwXAn4MGD0DRTTJy7BcjwLmjXW+nhnmFa7/2egKtiHjG7
         V5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687881111; x=1690473111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEINvILC+4P/bCKZ6JhrNskO2VgD6BklCUUwDEwGbD4=;
        b=LZA9UQgL5HiMze24KYwEzQvlOLDO1+7JbB06PkUOHoEsstifXPzZ77KoPPTGTs+Om7
         lSlKzGk7LzQCIOCggUYK0UkX6kcY0ZJN0r9W8WphC1zbYEwVK5STibO4CDSaB3sU1csZ
         qZFNVlUW2UFGm02mfmthUXr4KLXl3cHEenAvpkYSqVQgI112jwS06P+4Oq7l59jF5izT
         hnVQnULjm0J6TAsMdXHIR183qOD0w71HMiNMkEhqMqQ0gr96tECN0z5zl1jBV89FOVAA
         DhX3mZp54vHSzFGffJtk5mUAZ0gXH8PKB9VdciTT+iJME/Jtq9xxY6APiKBBYUNTClzB
         1RLA==
X-Gm-Message-State: AC+VfDzOmeL1i5tnsHvOkEPN6HKwffQn6bLk96bmAuWmy7UxlIDddG2y
        6ksNJrychQCk4RYjIHxzgAg=
X-Google-Smtp-Source: ACHHUZ56rBsWqc5TSXZQVBqt2bq5UikjjHQtF1ZR+a6bvKrfnMSQQwMxaPf74x1PuPgh3L1yUiUoew==
X-Received: by 2002:a17:907:7603:b0:991:c566:979 with SMTP id jx3-20020a170907760300b00991c5660979mr3978930ejc.36.1687881110532;
        Tue, 27 Jun 2023 08:51:50 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b009920f18a5f0sm1005687ejb.185.2023.06.27.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:51:50 -0700 (PDT)
Date:   Tue, 27 Jun 2023 18:51:47 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: dsa: felix: don't drop PTP frames with
 tag_8021q when RX timestamping is disabled
Message-ID: <20230627155147.atvr32v3vldnybrc@skbuf>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
 <20230626154003.3153076-4-vladimir.oltean@nxp.com>
 <20230627151222.bn3vboqjutkqzxjs@skbuf>
 <20230627084651.055a228c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627084651.055a228c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 08:46:51AM -0700, Jakub Kicinski wrote:
> On Tue, 27 Jun 2023 18:12:22 +0300 Vladimir Oltean wrote:
> > This is still not as good as I had wanted it, because simply checking
> > for HWTSTAMP_FILTER_NONE does not distinguish between L2 and L4
> > timestamping filters, and a port configured just with L2 traps will
> > still drop L4 PTP packets.
> 
> Out of curiosity - quick survey on why your reply does not contain:
> 
> pw-bot: changes-requested
> 
>  a) your email address is different and the bot doesn't understand
>     aliases
>  b) commands are hard to remember
>  c) don't care about patchwork
>  d) laziness
>  e) other

hmm, I'll tick e) unslept...
