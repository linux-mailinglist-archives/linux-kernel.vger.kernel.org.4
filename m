Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0EE632592
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKUOXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiKUOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A405326496
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669040523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykhJnNqnxOyo9r4byFX0GgaM79yTY6Gqzcv3nxSkQBo=;
        b=aImYbfPgZDo0uSbrWFqPm/IS8sZpV6+flHyJZZVyfwqxAKwZkc6d+CMjcthhEKeRAU84xi
        xxS+mlXn778jmRnQMaGoU+mamQa5oK7iKnq1AEVeHYBlQEZsRh3OIL5rIWfYyG8liGGChb
        65E8rywm4SkdlhgFyrm4tOGYXKjs4gk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-GFKSsJGkOiC8VKlb1impTg-1; Mon, 21 Nov 2022 09:22:02 -0500
X-MC-Unique: GFKSsJGkOiC8VKlb1impTg-1
Received: by mail-qt1-f200.google.com with SMTP id fb5-20020a05622a480500b003a525d52abcso12030550qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykhJnNqnxOyo9r4byFX0GgaM79yTY6Gqzcv3nxSkQBo=;
        b=XwOWG2rdgslNduEu1JXTGL9ZU3HRZnoh8sjWOofRIe+1y2jGywdtD+H2hhKtOI3nwS
         BZTi3+ag7Y/aS3ew9O4l9s67W7Gg7aIOHGzNIVo1zTU8T91x6w+oXhYsankFqYavQg/U
         r/CnCTSBu72Hs0t0Nc889y4H/dPu4QUJfMHIei0L+Y/mGHMk2jNbTQdyrySG1BvQRgg/
         CLPoLz4cRUueOvRYMQBJpSlV1pJwBimWq6BHMSIoFGTvQmk/savDrKgfEpxMQMNxb+cI
         l0wJLtaKwITPETTvAINkMaOm9WPABcH5Ze7pr8ycQpIgqXFprbc4+dCeqweCFDTa33Up
         abfQ==
X-Gm-Message-State: ANoB5pmWLek9p1n5MfH20sW+5QV2safdhsgdNiryMdMR9SDKUD35/pNG
        JNNaGxh4y/mr6MwQv4G7eABn3PmcP5dtMCe3khJuq/ZhWYcbUKOkJIWPUMj1bPWY9nIfiPTE01U
        VqqSfckmpSR/AtwHEzAQahn/D
X-Received: by 2002:ae9:e415:0:b0:6f3:e5c8:ddde with SMTP id q21-20020ae9e415000000b006f3e5c8dddemr31647qkc.80.1669040521899;
        Mon, 21 Nov 2022 06:22:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Kmo78A03hML/MnkehUvZc7anpEeRq7agSJVj/8E3w6Q4yg/FuaEwwBuxCvDZHq1Ggo7g2Kw==
X-Received: by 2002:ae9:e415:0:b0:6f3:e5c8:ddde with SMTP id q21-20020ae9e415000000b006f3e5c8dddemr31624qkc.80.1669040521678;
        Mon, 21 Nov 2022 06:22:01 -0800 (PST)
Received: from [192.168.33.110] (c-73-19-232-221.hsd1.tn.comcast.net. [73.19.232.221])
        by smtp.gmail.com with ESMTPSA id a13-20020ac84d8d000000b003a5430ee366sm6618466qtw.60.2022.11.21.06.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:21:59 -0800 (PST)
Message-ID: <8cedf92b-af18-bf47-cc92-d70e228b99b0@redhat.com>
Date:   Mon, 21 Nov 2022 09:21:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH next] kbuild: add ability to make source rpm buildable
 using koji
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, dzickus@redhat.com, kheib@redhat.com,
        jtornosm@redhat.com, ihuguet@redhat.com,
        Ivan Vecera <ivecera@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Jonathan Toppins <jtoppins@redhat.com>
References: <5b59fdb7db34f5292b1d138939c6b70b2b2039dd.1666703850.git.jtoppins@redhat.com>
 <CAK7LNAQNTDpKRDdi5JXV1ofC=s9ttJBk4yCivczZ1+KK7G2j5A@mail.gmail.com>
Content-Language: en-US
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <CAK7LNAQNTDpKRDdi5JXV1ofC=s9ttJBk4yCivczZ1+KK7G2j5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/22 08:33, Masahiro Yamada wrote:
> On Tue, Oct 25, 2022 at 10:17 PM Jonathan Toppins <jtoppins@redhat.com> wrote:
>>
>> From: Ivan Vecera <ivecera@redhat.com>
>>
>> Changes:
>> - added new target 'srcrpm-pkg' to generate source rpm
>> - added required build tools to spec file
>> - removed locally compiled host tools to force their re-compile
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> 
> 
> 
> I am fine with this patch.
> 
> Just minor comments.
> 
> 
> I noticed an inconsistency between
> "--target $(UTS_MACHINE)-linux" in the rpm-pkg target and
> "--target $(UTS_MACHINE)" in the srcrpm-pkg target.
> 
> 
> I applied 6105e4f6511d6b383738be89efb99c607e158a29
> just a few months ago.
> Is it better to make it consistent here?

Yes I can post a v2 that includes this change.

> 
> Actually, I do not know koji, also not sure if it is
> important to mention it in the commit subject.
> I just tested this patch by using 'rpmbuild' command
> on my local machine.

koji (https://koji.fedoraproject.org/koji/) is the automated builder 
available to Fedora developers. With this patch a developer can produce 
an upstream kernel rpm rather easily.

> 
> 
[...]
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 

