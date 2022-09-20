Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D325BE014
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiITIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiITIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62E763D4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663662583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=da3EKRUU/aX+F/G8AcfIVmp7slwdPcDC7pD7Lc1k6T8=;
        b=TpeSWuwDk31qvFRKF1S7eDYUS8pQLt4wdIcnEoTmW8tUAdUzwuzPwHS3IFm01hrEfK5hux
        90MIklUdAuE/JpAJw3sizipVcOOTo6joB83FC0nQEinEyOpjZpRoo73HywhqO3QaM3rfQW
        wiiYMoCFcrCNi8aiUBCQTBjkZcxyLJk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-427-wkM0-YuRMNmqbttQQhAuCw-1; Tue, 20 Sep 2022 04:29:42 -0400
X-MC-Unique: wkM0-YuRMNmqbttQQhAuCw-1
Received: by mail-wm1-f70.google.com with SMTP id p24-20020a05600c1d9800b003b4b226903dso5943432wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=da3EKRUU/aX+F/G8AcfIVmp7slwdPcDC7pD7Lc1k6T8=;
        b=ypLBWgTq8YH6xyXp9AbY1kECY8Eq7krO9sZ5TN9OyOVEnO8nb+9DVaQrXkmYJd5m47
         Mknv3mCeqKG5SaOJHa4byOvwoRWu38UCjBYNfAMBR9arnugejZvQLXTkxX6hzSQP73dk
         D7TRIYm2r0kOztF6OTrqHRCwYvzpqgKHrMP3CCt4Y8/0G9Qdn+mMSsWrQnUYEu4I0/ZI
         LfFOfaAm+1A2ioZ6H7TENR4rIBaKdk/1o5sk/uJh/hZnU92bX9XXzlQt2+p1pbjZ1Bkk
         yAsaY2CmywdwZ/gdf6RXLhMkxLrFgU/lL0XkjARFEO911/gX57CeHjH5Aq6yeuEAHbtX
         no3g==
X-Gm-Message-State: ACrzQf3xcRWqpBCK044QIfaD9lWENZZ5MdmV2o6+/VGT92O3+If4lZ5I
        bDsMn/cxcrI4M3bq3I/1ZRKB+LG+RLabohtbGp64LIiBX2pH4r6JLg+WYW8bLaMMAIkMvlRwnB/
        GXWYwCi/8EQb1hhtBXzZZWwF7
X-Received: by 2002:adf:eb02:0:b0:225:2b94:d14c with SMTP id s2-20020adfeb02000000b002252b94d14cmr13848118wrn.291.1663662581323;
        Tue, 20 Sep 2022 01:29:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XGXRZ5NH9x0iBE08TdJin8BZiQnDIHLSZamFKo6wSEPBM382Wr2hx4MknpmLHULGj3V7/oA==
X-Received: by 2002:adf:eb02:0:b0:225:2b94:d14c with SMTP id s2-20020adfeb02000000b002252b94d14cmr13848101wrn.291.1663662581078;
        Tue, 20 Sep 2022 01:29:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id k11-20020a05600c0b4b00b003b49ab8ff53sm1518774wmr.8.2022.09.20.01.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:29:40 -0700 (PDT)
Message-ID: <d98d439ef5ee8a1744481bf1f076fbed918c3cef.camel@redhat.com>
Subject: Re: [PATCH net-next 3/6] net: ipa: move and redefine
 ipa_version_valid()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Alex Elder <elder@linaro.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org
Cc:     mka@chromium.org, evgreen@chromium.org, andersson@kernel.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 Sep 2022 10:29:39 +0200
In-Reply-To: <20220910011131.1431934-4-elder@linaro.org>
References: <20220910011131.1431934-1-elder@linaro.org>
         <20220910011131.1431934-4-elder@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-09 at 20:11 -0500, Alex Elder wrote:
> Move the definition of ipa_version_valid(), making it a static
> inline function defined together with the enumerated type in
> "ipa_version.h".  Define a new count value in the type.
> 
> Rename the function to be ipa_version_supported(), and have it
> return true only if the IPA version supplied is explicitly supported
> by the driver.

I'm wondering if the above is going to cause regressions with some IPA
versions suddenly not probed anymore by the module?

Additionally there are a few places checking for the now unsupported
version[s], I guess that check could/should be removed? e.g.
ipa_reg_irq_suspend_en_ee_n_offset(),
ipa_reg_irq_suspend_info_ee_n_offset()
...

Thanks,

Paolo

