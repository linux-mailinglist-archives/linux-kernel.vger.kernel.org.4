Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4F5720BA1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjFBWBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjFBWA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:00:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4591A5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 15:00:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9745baf7c13so235420966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685743257; x=1688335257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0c9jC97KGUo6t2xu7Q7CAPz1B3NlMHnmNeStAhPtvo=;
        b=B/FzE16Y/d97COqfsYP4Gf+9f50rhp0JXBeyr0WLMKRrytwyZnttXH1AOPOZH3uNhe
         8PG71Otg1cI6bKjOceT9dQM5NRC2r9khaRdWmPziTLeSWoqTYDowTqXtpD3TJwyVZFy7
         LEhiEIj+Qd2RpmC2SRFaWkKdHNsbyAwr7f6h3qBbyOCg29DLKNdkQIxTegyeU82wKMiz
         hUNzyadcCa7WQD7dmG6YCmCe8KfAXHi4wDp8an5rmyn5u4lMZs7bYSWacTNWKLyUfHpQ
         Uoe96G2Uuc9yFuKMglFAqVEo5+RdKc5409iwq3c+wfwWfLopKKWW1xvwgQfnOe+8IWu5
         HSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685743257; x=1688335257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0c9jC97KGUo6t2xu7Q7CAPz1B3NlMHnmNeStAhPtvo=;
        b=geeBNoD5ztCtvoBUmU9+uLWodcO15NgJh67Vo68LEdENyhfGPdmmK8CSzxQSHlYcAz
         l0PNl5j6B2DaaXdQLJu+bCUEYXZ4WPki461QW3AdmoYezxHrSGiRSrrDjANeaz7QGCIg
         cQbU9n13g5/OwdIkfpNruR/3v/ugbMDCMhf6hSqMm5Nd4rTMxHbN1YEffuuVh47zrJhN
         tsFltXVFPtXhiO3LBXnTlO6MQoC+2B8jwqTPahAUbCCYsWGzGz406yY1DsrvJOSentTk
         RAq2gF9yW4SIZO9E3f75X9kD2Ai51AXNC338HWVBQ2VkPWYAIMVWxMoMz0tlw+frxJd3
         IhWg==
X-Gm-Message-State: AC+VfDzDHfkddvAznH1cEC/iE6vpyL9qmaLfoU4eDEmt3J0PQZpgzQj2
        zXuhisrU50aPQC32wE1F0Z5LNXL0E4XFlTcNQREmcg==
X-Google-Smtp-Source: ACHHUZ6APbng4RrVYWz+iiEOuhUyk2lS54PIgFE/nZYsHYhDmJNdhXg4FMQ9G2qfZy63fZxBgaDi3g+sk16zZtkUKTI=
X-Received: by 2002:a17:907:3e28:b0:96a:3811:f589 with SMTP id
 hp40-20020a1709073e2800b0096a3811f589mr14027824ejc.10.1685743256867; Fri, 02
 Jun 2023 15:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230602151916.GH26944@pendragon.ideasonboard.com>
 <20230602203746.288881-1-arakesh@google.com> <20230602211602.3b7rfa252wliiszp@synopsys.com>
In-Reply-To: <20230602211602.3b7rfa252wliiszp@synopsys.com>
From:   Avichal Rakesh <arakesh@google.com>
Date:   Fri, 2 Jun 2023 15:00:45 -0700
Message-ID: <CAMHf4W+yLY34yc4ZSHamXeghovcnVvQWPDuXk+mF=zx9miQt1A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: uvc: queue empty isoc requests if no
 video buffer is available
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
        "etalvala@google.com" <etalvala@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jchowdhary@google.com" <jchowdhary@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 2:16=E2=80=AFPM Thinh Nguyen <Thinh.Nguyen@synopsys.=
com> wrote:
> > ---
> > Changelog:
> > v2:
> >   - Updated commit message to make it clear that userspace application =
is not
> >     required to match the ISOC rate.
> >   - Styling and comment revision based on review
> >
>
>
> BTW, your previous version is already in Greg's usb-next branch. Any new
> change should be rebased on his usb-next.

Oh shoot! I rebased on Linus' master and assumed the patch hadn't been
merged because I couldn't find it there. Uploading a new patch with
the changes in v2 rebased on greg's usb-next branch. Sorry about that,
and thanks for catching it!

- Avi.
