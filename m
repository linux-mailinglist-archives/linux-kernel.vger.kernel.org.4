Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CD76589AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiL2G10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiL2G1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:27:24 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B3A196
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:27:23 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 17so18143575pll.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wp7a/SqxkJQiBzNObkC8yuL3dMlA3/D0swG9wS0+8cI=;
        b=nvmp5uWL2MCA7VFC+xj2NcKawctJVWIVLQ/dOq9XgsrR4yNKTrP3E78LO9oVdpKjBE
         rzlmlntfj5UVzNju5fBtj20Xll4DXBF14wk8VGayE4QXdG67kilB6PCmAZdUDAJDEbpa
         rLtcZTPpyEiSSuH5BbF84VRrVRutdNCt0CiQiH1xYME9L0YH3O3RVy2EwIRrOb7ePKcH
         Tu62W/erGqOlpEd8omExuIjfN7237/xC4KWTAIx9J/l6DgTm2yNu+lJnmDpPpvuXrEL6
         cufvuYx/vDK+COa+jCak6hCzrWfcrxNOosOVPaDX46prvbpIy0HWV96xUVJcma54lyu4
         BQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp7a/SqxkJQiBzNObkC8yuL3dMlA3/D0swG9wS0+8cI=;
        b=1UvSElYEqVqEHsl5PDjMojhc7X6IXx7wk+f8yJ1n91O1kM/IO87wKNz/3CRxY9VPZO
         WEYEiQeXhoDASOzOMgNzfyn2A80K3EPb1NUyOJxvmgKhmsXZrRDa+lghcd0r5gZUhgUF
         Mq2Qns2RGtS1sVm9620AV5M3cJ2FuAs473Tpt5T5KQUFrJsnHcnupD8XDEvO5fzpeNAn
         vVnAHC8wt34RPdGwH3TiMzAQxCznmiWTW/VjG+nhUOlEwg7tPfobW/tnuzyvHq1ZMLxE
         MCxpDrW2TbaSg/uAyMk6IUs3DoftRsDTGRynzE68Xd4CLaIXMBWb9/cF/BPqQ2vSaQff
         fjkg==
X-Gm-Message-State: AFqh2kpdQIiMyDTJcPIElovOpzbQ4AC16s21JwuLitqbTdKyL0JxB34t
        uxcrftWJfe2+gP8XpGdrCuM=
X-Google-Smtp-Source: AMrXdXvouxlTS5q6FeDiLy5aU5YcHYFqVnKOe57Ma/nRuF4I7JRhIKzb1XgiczitPxdkQGNQwxYNhw==
X-Received: by 2002:a05:6a21:3290:b0:af:757d:a8b0 with SMTP id yt16-20020a056a21329000b000af757da8b0mr40845162pzb.9.1672295243170;
        Wed, 28 Dec 2022 22:27:23 -0800 (PST)
Received: from [192.168.10.103] (ab137057.f.west.v6connect.net. [183.76.137.57])
        by smtp.gmail.com with ESMTPSA id b6-20020a63d306000000b0047850cecbdesm10081737pgg.69.2022.12.28.22.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 22:27:22 -0800 (PST)
Message-ID: <03cb5a7d-a10a-91b0-9e10-6a1147e56963@gmail.com>
Date:   Thu, 29 Dec 2022 15:27:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] virtio_balloon: high order allocation
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>, mst@redhat.com,
        david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kalutes@google.com, mhiramat@kernel.org, cwd@google.com
References: <20221223093527.12424-1-the.latticeheart@gmail.com>
 <3fabf076-0fd8-2ad2-52e7-3c2913308156@huawei.com>
From:   Soichiro Ueda <the.latticeheart@gmail.com>
In-Reply-To: <3fabf076-0fd8-2ad2-52e7-3c2913308156@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shixin.

Thanks for checking the patch!

>> +			for (i = 0; i < num_pfns; i++) {
>> +				set_page_pfns(vb, vb->pfns + vb->num_pfns + i,
>> +					      nth_page(page, i));
>> +			}
> Since the interval of vb->num_pfns is VIRTIO_BALLOON_PAGES_PER_PAGE,
> it seems that the pfns[] should be vb->pfns + vb->num_pfns + i * VIRTIO_BALLOON_PAGES_PER_PAGE.
Definitely.
>> +			vb->num_pages +=
>> +				num_pfns * VIRTIO_BALLOON_PAGES_PER_PAGE;
>> +			if (!virtio_has_feature(
>> +				    vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>> +				adjust_managed_page_count(page, -num_pfns);
> num_pfns is of the unsigned int type so need be to converted to long manually.

Oh, the second argument of adjust_managed_page_count is long type. So it 
needs casting as you say.

I'll fix these problems in the v2 patch.

Thank you,


