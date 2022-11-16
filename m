Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61A362C365
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiKPQFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiKPQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:05:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED5A2E9FB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668614690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VD8rIBKq9wf/FUSXyylUkCpNknVyWclxbOCFJ0JUI4U=;
        b=YzVtxMvsGCH7ykJE0mB/Xh7TBPk4pKeJ6DL5rqHzbYiBzeSk2sMY1FKo1YpzKDWraopYhC
        HMxnBI/l1qPmHgBw5cV9LW4+LBKMB8DwWBAgksnnQ6rcgXIBiOqUY/bUzhlYWw1AtthtnA
        HSyU50HhxO1fybzGV4gXYmsjvCJMiRk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-_JCzYwjBPjqkTrXc0VjlgA-1; Wed, 16 Nov 2022 11:04:46 -0500
X-MC-Unique: _JCzYwjBPjqkTrXc0VjlgA-1
Received: by mail-wr1-f72.google.com with SMTP id d23-20020adfa417000000b002364a31b7c9so3859163wra.15
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD8rIBKq9wf/FUSXyylUkCpNknVyWclxbOCFJ0JUI4U=;
        b=FK07zb5CN3VWWRA4Qt0EdZNKQXkX8tsil3f6rz/jyRArxX056zKrzE2gJbj2o97AjE
         bkYcBaebvco5eOD1e17hveUUagM4Iay+PQL/F1zqtU/irRY0UYtBttKFyisRHGdhIFPc
         jJh08yQP70OqV8pRJdQjFQd0YU0/sVWLON6IeTk/BgP2YI4clsxGipIoa5kYAuXOZrGk
         dY8ugzhSVQbqpLVslM0vAeXD04xxzW0FPcQ4NZh+BJc7NGasEXvF4aRbcWSPVNQpaFa3
         UlGtFW29Kz8KXCoNmeWjjq1nd30NAAtE82DYIzVF5JC7M5YZWTz0rPmqaLcSmacMPvff
         mWhQ==
X-Gm-Message-State: ANoB5plKpmKhh9Xf5u4w83KPqHQ2U8MlLw66VvyGmap+/PYCEzeILxOF
        HuhTwO0FASsM76sBoTvK6Yex7XqBLkQKqVJndUad4sd6XF6OF1wwYgQEaSMY+/23X8HPASTVDzD
        W4NdrVM/aQL+MyUwr/Q1Th8Pu
X-Received: by 2002:a05:600c:4a2a:b0:3b4:c00d:2329 with SMTP id c42-20020a05600c4a2a00b003b4c00d2329mr2537897wmp.124.1668614685617;
        Wed, 16 Nov 2022 08:04:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7EMEglFrPf91N9t9bXegttTA5+iZOC/JSZ1DTnLQiKDskxEyH/ekNzhjX8iFnAl8w3x3Cw+A==
X-Received: by 2002:a05:600c:4a2a:b0:3b4:c00d:2329 with SMTP id c42-20020a05600c4a2a00b003b4c00d2329mr2537870wmp.124.1668614685244;
        Wed, 16 Nov 2022 08:04:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003b4cba4ef71sm2678715wmn.41.2022.11.16.08.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 08:04:44 -0800 (PST)
Message-ID: <f4699655-c137-1d9c-72cd-0e67e6cfcc2c@redhat.com>
Date:   Wed, 16 Nov 2022 17:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Prarit Bhargava <prarit@redhat.com>, pmladek@suse.com,
        Petr Pavlu <petr.pavlu@suse.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.22 20:29, Luis Chamberlain wrote:
> On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
>> I don't have the machine at hand right now. But, again, I doubt this will
>> fix it.
> 
> There are *more* modules processed after that commit. That's all. So
> testing would be appreciated.

I'll try to get a grab on a suitable system.

-- 
Thanks,

David / dhildenb

