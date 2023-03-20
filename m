Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5620C6C124C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjCTMtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjCTMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19A144A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679316447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MCTZ2YEpD+DNcu1eqCJ1wevQ6rnwTmcbdNFcopJE5v0=;
        b=Bu2VlutiK2wHeVMCGuP7QKn+J7sLVpDFjOkItxqmiR50WS55wP2qlil8zGCmn+BXd0EXCR
        TE4La+nmhjr7swh3MPPcldhZHxdlkySTS1oqiQn543Nui6Kj9PYwT0Z5b0nh6dnWy/YsFc
        SrGBpImNzVFWVbiKVAYu2IaJAQ/IbHM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-wIs5ST7mOEWfgHl13IegBw-1; Mon, 20 Mar 2023 08:47:25 -0400
X-MC-Unique: wIs5ST7mOEWfgHl13IegBw-1
Received: by mail-pl1-f200.google.com with SMTP id l10-20020a17090270ca00b0019caa6e6bd1so7056500plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679316445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCTZ2YEpD+DNcu1eqCJ1wevQ6rnwTmcbdNFcopJE5v0=;
        b=CYH2vxI127qag4wPr6PLFxpNZkKPf+1N38a2OS1ToN0KQ/bfVNldWQHhCWgaQdAomx
         8xRPCAIqwGcx4oF4hrNXLKMHp5vKorhgnUco30CMEmglslPmjhDdwTGIlNJfeeMTTJMM
         +yaXPe18Nu/00HpX1eQNorLjYTck6rIBjz4bRQA41vDX0eFhAGofZkmLoh+mcM1uAe5N
         iIpJsQocWHn8+Y/ZFHOJf/eW/dWG2lxO77b5P/45QUxpvsvIj/oizbrZ8PwG8+upJFZA
         jWKbI9ArMkzIoXG45tIaCKAVZiQTbYIVyOKOVSZ/3+SIelqy5mLUCvHqGfoaZhteeJc/
         55cQ==
X-Gm-Message-State: AO0yUKXAYsnmqDCS5t6xLvpsB32JYZT/Kr5LB1q2x1rcV2tbgXM2NdWw
        JcAf41ac9wvfLOjWF6dvBUNuqIga41ERyVl4Nkq4zWL2ZHccUPRCNrRaiSrwsUAFpllkOgYEloK
        DtZ2a3Sg73pstFQqc8jX4ihMZ
X-Received: by 2002:a17:90a:354:b0:233:ee67:8eb3 with SMTP id 20-20020a17090a035400b00233ee678eb3mr20113196pjf.24.1679316444862;
        Mon, 20 Mar 2023 05:47:24 -0700 (PDT)
X-Google-Smtp-Source: AK7set9NvQjuWxOqxvHTyhzTOo2bI7ogfxl2dHPoaHJN+qRIYINNczfbWhlBBbuhETGfpifCCMiNgw==
X-Received: by 2002:a17:90a:354:b0:233:ee67:8eb3 with SMTP id 20-20020a17090a035400b00233ee678eb3mr20113160pjf.24.1679316444444;
        Mon, 20 Mar 2023 05:47:24 -0700 (PDT)
Received: from [10.72.12.59] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gq21-20020a17090b105500b002342ccc8280sm6176676pjb.6.2023.03.20.05.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 05:47:24 -0700 (PDT)
Message-ID: <0b51da52-bb38-2094-b9b2-bc3858066be5@redhat.com>
Date:   Mon, 20 Mar 2023 20:47:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/3] ceph: fscrypt: fix atomic open bug for encrypted
 directories
Content-Language: en-US
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316181413.26916-1-lhenriques@suse.de>
 <568da52f-18a6-5f96-cd51-5b07dedefb2d@redhat.com>
 <CAOi1vP9QsbSUq9JNRcpQpV3XWM2Eurhk+6AkDDNmks5PLTx3YQ@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP9QsbSUq9JNRcpQpV3XWM2Eurhk+6AkDDNmks5PLTx3YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/03/2023 19:20, Ilya Dryomov wrote:
> On Mon, Mar 20, 2023 at 2:07 AM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 17/03/2023 02:14, Luís Henriques wrote:
>>> Hi!
>>>
>>> I started seeing fstest generic/123 failing in ceph fscrypt, when running it
>>> with 'test_dummy_encryption'.  This test is quite simple:
>>>
>>> 1. Creates a directory with write permissions for root only
>>> 2. Writes into a file in that directory
>>> 3. Uses 'su' to try to modify that file as a different user, and
>>>      gets -EPERM
>>>
>>> All the test steps succeed, but the test fails to cleanup: 'rm -rf <dir>'
>>> will fail with -ENOTEMPTY.  'strace' shows that calling unlinkat() to remove
>>> the file got a -ENOENT and then -ENOTEMPTY for the directory.
>>>
>>> This is because 'su' does a drop_caches ('su (874): drop_caches: 2' in
>>> dmesg), and ceph's atomic open will do:
>>>
>>>        if (IS_ENCRYPTED(dir)) {
>>>                set_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags);
>>>                if (!fscrypt_has_encryption_key(dir)) {
>>>                        spin_lock(&dentry->d_lock);
>>>                        dentry->d_flags |= DCACHE_NOKEY_NAME;
>>>                        spin_unlock(&dentry->d_lock);
>>>                }
>>>        }
>>>
>>> Although 'dir' has the encryption key available, fscrypt_has_encryption_key()
>>> will return 'false' because fscrypt info isn't yet set after the cache
>>> cleanup.
>>>
>>> The first patch will add a new helper for the atomic_open that will force
>>> the fscrypt info to be loaded into an inode that has been evicted recently
>>> but for which the key is still available.
>>>
>>> The second patch switches ceph atomic_open to use the new fscrypt helper.
>>>
>>> Cheers,
>>> --
>>> Luís
>>>
>>> Changes since v2:
>>> - Make helper more generic and to be used both in lookup and atomic open
>>>     operations
>>> - Modify ceph_lookup (patch 0002) and ceph_atomic_open (patch 0003) to use
>>>     the new helper
>>>
>>> Changes since v1:
>>> - Dropped IS_ENCRYPTED() from helper function because kerneldoc says
>>>     already that it applies to encrypted directories and, most importantly,
>>>     because it would introduce a different behaviour for
>>>     CONFIG_FS_ENCRYPTION and !CONFIG_FS_ENCRYPTION.
>>> - Rephrased helper kerneldoc
>>>
>>> Changes since initial RFC (after Eric's review):
>>> - Added kerneldoc comments to the new fscrypt helper
>>> - Dropped '__' from helper name (now fscrypt_prepare_atomic_open())
>>> - Added IS_ENCRYPTED() check in helper
>>> - DCACHE_NOKEY_NAME is not set if fscrypt_get_encryption_info() returns an
>>>     error
>>> - Fixed helper for !CONFIG_FS_ENCRYPTION (now defined 'static inline')
>> This series looks good to me.
>>
>> And I have run the test locally and worked well.
>>
>>
>>> Luís Henriques (3):
>>>     fscrypt: new helper function - fscrypt_prepare_lookup_partial()
>> Eric,
>>
>> If possible I we can pick this together to ceph repo and need your ack
>> about this. Or you can pick it to the crypto repo then please feel free
>> to add:
>>
>> Tested-by: Xiubo Li <xiubli@redhat.com> and Reviewed-by: Xiubo Li
>> <xiubli@redhat.com>
> I would prefer the fscrypt helper to go through the fscrypt tree.

Sure. This also LGTM.

Thanks

- Xiubo

> Thanks,
>
>                  Ilya
>

