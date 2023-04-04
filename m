Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B558D6D5EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjDDLJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjDDLIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC9735BE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680606375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13WWdn1CKTzFzc+LsesKqq+DZLEoqqRMtewjbJUhOYg=;
        b=MvFu+deuAYfsl3CkbOJJRxh3bbtyiPLI5bdUiW4e4UkxPBKko5sjskH+81gJzRR/5Gk+R7
        k90+hzW+UqCopSnCniI28UpYeoBBcU/13bSCFDxXog7HL8f/gSmHbbrAQlmGd48d5sETRS
        XihhryJjKUbk/rnxOVx/fs1B5EXd4Bg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-b2dl4i-2N921683nzHapjw-1; Tue, 04 Apr 2023 07:03:03 -0400
X-MC-Unique: b2dl4i-2N921683nzHapjw-1
Received: by mail-wm1-f71.google.com with SMTP id h22-20020a05600c351600b003ef739416c3so11141695wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 04:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680606182;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13WWdn1CKTzFzc+LsesKqq+DZLEoqqRMtewjbJUhOYg=;
        b=U+HO7n8Z+tG291QAVfBVT4SN3AwF6qWxPb+s+yUwmBnCqQeJTgbN7lf5CcMPnhjDR5
         qQzIXlDpwueteWy11pq2l0Y+RqjQKYzPVY1eQlmmWYHiN8Y+BXPuIZRrXIWxLNM8LeAM
         mJWnXBW4DhIsQUcRjG3iwxWU4bdLbGtYgJqkVlglKGxxM1JwJGzl1knNnNFeIWfpF3eO
         ipz8V6IvZTfQNV41tP+pVQMRGGuvYOzd4PbSnyxT+KbZWc7gb0k5msINma84W5wLnE5p
         kz407xnMmobmzNbVJPcRz0z1pRpGub+uNbPw+AnndhksNNORdYct1plL/WNU/sQvu2dq
         +IsA==
X-Gm-Message-State: AAQBX9e1BbOJnRBhk94upt1lhHGirY8bcS9zcEazZpJbwwYyEfObZ0qE
        Pwbz/Z5dcx9ucwCcHfX8BpTjuQre2rcx5a3/1MRzDKFynLJfpOW3HaPMufTJYSYq2t6K79n7LTY
        CYJC5E1dJJMYD4YOvKiSGi7kw
X-Received: by 2002:a05:600c:450b:b0:3ee:9652:932 with SMTP id t11-20020a05600c450b00b003ee96520932mr15688900wmo.12.1680606181920;
        Tue, 04 Apr 2023 04:03:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350bZe97z66nGDbGC4iLvwGvTU+YVGSsMC3kGyTmdIJ9mqYGQOg24liH7lcGvttolkuPS/0R1tw==
X-Received: by 2002:a05:600c:450b:b0:3ee:9652:932 with SMTP id t11-20020a05600c450b00b003ee96520932mr15688890wmo.12.1680606181666;
        Tue, 04 Apr 2023 04:03:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003edf2dc7ca3sm14882758wmr.34.2023.04.04.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:03:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Christian Koenig <christian.koenig@amd.com>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/aperture: fix typos
In-Reply-To: <87355fex1f.fsf@minerva.mail-host-address-is-not-set>
References: <20230404040101.2165600-1-suijingfeng@loongson.cn>
 <0ad03743-0224-b154-a149-e3e4d54b252d@suse.de>
 <87355fex1f.fsf@minerva.mail-host-address-is-not-set>
Date:   Tue, 04 Apr 2023 13:03:00 +0200
Message-ID: <87zg7ndi57.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

[...]

>>>   	/*
>>>   	 * Remove the device from the device hierarchy. This is the right thing
>>> -	 * to do for firmware-based DRM drivers, such as EFI, VESA or VGA. After
>>> +	 * to do for firmware-based fb drivers, such as EFI, VESA or VGA. After
>>
>> That sentences is not well phrased. Maybe say 'This is required for 
>> firmware-provided graphics, such as EFI, VESA or VGA.'
>>
>
> Graphic drivers or display drivers would indeed be more accurate here. But
> I think that "fb drivers" is still well pharsed since the are other places
> where either fbdev or DRM drivers for firmware-provided framebuffers are
> named like that.
>

Sui,

Maybe you could post a follow-up patch to improve the comment as suggested
by Thomas?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

