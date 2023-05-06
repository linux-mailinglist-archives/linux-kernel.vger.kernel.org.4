Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1C6F93A8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEFSiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEFSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:38:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28381490C;
        Sat,  6 May 2023 11:38:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51b603bb360so2681476a12.2;
        Sat, 06 May 2023 11:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683398287; x=1685990287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w79NVR3gj7qsB+aXUIAYDIycgjursveG7dLrIvGarPw=;
        b=bNKKp4SJ1mH8ppSwMZ7EO4JmpXSsUIHE31QtF19b5geoGBVetfnmdzh8INpTBaEmDj
         +EpxjqpjF4nDrdwWDR+u4DSaXXRUt4AMI52RyHr60Y3PPfRJ1dCYvXdaF5LKUQ0jV2LQ
         cKplKBT6EsEyd+pRiFYFUjma+5pQ1IHDMl6n/12/yU8I3MKnIYykVk7KbbtvTHEvDSkW
         ywBe1QcAxtQu08CmhshI4G4X422Dqis6TebjMV5CA3dQ1wM5xHwhK5OBi/t2th9Bt2BV
         ZEAOSxL9zafMSR9limpFSR2AUU32BompagHk5lSGqBy5s+jrdtE6fiGzoA1c9dMpZCys
         2FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683398287; x=1685990287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w79NVR3gj7qsB+aXUIAYDIycgjursveG7dLrIvGarPw=;
        b=j7uarGjgKkSn9LpVoK2nUzevVuw51+63i1oeCE6NzPZDBOpGiBL9EdjomXz6gNA4KO
         h39ruFYacyNMwsUIv4Vmb334jFF8ocBz+Ogok6Rs0Bn/4BNcjMW3/k8BUICsaP+4QGFx
         TFmu+HE/utxWvl3zFjgAdxS+uhQgk1akGYRBm3nlurbRFKCOH8jfJNoP2uBV2aV/yO/k
         ffFcYP/RZ62DWwiomIfIgmJF+YhmY8JE+P2Zg3j2c2C0jDHSeNw7Ek4RGUDcXPFwfPmV
         nc7Q+GslfzDwuvYYAFwnftUXN51UEFDUe6AHF+Fa9r0deX+Jl6nm4O/GGp9LL9gYCnKe
         44Ag==
X-Gm-Message-State: AC+VfDzLKZNSKb3XhjR9BiU/XYzv18NbFoxaBAlBmnprzQOaAYxdOUQY
        IG0gLR8HXHZQzvXBx9SmZdo=
X-Google-Smtp-Source: ACHHUZ71hVIm2Ofn1w1AljTUyJiblhCxS4iJxpxyS5k187Argagzpy6Uht1e+5zCbe9M62Fi/KRBVw==
X-Received: by 2002:a05:6a20:8e26:b0:f0:5d4:c4a with SMTP id y38-20020a056a208e2600b000f005d40c4amr7151000pzj.8.1683398287115;
        Sat, 06 May 2023 11:38:07 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4440:ecf6:7bf5:244])
        by smtp.gmail.com with ESMTPSA id e22-20020a62aa16000000b00627fafe49f9sm3469343pff.106.2023.05.06.11.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 11:38:06 -0700 (PDT)
Date:   Sat, 6 May 2023 11:38:03 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: ensure timely release of driver-allocated resources
Message-ID: <ZFaeiwBp+5hUXk/j@google.com>
References: <ZFWarGkRAfPOmI6E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFWarGkRAfPOmI6E@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 05:09:16PM -0700, Dmitry Torokhov wrote:
> +	if (down_interruptible(&hdev->driver_input_lock))
> +		return -EINTR;
> +
> +	 ret = __hid_device_probe(hdev);

There is an extra space snuck in before "ret", let me know if you want
me to repost it (or if there are bigger concerns).

Thanks.

-- 
Dmitry
