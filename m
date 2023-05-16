Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A7D705020
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjEPODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjEPODd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0208525D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684245766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twS5ahFzaWXt7vJAdMtEbWdDWzby14zvPLkx6kO9lrM=;
        b=EA8sdwwR/4REOfMAWhhQnD53eFBvL6o2t7W1iBdo/l2xc/EzPRkyXxO1uIB1i8bWbvsdN2
        Cj8XgLzwaRCRMQoK73oM9b5iuOYEEyMxBwQxwJzhk3E+7Du+LBqxQ7ETlpaNRFtE8LLU6U
        M2dS0R37FpF3htRAPUd8zWryOnq7Cyg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-8YVGO-ovO0iTzm63bW9moQ-1; Tue, 16 May 2023 10:02:38 -0400
X-MC-Unique: 8YVGO-ovO0iTzm63bW9moQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-965cd056598so1697971766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684245748; x=1686837748;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twS5ahFzaWXt7vJAdMtEbWdDWzby14zvPLkx6kO9lrM=;
        b=J0/Na7IKRO3MpeMWfOgf+xH570CRpZ10aeIm33d3L9I9onAKuHGqzHKH5lVD0c3Woq
         qpXOWQPJDC3m93cRvAADiDUAguoYEVgGFgfTw72nE1oz5Rp9quI8JD9PD/tKAgRARfWV
         qbPOUnvhbSY/aMTtigE3e1mCrTZQxGL4Kap/iUkiV6nNURtVqxpv6j8UwE54lkRwbmoT
         fj7SxJvGR2eu053Ju5ZfEYz7rtR5aK+GbNXxlzkhdPvjcLiNGQcZLGvcr9aODrZNveF6
         9ccPfK7zRfdylDUsPkCeg9E+I3WBQVswaGwv+KwmzPMrVETPOsxBa55+CcIEODEEeL4t
         +uHQ==
X-Gm-Message-State: AC+VfDzpCFM06bQzG+9VcOqB1boHxMhnfFgmmy4PClo/XZ6GiZLN1720
        7dVfsGArY3lWnMRgSGeFM9ClfYgJBOainaviRAS/uwB7vuCI4HLiIWW0Wc7FkVULzb9nsK/YDj4
        5F8kkhHiabSTXeNZ1Kb3cqOPU
X-Received: by 2002:a17:907:1687:b0:94e:1764:b0b5 with SMTP id hc7-20020a170907168700b0094e1764b0b5mr40844287ejc.69.1684245748329;
        Tue, 16 May 2023 07:02:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Sv1L/mzfQuA3G4ODXv4iuBZ6M5UPWTIXaWAD5Nho4S5et/zpSXci+58Lm9EsOc+R+UavaDA==
X-Received: by 2002:a17:907:1687:b0:94e:1764:b0b5 with SMTP id hc7-20020a170907168700b0094e1764b0b5mr40844264ejc.69.1684245748028;
        Tue, 16 May 2023 07:02:28 -0700 (PDT)
Received: from [192.168.0.5] ([85.13.73.241])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906845100b0095844605bb8sm11139221ejy.10.2023.05.16.07.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 07:02:27 -0700 (PDT)
Message-ID: <24c413e6-75a5-254c-b776-1459da83f86f@redhat.com>
Date:   Tue, 16 May 2023 16:02:26 +0200
MIME-Version: 1.0
Content-Language: en-MW
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20230516123719.117137-1-xiafukun@huawei.com>
From:   Peter Rajnoha <prajnoha@redhat.com>
Subject: Re: [PATCH v5] kobject: Fix global-out-of-bounds in
 kobject_action_type()
In-Reply-To: <20230516123719.117137-1-xiafukun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 14:37, Xia Fukun wrote:
> The following c language code can trigger KASAN's global variable
> out-of-bounds access error in kobject_action_type():
> 
> int main() {
>     int fd;
>     char *filename = "/sys/block/ram12/uevent";
>     char str[86] = "offline";
>     int len = 86;
> 
>     fd = open(filename, O_WRONLY);
>     if (fd == -1) {
>         printf("open");
>         exit(1);
>     }
> 
>     if (write(fd, str, len) == -1) {
>         printf("write");
>         exit(1);
>     }
> 
>     close(fd);
>     return 0;
> }
> 
> Function kobject_action_type() receives the input parameters buf and count,
> where count is the length of the string buf.
> 
> In the use case we provided, count is 86, the count_first is 85.
> Buf points to a string with a length of 86, and its first seven
> characters are "offline".
> In line 87 of the code, kobject_actions[action] is the string "offline"
> with the length of 7,an out-of-boundary access will appear:
> 
> kobject_actions[action][85].
> 
> Use sysfs_match_string() to replace the fragile and convoluted loop.
> This function is well-tested for parsing sysfs inputs. Moreover, this
> modification will not cause any functional changes.
> 
> Fixes: f36776fafbaa ("kobject: support passing in variables for synthetic uevents")
> Signed-off-by: Xia Fukun <xiafukun@huawei.com>
> ---
> v4 -> v5:
> - Fixed build errors and warnings, and retested the patch.
> 

Please, also check this is still working:
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-uevent

When I try passing the example line "add
fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc", it doesn't recognize
such input anymore and it incorrectly considers it as erroneous.

-- 
Peter

