Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73F626E84
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 09:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiKMIaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 03:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 03:30:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65465D112;
        Sun, 13 Nov 2022 00:30:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z14so11986033wrn.7;
        Sun, 13 Nov 2022 00:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HAviD9zbWLptU+xHtVTfpcYj6auJhtOhDq/aATLFMfk=;
        b=PaC1RsJNWEsOn9Ec2BFyhjzZwG/RlX6d+VMXfi+AukESgZDglz9L+I16IdMdP+v0WF
         kFQLaslaT6740COGF+wWOnq1Dj1chAgKB8oGPiepHaBxJCAc9Lg4MEck8m7xbJpYQXGx
         3sv+LX+1OF3kci3vdEYa5EXYt6Bh92h/ki3ccMylRO75C1aJXCKcDqL+v+YYYDvA+KAn
         pBWuKtnxbsQI7DWPztBLy9kmtlGqB4RVveAhewfEoqNbtIJ6YBBeNwewmbnqIIaQbdjS
         n6qDZi/cZT9c6c/yigeUbZ+ljPTgubVqP3LL2b/7rzL7s0niQNzXfbL/8fUjriXl8xyY
         EJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAviD9zbWLptU+xHtVTfpcYj6auJhtOhDq/aATLFMfk=;
        b=iz+kQRc119+u6xa9mhHlUPMQq+ZP3kfzVZgTInu3SdV+wkwVkDiH+j4ipeY3HyHBpv
         tbv85ELR0Ultu5ml2ruQ+QzECs1V1sSVp3n4Ztx0Bh0hKywpRBvqfa8sJHJIr4/ukIcU
         kDOdyk9RglzEBq5gFv8YNtruto/TvXMoRzqxramQlcvzc9lMUo/2fADDfTj7FTxXhSlf
         UqvitcU54akYkIszkmROco3pHqFsJN3mDirMZtYRo/j2SgFvMpJY/Sahu2OzQYT4kLs4
         tsAJmmbWMq+/8nAK1RvJfTzYruVqwEjUSEudls2305Tjo6QtbR4C7CN5AlVXPDK/vadr
         1LNw==
X-Gm-Message-State: ANoB5plCVTMAoFEwAS/a6AlIZ8iwCMkRzm70hTeUtBHdQ3SCK/RHin09
        AOGV/GWDZnYZgfw/hGCP2oI=
X-Google-Smtp-Source: AA0mqf5Xcr9E0As5sX2jl1J+v9r5OCbyWtzgGu8RiU7BZWoZFcVAAPiAPplhKCdenDR3WnyoXNRO/A==
X-Received: by 2002:adf:ce88:0:b0:23a:ce24:1bf0 with SMTP id r8-20020adfce88000000b0023ace241bf0mr4770831wrn.383.1668328219777;
        Sun, 13 Nov 2022 00:30:19 -0800 (PST)
Received: from [89.138.235.186] (89-138-235-186.bb.netvision.net.il. [89.138.235.186])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d4050000000b002365b759b65sm6271882wrp.86.2022.11.13.00.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 00:30:19 -0800 (PST)
Message-ID: <2a8f59ac-9d49-ffa3-b035-809f2fac38ec@gmail.com>
Date:   Sun, 13 Nov 2022 10:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] char: xillybus: Prevent use-after-free due to race
 condition
Content-Language: en-US
To:     Hyunwoo Kim <imv4bel@gmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu
References: <20221030094209.65916-1-eli.billauer@gmail.com>
 <20221113080558.GA5854@ubuntu>
From:   Eli Billauer <eli.billauer@gmail.com>
In-Reply-To: <20221113080558.GA5854@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2022 10:05, Hyunwoo Kim wrote:
> Dear,
> 
> Sorry for the late review.
> 
> This patch cannot prevent the UAF scenario I presented:
> ```
>                  cpu0                                                cpu1
>         1. xillyusb_open()
>            mutex_lock(&kref_mutex);    // unaffected lock
>            xillybus_find_inode()
>            mutex_lock(&unit_mutex);
>            unit = iter;
>            mutex_unlock(&unit_mutex);
>                                                               2. xillyusb_disconnect()
>                                                                  xillybus_cleanup_chrdev()
>                                                                  mutex_lock(&unit_mutex);
>                                                                  kfree(unit);
>                                                                  mutex_unlock(&unit_mutex);
>         3. *private_data = unit->private_data;   // UAF
> 
> ```
> 
> This is a UAF for 'unit', not a UAF for 'xdev'.
> So, the added 'kref_mutex' has no effect.
> 

You're correct. This submitted patch solves only one problem out of two. 
It prevents the content of @private_data to be freed, but you're right 
that @unit itself isn't protected well enough.

The problem you're pointing at is that @unit can be freed before its 
attempted use, because the mutex is released too early.

This is easily solved by moving down the mutex_unlock() call to after 
@unit has been used. Do you want the pleasure to submit this patch, or 
should I?

Thanks,
   Eli
