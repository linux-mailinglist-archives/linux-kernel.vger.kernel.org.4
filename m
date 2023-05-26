Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE4712765
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243641AbjEZNV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjEZNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:21:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737F9B2;
        Fri, 26 May 2023 06:21:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51475e981f0so955316a12.1;
        Fri, 26 May 2023 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685107283; x=1687699283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8w//caJhgxpsU0D7Z3jRD+/+BPazq6oBeJagzyDLCJ0=;
        b=DFghpjm9bcpkgNyiJHFT2QAahYRZ25MWjLxtIPJ89MIhIBRZY9+kVhg+TjGBoTj1qf
         rjeb0Zc0V24pJDVSEfodtSrqOd0W8O6xz6TxNW+oKZMG6DC0XLj/XsqJCM2BtSrxaK9x
         ntArZQGmwI28pxiAbyJWMJ4TRkm2i46I+jc2nZ9sGwKcal4jxLpxHiL6mAxuXKfX9nA8
         d3asrq8zmnvNmO++WByMq1+Z0n2/IkD4ZoY7zU5gLWTkjPTxv3CqSTvYE9Cm0zpTeG4d
         8I+wI2yusBV9OebtoLfPE3pDP5Yot7ubwi41PfQDUk9yxLywSiDwB1BUfnipweoDNulx
         bViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685107283; x=1687699283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8w//caJhgxpsU0D7Z3jRD+/+BPazq6oBeJagzyDLCJ0=;
        b=KpqdhstVWHkwkERfK5GarWpns+fKPm1E+8/EKwSSUkqaNdDxu1J5JcT0OB7ekJiacQ
         xzh6VI7iodnjiNavboastuzS8U7bF7VjqPN+Mww/WyzOfScS/KnOvFLhERL6loBm9JaP
         aPaaLjPaBgjVTLvsgV5ILC1kAKtsRvB5mEoSsTuc8uQHO+4ly2h4kFNl+HN+/+E8b9rt
         1fI6OMDh5loDez5yxs15GRXPVPaBQhUKsrzDBDDCQWKB1qulI42LFtdcJU9oosCVY4nL
         iGRigur+tKBoTFXTimJNbkuqe9i+jmNm+Ky2Riv7KJdjDFoRygOHyaV1L6E+PuQfrBCE
         Q9rQ==
X-Gm-Message-State: AC+VfDw8yYzxkT/F+iiAw7DiODi9R8ptjRNygLlt1F1kRVqcZmGjnHGh
        wMKv972UDyLCv47IndlimEY=
X-Google-Smtp-Source: ACHHUZ4ztO0mCvPoV4w/YciLRZtDBOM/hRuhrghOrpsOPWOBd+L4oXwtd77pHKEzaCKdiqCuhd/VhA==
X-Received: by 2002:a17:907:6e8a:b0:969:e7da:fcb1 with SMTP id sh10-20020a1709076e8a00b00969e7dafcb1mr2531562ejc.13.1685107282595;
        Fri, 26 May 2023 06:21:22 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906341300b00965f98eefc1sm2175760ejb.116.2023.05.26.06.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 06:21:22 -0700 (PDT)
Date:   Fri, 26 May 2023 16:21:19 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     arinc9.unal@gmail.com
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
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
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 18/30] net: dsa: mt7530: remove .mac_port_config
 for MT7988 and make it optional
Message-ID: <20230526132119.mwth6nu3ifgsd24w@skbuf>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-19-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522121532.86610-19-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:15:20PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> For the switch on the MT7988 SoC, the code in mac_port_config for MT7988 is
> not needed as the interface of the CPU port is already handled on
> mt7988_mac_port_get_caps().
> 
> Make .mac_port_config optional. Before calling
> priv->info->mac_port_config(), if there's no mac_port_config member in the
> priv->info table, exit mt753x_mac_config() successfully.
> 
> Remove mac_port_config from the sanity check as the sanity check requires a
> pointer to a mac_port_config function to be non-NULL. This will fail for
> MT7988 as mac_port_config won't be a member of its info table.
> 
> Co-developed-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
