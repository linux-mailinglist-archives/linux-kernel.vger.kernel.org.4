Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758C6747502
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGDPL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjGDPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:11:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC05CE6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:11:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e3b15370so3098909b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688483482; x=1691075482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfwAeExHr+y1pYJrIRZuSm3ldW4dUztFq7/VB374kRE=;
        b=Hgm7cMwKS2E1aaVm4N2j15ZRGZeS5++jtefy5hLwxJBMqZdR2eZAiBCG7fH/pWo5/Z
         +Or2oafDAxsv54g5zDJsbcXVI+zkVT58kBPYKmGXDB7l6yD5YMha+39iqaZ5KkW7CLOB
         TMPiq2UJ4vd9OGze1qYwU7Hu+/6m4uyRd4mmMgNFc2wnwXgjxAbdMT45XQKdLGcPc421
         V4q2JCY/dFgC0JbTxL5uAY3Px6fvyXB5en+Gwj65sPGZUClYy2MwkQbNzTZpl+Tl9Bym
         xgT3pVuyH66UTH2T/OqVTJP2f6MxdX42Ex1FddMPJc8t+2df4Tzfuekhm7W99lTwwH54
         ZQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483482; x=1691075482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mfwAeExHr+y1pYJrIRZuSm3ldW4dUztFq7/VB374kRE=;
        b=JVXqI0+p7aYno/JMvuQbZvlyPdEWQ2Lw4zdsANUDnCg8QdrqeGIgIfCnwwPh/+v4Ny
         HcgobkSsr+bNJuyeesLWFMdD2uMk6tE/Prax+eyAca07EQ6smbFOTqCRiBW3jfaMVpRc
         CM9PGcj7+79G9rugzBedBlNRgYjQksFeerJHA8m+Gi8F4OwG+7qtOzy+EiEUOkY7DMCI
         m/SIxilaRKkYJHVIcM4bxSnIEiWvbHLVvlE2WEF9B1DCbm5lIntpGxa+2Bf5biR6UlUc
         O4g+L7QsMGSl1kwhGYHSGXYrhMMCtgFd8tDgD5lnwgrvqAy2PiJUHO3qGMWaEOfpx99n
         E2qQ==
X-Gm-Message-State: AC+VfDyJTTNri0NFDMYC7KA2U+0KYKOeHTjotZ5ro+ToZIcyQudUSTvU
        j6YiaFx11RgRoSisTMH5B3D6WcvwF0Nc8xz/S1Q=
X-Google-Smtp-Source: ACHHUZ6lFU9RHatoa8CPtTUvL3I3VmS429+p4CCImxVgdfEnS0NnIkvpMK/ERbsPk9tKKuel9Z9Yjw==
X-Received: by 2002:a05:6a20:5495:b0:125:a429:a19c with SMTP id i21-20020a056a20549500b00125a429a19cmr14123250pzk.48.1688483482403;
        Tue, 04 Jul 2023 08:11:22 -0700 (PDT)
Received: from [10.254.70.13] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79392000000b0063d24fcc2b7sm9889956pfe.1.2023.07.04.08.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 08:11:21 -0700 (PDT)
Message-ID: <c5f29a53-aae2-1d1b-9c98-5878a046d1f3@bytedance.com>
Date:   Tue, 4 Jul 2023 23:11:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 33/35] maple_tree: Update testing code for
 mas_{next,prev,walk}
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
 <20230518145544.1722059-34-Liam.Howlett@oracle.com>
 <CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/3 02:20, Geert Uytterhoeven 写道:
> Hi Liam,
> 
> On Thu, May 18, 2023 at 9:37 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>> Now that the functions have changed the limits, update the testing of
>> the maple tree to test these new settings.
>>
>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> Thanks for your patch, which is now commit eb2e817f38cafbf7
> ("maple_tree: update testing code for mas_{next,prev,walk}") in
> 
>> --- a/lib/test_maple_tree.c
>> +++ b/lib/test_maple_tree.c
>> @@ -2011,7 +2011,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
>>
>>          val = mas_next(&mas, ULONG_MAX);
>>          MT_BUG_ON(mt, val != NULL);
>> -       MT_BUG_ON(mt, mas.index != ULONG_MAX);
>> +       MT_BUG_ON(mt, mas.index != 0x7d6);
> 
> On m68k (ARAnyM):
> 
>      TEST STARTING
> 
>      BUG at next_prev_test:2014 (1)
>      Pass: 3749128 Run:3749129
> 
> And after that it seems to hang[*].
> 
> After adding a debug print (thus shifting all line numbers by +1):
> 
>      next_prev_test:mas.index = 0x138e
>      BUG at next_prev_test:2015 (1)
> 
> 0x138e = 5006, while the expected value is 0x7d6 = 2006.
I took a look. The return value 5006 is correct while the
expected value is wrong. This is a problem with the test,
it is not compatible with 32-bit systems.
> 
> I guess converting this test to the KUnit framework would make it a
> bit easier to investigate failures...
> 
> [*] Left the debug one running, and I got a few more:
> 
>      BUG at check_empty_area_window:2656 (1)
>      Pass: 3754275 Run:3754277
>      BUG at check_empty_area_window:2657 (1)
>      Pass: 3754275 Run:3754278
>      BUG at check_empty_area_window:2658 (1)
>      Pass: 3754275 Run:3754279
>      BUG at check_empty_area_window:2662 (1)
>      Pass: 3754275 Run:3754280
>      BUG at check_empty_area_window:2663 (1)
>      Pass: 3754275 Run:3754281
>      maple_tree: 3804518 of 3804524 tests passed
> 
> So the full test took more than 20 minutes...
> 
>>          MT_BUG_ON(mt, mas.last != ULONG_MAX);
>>
>>          val = mas_prev(&mas, 0);
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
