Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D0670639A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjEQJIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjEQJIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF53E5C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684314470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5S7Mmw4kjAD2XaDKIPcRvxW4MkJS5gg8vseQbxJ1MII=;
        b=c/OKAOtz2KK3baD4LM3ydATOncOS8oIJ6lMjWEnz5Dbhbgd6DkMTPMe9wm3Iwp/lRXaA5J
        3gxV4zh9xjE8eNWL47bO5f+hzyI/F0dZVuxtK28Nz2oDOM3qJZllWNskd79fwsmyxtJjfX
        9a18gVoahrLOaGXwn3Io4TEXQVROUMQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-shnYupdgOR6gV0vNsxd6gA-1; Wed, 17 May 2023 05:07:49 -0400
X-MC-Unique: shnYupdgOR6gV0vNsxd6gA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355cf318so67378066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684314468; x=1686906468;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5S7Mmw4kjAD2XaDKIPcRvxW4MkJS5gg8vseQbxJ1MII=;
        b=ATIYVzen+onahUrmms8UnSyjFYIzCgSbVG5GbZ/6f71vYOF2yTAtfaui8DabhLJeR4
         BS6zM+s0cWmhtnt3f8ZfR67cJ/BZYC6Nfnh4Qv12qGkEDere73tAgfZs4Ky9FqhDBnDu
         o+zfKBmkYrrjd0w4FFxv+9vGI6fpuqCdhs2MCYgv3Mx9bIoleVz4yNRGrItiKdDeNDo1
         FKpCDdEJ/7NaoqQKKcFbv5qosaJNr2Wd25Tl2HcWjlvy4/dH/hHG32FYE/m02iYjv4UP
         nqcgFBg1oEGq9SB6P8cDwdmMd5vIIJofh/cx54IiwGTFowcjp3D3QNwkFTxZJHIL4eEC
         NEXA==
X-Gm-Message-State: AC+VfDzGPh7VZuEAtOZgCXXmgOcsgzjFdoDjG/0tZ7KTvaac2vh6FbfJ
        PZU+ZG/KHTfdHLigJcG9qM7lmZ4ttuG3LSUDTY+nqQB7wrKOxO5WxaEz343SjiBTAh+w8OPG7nh
        XOp0zUA5KC2nxv3kp0NrGZF7O
X-Received: by 2002:a17:907:1c9f:b0:969:bea8:e1c7 with SMTP id nb31-20020a1709071c9f00b00969bea8e1c7mr32174032ejc.37.1684314468559;
        Wed, 17 May 2023 02:07:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wiYJ3/H7lpetfZjqrQD5NI+m7vxbLc2nZ7gu8e7hzXbrT0+Iwzq0niuN7OOEw2WlR2SXXOg==
X-Received: by 2002:a17:907:1c9f:b0:969:bea8:e1c7 with SMTP id nb31-20020a1709071c9f00b00969bea8e1c7mr32174019ejc.37.1684314468291;
        Wed, 17 May 2023 02:07:48 -0700 (PDT)
Received: from [10.43.17.81] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d20-20020a1709067a1400b0096f0c21903bsm277330ejo.31.2023.05.17.02.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:07:47 -0700 (PDT)
Message-ID: <2e650812-d484-12d7-bdf2-7cbe00d53e25@redhat.com>
Date:   Wed, 17 May 2023 11:07:47 +0200
MIME-Version: 1.0
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20230516123719.117137-1-xiafukun@huawei.com>
 <24c413e6-75a5-254c-b776-1459da83f86f@redhat.com>
 <484d25eb-bcc3-f64f-1182-ff50fb4aca9a@huawei.com>
Content-Language: en-MW
From:   Peter Rajnoha <prajnoha@redhat.com>
Subject: Re: [PATCH v5] kobject: Fix global-out-of-bounds in
 kobject_action_type()
In-Reply-To: <484d25eb-bcc3-f64f-1182-ff50fb4aca9a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 10:54, Xia Fukun wrote:
> 在 2023/5/16 22:02, Peter Rajnoha wrote:
>> On 5/16/23 14:37, Xia Fukun wrote:
> 
>>> ---
>>> v4 -> v5:
>>> - Fixed build errors and warnings, and retested the patch.
>>>
>>
>> Please, also check this is still working:
>> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-uevent
>>
>> When I try passing the example line "add
>> fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc", it doesn't recognize
>> such input anymore and it incorrectly considers it as erroneous.
>>
> 
> Why did I receive the following error message when passing the example
> line "add fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc" using the
> original mainline code?
> 
> synth uevent: /devices/virtual/block/ram12: incorrect uevent action arguments
> block ram12: uevent: failed to send synthetic uevent: -22
> 
> Is there a problem with my test case, or is the original code unable
> to successfully parse the sample?
> 

That works for me, I'm testing on kernel 6.2.15:

# echo "add fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed A=1 B=abc" >
/sys/block/ram0/uevent

# udevadm monitor --kernel --env
monitor will print the received events for:
KERNEL - the kernel uevent

KERNEL[189.376386] add      /devices/virtual/block/ram0 (block)
ACTION=add
DEVPATH=/devices/virtual/block/ram0
SUBSYSTEM=block
SYNTH_UUID=fe4d7c9d-b8c6-4a70-9ef1-3d8a58d18eed
SYNTH_ARG_A=1
SYNTH_ARG_B=abc
DEVNAME=/dev/ram0
DEVTYPE=disk
DISKSEQ=14
SEQNUM=3781
MAJOR=1
MINOR=0


-- 
Peter

