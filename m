Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7E6737E7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjASMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjASMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495204B4B9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674130001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MA+Tu3X5uLRzP6doE5KbzSpkyhzhncA6EFOFEasfI5U=;
        b=DK7pcS2u+aFZoC+wTDfap5awHqTSHIbqNhhHrINIuS6BreHRqcLfsDauJ420HGDARTc8d4
        ecQvl1+FN9h1gOU+3zMfuSuSdFS0WlkcabbbgKmtDy97NfdbG5OzaVj1HG6Oqi+fb+F/m0
        uKxepmwbvBuOlc5CkHBpy8mdORFo8Dw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-olRnRInfPiCGT1cEhzyy1w-1; Thu, 19 Jan 2023 07:06:40 -0500
X-MC-Unique: olRnRInfPiCGT1cEhzyy1w-1
Received: by mail-qk1-f197.google.com with SMTP id x12-20020a05620a258c00b007051ae500a2so1228233qko.15
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MA+Tu3X5uLRzP6doE5KbzSpkyhzhncA6EFOFEasfI5U=;
        b=cGnStUHgWi2+9sG/r+RWnF+ZkR3Eejtka/lakDD4V6KmV44dE3JPcpu9rFWioYCL7t
         or6Bj7rsNbAOri/fIgMVe62iBsHhz65Qplt/WwpX+8ejyDXSZKoSO3fegOX7lIw8Y0Es
         +oUlILuDAwFyaolGr8pQt93Z3Z6znz40fWSEf43zqvVFFhStLeoCEPnxQaDxiQ8RrPyk
         E8RCnT/G2fjhiwxvy4LBtbKW9feH16w0vupvYPn8Ci6qDseYmpgAlO1nqZhycT+T1Gwi
         WYa7G6gWOsEQIPzvL2Kr2ZQl/T8sGwww0yIl34JwXW9tgcW0+WxtGOVQ1OBq+75t4dY6
         z0kA==
X-Gm-Message-State: AFqh2kryp1eoePT817Dik4cvCDzAFmQfWp5eQdBDX6p3CHSEqFSlZ0Ci
        1w3GT9o3nOLj3Wn6gbEpvdxgidyWCjnrd98Zp+BhJUfYplmbSAytHwM8vtDGqbBufGtmGx9dIYM
        O3uCCL2eV/nft+6I/HArpiLth2vgyKpVxTFr5tBOR
X-Received: by 2002:a05:620a:2fb:b0:6fe:c73e:2579 with SMTP id a27-20020a05620a02fb00b006fec73e2579mr337815qko.756.1674129999581;
        Thu, 19 Jan 2023 04:06:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuB1xj8g49yNQDrZJdDlcymlZZ5MyruwIBZLgJ7+yb54wy/t1FK2bjN0BKkeFhzZVgJHoeEtvL+bWpF1BxEgVY=
X-Received: by 2002:a05:620a:2fb:b0:6fe:c73e:2579 with SMTP id
 a27-20020a05620a02fb00b006fec73e2579mr337811qko.756.1674129999344; Thu, 19
 Jan 2023 04:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20230119080508.24235-1-meadhbh.fitzpatrick@intel.com>
In-Reply-To: <20230119080508.24235-1-meadhbh.fitzpatrick@intel.com>
From:   Vladis Dronov <vdronov@redhat.com>
Date:   Thu, 19 Jan 2023 13:06:28 +0100
Message-ID: <CAMusb+RPz8PHe3ab6n=TYQG761Rn0uA7OHY7WVQ68onA0wXJMg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: qat: change kernel version
To:     Meadhbh <meadhbh.fitzpatrick@intel.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, wojciech.ziemba@intel.com,
        tomaszx.kowalik@intel.com, bagasdotme@gmail.com,
        linux-kernel@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 19, 2023 at 9:15 AM Meadhbh <meadhbh.fitzpatrick@intel.com> wrote:
>
> Change kernel version from 5.20 to 6.0, as 5.20 is not a release.
>
> Signed-off-by: Meadhbh Fitzpatrick <meadhbh.fitzpatrick@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-qat | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
> index 185f81a2aab3..087842b1969e 100644
> --- a/Documentation/ABI/testing/sysfs-driver-qat
> +++ b/Documentation/ABI/testing/sysfs-driver-qat
> @@ -1,6 +1,6 @@
>  What:          /sys/bus/pci/devices/<BDF>/qat/state
>  Date:          June 2022
> -KernelVersion: 5.20
> +KernelVersion: 6.0
>  Contact:       qat-linux@intel.com
>  Description:   (RW) Reports the current state of the QAT device. Write to
>                 the file to start or stop the device.
> @@ -18,7 +18,7 @@ Description:  (RW) Reports the current state of the QAT device. Write to
>
>  What:          /sys/bus/pci/devices/<BDF>/qat/cfg_services
>  Date:          June 2022
> -KernelVersion: 5.20
> +KernelVersion: 6.0
>  Contact:       qat-linux@intel.com
>  Description:   (RW) Reports the current configuration of the QAT device.
>                 Write to the file to change the configured services.
> --
> 2.37.3

Indeed,

Reviewed-by: Vladis Dronov <vdronov@redhat.com>

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

