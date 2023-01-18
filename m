Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7203672667
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjARSL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjARSLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:11:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C256EEC;
        Wed, 18 Jan 2023 10:11:36 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so1604053wmq.1;
        Wed, 18 Jan 2023 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thZKzDaf41DOaDvzUVPdA+iiPMIsDq7PLQWiM3Lp49Q=;
        b=Vq1msGhnpVMBs0zCpH22rqL+V1G+NR5pHVjXueq2cjEuSWKRT5Tf4G5i/gWOJPb286
         UrKqQz+uKIRbbYxRKSmT6JE2O382ES5NqftxXoJmA8FsNg4NwKOW81DDKyXAt4f/obtA
         mctWLMjRW7npj4ete1xJ10W2deeD3Cmu1pVMmoSeoXvWzjFJPeKAV3Zrnw/8ef/mMZw8
         h73RmkTVUBvFPKJC1v31anMHtftuvhjOZqOhlTfmdcTN1dNW/G7JQCzUTHpLAQIUTt1C
         Haj23BWbKf0MMySxEDWFpLCXsOK5R3mZ7oANDD26sLCRNUJTKg2rHbav7mETH8u7Y20V
         cWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thZKzDaf41DOaDvzUVPdA+iiPMIsDq7PLQWiM3Lp49Q=;
        b=AfNQ5Kf2zSsHR5nOrrhhGFUrIr33W0RhgeSJ+1uzDmSQY4vOWo1pZ/mjNIrZr6EZuq
         NtumSi50gfMRCW9C92bVMqyufFmBDBM1RiP9A9ZnmIC77HEF6GDa4bufd5IYO+ISA+vb
         sPulxO1RGVN/a3ogVRioB0qkdwc/vhoP+2d8v6wsHRBYtdEYPe5za0mR90DDzuMkVKj1
         mE9Fvz+bQ30YQmxqoCFY41k63haoNkdcGCpUGteum27tjujt2PGfi2kPbaeeBzEoW2Vu
         3VSN5hsGogN14qxxLc0WzHGF7lC73+5rtnKSC3IcPP9spI5HvOSnZ/OTYC7BTNtZMevm
         2QoQ==
X-Gm-Message-State: AFqh2krii+HsbizZxJlGp08lMEKJAnWW+Qu21Kkv/EM9EJ2Kj2E02tZP
        n4ApImat2gjCszmxR9yP2Cw=
X-Google-Smtp-Source: AMrXdXvC3macKDxyUb+BGmYm7BcOTuI3IMOhA5CwUNKGqTvZkc3N9iWtCJJjx6b7+Ycm553BQ/XoJw==
X-Received: by 2002:a05:600c:3422:b0:3da:f651:782c with SMTP id y34-20020a05600c342200b003daf651782cmr3620699wmp.25.1674065495006;
        Wed, 18 Jan 2023 10:11:35 -0800 (PST)
Received: from fedora.36 ([78.10.207.59])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b003d1e1f421bfsm3107205wms.10.2023.01.18.10.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:11:34 -0800 (PST)
Date:   Wed, 18 Jan 2023 19:11:33 +0100 (CET)
From:   =?ISO-8859-2?Q?Micha=B3_Grzelak?= <mchl.grzlk@gmail.com>
To:     Rob Herring <robh@kernel.org>
cc:     =?ISO-8859-2?Q?Micha=B3_Grzelak?= <mchl.grzlk@gmail.com>,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, cosmin.tanislav@analog.com,
        jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: addac: adi,74115: Add missing
 maxItems
In-Reply-To: <20230117195723.GA3527095-robh@kernel.org>
Message-ID: <16a6e9ae-291f-d0b9-9529-4c72588d9668@student.agh.edu.pl>
References: <20230115022558.145076-1-mchl.grzlk@gmail.com> <20230117195723.GA3527095-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463809024-2123484451-1674063327=:48246"
Content-ID: <bf5b20f9-7b9d-cbf5-db48-9adad995e2@student.agh.edu.pl>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809024-2123484451-1674063327=:48246
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <35a7aac2-3d12-ac32-14cf-0679fc484c6@student.agh.edu.pl>

On Tue, 17 Jan 2023, Rob Herring wrote:

> On Sun, Jan 15, 2023 at 03:25:58AM +0100, Micha³ Grzelak wrote:
>> Running 'make dt_binding_check' gives following warnings:
>> iio/addac/adi,ad74115.example.dtb:
>> addac@0: adi,conv2-range-microvolt: 'oneOf' conditional failed, one must
>> be fixed:
>>         4282967296 is not one of [-2500000, 0]
>>         4282967296 is not one of [-12000000, 0]
>>         -2500000 was expected
>>         -104000 was expected
>>         625000 was expected
>>
>> addac@0: Unevaluated properties are not allowed
>> ('adi,conv2-range-microvolt' was unexpected)
>>         From schema: iio/addac/adi,ad74115.yaml
>
> I think your dtschema version is out of date. I don't see this issue.
> The issue has to do with signed types and there have been some fixes
> related to them.
>

Right. Issue vanished after upgrade, sorry for unnecessary noise.

Best regards,
Micha³
---1463809024-2123484451-1674063327=:48246--
