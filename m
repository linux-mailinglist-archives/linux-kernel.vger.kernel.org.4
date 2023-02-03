Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA52689310
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjBCJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjBCJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:07:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61908B76B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675415192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhKCB9KNSzkYHejsdvcNaStCQTPERBmDcFyhTdzuPeU=;
        b=VXsC0qLq5Rd3quS7bkbz04iy9kiFnG5NOrGCmPhI4S1+sU+FX9pJyDfyXs7+nKn0TEGvDp
        +O9yioULkETCJh3Wr5btAwgKEEGtb4gjLfceyOMtrhr9d4aB0AexJT+D39HKQVVlQBq5F4
        YSq5lcIe4Sb7aawLcx1VPgmKrcsrHt0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-DbZCB55-NguvOp__j8eh5w-1; Fri, 03 Feb 2023 04:06:31 -0500
X-MC-Unique: DbZCB55-NguvOp__j8eh5w-1
Received: by mail-ed1-f71.google.com with SMTP id d21-20020aa7c1d5000000b004a6e1efa7d0so2929333edp.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhKCB9KNSzkYHejsdvcNaStCQTPERBmDcFyhTdzuPeU=;
        b=4Pjb3d2wQv/sWQ+KydfcsXsVIG4nktcW+kJ22GlKj8JGdxwgStLlt1yTKXLRCnPCXs
         DdzIM5oskXNM8Rpjlm1/zOnbEouiR6sSe/v7JrNTPkfe89fBcdjW1u3A4ZMkvtEFVBke
         AKeteBsOmhmTF2y5gDnlslYbF6PGMG2AnKCJ7GY92gSgTQhqOR1UPITQDi3f2mF6shy8
         i6Fl3MyIip4pGYE9/x4A187njK/2tswOamCf7VwTRidyUGoDzz9cZq0UxfU9BcJtVTqW
         Y1TAEkN8ne9SxSx0Lo4zbF9VZUxeKRphI+JQLIt/m/Pc3cy4ATseCqQFgnAOJA+idjbL
         qENQ==
X-Gm-Message-State: AO0yUKWL+wb7n7coSdc5FkhoebPQQQWNHWVvQlWbOUJfqiKmh0EAj6av
        EYRv4tpGd35W0wyPfgokpaEPL9z+B//oxcq/Evu1mzSMxHv8Q2h5jddgRJBjyl1sf+AiQljD189
        Vnbr0Nm7hm2WvjsK1+UZtnRv9
X-Received: by 2002:a17:907:3d87:b0:88f:9c29:d232 with SMTP id he7-20020a1709073d8700b0088f9c29d232mr1301121ejc.57.1675415190053;
        Fri, 03 Feb 2023 01:06:30 -0800 (PST)
X-Google-Smtp-Source: AK7set/BNOT1dSdb1YhVnB4GNaZNhLGEVrN6r8pdC7z1PqJ3/f3nOok0MNZiqSQoHXK2GDx/GWc/gw==
X-Received: by 2002:a17:907:3d87:b0:88f:9c29:d232 with SMTP id he7-20020a1709073d8700b0088f9c29d232mr1301112ejc.57.1675415189939;
        Fri, 03 Feb 2023 01:06:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709060ac500b008806a3c22c5sm1076367ejf.25.2023.02.03.01.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:06:29 -0800 (PST)
Message-ID: <595e91e0-ae13-471d-2685-5d8f3a49b31c@redhat.com>
Date:   Fri, 3 Feb 2023 10:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230203083313.53745bdd@canb.auug.org.au>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230203083313.53745bdd@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/23 22:33, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   95a579b5c89f ("tools/power/x86/intel-speed-select: v1.14 release")
>   19aceabd7a26 ("tools/power/x86/intel-speed-select: Adjust uncore max/min frequency")
>   75ade1b46b8b ("tools/power/x86/intel-speed-select: Add Emerald Rapid quirk")
>   a06644c7dc9b ("tools/power intel-speed-select: Fix display of uncore min frequency")
>   113943d71f54 ("tools/power/x86/intel-speed-select: turbo-freq auto mode with SMT off")
>   9bd3f4d5ca2e ("tools/power/x86/intel-speed-select: cpufreq reads on offline CPUs")
>   61246ca53e17 ("tools/power/x86/intel-speed-select: Use null-terminated string")
>   e5bf2623cf49 ("tools/power/x86/intel-speed-select: Remove duplicate dup()")
>   1bf2637725f8 ("tools/power/x86/intel-speed-select: Handle open() failure case")
>   1fd93ae6e2b0 ("tools/power/x86/intel-speed-select: Remove unused non_block flag")
>   74ea37879c89 ("tools/power/x86/intel-speed-select: Remove wrong check in set_isst_id()")
> 
> are missing a Signed-off-by from their committer.

My bad, these came from a pull-request but then I had to rebase them
making me the commiter. I've added my S-o-b to these now and I'll push
out a fixed for-next soon.

Thank you for catching this.

Regards,

Hans


