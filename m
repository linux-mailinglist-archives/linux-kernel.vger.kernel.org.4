Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022B270B828
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjEVI5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjEVI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCEF18B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684745736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPSy40Ik/lXr1edVRYw63Ydc2QclByRoU1Cs393xPXE=;
        b=NZSHLBvsEYljONPErPYZygHm9mS6RbhyjWMumcu/fkwBET3ZqcfXwMSeumxFrNsbigVU9A
        pI/7B8nB/sq8MKyWIe2za62letPyA9+ndt1OQjk6SeUYvx9h+/lgFMpmXLQDwBXwlpAS/s
        qr0c1dNqbSAWySnCRqNVWh0SiYDS+MU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-r3sQv8gpMUWrm5dzeS4y8Q-1; Mon, 22 May 2023 04:55:33 -0400
X-MC-Unique: r3sQv8gpMUWrm5dzeS4y8Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f603fed174so5239005e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745732; x=1687337732;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPSy40Ik/lXr1edVRYw63Ydc2QclByRoU1Cs393xPXE=;
        b=lziiAV9a4JPuUixxTQlWcdhjA3dGYHMARrAIaAJbtoIUwQsKDxBe1OKN6K/Sia79Jl
         xAVdKm8Tf9cViqopaCY6q6cENHO5BcewcGEMcl8OuL1EFmIk3hy8PqgRlxWt5VlVOg/p
         pc+4rjt/gkoTcze6gA15Vr/PkjA1RVBQZrYihd5wEK6BVvLijcCHiEWDorG9ajexVWl7
         mcMvOLqXknU2O+vRFPSjmb8wFeBIW7CBqR+uSqVwBha7WL6ACTGx4Tu2D+qHW+Bg4/ra
         xisxqtjAM/Wdem2Zkv6i42R1U61aSlV+SAkEk26NwIKGmoiWmL9OBHO3ca+sZ0B0c6v6
         rOKA==
X-Gm-Message-State: AC+VfDyGqWrsoOjhg6YXdULBfgc3PR+hMK6l1lPXcA1bOTj08cp8Ndzl
        apzJ10v+sIyLMKKkkyJa1Fl0+CNXBEZ0wTfQRchW3uKzpiO71ZhnvRceeULgoPowvpZbz0/HQGR
        77LSgf2UqaqPuZBY+QXe6jIE9
X-Received: by 2002:a7b:ce0e:0:b0:3f5:1bca:345a with SMTP id m14-20020a7bce0e000000b003f51bca345amr6751142wmc.21.1684745732260;
        Mon, 22 May 2023 01:55:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IfyeEnjp7Pfim3zymj1hor8xyUZVI6Ko6H9zwVNZrHsgCWOSKpODloCatqykLSZbOw1M8UA==
X-Received: by 2002:a7b:ce0e:0:b0:3f5:1bca:345a with SMTP id m14-20020a7bce0e000000b003f51bca345amr6751111wmc.21.1684745731895;
        Mon, 22 May 2023 01:55:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c27ca00b003f4290720d0sm10709279wmb.47.2023.05.22.01.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:55:31 -0700 (PDT)
Message-ID: <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
Date:   Mon, 22 May 2023 10:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230517150321.2890206-4-revest@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.23 17:03, Florent Revest wrote:
> Alexey pointed out that defining a prctl flag as an int is a footgun
> because, under some circumstances, when used as a flag to prctl, it can
> be casted to long with garbage upper bits which would result in
> unexpected behaviors.
> 
> This patch changes the constant to a UL to eliminate these
> possibilities.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
> ---
>   include/uapi/linux/prctl.h       | 2 +-
>   tools/include/uapi/linux/prctl.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index f23d9a16507f..6e9af6cbc950 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>   
>   /* Memory deny write / execute */
>   #define PR_SET_MDWE			65
> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>   
>   #define PR_GET_MDWE			66
>   
> diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
> index 759b3f53e53f..6e6563e97fef 100644
> --- a/tools/include/uapi/linux/prctl.h
> +++ b/tools/include/uapi/linux/prctl.h
> @@ -283,7 +283,7 @@ struct prctl_mm_map {
>   
>   /* Memory deny write / execute */
>   #define PR_SET_MDWE			65
> -# define PR_MDWE_REFUSE_EXEC_GAIN	1
> +# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
>   
>   #define PR_GET_MDWE			66
>   

Both are changing existing uapi, so you'll already have existing user 
space using the old values, that your kernel code has to deal with no?

-- 
Thanks,

David / dhildenb

