Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596146772E8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAVV6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjAVV6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:58:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF6517146
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 13:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674424651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAGz6AMzTiiLgzMFcsUhGWBA0NWtp6ggxEU7R8HhwK4=;
        b=NZLNPQySroESHC72Z+D0EQJ/hEqXAv5glTwdES06WzpR7WSX8ZvNFGwJO5JJOriALL1Dlh
        jKC/TCfMxjaysgUCVSBXPAh+JyE9Pq8Jw2zKBUnn8NyiQg4qjE0eaEvBUCBVYbVebCfH16
        edGHYegGeVNYqFauU9Jsu98KbfNhTRU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-572-8chJ9eTFMrOaKveT9lLU6w-1; Sun, 22 Jan 2023 16:57:30 -0500
X-MC-Unique: 8chJ9eTFMrOaKveT9lLU6w-1
Received: by mail-qk1-f200.google.com with SMTP id az16-20020a05620a171000b00709129a745eso5267368qkb.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 13:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAGz6AMzTiiLgzMFcsUhGWBA0NWtp6ggxEU7R8HhwK4=;
        b=sbouDmP+R6pUo6rTsr+gBDnABVyYvmx9RlrLDIlb/wulR7qvXZ3voliHed/8rBSjDJ
         OJ32fo1XsjA7v+zcTorhqTdJzfBHylzsJnVAGehFDJYjIid+cd0KDoNlKhBR2SIyCnPh
         U+Ug61SbHggxXIXghdLqkDTMTbNfvAlmgz+PnGAsGR2aCFre7yHtCSS8Gz01eloZKVQh
         DHy4nFjnuwV0uAa9YybA0kgy0fMNCCB3TpHMNV5Op2v6KFrNAt6ye3DFBnvCOvGIjPms
         GReg+RNoMPhOL0efxijAel2AlQqjZe8wr7pdB1Ieek1pprxi6JqHc4shjtDnex05Ut9C
         22WA==
X-Gm-Message-State: AFqh2kqnhDad1k7S+vswCbQC5C/9y8Xe9+2eQw8FCccWrnPqWkKc+7TT
        HurNuoBREJmH+NYxl7AmPVPK9dxLm6gx5rVLKmNKRm6njGFwxOMd25N9cDN1QnRrb3TEYTUi/8y
        0BL9E8XsSeYxi3UqosEuN8rTz
X-Received: by 2002:ac8:707:0:b0:3a5:17f0:e718 with SMTP id g7-20020ac80707000000b003a517f0e718mr31136147qth.14.1674424649661;
        Sun, 22 Jan 2023 13:57:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsXLByHvU3jUJu2vyqhI4amE8DNqUGJk9i0e0Hc9QuF48qL4kADNUF69T8akaoaNSs/u0JCig==
X-Received: by 2002:ac8:707:0:b0:3a5:17f0:e718 with SMTP id g7-20020ac80707000000b003a517f0e718mr31136135qth.14.1674424649445;
        Sun, 22 Jan 2023 13:57:29 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b006fca1691425sm30428273qko.63.2023.01.22.13.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 13:57:29 -0800 (PST)
Subject: Re: [PATCH v2] paride/pcd: return earlier when an error happens in
 pcd_atapi()
To:     Jens Axboe <axboe@kernel.dk>, tim@cyberelk.net, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230122154901.505142-1-trix@redhat.com>
 <1a501bc9-7058-6c47-0ebf-44459bc0e730@kernel.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b4866797-bcfa-d261-bae2-6e1e132e1863@redhat.com>
Date:   Sun, 22 Jan 2023 13:57:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1a501bc9-7058-6c47-0ebf-44459bc0e730@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/23 12:49 PM, Jens Axboe wrote:
> On 1/22/23 8:49 AM, Tom Rix wrote:
>> clang static analysis reports
>> drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
>>    is a garbage value [core.UndefinedBinaryOperatorResult]
>>    tocentry->cdte_ctrl = buffer[5] & 0xf;
>>                          ~~~~~~~~~ ^
> Has this one been compiled? I'm guessing not tested...
>
> In any case, this code is going away hopefully shortly, so let's not
> bother with changes like this.

Going away soon would be nice, this is an old problem.

I did not bother with a fixes: tag because it was is when the repo was 
created in 2005.

Tom


>

