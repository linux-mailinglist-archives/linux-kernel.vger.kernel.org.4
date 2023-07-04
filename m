Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07B746B42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjGDH4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGDHz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBE610CB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688457283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKrB5YS08GogmNSu7Y0RQRA2Szw+Z40s1lTL+YoBbo8=;
        b=B1JCrY73CrV3nmTyA8Xv2L5RnrSmYenblr1SAhitvUDw1J7CKuWUn9t4tVoVhgM06LXeH2
        5j8wDKz9aaqxXELIxEX1hTDJVW7g3SlDU+UQJGuyKIiO9hHeZ/g/t9T0IAf6OcFnk0ckdD
        O113PHcPaRacxiRGFCTxELbIR9T9ZDQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-f4-EWC4hPIq0H1LviBhDVw-1; Tue, 04 Jul 2023 03:54:42 -0400
X-MC-Unique: f4-EWC4hPIq0H1LviBhDVw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4edbdd8268bso4899140e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457281; x=1691049281;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKrB5YS08GogmNSu7Y0RQRA2Szw+Z40s1lTL+YoBbo8=;
        b=I+gJJ+782Q6XlaIbhlYvospfZkuDXr7oJxg9GHfU+D/2RSiaJ34nwOTUsJVIZVO357
         CHsa/iZTV0pKpNHaKTpwHhG2rP+1ZflNMEL7Qbl9nhsfwu5BxhOSny52N8SIl9H7nGb6
         4BkNbw+REvjOVFmzayt1XSnlaAkWa5khoQ9Rjnq9B+pstnAeBDIF9Fd6TTTHtcCfho8S
         XEGN/fufocF8EHDY9HEpJf7N12TzEatJjJj3txyFW9a67dEcrmSTCvPBup9ZsM/mUNXb
         m/mqcK1r6kJsI7BjOS2Vl+ZZbKaHnA0EwvsOGVAzZkhrzY3x/0f7ih8ZKqwjnh25cGZq
         F3Vw==
X-Gm-Message-State: ABy/qLYocDqaIK3FcOT/bIRcDzJ1O1CBNxNtSl/wsDW6z/w05D3aHdMK
        GgOdA/MV1Mwqlm4TpzVg7smc1RcRwFIzORxwiXa1G9WYTTTim0WME6895g+X6RlliYh148Qga8I
        2iXK9ZrcD0RZg8AQcD50LSLwF
X-Received: by 2002:ac2:5f92:0:b0:4fa:a0c3:efa1 with SMTP id r18-20020ac25f92000000b004faa0c3efa1mr8124395lfe.7.1688457280934;
        Tue, 04 Jul 2023 00:54:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGv5H/b0zhH/dQl8i//ZbCh57DUE2bTT97eL1Mf3dlGQfF99dJp+Ktbu5zRXTh1sOMdVeb8dQ==
X-Received: by 2002:ac2:5f92:0:b0:4fa:a0c3:efa1 with SMTP id r18-20020ac25f92000000b004faa0c3efa1mr8124377lfe.7.1688457280294;
        Tue, 04 Jul 2023 00:54:40 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c230700b003fa968e9c27sm24443386wmo.9.2023.07.04.00.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:54:40 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 1/5] video: Add auxiliary display drivers to Graphics
 support menu
In-Reply-To: <CAMuHMdXRg1OUy6UHuH4H+qkK-qO+jTKdVoG_SRM3q_PkyD+Bbw@mail.gmail.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-2-javierm@redhat.com>
 <CAMuHMdXRg1OUy6UHuH4H+qkK-qO+jTKdVoG_SRM3q_PkyD+Bbw@mail.gmail.com>
Date:   Tue, 04 Jul 2023 09:54:39 +0200
Message-ID: <87h6qkyuv4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Javier,
>
> On Tue, Jul 4, 2023 at 1:05=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The drivers in this subsystem are for character-based LCD displays, which
>> can fall into the same category of the DRM/KMS and fbdev drivers that are
>> located under the "Graphics support" menu. Add auxdisplay there as well.
>>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Thanks for your patch!
>
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -30,6 +30,8 @@ if HAS_IOMEM
>>  config HAVE_FB_ATMEL
>>         bool
>>
>> +source "drivers/auxdisplay/Kconfig"
>
> This is inside the "if HAS_IOMEM" section, while there was no
> such limitation before.
>

Gah, I missed that. Thanks a lot for pointing it out.

If I move the source outside of the if block, are you OK with this patch?

I think Thomas is correct and would make sense to put the character-based
drivers next to the DRM and fbdev drivers since all these are for display.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

