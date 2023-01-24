Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57306794D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjAXKLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjAXKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089DA3FF23
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFDK+kFH8HIC/TzW1KCoOg355Vt7UsVPru6vlXZw2AA=;
        b=CmgRs52nhypwnNj4ZKoZn0+MCMoHb0cjGVkvV1S7Jo4E/roOg9S1Zm4qqcCW0HzPqn+muT
        Xa0ZI8j+orqhpDhZ/9EPQGPf3lznnp17T2RP1OoCTRzDoKBU8nsDkLp2o6AqBoOZrWGt4B
        gvoiwVLoc4ZvnY7Gn/3py96ZltZN1ZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-3v8Jb3ZHMpSkOVWCmlSG8g-1; Tue, 24 Jan 2023 05:10:03 -0500
X-MC-Unique: 3v8Jb3ZHMpSkOVWCmlSG8g-1
Received: by mail-wm1-f70.google.com with SMTP id l31-20020a05600c1d1f00b003da8b330db2so498168wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFDK+kFH8HIC/TzW1KCoOg355Vt7UsVPru6vlXZw2AA=;
        b=GnQ5BYDWkH1W6Ij9WjRPGYmMqbpiG5g7DnMgTD0Yrf4YGmeQifcUb3K9iFNJqM34wZ
         tOlEVhqN7GyVTPj45LMXZXtABktWNen72oM4ENqf8vPiJ4MODoE8KDB+OVhpvciSsJ75
         ZOZOtzJJdVmL84toyuOSc6mMJQruqEiu2h/QiJDsuuvAntSkzCEMClYScOpMymSUUiS1
         jVquXCTUIwm/kOickHYGpZasZLXHfNny3KFoccrCoiJCHcAct++PfO1nIw8CMxreZhBS
         PugTW/J/ucTz/qjHgXhHLvZkQ5mPwIGSCMJig6/UfoHnRxRsVNv72KU0dSMP3R6P0kH1
         LylA==
X-Gm-Message-State: AO0yUKV5RyQw237cwD5HhBsJmvo4K0IWD807pO9Jy/1zIplsTdAhSZ5j
        C8CXnNLRQIwvcwWVH/KEgEoSurvv+CCQk0yfPqKiQ7sdkYGnPunkpl8WVje+hbAvEJilOdQClZ+
        ZexT/gXGhjfIy3ciDffpNGyLkOceXSDJiaC4FQBJxQTWrAg1Ngcd1AnhRQycnyo7cI3OtLIRine
        Q=
X-Received: by 2002:adf:ce04:0:b0:2bf:ae15:5950 with SMTP id p4-20020adfce04000000b002bfae155950mr2064124wrn.20.1674555001494;
        Tue, 24 Jan 2023 02:10:01 -0800 (PST)
X-Google-Smtp-Source: AK7set8JCDaZ6+VVJYdKA3bFSsDgu6eawmj4lpdDSlBDI/rz3pyQULfDuvWJ7TNd2EQjXNI5XGujFw==
X-Received: by 2002:adf:ce04:0:b0:2bf:ae15:5950 with SMTP id p4-20020adfce04000000b002bfae155950mr2064099wrn.20.1674555001179;
        Tue, 24 Jan 2023 02:10:01 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d604d000000b002bddd75a83fsm1538673wrt.8.2023.01.24.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:10:00 -0800 (PST)
Message-ID: <03881b6b-baeb-0e23-5e5d-e625b52366bd@redhat.com>
Date:   Tue, 24 Jan 2023 11:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/3] fbdev: Remove unused struct fb_deferred_io
 .first_io field
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20230121192418.2814955-1-javierm@redhat.com>
 <20230121192418.2814955-2-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230121192418.2814955-2-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 20:24, Javier Martinez Canillas wrote:
> This optional callback was added in the commit 1f45f9dbb392 ("fb_defio:
> add first_io callback") but it was never used by a driver. Let's remove
> it since it's unlikely that will be used after a decade that was added.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Pushed this to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

