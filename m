Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E477070631A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjEQIkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEQIjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9402A5FCC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684312707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Awr4gRZsdLGQYIUyMmed1KNNdKfsJvua5DQtUGISNWs=;
        b=MqHG5BpfI8qvxqz7vMrs9GpP4ySJL25p/YLts7AbgHvUVW/o6AOf2qQQlxPgvXogVYiH/k
        oNGCzA/FOa0b6XprnaB+VvgBvkQ4MLsmVgM7JJF15IQpW/yY82+OzQ/R2qaaIEzlzxdG7T
        A6ATmg7OF3GlNKbYWHeT/x9EThTWnRc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-fSr8Au8DNkKWLDbeuBJlxw-1; Wed, 17 May 2023 04:38:26 -0400
X-MC-Unique: fSr8Au8DNkKWLDbeuBJlxw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f33f8ffa37so1777275e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312705; x=1686904705;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Awr4gRZsdLGQYIUyMmed1KNNdKfsJvua5DQtUGISNWs=;
        b=aIlLzsgari/tU7xUh6TzSp22utCtAIzQWNfrqBr5QLjDNRWLHTAWA4Hpn4deebFt+9
         bNkVbKP65AnrkjG9PQ3RfMjCsZm/lkWLV2FVMnXCnL+IsEKyqE26mxmret9aNTSIQqvX
         KYkRuAsvxRMqIFDwuR8jKugFiIjpOKRDae1QhjqtpExRtR3WWEb0EFN25sGrDff9VD1I
         62Gc1sPZrVI0w9fhKXF91AyHRP3QgYX9dGWWby3AJDmPxz1iVUb8TG84tTnld3mLo01/
         BDYsqaHGdrTAwq7XMCrGwCp1jCVSXVwJzJyGL7K6b6T4nkB9FvA4YXH6yoLoMquEjRVI
         5hQQ==
X-Gm-Message-State: AC+VfDxmAXUwK9ZgCTpJ5MW4+QPBRzO7hJPt8ZgC/o/1vqoQNvXoJgMG
        OyPRIC5Lft30U2djNOH9Bir4pm0Uz9uJnJgQZ+3ZlrZxMkQ92cetLT95ji5qOq3PkYicOYTxuPw
        LILIwn0XTRCSmpA2Ypqd6ZY5O
X-Received: by 2002:a05:600c:296:b0:3f4:1dd9:e9e4 with SMTP id 22-20020a05600c029600b003f41dd9e9e4mr25183081wmk.4.1684312705171;
        Wed, 17 May 2023 01:38:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+xQB/WwSfZGlVBWz3pf1X3XrZ6616+LvJs0buY0t+QlE+UE09KziCsrhgVjdn2XBjNLyu9g==
X-Received: by 2002:a05:600c:296:b0:3f4:1dd9:e9e4 with SMTP id 22-20020a05600c029600b003f41dd9e9e4mr25183070wmk.4.1684312704870;
        Wed, 17 May 2023 01:38:24 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y26-20020a7bcd9a000000b003f42a75ac2asm1536196wmj.23.2023.05.17.01.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 01:38:24 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        suijingfeng <suijingfeng@loongson.cn>, liyi <liyi@loongson.cn>
Cc:     loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/drm_atomic.h: fixup typos
In-Reply-To: <20230517082322.3230271-1-suijingfeng@loongson.cn>
References: <20230517082322.3230271-1-suijingfeng@loongson.cn>
Date:   Wed, 17 May 2023 10:38:23 +0200
Message-ID: <877ct79wu8.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Sui,

I would still add something to the commit description even when your
changes are trivial.

Sui Jingfeng <suijingfeng@loongson.cn> writes:

> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---

The fixes look good to me though

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

