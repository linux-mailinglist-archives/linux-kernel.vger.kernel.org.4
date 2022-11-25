Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89472638847
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiKYLIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKYLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92534D5D5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669374432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFEngP0X3fPVq5kw5eVn67kkqccTP4KFzznQM/5adG0=;
        b=SDLlhCwOwSCkcupD4WEW2uhORsI/zjNFs8LjxH8lnfDoI+iYsZLGuhE1COWydWFwlXN5N6
        ueCYoNFljJY1mwyKGjXfSdOOsYmn3EK7fDm9S3/zkTpO/gwljupa8YEhC/yf9I/mLs5aG3
        WZ0QViiSFLaPDpvd7EVykKYQtXvWzAo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-tVMIIkpHPJu4lsqtKUwLNA-1; Fri, 25 Nov 2022 06:07:10 -0500
X-MC-Unique: tVMIIkpHPJu4lsqtKUwLNA-1
Received: by mail-wm1-f72.google.com with SMTP id az40-20020a05600c602800b003cfa26c40easo3817543wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFEngP0X3fPVq5kw5eVn67kkqccTP4KFzznQM/5adG0=;
        b=UvOFU0o0OvwyBAQON5H8NiDFLLKxz2ue3MApX1r8eAzmJN1SmPNmw1PdrIC5oj07j4
         bzZaokdhHJt8SjnRwPy+j9TVloPBt2ZcRR5S0sufKQV+OQOQvHSE9iHb/4SbVNNiNYTh
         Ss0l5WHA+zDnvdR/7AsCHi+HVHxw5fDhq6hkn/YrATbb3e+c8BuSBGwIaFs+S2wnuPQs
         KLTggLWBzh3K6aD0r6QQ/joRxnP+Zb500Nrik9nl1Khh5u6ljrGmx4Iqy3SgFSBLvAhK
         enTP8jhNaIiXRzAfi5tQ0qVnH+IRPpr1ChJE8WSGaq+bVdrtntHJ4oWQsWd0j63Dft4Q
         E4Cw==
X-Gm-Message-State: ANoB5pnWfP0JvfzzfjeL0XJP7QpF9ZDuuLxAJbnTsVGr8BAufrZZK6Yi
        Cbyguixa4S+G6Pp74ho+2TCwGQQ6VH08zRmIObGjiL8B5msoICguUKgx4tsgOBww1NhJ9QTn9U/
        gi28BTNEAXMs3faXwB9YRJcr8
X-Received: by 2002:a05:600c:4e4c:b0:3cf:87c6:890b with SMTP id e12-20020a05600c4e4c00b003cf87c6890bmr27851418wmq.194.1669374429209;
        Fri, 25 Nov 2022 03:07:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ekFpSGBe1M+kDVda3TnzsIFkEcOgKcp7ocT5w3PpSZSU0krdQ+qq0patBmQZVNGkBmTCp8w==
X-Received: by 2002:a05:600c:4e4c:b0:3cf:87c6:890b with SMTP id e12-20020a05600c4e4c00b003cf87c6890bmr27851391wmq.194.1669374428951;
        Fri, 25 Nov 2022 03:07:08 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id co29-20020a0560000a1d00b00236e834f050sm3703836wrb.35.2022.11.25.03.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:07:08 -0800 (PST)
Message-ID: <90c712ff-c5bb-ab44-fb1e-fcf7b055e908@redhat.com>
Date:   Fri, 25 Nov 2022 12:07:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 14/24] drm/vc4: txp: Reorder the variable assignments
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Gow <davidgow@google.com>, linaro-mm-sig@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        linux-media@vger.kernel.org, kunit-dev@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-14-051a0bb60a16@cerno.tech>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221123-rpi-kunit-tests-v1-14-051a0bb60a16@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 16:25, Maxime Ripard wrote:
> The current order of variable assignments is unneccessarily complex,
> let's make it simpler.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
Much easier to follow indeed.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

