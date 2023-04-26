Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC36EF090
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbjDZJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbjDZJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCEA40DE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682499580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3fBb63lE0NdO6K08wbAb+sUNpRZJ7AhFNrVK+l26Xw=;
        b=GXlS4ehAf1eEYTa6wWxto5yob6vv6l8+Cn0lhmjpS0q0/mltzz67xtRzz8t5boFG7fMpOO
        5Fc1Ggrs5M52GAkrIsMrQ9f3pXe7RhX2nHKy5TV1/WlYZLB7di+1761/3tOZlOt5s5g2/6
        AWkqNG9VyZX1Y4xIlvRajl+i1yLiOMw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-LU4qUl83P7enHTtU8jrh_w-1; Wed, 26 Apr 2023 04:59:36 -0400
X-MC-Unique: LU4qUl83P7enHTtU8jrh_w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-505149e1a4eso2925099a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682499575; x=1685091575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3fBb63lE0NdO6K08wbAb+sUNpRZJ7AhFNrVK+l26Xw=;
        b=DAisW7vjdRiSa12muyjDuEtMzhh7RDykccXrxZGlcTMrFk+ZlnZlZSytTxbzLPwvyO
         4c8cJcocT1/EVoH0Pv2MthgwRamfMcVMAK4ZT+mePFzMPJqpF06sGgJ5siW9CrGG+vF1
         8+1AUR+gTYabahCQ8Ftm8sM+Qy6osYjN+l4p9DMdlsFLBHnNkF5JRg/lgoKOe/T4uJkF
         qI9uVO7Izz1g7OLAOSMh/3ZdUCWWiv2GofNvaCpZcufMhbFC0o4Ahtx3T4Zl3cuIy0ew
         A+u4NZ0G2efrPtLlg5tAD0HMaDn36vEMaFgBq+DDc1dFfor2ZsFU7h3O1XYPsFprx1HU
         bLNQ==
X-Gm-Message-State: AC+VfDyh9/tgV7ibG52PJ0iswZvqSekmkf36niKo8SkC1oFqP94muyka
        UBBBnXWmYOi6iM68T1/0acaNKNi362A7dbMUOSGMwxZHIN7bwbWM2Fc21lAlMH3dp4eA9r5wH3z
        7uwJz+/J3sKUxArsFNiIHz57XSyLx8CTJ
X-Received: by 2002:a05:6402:50cd:b0:504:77ed:5a33 with SMTP id h13-20020a05640250cd00b0050477ed5a33mr1433498edb.8.1682499574946;
        Wed, 26 Apr 2023 01:59:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5E4YUPH6KUsC/YrJcqjdZonZ+2wpE9ht7ygVt3UseyqI98eMH/6X68EG/k6xQyfw3gCFXChw==
X-Received: by 2002:a05:6402:50cd:b0:504:77ed:5a33 with SMTP id h13-20020a05640250cd00b0050477ed5a33mr1433493edb.8.1682499574687;
        Wed, 26 Apr 2023 01:59:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d21-20020aa7c1d5000000b005027d31615dsm6408138edp.62.2023.04.26.01.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 01:59:34 -0700 (PDT)
Message-ID: <c2d0c706-e006-6c2f-8fe6-ea20a745ddd6@redhat.com>
Date:   Wed, 26 Apr 2023 10:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Function of the camera key on windows
To:     Jonathan Singer <jes965@nyu.edu>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <MN0PR12MB6101D9688E7904FF52634520E2649@MN0PR12MB6101.namprd12.prod.outlook.com>
 <20230425210953.14597-1-jes965@nyu.edu>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230425210953.14597-1-jes965@nyu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/25/23 23:09, Jonathan Singer wrote:
> The key itself triggers a hardware response both on windows and linux.
> It disconnects power from the camera USB module and raises a cover in front
> of the camera aperature. The keycode is as far as I know only to notify the
> operating system in case it wanted to show a message.
> 
> Is that the kind of use case that would benefit from emitting a KEY_CAMERA?

Actually we have SW_CAMERA_LENS_COVER for this and this is what
new Dell laptops with a similar feature use.

The problem with using a SW for this though is that we should then either:

a) Figure out a way to identify models which will report this; or
b) register a separate input_dev just for reporting the SW
   on the first event.

This is necessary because unlike keys where only press + release
events really matter and if those never happens no harm is done,
switches can be acted upon by userspace in both there open and closed
state, so the mere presence of an input_device with a SW_CAMERA_LENS_COVER
may be acted upon by userspace. E.g. if we by default report
SW_CAMERA_LENS_COVER=1 (so lenscover closed) then apps who want to access
the camera may ask the user something like: "Your camera is currently
unavailable, please press the keyboard combination to enable your camera"
which makes no sense to ask on devices without such feature.

Note that simply registering a separate input_dev for just reporting
SW_CAMERA_LENS_COVER on the first event is a good workaround for
this though. We already do the same in other drivers for SW_TABLET_MODE
for similar reasons.

A second problem is that we would need to be able to tell if we
get the 0x1A event because of the camera being enabled or disabled,
but perhaps this info is already present in the event_data ?

Regards,

Hans


