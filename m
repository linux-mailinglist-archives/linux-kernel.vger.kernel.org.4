Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAC363FD6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiLBA7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiLBA7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:59:53 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F6BE692
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:59:51 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id x12so1522235ilg.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5gZg4mZ+Y6hG3RyPNuo5TnwMGDFqNZx0oxGGFZyG9gs=;
        b=s02BtCOyTCmiPXAGRGmaTM96neMNIKFFywoAQ7I7mHGhCI9vdng089AXCHfdmREQm0
         TNGUp11MIwXhIU4Dm+yR/TPN/GnvRN/JfLRua6ProivCGOpe1jCs/8isu98NmMC5+OWx
         ynAx9NSlaiuNwyvbSQ6DhjHgVoZcVsOEbuvXwQhgL7yFkX7RnxZzy1KTVTguEOsDxMTX
         jB55x1l97b8X9jzjsktoR4J2pZUvXymKnAYW1CAyGrJHLO9G4EOhRwfcrgWOI+0VwPcX
         Vl2PFvOUZd4J+yCdXvypiHAcs1+VvIeLFZEvEz7Q+LSuO9qxTQXiht0rzHJV2dWYRS2e
         fYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gZg4mZ+Y6hG3RyPNuo5TnwMGDFqNZx0oxGGFZyG9gs=;
        b=IMlWoF8qLRiGHNTMy37LhJvYH7rhRuL7hmetwd00YuOGk+xKXPBSzbGqOWA/OhcIfm
         1bMY9iOmr0RZsywRK4QB6IS8n1N3j63XJ3CNrJFXzFh+wWbmUFoaMItqX7PgIQNOE0/H
         W3JjlQNnNZZDOBsECJeHcH4gQLnyRSNoPSu63oTcqQoD8LltwnT/3NaQUO3U7We98wUH
         kZz2WweJSEh8yq4FN+HjF01TsU6336Vvr+2hfvulBictPzpw/Qaky2osK4Ri7tizBEHP
         ErCAF4nXCAAmNRVmdN0tVzMh4hfFpCPdJie6AmhSo5k/A55SDWTZZbmNAI2C2beNIwqw
         ne1w==
X-Gm-Message-State: ANoB5pkNKAjOlzhVPZvNHQfNLGI7bdLw2LFgjlP0lYJKNAVuxG3c3i5h
        agyCieT6EJ05yW9G6SpinH8N7Pt5prU2dJvJXJ38oQ==
X-Google-Smtp-Source: AA0mqf4PK5ZJJZ4p/WZvUg80NUj8mfpbio/mn2njsWlMvSQTxCD16JrMrXpBinqu4KFXKOcx825t6TGOeM7b8IHtg30=
X-Received: by 2002:a05:6e02:216a:b0:303:129a:8157 with SMTP id
 s10-20020a056e02216a00b00303129a8157mr11125353ilv.38.1669942790467; Thu, 01
 Dec 2022 16:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20221028210527.never.934-kees@kernel.org> <Y2TVXDfQUwlYFv9S@gondor.apana.org.au>
 <20221201115244.GC69385@mutt> <Y4iZn9jC3VqBHEtU@gondor.apana.org.au>
In-Reply-To: <Y4iZn9jC3VqBHEtU@gondor.apana.org.au>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 2 Dec 2022 01:59:39 +0100
Message-ID: <CADYN=9J2tP7GG80-mzmUe3ad9-OTd_jbE7Y2yMafvwADLLjz9g@mail.gmail.com>
Subject: Re: [PATCH] crypto/caam: Avoid GCC constprop bug warning
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 at 13:10, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Dec 01, 2022 at 12:52:44PM +0100, Anders Roxell wrote:
> .
> > I think that was fixed in sparse release v0.5.1 [1]. The workaround 'if
> > (len)' was introduced back in 2011, and the sparse release v0.5.1 was
> > done in 2017. So it should probably be safe to remove the 'if (len)'  or
> > what do you think?
>
> Could you please send a patch? :)

Please ignore my previous email... since its not the 'if (len)' statement that
GCC comlains about.

Cheers,
Anders


>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
