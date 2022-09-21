Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66DE5E5478
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiIUUZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiIUUZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:25:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC0033A20
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:25:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a29so7121241pfk.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=sqG2AIDQKKDIE+aKBMVPmM2IG52evSEYbtT3naoareY=;
        b=BBSldU+bSB4OlpR9ZugkdEuCgPBnKNc+8QbIKCogH4mDwvWJ9SnKnG2omcEjKB4djJ
         Tih3+qSVPrty+9QPwr2RGb/XzY++8EKchwWodpep1/VYX3d6IO41WIL7wK3js2pSq1je
         tXfGQwpOgAWMDbIov1mD+/XnKLu0nQzYOom2W+IwKC8+Oq/pn2qAQKAMb2ApWwFd+SIT
         HsWpb5ULu6TZqVKmW44N2UeOxmqFihUWiChncYu3TOvzxVznBE/CW+cQz83GqpUQkVkg
         q6Mi0tGHmMuVGrXSFiXABJooHQr0egYvAIZ3MYbprwMJERtGe+okOe/oMz1w7zprMfc6
         xRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sqG2AIDQKKDIE+aKBMVPmM2IG52evSEYbtT3naoareY=;
        b=E1TE4O1+mdk4Znv1GpskCveOOR2AjfQAtp2o+ybPyCZiA/fAVK704og+mLZNp2YI2H
         GY5ERKmzxJA09gaz0Yy2LvWGQBml/3RWQAwJoB/ZXysE2noO4IsJe6a7X4SBDTolEtRO
         9xfzwXx0jijSoIKD/z+XFBp1flnAHBYLKS2acKMu9pUacH0eejTi0c+/74gMH35eBtHd
         aI5sJzNZv9iG9Dh3swhqflZ2+qTfzKPqMzYYb/Ty2Uy5vQW6O6heUBnBymA2t+eqYBCG
         slj7Ei3KNygFowqJYukTcTrD/nrx64ctjfuwQ1riqE+7HV9PT75ce98hGfH+Yr3VqTnN
         1DOw==
X-Gm-Message-State: ACrzQf3WNx/iEN3yMcsnlsl5JrQrSU/XAzHurHT44YGc5lXFaG+bWSS/
        rQe9zIxMHttYj2kKACtl/tT4CA==
X-Google-Smtp-Source: AMsMyM6o8G1z4hT/AOp7wIZTc+0oakeB6QJKQLscLYOK+iFgjuptTVMCsMqJ0+ePeCH5Dpd7ApeZtQ==
X-Received: by 2002:a05:6a00:3392:b0:547:f861:1fad with SMTP id cm18-20020a056a00339200b00547f8611fadmr31009348pfb.16.1663791905942;
        Wed, 21 Sep 2022 13:25:05 -0700 (PDT)
Received: from localhost (p200300ee3707fe003af25da13a798889.dip0.t-ipconnect.de. [2003:ee:3707:fe00:3af2:5da1:3a79:8889])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b00176b5035045sm2419819plg.202.2022.09.21.13.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 13:25:04 -0700 (PDT)
Date:   Wed, 21 Sep 2022 13:25:04 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Sep 2022 08:31:52 PDT (-0700)
Subject:     Re: [PATCH -next v2 2/2] riscv: extable: add new extable type EX_TYPE_KACCESS_ERR_ZERO support
In-Reply-To: <301cd27e-d003-584b-2eb0-8fa025348cff@huawei.com>
CC:     ajones@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor.Dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     tongtiangen@huawei.com
Message-ID: <mhng-b5608339-68e0-4706-9002-50ba006b4d05@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2022 03:39:38 PDT (-0700), tongtiangen@huawei.com wrote:
>
>
> 在 2022/8/26 16:16, Andrew Jones 写道:
>> On Fri, Aug 26, 2022 at 02:44:48PM +0800, Tong Tiangen wrote:
>>>
>>>
>>> 在 2022/8/25 19:06, Andrew Jones 写道:
>>>> On Mon, Aug 15, 2022 at 03:20:25AM +0000, Tong Tiangen wrote:
>>>>> Currently, The extable type EX_TYPE_UACCESS_ERR_ZERO is used by
>>>>> __get/put_kernel_nofault(), but those helpers are not uaccess type, so we
>>>>> add a new extable type EX_TYPE_KACCESS_ERR_ZERO which can be used by
>>>>> __get/put_kernel_no_fault().
>>>>>
>>>>> Only refactor code without any functional changes.
>>>>
>>>> This isn't quite true. __get/put_kernel_nofault now sets a different
>>>> extable type (as the commit message says). But, nothing special seems
>>>> to be done with that, so there's effectively no functional change. Can
>>>> you please elaborate on the motivation for this change? Where will the
>>>> KACCESS type need to be distinguished from the UACCESS type?
>>>
>>> The introduction of EX_TYPE_KACCESS_ERR_ZERO does not change any function,
>>> but makes a correct distinction in the actual type, indicating that there
>>> are indeed some kaccess entries in extable. I think this optimization is
>>> more clear and reasonable.
>>
>> Well, creating new types, just for new type sake, just bloats code.
>>
>>>
>>> A few weeks ago, I did something similar on arm64[1]. I think this
>>> optimization can also be used on riscv.
>>>
>>> We can do some features that are used on uaccss but not applicable on
>>> kaccess in the future[2].
>>>
>>> [1]
>>> https://lore.kernel.org/lkml/20220621072638.1273594-2-tongtiangen@huawei.com/
>>> [2]https://lore.kernel.org/lkml/20220812070557.1028499-4-tongtiangen@huawei.com/
>>>
>>
>> This is part of the information, but I had already found this. What's
>> still missing to me are the riscv patches, or at least a riscv plan, for
>> actually implementing something which requires kaccess and uaccess to have
>> distinct types.
>>
>> Thanks,
>> drew
>
> At present, there is no such plan on riscv, because it is rely on
> hardware support.
> I think this patch can be merged as a small code optimization and
> without any function change.

Generally we need some use of the code in the upstream kernel to justify 
its existence.  In this case I don't really see that: it's just another 
type that's exactly the same as the existing one, having some out of 
tree code that depends on making these types do something different 
isn't a sufficient justification.
