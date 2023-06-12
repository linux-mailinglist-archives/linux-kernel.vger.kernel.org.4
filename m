Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABD172CE72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjFLSbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjFLSbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC011728
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686594625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ytk4CBUD5ymgdb/TV8v27oVrKqeWA1Ac0y1484kVuMA=;
        b=Ns2DTuh91AG7n9kAg7VJ675+fJ3EqI7ZPZhpG8UG1tmhhebeuzRJC4oqTHiGQKizRk6fly
        A1L2Zdyk5Df+V6BBVreZlr9dWUuSchui9W2TRgWSVZ9ec/1wWPpbkDptOZCTI71a4RASsJ
        ABdpwltxmK+D6g7rMXsCCVbCto6mMY8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-KodHhvVXMCaNx7y8rqdjNg-1; Mon, 12 Jun 2023 14:30:24 -0400
X-MC-Unique: KodHhvVXMCaNx7y8rqdjNg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7e6582938so87826145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594622; x=1689186622;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytk4CBUD5ymgdb/TV8v27oVrKqeWA1Ac0y1484kVuMA=;
        b=k+sGqTX+3gal38NBXVSASqbsuLT2GwoYoOPATHEfQSsit6H0SQA6InssREdaRo39PX
         NU4YR+YkU9xG5k/Qlodi7r+gDfO3cG3XOiMF+FxJnctqndevpsNIHBuuQ9Uv8DHRwCZi
         b1AAYV9y77lSGjY6z1zmfz6Swt+FdePpeyicyiwY8jhl0L0VePt7k1bNXUdM12FisTK0
         0A4Mx2xHxx1mcxsA1LM/dJUU0gwCfVJYd+LbiH/yvwetxKBSt3xbGMREQjHJVAhLb6Ie
         a2b7umztubm0U/Ozu8s8UXSGSbVQiyTq0b/cGwkFovjqaus3ITqEjWT1Ko36W23Iz5vn
         b3Lg==
X-Gm-Message-State: AC+VfDwB/26QnLktIzTXA2yrsqGQazhzgeiOjXD5zPeoTLe0K+7AjQfX
        bWqTFIL8SejpXYIsJPirkLVsSXA6D0QNOUoSQILLTpoBlQfLC9NYDTGZmrf6S+6lwsbYuKfUiR/
        e1K4fRw0so6a9PgiV+UQgBh4xUmyBZ6/S
X-Received: by 2002:a05:600c:2297:b0:3f7:f544:4993 with SMTP id 23-20020a05600c229700b003f7f5444993mr8211865wmf.20.1686594622651;
        Mon, 12 Jun 2023 11:30:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6f87goxu4tLEIjzoynyJtL5A/keJi5mHvAB0RC30rg0lgcZJDIaJ1gEOYrsjRA3uu+QEeiPA==
X-Received: by 2002:a05:600c:2297:b0:3f7:f544:4993 with SMTP id 23-20020a05600c229700b003f7f5444993mr8211850wmf.20.1686594622317;
        Mon, 12 Jun 2023 11:30:22 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r15-20020adfda4f000000b002fe96f0b3acsm13271835wrl.63.2023.06.12.11.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:30:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Conor Dooley <conor@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: ssd1307fb: Remove default
 width and height values
In-Reply-To: <20230612-parade-sauciness-16225ce0a643@spud>
References: <20230609170941.1150941-1-javierm@redhat.com>
 <20230609170941.1150941-3-javierm@redhat.com>
 <20230610-opposite-quality-81d4a1561c88@spud>
 <87r0qj19zs.fsf@minerva.mail-host-address-is-not-set>
 <20230610-unused-engaged-c1f4119cff08@spud>
 <87jzwa29ff.fsf@minerva.mail-host-address-is-not-set>
 <d4828a3d-639a-a207-ff36-45c8c5d4d311@suse.de>
 <20230612-parade-sauciness-16225ce0a643@spud>
Date:   Mon, 12 Jun 2023 20:30:21 +0200
Message-ID: <87h6rc354y.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

> On Mon, Jun 12, 2023 at 09:47:12AM +0200, Thomas Zimmermann wrote:
>> Am 11.06.23 um 01:18 schrieb Javier Martinez Canillas:
>
>> > But I will be OK to drop the "solomon,ssd130?fb-i2c" compatible strings
>> > from the DRM driver and only match against the new "solomon,ssd130?-i2c"
>> > compatible strings. And add a different DT binding schema for the ssd130x
>> > driver, if that would mean being able to fix things like the one mentioned
>> > in this patch.
>
> If there are different compatibles, then it can always be sorted out
> later iff it turns out to be a problem, since new devicetrees should not
> be using the deprecated compatibles anyway. I didn't realise that those
> deprecated compatibles existed, thanks for your patience.
>

No worries, thanks for raising this question.

>> > In my opinion, trying to always make the drivers backward compatible with
>> > old DTBs only makes the drivers code more complicated for unclear benefit.
>> > 
>> > Usually this just ends being code that is neither used nor tested. Because
>> > in practice most people update the DTBs and kernels, instead of trying to
>> > make the DTB a stable ABI like firmware.
>> > 
>> 
>> From my understanding, fixing the resolution is the correct thing to do
>> here. Userspace needs to be able to handle these differences.
>
> Fixing meaning correcting, or fixing meaning using a fixed resolution?
> Not clear to me what you mean, sorry.
>

Fixing meaning using as a default the correct maximum resolution for each
OLED controller, rather than an arbitrary 96x16 resolution that was added
just to be compatible with the panel that was tested the original driver.

But after talking with Thomas and Maxime about this issue, I realized that
it won't even cause an issue for theoretical users that may be relying on
the previous default.

Changing the default resolution to something smaller could cause an issue
since a user expecting a bigger default would get their display output cut
but changing to something bigger just means user-space being able to write
more pixels than those that will be displayed.

Because there isn't really a "resolution" configured in the chip, but just
how many pixels a particular controller can drive. The new default is the
maximum that each controller supports according to their documentation.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

