Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9D16335D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiKVHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiKVHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:23:02 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC9B101FB;
        Mon, 21 Nov 2022 23:22:59 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d7so9681050qkk.3;
        Mon, 21 Nov 2022 23:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7TwzpFsFQClSwuKQTXmRtSYacFGh+27tuORQa4kKv5I=;
        b=mA7aJhcq06ImGokynYxotESuqynecZKKDYx4ub48VcZOFRKkDdur39R/JJfnAk58tK
         oHQNyuaJh8XXlJwjR1+33qwCB6dKNOnmPnaIAXaEO7lyp2jbbocJuqiRd+DzpL1Q2Nn1
         4QO7d/2t2e2rj0eRXUVAbnhPVJk0QC2hra460FKmZhe+RUTkwuPijCVQx8BRDfFINiia
         A1UD/F3ZmKrt+3CeAdiOv299Ws02Sx3jlUqi+n9YXlAcJUz5UdZ+K/fkY9voUb4Fv2s1
         rlGQVbCzPABFSLGoVr+lU7T7/MfcnP1nJjMnHvx+GvzMXufVa8NzYCQYMbrxFi64G3QA
         6bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TwzpFsFQClSwuKQTXmRtSYacFGh+27tuORQa4kKv5I=;
        b=Q1849dNgFNPquezxgr/GWNa7usz57XmZV8uwzGFH61zBFN4MvxjbanqJWT8tMZOFZR
         vWfg4Ah/ZMYDY+Y+mANk/V0YetmU6kQL18UiWJgAYOfFYqa3TN3XwkF7nbjs6gv892Fp
         urkg+0dER7pkMSH5xq5OgReHRyJZeaoquxfusM7QHZg6mBzMpqQM1Yx8cIDNyraWNwlI
         VsEqsGLPYcSYPFxdR4vgPKHI19jKutSgPmbYI6Lj5MS5Ekb4QL1DkWs3nG2CV9u3Hg4M
         CJ6a1J0i7LoEKe/Hf5Wb7YNQzuyUEwWCmZqek0ESHMKmt0vK1qoHU2MZXN794WdII1CZ
         M0Gg==
X-Gm-Message-State: ANoB5pnh2xKFzKnho0sqd4t344Xvhe34hzNS/6bZSa5DvoMJqq4AqS6K
        WMqzCAD9YfOOhOFq3mYCHj4=
X-Google-Smtp-Source: AA0mqf6a2BBw7C+lLin2nyBRusno/c+zXxhOMqbNCqG4uo/1+vPPilx/DBvJlWuDIixI5pUfhE7j6w==
X-Received: by 2002:a37:4655:0:b0:6ee:6fb0:c4ef with SMTP id t82-20020a374655000000b006ee6fb0c4efmr2908350qka.173.1669101778217;
        Mon, 21 Nov 2022 23:22:58 -0800 (PST)
Received: from p200300f6ef01c100bbfed85b414bb2c3.dip0.t-ipconnect.de (p200300f6ef01c100bbfed85b414bb2c3.dip0.t-ipconnect.de. [2003:f6:ef01:c100:bbfe:d85b:414b:b2c3])
        by smtp.gmail.com with ESMTPSA id l15-20020a05620a28cf00b006bb2cd2f6d1sm9622910qkp.127.2022.11.21.23.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:22:57 -0800 (PST)
Message-ID: <1939e7e7dd3f935a0222c1fd0318b58de0cbdb3c.camel@gmail.com>
Subject: Re: [PATCH] iio: use devm_platform_get_and_ioremap_resource()
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     ye.xingchen@zte.com.cn, lars@metafoo.de
Cc:     michael.hennerich@analog.com, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
Date:   Tue, 22 Nov 2022 08:24:28 +0100
In-Reply-To: <202211220935338446115@zte.com.cn>
References: <202211220935338446115@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-22 at 09:35 +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>=20
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

