Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1545FEBCF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiJNJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJNJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2F16086B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665740290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YPcsdhguVebBYw6wlhJcVtchAbBz7klXMKMCGpq3nBc=;
        b=RIFkzM1odvoGKpnsRWIuYcIEPMKJ0H5rl9bV+t+bL4glCjWf5t9f0vw/1cXVcR2PkOtPqf
        FlhisCNDat6oHepVnuFVjHcmQ0XB/yo67HLNDmlnvfvj0TIaOh6w+J9TznnabpcfrVGBdK
        7oZpsa0orEfHu0oIF2/gMtqNZgsNq/8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-Nvk5WDadNV-dukZRQLiYOg-1; Fri, 14 Oct 2022 05:38:09 -0400
X-MC-Unique: Nvk5WDadNV-dukZRQLiYOg-1
Received: by mail-io1-f72.google.com with SMTP id bx19-20020a056602419300b006bcbf3b91fdso2787188iob.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPcsdhguVebBYw6wlhJcVtchAbBz7klXMKMCGpq3nBc=;
        b=NYPeirD76JmbsWd5tU9ZxLINi6kCOds+Us8+fMozDUGXgoxZb4mX/YRkGsRZg4L+Rt
         rmIHyv5rPGp3hw0FTPSuoa2xFzME4jUJNaJQGG5/rWzPglNSAO8dHVg/vj88UsC8jkFO
         2ml6vnBF+PJPsluoXfLxpQpOLfIFZdzZPV2HXz2BG5dAbCUZkJEae7k60DtI0rR5KIRp
         gk+cTlbjPDL+hy+jelflxmnCjsOlw96o495wjTwmwuSvI3exPzgxUX4ZCsZRPkBB9i8u
         7KAZ9+jBxT2p5MX0POt/Obhck0Eypx4ZiLyLkutWiaJoX8/cUYNiLj+NltJs2fdOxSxH
         fccg==
X-Gm-Message-State: ACrzQf2cEkE23hp02YutZ92ruOS9yabMngZyZcve9PEFKfmWuHEOMYHH
        E7BFPxouZchnLqurFy0OTOwB4xRHAmrtVMef9Ioj7JD7lIAsAN72p5mgacI/Ty93QpAl1YnSrXk
        7PAndaelSKxUgAWyo/dk8jW1ICNpP5xp9JULP4jAL
X-Received: by 2002:a05:6e02:17c8:b0:2fa:3fda:3e2 with SMTP id z8-20020a056e0217c800b002fa3fda03e2mr2041707ilu.15.1665740288242;
        Fri, 14 Oct 2022 02:38:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM71V3rbiiGGgxU8j0lRH9uGIW7/RMp5qOc8iSYm6/3cYslMcMTyJNXceNRsIAzGSuOcvrmgUDo4dscobzW34us=
X-Received: by 2002:a05:6e02:17c8:b0:2fa:3fda:3e2 with SMTP id
 z8-20020a056e0217c800b002fa3fda03e2mr2041703ilu.15.1665740288060; Fri, 14 Oct
 2022 02:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220915123432.520760-1-marcus.folkesson@gmail.com> <CAM8FrK+qj8aao5mEzzvmBS0Zi=qXqVXnE6X4uQP4Hp6-cPedJw@mail.gmail.com>
In-Reply-To: <CAM8FrK+qj8aao5mEzzvmBS0Zi=qXqVXnE6X4uQP4Hp6-cPedJw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 14 Oct 2022 11:37:56 +0200
Message-ID: <CAO-hwJJ5+WFUamDJERu=EHnTq04u=bMo3TLxpCWUJbyEFPZ-gQ@mail.gmail.com>
Subject: Re: [PATCH] HID: hid-elan: use default remove for hid device
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:25 AM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
>
> Den tors 15 sep. 2022 kl 14:28 skrev Marcus Folkesson <marcus.folkesson@gmail.com>:
>>
>> hid_device_remove() will call hid_hw_stop() as default .remove function
>> if no function is specified.
>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> ---
>
>
> Ping on this patch and the other similar patches.

Hi Marcus,

Just a quick FYI, we are still in the merge window period, and as such
we can not push anything in linux-next that is not 6.1 material. Given
that I intend to take those in 6.2, I will be able to process those
patches next week at the earliest.

Cheers,
Benjamin

