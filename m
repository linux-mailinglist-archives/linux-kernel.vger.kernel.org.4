Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4266BC41
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjAPKyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAPKxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:53:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC941A4BB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673866384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YE3ye6oSJWwx0Akq/jL9vL0RZ0atPKXBDGaWJDXGSew=;
        b=LyEC1TOVqYqfxLca0/Z1DU41zqWsJ4gJAulwzTBpH0XN39tb4pr4kRwZ3lQA8TSarOX+rw
        erAftqVq3pNofgbyyrZ9KeIlUewcTZVU0vpeTQoArqJ+LAEJeMI3UK/MhzxT28ywhZhcCL
        8p0IcQeo1q0bxrxtDXVNK1wmCi6KAPk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-ZPAJQrk3M2eNQrawpG14tA-1; Mon, 16 Jan 2023 05:53:03 -0500
X-MC-Unique: ZPAJQrk3M2eNQrawpG14tA-1
Received: by mail-wm1-f72.google.com with SMTP id z22-20020a7bc7d6000000b003daf671f7b2so559721wmk.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YE3ye6oSJWwx0Akq/jL9vL0RZ0atPKXBDGaWJDXGSew=;
        b=7b9xSEgnH7ogmLj6b6QSiHSFEoID9CFzUf+S9pGcmjD7w2q3nagq75lr7LacmQnpLf
         Awq8Sjj4xnsfy1bR/GqBjL+H4vcud4xQko6vQ9oUXJknfZRQUAzpuehzzYoyAZI5dIWu
         fQ8hyZaVSkd2BJ7CvhmgYbzCx0cO6wq1bO2lKHTawwNABI9OmIzT6Z4LlHLo9qClvYpw
         WVdsK5ueF+h3DqLuuUTUZtUv0F9oVXjeoznqm0gM5ahlaBlgyBgYWUQ83b3fdoc+F+8o
         B2JSPYO+YMaCsl1S+ivIXbd1gMcwfnOT1xNmG3im6joyAsgn1UsytnuUJ2jjIXqAet2v
         iawA==
X-Gm-Message-State: AFqh2kqhjAd7MjBlwpHlVHtNHv6/DDJLuoikLkddiWGyNCvhE+T6QuyV
        ZizUp90G94n4717W9qWXE1mLrsjrOAl09WbDm1url2Rs/t4iGCl2eg1l5AlY3RSAJqkKv3Qfhm7
        oSnZwPv0W2ZqEBNLbg2+S8A42
X-Received: by 2002:a05:600c:1e07:b0:3da:ff08:6c5f with SMTP id ay7-20020a05600c1e0700b003daff086c5fmr1443637wmb.40.1673866381742;
        Mon, 16 Jan 2023 02:53:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtnacRqfQpY9dYMEh7V6ZqwwTnJokxXvk944I1ebPVf8RLXYHBA4n1ZZvdppEv1LBf8959c2A==
X-Received: by 2002:a05:600c:1e07:b0:3da:ff08:6c5f with SMTP id ay7-20020a05600c1e0700b003daff086c5fmr1443624wmb.40.1673866381434;
        Mon, 16 Jan 2023 02:53:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1000:21d5:831d:e107:fbd6? (p200300cbc704100021d5831de107fbd6.dip0.t-ipconnect.de. [2003:cb:c704:1000:21d5:831d:e107:fbd6])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c2cdb00b003a84375d0d1sm42034036wmc.44.2023.01.16.02.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:53:01 -0800 (PST)
Message-ID: <916aedc8-1d0b-a0f9-5ddf-6c6305e7cbdb@redhat.com>
Date:   Mon, 16 Jan 2023 11:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] mm/page_ext: Do not allocate space for page_ext->flags
 if not needed
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        akpm@linux-foundation.org, mhocko@suse.com,
        quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20230113154253.92480-1-pasha.tatashin@soleen.com>
 <0c706897-b2cc-714c-c72e-4154b1f3f52b@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0c706897-b2cc-714c-c72e-4154b1f3f52b@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.23 11:51, Vlastimil Babka wrote:
> On 1/13/23 16:42, Pasha Tatashin wrote:
>> There is 8 byte page_ext->flags field allocated per page whenever
>> CONFIG_PAGE_EXTENSION is enabled. However, not every user of page_ext
>> uses flags. Therefore, check whether flags is needed at least by one
>> user and if so allocate space for it.
>>
>> For example when page_table_check is enabled, on a machine with 128G
>> of memory before the fix:
>>
>> [    2.244288] allocated 536870912 bytes of page_ext
>> after the fix:
>> [    2.160154] allocated 268435456 bytes of page_ext
>>
>> Also, add a comment before page_ext_operations that describes the
>> field, and remove check if need() is set, as that is now a required
>> field.
>>
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Mike's comments look reasonable to me.

Seconded

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

