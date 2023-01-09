Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2688B6624BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbjAILyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbjAILyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:54:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B0712083
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673265194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZT+C8iVlMW2cC5v0WiwtfPl4IXfefK4BJ9hDx37N9LU=;
        b=i4yMLNOdi90/qwZxFPOLO30MFDDzAVdjo22fOi4BmPQUUBR9bts6Qu3aNZw73Wuc9UMeUz
        /M/Is1gZTZKZiJKmZvHNLjCABKvOtBWj+9R5ROA5XFm2TCSiBKjo81YnLp3lnqA9SrndKZ
        vctwZ9Vpe7in96VfuYvMluKBW27A/lA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-fjQ1LdPVPSyT0X3Bx7MlPg-1; Mon, 09 Jan 2023 06:53:11 -0500
X-MC-Unique: fjQ1LdPVPSyT0X3Bx7MlPg-1
Received: by mail-qk1-f200.google.com with SMTP id bp6-20020a05620a458600b006ffd3762e78so6335925qkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZT+C8iVlMW2cC5v0WiwtfPl4IXfefK4BJ9hDx37N9LU=;
        b=ctkw8h6fAPmN+WJEvsPMWxb1/3zVmZMYctD+XMimORKRPizoVElZUEEPQ9FEXq4vDv
         n67Rfc2XJgyCTgBmjIbO6zcIZ+DZkE5WmZuEHnUeCxZB/MDz0eg6CjwQVuEku0sBJsYo
         uqMUrPBMroQkCRE6LiPUIF/BwLsCM03kEL90MhrXEVYD592W47uUOEutVk1hAgTwrZRh
         ic8SEzBDSyihKFmRzlG1NXdeqUlKL1ZhFibz3MqRR4To2C0pBtm2Mjc4ntaT8Cc9u7t+
         Czuecru6aYzi+3DTZyjYS8YS/JhdHizoaftrtk0xMVRiYaRs/9kAqCJCQFVFNgKVs5rP
         7kUg==
X-Gm-Message-State: AFqh2krtinIvvUSgQUXN9hvBuXONmsxg1YzsURpc/fBq7JQqXXBPqne5
        dpKrn30Fkl3Czyb+CMS8ecwzpqELXAzw15HIYzGkgm5UmtzXKRdASPKsg+BN1z0f3+DAWYfOBPh
        CDvrjrXaexVHVwKR01eDj04QrP7rGxzJnOodEhpNM
X-Received: by 2002:a05:622a:2282:b0:3ab:c8c6:51ba with SMTP id ay2-20020a05622a228200b003abc8c651bamr731551qtb.597.1673265190904;
        Mon, 09 Jan 2023 03:53:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsAv8CBtPDy6ySW2hwbwq/T3ofuZmSkH3vcnnckU1rf3jtPGqFKt6eK17aWte1O2YYiK22atrD351JpSj7wAPo=
X-Received: by 2002:a05:622a:2282:b0:3ab:c8c6:51ba with SMTP id
 ay2-20020a05622a228200b003abc8c651bamr731544qtb.597.1673265190648; Mon, 09
 Jan 2023 03:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20230109021502.682474-1-koba.ko@canonical.com>
In-Reply-To: <20230109021502.682474-1-koba.ko@canonical.com>
From:   Vladis Dronov <vdronov@redhat.com>
Date:   Mon, 9 Jan 2023 12:52:59 +0100
Message-ID: <CAMusb+SK3SPOijFw2wkivXQbhaJfe1Fhd0XNNv95soZdBP4eRA@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp - Failure on re-initialization due to
 duplicate sysfs filename
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This looks good to me, thanks, Koba:

Reviewed-by: Vladis Dronov <vdronov@redhat.com>

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

