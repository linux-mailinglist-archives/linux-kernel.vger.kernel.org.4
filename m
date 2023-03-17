Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1BC6BE7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCQLJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCQLI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C31241E9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679051287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFrkZcgMRFqj/YL76AsZyo+pZLdDkc3U0vHb8n1dWOc=;
        b=YYZk2JD5yvCbVQiyOf/9nfQs5tB5j6aZwTasSMmk5XquQylFu9gV2BS4ZxqT0ItOYtZ5Fx
        LtrL+19xIuHvFeUNEd7dnNOK9GrT7FbhM06+24cqH/iMwnCEeXDNlLYpCcetkfe2ckxPFk
        tPrXT+H7495Cq9wZ3jcsophr8emP/Is=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-kHCjNLtnNWe04AiWacJToA-1; Fri, 17 Mar 2023 07:08:06 -0400
X-MC-Unique: kHCjNLtnNWe04AiWacJToA-1
Received: by mail-qv1-f71.google.com with SMTP id e11-20020ad4536b000000b005a9292e8c2bso2633735qvv.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679051285;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFrkZcgMRFqj/YL76AsZyo+pZLdDkc3U0vHb8n1dWOc=;
        b=COqH1/srGUAdpeNTUsAH8AOqNhtW+mpGWPfNrNkNCsWRG+U5SpkE38Wh3AY56K5HTY
         alNrApAc0eWJk89K8F7noEiC/kzkBF3omAGZeL664VWbbJu82CEwMYEQvozcjwlTG2TG
         Dt1sjvgxDAQKmxOUMwjKLYAtMnhNaarj8OaWWwnpAQKV8F8vqmryI76uLbOgktpVSJzr
         YeouEbo9dwEFqUlUrCvb0e6xZiQRq9tr42Asn1JBKl+7Y7EAUIyENLatqGies051tEMg
         zxtzShPBEZjQLZibAkdSqjyhHWsgMb3nG/37iDYDtagjFHoP7UVT7LCkRb9PBNsWNUGG
         3dng==
X-Gm-Message-State: AO0yUKU2O2/4uWgxqSXBgwamdZc37yd5APNCbrVB/ud2lFxSykV6MIh1
        peeuSm+95l3dl1u059/i1iEDSTJqd/BG1S2P7jKQTZEwrPAIKS29zsXR7h6Pryw/hWQA0h0h+M0
        S5ndMJ4NjiOr2CG8P7JNmKBDPWjXtPK+AQm3gkUB67wdZyvERzaz11sRf3Zr3d1BTiLcgE1Wj9l
        DDayE=
X-Received: by 2002:ac8:5c96:0:b0:3bf:df2e:a494 with SMTP id r22-20020ac85c96000000b003bfdf2ea494mr12230098qta.6.1679051285547;
        Fri, 17 Mar 2023 04:08:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set/0k3uYz5kgjWc7xcseMVq0TkOVZC6Wmp9XEep8Xuy3onXi/3HlEgtGMuN8MojLsBrYKEFdOA==
X-Received: by 2002:ac8:5c96:0:b0:3bf:df2e:a494 with SMTP id r22-20020ac85c96000000b003bfdf2ea494mr12230066qta.6.1679051285195;
        Fri, 17 Mar 2023 04:08:05 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id d188-20020a37b4c5000000b007426ec97253sm1410746qkf.111.2023.03.17.04.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 04:08:04 -0700 (PDT)
Subject: Re: [PATCH] ext4: remove unneeded check of nr_to_submit
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316204831.2472537-1-trix@redhat.com>
 <20230317045836.GA882@sol.localdomain>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7833722c-3618-14f5-0e49-cff96eb06ea8@redhat.com>
Date:   Fri, 17 Mar 2023 04:08:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230317045836.GA882@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/16/23 9:58 PM, Eric Biggers wrote:
> On Thu, Mar 16, 2023 at 04:48:31PM -0400, Tom Rix wrote:
>> cppcheck reports
>> fs/ext4/page-io.c:516:51: style:
>>    Condition 'nr_to_submit' is always true [knownConditionTrueFalse]
>>   if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
>>                                                    ^
>> This earlier check to bail, makes this check unncessary
>> 	/* Nothing to submit? Just unlock the page... */
>> 	if (!nr_to_submit)
>> 		return 0;
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> Maybe add:
>
> Fixes: dff4ac75eeee ("ext4: move keep_towrite handling to ext4_bio_write_page()")

The rule of thumb I use is 'would this require a recompile?'

In this case, the existing code will work, so no fixes:

Tom

> Either way, looks good to me.
>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
>
> - Eric
>

