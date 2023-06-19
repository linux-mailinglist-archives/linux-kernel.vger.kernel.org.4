Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C37735651
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjFSL5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjFSL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:57:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FECB3;
        Mon, 19 Jun 2023 04:57:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-987341238aeso386127866b.3;
        Mon, 19 Jun 2023 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687175823; x=1689767823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Up4jJYc04onqJVjn/jduw0AxLdn5KV2b68agsfpNuv0=;
        b=WZhfMEOl6W4eSeONkArOXbFdMsxwAX0hnyfh6JfAdn0t9zqPB2eycMsQhkfbJ5ZlIC
         ouot1OhvI1zBxDFbitYy7/+PKqJ/gj4X3oltatjV712V6Oeghb5DfPlUnMK+ZZDypqAq
         sYU6cZvCfd9ULAiY23tmTWsxKUxwmDwpkqB8HK7/4iA86XkWFSxoiynpt89JVcc6fjBe
         XfLv8N1QJk8NLjDaVK3zidz4oMmxFZWziX+t4L6b+oEW2LqZ35xppflwZsndWd5B43IR
         13dA3pBRd0s+GAunRsJ+EgZ8s84ooKBteBvGDlMAPKA5aFxRKYF+zmyY+Wy/18q75PWa
         Xb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175823; x=1689767823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Up4jJYc04onqJVjn/jduw0AxLdn5KV2b68agsfpNuv0=;
        b=Wd5CkWVfzENn9siLzfvqX4QpqgiF20HBvqvxDS1N13P/hv/yQDWdRsvp19Jv8DhMTX
         A+KAb2adB7kMlp4dSTcSfqrAQtUV66nRiNzGQ5PXHYcZSZdlsMhVaJSLuxdHAcvHqAia
         dO/tFp5o7D62N9TDDIISCQx0v3nis9BfbZmAO0tgvTUzsdKwY+5Pn+OfIahBuzJ9FttO
         /NBJYo7ZtDtot6JnVcSJjIJqGSMSTo9i99bx3s+ovTi8VgW/0J83WA3P0lN2lj/2n/Vk
         2rgT52s94B3/frYqBZ0Scwzz3uk2AnKoPmVzNs2JdvYjSmyB+VEMk897UUZvJYQn+uKG
         YQtQ==
X-Gm-Message-State: AC+VfDzVX+J7ppS+w0fAoDnfUdSL9sr9/UYtpsUHA3+wflsQqIg3SV1g
        rOJRdL5GSaP+Mp0swGty9Gg=
X-Google-Smtp-Source: ACHHUZ4iA5WgHAy5UdQgL9UY0qqnt+Y4TMeEJj7iHabnmfR/qt7lxQ1zk0720GXrfvApDycLxYpvkg==
X-Received: by 2002:a17:906:ef0e:b0:978:adad:fe18 with SMTP id f14-20020a170906ef0e00b00978adadfe18mr7848960ejs.21.1687175822554;
        Mon, 19 Jun 2023 04:57:02 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id r20-20020a1709064d1400b00988a6421831sm1444511eju.93.2023.06.19.04.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:57:02 -0700 (PDT)
Date:   Mon, 19 Jun 2023 14:56:59 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     arinc9.unal@gmail.com
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v6 4/6] net: dsa: mt7530: fix handling of LLDP frames
Message-ID: <20230619115659.7dpve4uoodqts4ok@skbuf>
References: <20230617062649.28444-1-arinc.unal@arinc9.com>
 <20230617062649.28444-1-arinc.unal@arinc9.com>
 <20230617062649.28444-5-arinc.unal@arinc9.com>
 <20230617062649.28444-5-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230617062649.28444-5-arinc.unal@arinc9.com>
 <20230617062649.28444-5-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 09:26:47AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> LLDP frames are link-local frames, therefore they must be trapped to the
> CPU port. Currently, the MT753X switches treat LLDP frames as regular
> multicast frames, therefore flooding them to user ports. To fix this, set
> LLDP frames to be trapped to the CPU port(s).
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
