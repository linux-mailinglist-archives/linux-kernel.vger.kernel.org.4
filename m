Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E89A6F1C58
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjD1QMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjD1QMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843E11BC3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682698292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xvahxQLiQFCmxj/da0CErLJVS9PB2G5zFVCmECHMB00=;
        b=DGvkDp8UAKUWvdmFGUOjFjB5Md5vXBR6ipW9JD423ZqAilPZRxgLFdVEbxr41R3rreeLPP
        QSufe7KGCXVtas9ztJtvCcaTw8kPZ/b6YBKmwOZjygqFd94J27AttyrSQyUDBirf57r4WX
        kuFkspy0ckkCP9qOjF4EnkLJuWGoAYE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Sa6dKrrDNpu61gkan9yHfA-1; Fri, 28 Apr 2023 12:11:31 -0400
X-MC-Unique: Sa6dKrrDNpu61gkan9yHfA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-54f94262a87so337257b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682698290; x=1685290290;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvahxQLiQFCmxj/da0CErLJVS9PB2G5zFVCmECHMB00=;
        b=gQPJ+vI30mN53VnvHuQjNVB5BzQ4AmcTMdXR4rUZUHxKqhpfC5DQxNU06cdrc97aRm
         M5PwAcGiMG6tfTEPyFTfBzrq+gAsL7T0oyywBoxQPBh2IddHbjOoWMqnWfKH9iSprlHh
         JCYGQF0k5b5CoD6CRi/Ja8AMzEcaMSAsKVdvVhA3uiJsOOKeBIBzStceT0J6ydcwHXX4
         NnomTc2DzVZm8fLBs0gRGIg3FoZEXTO3teunjax3TRPE+9nBrieeqoBi0nMOgA8rpynb
         c76SqaHy7HB93e4iXSQmJlbmvxzgmPOIgtpJMcv+QY1De/dVViAfc3vvZyQ/CRiQJjhc
         0u6A==
X-Gm-Message-State: AC+VfDxjqvQGJgZRTWlH1rgeVDwB9XgwAKNbZNcbmSltFDZ80yq+Iyg6
        t6ieEPu0YZNkKQsc59LaDQrdMHGx6DJOABnhepHAxXXsRps8q6z/66e+ZgjV6yQYEYEtihihoFU
        V+4nKfyr3gfFx6TuwNHgNBpBauOJvxIbo
X-Received: by 2002:a0d:e781:0:b0:54f:7971:4f87 with SMTP id q123-20020a0de781000000b0054f79714f87mr4293697ywe.36.1682698290454;
        Fri, 28 Apr 2023 09:11:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eQOValmuJ/zOGLy7XBJvtcPQGnD4pUgv35/t3W92dQB8jJAbCq53fx3gGDoRQ4+mPyAlOcw==
X-Received: by 2002:a0d:e781:0:b0:54f:7971:4f87 with SMTP id q123-20020a0de781000000b0054f79714f87mr4293686ywe.36.1682698290218;
        Fri, 28 Apr 2023 09:11:30 -0700 (PDT)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id d190-20020a0df4c7000000b0054fcbf35b94sm5497442ywf.87.2023.04.28.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 09:11:29 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:11:27 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] Input: pwm-vibra - add support for enable GPIO
Message-ID: <ZEvwL69i2Wzdoagt@x1>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-3-e87eeb94da51@z3ntu.xyz>
 <ZEsFV6F4CEh2/av8@x1>
 <8250064.NyiUUSuA9g@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8250064.NyiUUSuA9g@z3ntu.xyz>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 06:06:20PM +0200, Luca Weiss wrote:
> On Freitag, 28. April 2023 01:29:27 CEST Brian Masney wrote:
> > Take a look at dev_err_probe() to remove the -EPROBE_DEFER check.
> 
> The input subsystem doesn't like dev_err_probe for some reason, you should 
> quickly find examples of that being rejected on the mailing list (or see   
> "git grep dev_err_probe drivers/input/")

OK, that's fine then. Feel free to include my Reviewed-by.

Brian

