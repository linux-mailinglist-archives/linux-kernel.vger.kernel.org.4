Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9714171F3CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjFAUYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjFAUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:23:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C05419D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KHOfwolgp9XhN7STp1l0dexkTZzW2Pcs/mHiDWhkhXI=; b=lVug5T1raKnst0iLVKJVuj0iZo
        tw5+d34F0rJrIDMYTxT8bJqtA5jnw89Y6Ri3siDGv1CFagjvYPl0JYMXv7ASS3FZjLSwcIqF4Lb2L
        gxfw9+DYM3rVDwrK68a+F3UJTNV4XuhAd9TnIXUSol45TZQ4Bv/DoRKY38XGo9fmLuhg3FMqeZ3XU
        YYk63+DXJsurDmtWeUm2Enk9OWU2Cg2gq3kXqhgT4raIEQ5gHYXcK8Hk7u87y8fKThYzSSh4GpkF2
        ixgdxIU7CcL7BeNLXNMJjWTqmdaiVrjXwTm7npZWOqCqQUzO2MkGMI5w3Eaplpw2GLdVqvQUSR8nU
        4ksDo8Xw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4opU-004rIk-26;
        Thu, 01 Jun 2023 20:23:28 +0000
Message-ID: <c9770ddc-d1fe-d49f-adec-a413a7bf65ec@infradead.org>
Date:   Thu, 1 Jun 2023 13:23:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] firewire: fix warnings to generate UAPI documentation
Content-Language: en-US
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230601144937.121179-1-o-takashi@sakamocchi.jp>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230601144937.121179-1-o-takashi@sakamocchi.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/1/23 07:49, Takashi Sakamoto wrote:
> Any target to generate UAPI documentation reports warnings to missing
> annotation for padding member in structures added recently.
> 
> This commit suppresses the warnings.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20230531135306.43613a59@canb.auug.org.au/
> Fixes: 7c22d4a92bb2 ("firewire: cdev: add new event to notify request subaction with time stamp")
> Fixes: fc2b52cf2e0e ("firewire: cdev: add new event to notify response subaction with time stamp")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  include/uapi/linux/firewire-cdev.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 

You can do it as this patch shows, or you can hide those padding fields as
described in Documentation/doc-guide/kernel-doc.rst:

Inside a struct or union description, you can use the ``private:`` and
``public:`` comment tags. Structure fields that are inside a ``private:``
area are not listed in the generated output documentation.

The ``private:`` and ``public:`` tags must begin immediately following a
``/*`` comment marker. They may optionally include comments between the
``:`` and the ending ``*/`` marker.

See below.

> diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
> index 99e823935427..1f2c9469f921 100644
> --- a/include/uapi/linux/firewire-cdev.h
> +++ b/include/uapi/linux/firewire-cdev.h
> @@ -130,6 +130,9 @@ struct fw_cdev_event_response {
>   * @length:	Data length, i.e. the response's payload size in bytes
>   * @request_tstamp:	The time stamp of isochronous cycle at which the request was sent.
>   * @response_tstamp:	The time stamp of isochronous cycle at which the response was sent.
> + * @padding:	Padding to keep the size of structure as multiples of 8 in various architectures
> + *		since 4 byte alignment is used for 8 byte of object type in System V ABI for i386
> + *		architecture.

You could drop that change.

>   * @data:	Payload data, if any
>   *
>   * This event is sent when the stack receives a response to an outgoing request
> @@ -155,10 +158,6 @@ struct fw_cdev_event_response2 {
>  	__u32 length;
>  	__u32 request_tstamp;
>  	__u32 response_tstamp;

	/* private: */
> -	/*
> -	 * Padding to keep the size of structure as multiples of 8 in various architectures since
> -	 * 4 byte alignment is used for 8 byte of object type in System V ABI for i386 architecture.
> -	 */
>  	__u32 padding;

	/* public: */

>  	__u32 data[];
>  };
> @@ -231,6 +230,9 @@ struct fw_cdev_event_request2 {
>   * @handle:	Reference to the kernel-side pending request
>   * @length:	Data length, i.e. the request's payload size in bytes
>   * @tstamp:	The time stamp of isochronous cycle at which the request arrived.
> + * @padding:	Padding to keep the size of structure as multiples of 8 in various architectures
> + *		since 4 byte alignment is used for 8 byte of object type in System V ABI for i386
> + *		architecture.

drop that.

>   * @data:	Incoming data, if any
>   *
>   * This event is sent when the stack receives an incoming request to an address
> @@ -284,10 +286,6 @@ struct fw_cdev_event_request3 {
>  	__u32 handle;
>  	__u32 length;
>  	__u32 tstamp;

	/* private: */

> -	/*
> -	 * Padding to keep the size of structure as multiples of 8 in various architectures since
> -	 * 4 byte alignment is used for 8 byte of object type in System V ABI for i386 architecture.
> -	 */
>  	__u32 padding;

	/* public: */

>  	__u32 data[];
>  };

-- 
~Randy
