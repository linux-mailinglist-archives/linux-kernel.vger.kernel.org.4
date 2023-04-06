Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CFA6D9955
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbjDFOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbjDFOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8820C7AA6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/VuXtyuOduGMa5ZSVvX0YV7CAkGWIAjStnAR0rgErI=;
        b=XRkonhnrmG7TAsmdnjM7H7M0ESl2FoEIqROgUHYWMR867qdfkCD+a0tSaaHzt7ufAs/0Ng
        eC3Jst0KsX4bugUg6x1k+NyabuMoS+TTljyIFQ4YhsRlgdlLl8ollh40wdD5DfV+oDlgMk
        Xp6AKHaUb47+oPJXgyF2X+bVGx4Kr+w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-TemYdQbpOZ6YVes_WbTc-A-1; Thu, 06 Apr 2023 10:14:52 -0400
X-MC-Unique: TemYdQbpOZ6YVes_WbTc-A-1
Received: by mail-wr1-f72.google.com with SMTP id u10-20020adfa18a000000b002ef45d25264so226720wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790491; x=1683382491;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/VuXtyuOduGMa5ZSVvX0YV7CAkGWIAjStnAR0rgErI=;
        b=v3YLcAeEoKVj9H8q5r4j1zPyqvT6L/pb3t0XGMrB2dDXnzrT+HlRRaL04PCg86ZoYu
         /jhQxpdbGQ0eHeTvJG7AGEq81+EykT0nDeYWwcVdL4++TwGsmAqiG0GMcMULGmtswkeC
         Nq2YTlge6SkFdv6jaPomq7gUODwhqx5MudGqz2SffRrbzS8DBq86mBMu9Nraf302xH7a
         NmtDByhIhli8Ezcfp4/LxvyDtPbY32509Gb/J9Jol7haWrAIqA+3FyI/PDKIWID1poNm
         ViF2S4+1/g8hsSGKk6CfLIUXRXHmvutm3pVDlHUSVAqowwWq/e4PguN7WX1fH4XtyU00
         iJjA==
X-Gm-Message-State: AAQBX9eBeadXL/OU99xQ8zzCnqde3+DfWdwIZllUxyghkfBVp1xpc0jC
        4Nx7vRmdtirRT6EmPwdjO0PLFGjbOkA7i3wgDW+X8yYXbDaDCa1fHj4a7e5KleEH6mgaKwdGIY2
        Y6PFaMK1PlkJygClrmeVeRL1X
X-Received: by 2002:a1c:cc15:0:b0:3ef:561d:255d with SMTP id h21-20020a1ccc15000000b003ef561d255dmr6768192wmb.41.1680790491517;
        Thu, 06 Apr 2023 07:14:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZtIq3UeLwNBpMRIQtwhyNqEaPwt8QiZdNhkpjpFMM9Z/XHAeZlxlSD5BXz8r8GJQVI3pJKwA==
X-Received: by 2002:a1c:cc15:0:b0:3ef:561d:255d with SMTP id h21-20020a1ccc15000000b003ef561d255dmr6768177wmb.41.1680790491211;
        Thu, 06 Apr 2023 07:14:51 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003f0652084b8sm5300179wms.20.2023.04.06.07.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:14:50 -0700 (PDT)
Message-ID: <cd49c00e-1982-b7f3-5637-4a35533ac498@redhat.com>
Date:   Thu, 6 Apr 2023 16:14:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for
 atomic64_t
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        'Luis Chamberlain' <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "petr.pavlu@suse.com" <petr.pavlu@suse.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-6-mcgrof@kernel.org>
 <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
 <ZC2cC+I1KTyD8UcC@bombadil.infradead.org>
 <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
 <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
 <ZC2nbiarELlUVcSj@bombadil.infradead.org>
 <979c8cf9ab2d4fcba811adc0c563b8bb@AcuMS.aculab.com>
 <48f2c6f2-f776-be29-7d74-67f1b6cf5467@csgroup.eu>
 <6ba49055a1a343e8b50f808f91438e39@AcuMS.aculab.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6ba49055a1a343e8b50f808f91438e39@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.23 15:48, David Laight wrote:
> From: Christophe Leroy
>> Sent: 06 April 2023 14:38
> ...
>> On powerpc 'long long' is 64 bits on both PPC32 and PPC64.
> 
> It probably in on x85-64 as well.
> By brain is getting frazzled.
> 
> On 64bit long long ought to be 128bit.

I might have been living under a rock, but the only requirement I am 
aware of is for long long to be at least 64bit wide.

AFAIK, that is also the case on s390x and aarch64.

-- 
Thanks,

David / dhildenb

