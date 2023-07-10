Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE7F74DBC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGJQ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjGJQ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E17120
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689008244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LoMYW18vJXNHTEpLoz7+gRHmG7+n2OVYuQI+lT5sFFc=;
        b=H9X1mjka61Niw6KLjiFvEMGgVENnLVbv2f0XyovwHdub+rlPiEaaGPjM/qd7DBs9xWcVu4
        1s/MwqV1vIdMnViadFZYUDlFSMCM52vKPrz168ZXceEPsmieatAxgIihwfPUo9Ua3tH8+C
        QbSfk+mzNU/OmBubVZ9Ox+y5M7Cr4NM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-uYRseehcMzerRwcj6_GZrQ-1; Mon, 10 Jul 2023 12:57:22 -0400
X-MC-Unique: uYRseehcMzerRwcj6_GZrQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fbefe1b402so29060845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689008241; x=1691600241;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoMYW18vJXNHTEpLoz7+gRHmG7+n2OVYuQI+lT5sFFc=;
        b=KTvj1hmv5bZy67btmG/NFzLHg+8gzEfo5SLNwaM2bDSM0sFcoEpVjHoMOuHmansi7o
         Z6MowAIaH7Zz7iLJiEdpapPbrmXArsLXC50WHnudKbr1YSzwQQnElLye4juunCtaDwUO
         i07LXUX4WL4XaCbeI84zEyftvEfIs9YzrRVtYuQIjHZFOB+u45vPL1xp2ekdY23YtdWH
         8ZxlI/vJd2IK/xzop2ipz4FuQFCVVXU+RNrO5Zcdn4gOdcQ9ywGmmVEcvKZpLUpBGq9p
         MSYTEso2JvStmVfKdPSA1aoqSZxYYlsMACsjMpRry8yldyqApIi6fPj3m/XbO08L2vxQ
         YjNQ==
X-Gm-Message-State: ABy/qLaRJGmgmjxSJoXDSwOhqX+V8u6FyhcDf7nqH7xacvsCS8ZWtdl0
        oIRssvFELhJk3i2uGzlrwn/Rvik+6BlE7VsstD8TZ8obHrJY9C3ImzS08MaRuak/CrGnxBvGX8A
        ns7fg0I7cmSLwcQUgJtlfVZvixSlTzoDX
X-Received: by 2002:a7b:cc8c:0:b0:3fb:c9f4:150e with SMTP id p12-20020a7bcc8c000000b003fbc9f4150emr12567343wma.14.1689008241247;
        Mon, 10 Jul 2023 09:57:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFRVXM8MQjD6Rt1Xe3hVa5sE1tXAMtUEmjJjoeOSg1/3Qfhceud+AVl4CyG2DAeeUsngsKBog==
X-Received: by 2002:a7b:cc8c:0:b0:3fb:c9f4:150e with SMTP id p12-20020a7bcc8c000000b003fbc9f4150emr12567331wma.14.1689008241005;
        Mon, 10 Jul 2023 09:57:21 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c5-20020a7bc005000000b003fbdbd0a7desm10780652wmb.27.2023.07.10.09.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 09:57:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 3/5] drm/arm: Make ARM devices menu depend on DRM
In-Reply-To: <ZKRE0T-3Mbht8HZT@e110455-lin.cambridge.arm.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-4-javierm@redhat.com>
 <ZKRE0T-3Mbht8HZT@e110455-lin.cambridge.arm.com>
Date:   Mon, 10 Jul 2023 18:57:19 +0200
Message-ID: <878rbniu1c.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liviu Dudau <liviu.dudau@arm.com> writes:

Hello Liviu,

> On Tue, Jul 04, 2023 at 01:05:27AM +0200, Javier Martinez Canillas wrote:
>> Otherwise if CONFIG_DRM is disabled, menuconfig will show an empty menu.
>> 
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
>

Thanks! I've pushed this to drm-misc-next since is really a fix that's
independent of the other patches in the set.

> Best regards,
> Liviu
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

