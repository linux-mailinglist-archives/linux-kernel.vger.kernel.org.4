Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E69722333
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjFEKQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjFEKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234CAEC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685960136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w//PXxvTZrP/Pd4OMnUnywaLbQPL0Fl6oKrPT/BNYWY=;
        b=PTtp4cXnSFRJwog1CvSKqlGWiR4L3lyCkku6G8bo+p5SGFWA8F79jOXEIoDSHdLMwpvcKI
        nXtKYQAnCNTBiO60hv4h7LuSQbUg6gWGSI37TIguqDJygZJ4gaCvC5abjwtnBt/AAGiZc2
        Wmz+jfHkhU5tcZ/GWZaXBPxR7z1dve4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-OX4Q--WsM5OvS5sr3Ek1qA-1; Mon, 05 Jun 2023 06:15:35 -0400
X-MC-Unique: OX4Q--WsM5OvS5sr3Ek1qA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f60911a417so21930625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 03:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685960134; x=1688552134;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w//PXxvTZrP/Pd4OMnUnywaLbQPL0Fl6oKrPT/BNYWY=;
        b=huXNEEkM0vVtxUyQxjdXgp/oXNwPLBAJ6qFHQlqHLrJfhbQDc5fQ4HboLWw4GsN74A
         VLIylSA9E60G46t69HAgXVjhnG9UNO6v6jL2yaBcN7JwcaD/VEKg96+PV0koDxMYP67Q
         dzxIMO5Sytq9qs0GEMbvUiD3mQfNsLJiUebBwdJLaShhVZgtElJFQdL3qZGrDMxbOZs9
         Ywl9MwiyvvJet2F57ne7lGyq3FQqTOLNI/Yxrf31rL5NOjI8Od7XI+I4i0KemCAkk/w+
         vnhegIlfFP5qbwug2/Md0WN8uFnaYXlsRp2paJxvPZm1TcmiK0eDO55b9PQXAMIPFoh9
         PLBA==
X-Gm-Message-State: AC+VfDyJLB/5kCztbZ/7lwoJocB6nhighwhVwZK4AG/hku98Kxla7pZs
        7finIsDNYhWzqHiRF75lrwtaRmVmzLeiIlz0NCfp4A3xAP8psD76tYIumBDhAzCZ34sS4j8XxQa
        YnsbDypcmTO6Oz6B8AjSFE85Ap1stLqlB
X-Received: by 2002:a7b:ce0a:0:b0:3f4:fc5e:fbf2 with SMTP id m10-20020a7bce0a000000b003f4fc5efbf2mr6422024wmc.8.1685960133990;
        Mon, 05 Jun 2023 03:15:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ774aF+F8xAb+CL5DwQDB+hwugLWEVdNbOkjDsp7YxMoQiVfuXw+ifNZEj/0nkXNmGxevlGLQ==
X-Received: by 2002:a7b:ce0a:0:b0:3f4:fc5e:fbf2 with SMTP id m10-20020a7bce0a000000b003f4fc5efbf2mr6422013wmc.8.1685960133687;
        Mon, 05 Jun 2023 03:15:33 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bca59000000b003f7e62d38d4sm1353196wml.25.2023.06.05.03.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:15:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/5] dt-bindings: display: ssd1307fb: Remove default
 width and height values
In-Reply-To: <3bluztz3pcyoyjk4ett673ksnvtkl4xrjqjt43mhmd76dugg7t@kkp7rkx3vjjs>
References: <20230605074753.562332-1-javierm@redhat.com>
 <20230605074753.562332-3-javierm@redhat.com>
 <3bluztz3pcyoyjk4ett673ksnvtkl4xrjqjt43mhmd76dugg7t@kkp7rkx3vjjs>
Date:   Mon, 05 Jun 2023 12:15:32 +0200
Message-ID: <87v8g2gqpn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

Thanks for your feedback.

> Hi,
>
> On Mon, Jun 05, 2023 at 09:47:50AM +0200, Javier Martinez Canillas wrote:

[...]

>>    solomon,width:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>> -    default: 96
>>      description:
>> -      Width in pixel of the screen driven by the controller
>> +      Width in pixel of the screen driven by the controller.
>> +      The default value is controller-dependent.
>
> I think we should document it still, either in the comment itself, or
> through a conditional and different default values based on the
> compatible.
>

Makes sense. I'll add that in v2.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

