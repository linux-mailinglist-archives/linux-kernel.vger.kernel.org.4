Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96756059B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJTI2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJTI17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:27:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0BD189808
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:27:58 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id mg6so13048576qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAYFmXkINTjJjSvosD7JyY8mMrc36MRPPjiOcaF+K1Y=;
        b=MF9mY9LrtxQJ9y/MfIehqQFud5E+lhTwm+09rzk0yD/RFbw66AjuV6Gto/DzQLulq4
         pD0YcPljm4H5M/iJghYWZhGuPmWLVvFDT6rdgTx2b5JWxLif3z461paHZqQMJTSAHCjt
         nRkOudsDu+gEIX2T0wrVipLSdCxfJoDMUVaCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAYFmXkINTjJjSvosD7JyY8mMrc36MRPPjiOcaF+K1Y=;
        b=4gSvSls2SM8NqnO8oUlI3GLOyMHcmZncUpF9FK+UI/TVSjHp1rnwetdfP5L62pZXJQ
         iQHcGrZlqJ5l/sj6QCJd1eYfnxD5cBgtMYG4UzsfX/wBfzUMHPyPSHh5mPQbut0yUot8
         32WuqwCI5EOyCvCfr+peVDjwXV75VsGkNimx1F8qPBQ/3TOGXLue8XBl8TZ3N1CaZrsr
         sn01wRNSJHmtImuQstPbh05twsdW23FYyBDH9UlGFO4pbVBvyFThgOZjQ8DjR3QIx6b8
         bADj6S08a9VSqoF0vW78nvWvY/fiW30MXrGzXlPJvRnhNnItzqZ1BUOJHlUM7y3qXJj9
         /XVQ==
X-Gm-Message-State: ACrzQf2sJ0R+YvTz2B5lUb7EcwS9uFLxrii1k8z871mZgxMmqHZY0vys
        GC76OX4F68l6pc/urh5QZdFcHQ==
X-Google-Smtp-Source: AMsMyM4gVknx/zGimNxQCk6OKQeMPCHi9kxUIY0rGsdAUdUJvhROid4TAt1xP4mWJtITy4EJr5D3yw==
X-Received: by 2002:a0c:f54f:0:b0:4b1:872e:102 with SMTP id p15-20020a0cf54f000000b004b1872e0102mr10244381qvm.123.1666254477516;
        Thu, 20 Oct 2022 01:27:57 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id h10-20020ac8744a000000b0039953dcc480sm5564728qtr.88.2022.10.20.01.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:27:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Thu, 20 Oct 2022 04:27:56 -0400
Message-Id: <07E5D3DD-2AA5-48B2-ADCF-48004D889724@joelfernandes.org>
References: <20221020010242.453121-1-qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221020010242.453121-1-qiang1.zhang@intel.com>
To:     Zqiang <qiang1.zhang@intel.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 19, 2022, at 8:56 PM, Zqiang <qiang1.zhang@intel.com> wrote:
>=20
> =EF=BB=BFCurrently, regardless of whether the CONFIG_RCU_LAZY is enabled,
> invoke the call_rcu() is always lazy, it also means that when
> CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
> lazy. therefore, this commit make call_rcu() lazy only when
> CONFIG_RCU_LAZY is enabled.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
> v1->v2->v3:
> Use IS_ENABLED(CONFIG_RCU_LAZY) to the existing function of the same name.=
=20

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Best,

 - J


> kernel/rcu/tree.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index abc615808b6e..1f6a4b2b13da 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2887,7 +2887,7 @@ EXPORT_SYMBOL_GPL(call_rcu_flush);
>  */
> void call_rcu(struct rcu_head *head, rcu_callback_t func)
> {
> -    return __call_rcu_common(head, func, true);
> +    return __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
> }
> EXPORT_SYMBOL_GPL(call_rcu);
>=20
> --=20
> 2.25.1
>=20
