Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F32659217
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiL2VRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiL2VQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:16:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F515A192
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672348556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RbbKKCG1Xyq1vtML62Lc3iWFrkbMdarR9zQ1HGXJi6w=;
        b=hePIyX6Sd0kL3RFr4kDvYFmwWFSDTKCO0iWOjhqKxT8rt3yWYdPsnBwiMqsmv1dkOFXX5L
        LXlYlRNoHCP+Nd/ugs1m93y+dr8UN2HOrg8zt2QSeaK1z/DjXuSkJUfH4unPzT5lNoTXcR
        /kIs9vuZLhz6AS6cZ++ZxFOFRVXN58w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-fZMewmpLNNOs0HKKo6a0sg-1; Thu, 29 Dec 2022 16:15:54 -0500
X-MC-Unique: fZMewmpLNNOs0HKKo6a0sg-1
Received: by mail-qt1-f199.google.com with SMTP id z16-20020ac84550000000b003a807d816b2so7557952qtn.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbbKKCG1Xyq1vtML62Lc3iWFrkbMdarR9zQ1HGXJi6w=;
        b=zIv8aDEAh/wRGG5MxtBaw9BZsL5jK4uNpyW7LVA01XU5aTYQHjY9TrHO3qP9quh7wN
         4piNGnMbRcVp/4Py4bEcjfHqpNv5Ll5dZSa5LODg2Opmwa6eQ0tV8naGEIvvEwwL8VvT
         G5noZGv15M3qoheV6qmrzDIbEaMkSyCcHpmLxFx6AXIFmmn2xmLl2HxYnXaKiB2gzWxM
         mrZa+vIvwZ2jI/48vjzqdJQYF06PWum83H6CS9Ub/7KlriRCWwDRNCAEA5ZI1WOQIbO2
         /CwibgBC82CojUemyES075Fku1LuPiMayuq3Gkxzuo1OBxYVR6lUCL66BP4rpHJ1Zgj3
         0XdQ==
X-Gm-Message-State: AFqh2kotDc0GLadHdk0/pSz635BGeFnGGaK+zvyRHaTeOhXQNSIH49Ny
        U7tgZUPAFBrubr/qwfpln29HWopQy/9dwgGq1c7uJPQB1gVoY7NloqYEviSCinnyyuPSkG2QG2u
        Nsr6srJ7DxltxfWjtNZ1LsPApJOEos7ZmPfspb0zK
X-Received: by 2002:a37:b843:0:b0:6ff:8aef:d886 with SMTP id i64-20020a37b843000000b006ff8aefd886mr896778qkf.453.1672348554322;
        Thu, 29 Dec 2022 13:15:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv8OGe/F/Uu4oZtGoWYTO/HtUS4b5b2xWQiR0GjbYnWvXuR5xLvbKvMlENNl+GbFlgA7XwHYM6lXA/RFAm87pk=
X-Received: by 2002:a37:b843:0:b0:6ff:8aef:d886 with SMTP id
 i64-20020a37b843000000b006ff8aefd886mr896774qkf.453.1672348554067; Thu, 29
 Dec 2022 13:15:54 -0800 (PST)
MIME-Version: 1.0
References: <20221229203708.13628-1-vdronov@redhat.com> <20221229203708.13628-7-vdronov@redhat.com>
 <Y64AQg+W0SGsYUDY@sol.localdomain>
In-Reply-To: <Y64AQg+W0SGsYUDY@sol.localdomain>
From:   Vladis Dronov <vdronov@redhat.com>
Date:   Thu, 29 Dec 2022 22:15:43 +0100
Message-ID: <CAMusb+RXTtfa5Ez+_vsYuDwyNc_U9pRRAQHcJycoiX1g=c3_GQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] crypto: testmgr - allow ecdsa-nist-p256 and -p384
 in FIPS mode
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>,
        Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 10:02 PM Eric Biggers <ebiggers@kernel.org> wrote:
> ... skip ...
> Please don't add my Reviewed-by to patches I didn't review.  I only gave
> Reviewed-by on "[PATCH 2/6] crypto: xts - drop xts_check_key()".  I didn't look
> at the other patches in the series much, as I'm not very interested in them.
>
> - Eric

My bad. I'm sorry for misunderstanding and this traffic and mess. Let me send v3
with your review tag for the patch 2/6 only.

Best regards,
Vladis

