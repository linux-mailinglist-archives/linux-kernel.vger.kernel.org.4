Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A93970DBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjEWLvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjEWLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:51:49 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCAFE
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:51:47 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-623921866bfso25717276d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684842707; x=1687434707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzz3Krl/1gwfPCERAAjwqn0A7Go/oeUTBfwGr7hxyc0=;
        b=WcwcWEBRQ3CSQnhggU6sxIuBxcHgb1z+lx8c+3GhWOshgrbqOklav8Q1Zahi/1PQiQ
         d6LutGzMoyqBMegpqFnALw1q89kQYIhh9kbYo/UcFTx1JxwdnYCST7E90oMsdlGZ+7h+
         ZfgwfWKblYDhwJFmiYLQIr0x5mz3EarwkS4wthiMdf/jfJHfBhi6APYRUPEI8VA424R4
         Qg+hiUQmwwa8tGkFNckKAY5X2CLMQdKCiTxdwDV1AjmDcrFy+HNd0NuElPNFjk059aYN
         oHSz6Pb8WqZNvg89btcoHYQbPWKe1lTv8UvUc4eU89iVRMTLL6RfpXtsdvOuSWm4gf+Y
         EGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684842707; x=1687434707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzz3Krl/1gwfPCERAAjwqn0A7Go/oeUTBfwGr7hxyc0=;
        b=N7BHdLEo+p2KzPl7S7cAtWyfHcUofXvd47cCHa7Lv9wqD1WfAAFk9x68wdbkifCncl
         1uYn36TwHayYJ3awdQx5leKlx8TNd2xCJtvosgyZ/w/ZQ196fVoCajoD+kXXZFmH//EI
         z0fz6oA3djVf8qjBJcWK02gAE6F54SZIYMX+Ewsw/TuFfaIG5PkKiYWjPnovf3AZ4uTb
         2Noo1yfabmRcMag0iRA5BmeWPviAGSMP7TOL39aPQ6R7UU9/b9VuGczpK7MX2My8wmFM
         B9zft6caMXkHGmfzUX55db6gIwG8+kF0t7JR7Na99QO/wmez5LGOQm1YWiHfbpqY3rsG
         bj8g==
X-Gm-Message-State: AC+VfDwXftWlsT7U3IotIjnzESvjYKGyCrTEgT9H7NzqG3fpiFz/GyGz
        +FvKqi6PaCPZLuVAjsyf9sI=
X-Google-Smtp-Source: ACHHUZ7b8xFy/485iH037f7VjmIresR5S+f7+6OC3F7PeALctFmgHHgkBSyXUU8qSNI2b+Oo7mN6yw==
X-Received: by 2002:a05:6214:27e6:b0:615:a787:6d31 with SMTP id jt6-20020a05621427e600b00615a7876d31mr22964525qvb.38.1684842706670;
        Tue, 23 May 2023 04:51:46 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id mi4-20020a056214558400b006210c4ecbdbsm2564904qvb.22.2023.05.23.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 04:51:46 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     mazziesaccount@gmail.com
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH RFC v3 1/5] regulator: move monitor handling into own function
Date:   Tue, 23 May 2023 13:51:01 +0200
Message-Id: <20230523115101.627722-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9641aa06-4925-051c-2ebe-22e43bf9dd4f@gmail.com>
References: <9641aa06-4925-051c-2ebe-22e43bf9dd4f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

thanks for the feedback!

On Tue, 23 May 2023 at 11:46, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> As far as I see, this changes the existing logic. Previously the
> monitoring was unconditionally enabled for all regulators, now it gets
> only enabled for regulators which are marked as enabled.
>
> Furthermore, if I am not reading this wrong, the code tries to disable
> all protections if regulator is not enabled at startup(?)
>
> I am not saying this is wrong. I am just saying that things will
> change here and likely to break something.
>
> There are PMICs like ROHM BD9576, where the protection can not be
> disabled.

Thanks for letting me know! I dropped my initial "disable monitor while
disabling the regulator" property, and activated it per default instead.
But this basically means something like that will be required. I guess
it might make sense to have a property which is called something like
"monitor always on", to let the driver inform the core that the monitors
cannot or should not be disabled, instead.
Except if you think there is a general problem with keeping monitors
disabled while the regulator is disabled, then I might have to do it
differently.


> I am unsure if we might also have cases where some regulator could
> really be enabled w/o core knowing it. 

Unfortunately, I am not 100% sure what you mean by that.
On the da9063, for example, it might be possible that a monitor is
activated by the OTP, without that the kernel actually activates it.
I think it is not recommended, but it is possible.


> There can also be a problem if we have hardware where monitoring is
> common for all regulators, eg either globally enabled / disabled.

Yes, but I think in this case it should be the responsibility of the
driver to ensure that either all or no regulator is monitored, because
the same requirement is valid for implementing the protection ops.

Best regards,
Benjamin
