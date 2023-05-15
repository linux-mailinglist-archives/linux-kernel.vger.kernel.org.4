Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21CF702C55
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbjEOMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbjEOMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECE5138
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684152545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1OPYbFK1MaRB/Vx7gvgvUiirswNhs1Gc4aAk6bBszZU=;
        b=DY+biKCdzC3bZPaovA2/TToS1moklnugj18biaCaZVqZO1tn4YWpBhsq2q8xS2sapSmh+f
        VvWAhNPlmDv2g2cciXY0bovZlOkB0GTCgqxlmsDSvnicIkvlFRvrmdC5pa8jUDTbbIr93f
        reawKECdCULlm8psRkSbyqpEisX5br8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-eA0U6THxO5-TsddgRWqRng-1; Mon, 15 May 2023 08:09:04 -0400
X-MC-Unique: eA0U6THxO5-TsddgRWqRng-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f42867b47dso48476345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152543; x=1686744543;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OPYbFK1MaRB/Vx7gvgvUiirswNhs1Gc4aAk6bBszZU=;
        b=ZON7/uRDNLVwDHMZxdbOmbiORnFaAusZGZPk1yFR5XMhI/m6uNFzCxa7TDKdfrQ3De
         aJAmQ6kZHPJd6QRiU6AmX2zvXQHuS2okLEZaKSaESjQNUnqphYQk/q7hs0ZQNZoEIMU6
         5PVqQhCBCBy5eUC09J32UBPIig+ghn97CLv+4ROtr1DVOXkCuWvSn3H5y1RjHaQlaI9J
         SaR94Z/aGhDLKqATSSoHQ9h4CDtBAynguOnjO4vkcQzG4DWvyJZPsbftUvg4ITYPj+f2
         Bd2+/bagtRQXZl8unBEfQjfgtub3SRI0yRqOzJXemaZoU90xNv/VCNDlWRkQsychUyQt
         Zk9w==
X-Gm-Message-State: AC+VfDw896dEMrrSqwuevPBP638MfBoGiqrgQPGJ316crWqH4Rhl1C5P
        R6qHZ3GMqbwcRv8+FTXHhhK81LiRyTmf5qYZiLDlquP/HXWlQ/yRcLfTHpP5Jo94/t/knq8Ue0V
        FOLLDfQpnWyuFJAIJl533JOVqIrCpnyKI
X-Received: by 2002:a05:600c:cf:b0:3f4:9bee:b9c with SMTP id u15-20020a05600c00cf00b003f49bee0b9cmr13827116wmm.18.1684152543294;
        Mon, 15 May 2023 05:09:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cA1R4HrXV4puy/LOr07navRMi/rmZmaiDm/8VhAVfXpABZay9tsPMWtZHk7Tz8iknQ9yAiA==
X-Received: by 2002:a05:600c:cf:b0:3f4:9bee:b9c with SMTP id u15-20020a05600c00cf00b003f49bee0b9cmr13827106wmm.18.1684152543010;
        Mon, 15 May 2023 05:09:03 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b003062675d4c9sm32285269wrn.39.2023.05.15.05.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:09:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sui Jingfeng <15330273260@189.cn>, linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org
Subject: Re: drm/ssd130x: Fix include guard name
In-Reply-To: <ab3a2467-2236-604f-b4aa-862a7ac838e9@189.cn>
References: <20230512120232.304603-1-javierm@redhat.com>
 <ab3a2467-2236-604f-b4aa-862a7ac838e9@189.cn>
Date:   Mon, 15 May 2023 14:09:02 +0200
Message-ID: <87jzx9aja9.fsf@minerva.mail-host-address-is-not-set>
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

Sui Jingfeng <15330273260@189.cn> writes:

> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

