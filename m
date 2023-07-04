Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31AD747693
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGDQ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjGDQ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC310FA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688487993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3N/Gyf3beclIUSfPsZhAnE2wLloPptbf+HqX/lLqDWc=;
        b=fHw9FiyufPGlzK4AIgS0dgZSj76QR2FVKZvFvIluVIyEuP6f3F2l9lrIR/e7xDHUCo0DWG
        LtDrB9sZuGTrAaR8aaSfQoiN+gnQoz1dcDo/jLka8JWUNjX/woiMKkO0AMpZE+9Vz1vK2O
        XMYn5sTagth877zSew8hlnGG90Q13y8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-kNTqdwogM_qaG1iYPiyHew-1; Tue, 04 Jul 2023 12:26:32 -0400
X-MC-Unique: kNTqdwogM_qaG1iYPiyHew-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fb40d0623bso27146575e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487991; x=1691079991;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3N/Gyf3beclIUSfPsZhAnE2wLloPptbf+HqX/lLqDWc=;
        b=iRHFbgYkYZnnxdJvQq1Jdzt6T9jqI9F1TuJCTGkr7NyKGzEbYWGLkFKVVQBJJNF+Sa
         Aa2eTY5Y3FXtj2XLEwxh4ec2wIrWZRu5OKvbVBwymqj9CpxgFQ5NiVSMseQtjstG2zdw
         U3zrnU2JcEnHIAUoEngoe7ueGtMvNhURDWGg/l+TJzE7RlSO13fJjbMPWxOKgOKfCo5/
         3ugH+EWrPpJbk7zQKuHNXI5tG8L6TSVcFPR0M/wdtfJb+XCh0pVvd5obYZX4MQIudoKg
         lV1G6UcgHyIbQIcw3YPGiBcINl6P4MTryynoLiR/sQuWMHLduYJ94nTE8T12RmyKyyOh
         uOew==
X-Gm-Message-State: AC+VfDzmoTIWCmvgNDzsXsibqwXpH1YM61G4zuGEpxj6cyJH5LvGwD2u
        KRJ3nZEiIaZbePE2I5t+YfCSbtshYWhy52n8jjM4DI/FjZT+AU8eJ0dDY4SwHJblKQzS3x8VDXa
        aNeLUjDTRhSCPF7xqEevfvRX/
X-Received: by 2002:a7b:ca57:0:b0:3fb:af9a:bf30 with SMTP id m23-20020a7bca57000000b003fbaf9abf30mr12688276wml.2.1688487991011;
        Tue, 04 Jul 2023 09:26:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71ufTEe/wWv7h1ExOsJanD4siZOoua0ql6zTBm+MH4Z3jUb1+lMMqlPgaWI376xU4gg3rSqQ==
X-Received: by 2002:a7b:ca57:0:b0:3fb:af9a:bf30 with SMTP id m23-20020a7bca57000000b003fbaf9abf30mr12688259wml.2.1688487990852;
        Tue, 04 Jul 2023 09:26:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s25-20020a7bc399000000b003fa96fe2bebsm25398819wmj.41.2023.07.04.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:26:30 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 03/12] sysfb: Do not include <linux/screen_info.h> from
 sysfb header
In-Reply-To: <20230629121952.10559-4-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-4-tzimmermann@suse.de>
Date:   Tue, 04 Jul 2023 18:26:29 +0200
Message-ID: <87cz17lk22.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The header file <linux/sysfb.h> does not need anything from
> <linux/screen_info.h>. Declare struct screen_info and remove
> the include statements.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

