Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ECC6008AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJQIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJQIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1BCE1B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665995467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICZj4OzZtpWjbJoXyPcZEJISbo2i7c++c+5S4uuj5bw=;
        b=inQfYZtAzlTFbPoLrp6ri60FCi9BLGB4W7Se7O9Y7GPsMc8NtnDEBe0jTPPaHZpuEq/zWL
        GdNEv/78wBMN0jkPikjA475AxdMJhRReEZIKpiahEu7ii9m9aZozcjOH3aXpPdvqDwZwR/
        mZBzDV35kneATgazI0UKZxNKOCsTNSM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-88dzus-sOMitcKXznQynPg-1; Mon, 17 Oct 2022 04:31:06 -0400
X-MC-Unique: 88dzus-sOMitcKXznQynPg-1
Received: by mail-io1-f71.google.com with SMTP id 5-20020a5d9c05000000b006a44709a638so6595452ioe.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICZj4OzZtpWjbJoXyPcZEJISbo2i7c++c+5S4uuj5bw=;
        b=D0DlH0GjKEKPOPwghuQtyoJsWGLykICqslqDkgrPuzH9EuRBBTya0sXlbgKW3NjusG
         rEsWwYmPsdhbxpR8Uo1tjS8FGm1UTED+Sno5KgzP0p5ux1Pl5YvzskvvUkY0nRkKvhrB
         8tDDr90Vjo6aNmmL5UNQ9jSildblTFYrPDTWWbOMHDhT9W/HpQiZAkLnwD8XZsUJlsZC
         X03bhhY5TibBL/0Q3E/O6E0P1DSnGfGlFWiRpwhJfayW1lyT6l1kAn6UAJRv1zY6VB1s
         NL2ktvlGkCwXQyCuxOUq/8QQK3MLqZJTnqUoe1d40SYIXBztQaHFW9SOdx+eL1bHnf41
         j/sA==
X-Gm-Message-State: ACrzQf2TZxIyjbaZGThpA03dQsewN6TI6wDlp1lI9K2/PT7XLi+HvB9v
        1PwKbFJ3chdjLlKqWCn494OO5uGm/6bZY0q1DxBy4m0mQQVU86/d6YZABy/k+xyWm2F1MhKpMYM
        0HxJe3NC4+7HRewogpkQikGKo4MtalDRcosJm5DLP
X-Received: by 2002:a05:6e02:194e:b0:2f8:fa94:9da1 with SMTP id x14-20020a056e02194e00b002f8fa949da1mr4232886ilu.102.1665995465542;
        Mon, 17 Oct 2022 01:31:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6A9nbSAuPnK/VcE7PLgVI04FeAE9qOqh0Dh3xG2hiYKH0UZl9qY2PUMIe/P/j853gLy2LBNOAeQjHYhGTEPjk=
X-Received: by 2002:a05:6e02:194e:b0:2f8:fa94:9da1 with SMTP id
 x14-20020a056e02194e00b002f8fa949da1mr4232872ilu.102.1665995465281; Mon, 17
 Oct 2022 01:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <Y00JenqCzKRrcTiF@mail.google.com>
In-Reply-To: <Y00JenqCzKRrcTiF@mail.google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 17 Oct 2022 10:30:54 +0200
Message-ID: <CAO-hwJ+q+fsmjKY=BjDazBjUDD3755VhRxWw628=xxC9ePWzqA@mail.gmail.com>
Subject: Re: [PATCH] [next] HID: hyperv: Replace one-element array with
 flexible-array member
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jiri Kosina <jikos@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 9:51 AM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in structs synthhid_msg, synthhid_input_report,
> pipe_prt_msg and refactor the rest of the code accordingly.
>
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/210
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
>
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---

FWIW, this is
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Couple of questions though:
- do the hyperv want to take this patch through their tree or should I
(I plan on sending some fixes for 6.1-rc2 this week, so I can piggy
back this one)
- on the driver itself, please see inline:

>  drivers/hid/hid-hyperv.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index e0bc73124196..208cf8d981a5 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -61,7 +61,7 @@ struct synthhid_msg_hdr {
>
>  struct synthhid_msg {
>         struct synthhid_msg_hdr header;
> -       char data[1]; /* Enclosed message */
> +       char data[]; /* Enclosed message */
>  };

IMO that struct has no real use. We just use it in
mousevsc_on_receive() to dereference the first field only, the header.
So how about we have a followup cleanup patch that just removes it and
in mousevsc_on_receive() we convert those usages directly to struct
synthhid_msg_hdr?

Cheers,
Benjamin

>
>  union synthhid_version {
> @@ -99,7 +99,7 @@ struct synthhid_device_info_ack {
>
>  struct synthhid_input_report {
>         struct synthhid_msg_hdr header;
> -       char buffer[1];
> +       char buffer[];
>  };
>
>  #pragma pack(pop)
> @@ -118,7 +118,7 @@ enum pipe_prot_msg_type {
>  struct pipe_prt_msg {
>         enum pipe_prot_msg_type type;
>         u32 size;
> -       char data[1];
> +       char data[];
>  };
>
>  struct  mousevsc_prt_msg {
> @@ -232,7 +232,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
>
>         ret = vmbus_sendpacket(input_device->device->channel,
>                         &ack,
> -                       sizeof(struct pipe_prt_msg) - sizeof(unsigned char) +
> +                       sizeof(struct pipe_prt_msg) +
>                         sizeof(struct synthhid_device_info_ack),
>                         (unsigned long)&ack,
>                         VM_PKT_DATA_INBAND,
> @@ -271,16 +271,14 @@ static void mousevsc_on_receive(struct hv_device *device,
>                  * malicious/buggy hypervisor/host, add a check here to
>                  * ensure we don't corrupt memory.
>                  */
> -               if ((pipe_msg->size + sizeof(struct pipe_prt_msg)
> -                       - sizeof(unsigned char))
> +               if (struct_size(pipe_msg, data, pipe_msg->size)
>                         > sizeof(struct mousevsc_prt_msg)) {
>                         WARN_ON(1);
>                         break;
>                 }
>
>                 memcpy(&input_dev->protocol_resp, pipe_msg,
> -                      pipe_msg->size + sizeof(struct pipe_prt_msg) -
> -                      sizeof(unsigned char));
> +                               struct_size(pipe_msg, data, pipe_msg->size));
>                 complete(&input_dev->wait_event);
>                 break;
>
> @@ -359,8 +357,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
>         request->request.version_requested.version = SYNTHHID_INPUT_VERSION;
>
>         ret = vmbus_sendpacket(device->channel, request,
> -                               sizeof(struct pipe_prt_msg) -
> -                               sizeof(unsigned char) +
> +                               sizeof(struct pipe_prt_msg) +
>                                 sizeof(struct synthhid_protocol_request),
>                                 (unsigned long)request,
>                                 VM_PKT_DATA_INBAND,
> --
> 2.37.3
>

