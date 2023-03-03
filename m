Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198386A9716
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCCMQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjCCMQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:16:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1315F531;
        Fri,  3 Mar 2023 04:16:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so9325277edb.12;
        Fri, 03 Mar 2023 04:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677845768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKF5bThLEdXvv6M/eGMYQTDSSRPUXsU5bEyWlcnJsFI=;
        b=XTw2Ks9VFnobVPmqdmHB4E733ZuVBV38o6jsGQeOzO0QuqW7CsvLy+z95W+jahW8FQ
         H2nIso0p5952QktEBH/nmuP1PYB6B4k5aTp5T7NnwKGoEHoVdRdFl5th99U8XlFX1yNq
         wYhXeEJR72UTntkebh1MEmLRZIoobeejQxuzOI0duQlcYpTgDs1XuFsOMZc79VF7R46l
         z1/FlF3v1sMavx4Jexnw3exmmTev22ydbR0UhxQRmwVE1z9TKtcCpdm5fkmqMwQVV8xX
         Bg4yoLWhWwmvQo+eDTD5bf+2ThpPbN4af9C4j6QfwQSlK9VUkjOmoAT3Xs4JJRIAIR4X
         Y4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677845768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKF5bThLEdXvv6M/eGMYQTDSSRPUXsU5bEyWlcnJsFI=;
        b=Bv6jU93VSJswx5LVKbmfRCjyWVPT7KbbUdgpRZdZrvvq0RNWoS1T/Z+dA0Rq+Bs2eL
         NOS/sVnOq8EH/77+9R/WfIARRzLEeC9lq/n1H5It43hW47+ouvc7h9X5FXrW1NF5vE2C
         OOIK//PoQ7IHqhhnOzHPrtrto8QdDf/LT6++RIyivi1XxZJEEHM7dP9Z3f0SiLAPL+KM
         RaNhJpgNbyU7PTg/3fiAEnYKsk8sEqEFLKOqwmSx59LiLoMAfrUat8cTedB0l92FxvGa
         WkHCYotlROPk/k5oEqF8vApIKGDfAXo1zYXMldybYBsTEj7qpA1hxn4c4h+3nXDlkUXN
         P0Mg==
X-Gm-Message-State: AO0yUKUi+0gNmCdaK8HPWncaLxGxVw/14UIN5foFNu92a28mqAxKFwi7
        G+rivEer+Qw5xgHfoK6rpy6htDur7rY=
X-Google-Smtp-Source: AK7set/R588HGFJwcd0eNeafQWwy8KUGJwUvOlfbwq5LI14n2rHC8JUskp9YzyeM9ses1FA3sV97ag==
X-Received: by 2002:a05:6402:b11:b0:4ae:eb0f:8867 with SMTP id bm17-20020a0564020b1100b004aeeb0f8867mr1568280edb.41.1677845768269;
        Fri, 03 Mar 2023 04:16:08 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o22-20020a509b16000000b004c4eed3fe20sm1107400edi.5.2023.03.03.04.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 04:16:07 -0800 (PST)
Date:   Fri, 3 Mar 2023 15:16:03 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH v3] s390/zcrypt: remove unnecessary (void*) conversions
Message-ID: <ZAHlAxv2QNKpNLmZ@kadam>
References: <20230303013250.3058-1-yuzhe@nfschina.com>
 <20230303052155.21072-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303052155.21072-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:21:55PM +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>

LGTM.  Thanks!

regards,
dan carpenter

