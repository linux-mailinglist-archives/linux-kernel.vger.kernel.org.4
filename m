Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439EF73B84D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjFWM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWM5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:57:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D61BC6;
        Fri, 23 Jun 2023 05:57:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-311367a3e12so708473f8f.2;
        Fri, 23 Jun 2023 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687525060; x=1690117060;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBGlu4mVjSZIVkmyT63GiSTJi1xsdDVdh6nA4KVczZk=;
        b=Da3PZ42WRVj068XKjsp7ChqeSKc42ke+gcHYN+e/OmoJZICNLD82oBSwzKYYWkgcG6
         79G3SFLUoDLsqHvF1YhE/GkvfU8XkJGEz5+lazPJUBMxqS6yBplsrwa9S2ZqnuAWR+Lr
         jwdAqvZj4S8p+Wx+xxPZzX65nhVmfOh2PyzGNLt2kLidzCvchgVbstihvLmZLA9Heksm
         gj7DVGJttCNANj4xtkAMx0Nqy/tIq2hqJZg6f5V84d5ikeo7lEOuXUYECVNccJ7QosY0
         zFOmwBiz7DCu/lEh4eLLEZq56HdB3bFCO3+RLPHJjdP6m8XMvQwgd2ydmoMA2z9Y+y3e
         gruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687525060; x=1690117060;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBGlu4mVjSZIVkmyT63GiSTJi1xsdDVdh6nA4KVczZk=;
        b=QYV/YCuphtcgKaT0OTdh/ogMNxHkyY6xLCEFARgZlxPg3gSwNpj5W5rVgEmtZQc76A
         hq5owNQg/DW6oCv9cVgbV5aE2ekuYt9Fieeipmqy0hhmXAZBpxezKjDAyM5NJokPS8LU
         vtt3+XPxpTUYyLYuqqoWqZCUHl9M486ltTWW63VckQ7FCKwXIoT2wTfeDLvaLFC67XyF
         dPGNczDkjujA1SNjmHyWeTuXNC0EO/UkD5e+N/NYbZTLIYnCrZ5egABEec/6eN0IiV3v
         NTgJM+pLixYWr33Ssyxm4Ch6RYGMhvGtFkSLov/UfQ5qku8nTY0NtfLV2B7Zdojz0xgN
         1SWg==
X-Gm-Message-State: AC+VfDwqKE59tlUeS4nbelnlOFU0Kms3w4a0iv55CK+iSqpaPxLJdF+q
        TNYA5oZcGNERo+4ERC4rgcOa7fpFnAU=
X-Google-Smtp-Source: ACHHUZ7Hvj6grFzKGnMkHJahttoaVl+DK1eSiQN1i3nG8Pn0uM6L6bQypkWXGd3UwyOchyCI+r3ZlQ==
X-Received: by 2002:adf:cc90:0:b0:311:ffc:f54d with SMTP id p16-20020adfcc90000000b003110ffcf54dmr18450756wrj.66.1687525060520;
        Fri, 23 Jun 2023 05:57:40 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b0030f9c3219aasm9450567wrp.47.2023.06.23.05.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 05:57:40 -0700 (PDT)
Subject: Re: [PATCH 3/3] sfc: selftest: fix struct packing
To:     David Laight <David.Laight@ACULAB.COM>,
        Arnd Bergmann <arnd@kernel.org>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-net-drivers@amd.com" <linux-net-drivers@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230619091215.2731541-1-arnd@kernel.org>
 <20230619091215.2731541-3-arnd@kernel.org>
 <7c448f02-4031-0a90-97e2-0cc663b0cff9@gmail.com>
 <ee0cf01638074abfbddda7edd3074d2c@AcuMS.aculab.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <0f12f612-7fad-59c6-c7dd-dea49721842b@gmail.com>
Date:   Fri, 23 Jun 2023 13:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ee0cf01638074abfbddda7edd3074d2c@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 11:52, David Laight wrote:
> Maybe you can get away with adding a 16bit pad before the ethernet
> header so that the IP header is actually aligned.

That's what I ended up doing, because my original idea was
 overcomplicated and turned out super ugly.
See https://lore.kernel.org/netdev/6f87fdf5-1844-4633-b4fe-6b247bc6ab49@app.fastmail.com/T/

> (Then fight all the stuff that stops you doing a memcpy()
> that runs into a second field of a structure.)

Yeah, I don't know how you're meant to annotate that stuff.
I guess I'll have to wait until Kees shouts at me and tells
 me what to do :S

-ed
