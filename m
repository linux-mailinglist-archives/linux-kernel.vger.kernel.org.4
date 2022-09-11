Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8514C5B4FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiIKPy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIKPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C05237C6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662911690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XTgMaSHBU/lmRwABmwxshdNhhl1P9NPVCYW5gm0oZg=;
        b=R+O4EjWDkxja2QWfROlxq6bB/LYH9xa0BVczHQJYE37QX9vwUid6OB3hTWDCcOASwY6FRh
        pzMVSYG3g0rpomRBfYl3zB8tWmuX6an6zXt17hIJMqDuCMEkunMUC6KWksktjSA4kzAVzA
        xkSDuQkBU1zxuDk+askB0AQ/9X44lUM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-604-AGL7EqFKN6iqiShT8zwuMw-1; Sun, 11 Sep 2022 11:54:49 -0400
X-MC-Unique: AGL7EqFKN6iqiShT8zwuMw-1
Received: by mail-ed1-f70.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso4559805edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 08:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2XTgMaSHBU/lmRwABmwxshdNhhl1P9NPVCYW5gm0oZg=;
        b=VyKfvTM+uM7MX5JWsA8SdQcNV0FuAXq6lOdgXcaz1vo6SjICHV+kkrAKNCzsYFeY3f
         OCr8pSDzRUeYKfiDWFeS7Wgf+hb1SFbVrfT1u1wyIoLt6FHbt0conD1whvS18hlZvC2D
         l/iZ5beASPKDATe82xQOrb0GnD+IFPAvh4z6ZcdDem8RraNrWlNAin3GZXjr0AdkKyb7
         bIwo5tbhdpPSbSyCaROjacVn/BZawriwnge2rSisAD+KuUVSOwBMP67YmC/2y50+d447
         RPFTgtbfXpkGRLLhyHRg5ldQIWKLbWrupzRxNMutokNevM6d9QIeii3IfGBj+G4IbLLt
         J24g==
X-Gm-Message-State: ACgBeo1Ky2CJQWsXpqV/5CgFJ7wyTg7IEXnDlCMB/oZ6HzZXVk8VL63o
        DbQNpriP3YecMYiVCM02hu0gTtyAaSv2Wr/uNZTE0eNHkPuf5cg5oht+oWTyvPeJriEPlf96TUL
        jQamiSOHUeb8YelNm4NwSFOob
X-Received: by 2002:aa7:c052:0:b0:44f:147:521b with SMTP id k18-20020aa7c052000000b0044f0147521bmr19166499edo.53.1662911688263;
        Sun, 11 Sep 2022 08:54:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4RkXwfrlMn01ttEdUdKeNdDXoLBf1pLBjFJ/Wkt4v5Cg5PYqYfkL8NqnX98hhv1aLB5ZOkxg==
X-Received: by 2002:aa7:c052:0:b0:44f:147:521b with SMTP id k18-20020aa7c052000000b0044f0147521bmr19166488edo.53.1662911688068;
        Sun, 11 Sep 2022 08:54:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ly9-20020a170906af4900b0073dde62713asm3154724ejb.89.2022.09.11.08.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 08:54:47 -0700 (PDT)
Message-ID: <85bb630f-2163-9e99-1089-8050fac57a3f@redhat.com>
Date:   Sun, 11 Sep 2022 17:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v1 1/1] media: atomisp_gmin_platform: Unexport and split
 camera_sensor_csi()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220730162027.1011-1-andriy.shevchenko@linux.intel.com>
 <Yud2cwiCCnq4x50L@paasikivi.fi.intel.com>
 <YxYWBSo+fceHCAOd@smile.fi.intel.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YxYWBSo+fceHCAOd@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/5/22 17:30, Andy Shevchenko wrote:
> +Cc: Hans
> 
> On Mon, Aug 01, 2022 at 06:45:07AM +0000, Sakari Ailus wrote:
>> On Sat, Jul 30, 2022 at 07:20:27PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
>> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Thanks!
> 
> Hans, maybe you want to include this one into your bunch?

Ack, I've added this to my next batch of atomisp cleanup
patches which I'm sending out right after this email.

Regards,

Hans

