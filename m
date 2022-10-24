Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4448960AED8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiJXPSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiJXPR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702E68D210
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666619761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EmWmTkMoJsoEVALl9wy+YXRPF7l0NRbRGxqJeQt3D1w=;
        b=BcM3NIc5uO7dMDq/u6doYif/87egGZjT+Cs6pNQIMGU7iNr7IHCu1kmGtA+yv9wEcJr2Af
        OUIhrLsJ/jRuBruS+SD/KFwx7c5SD2W8rz9pGVHTN7Il5ERp3Az0zj7pRM8yv1EAYv1VBy
        HpzLzfuK6IxqSFgHRM7BpZaAS5Kd5ew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-9aQHBqLMPCONnZ_MkZvvbg-1; Mon, 24 Oct 2022 09:32:56 -0400
X-MC-Unique: 9aQHBqLMPCONnZ_MkZvvbg-1
Received: by mail-wm1-f71.google.com with SMTP id z10-20020a05600c220a00b003c6ecad1decso1884965wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmWmTkMoJsoEVALl9wy+YXRPF7l0NRbRGxqJeQt3D1w=;
        b=IlPzgm9OnO62ONKVah3ZrRQnqmPXqsNstq8oXHE4YUODjTVV28zA1xfRp5Obin7vFU
         baFhgKPRgKe/w3RLK/y4BeyRgHgRn7HRXr4/Uqjlp5SZTJInxkOKxmd/I2gMNX35f1et
         rWP9E7+L4SgltpjReiekANFmuCZqnmmDquAtZK8U/8K/jtinraxem/mkrxVSKDyc2soo
         K45/U8x6d0TaEO4sS/cykveQJ2cOyO0HlE/haIEkXDhPMwGe/5CoBJR/8qUu5/DAMr1I
         UKhxGEBoxcEiBGSZdB3zBG/RAA8Fv6RksOx8EKD2fPt263QlLMn1ymAJ5iYPSaLF/e81
         D9Fw==
X-Gm-Message-State: ACrzQf2LmMrfd63wymlxWj6qfsenFc9i3/Dp8O54ngH0eirM42KJrT1B
        A/Ch87jBJXkT2cv+V7M9PmPnGVB03Ky3rMaCOicca0ONLDH/dQkNXJHl+n/Do92t/1E3yVhgIa2
        Ti+17/gF9F3lBIfBvYZwqKdMW
X-Received: by 2002:a05:600c:a05:b0:3b9:cecc:9846 with SMTP id z5-20020a05600c0a0500b003b9cecc9846mr42424843wmp.3.1666618374108;
        Mon, 24 Oct 2022 06:32:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6cL1e1sL/077dBTDCluX2MmyW8nmK9GM4RgH8uNgnfIETcBEk9GgLo7C6+FEvUqbj6uWuw5A==
X-Received: by 2002:a05:600c:a05:b0:3b9:cecc:9846 with SMTP id z5-20020a05600c0a0500b003b9cecc9846mr42424822wmp.3.1666618373813;
        Mon, 24 Oct 2022 06:32:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:f100:6371:a05b:e038:ac2c? (p200300cbc704f1006371a05be038ac2c.dip0.t-ipconnect.de. [2003:cb:c704:f100:6371:a05b:e038:ac2c])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b003c64c186206sm10958540wms.16.2022.10.24.06.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:32:53 -0700 (PDT)
Message-ID: <c14a306e-2814-2c9a-21f6-35d477b0fe3d@redhat.com>
Date:   Mon, 24 Oct 2022 15:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20221021101141.84170-1-david@redhat.com>
 <20221021125724.0bc29fdad1c696b8fe92f7f9@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/9] mm/ksm: break_ksm() cleanups and fixes
In-Reply-To: <20221021125724.0bc29fdad1c696b8fe92f7f9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.22 21:57, Andrew Morton wrote:
> On Fri, 21 Oct 2022 12:11:32 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> This series cleans up and fixes break_ksm().
> 
> Quite a lot of fixups were needed merging this.  I guess you couldn't
> develop against mm-unstable because the v1 series was already in there.

Nowadays, I tend to send against mm-stable (I remember that was the 
suggestion). Usually it works because there are no conflicts -- this 
time there are probably quite some kvm unit test conflicts.

Feel free to ask me next time to rebase on XYZ so I can make you life 
easier ;)

> 
> For this reason I'll henceforth be more inclined to drop serieses when
> I know a full resend is coming out.

Yes, good idea. While the fixup-patch process works for small 
adjustments, it's not a good fit for bigger changes, especially once 
involving new patches.

> 
> So please do let me know when a full resend is coming out. 

Will do; I kind-of did that [1] but I should have been more clear 
("Please drop the current series, I'll send a new version.").

> Or, of
> course, send little fixes against the current version.

I prefer a full resend when there are bigger changes that involve 
modifications to multiple patches ... which also makes life easier for 
reviewers.


[1] 
https://lore.kernel.org/all/87104912-6615-4917-eae1-6ae0a80677e1@redhat.com/T/#u

-- 
Thanks,

David / dhildenb

