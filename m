Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ECB69DCA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjBUJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjBUJNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA84449A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676970782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9qPgJ9YfQaIBYxPeu9q0HF9PJcAGNOnIB/vKwxuzMc=;
        b=FXoGwlqvceIhU2EV6rhRmsmg54rAveasbGQYAwu0WX0XPlmJRyI5fJohkZGfwqJnr1TLEr
        exJjpmiX/5NGNuVI0zqvq6TQCvBCshnWxfTwMJL/EQCENUKIHLquAXUep47NZ97oA5ri8/
        rJShg3nV3UJmqlV3DuOIqYGuoIsXHdc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-gmJVqY7pOiemci-roDbbfw-1; Tue, 21 Feb 2023 04:13:00 -0500
X-MC-Unique: gmJVqY7pOiemci-roDbbfw-1
Received: by mail-qt1-f200.google.com with SMTP id e17-20020ac85dd1000000b003ba2d72f98aso1807054qtx.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9qPgJ9YfQaIBYxPeu9q0HF9PJcAGNOnIB/vKwxuzMc=;
        b=mbed7GAscQGObwBEMJw1vs+5Xc6nhnk160Ai4YiD70VuE8zSAEKI8TBOzNbAi250JZ
         pvg9v3Goo1/p0nZ4EEKy4qrgMEBNM4vaL6CMLCupx2R4sQkZ73m13KeWhXUqpIMo51lX
         QFU7lySYJ8XvRY9n7UiNmXyrfIdU7fkw3h2CuvvDNw8jvHdI8SPQPa7S+xqTWXwrd+s7
         fz0cW4oF2I4pdw70/0I1MDTgfzhWxZzt9kP2UB28mTFNpQ/P+yy0rEWbYyqScKG2XPSA
         lasW9OdxzK9A2DIHAT/nUP/GscU0yJ7VsdlFqRXzT6e8uqJIG/gKbgIupFZSBMPPLARz
         aapQ==
X-Gm-Message-State: AO0yUKWK7pgX7Kl7vaa5CWqz1SfzvckWU0IIfr3uzJMW+i6M22fk0Ek4
        AUg5vyXNX8vfvOPBujFqR1bbs7p5NGOtuuf9ol28hIn2Q5vexcbb20gVOK+v36ucFphDLuh/6J5
        1v2TbnwlRUAfTJXJ3EGTBBAtr
X-Received: by 2002:a05:622a:1387:b0:3b6:8ece:cab9 with SMTP id o7-20020a05622a138700b003b68ececab9mr9007220qtk.2.1676970780247;
        Tue, 21 Feb 2023 01:13:00 -0800 (PST)
X-Google-Smtp-Source: AK7set8kiVEBhsNJv0mZoYrOBkHxRKdqQSfVZHQqIki9/aW5Lspjg93ps58VyJ2p0giooT1AijNf/w==
X-Received: by 2002:a05:622a:1387:b0:3b6:8ece:cab9 with SMTP id o7-20020a05622a138700b003b68ececab9mr9007188qtk.2.1676970779965;
        Tue, 21 Feb 2023 01:12:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id y6-20020ac87086000000b003be56bdd3b1sm1966046qto.92.2023.02.21.01.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 01:12:59 -0800 (PST)
Message-ID: <815485547a20f80f6dce991b76a7b60aebf1a716.camel@redhat.com>
Subject: Re: [PATCH v3] page_pool: add a comment explaining the fragment
 counter usage
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org
Cc:     alexander.duyck@gmail.com, Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 21 Feb 2023 10:12:56 +0100
In-Reply-To: <20230217222130.85205-1-ilias.apalodimas@linaro.org>
References: <20230217222130.85205-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-02-18 at 00:21 +0200, Ilias Apalodimas wrote:
> When reading the page_pool code the first impression is that keeping
> two separate counters, one being the page refcnt and the other being
> fragment pp_frag_count, is counter-intuitive.
>=20
> However without that fragment counter we don't know when to reliably
> destroy or sync the outstanding DMA mappings.  So let's add a comment
> explaining this part.
>=20
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

# Form letter - net-next is closed

The merge window for v6.3 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Mar 6th.

RFC patches sent for review only are obviously welcome at any time.

