Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B237C72F65F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbjFNHcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243437AbjFNH3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:29:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19A910C6;
        Wed, 14 Jun 2023 00:29:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8d176396bso3045705e9.2;
        Wed, 14 Jun 2023 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686727784; x=1689319784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kQh+i2qewEJ5nIFSelYX9sKtVjFZOZ+RgXX/lYenfFQ=;
        b=S/YQ+11NAf7qreGezjRV9yfsyV7pNUapi0EPE8PP9I0aFcB/TsqJj+a/HenDT2bn1z
         k7STkqr7yezK+s6GS1AoYcemFC1JVnkn+HCN9StZ5lc/hx253Yss7oazMT9uAXSeH+nb
         YraIAtMvnGRb1LMlOTKyZ2h4kmu+ntNJ3YtiEBcMQAxZYoekucbmTwOmbi7Vvyrnggjr
         9hStTPvaQRzEpEMgTvaQv9yH6Q4/DzZZycIE08YF7Dt9NfqVSQFpSjPlbRJNjzNz6Leb
         PdZ1Yp495cJgBw/YWigzd+H6zRVDRpQuj6a9f+0b1cnbYD5+sAuweGGqduyIJ/vc25us
         X/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686727784; x=1689319784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQh+i2qewEJ5nIFSelYX9sKtVjFZOZ+RgXX/lYenfFQ=;
        b=lez/lNluZ6f4Q82VHGut7LOFWVYYq8SNem7CuVIvym7LFrw2scgbHbMCfdkel2vHhZ
         6nh0r79kxNJ/mmhhli+WZgXz43XDAzw0wVIuap8EGESwolvBRjh8YR7cMka4nmvmArRk
         zYtNRBqxaSag7o9c07NRQSHqnZjeSxcmxQNxBkbHl3qqO4aGD55aQDV3ZK+1QPBq3G/m
         wRoOIfQA9ms19PlrSaWe1ErTAOyPd0MLVooYU5KDEaadWYqgy/wxNg4A1ha/+cw8AKyD
         OMZ6Zm0FNV+LcOYJPPJav3mIk88Omgn8LCLbVOLoap3KOlDNuLVyi/FheCLT/edb1R2T
         Nlkw==
X-Gm-Message-State: AC+VfDwNYF4vw3w9D65Lx2GGXyC5emWZXcMafvhuGeLO0k+bpszjoYAW
        2EwJtYm2UKDkJ5z6Fzfy02s=
X-Google-Smtp-Source: ACHHUZ61Q0pJnWxc3jjFrsz88PyYYxqooZdRMqUg+sTdEFjrw0hzq2gAWTF6R2U4AfzsQGJgMtcvtQ==
X-Received: by 2002:a05:6000:88:b0:30a:bdfd:5c3c with SMTP id m8-20020a056000008800b0030abdfd5c3cmr8491423wrx.17.1686727784095;
        Wed, 14 Jun 2023 00:29:44 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c024400b003f60101074dsm16502798wmj.33.2023.06.14.00.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 00:29:43 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:29:40 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Daniel Golle <daniel@makrotopia.org>,
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
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 2/7] net: dsa: mt7530: fix trapping frames with
 multiple CPU ports on MT7530
Message-ID: <20230614072940.zd7kxu22u4snuf3n@skbuf>
References: <20230613172402.grdpgago6in4jogq@skbuf>
 <ca78b2f9-bf98-af26-0267-60d2638f7f00@arinc9.com>
 <20230613173908.iuofbuvkanwyr7as@skbuf>
 <edcbe326-c456-06ef-373b-313e780209de@arinc9.com>
 <20230613201850.5g4u3wf2kllmlk27@skbuf>
 <4a2fb3ac-ccad-f56e-4951-e5a5cb80dd1b@arinc9.com>
 <20230613205915.rmpuqq7ahmd7taeq@skbuf>
 <dd0d716e-8fdc-b6dc-3870-e7e524e8bf49@arinc9.com>
 <20230613211432.dc66py7nh34ehiv4@skbuf>
 <ba072bab-a6af-b6bf-e3c2-de07b1003d41@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba072bab-a6af-b6bf-e3c2-de07b1003d41@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:03:04AM +0300, Arınç ÜNAL wrote:
> Makes sense. I have prepared v5 that addresses everything so far, should I
> send it today now that Russell has reviewed v4?
> 
> Arınç

Let's wait for Russell to ack that all discussions on v2-v4 are closed
and that there aren't any follow-up questions there.
