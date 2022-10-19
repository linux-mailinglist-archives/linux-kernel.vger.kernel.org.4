Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9B6047B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJSNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiJSNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:44:01 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1567111F487
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:30:52 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id df9so11329187qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZkPzvePgnTqO/k8Y6G4wzcYziUwK2RlaQD/cWAhimw=;
        b=UUJW/yWXmxeGPC8QuZaJUWcmN10ZTC5R57uXyQ+TTkiSaKrHJo+hVuk58DPQG2sDia
         QTorK2rmmnVbUwosCafoM0yQfyLsBE/lgIyoAEBeI7w/shgu1CGHEc39KicCkZCTP/Fu
         e0H9tCaFO/K5eGaNS96PCwYAJaUTGHfJ0M5biDJI02ZZUGRxHCYB0s4wffInT+5vWvRr
         Ev8u3sjWZcMVd3NRBFpQ3juOEl2KfTHvi50a9Gu/l2StNegTxhqFBq/avX4Bl/pJw6R/
         M2awjK/4VUWVSQWyVJkouUoP+ettcnHxmdfRui0Q8X878oYd7Iat8chSP9xcZlzKfqSe
         iufQ==
X-Gm-Message-State: ACrzQf3fPfUQiqS1bDoEEvC0Tcw9v0qPdn/ZMIIRSP2v0r3rdM6YUQo7
        haMcm68zrSmJAMwmmpo09wZI+U9MMYQ7B++31UA=
X-Google-Smtp-Source: AMsMyM5r+H1reS0oevtwljprObPFXm77UjowgyjcsFw17jcKjQKswOI8qtAGZyGhrB/eG5+oxKasLKFn7WV1SAUf23k=
X-Received: by 2002:a05:6214:f24:b0:4b3:efeb:d800 with SMTP id
 iw4-20020a0562140f2400b004b3efebd800mr6390093qvb.15.1666186193746; Wed, 19
 Oct 2022 06:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220831122356.65544-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220831122356.65544-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Oct 2022 15:29:42 +0200
Message-ID: <CAJZ5v0ipnRzHjKqhysKbbHp+919RrsY13P8H9PwUN9xzMMJpsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] virt: acrn: Mark the uuid field as unused
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Shuo Liu <shuo.a.liu@intel.com>, linux-kernel@vger.kernel.org,
        Fei Li <fei1.li@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 2:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> After the commits for userspace (see Link tags below) the uuid field is
> not being used in the ACRN code. Update kernel to reflect these changes.
> I.e. we do the following:
> - adding a comment explaining that it's not used anymore
> - replacing the specific type by a raw buffer
> - updating the example code accordingly
>
> The advertised field confused users and actually never been used. So
> the wrong part here is that kernel puts something which userspace never
> used and hence this may confuse a reader of this code.
>
> Link: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
> Link: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
> Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
> Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me:

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks!

> ---
> v3: converted to Link tags (Rafael), explained what was wrong (Rafael)
> v2: added tag (Fei)
>  include/uapi/linux/acrn.h | 5 ++---
>  samples/acrn/vm-sample.c  | 3 ---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
> index ccf47ed92500..04fa83647ae5 100644
> --- a/include/uapi/linux/acrn.h
> +++ b/include/uapi/linux/acrn.h
> @@ -12,7 +12,6 @@
>  #define _UAPI_ACRN_H
>
>  #include <linux/types.h>
> -#include <linux/uuid.h>
>
>  #define ACRN_IO_REQUEST_MAX            16
>
> @@ -186,7 +185,7 @@ struct acrn_ioreq_notify {
>   * @reserved0:         Reserved and must be 0
>   * @vcpu_num:          Number of vCPU in the VM. Return from hypervisor.
>   * @reserved1:         Reserved and must be 0
> - * @uuid:              UUID of the VM. Pass to hypervisor directly.
> + * @uuid:              Reserved (used to be UUID of the VM)
>   * @vm_flag:           Flag of the VM creating. Pass to hypervisor directly.
>   * @ioreq_buf:         Service VM GPA of I/O request buffer. Pass to
>   *                     hypervisor directly.
> @@ -198,7 +197,7 @@ struct acrn_vm_creation {
>         __u16   reserved0;
>         __u16   vcpu_num;
>         __u16   reserved1;
> -       guid_t  uuid;
> +       __u8    uuid[16];
>         __u64   vm_flag;
>         __u64   ioreq_buf;
>         __u64   cpu_affinity;
> diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
> index b2dad47a77a0..7abd68b20153 100644
> --- a/samples/acrn/vm-sample.c
> +++ b/samples/acrn/vm-sample.c
> @@ -29,8 +29,6 @@ static struct acrn_io_request *io_req_buf = (struct acrn_io_request *)io_request
>
>  __u16 vcpu_num;
>  __u16 vmid;
> -/* POST_STANDARD_VM_UUID1, refer to https://github.com/projectacrn/acrn-hypervisor/blob/master/hypervisor/include/common/vm_uuids.h */
> -guid_t vm_uuid = GUID_INIT(0x385479d2, 0xd625, 0xe811, 0x86, 0x4e, 0xcb, 0x7a, 0x18, 0xb3, 0x46, 0x43);
>
>  int hsm_fd;
>  int is_running = 1;
> @@ -63,7 +61,6 @@ int main(int argc, char **argv)
>         }
>         hsm_fd = open("/dev/acrn_hsm", O_RDWR|O_CLOEXEC);
>
> -       memcpy(&create_vm.uuid, &vm_uuid, 16);
>         create_vm.ioreq_buf = (__u64)io_req_buf;
>         ret = ioctl(hsm_fd, ACRN_IOCTL_CREATE_VM, &create_vm);
>         printf("Created VM! [%d]\n", ret);
> --
> 2.35.1
>
